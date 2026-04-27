import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../data/models/tag_group.dart';
import '../../widgets/common/main_top_app_bar_title.dart';
import '../../widgets/common/cached_image.dart';

/// 话题页面
///
/// 展示标签分类和热门话题，采用左侧分类导航+右侧网格卡片的布局
class TopicsPage extends ConsumerStatefulWidget {
  /// 是否作为独立页面显示（显示AppBar）
  final bool asStandalonePage;

  /// 构造函数
  const TopicsPage({super.key, this.asStandalonePage = false});

  @override
  ConsumerState<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends ConsumerState<TopicsPage>
    with TickerProviderStateMixin {
  /// 当前选中的分类索引
  int _selectedCategoryIndex = 0;

  /// 标签分组数据
  late final List<TagGroup> _tagGroups;

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 动画控制器
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _tagGroups = TagData.getAllTagGroups();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
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
        Expanded(child: _buildContentArea(theme, colorScheme)),
      ],
    );

    if (widget.asStandalonePage) {
      return Scaffold(
        appBar: AppBar(
          title: const MainTopAppBarTitle(),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                HapticFeedbackUtil.trigger(ref, HapticScene.message);
                context.push(RoutePaths.notifications);
              },
            ),
          ],
        ),
        body: body,
      );
    }

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          SliverAppBar(
            title: const MainTopAppBarTitle(),
            pinned: true,
            floating: true,
            snap: true,
            forceElevated: innerBoxIsScrolled,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  HapticFeedbackUtil.trigger(ref, HapticScene.message);
                  context.push(RoutePaths.notifications);
                },
              ),
            ],
          ),
        ];
      },
      body: body,
    );
  }

  /// 构建左侧分类导航栏
  ///
  /// [colorScheme] 当前主题的颜色方案
  /// @return 左侧导航栏Widget
  Widget _buildCategorySidebar(ColorScheme colorScheme) {
    return Container(
      width: 88,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        border: Border(
          right: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        itemCount: _tagGroups.length,
        itemBuilder: (context, index) {
          final group = _tagGroups[index];
          final isSelected = index == _selectedCategoryIndex;

          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: _CategoryNavItem(
              icon: _getCategoryIcon(group.icon),
              label: group.category,
              isSelected: isSelected,
              colorScheme: colorScheme,
              onTap: () {
                if (_selectedCategoryIndex != index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }
              },
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
        // 分类标题 - 优化为更紧凑的样式
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: colorScheme.primary.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getCategoryIcon(currentGroup.icon),
                    size: 18,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentGroup.category,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      Text(
                        '${tags.length} 个话题',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // 标签网格 - 修复溢出问题，调整为1.2宽高比
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final tag = tags[index];
              return AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final delay = index * 0.05;
                  final value = (_animationController.value - delay).clamp(
                    0.0,
                    1.0,
                  );
                  return FadeTransition(
                    opacity: CurvedAnimation(
                      parent: AlwaysStoppedAnimation(value),
                      curve: Curves.easeOut,
                    ),
                    child: SlideTransition(
                      position:
                          Tween<Offset>(
                            begin: const Offset(0, 0.1),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: AlwaysStoppedAnimation(value),
                              curve: Curves.easeOut,
                            ),
                          ),
                      child: child,
                    ),
                  );
                },
                child: _TagCard(tag: tag, onTap: () => _onTagTap(tag)),
              );
            }, childCount: tags.length),
          ),
        ),
        // 底部间距
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
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
    final rawTag = tag.name.trim().isNotEmpty
        ? tag.name.trim()
        : tag.slug.trim();
    // 使用 Uri.encodeComponent 对标签进行编码，确保特殊字符不会破坏 URL
    // 同时处理可能的 % 字符，避免双重编码问题
    final sanitizedTag = rawTag.replaceAll('%', '%25');
    final encodedTag = Uri.encodeComponent(sanitizedTag);
    context.push(RoutePaths.tagDetail.replaceFirst(':tag', encodedTag));
  }
}

/// 分类导航项组件
///
/// 用于展示左侧导航栏的分类项
class _CategoryNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _CategoryNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primaryContainer
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary.withOpacity(0.2)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: isSelected ? 1.15 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                child: Icon(
                  icon,
                  size: 22,
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
      ),
    );
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
  const _TagCard({required this.tag, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final tagColor = _parseColor(tag.color);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: colorScheme.outlineVariant.withOpacity(0.15),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: tagColor.withOpacity(0.1),
        highlightColor: tagColor.withOpacity(0.05),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [tagColor.withOpacity(0.06), tagColor.withOpacity(0.02)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // 顶部：图标和数量
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 标签图标
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: tagColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: tag.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedImage(
                                imageUrl: tag.imageUrl!,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                                borderRadius: 10,
                                memCacheWidth: 80,
                                memCacheHeight: 80,
                                errorIcon: Icons.label,
                              ),
                            )
                          : _buildFallbackIcon(tagColor),
                    ),
                  ),
                  // 话题数量
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 10,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          _formatCount(tag.count),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // 底部：标签名称
              Text(
                tag.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
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
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
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
