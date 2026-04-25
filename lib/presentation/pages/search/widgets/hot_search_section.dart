import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/search_provider.dart';

/// 热门搜索区域组件
class HotSearchSection extends ConsumerWidget {
  final ValueChanged<String> onSearch;

  const HotSearchSection({
    super.key,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final searchState = ref.watch(searchNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题栏
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '热门搜索',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh, size: 20),
              onPressed: () {
                ref.read(searchNotifierProvider.notifier).loadHotSearches();
              },
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 热门搜索标签
        if (searchState.isLoadingHotSearches)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          )
        else if (searchState.hotSearches.isEmpty)
          const Text('暂无热门搜索')
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: searchState.hotSearches.map((keyword) {
              return ActionChip(
                avatar: const Icon(Icons.trending_up, size: 16),
                label: Text(keyword),
                onPressed: () => onSearch(keyword),
                backgroundColor: colorScheme.secondaryContainer.withOpacity(0.5),
              );
            }).toList(),
          ),
      ],
    );
  }
}
