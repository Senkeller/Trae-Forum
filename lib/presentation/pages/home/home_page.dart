import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../core/utils/performance_util.dart';
import '../../providers/auth_provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../widgets/common/like_button.dart';
import '../../widgets/common/main_top_app_bar_title.dart';
import '../../widgets/feed/featured_comment.dart';
import '../../widgets/feed/quick_comment_bar.dart';
import '../../widgets/comment/quick_comment_sheet.dart';
import '../../widgets/home/pinned_topics_banner.dart';

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
    await HapticFeedbackUtil.trigger(ref, HapticScene.refresh);
    final notifier = ref.read(homeNotifierProvider.notifier);
    notifier.switchTab(tabIndex);
    await notifier.refreshFeeds();
    _refreshControllers[tabIndex].refreshCompleted();
    await HapticFeedbackUtil.trigger(ref, HapticScene.refreshDone);
  }

  Future<void> _onLoading(int tabIndex) async {
    final notifier = ref.read(homeNotifierProvider.notifier);
    notifier.switchTab(tabIndex);
    await notifier.loadMoreFeeds();
    _refreshControllers[tabIndex].loadComplete();
  }

  int? _resolveBannerCategoryId(FeedType feedType) {
    switch (feedType) {
      case FeedType.official:
        return AppConstants.forumCategoryIds['official'];
      case FeedType.help:
        return AppConstants.forumCategoryIds['help'];
      case FeedType.suggestions:
        return AppConstants.forumCategoryIds['suggestions'];
      case FeedType.tips:
        return AppConstants.forumCategoryIds['tips'];
      case FeedType.showcase:
        return AppConstants.forumCategoryIds['showcase'];
      case FeedType.discussion:
        return AppConstants.forumCategoryIds['discussion'];
      case FeedType.events:
        return AppConstants.forumCategoryIds['events'];
      case FeedType.recommended:
      case FeedType.latest:
      case FeedType.hot:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const MainTopAppBarTitle(),
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    HapticFeedbackUtil.trigger(ref, HapticScene.message);
                    context.push(RoutePaths.notifications);
                  },
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                tabs: homeFeedTabs
                    .map(
                      (type) => Tab(text: homeFeedTabLabels[type] ?? type.name),
                    )
                    .toList(),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: List.generate(homeFeedTabs.length, (index) {
            final feedType = homeFeedTabs[index];
            final bannerCategoryId = _resolveBannerCategoryId(feedType);

            return _FeedListView(
              key: ValueKey('feed_${feedType.name}'),
              tabIndex: index,
              onRefresh: () => _onRefresh(index),
              onLoading: () => _onLoading(index),
              refreshController: _refreshControllers[index],
              scrollController: _scrollControllers[index],
              showBanner: true,
              bannerCategoryId: bannerCategoryId,
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final created = await context.push<bool>(RoutePaths.feedCreate);
          if (created == true && mounted) {
            await ref.read(homeNotifierProvider.notifier).refreshFeeds();
          }
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
  final int? bannerCategoryId;

  const _FeedListView({
    super.key,
    required this.tabIndex,
    required this.onRefresh,
    required this.onLoading,
    required this.refreshController,
    this.scrollController,
    this.showBanner = false,
    this.bannerCategoryId,
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
            ElevatedButton(onPressed: onRefresh, child: const Text('重试')),
          ],
        ),
      );
    }

    if (isLoading && feedList.isEmpty) {
      return _buildSkeletonList();
    }

    if (feedList.isEmpty) {
      final isOfficialTab = feedType == FeedType.official;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isOfficialTab ? Icons.campaign_outlined : Icons.inbox_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isOfficialTab ? '暂无官方公告' : '暂无内容',
              style: TextStyle(color: Colors.grey[600]),
            ),
            if (isOfficialTab) ...[
              const SizedBox(height: 8),
              Text(
                '官方公告将在这里发布',
                style: TextStyle(color: Colors.grey[500], fontSize: 12),
              ),
            ],
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
            return PinnedTopicsBanner(categoryId: bannerCategoryId);
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

  /// 构建骨架屏列表
  Widget _buildSkeletonList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 5,
      itemBuilder: (context, index) => const _FeedSkeletonCard(),
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

/// Feed 骨架屏卡片
///
/// 用于加载时显示的占位卡片
class _FeedSkeletonCard extends StatelessWidget {
  const _FeedSkeletonCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final skeletonColor = colorScheme.surfaceContainerHighest;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户头像和名称行
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 14,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 60,
                    height: 10,
                    decoration: BoxDecoration(
                      color: skeletonColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 标题
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          // 内容
          Container(
            width: double.infinity,
            height: 12,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 12,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          // 图片占位
          Container(
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),
          // 操作栏
          Row(
            children: [
              Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FeedCard extends ConsumerStatefulWidget {
  final FeedItem feed;
  final VoidCallback onTap;

  const _FeedCard({super.key, required this.feed, required this.onTap});

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
    HapticFeedbackUtil.trigger(ref, HapticScene.commentSuccess);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('评论发送成功')));
  }

  void _openQuickCommentSheet(BuildContext context) {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);
    QuickCommentSheet.show(
      context: context,
      topicId: widget.feed.topicId,
      onSubmit: (content) => _handleCommentSuccess(content),
    );
  }

  Future<void> _toggleBookmarkFromFeed() async {
    final topicId = widget.feed.topicId;
    if (topicId <= 0) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('无效的话题ID，无法操作书签')));
      return;
    }

    final hasSession = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!hasSession) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先登录后再使用书签'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () => context.push(RoutePaths.login),
          ),
        ),
      );
      return;
    }

    final notifier = ref.read(bookmarkProvider.notifier);
    final beforeState = ref.read(postBookmarkStateProvider(topicId));
    if (beforeState == null) {
      notifier.initializePost(topicId, isBookmarked: false);
    }

    await notifier.toggleBookmark(topicId, bookmarkId: beforeState?.bookmarkId);

    if (!mounted) return;

    final currentState = ref.read(postBookmarkStateProvider(topicId));
    final message = currentState?.errorMessage;
    if (message != null && message.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      notifier.clearError(topicId);
      return;
    }

    final tips = (currentState?.isBookmarked ?? false) ? '已添加论坛书签' : '已取消论坛书签';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tips)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final currentUser = ref.watch(currentUserProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildUserInfo(context, colorScheme),
                const SizedBox(height: 12),
                if (widget.feed.title.isNotEmpty)
                  Text(
                    widget.feed.title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (widget.feed.title.isNotEmpty &&
                    widget.feed.content.isNotEmpty)
                  const SizedBox(height: 8),
                if (widget.feed.content.isNotEmpty)
                  Text(
                    widget.feed.content,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      height: 1.5,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                if (widget.feed.images.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildImagePreview(context),
                ],
                if (widget.feed.tags.isNotEmpty ||
                    widget.feed.category.isNotEmpty ||
                    widget.feed.isPinned) ...[
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
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, ColorScheme colorScheme) {
    final initial = widget.feed.username.isNotEmpty
        ? widget.feed.username[0].toUpperCase()
        : '?';

    return InkWell(
      onTap: () {
        if (widget.feed.username.isNotEmpty) {
          context.push(
            RoutePaths.userProfile.replaceFirst(':uid', widget.feed.username),
          );
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
              backgroundImage: widget.feed.avatarUrl.isNotEmpty
                  ? NetworkImage(widget.feed.avatarUrl)
                  : null,
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
        child: InkWell(
          onTap: () => _openImagePreview(context),
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
      ),
    );
  }

  /// 打开图片预览
  void _openImagePreview(BuildContext context) {
    context.push(RoutePaths.imagePreview, extra: widget.feed.images);
  }

  /// 获取标签的汉化显示文本
  ///
  /// [tag] 原始标签文本（英文）
  /// @return 汉化后的标签文本，如果没有映射则返回原值
  String _getLocalizedTag(String tag) {
    final lowerTag = tag.toLowerCase().trim();
    // 移除可能的 # 前缀
    final cleanTag = lowerTag.startsWith('#')
        ? lowerTag.substring(1)
        : lowerTag;
    return _tagLocalizationMap[cleanTag] ?? tag;
  }

  /// 处理标签点击
  ///
  /// [context] 上下文
  /// [tag] 标签名称
  void _onTagTap(BuildContext context, String tag) {
    final rawTag = tag.trim().replaceFirst(RegExp(r'^#+\s*'), '');
    if (rawTag.isEmpty) return;
    final encodedTag = Uri.encodeComponent(rawTag);
    context.push(RoutePaths.tagDetail.replaceFirst(':tag', encodedTag));
  }

  /// 处理分类（话题）点击
  void _onCategoryTap(BuildContext context) {
    if (widget.feed.categoryId <= 0) return;
    final categoryUrl = '${AppConstants.forumUrl}/c/${widget.feed.categoryId}';
    final encodedUrl = Uri.encodeComponent(categoryUrl);
    final encodedTitle = Uri.encodeComponent(widget.feed.category);
    context.push('${RoutePaths.webview}?url=$encodedUrl&title=$encodedTitle');
  }

  Widget _buildMetaTags(BuildContext context) {
    final items = <Widget>[];

    // 分类标签（使用汉化映射）
    if (widget.feed.category.isNotEmpty) {
      final localizedCategory = _getLocalizedTag(widget.feed.category);
      items.add(
        _metaChip(
          context,
          '#$localizedCategory',
          onTap: () => _onCategoryTap(context),
        ),
      );
    }

    // 普通标签（使用汉化映射，可点击）
    for (final tag in widget.feed.tags.take(3)) {
      final localizedTag = _getLocalizedTag(tag);
      items.add(
        _metaChip(
          context,
          '#$localizedTag',
          onTap: () => _onTagTap(context, tag),
        ),
      );
    }

    // 置顶标签（汉化）
    if (widget.feed.isPinned) {
      items.add(_metaChip(context, '置顶'));
    }

    return Wrap(spacing: 8, runSpacing: 6, children: items);
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

  Widget _buildActions(
    BuildContext context,
    ColorScheme colorScheme,
    int replyCount,
  ) {
    final textStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant);
    final bookmarkState = ref.watch(
      postBookmarkStateProvider(widget.feed.topicId),
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
        Icon(
          Icons.comment_outlined,
          size: 20,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text('$replyCount', style: textStyle),
        const SizedBox(width: 16),
        Icon(
          Icons.visibility_outlined,
          size: 20,
          color: colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text('${widget.feed.viewCount}', style: textStyle),
        const Spacer(),
        // 收藏按钮
        _buildBookmarkButton(colorScheme, bookmarkState),
        const SizedBox(width: 8),
        // 分享按钮
        _buildShareButton(colorScheme),
      ],
    );
  }

  /// 构建收藏按钮
  Widget _buildBookmarkButton(
    ColorScheme colorScheme,
    PostBookmarkState? bookmarkState,
  ) {
    final isBookmarked = bookmarkState?.isBookmarked ?? false;
    final isLoading = bookmarkState?.isLoading ?? false;

    return InkWell(
      onTap: isLoading
          ? null
          : () async {
              HapticFeedbackUtil.trigger(ref, HapticScene.tap);
              await _toggleBookmarkFromFeed();
            },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              )
            : Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                size: 20,
                color: isBookmarked
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
      ),
    );
  }

  /// 构建分享按钮
  Widget _buildShareButton(ColorScheme colorScheme) {
    return InkWell(
      onTap: () {
        HapticFeedbackUtil.trigger(ref, HapticScene.tap);
        _showShareOptions(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.share_outlined,
          size: 20,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// 显示分享选项
  void _showShareOptions(BuildContext context) {
    final feedUrl = 'https://forum.trae.cn/t/${widget.feed.topicId}';

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('复制链接'),
              onTap: () {
                Navigator.of(context).pop();
                _copyToClipboard(context, feedUrl);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('分享到...'),
              onTap: () {
                Navigator.of(context).pop();
                Share.share(
                  '${widget.feed.title}\n$feedUrl',
                  subject: widget.feed.title,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 复制到剪贴板
  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    HapticFeedbackUtil.trigger(ref, HapticScene.copySuccess);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('链接已复制到剪贴板'),
        duration: Duration(seconds: 2),
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
