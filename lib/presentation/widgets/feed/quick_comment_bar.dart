import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../user/user_avatar.dart';
import '../../providers/auth_provider.dart';
import '../../../config/routes.dart';

/// 快速评论栏组件
///
/// 用于动态卡片底部的快速评论输入入口，展示为胶囊形输入框
/// 包含用户头像、占位文案和表情图标
/// 集成登录态检查，未登录时显示登录引导弹窗
class QuickCommentBar extends ConsumerWidget {
  /// 当前用户头像 URL
  final String? currentUserAvatar;

  /// 点击回调
  final VoidCallback onTap;

  /// 是否强制显示登录检查，默认为 true
  final bool requireLogin;

  /// 构造函数
  ///
  /// [currentUserAvatar] 当前用户头像 URL，为 null 时显示默认头像
  /// [onTap] 点击回调（必填）
  /// [requireLogin] 是否需要登录检查，默认为 true
  const QuickCommentBar({
    super.key,
    this.currentUserAvatar,
    required this.onTap,
    this.requireLogin = true,
  });

  /// 显示登录引导弹窗
  ///
  /// [context] BuildContext
  /// 返回用户是否点击了「去登录」
  static Future<bool> showLoginDialog(BuildContext context) async {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          '需要登录',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        content: Text(
          '登录后即可发表评论，与社区互动',
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        actions: [
          Row(
            children: [
              // 取消按钮
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: colorScheme.outline,
                    ),
                  ),
                  child: const Text('取消'),
                ),
              ),
              const SizedBox(width: 12),
              // 去登录按钮
              Expanded(
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('去登录'),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return result ?? false;
  }

  /// 处理点击事件
  ///
  /// [context] BuildContext
  /// [ref] WidgetRef
  /// 检查登录状态，未登录时显示登录引导弹窗
  Future<void> _handleTap(BuildContext context, WidgetRef ref) async {
    if (!requireLogin) {
      onTap();
      return;
    }

    final isAuthenticated = ref.read(isAuthenticatedProvider);

    if (isAuthenticated) {
      onTap();
    } else {
      final shouldLogin = await showLoginDialog(context);
      if (shouldLogin && context.mounted) {
        context.push(RoutePaths.login);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => _handleTap(context, ref),
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // 当前用户头像
            UserAvatar(
              avatarUrl: currentUserAvatar,
              size: 24,
              fallbackIcon: Icons.person,
              fallbackBackgroundColor: colorScheme.surface,
              fallbackIconColor: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            // 占位文案
            Expanded(
              child: Text(
                '说点什么吧...',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant.withOpacity(0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // 表情图标
            Icon(
              Icons.sentiment_satisfied_outlined,
              size: 20,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}

/// 使用示例
///
/// ```dart
/// // 基础使用（自动检查登录态）
/// QuickCommentBar(
///   currentUserAvatar: 'https://example.com/avatar.jpg',
///   onTap: () {
///     // 已登录时执行此回调
///     showModalBottomSheet(
///       context: context,
///       builder: (context) => CommentInputSheet(),
///     );
///   },
/// )
///
/// // 无头像时使用默认头像
/// QuickCommentBar(
///   onTap: () {
///     // 处理点击事件
///   },
/// )
///
/// // 跳过登录检查
/// QuickCommentBar(
///   requireLogin: false,
///   onTap: () {
///     // 直接执行，不检查登录态
///   },
/// )
///
/// // 在动态卡片中使用
/// FeedCard(
///   feed: feed,
///   bottomWidget: Padding(
///     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
///     child: QuickCommentBar(
///       currentUserAvatar: userProvider.currentUser?.avatarUrl,
///       onTap: () => _openCommentInput(context, feed),
///     ),
///   ),
/// )
/// ```
