import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/ai_news_provider.dart';
import 'ai_news_feed_card.dart';

/// AI快讯列表视图组件 V2
///
/// 优化后的列表视图，支持分类筛选、搜索等功能
class AINewsListViewV2 extends ConsumerStatefulWidget {
  const AINewsListViewV2({super.key});

  @override
  ConsumerState<AINewsListViewV2> createState() => _AINewsListViewV2State();
}

class _AINewsListViewV2State extends ConsumerState<AINewsListViewV2>
    with AutomaticKeepAliveClientMixin {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
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

  /// 处理新闻点击
  void _onNewsTap(dynamic news) {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);
    final encodedUrl = Uri.encodeComponent(news.sourceUrl);
    final encodedTitle = Uri.encodeComponent(news.title);
    context.push('/webview?url=$encodedUrl&title=$encodedTitle');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final newsList = ref.watch(aiNewsListProvider);
    final isRefreshing = ref.watch(isAINewsRefreshingProvider);
    final hasMore = ref.watch(hasMoreAINewsProvider);
    final errorMessage = ref.watch(aiNewsErrorMessageProvider);

    return Column(
      children: [
        // 分类筛选栏
        _buildCategoryFilter(),

        // 新闻列表
        Expanded(
          child: _buildContent(
            newsList: newsList,
            isRefreshing: isRefreshing,
            hasMore: hasMore,
            errorMessage: errorMessage,
          ),
        ),
      ],
    );
  }

  /// 构建分类筛选栏
  Widget _buildCategoryFilter() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip('全部', isSelected: true),
          _buildFilterChip('大模型'),
          _buildFilterChip('图像生成'),
          _buildFilterChip('视频生成'),
          _buildFilterChip('AI硬件'),
          _buildFilterChip('AI应用'),
        ],
      ),
    );
  }

  /// 构建筛选Chip
  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        onSelected: (selected) {
          // TODO: 实现筛选功能
        },
        selectedColor: Theme.of(context).colorScheme.primaryContainer,
        checkmarkColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  /// 构建内容区域
  Widget _buildContent({
    required List<dynamic> newsList,
    required bool isRefreshing,
    required bool hasMore,
    String? errorMessage,
  }) {
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
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: newsList.length,
        cacheExtent: 250,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return AINewsFeedCard(
            key: ValueKey('ai_news_${news.id}'),
            news: news,
            onTap: () => _onNewsTap(news),
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
          Text(
            errorMessage,
            style: TextStyle(color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('重试'),
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
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('刷新'),
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
      itemBuilder: (context, index) => const AINewsFeedSkeleton(),
    );
  }
}
