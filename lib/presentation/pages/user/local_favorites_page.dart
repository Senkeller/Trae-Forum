import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../../data/models/user_activity.dart';
import '../../providers/user_activity_provider.dart';
import '../../widgets/home/pinned_topics_banner.dart';

/// 本地收藏页面
class LocalFavoritesPage extends ConsumerStatefulWidget {
  const LocalFavoritesPage({super.key});

  @override
  ConsumerState<LocalFavoritesPage> createState() => _LocalFavoritesPageState();
}

class _LocalFavoritesPageState extends ConsumerState<LocalFavoritesPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(localFavoritesProvider.notifier).refresh();
    _refreshController.refreshCompleted();
  }

  Future<void> _showClearConfirm() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空收藏'),
        content: const Text('确定要清空所有本地收藏吗？此操作不可恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('清空'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(localFavoritesProvider.notifier).clearAll();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('收藏已清空')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesAsync = ref.watch(localFavoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('本地收藏'),
        actions: [
          favoritesAsync.when(
            data: (list) => list.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: _showClearConfirm,
                    tooltip: '清空收藏',
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: favoritesAsync.when(
        data: (list) => _buildList(list),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('加载失败: $err')),
      ),
    );
  }

  Widget _buildList(List<LocalFavorite> list) {
    if (list.isEmpty) {
      return _buildEmptyState();
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: list.length + 1,
        cacheExtent: 200,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const PinnedTopicsBanner();
          }

          final item = list[index - 1];
          return _FavoriteCard(
            item: item,
            onTap: () => _navigateToDetail(item.feedId),
            onDelete: () => _removeFavorite(item.feedId),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text('暂无本地收藏', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            '浏览帖子时点击收藏按钮即可添加',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(String feedId) {
    context.push(RoutePaths.feedDetail.replaceFirst(':id', feedId));
  }

  Future<void> _removeFavorite(String feedId) async {
    await ref.read(localFavoritesProvider.notifier).removeFavorite(feedId);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已从收藏中移除')));
    }
  }
}

class _FavoriteCard extends StatelessWidget {
  final LocalFavorite item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _FavoriteCard({
    required this.item,
    required this.onTap,
    required this.onDelete,
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
                radius: 22,
                backgroundImage: item.avatarUrl.isNotEmpty
                    ? NetworkImage(item.avatarUrl)
                    : null,
                child: item.avatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 22)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.message,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          '@${item.username}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colorScheme.primary),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.deviceTitle,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error),
                onPressed: onDelete,
                tooltip: '删除',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
