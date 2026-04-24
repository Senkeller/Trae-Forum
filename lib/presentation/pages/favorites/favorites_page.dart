import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  final RefreshController _refreshController = RefreshController();

  List<Map<String, dynamic>> _favoritesList = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.uid.isEmpty) {
      setState(() {
        _errorMessage = '请先登录';
      });
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isLoading = false;
        _favoritesList = [];
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
    await _loadFavorites();
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

  Future<void> _removeFavorite(String topicId) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('已取消收藏')),
    );

    setState(() {
      _favoritesList.removeWhere((item) => item['topicId'] == topicId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('我的收藏'),
        ),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可查看收藏',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _favoritesList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && _favoritesList.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadFavorites,
      );
    }

    if (_favoritesList.isEmpty) {
      return _StateView(
        icon: Icons.bookmark_outline,
        title: '暂无收藏',
        message: '你还没有收藏任何话题',
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
        itemCount: _favoritesList.length,
        itemBuilder: (context, index) {
          final item = _favoritesList[index];
          return _FavoriteCard(
            item: item,
            onTap: () {
              final topicId = item['topicId']?.toString();
              if (topicId != null && topicId.isNotEmpty) {
                context.push(RoutePaths.feedDetail.replaceFirst(':id', topicId));
              }
            },
            onRemove: () => _removeFavorite(item['topicId']?.toString() ?? ''),
          );
        },
      ),
    );
  }
}

class _FavoriteCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteCard({
    required this.item,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = item['title']?.toString() ?? '';
    final username = item['username']?.toString() ?? '';
    final time = item['time']?.toString() ?? '';
    final avatarUrl = item['avatarUrl']?.toString() ?? '';
    final excerpt = item['excerpt']?.toString() ?? '';

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
                    backgroundImage: avatarUrl.isNotEmpty
                        ? NetworkImage(avatarUrl)
                        : null,
                    child: avatarUrl.isEmpty
                        ? const Icon(Icons.person, size: 18)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: colorScheme.primary,
                    ),
                    onPressed: onRemove,
                    tooltip: '取消收藏',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (excerpt.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  excerpt,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${item['likeCount'] ?? 0}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.comment_outlined,
                    size: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${item['replyCount'] ?? 0}',
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
