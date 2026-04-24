import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../data/models/user.dart' as user_model;
import '../../providers/auth_provider.dart';
import '../../providers/home_provider.dart';
import '../../providers/user_provider.dart';

/// 用户资料页
class UserProfilePage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username）
  final String? uid;

  const UserProfilePage({
    super.key,
    this.uid,
  });

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  final ScrollController _scrollController = ScrollController();
  String? _activeUsername;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_activeUsername == null || !_scrollController.hasClients) {
      return;
    }

    final state = ref.read(userSpaceNotifierProvider(_activeUsername!));
    if (state.isLoadingFeeds || !state.hasMoreFeeds) {
      return;
    }

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(userSpaceNotifierProvider(_activeUsername!).notifier).loadMoreUserFeeds();
    }
  }

  String? _resolveUsername(user_model.UserInfo? currentUser) {
    final target = widget.uid;
    if (target != null && target.isNotEmpty && target != 'current_user') {
      return target;
    }

    if (currentUser != null && currentUser.username.isNotEmpty) {
      return currentUser.username;
    }

    return null;
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
              isOwnProfile: isOwnProfile,
              onEditProfile: () {
                context.push(RoutePaths.userEdit);
              },
              onToggleFollow: () async {
                final messenger = ScaffoldMessenger.of(context);
                final success = await notifier.toggleFollow();
                if (!mounted) return;

                final text = success
                    ? (profile.isFollowing ? '已取消关注' : '已关注')
                    : '操作失败';
                messenger.showSnackBar(
                  SnackBar(content: Text(text)),
                );
              },
              onSendMessage: () {
                _showMessageDialog(context, username);
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

    return [
      SliverToBoxAdapter(
        child: _SummarySection(summary: summary),
      ),
    ];
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

  void _showMessageDialog(BuildContext context, String username) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('发私信给 @$username'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: '请输入私信内容...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('私信功能开发中')),
              );
            },
            child: const Text('发送'),
          ),
        ],
      ),
    );
  }
}

class _UserTabs extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const _UserTabs({
    required this.selectedIndex,
    required this.onTabSelected,
  });

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
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
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
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
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
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SummaryStatItem(
                value: summary.topicCount.toString(),
                label: '话题',
              ),
              _SummaryStatItem(
                value: summary.postCount.toString(),
                label: '回复',
              ),
              _SummaryStatItem(
                value: summary.likesReceived.toString(),
                label: '收到赞',
              ),
              _SummaryStatItem(
                value: summary.daysVisited.toString(),
                label: '访问天数',
              ),
            ],
          ),
          if (summary.topics.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              '热门话题',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            ...summary.topics.take(5).map((topic) => _SummaryTopicItem(topic: topic)),
          ],
          if (summary.replies.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              '热门回复',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(height: 12),
            ...summary.replies.take(5).map((reply) => _SummaryReplyItem(reply: reply)),
          ],
        ],
      ),
    );
  }
}

class _SummaryStatItem extends StatelessWidget {
  final String value;
  final String label;

  const _SummaryStatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
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
          context.push(RoutePaths.feedDetail.replaceFirst(':id', topic.id.toString()));
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
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
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
            context.push(RoutePaths.feedDetail.replaceFirst(':id', reply.topicId.toString()));
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (activity.topicId > 0) {
            context.push(RoutePaths.feedDetail.replaceFirst(':id', activity.topicId.toString()));
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
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (activity.createdAt != null)
                          Text(
                            _formatTime(activity.createdAt!),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (activity.cooked != null && activity.cooked!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  _stripHtml(activity.cooked!),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              if (activity.topicSlug != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
            ],
          ),
        ),
      ),
    );
  }

  String _formatAvatarUrl(String template) {
    if (template.startsWith('http')) {
      return template;
    }
    return 'https://forum.trae.cn${template.replaceAll('{size}', '60')}';
  }

  String _formatTime(String isoTime) {
    try {
      final dateTime = DateTime.parse(isoTime);
      final now = DateTime.now();
      final diff = now.difference(dateTime);

      if (diff.inDays > 0) {
        return '$diff.inDays 天前';
      } else if (diff.inHours > 0) {
        return '${diff.inHours} 小时前';
      } else if (diff.inMinutes > 0) {
        return '${diff.inMinutes} 分钟前';
      } else {
        return '刚刚';
      }
    } catch (e) {
      return isoTime;
    }
  }

  String _stripHtml(String htmlString) {
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&amp;', '&')
        .trim();
  }
}

class _ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final bool isOwnProfile;
  final VoidCallback onEditProfile;
  final VoidCallback onToggleFollow;
  final VoidCallback onSendMessage;

  const _ProfileHeader({
    required this.profile,
    required this.isOwnProfile,
    required this.onEditProfile,
    required this.onToggleFollow,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatItem(
                      count: profile.feedCount.toString(),
                      label: '动态',
                    ),
                    _StatItem(
                      count: profile.followCount.toString(),
                      label: '关注',
                    ),
                    _StatItem(
                      count: profile.fansCount.toString(),
                      label: '粉丝',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            profile.username,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
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
          ]
          else
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
                  label: const Text('私信'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({
    required this.count,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          Text(
            count,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  final FeedItem feed;

  const _FeedCard({required this.feed});

  @override
  Widget build(BuildContext context) {
    final content = feed.content.isNotEmpty ? feed.content : '话题 #${feed.id}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: feed.id.isEmpty
            ? null
            : () {
                context.push(RoutePaths.feedDetail.replaceFirst(':id', feed.id));
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
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
                      color: Theme.of(context).colorScheme.surfaceContainerHighest,
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    feed.createTime.isNotEmpty ? feed.createTime : '未知时间',
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
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
