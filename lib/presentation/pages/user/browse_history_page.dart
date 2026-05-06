import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../../data/models/user_activity.dart';
import '../../providers/user_activity_provider.dart';
import '../../widgets/home/pinned_topics_banner.dart';
import '../../widgets/user/user_avatar.dart';

/// 浏览历史页面
class BrowseHistoryPage extends ConsumerStatefulWidget {
  const BrowseHistoryPage({super.key});

  @override
  ConsumerState<BrowseHistoryPage> createState() => _BrowseHistoryPageState();
}

class _BrowseHistoryPageState extends ConsumerState<BrowseHistoryPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(browseHistoriesProvider.notifier).refresh();
    _refreshController.refreshCompleted();
  }

  Future<void> _showClearConfirm() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空历史'),
        content: const Text('确定要清空所有浏览历史吗？此操作不可恢复。'),
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
      await ref.read(browseHistoriesProvider.notifier).clearAll();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('浏览历史已清空')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(browseHistoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('浏览历史'),
        actions: [
          historyAsync.when(
            data: (list) => list.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: _showClearConfirm,
                    tooltip: '清空历史',
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: historyAsync.when(
        data: (list) => _buildList(list),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('加载失败: $err')),
      ),
    );
  }

  Widget _buildList(List<BrowseHistory> list) {
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
          return _HistoryCard(
            item: item,
            onTap: () => _navigateToDetail(item.feedId),
            onDelete: () => _removeHistory(item.feedId),
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
            Icons.history,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text('暂无浏览历史', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            '浏览帖子时会自动记录',
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

  Future<void> _removeHistory(String feedId) async {
    await ref.read(browseHistoriesProvider.notifier).removeHistory(feedId);
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已从历史中移除')));
    }
  }
}

class _HistoryCard extends StatelessWidget {
  final BrowseHistory item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _HistoryCard({
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final daysSince = DateTime.now().difference(item.viewedAt).inDays;
    final timeText = daysSince == 0
        ? '今天'
        : daysSince == 1
        ? '昨天'
        : '$daysSince天前';

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
                avatarUrl: item.avatarUrl.isNotEmpty ? item.avatarUrl : null,
                size: 44,
                memCacheWidth: 100,
                memCacheHeight: 100,
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
                        const Spacer(),
                        Text(
                          timeText,
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
