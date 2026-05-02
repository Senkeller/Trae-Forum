import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/html_text_util.dart';
import '../../../core/utils/relative_time_util.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../../data/models/user.dart' as user_model;
import '../../providers/auth_provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/private_message_provider.dart';
import '../../providers/user_badges_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/home/pinned_topics_banner.dart';
import '../../widgets/user/online_status_indicator.dart';

/// 用户资料页
class UserProfilePage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username）
  final String? username;
  final String? initialTab;
  final String? initialActivityCategory;

  const UserProfilePage({
    super.key,
    this.username,
    this.initialTab,
    this.initialActivityCategory,
  });

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理用户动态列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  String? _activeUsername;
  int _selectedTabIndex = 0;
  bool _initialCategoryApplied = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _selectedTabIndex = _resolveInitialTabIndex(widget.initialTab);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多用户动态。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _onScroll() {
    if (_activeUsername == null) return;

    final state = ref.read(userSpaceNotifierProvider(_activeUsername!));
    if (state.isLoadingFeeds || !state.hasMoreFeeds) return;

    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        ref
            .read(userSpaceNotifierProvider(_activeUsername!).notifier)
            .loadMoreUserFeeds();
      },
    );
  }

  String? _resolveUsername(user_model.UserInfo? currentUser) {
    final target = widget.username?.trim();
    if (target != null && target.isNotEmpty) {
      return target;
    }

    if (currentUser != null && currentUser.username.isNotEmpty) {
      return currentUser.username;
    }

    return null;
  }

  int _resolveInitialTabIndex(String? tab) {
    switch (tab?.trim().toLowerCase()) {
      case 'activity':
      case 'activities':
      case '1':
        return 1;
      case 'feeds':
      case 'feed':
      case '2':
        return 2;
      default:
        return 0;
    }
  }

  UserActivityCategory? _resolveInitialCategory(String? category) {
    switch (category?.trim().toLowerCase()) {
      case 'all':
        return UserActivityCategory.all;
      case 'topics':
      case 'topic':
        return UserActivityCategory.topics;
      case 'replies':
      case 'reply':
        return UserActivityCategory.replies;
      case 'likes':
      case 'like':
        return UserActivityCategory.likes;
      case 'solved':
        return UserActivityCategory.solved;
      case 'votes':
      case 'vote':
        return UserActivityCategory.votes;
      default:
        return null;
    }
  }

  void _ensureLoaded(String username) {
    if (_activeUsername == username) return;
    _activeUsername = username;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(userSpaceNotifierProvider(username).notifier);
      notifier.loadUserProfile();
      notifier.loadUserFeeds();
      notifier.loadUserSummary();
      notifier.loadUserActivities();
    });
  }

  void _applyInitialCategoryIfNeeded(String username) {
    if (_initialCategoryApplied || _selectedTabIndex != 1) {
      return;
    }
    final category = _resolveInitialCategory(widget.initialActivityCategory);
    if (category == null || category == UserActivityCategory.all) {
      _initialCategoryApplied = true;
      return;
    }
    _initialCategoryApplied = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(userSpaceNotifierProvider(username).notifier)
          .switchActivityCategory(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final username = _resolveUsername(currentUser);

    if (username == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('个人主页')),
        body: const _StateView(
          icon: Icons.person_search,
          title: '无法确定用户',
          message: '请先登录，或通过 /user/{username} 打开用户主页。',
        ),
      );
    }

    _ensureLoaded(username);
    _applyInitialCategoryIfNeeded(username);

    final userState = ref.watch(userSpaceNotifierProvider(username));
    final notifier = ref.read(userSpaceNotifierProvider(username).notifier);
    final isOwnProfile = currentUser?.username == username;

    return Scaffold(
      appBar: AppBar(
        title: Text('@$username'),
        actions: [
          if (isOwnProfile)
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                context.push(RoutePaths.settings);
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                _showMoreOptions(context);
              },
            ),
        ],
      ),
      body: _buildBody(
        context: context,
        userState: userState,
        notifier: notifier,
        isOwnProfile: isOwnProfile,
        username: username,
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required UserSpaceState userState,
    required UserSpaceNotifier notifier,
    required bool isOwnProfile,
    required String username,
  }) {
    if (userState.isLoadingProfile && userState.profile == null) {
      return const _StateView(
        icon: Icons.person,
        title: '正在加载资料',
        message: '正在从 forum.trae.cn 拉取用户数据…',
        loading: true,
      );
    }

    if (userState.errorMessage != null && userState.profile == null) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: userState.errorMessage!,
        actionLabel: '重试',
        onAction: () {
          notifier.loadUserProfile();
          notifier.loadUserFeeds();
        },
      );
    }

    if (userState.profile == null) {
      return const _StateView(
        icon: Icons.person_off,
        title: '未获取到用户资料',
        message: '该用户可能不存在，或接口返回了空数据。',
      );
    }

    final profile = userState.profile!;

    return RefreshIndicator(
      onRefresh: () async {
        await notifier.loadUserProfile();
        await notifier.refreshUserFeeds();
        await notifier.loadUserSummary();
        await notifier.loadUserActivities();
      },
      child: CustomScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _ProfileHeader(
              profile: profile,
              summary: userState.summary,
              isOwnProfile: isOwnProfile,
              onEditProfile: () {
                _openForumProfilePreferences(context);
              },
              onToggleFollow: () async {
                final messenger = ScaffoldMessenger.of(context);
                final success = await notifier.toggleFollow();
                if (!mounted) return;

                final text = success
                    ? (profile.isFollowing ? '已取消关注' : '已关注')
                    : '操作失败';
                messenger.showSnackBar(SnackBar(content: Text(text)));
              },
              onSendMessage: () {
                // 跳转到私信页面，创建新私信
                _showSendMessageDialog(context, username);
              },
              onFollowersTap: () {
                context.push(
                  RoutePaths.fanList.replaceFirst(':username', username),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: _UserTabs(
              selectedIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
          ),
          ..._buildTabContent(context, userState, notifier),
        ],
      ),
    );
  }

  List<Widget> _buildTabContent(
    BuildContext context,
    UserSpaceState userState,
    UserSpaceNotifier notifier,
  ) {
    switch (_selectedTabIndex) {
      case 0:
        return _buildSummaryContent(context, userState);
      case 1:
        return _buildActivityContent(context, userState, notifier);
      case 2:
        return _buildFeedSlivers(context, userState, notifier);
      default:
        return [];
    }
  }

  List<Widget> _buildSummaryContent(
    BuildContext context,
    UserSpaceState userState,
  ) {
    if (userState.isLoadingSummary) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _StateView(
            icon: Icons.summarize,
            title: '正在加载总结',
            message: '正在从 forum.trae.cn 拉取用户总结…',
            loading: true,
          ),
        ),
      ];
    }

    final summary = userState.summary;
    if (summary == null) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _StateView(
            icon: Icons.summarize,
            title: '暂无总结',
            message: '该用户暂时没有总结数据。',
          ),
        ),
      ];
    }

    return [SliverToBoxAdapter(child: _SummarySection(summary: summary))];
  }

  List<Widget> _buildActivityContent(
    BuildContext context,
    UserSpaceState userState,
    UserSpaceNotifier notifier,
  ) {
    return [
      SliverToBoxAdapter(
        child: _ActivityCategoryTabs(
          selectedCategory: userState.activityCategory,
          onCategorySelected: (category) {
            notifier.switchActivityCategory(category);
          },
        ),
      ),
      if (userState.isLoadingActivities && userState.activities.isEmpty)
        const SliverFillRemaining(
          hasScrollBody: false,
          child: _StateView(
            icon: Icons.timeline,
            title: '正在加载活动',
            message: '正在从 forum.trae.cn 拉取用户活动…',
            loading: true,
          ),
        )
      else if (userState.activities.isEmpty)
        const SliverFillRemaining(
          hasScrollBody: false,
          child: _StateView(
            icon: Icons.timeline,
            title: '暂无活动',
            message: '该用户近期没有活动记录。',
          ),
        )
      else
        SliverList.builder(
          itemCount: userState.activities.length,
          itemBuilder: (context, index) {
            final activity = userState.activities[index];
            return _ActivityCard(activity: activity);
          },
        ),
    ];
  }

  List<Widget> _buildFeedSlivers(
    BuildContext context,
    UserSpaceState userState,
    UserSpaceNotifier notifier,
  ) {
    if (userState.isLoadingFeeds && userState.feeds.isEmpty) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _StateView(
            icon: Icons.forum,
            title: '正在加载话题',
            message: '请稍候…',
            loading: true,
          ),
        ),
      ];
    }

    if (userState.errorMessage != null && userState.feeds.isEmpty) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _StateView(
            icon: Icons.error_outline,
            title: '加载话题失败',
            message: userState.errorMessage!,
            actionLabel: '重试',
            onAction: notifier.loadUserFeeds,
          ),
        ),
      ];
    }

    if (userState.feeds.isEmpty) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: _StateView(
            icon: Icons.inbox,
            title: '暂无话题',
            message: '该用户近期还没有可展示的话题。',
          ),
        ),
      ];
    }

    return [
      const SliverToBoxAdapter(child: PinnedTopicsBanner()),
      SliverList.builder(
        itemCount: userState.feeds.length,
        itemBuilder: (context, index) {
          final feed = userState.feeds[index];
          return _FeedCard(feed: feed);
        },
      ),
      if (userState.isLoadingFeeds)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: CircularProgressIndicator()),
          ),
        )
      else if (!userState.hasMoreFeeds)
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(child: Text('没有更多内容了')),
          ),
        ),
    ];
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('举报用户'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('加入黑名单'),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  /// 打开论坛个人资料设置页面（/my/preferences/profile）
  void _openForumProfilePreferences(BuildContext context) {
    final baseUri = Uri.parse(AppConstants.forumUrl);
    final profileUri = baseUri.replace(
      pathSegments: ['my', 'preferences', 'profile'],
    );

    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(profileUri.toString())}&title=${Uri.encodeComponent('编辑资料')}',
    );
  }

  /// 显示发送私信对话框
  void _showSendMessageDialog(BuildContext context, String username) {
    showDialog(
      context: context,
      builder: (context) => _SendMessageDialog(targetUsername: username),
    );
  }
}

