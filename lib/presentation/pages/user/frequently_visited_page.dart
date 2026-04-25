import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../../data/models/user_activity.dart';
import '../../providers/user_activity_provider.dart';

/// 我常去页面
class FrequentlyVisitedPage extends ConsumerStatefulWidget {
  const FrequentlyVisitedPage({super.key});

  @override
  ConsumerState<FrequentlyVisitedPage> createState() => _FrequentlyVisitedPageState();
}

class _FrequentlyVisitedPageState extends ConsumerState<FrequentlyVisitedPage> {
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await ref.read(frequentlyVisitedListProvider.notifier).refresh();
    _refreshController.refreshCompleted();
  }

  Future<void> _showClearConfirm() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('清空记录'),
        content: const Text('确定要清空所有常去记录吗？此操作不可恢复。'),
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
      await ref.read(frequentlyVisitedListProvider.notifier).clearAll();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('记录已清空')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final visitedAsync = ref.watch(frequentlyVisitedListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('我常去'),
        actions: [
          visitedAsync.when(
            data: (list) => list.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: _showClearConfirm,
                    tooltip: '清空记录',
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: visitedAsync.when(
        data: (list) => _buildList(list),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('加载失败: $err')),
      ),
    );
  }

  Widget _buildList(List<FrequentlyVisited> list) {
    if (list.isEmpty) {
      return _buildEmptyState();
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          return _VisitedCard(
            item: item,
            onTap: () => _navigateToDetail(item.topicId),
            onDelete: () => _removeRecord(item.topicId),
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
            Icons.location_on_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无常去记录',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            '浏览话题时会自动记录',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  void _navigateToDetail(String topicId) {
    context.push(RoutePaths.topicDetail.replaceFirst(':tag', topicId));
  }

  Future<void> _removeRecord(String topicId) async {
    await ref.read(frequentlyVisitedListProvider.notifier).remove(topicId);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('已移除')),
      );
    }
  }
}

class _VisitedCard extends StatelessWidget {
  final FrequentlyVisited item;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _VisitedCard({
    required this.item,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final daysSince = DateTime.now().difference(item.lastVisitedAt).inDays;
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: item.coverUrl != null && item.coverUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.coverUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Icon(
                            Icons.topic,
                            color: colorScheme.primary,
                          ),
                        ),
                      )
                    : Icon(
                        Icons.topic,
                        color: colorScheme.primary,
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.topicName,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        if (item.topicTag != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.secondaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              item.topicTag!,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: colorScheme.onSecondaryContainer,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          '访问 ${item.visitCount} 次',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          timeText,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: colorScheme.error,
                ),
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
