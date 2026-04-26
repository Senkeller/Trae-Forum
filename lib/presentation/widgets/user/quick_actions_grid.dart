import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';

/// 快捷功能项
class QuickActionItem {
  final String title;
  final IconData icon;
  final String route;
  final bool requireLogin;
  final Color? iconColor;
  final Color? backgroundColor;
  final int? badgeCount;
  final VoidCallback? onTap;

  const QuickActionItem({
    required this.title,
    required this.icon,
    required this.route,
    this.requireLogin = false,
    this.iconColor,
    this.backgroundColor,
    this.badgeCount,
    this.onTap,
  });
}

/// 快捷功能入口网格组件
///
/// 展示用户常用功能的快捷入口，以网格形式排列
/// 支持自定义图标、颜色、点击事件和消息徽章
class QuickActionsGrid extends ConsumerWidget {
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
    this.crossAxisCount = 4,
    this.spacing = 12,
    this.runSpacing = 16,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isLoggedIn = ref.watch(isAuthenticatedProvider);

    return Container(
      padding: padding,
      child: Column(
        children: [
          for (
            int row = 0;
            row < (items.length / crossAxisCount).ceil();
            row++
          ) ...[
            if (row > 0) SizedBox(height: runSpacing),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int col = 0; col < crossAxisCount; col++) ...[
                  if (col > 0) SizedBox(width: spacing),
                  Expanded(
                    child: (row * crossAxisCount + col) < items.length
                        ? _buildActionItem(
                            context,
                            items[row * crossAxisCount + col],
                            colorScheme,
                            isLoggedIn,
                            ref,
                          )
                        : const SizedBox.shrink(),
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
    bool isLoggedIn,
    WidgetRef ref,
  ) {
    final effectiveIconColor = item.iconColor ?? colorScheme.primary;
    final effectiveBgColor =
        item.backgroundColor ??
        (colorScheme.brightness == Brightness.light
            ? const Color(0xFFF0F7FF)
            : colorScheme.surfaceContainerHighest);

    return InkWell(
      onTap: () => _handleTap(context, item, isLoggedIn, ref),
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
                  child: Icon(item.icon, color: effectiveIconColor, size: 24),
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
              item.title,
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

  /// 处理点击事件
  void _handleTap(
    BuildContext context,
    QuickActionItem item,
    bool isLoggedIn,
    WidgetRef ref,
  ) {
    // 检查是否需要登录
    if (item.requireLogin && !isLoggedIn) {
      _showLoginDialog(context);
      return;
    }

    // 如果有自定义 onTap，优先使用
    if (item.onTap != null) {
      item.onTap!();
      return;
    }

    // 导航到对应页面
    context.push(item.route);
  }

  /// 显示登录对话框
  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('需要登录'),
        content: const Text('该功能需要登录后才能使用，是否前往登录？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.push(RoutePaths.login);
            },
            child: const Text('去登录'),
          ),
        ],
      ),
    );
  }
}

/// 默认快捷功能列表
final List<QuickActionItem> defaultQuickActions = [
  // 本地数据功能（无需登录）
  const QuickActionItem(
    title: '本地收藏',
    icon: Icons.favorite_outline,
    route: RoutePaths.localFavorites,
    iconColor: Color(0xFFE91E63),
    backgroundColor: Color(0xFFFCE4EC),
  ),
  const QuickActionItem(
    title: '浏览历史',
    icon: Icons.history,
    route: RoutePaths.browseHistory,
    iconColor: Color(0xFF9C27B0),
    backgroundColor: Color(0xFFF3E5F5),
  ),
  const QuickActionItem(
    title: '我常去',
    icon: Icons.location_on_outlined,
    route: RoutePaths.frequentlyVisited,
    iconColor: Color(0xFF4CAF50),
    backgroundColor: Color(0xFFE8F5E9),
  ),
  // 服务器数据功能（需要登录）
  const QuickActionItem(
    title: '我的收藏',
    icon: Icons.bookmark_outline,
    route: RoutePaths.favorites,
    requireLogin: true,
    iconColor: Color(0xFFFF9800),
    backgroundColor: Color(0xFFFFF3E0),
  ),
  const QuickActionItem(
    title: '我的赞',
    icon: Icons.thumb_up_outlined,
    route: '/user/current_user?tab=activity&category=likes',
    requireLogin: true,
    iconColor: Color(0xFF2196F3),
    backgroundColor: Color(0xFFE3F2FD),
  ),
  const QuickActionItem(
    title: '我的回复',
    icon: Icons.chat_bubble_outline,
    route: '/user/current_user?tab=activity&category=replies',
    requireLogin: true,
    iconColor: Color(0xFF00BCD4),
    backgroundColor: Color(0xFFE0F7FA),
  ),
  const QuickActionItem(
    title: '我的关注',
    icon: Icons.person_add_outlined,
    route: '/user/follows',
    requireLogin: true,
    iconColor: Color(0xFF3F51B5),
    backgroundColor: Color(0xFFE8EAF6),
  ),
  const QuickActionItem(
    title: '我的粉丝',
    icon: Icons.people_outline,
    route: '/user/fans',
    requireLogin: true,
    iconColor: Color(0xFF795548),
    backgroundColor: Color(0xFFEFEBE9),
  ),
  const QuickActionItem(
    title: '草稿箱',
    icon: Icons.drafts_outlined,
    route: RoutePaths.message,
    requireLogin: true,
    iconColor: Color(0xFF607D8B),
    backgroundColor: Color(0xFFECEFF1),
  ),
  const QuickActionItem(
    title: '设置',
    icon: Icons.settings_outlined,
    route: RoutePaths.settings,
    iconColor: Color(0xFF757575),
    backgroundColor: Color(0xFFF5F5F5),
  ),
  const QuickActionItem(
    title: '关于',
    icon: Icons.info_outline,
    route: RoutePaths.about,
    iconColor: Color(0xFF9E9E9E),
    backgroundColor: Color(0xFFFAFAFA),
  ),
];
