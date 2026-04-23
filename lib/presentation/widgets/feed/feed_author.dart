import 'package:flutter/material.dart';
import '../user/user_avatar.dart';
import '../user/user_name.dart';
import '../user/follow_button.dart';

/// 动态作者信息组件
///
/// 展示作者头像、昵称、发布时间等信息
/// 支持关注按钮和更多操作
class FeedAuthor extends StatelessWidget {
  /// 用户头像 URL
  final String? avatarUrl;

  /// 用户 ID
  final String? userId;

  /// 用户名
  final String username;

  /// 发布时间
  final DateTime? publishTime;

  /// 发布地点
  final String? location;

  /// 用户等级
  final UserLevel userLevel;

  /// 是否显示关注按钮
  final bool showFollowButton;

  /// 当前关注状态
  final FollowStatus followStatus;

  /// 是否显示更多按钮
  final bool showMoreButton;

  /// 点击回调
  final VoidCallback? onTap;

  /// 关注按钮点击回调
  final VoidCallback? onFollowTap;

  /// 更多按钮点击回调
  final VoidCallback? onMoreTap;

  /// 头像尺寸
  final double avatarSize;

  /// 构造函数
  ///
  /// [username] 用户名（必填）
  /// [avatarUrl] 头像 URL
  /// [userId] 用户 ID
  /// [publishTime] 发布时间
  /// [location] 发布地点
  /// [userLevel] 用户等级，默认 normal
  /// [showFollowButton] 是否显示关注按钮，默认 true
  /// [followStatus] 关注状态，默认 notFollowing
  /// [showMoreButton] 是否显示更多按钮，默认 true
  /// [onTap] 点击回调
  /// [onFollowTap] 关注按钮点击回调
  /// [onMoreTap] 更多按钮点击回调
  /// [avatarSize] 头像尺寸，默认 48
  const FeedAuthor({
    super.key,
    required this.username,
    this.avatarUrl,
    this.userId,
    this.publishTime,
    this.location,
    this.userLevel = UserLevel.normal,
    this.showFollowButton = true,
    this.followStatus = FollowStatus.notFollowing,
    this.showMoreButton = true,
    this.onTap,
    this.onFollowTap,
    this.onMoreTap,
    this.avatarSize = 48,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap ?? () => _navigateToUserProfile(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // 头像
            UserAvatar(
              avatarUrl: avatarUrl,
              userId: userId,
              size: avatarSize,
            ),
            const SizedBox(width: 12),
            // 用户信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 用户名和等级
                  UserName(
                    username: username,
                    userId: userId,
                    level: userLevel,
                    showLevel: true,
                  ),
                  const SizedBox(height: 2),
                  // 时间和位置
                  _buildTimeAndLocation(context, colorScheme),
                ],
              ),
            ),
            // 关注按钮
            if (showFollowButton) ...[
              const SizedBox(width: 8),
              FollowButton.small(
                status: followStatus,
                onPressed: onFollowTap,
              ),
            ],
            // 更多按钮
            if (showMoreButton) ...[
              IconButton(
                onPressed: onMoreTap,
                icon: const Icon(Icons.more_vert),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 40,
                  minHeight: 40,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 构建时间和位置信息
  Widget _buildTimeAndLocation(BuildContext context, ColorScheme colorScheme) {
    final textTheme = Theme.of(context).textTheme;
    final List<Widget> children = [];

    // 时间
    if (publishTime != null) {
      children.add(
        Text(
          _formatTime(publishTime!),
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    // 位置
    if (location != null && location!.isNotEmpty) {
      if (children.isNotEmpty) {
        children.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              '·',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        );
      }
      children.add(
        Flexible(
          child: Text(
            location!,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }

  /// 格式化时间
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}个月前';
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

  /// 跳转到用户主页
  void _navigateToUserProfile(BuildContext context) {
    if (userId != null) {
      // TODO: 使用路由跳转到用户主页
      // context.push('/user/$userId');
    }
  }
}

/// 简洁版动态作者组件
///
/// 用于需要简洁展示作者信息的场景
class FeedAuthorSimple extends StatelessWidget {
  /// 用户头像 URL
  final String? avatarUrl;

  /// 用户 ID
  final String? userId;

  /// 用户名
  final String username;

  /// 发布时间
  final DateTime? publishTime;

  /// 点击回调
  final VoidCallback? onTap;

  /// 头像尺寸
  final double avatarSize;

  /// 构造函数
  ///
  /// [username] 用户名（必填）
  /// [avatarUrl] 头像 URL
  /// [userId] 用户 ID
  /// [publishTime] 发布时间
  /// [onTap] 点击回调
  /// [avatarSize] 头像尺寸，默认 40
  const FeedAuthorSimple({
    super.key,
    required this.username,
    this.avatarUrl,
    this.userId,
    this.publishTime,
    this.onTap,
    this.avatarSize = 40,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap ?? () => _navigateToUserProfile(context),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserAvatar(
            avatarUrl: avatarUrl,
            userId: userId,
            size: avatarSize,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                username,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onBackground,
                ),
              ),
              if (publishTime != null)
                Text(
                  _formatTime(publishTime!),
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  /// 格式化时间
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}个月前';
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

  /// 跳转到用户主页
  void _navigateToUserProfile(BuildContext context) {
    if (userId != null) {
      // TODO: 使用路由跳转到用户主页
      // context.push('/user/$userId');
    }
  }
}
