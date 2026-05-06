import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/user_provider.dart';

/// 在线状态指示器组件
///
/// 显示用户的在线状态，包括：
/// - 在线（绿色圆点）
/// - 离线（显示多久前在线）
///
/// 使用示例：
/// ```dart
/// OnlineStatusIndicator(username: '用户名')
/// ```
class OnlineStatusIndicator extends ConsumerWidget {
  /// 用户名
  final String username;

  /// 显示样式
  final OnlineStatusStyle style;

  /// 是否显示文字
  final bool showText;

  /// 圆点大小
  final double dotSize;

  const OnlineStatusIndicator({
    super.key,
    required this.username,
    this.style = OnlineStatusStyle.compact,
    this.showText = true,
    this.dotSize = 8,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final discourseUserAsync = ref.watch(discourseUserProfileProvider(username));

    return discourseUserAsync.when(
      data: (userData) {
        if (userData == null) return const SizedBox.shrink();

        final lastSeenAt = userData['last_seen_at'] as String?;
        if (lastSeenAt == null || lastSeenAt.isEmpty) {
          return const SizedBox.shrink();
        }

        final lastSeen = DateTime.tryParse(lastSeenAt);
        if (lastSeen == null) return const SizedBox.shrink();

        final now = DateTime.now();
        final difference = now.difference(lastSeen);

        // 判断在线状态（5分钟内活跃视为在线）
        final isOnline = difference.inMinutes < 5;

        switch (style) {
          case OnlineStatusStyle.compact:
            return _buildCompactStyle(context, isOnline, difference);
          case OnlineStatusStyle.detailed:
            return _buildDetailedStyle(context, isOnline, difference);
          case OnlineStatusStyle.dotOnly:
            return _buildDotOnly(context, isOnline);
        }
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  /// 构建紧凑样式（用于用户名后面）
  Widget _buildCompactStyle(BuildContext context, bool isOnline, Duration difference) {
    final statusText = isOnline ? '在线' : _formatLastSeen(difference);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            color: isOnline ? Colors.green : Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 4),
          Text(
            statusText,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isOnline ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 11,
            ),
          ),
        ],
      ],
    );
  }

  /// 构建详细样式（用于用户资料页）
  Widget _buildDetailedStyle(BuildContext context, bool isOnline, Duration difference) {
    final statusText = isOnline ? '在线' : _formatLastSeen(difference);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOnline
            ? Colors.green.withValues(alpha: 0.1)
            : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isOnline
              ? Colors.green.withValues(alpha: 0.3)
              : Theme.of(context).colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              color: isOnline ? Colors.green : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          if (showText) ...[
            const SizedBox(width: 4),
            Text(
              statusText,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isOnline ? Colors.green : Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: isOnline ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 构建仅圆点样式
  Widget _buildDotOnly(BuildContext context, bool isOnline) {
    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.grey,
        shape: BoxShape.circle,
      ),
    );
  }

  /// 格式化最后在线时间
  String _formatLastSeen(Duration difference) {
    if (difference.inDays > 365) {
      final years = difference.inDays ~/ 365;
      return '$years年前';
    } else if (difference.inDays > 30) {
      final months = difference.inDays ~/ 30;
      return '$months个月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}

/// 在线状态显示样式
enum OnlineStatusStyle {
  /// 紧凑样式（圆点+文字，用于用户名后面）
  compact,

  /// 详细样式（带背景的标签，用于用户资料页）
  detailed,

  /// 仅圆点
  dotOnly,
}