class _UserTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const _UserTabs({required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          _TabItem(
            label: '总结',
            isSelected: selectedIndex == 0,
            onTap: () => onTabSelected(0),
          ),
          _TabItem(
            label: '活动',
            isSelected: selectedIndex == 1,
            onTap: () => onTabSelected(1),
          ),
          _TabItem(
            label: '话题',
            isSelected: selectedIndex == 2,
            onTap: () => onTabSelected(2),
          ),
        ],
      ),
    );
  }
}

class _ActivityCategoryTabs extends StatelessWidget {
  final UserActivityCategory selectedCategory;
  final ValueChanged<UserActivityCategory> onCategorySelected;

  const _ActivityCategoryTabs({
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: UserActivityCategory.values.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = UserActivityCategory.values[index];
          final isSelected = category == selectedCategory;

          return FilterChip(
            label: Text(category.label),
            selected: isSelected,
            onSelected: (_) => onCategorySelected(category),
            backgroundColor: colorScheme.surfaceContainerHighest,
            selectedColor: colorScheme.primaryContainer,
            checkmarkColor: colorScheme.primary,
            labelStyle: TextStyle(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          );
        },
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isSelected ? colorScheme.primary : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _SummarySection extends StatelessWidget {
  final UserSummary summary;

  const _SummarySection({required this.summary});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '统计信息',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          // 第一行统计：访问天数、阅读时间、最近阅读时间、浏览话题
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _SummaryStatItem(
                value: summary.daysVisited.toString(),
                label: '访问天数',
              ),
              _SummaryStatItem(
                value: _formatDuration(summary.timeRead),
                label: '阅读时间',
              ),
              _SummaryStatItem(
                value: _formatDuration(summary.recentTimeRead),
                label: '最近阅读时间',
              ),
              _SummaryStatItem(
                value: _formatCount(summary.topicsEntered),
                label: '浏览的话题',
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 第二行统计：已读帖子、已送出赞、已收到赞
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _SummaryStatItem(
                value: _formatCount(summary.postsReadCount),
                label: '已读帖子',
              ),
              _SummaryStatItem(
                value: summary.likesGiven.toString(),
                label: '已送出',
                icon: Icons.favorite,
                iconColor: Colors.pink,
              ),
              _SummaryStatItem(
                value: summary.likesReceived.toString(),
                label: '已收到',
                icon: Icons.favorite,
                iconColor: Colors.pink,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 第三行统计：创建的话题、创建的帖子、解决方案
          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              _SummaryStatItem(
                value: summary.topicCount.toString(),
                label: '创建的话题',
              ),
              _SummaryStatItem(
                value: summary.postCount.toString(),
                label: '创建的帖子',
              ),
              if (summary.solvedCount > 0)
                _SummaryStatItem(
                  value: summary.solvedCount.toString(),
                  label: '解决方案',
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                ),
            ],
          ),
          if (summary.topics.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              '热门话题',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...summary.topics
                .take(5)
                .map((topic) => _SummaryTopicItem(topic: topic)),
          ],
          if (summary.replies.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              '热门回复',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            ...summary.replies
                .take(5)
                .map((reply) => _SummaryReplyItem(reply: reply)),
          ],
        ],
      ),
    );
  }

  /// 格式化数字（超过1000显示为k）
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  /// 格式化时长（秒转换为天/小时/分钟）
  String _formatDuration(int seconds) {
    if (seconds <= 0) return '0';

    final days = seconds ~/ 86400;
    if (days > 0) {
      return '${days}天';
    }

    final hours = seconds ~/ 3600;
    if (hours > 0) {
      return '${hours}小时';
    }

    final minutes = seconds ~/ 60;
    if (minutes > 0) {
      return '${minutes}分钟';
    }

    return '${seconds}秒';
  }
}

