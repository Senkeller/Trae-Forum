import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
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
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required UserSpaceState userState,
    required UserSpaceNotifier notifier,
    required bool isOwnProfile,
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
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Text(
                '最近话题',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          ..._buildFeedSlivers(context, userState, notifier),
        ],
      ),
    );
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
}

class _ProfileHeader extends StatelessWidget {
  final UserProfile profile;
  final bool isOwnProfile;
  final VoidCallback onEditProfile;
  final VoidCallback onToggleFollow;

  const _ProfileHeader({
    required this.profile,
    required this.isOwnProfile,
    required this.onEditProfile,
    required this.onToggleFollow,
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
          if (isOwnProfile)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onEditProfile,
                icon: const Icon(Icons.edit, size: 18),
                label: const Text('编辑资料'),
              ),
            )
          else
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onToggleFollow,
                child: Text(profile.isFollowing ? '取消关注' : '关注'),
              ),
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
    final content = feed.content.isNotEmpty ? feed.content : 'Topic #${feed.id}';

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
