import 'package:flutter/material.dart';
import '../user/user_avatar.dart';

/// 快速评论栏组件
///
/// 用于动态卡片底部的快速评论输入入口，展示为胶囊形输入框
/// 包含用户头像、占位文案和表情图标
class QuickCommentBar extends StatelessWidget {
  /// 当前用户头像 URL
  final String? currentUserAvatar;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  ///
  /// [currentUserAvatar] 当前用户头像 URL，为 null 时显示默认头像
  /// [onTap] 点击回调（必填）
  const QuickCommentBar({
    super.key,
    this.currentUserAvatar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
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
/// // 基础使用
/// QuickCommentBar(
///   currentUserAvatar: 'https://example.com/avatar.jpg',
///   onTap: () {
///     // 打开评论输入框或跳转到评论页面
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
