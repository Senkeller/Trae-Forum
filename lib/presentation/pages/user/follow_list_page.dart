import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user/user_avatar.dart';

class FollowListPage extends ConsumerStatefulWidget {
  final String uid;

  const FollowListPage({super.key, required this.uid});

  @override
  ConsumerState<FollowListPage> createState() => _FollowListPageState();
}

class _FollowListPageState extends ConsumerState<FollowListPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref
        .read(
          discourseFollowListProvider(
            widget.uid,
            FollowType.following,
          ).notifier,
        )
        .refresh(widget.uid, FollowType.following);
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    _refreshController.loadComplete();
  }

  Future<void> _unfollow(String username) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先登录'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () => context.push(RoutePaths.login),
          ),
        ),
      );
      return;
    }

    try {
      await ref
          .read(userFollowStatusProvider(username).notifier)
          .toggleFollow(username);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('已取消关注 @$username')));
      ref.invalidate(
        discourseFollowListProvider(widget.uid, FollowType.following),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('操作失败: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isOwnProfile = currentUser?.username == widget.uid;

    final followListAsync = ref.watch(
      discourseFollowListProvider(widget.uid, FollowType.following),
    );

    return Scaffold(
      appBar: AppBar(title: Text(isOwnProfile ? '我的关注' : '关注列表')),
      body: followListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _StateView(
          icon: Icons.error_outline,
          title: '加载失败',
          message: error.toString(),
          actionLabel: '重试',
          onAction: () => ref.invalidate(
            discourseFollowListProvider(widget.uid, FollowType.following),
          ),
        ),
        data: (users) {
          if (users.isEmpty) {
            return _StateView(
              icon: Icons.people_outline,
              title: '暂无关注',
              message: '还没有关注任何人',
            );
          }

          return SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: users.length,
              cacheExtent: 200,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: true,
              itemBuilder: (context, index) {
                final user = users[index];
                return _UserCard(
                  username: user.username,
                  avatarUrl: user.avatarUrl,
                  bio: user.name ?? '',
                  onTap: () {
                    context.push(
                      RoutePaths.userProfile.replaceFirst(
                        ':username',
                        user.username,
                      ),
                    );
                  },
                  onUnfollow: () => _unfollow(user.username),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final String bio;
  final VoidCallback onTap;
  final VoidCallback onUnfollow;

  const _UserCard({
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.onTap,
    required this.onUnfollow,
  });

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
          child: Row(
            children: [
              UserAvatar(
                avatarUrl: avatarUrl.isNotEmpty ? avatarUrl : null,
                size: 56,
                memCacheWidth: 120,
                memCacheHeight: 120,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (bio.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        bio,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              OutlinedButton(
                onPressed: onUnfollow,
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.error,
                  side: BorderSide(color: colorScheme.error),
                ),
                child: const Text('取消关注'),
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
