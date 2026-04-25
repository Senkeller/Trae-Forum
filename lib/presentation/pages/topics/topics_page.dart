import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../data/models/tag_group.dart';

/// 话题页面
///
/// 展示标签分类和热门话题，采用左侧分类导航+右侧网格卡片的布局
class TopicsPage extends ConsumerStatefulWidget {
  /// 是否作为独立页面显示（显示AppBar）
  final bool asStandalonePage;

  /// 构造函数
  const TopicsPage({
    super.key,
    this.asStandalonePage = false,
  });

  @override
  ConsumerState<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends ConsumerState<TopicsPage> {
  /// 当前选中的分类索引
  int _selectedCategoryIndex = 0;

  /// 标签分组数据
  late final List<TagGroup> _tagGroups;

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tagGroups = TagData.getAllTagGroups();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final body = Row(
      children: [
        // 左侧分类导航
        _buildCategorySidebar(colorScheme),
        // 右侧内容区域
        Expanded(
          child: _buildContentArea(theme, colorScheme),
        ),
      ],
    );

    if (widget.asStandalonePage) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('话题'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                context.push(RoutePaths.search);
              },
            ),
          ],
        ),
        body: body,
      );
    }

    return body;
  }

  /// 构建左侧分类导航栏
  ///
  /// [colorScheme] 当前主题的颜色方案
  /// @return 左侧导航栏Widget
  Widget _buildCategorySidebar(ColorScheme colorScheme) {
    return Container(
      width: 90,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border(
          right: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.5),
            width: 0.5,
          ),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _tagGroups.length,
        itemBuilder: (context, index) {
          final group = _tagGroups[index];
          final isSelected = index == _selectedCategoryIndex;

          return InkWell(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
              // 滚动到顶部
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primaryContainer.withOpacity(0.3)
                    : Colors.transparent,
                border: Border(
                  left: BorderSide(
                    color: isSelected ? colorScheme.primary : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getCategoryIcon(group.icon),
                    size: 24,
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    group.category,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// 构建右侧内容区域
  ///
  /// [theme] 当前主题
  /// [colorScheme] 当前主题的颜色方案
  /// @return 右侧内容区域Widget
  Widget _buildContentArea(ThemeData theme, ColorScheme colorScheme) {
    final currentGroup = _tagGroups[_selectedCategoryIndex];
    final tags = currentGroup.tags;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        // 分类标题
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: [
                Icon(
                  _getCategoryIcon(currentGroup.icon),
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  currentGroup.category,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${tags.length}个话题)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        // 标签网格
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final tag = tags[index];
                return _TagCard(
                  tag: tag,
                  onTap: () => _onTagTap(tag),
                );
              },
              childCount: tags.length,
            ),
          ),
        ),
        // 底部间距
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
      ],
    );
  }

  /// 获取分类图标
  ///
  /// [iconName] 图标名称标识
  /// @return 对应的图标数据
  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'recommend':
        return Icons.recommend_outlined;
      case 'hot':
        return Icons.local_fire_department_outlined;
      case 'interaction':
        return Icons.forum_outlined;
      case 'product':
        return Icons.apps_outlined;
      case 'solo':
        return Icons.emoji_events_outlined;
      case 'career':
        return Icons.work_outline;
      case 'other':
        return Icons.more_horiz;
      default:
        return Icons.label_outline;
    }
  }

  /// 处理标签点击事件
  ///
  /// [tag] 被点击的标签
  void _onTagTap(TagItem tag) {
    context.push(RoutePaths.tagDetail.replaceFirst(':tag', tag.slug));
  }
}

/// 标签卡片组件
///
/// 用于展示单个标签的卡片
class _TagCard extends StatelessWidget {
  /// 标签数据
  final TagItem tag;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _TagCard({
    required this.tag,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 解析标签颜色
    final tagColor = _parseColor(tag.color);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 标签图标/首字母
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: tagColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: tag.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          tag.imageUrl!,
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return _buildFallbackIcon(tagColor);
                          },
                        ),
                      )
                    : _buildFallbackIcon(tagColor),
              ),
            ),
            const SizedBox(height: 8),
            // 标签名称
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                tag.name,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            // 话题数量
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.chat_bubble_outline,
                  size: 10,
                  color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                ),
                const SizedBox(width: 2),
                Text(
                  _formatCount(tag.count),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建默认图标
  ///
  /// [color] 图标颜色
  /// @return 默认图标Widget
  Widget _buildFallbackIcon(Color color) {
    return Text(
      tag.name.isNotEmpty ? tag.name[0].toUpperCase() : '#',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  /// 解析颜色字符串
  ///
  /// [colorString] 十六进制颜色字符串
  /// @return 解析后的颜色值
  Color _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return Colors.blue;
    }
    try {
      String hex = colorString.replaceAll('#', '');
      if (hex.length == 6) {
        hex = 'FF$hex';
      }
      return Color(int.parse(hex, radix: 16));
    } catch (_) {
      return Colors.blue;
    }
  }

  /// 格式化数量显示
  ///
  /// [count] 话题数量
  /// @return 格式化后的字符串
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}万';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
