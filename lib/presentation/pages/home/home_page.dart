import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../../core/utils/performance_util.dart';
import '../../providers/home_provider.dart';
import '../../providers/feed_provider.dart';

/// 首页
///
/// 应用的首页，展示 Feed 流列表
/// 支持下拉刷新和上拉加载更多
/// 使用性能优化策略：ListView.builder、const 构造函数、RepaintBoundary
class HomePage extends ConsumerStatefulWidget {
  /// 构造函数
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

/// 首页状态
class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// Tab 控制器
  late TabController _tabController;

  /// 刷新控制器
  final RefreshController _refreshController = RefreshController();

  /// 滚动控制器列表
  final List<ScrollController> _scrollControllers = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // 为每个 Tab 创建滚动控制器
    for (int i = 0; i < 3; i++) {
      _scrollControllers.add(ScrollController());
    }

    // 监听 Tab 切换，优化内存
    _tabController.addListener(_onTabChanged);
    
    // 初始加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeNotifierProvider.notifier).refreshFeeds();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _refreshController.dispose();

    // 释放滚动控制器
    for (final controller in _scrollControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  /// Tab 切换回调
  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      // Tab 切换时可以执行内存清理
      _optimizeMemory();
    }
  }

  /// 优化内存
  void _optimizeMemory() {
    // 清理图片缓存（保留最近使用的）
    final stats = MemoryOptimizer.getCacheStats();
    if (stats.currentSize > stats.maximumSize * 0.8) {
      // 当缓存使用超过 80% 时清理
      MemoryOptimizer.clearImageCache();
    }
  }

  /// 处理下拉刷新
  ///
  /// 刷新当前 Tab 的数据
  Future<void> _onRefresh() async {
    await ref.read(homeNotifierProvider.notifier).refreshFeeds();
    _refreshController.refreshCompleted();
  }

  /// 处理上拉加载更多
  ///
  /// 加载更多数据
  Future<void> _onLoading() async {
    await ref.read(homeNotifierProvider.notifier).loadMoreFeeds();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('TRAE Forum'),
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                IconButton(
                  icon: const Icon(Icons.language),
                  tooltip: '访问论坛网页',
                  onPressed: () {
                    context.push(
                      '${RoutePaths.webview}?url=${Uri.encodeComponent(AppConstants.forumUrl)}&title=TRAE 论坛',
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.push(RoutePaths.search);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    context.push(RoutePaths.notifications);
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: '推荐'),
                  Tab(text: '关注'),
                  Tab(text: '热门'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _FeedListView(
              key: const ValueKey('feed_recommend'),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              refreshController: _refreshController,
              scrollController: _scrollControllers[0],
            ),
            _FeedListView(
              key: const ValueKey('feed_following'),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              refreshController: RefreshController(),
              scrollController: _scrollControllers[1],
            ),
            _FeedListView(
              key: const ValueKey('feed_hot'),
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              refreshController: RefreshController(),
              scrollController: _scrollControllers[2],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RoutePaths.feedCreate);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// Feed 列表视图
///
/// 展示 Feed 流列表，支持下拉刷新和上拉加载
/// 使用性能优化策略：
/// - ListView.builder 替代 ListView
/// - addAutomaticKeepAlives: false 减少内存占用
/// - addRepaintBoundaries: true 隔离重绘
/// - const 构造函数减少重建
class _FeedListView extends ConsumerWidget {
  /// 刷新回调
  final Future<void> Function() onRefresh;

  /// 加载更多回调
  final Future<void> Function() onLoading;

  /// 刷新控制器
  final RefreshController refreshController;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 构造函数
  const _FeedListView({
    super.key,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedList = ref.watch(feedListProvider);
    final isLoading = ref.watch(isFeedRefreshingProvider);
    final hasMore = ref.watch(hasMoreFeedsProvider);
    final errorMessage = ref.watch(homeErrorMessageProvider);

    // 显示错误信息
    if (errorMessage != null && feedList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(errorMessage, style: TextStyle(color: Colors.grey[600])),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRefresh,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    // 显示加载中
    if (isLoading && feedList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // 显示空状态
    if (feedList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('暂无内容', style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      );
    }

    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: hasMore,
      onRefresh: onRefresh,
      onLoadMore: hasMore ? onLoading : null,
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
        controller: scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: feedList.length,
        cacheExtent: 250,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        addSemanticIndexes: false,
        itemBuilder: (context, index) {
          final feed = feedList[index];

          return RepaintBoundary(
            child: _FeedCard(
              key: ValueKey(feed.id),
              feed: feed,
              onTap: () {
                context.push('/feed/${feed.id}');
              },
            ),
          );
        },
      ),
    );
  }
}

/// Feed 卡片
///
/// 单个 Feed 项的展示卡片
/// 使用 const 构造函数优化性能
class _FeedCard extends StatelessWidget {
  /// 数据
  final FeedItem feed;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _FeedCard({
    super.key,
    required this.feed,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 用户信息行
              _buildUserInfo(context, colorScheme),
              const SizedBox(height: 12),
              // 内容
              Text(
                feed.content,
                style: theme.textTheme.bodyMedium,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
              if (feed.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildTags(context),
              ],
              const SizedBox(height: 12),
              // 操作栏
              _buildActions(context, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: colorScheme.primaryContainer,
          backgroundImage: NetworkImage(feed.avatarUrl),
          onBackgroundImageError: (_, __) {},
          child: feed.avatarUrl.isEmpty
              ? Text(
                  feed.username.isNotEmpty ? feed.username[0].toUpperCase() : '?',
                  style: TextStyle(color: colorScheme.onPrimaryContainer),
                )
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                feed.username,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                _formatTime(feed.createTime),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTags(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: feed.tags.take(3).map((tag) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            tag,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActions(BuildContext context, ColorScheme colorScheme) {
    return Row(
      children: [
        Icon(Icons.thumb_up_outlined, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          '${feed.likeCount}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.comment_outlined, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          '${feed.replyCount}',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(width: 16),
        Icon(Icons.visibility_outlined, size: 20, color: colorScheme.onSurfaceVariant),
      ],
    );
  }

  String _formatTime(String timestamp) {
    if (timestamp.isEmpty) return '';
    
    try {
      final intTs = int.tryParse(timestamp);
      if (intTs == null) return timestamp;
      
      final dateTime = DateTime.fromMillisecondsSinceEpoch(intTs * 1000);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return '刚刚';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes}分钟前';
      } else if (difference.inDays < 1) {
        return '${difference.inHours}小时前';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}天前';
      } else {
        return '${dateTime.month}/${dateTime.day}';
      }
    } catch (e) {
      return timestamp;
    }
  }
}
