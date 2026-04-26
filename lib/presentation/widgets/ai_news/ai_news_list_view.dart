import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/ai_news_provider.dart';
import 'ai_news_card.dart';

/// AI快讯列表视图组件
///
/// 用于展示AI快讯列表，支持下拉刷新和上拉加载更多
class AINewsListView extends ConsumerStatefulWidget {
  const AINewsListView({super.key});

  @override
  ConsumerState<AINewsListView> createState() => _AINewsListViewState();
}

class _AINewsListViewState extends ConsumerState<AINewsListView>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // 延迟加载数据，确保页面已经构建完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  /// 加载初始数据
  Future<void> _loadInitialData() async {
    final notifier = ref.read(aINewsNotifierProvider.notifier);
    await notifier.refreshNews();
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    await HapticFeedbackUtil.trigger(ref, HapticScene.refresh);
    final notifier = ref.read(aINewsNotifierProvider.notifier);
    await notifier.refreshNews();
    _refreshController.refreshCompleted();
    await HapticFeedbackUtil.trigger(ref, HapticScene.refreshDone);
  }

  /// 上拉加载更多
  Future<void> _onLoading() async {
    final notifier = ref.read(aINewsNotifierProvider.notifier);
    await notifier.loadMoreNews();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final newsList = ref.watch(aiNewsListProvider);
    final isRefreshing = ref.watch(isAINewsRefreshingProvider);
    final hasMore = ref.watch(hasMoreAINewsProvider);
    final errorMessage = ref.watch(aiNewsErrorMessageProvider);

    // 显示错误状态
    if (errorMessage != null && newsList.isEmpty) {
      return _buildErrorView(errorMessage);
    }

    // 显示加载状态
    if (isRefreshing && newsList.isEmpty) {
      return _buildSkeletonList();
    }

    // 显示空状态
    if (newsList.isEmpty) {
      return _buildEmptyView();
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: hasMore,
      onRefresh: _onRefresh,
      onLoading: hasMore ? _onLoading : null,
      header: const WaterDropMaterialHeader(
        backgroundColor: Colors.white,
        color: Colors.black87,
      ),
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        loadingText: '加载中...',
        noDataText: '没有更多了',
        idleText: '上拉加载更多',
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: newsList.length,
        cacheExtent: 250,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return RepaintBoundary(
            child: AINewsCard(
              key: ValueKey('ai_news_${news.id}'),
              news: news,
              onTap: () => _onNewsTap(news),
            ),
          );
        },
      ),
    );
  }

  /// 构建错误视图
  Widget _buildErrorView(String errorMessage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(errorMessage, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _onRefresh,
            child: const Text('重试'),
          ),
        ],
      ),
    );
  }

  /// 构建空视图
  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.newspaper_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            '暂无AI快讯',
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            '最新AI资讯将在这里展示',
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// 构建骨架屏列表
  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 5,
      itemBuilder: (context, index) => const AINewsSkeletonCard(),
    );
  }

  /// 处理新闻点击
  void _onNewsTap(dynamic news) {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);
    // 打开新闻详情页面或外部链接
    // context.push('/ai-news/${news.id}', extra: news);
    // 或者使用WebView打开原文链接
    final encodedUrl = Uri.encodeComponent(news.sourceUrl);
    final encodedTitle = Uri.encodeComponent(news.title);
    context.push('/webview?url=$encodedUrl&title=$encodedTitle');
  }
}
