import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../providers/search_provider.dart';

/// 榜单区域组件
class RankingSection extends ConsumerWidget {
  const RankingSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final searchState = ref.watch(searchNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tab栏
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: RankingType.values.map((type) {
              final isSelected = searchState.rankingType == type;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                  onTap: () {
                    ref.read(searchNotifierProvider.notifier).setRankingType(type);
                  },
                  child: Column(
                    children: [
                      Text(
                        _getRankingTypeName(type),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 2),
                      if (isSelected)
                        Container(
                          width: 16,
                          height: 2,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        // 榜单内容
        if (searchState.isLoadingRanking)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          )
        else if (searchState.rankingTopics.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                '暂无榜单数据',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ),
          )
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: searchState.rankingTopics.take(20).length,
            itemBuilder: (context, index) {
              final topic = searchState.rankingTopics[index];
              return _RankingListItem(
                topic: topic,
                onTap: () {
                  context.push('/feed/${topic.id}');
                },
              );
            },
          ),
      ],
    );
  }

  String _getRankingTypeName(RankingType type) {
    switch (type) {
      case RankingType.hot:
        return '热门榜';
      case RankingType.top:
        return '排行榜';
      case RankingType.category:
        return '分类榜';
    }
  }
}

/// 榜单列表项
class _RankingListItem extends StatelessWidget {
  final RankingTopic topic;
  final VoidCallback onTap;

  const _RankingListItem({
    required this.topic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 排名颜色
    Color rankColor;
    if (topic.rank == 1) {
      rankColor = Colors.red;
    } else if (topic.rank == 2) {
      rankColor = Colors.orange;
    } else if (topic.rank == 3) {
      rankColor = Colors.amber;
    } else {
      rankColor = colorScheme.onSurfaceVariant;
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            // 排名
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: topic.rank <= 3 ? rankColor.withValues(alpha: 0.1) : null,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Center(
                child: Text(
                  '${topic.rank}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: rankColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      if (topic.categoryName.isNotEmpty)
                        Text(
                          topic.categoryName,
                          style: TextStyle(
                            fontSize: 11,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      if (topic.categoryName.isNotEmpty)
                        Text(
                          ' · ',
                          style: TextStyle(
                            fontSize: 11,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      Icon(
                        Icons.comment_outlined,
                        size: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${topic.replyCount}',
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // 热度
            Row(
              children: [
                Icon(
                  Icons.local_fire_department,
                  size: 14,
                  color: Colors.orange[400],
                ),
                const SizedBox(width: 2),
                Text(
                  _formatHeatValue(topic.heatValue),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.orange[400],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatHeatValue(int value) {
    if (value >= 10000) {
      return '${(value / 10000).toStringAsFixed(1)}万';
    }
    return '$value';
  }
}
