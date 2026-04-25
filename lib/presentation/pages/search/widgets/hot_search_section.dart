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
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            InkWell(
              onTap: () {
                ref.read(searchNotifierProvider.notifier).loadHotSearches();
              },
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.refresh,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 热门搜索标签
        if (searchState.isLoadingHotSearches)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          )
        else if (searchState.hotSearches.isEmpty)
          Text(
            '暂无热门搜索',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          )
        else
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: searchState.hotSearches.map((keyword) {
              return ActionChip(
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                avatar: const Icon(Icons.trending_up, size: 14),
                label: Text(
                  keyword,
                  style: const TextStyle(fontSize: 12),
                ),
                onPressed: () => onSearch(keyword),
                backgroundColor: colorScheme.secondaryContainer.withValues(alpha: 0.5),
              );
            }).toList(),
          ),
      ],
    );
  }
}
