import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';

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

  List<Map<String, String>> _fanList = [];
  Set<String> _followingSet = {};
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFanList();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _loadFanList() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isLoading = false;
        _fanList = [];
        _hasMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '加载失败: $e';
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadFanList();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    if (_isLoadingMore || !_hasMore) {
      _refreshController.loadComplete();
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoadingMore = false;
      _hasMore = false;
    });

    _refreshController.loadComplete();
  }

  Future<void> _toggleFollow(String username) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.uid.isEmpty) {
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
      final isFollowing = _followingSet.contains(username);

      setState(() {
        if (isFollowing) {
          _followingSet.remove(username);
        } else {
          _followingSet.add(username);
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isFollowing ? '已取消关注 @$username' : '已关注 @$username'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('操作失败: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isOwnProfile = currentUser?.username == widget.uid ||
        currentUser?.uid == widget.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(isOwnProfile ? '我的粉丝' : '粉丝列表'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _fanList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && _fanList.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadFanList,
      );
    }

    if (_fanList.isEmpty) {
      return _StateView(
        icon: Icons.people_outline,
        title: '暂无粉丝',
        message: '还没有粉丝关注你',
      );
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: _hasMore,
      onRefresh: _onRefresh,
      onLoading: _hasMore ? _onLoading : null,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _fanList.length,
        itemBuilder: (context, index) {
          final user = _fanList[index];
          final username = user['username'] ?? '';
          final isFollowing = _followingSet.contains(username);
          final currentUsername = ref.read(currentUserProvider)?.username;
          final isSelf = currentUsername == username;

          return _FanCard(
            username: username,
            avatarUrl: user['avatarUrl'] ?? '',
            bio: user['bio'] ?? '',
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
              CircleAvatar(
                radius: 28,
                backgroundImage: avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 28)
                    : null,
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
