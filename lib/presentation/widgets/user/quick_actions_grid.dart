import 'package:flutter/material.dart';

/// 快捷功能入口数据模型
class QuickActionItem {
  /// 功能图标
  final IconData icon;

  /// 功能名称
  final String label;

  /// 图标颜色
  final Color? iconColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 未读消息数量
  final int? badgeCount;

  const QuickActionItem({
    required this.icon,
    required this.label,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
    this.badgeCount,
  });
}

/// 快捷功能入口网格组件
///
/// 展示用户常用功能的快捷入口，以网格形式排列
/// 支持自定义图标、颜色、点击事件和消息徽章
class QuickActionsGrid extends StatelessWidget {
  /// 功能列表
  final List<QuickActionItem> items;

  /// 每行显示的列数
  final int crossAxisCount;

  /// 子元素间距
  final double spacing;

  /// 行间距
  final double runSpacing;

  /// 内边距
  final EdgeInsetsGeometry padding;

  const QuickActionsGrid({
    super.key,
    required this.items,
    this.crossAxisCount = 3,
    this.spacing = 16,
    this.runSpacing = 16,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding,
      child: Column(
        children: [
          for (int row = 0; row < (items.length / crossAxisCount).ceil(); row++) ...[
            if (row > 0) SizedBox(height: runSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int col = 0; col < crossAxisCount; col++) ...[
                  if (col > 0) SizedBox(width: spacing),
                  Expanded(
                    child: _buildActionItem(
                      context,
                      items[row * crossAxisCount + col],
                      colorScheme,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// 构建单个功能入口项
  Widget _buildActionItem(
    BuildContext context,
    QuickActionItem item,
    ColorScheme colorScheme,
  ) {
    final effectiveIconColor = item.iconColor ?? colorScheme.primary;
    final effectiveBgColor = item.backgroundColor ??
        (colorScheme.brightness == Brightness.light
            ? const Color(0xFFF0F7FF)
            : colorScheme.surfaceContainerHighest);

    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: effectiveBgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    item.icon,
                    color: effectiveIconColor,
                    size: 24,
                  ),
                ),
                if (item.badgeCount != null && item.badgeCount! > 0)
                  Positioned(
                    right: -4,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        item.badgeCount! > 99 ? '99+' : '${item.badgeCount}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// 预定义的快捷功能配置
class QuickActionPresets {
  /// 本地收藏
  static QuickActionItem localFavorite({VoidCallback? onTap, int? badgeCount}) =>
      QuickActionItem(
        icon: Icons.folder_outlined,
        label: '本地收藏',
        iconColor: const Color(0xFF2196F3),
        backgroundColor: const Color(0xFFE3F2FD),
        onTap: onTap,
        badgeCount: badgeCount,
      );

  /// 浏览历史
  static QuickActionItem history({VoidCallback? onTap}) => QuickActionItem(
        icon: Icons.history,
        label: '浏览历史',
        iconColor: const Color(0xFF9C27B0),
        backgroundColor: const Color(0xFFF3E5F5),
        onTap: onTap,
      );

  /// 我的常去
  static QuickActionItem frequentlyVisited({VoidCallback? onTap}) =>
      QuickActionItem(
        icon: Icons.location_on_outlined,
        label: '我的常去',
        iconColor: const Color(0xFF4CAF50),
        backgroundColor: const Color(0xFFE8F5E9),
        onTap: onTap,
      );

  /// 我的收藏
  static QuickActionItem myFavorites({VoidCallback? onTap, int? badgeCount}) =>
      QuickActionItem(
        icon: Icons.star_border,
        label: '我的收藏',
        iconColor: const Color(0xFFFF9800),
        backgroundColor: const Color(0xFFFFF3E0),
        onTap: onTap,
        badgeCount: badgeCount,
      );

  /// 我的赞
  static QuickActionItem myLikes({VoidCallback? onTap, int? badgeCount}) =>
      QuickActionItem(
        icon: Icons.favorite_border,
        label: '我的赞',
        iconColor: const Color(0xFFE91E63),
        backgroundColor: const Color(0xFFFCE4EC),
        onTap: onTap,
        badgeCount: badgeCount,
      );

  /// 我的回复
  static QuickActionItem myReplies({VoidCallback? onTap, int? badgeCount}) =>
      QuickActionItem(
        icon: Icons.chat_bubble_outline,
        label: '我的回复',
        iconColor: const Color(0xFF00BCD4),
        backgroundColor: const Color(0xFFE0F7FA),
        onTap: onTap,
        badgeCount: badgeCount,
      );

  /// 我的帖子
  static QuickActionItem myTopics({VoidCallback? onTap, int? badgeCount}) =>
      QuickActionItem(
        icon: Icons.article_outlined,
        label: '我的帖子',
        iconColor: const Color(0xFF3F51B5),
        backgroundColor: const Color(0xFFE8EAF6),
        onTap: onTap,
        badgeCount: badgeCount,
      );

  /// 草稿箱
  static QuickActionItem drafts({VoidCallback? onTap, int? badgeCount}) =>
      QuickActionItem(
        icon: Icons.drive_file_rename_outline,
        label: '草稿箱',
        iconColor: const Color(0xFF795548),
        backgroundColor: const Color(0xFFEFEBE9),
        onTap: onTap,
        badgeCount: badgeCount,
      );
}
