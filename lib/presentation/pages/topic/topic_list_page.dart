import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../config/routes.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../providers/home_provider.dart';
import '../../widgets/home/pinned_topics_banner.dart';

class TopicListPage extends ConsumerStatefulWidget {
  const TopicListPage({super.key});

  @override
  ConsumerState<TopicListPage> createState() => _TopicListPageState();
}

class _TopicListPageState extends ConsumerState<TopicListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理话题列表的触底加载逻辑
  /// 阈值设置为 500 像素，提前预加载更多话题，提供更流畅的滚动体验
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard(
    threshold: 500,
    minIntervalMs: 300,
  );

  final List<String> _tabs = ['latest', 'top', 'hot', 'votes'];
  final List<String> _tabLabels = ['最新', '精华', '热门', '投票'];

  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_handleScroll);

    // 初始化加载数据
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialData();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    if (_currentTabIndex != _tabController.index) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      _loadInitialData();
    }
  }

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  void _handleScroll() {
    final homeState = ref.read(homeNotifierProvider);
    final feedType = _getFeedTypeByTabIndex(_currentTabIndex);
    final tabState = homeState.tabStates[feedType];

    if (tabState == null || !tabState.hasMore || tabState.isLoadingMore) {
      return;
    }

    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: _loadMoreTopics,
    );
  }

  /// 根据 Tab 索引获取 FeedType
  FeedType _getFeedTypeByTabIndex(int index) {
    switch (_tabs[index]) {
      case 'latest':
        return FeedType.latest;
      case 'top':
        return FeedType.hot;
      case 'hot':
        return FeedType.hot;
      case 'votes':
        return FeedType.recommended;
      default:
        return FeedType.latest;
    }
  }

  /// 加载初始数据
  void _loadInitialData() {
    final feedType = _getFeedTypeByTabIndex(_currentTabIndex);
    ref.read(homeNotifierProvider.notifier).switchTab(
          _feedTypeToTabIndex(feedType),
        );
  }

  /// 将 FeedType 转换为 Tab 索引
  int _feedTypeToTabIndex(FeedType feedType) {
    switch (feedType) {
      case FeedType.latest:
        return 0;
      case FeedType.hot:
        return _currentTabIndex == 1 ? 1 : 2;
      case FeedType.recommended:
        return 3;
      default:
        return 0;
    }
  }

  /// 加载更多话题
  Future<void> _loadMoreTopics() async {
    await ref.read(homeNotifierProvider.notifier).loadMoreFeeds();
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    await ref.read(homeNotifierProvider.notifier).refreshCurrentTab();
  }

  @override
  Widget build(BuildContext context) {
    final homeState = ref.watch(homeNotifierProvider);
    final feedType = _getFeedTypeByTabIndex(_currentTabIndex);
    final tabState = homeState.tabStates[feedType];

    final topics = tabState?.feedList ?? [];
    final isLoading = tabState?.isRefreshing ?? false;
    final isLoadingMore = tabState?.isLoadingMore ?? false;
    final hasMore = tabState?.hasMore ?? false;
    final errorMessage = tabState?.errorMessage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('综合话题流'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabLabels.map((label) => Tab(text: label)).toList(),
        ),
      ),
      body: _buildBody(
        topics: topics,
        isLoading: isLoading,
        isLoadingMore: isLoadingMore,
        hasMore: hasMore,
        errorMessage: errorMessage,
      ),
    );
  }

  Widget _buildBody({
    required List<FeedItem> topics,
    required bool isLoading,
    required bool isLoadingMore,
    required bool hasMore,
    String? errorMessage,
  }) {
    if (isLoading && topics.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null && topics.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: errorMessage,
        actionLabel: '重试',
        onAction: _loadInitialData,
      );
    }

    if (topics.isEmpty) {
      return _StateView(
        icon: Icons.inbox_outlined,
        title: '暂无话题',
        message: '当前分类下没有话题',
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: topics.length + 1 + (hasMore ? 1 : 0),
        cacheExtent: MediaQuery.of(context).size.height * 0.5,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          // 第一个位置显示置顶横幅
          if (index == 0) {
            return const PinnedTopicsBanner();
          }

          // 话题列表
          if (index <= topics.length) {
            final topic = topics[index - 1];
            return _TopicCard(
              topic: topic,
              onTap: () {
                context.push(
                  RoutePaths.feedDetail.replaceFirst(':id', topic.id),
                );
              },
            );
          }

          // 底部加载指示器
          return _buildBottomLoader(isLoadingMore);
        },
      ),
    );
  }

  /// 构建底部加载指示器
  Widget _buildBottomLoader(bool isLoadingMore) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (isLoadingMore) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '加载更多话题...',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

class _TopicCard extends StatelessWidget {
  final FeedItem topic;
  final VoidCallback onTap;

  const _TopicCard({required this.topic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: topic.avatarUrl.isNotEmpty
                        ? NetworkImage(topic.avatarUrl)
                        : null,
                    child: topic.avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 18)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          topic.username,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          _formatTime(topic.createTime),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  if (topic.isPinned)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '置顶',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.onPrimaryContainer,
                            ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                topic.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (topic.content.isNotEmpty && topic.content != topic.title) ...[
                const SizedBox(height: 8),
                Text(
                  topic.content,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (topic.tags.isNotEmpty) ...[
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: topic.tags.take(3).map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '#$tag',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: colorScheme.primary,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${topic.likeCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.comment_outlined,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${topic.replyCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.visibility_outlined,
                    size: 16,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${topic.viewCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
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
      }
      if (difference.inHours < 1) {
        return '${difference.inMinutes}分钟前';
      }
      if (difference.inDays < 1) {
        return '${difference.inHours}小时前';
      }
      if (difference.inDays < 7) {
        return '${difference.inDays}天前';
      }
      return '${dateTime.month}/${dateTime.day}';
    } catch (_) {
      return timestamp;
    }
  }
}

class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
