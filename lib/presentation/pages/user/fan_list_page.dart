import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user/user_avatar.dart';

class FanListPage extends ConsumerStatefulWidget {
  final String uid;

  const FanListPage({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<FanListPage> createState() => _FanListPageState();
}

class _FanListPageState extends ConsumerState<FanListPage> {
  final RefreshController _refreshController = RefreshController();
  final Set<String> _followingSet = {};

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(discourseFollowListProvider(widget.uid, FollowType.followers).notifier).refresh(widget.uid, FollowType.followers);
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    _refreshController.loadComplete();
  }

  Future<void> _toggleFollow(String username) async {
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
      await ref.read(userFollowStatusProvider(username).notifier).toggleFollow(username);
      if (!mounted) return;
      final isFollowing = !_followingSet.contains(username);
      setState(() {
        if (isFollowing) {
          _followingSet.add(username);
        } else {
          _followingSet.remove(username);
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isFollowing ? '已关注 @$username' : '已取消关注 @$username'),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('操作失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isOwnProfile = currentUser?.username == widget.uid;

    final fanListAsync = ref.watch(discourseFollowListProvider(widget.uid, FollowType.followers));

    return Scaffold(
      appBar: AppBar(
        title: Text(isOwnProfile ? '我的粉丝' : '粉丝列表'),
      ),
      body: fanListAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => _StateView(
          icon: Icons.error_outline,
          title: '加载失败',
          message: error.toString(),
          actionLabel: '重试',
          onAction: () => ref.invalidate(discourseFollowListProvider(widget.uid, FollowType.followers)),
        ),
        data: (users) {
          if (users.isEmpty) {
            return _StateView(
              icon: Icons.people_outline,
              title: '暂无粉丝',
              message: '还没有粉丝关注你',
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
              itemBuilder: (context, index) {
                final user = users[index];
                final username = user.username;
                final isFollowing = _followingSet.contains(username);
                final currentUsername = ref.read(currentUserProvider)?.username;
                final isSelf = currentUsername == username;

                return _FanCard(
                  username: username,
                  avatarUrl: user.avatarUrl,
                  bio: user.name ?? '',
                  isFollowing: isFollowing,
                  isSelf: isSelf,
                  onTap: () {
                    context.push(RoutePaths.userProfile.replaceFirst(':uid', username));
                  },
                  onToggleFollow: () => _toggleFollow(username),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _FanCard extends StatelessWidget {
  final String username;
  final String avatarUrl;
  final String bio;
  final bool isFollowing;
  final bool isSelf;
  final VoidCallback onTap;
  final VoidCallback onToggleFollow;

  const _FanCard({
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.isFollowing,
    required this.isSelf,
    required this.onTap,
    required this.onToggleFollow,
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
              if (!isSelf)
                isFollowing
                    ? OutlinedButton(
                        onPressed: onToggleFollow,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: colorScheme.error,
                          side: BorderSide(color: colorScheme.error),
                        ),
                        child: const Text('取消关注'),
                      )
                    : FilledButton(
                        onPressed: onToggleFollow,
                        child: const Text('回关'),
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