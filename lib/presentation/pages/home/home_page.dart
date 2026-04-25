import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../../core/utils/performance_util.dart';
import '../../providers/auth_provider.dart';
import '../../providers/home_provider.dart';
import '../../widgets/common/like_button.dart';
import '../../widgets/feed/featured_comment.dart';
import '../../widgets/feed/quick_comment_bar.dart';
import '../../widgets/comment/quick_comment_sheet.dart';
import '../../widgets/home/pinned_topics_banner.dart';
import '../topics/topics_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController _tabController;

  final List<RefreshController> _refreshControllers = [];
  final List<ScrollController> _scrollControllers = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: homeFeedTabs.length, vsync: this);

    for (int i = 0; i < homeFeedTabs.length; i++) {
      _refreshControllers.add(RefreshController());
      _scrollControllers.add(ScrollController());
    }

    _tabController.addListener(_onTabChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeNotifierProvider.notifier).refreshFeeds();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();

    for (final controller in _refreshControllers) {
      controller.dispose();
    }

    for (final controller in _scrollControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      _optimizeMemory();
      return;
    }

    ref.read(homeNotifierProvider.notifier).switchTab(_tabController.index);
  }

  void _optimizeMemory() {
    final stats = MemoryOptimizer.getCacheStats();
    if (stats.currentSize > stats.maximumSize * 0.8) {
      MemoryOptimizer.clearImageCache();
    }
  }

  Future<void> _onRefresh(int tabIndex) async {
    final notifier = ref.read(homeNotifierProvider.notifier);
    notifier.switchTab(tabIndex);
    await notifier.refreshFeeds();
    _refreshControllers[tabIndex].refreshCompleted();
  }

  Future<void> _onLoading(int tabIndex) async {
    final notifier = ref.read(homeNotifierProvider.notifier);
    notifier.switchTab(tabIndex);
    await notifier.loadMoreFeeds();
    _refreshControllers[tabIndex].loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const _HomeAppBarTitle(),
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    context.push(RoutePaths.notifications);
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: homeFeedTabs
                    .map((type) => Tab(text: homeFeedTabLabels[type] ?? type.name))
                    .toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: List.generate(homeFeedTabs.length, (index) {
            final feedType = homeFeedTabs[index];
            // 话题Tab显示独立的话题页面
            if (feedType == FeedType.topics) {
              return const TopicsPage();
            }
            return _FeedListView(
              key: ValueKey('feed_${homeFeedTabs[index].name}'),
              tabIndex: index,
              onRefresh: () => _onRefresh(index),
              onLoading: () => _onLoading(index),
              refreshController: _refreshControllers[index],
              scrollController: _scrollControllers[index],
              showBanner: index == 0,
            );
          }),
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

class _FeedListView extends ConsumerWidget {
  final int tabIndex;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoading;
  final RefreshController refreshController;
  final ScrollController? scrollController;
  final bool showBanner;

  const _FeedListView({
    super.key,
    required this.tabIndex,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    this.scrollController,
    this.showBanner = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedType = homeFeedTabs[tabIndex];
    final tabState = ref.watch(
      homeNotifierProvider.select(
        (homeState) => homeState.tabStates[feedType] ?? const TabFeedState(),
      ),
    );

    final feedList = tabState.feedList;
    final isLoading = tabState.isRefreshing;
    final hasMore = tabState.hasMore;
    final errorMessage = tabState.errorMessage;

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

    if (isLoading && feedList.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

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
      onLoading: hasMore ? onLoading : null,
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
        itemCount: feedList.length + (showBanner ? 1 : 0),
        cacheExtent: 250,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        addSemanticIndexes: true,
        itemBuilder: (context, index) {
          // 如果是第一个位置且需要显示Banner
          if (showBanner && index == 0) {
            return const PinnedTopicsBanner();
          }

          // 计算实际的feed索引
          final feedIndex = showBanner ? index - 1 : index;
          final feed = feedList[feedIndex];

          return RepaintBoundary(
            child: _FeedCard(
              key: ValueKey('${feedType.name}_${feed.id}'),
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

/// 标签汉化映射表
///
/// 用于将英文标签映射为中文显示
const Map<String, String> _tagLocalizationMap = {
  // SOLO 相关
  'code-with-solo': 'Code-with-SOLO',
  'solo': 'SOLO赛',
  'solo-news': 'SOLO赛事速递',
  'solo-beginner': '新SOLO初体验',

  // 活动相关
  'event': '活动',
  'events': '活动',
  'activity': '活动',
  'contest': '比赛',
  'challenge': '挑战',
  'hello-ai': 'Hello-AI-科技致善',
  'more-coding': 'More-than-Coding',

  // 内容类型
  'announcement': '公告',
  'official': '官方',
  'news': '新闻',
  'update': '更新',
  'release': '发布',

  // 主题分类
  'help': '求助',
  'question': '问题',
  'support': '支持',

  // 建议反馈
  'suggestion': '建议',
  'feedback': '反馈',
  'feature-request': '功能请求',
  'bug': 'Bug',

  // 技巧分享
  'tips': '技巧',
  'tutorial': '教程',
  'guide': '指南',
  'how-to': '教程',
  'best-practice': '最佳实践',

  // 作品展示
  'showcase': '作品',
  'project': '项目',
  'demo': '演示',
  'portfolio': '作品集',

  // 交流讨论
  'discussion': '讨论',
  'general': '综合',
  'chat': '闲聊',
  'intro': '介绍',
  'introduction': '介绍',
  'newbie': '新人必看',

  // 技术相关
  'tech': '技术',
  'code': '代码',
  'development': '开发',
  'ai': 'AI',
  'ml': '机器学习',

  // 其他
  'pinned': '置顶',
  'featured': '精选',
};

class _FeedCard extends ConsumerStatefulWidget {
  final FeedItem feed;
  final VoidCallback onTap;

  const _FeedCard({
    super.key,
    required this.feed,
    required this.onTap,
  });

  @override
  ConsumerState<_FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends ConsumerState<_FeedCard> {
  late int _replyCount;

  @override
  void initState() {
    super.initState();
    _replyCount = widget.feed.replyCount;
  }

  @override
  void didUpdateWidget(_FeedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.feed.replyCount != widget.feed.replyCount) {
      _replyCount = widget.feed.replyCount;
    }
  }

  void _handleCommentSuccess(String content) {
    setState(() {
      _replyCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('评论发送成功')),
    );
  }

  void _openQuickCommentSheet(BuildContext context) {
    QuickCommentSheet.show(
      context: context,
      topicId: widget.feed.topicId,
      onSubmit: (content) => _handleCommentSuccess(content),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUser = ref.watch(currentUserProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildUserInfo(context, colorScheme),
              const SizedBox(height: 10),
              if (widget.feed.title.isNotEmpty)
                Text(
                  widget.feed.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              if (widget.feed.title.isNotEmpty && widget.feed.content.isNotEmpty) const SizedBox(height: 8),
              if (widget.feed.content.isNotEmpty)
                Text(
                  widget.feed.content,
                  style: theme.textTheme.bodyMedium,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              if (widget.feed.images.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildImagePreview(context),
              ],
              if (widget.feed.tags.isNotEmpty || widget.feed.category.isNotEmpty || widget.feed.isPinned) ...[
                const SizedBox(height: 12),
                _buildMetaTags(context),
              ],
              // 精选评论
              if (widget.feed.topComment != null) ...[
                const SizedBox(height: 12),
                FeaturedComment(
                  comment: widget.feed.topComment,
                  onTap: widget.onTap,
                ),
              ],
              const SizedBox(height: 12),
              _buildActions(context, colorScheme, _replyCount),
              // 快速输入栏
              const SizedBox(height: 12),
              QuickCommentBar(
                currentUserAvatar: currentUser?.avatar,
                onTap: () => _openQuickCommentSheet(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, ColorScheme colorScheme) {
    final initial = widget.feed.username.isNotEmpty ? widget.feed.username[0].toUpperCase() : '?';

    return InkWell(
      onTap: () {
        if (widget.feed.username.isNotEmpty) {
          context.push(RoutePaths.userProfile.replaceFirst(':uid', widget.feed.username));
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: colorScheme.primaryContainer,
              backgroundImage: widget.feed.avatarUrl.isNotEmpty ? NetworkImage(widget.feed.avatarUrl) : null,
              onBackgroundImageError: (error, stackTrace) {},
              child: widget.feed.avatarUrl.isEmpty
                  ? Text(
                      initial,
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
                    widget.feed.username,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    _formatTime(widget.feed.createTime),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Image.network(
          widget.feed.images.first,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              alignment: Alignment.center,
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            );
          },
        ),
      ),
    );
  }

  /// 获取标签的汉化显示文本
  ///
  /// [tag] 原始标签文本（英文）
  /// @return 汉化后的标签文本，如果没有映射则返回原值
  String _getLocalizedTag(String tag) {
    final lowerTag = tag.toLowerCase().trim();
    // 移除可能的 # 前缀
    final cleanTag = lowerTag.startsWith('#') ? lowerTag.substring(1) : lowerTag;
    return _tagLocalizationMap[cleanTag] ?? tag;
  }

  /// 处理标签点击
  ///
  /// [context] 上下文
  /// [tag] 标签名称
  void _onTagTap(BuildContext context, String tag) {
    // 将标签转换为 URL 友好的格式（小写，空格转连字符）
    final urlFriendlyTag = tag.toLowerCase().trim().replaceAll(' ', '-');
    // 跳转到标签详情页
    context.push(RoutePaths.tagDetail.replaceFirst(':tag', urlFriendlyTag));
  }

  Widget _buildMetaTags(BuildContext context) {
    final items = <Widget>[];

    // 分类标签（使用汉化映射）
    if (widget.feed.category.isNotEmpty) {
      final localizedCategory = _getLocalizedTag(widget.feed.category);
      items.add(_metaChip(context, '#$localizedCategory', onTap: () {
        // 分类标签点击可以跳转到对应分类
        // 这里可以根据需要实现分类跳转逻辑
      }));
    }

    // 普通标签（使用汉化映射，可点击）
    for (final tag in widget.feed.tags.take(3)) {
      final localizedTag = _getLocalizedTag(tag);
      items.add(_metaChip(context, '#$localizedTag', onTap: () => _onTagTap(context, tag)));
    }

    // 置顶标签（汉化）
    if (widget.feed.isPinned) {
      items.add(_metaChip(context, '置顶'));
    }

    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: items,
    );
  }

  Widget _metaChip(BuildContext context, String label, {VoidCallback? onTap}) {
    final chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: chip,
      );
    }

    return chip;
  }

  Widget _buildActions(BuildContext context, ColorScheme colorScheme, int replyCount) {
    final textStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
          color: colorScheme.onSurfaceVariant,
        );

    return Row(
      children: [
        LikeButton(
          postId: widget.feed.topicId,
          initialLikeCount: widget.feed.likeCount,
          initialIsLiked: widget.feed.isLiked,
          iconSize: 20,
          fontSize: 12,
        ),
        const SizedBox(width: 16),
        Icon(Icons.comment_outlined, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text('$replyCount', style: textStyle),
        const SizedBox(width: 16),
        Icon(Icons.visibility_outlined, size: 20, color: colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text('${widget.feed.viewCount}', style: textStyle),
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

/// 首页顶部AppBar自定义标题
///
/// 包含用户头像、搜索框，类似酷安首页顶部布局
class _HomeAppBarTitle extends ConsumerWidget {
  const _HomeAppBarTitle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authNotifierProvider);
    final currentUser = authState.valueOrNull;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          // 用户头像
          GestureDetector(
            onTap: () {
              if (currentUser != null) {
                context.push('/profile/${currentUser.uid}');
              } else {
                context.push(RoutePaths.login);
              }
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer,
              ),
              child: ClipOval(
                child: currentUser?.avatar != null && currentUser!.avatar!.isNotEmpty
                    ? Image.network(
                        currentUser.avatar!,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 20,
                            color: colorScheme.onPrimaryContainer,
                          );
                        },
                      )
                    : Icon(
                        Icons.person,
                        size: 20,
                        color: colorScheme.onPrimaryContainer,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // 搜索框
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.push(RoutePaths.search);
              },
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '搜索话题、用户...',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