class _SummaryStatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;

  const _SummaryStatItem({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 12,
                color:
                    iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
            ],
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}

class _SummaryTopicItem extends StatelessWidget {
  final UserSummaryTopic topic;

  const _SummaryTopicItem({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          context.push(
            RoutePaths.feedDetail.replaceFirst(':id', topic.id.toString()),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                topic.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              if (topic.excerpt != null &&
                  topic.excerpt!.trim().isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  topic.excerpt!.trim(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${topic.likeCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.comment_outlined,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${topic.replyCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.visibility_outlined,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${topic.views}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  if (topic.createdAt != null &&
                      topic.createdAt!.trim().isNotEmpty) ...[
                    const Spacer(),
                    Text(
                      RelativeTimeUtil.fromIso(topic.createdAt!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SummaryReplyItem extends StatelessWidget {
  final UserSummaryReply reply;

  const _SummaryReplyItem({required this.reply});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () {
          if (reply.topicId > 0) {
            context.push(
              RoutePaths.feedDetail.replaceFirst(
                ':id',
                reply.topicId.toString(),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '回复了: ${reply.topicTitle}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              if (reply.excerpt != null) ...[
                const SizedBox(height: 4),
                Text(
                  reply.excerpt!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: 4),
              Row(
                children: [
                  if (reply.likeCount != null) ...[
                    Icon(
                      Icons.thumb_up_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${reply.likeCount}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  if (reply.postNumber != null) ...[
                    const SizedBox(width: 12),
                    Text(
                      '#${reply.postNumber}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final UserActivity activity;

  const _ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    final primaryText = _resolvePrimaryText();
    final cookedText = HtmlTextUtil.stripHtml(activity.cooked ?? '');
    final bodyText = cookedText.isNotEmpty && cookedText != primaryText
        ? cookedText
        : '';
    final showStats =
        (activity.replyCount ?? 0) > 0 ||
        (activity.reads ?? 0) > 0 ||
        (activity.likeCount ?? 0) > 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (activity.topicId > 0) {
            context.push(
              RoutePaths.feedDetail.replaceFirst(
                ':id',
                activity.topicId.toString(),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (activity.avatarTemplate != null)
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        _formatAvatarUrl(activity.avatarTemplate!),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.username,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (activity.createdAt != null)
                          Text(
                            RelativeTimeUtil.fromIso(activity.createdAt!),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (primaryText.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  primaryText,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
              if (bodyText.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  bodyText,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (activity.topicSlug != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '话题 #${activity.topicSlug}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
              if (showStats) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    if ((activity.replyCount ?? 0) > 0) ...[
                      Icon(
                        Icons.comment_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${activity.replyCount}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 12),
                    ],
                    if ((activity.reads ?? 0) > 0) ...[
                      Icon(
                        Icons.visibility_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${activity.reads}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 12),
                    ],
                    if ((activity.likeCount ?? 0) > 0) ...[
                      Icon(
                        Icons.thumb_up_outlined,
                        size: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${activity.likeCount}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _resolvePrimaryText() {
    final excerpt = activity.excerpt?.trim() ?? '';
    if (excerpt.isNotEmpty) return excerpt;

    final cooked = HtmlTextUtil.stripHtml(activity.cooked ?? '');
    if (cooked.isNotEmpty) return cooked;

    if (activity.topicId > 0) {
      return '话题 #${activity.topicId}';
    }
    return '';
  }

  String _formatAvatarUrl(String template) {
    if (template.startsWith('http')) {
      return template;
    }
    return 'https://forum.trae.cn${template.replaceAll('{size}', '60')}';
  }
}

class _ProfileHeader extends ConsumerWidget {
  final UserProfile profile;
  final UserSummary? summary;
  final bool isOwnProfile;
  final VoidCallback onEditProfile;
  final VoidCallback onToggleFollow;
  final VoidCallback onSendMessage;
  final VoidCallback? onFollowersTap;

  const _ProfileHeader({
    required this.profile,
    this.summary,
    required this.isOwnProfile,
    required this.onEditProfile,
    required this.onToggleFollow,
    required this.onSendMessage,
    this.onFollowersTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: profile.avatarUrl.isNotEmpty
                        ? NetworkImage(profile.avatarUrl)
                        : null,
                    child: profile.avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 36)
                        : null,
                  ),
                  const SizedBox(height: 8),
                  // 在线状态指示器
                  _buildOnlineStatus(context, ref),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: summary != null
                    ? _buildStatsSection(context, summary!)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            profile.username,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '@${profile.username}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            profile.bio.isNotEmpty ? profile.bio : '这个用户还没有填写简介。',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          // 徽章展示区域
          const SizedBox(height: 12),
          _buildUserBadgesSection(context, ref, profile.username),
          const SizedBox(height: 16),
          if (isOwnProfile) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onEditProfile,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('编辑资料'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  context.push(RoutePaths.traeDashboard);
                },
                icon: const Icon(Icons.dashboard_outlined, size: 18),
                label: const Text('TRAE 仪表盘'),
              ),
            ),
          ] else
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: onToggleFollow,
                    child: Text(profile.isFollowing ? '取消关注' : '关注'),
                  ),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: onSendMessage,
                  icon: const Icon(Icons.message_outlined, size: 18),
                  label: const Text('发私信'),
                ),
              ],
            ),
        ],
      ),
    );
  }

  /// 构建在线状态指示器
  Widget _buildOnlineStatus(BuildContext context, WidgetRef ref) {
    return OnlineStatusIndicator(
      username: profile.username,
      style: OnlineStatusStyle.detailed,
    );
  }

  /// 构建统计信息区域（显示在头像右侧）
  Widget _buildStatsSection(BuildContext context, UserSummary summary) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 第一行：访问天数、阅读时间
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _HeaderStatItem(
              value: summary.daysVisited.toString(),
              label: '访问天数',
            ),
            _HeaderStatItem(
              value: _formatDuration(summary.timeRead),
              label: '阅读时间',
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 第二行：浏览话题、已读帖子
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _HeaderStatItem(
              value: _formatCount(summary.topicsEntered),
              label: '浏览话题',
            ),
            _HeaderStatItem(
              value: _formatCount(summary.postsReadCount),
              label: '已读帖子',
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 第三行：已送出赞、已收到赞
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            _HeaderStatItem(
              value: summary.likesGiven.toString(),
              label: '已送出',
              icon: Icons.favorite,
              iconColor: Colors.pink,
            ),
            _HeaderStatItem(
              value: summary.likesReceived.toString(),
              label: '已收到',
              icon: Icons.favorite,
              iconColor: Colors.pink,
            ),
          ],
        ),
      ],
    );
  }

  /// 格式化数字（超过1000显示为k）
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  /// 格式化时长（秒转换为天/小时/分钟）
  String _formatDuration(int seconds) {
    if (seconds <= 0) return '0';

    final days = seconds ~/ 86400;
    if (days > 0) {
      return '${days}天';
    }

    final hours = seconds ~/ 3600;
    if (hours > 0) {
      return '${hours}小时';
    }

    final minutes = seconds ~/ 60;
    if (minutes > 0) {
      return '${minutes}分钟';
    }

    return '${seconds}秒';
  }

  /// 构建用户徽章展示区域
  Widget _buildUserBadgesSection(
    BuildContext context,
    WidgetRef ref,
    String username,
  ) {
    final badgesAsync = ref.watch(userBadgesProvider(username));

    return badgesAsync.when(
      data: (badges) {
        if (badges.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 徽章标题和数量
            Row(
              children: [
                Icon(
                  Icons.workspace_premium_outlined,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 6),
                Text(
                  '徽章',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${badges.length}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // 徽章列表
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: badges
                  .take(6)
                  .map((badge) => _buildBadgeItem(context, badge))
                  .toList(),
            ),
            // 查看更多按钮（如果徽章数量超过6个）
            if (badges.length > 6) ...[
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _navigateToUserBadges(context, username),
                child: Text(
                  '查看全部 ${badges.length} 个徽章 →',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ],
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  /// 构建单个徽章项
  Widget _buildBadgeItem(BuildContext context, UserBadgeInfo badge) {
    return Tooltip(
      message: badge.description ?? badge.name,
      child: GestureDetector(
        onTap: () => _navigateToBadgeDetail(context, badge),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(
                context,
              ).colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 徽章图标
              if (badge.imageUrl != null && badge.imageUrl!.isNotEmpty)
                Image.network(
                  badge.imageUrl!,
                  width: 16,
                  height: 16,
                  errorBuilder: (_, _, _) => _buildDefaultBadgeIcon(),
                )
              else
                _buildDefaultBadgeIcon(),
              const SizedBox(width: 6),
              // 徽章名称
              Flexible(
                child: Text(
                  badge.name,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建默认徽章图标
  Widget _buildDefaultBadgeIcon() {
    return const Icon(
      Icons.emoji_events_outlined,
      size: 16,
      color: Color(0xFFFFB800),
    );
  }

  /// 导航到徽章详情页
  void _navigateToBadgeDetail(BuildContext context, UserBadgeInfo badge) {
    final baseUri = Uri.parse(AppConstants.forumUrl);
    final badgeUri = baseUri.replace(
      pathSegments: ['badges', badge.id.toString(), badge.slug],
    );

    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(badgeUri.toString())}&title=${Uri.encodeComponent(badge.name)}',
    );
  }

  /// 导航到用户徽章列表页
  void _navigateToUserBadges(BuildContext context, String username) {
    final baseUri = Uri.parse(AppConstants.forumUrl);
    final badgesUri = baseUri.replace(pathSegments: ['u', username, 'badges']);

    context.push(
      '${RoutePaths.webview}?url=${Uri.encodeComponent(badgesUri.toString())}&title=${Uri.encodeComponent('徽章')}',
    );
  }
}

/// 头部统计项组件（用于头像右侧的紧凑显示）
class _HeaderStatItem extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;
  final Color? iconColor;

  const _HeaderStatItem({
    required this.value,
    required this.label,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 4),
        if (icon != null) ...[
          Icon(
            icon,
            size: 12,
            color: iconColor ?? Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 2),
        ],
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;
  final VoidCallback? onTap;

  const _StatItem({required this.count, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Column(
          children: [
            Text(
              count,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(label, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  final FeedItem feed;

  const _FeedCard({required this.feed});

  @override
  Widget build(BuildContext context) {
    final title = feed.title.trim().isNotEmpty
        ? feed.title.trim()
        : (feed.content.trim().isNotEmpty
              ? feed.content.trim()
              : '话题 #${feed.id}');
    final excerpt = HtmlTextUtil.stripHtml(feed.content).trim();
    final showExcerpt = excerpt.isNotEmpty && excerpt != title;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: feed.id.isEmpty
            ? null
            : () {
                context.push(
                  RoutePaths.feedDetail.replaceFirst(':id', feed.id),
                );
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
              ),
              if (showExcerpt) ...[
                const SizedBox(height: 8),
                Text(
                  excerpt,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              if (feed.images.isNotEmpty) ...[
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    feed.images.first,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 160,
                      alignment: Alignment.center,
                      color: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    _formatTimeValue(feed.createTime),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Spacer(),
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${feed.likeCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.comment_outlined,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${feed.replyCount}',
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

  String _formatTimeValue(String value) {
    if (value.trim().isEmpty) return '未知时间';

    final parsedInt = int.tryParse(value.trim());
    if (parsedInt != null) {
      final milliseconds = parsedInt > 1000000000000
          ? parsedInt
          : parsedInt * 1000;
      final dt = DateTime.fromMillisecondsSinceEpoch(milliseconds).toLocal();
      return RelativeTimeUtil.fromIso(dt.toIso8601String());
    }

    try {
      final dt = DateTime.parse(value).toLocal();
      return RelativeTimeUtil.fromIso(dt.toIso8601String());
    } catch (_) {
      return value;
    }
  }
}

class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final bool loading;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
    this.loading = false,
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
            if (loading)
              const CircularProgressIndicator()
            else
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

/// 发送私信对话框
class _SendMessageDialog extends ConsumerStatefulWidget {
  final String targetUsername;

  const _SendMessageDialog({required this.targetUsername});

  @override
  ConsumerState<_SendMessageDialog> createState() => _SendMessageDialogState();
}

class _SendMessageDialogState extends ConsumerState<_SendMessageDialog> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Text('发私信给 @${widget.targetUsername}'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: '标题',
                hintText: '输入私信标题',
                prefixIcon: Icon(Icons.title),
              ),
              enabled: !_isSending,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: '内容',
                hintText: '输入私信内容',
                prefixIcon: Icon(Icons.message_outlined),
                alignLabelWithHint: true,
              ),
              enabled: !_isSending,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSending ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _isSending ? null : _sendMessage,
          child: _isSending
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('发送'),
        ),
      ],
    );
  }

  Future<void> _sendMessage() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      _showError('请输入标题');
      return;
    }
    if (content.isEmpty) {
      _showError('请输入内容');
      return;
    }

    setState(() => _isSending = true);

    // 导入私信 provider
    final notifier = ref.read(privateMessageChatNotifierProvider.notifier);
    final topicId = await notifier.createConversation(
      title: title,
      content: content,
      targetUsernames: [widget.targetUsername],
    );

    if (mounted) {
      if (topicId != null) {
        Navigator.of(context).pop();
        // 跳转到新创建的会话
        context.push('/chat/$topicId');
      } else {
        setState(() => _isSending = false);
        final error = ref.read(privateMessageChatNotifierProvider).errorMessage;
        _showError(error ?? '发送失败');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
