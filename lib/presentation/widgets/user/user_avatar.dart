import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants.dart';
import '../common/cached_image.dart';

/// 用户头像组件
///
/// 支持以下功能：
/// - 圆形头像展示
/// - 网络图片缓存
/// - 点击跳转用户主页
/// - 在线状态指示器
/// - 认证标识（V 标）
/// - 多种尺寸预设
class UserAvatar extends StatelessWidget {
  /// 用户头像 URL
  final String? avatarUrl;

  /// 用户 ID（用于点击跳转）
  final String? userId;

  /// 头像尺寸
  final double size;

  /// 是否显示在线状态
  final bool showOnlineStatus;

  /// 是否在线
  final bool isOnline;

  /// 是否显示认证标识
  final bool showVerifiedBadge;

  /// 是否认证用户
  final bool isVerified;

  /// 认证标识位置
  final Alignment verifiedBadgeAlignment;

  /// 点击回调
  final VoidCallback? onTap;

  /// 占位图背景色
  final Color? placeholderColor;

  /// 边框颜色
  final Color? borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 回退图标（当没有头像时显示）
  final IconData? fallbackIcon;

  /// 回退背景色
  final Color? fallbackBackgroundColor;

  /// 回退图标颜色
  final Color? fallbackIconColor;

  /// 内存缓存宽度（用于优化内存占用）
  final int? memCacheWidth;

  /// 内存缓存高度（用于优化内存占用）
  final int? memCacheHeight;

  /// 构造函数
  ///
  /// [avatarUrl] 头像 URL
  /// [userId] 用户 ID，用于点击跳转
  /// [size] 头像尺寸，默认 48
  /// [showOnlineStatus] 是否显示在线状态，默认 false
  /// [isOnline] 是否在线，默认 false
  /// [showVerifiedBadge] 是否显示认证标识，默认 false
  /// [isVerified] 是否认证用户，默认 false
  /// [verifiedBadgeAlignment] 认证标识位置，默认右下角
  /// [onTap] 点击回调
  /// [placeholderColor] 占位图背景色
  /// [borderColor] 边框颜色
  /// [borderWidth] 边框宽度，默认 0
  /// [fallbackIcon] 回退图标（当没有头像时显示）
  /// [fallbackBackgroundColor] 回退背景色
  /// [fallbackIconColor] 回退图标颜色
  /// [memCacheWidth] 内存缓存宽度，用于限制内存占用
  /// [memCacheHeight] 内存缓存高度，用于限制内存占用
  const UserAvatar({
    super.key,
    this.avatarUrl,
    this.userId,
    this.size = 48,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.showVerifiedBadge = false,
    this.isVerified = false,
    this.verifiedBadgeAlignment = Alignment.bottomRight,
    this.onTap,
    this.placeholderColor,
    this.borderColor,
    this.borderWidth = 0,
    this.fallbackIcon,
    this.fallbackBackgroundColor,
    this.fallbackIconColor,
    this.memCacheWidth,
    this.memCacheHeight,
  });

  /// 小尺寸头像（40px）
  const UserAvatar.small({
    super.key,
    this.avatarUrl,
    this.userId,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.showVerifiedBadge = false,
    this.isVerified = false,
    this.verifiedBadgeAlignment = Alignment.bottomRight,
    this.onTap,
    this.placeholderColor,
    this.borderColor,
    this.borderWidth = 0,
    this.fallbackIcon,
    this.fallbackBackgroundColor,
    this.fallbackIconColor,
    this.memCacheWidth,
    this.memCacheHeight,
  }) : size = 40;

  /// 中尺寸头像（48px）
  const UserAvatar.medium({
    super.key,
    this.avatarUrl,
    this.userId,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.showVerifiedBadge = false,
    this.isVerified = false,
    this.verifiedBadgeAlignment = Alignment.bottomRight,
    this.onTap,
    this.placeholderColor,
    this.borderColor,
    this.borderWidth = 0,
    this.fallbackIcon,
    this.fallbackBackgroundColor,
    this.fallbackIconColor,
    this.memCacheWidth,
    this.memCacheHeight,
  }) : size = 48;

  /// 大尺寸头像（56px）
  const UserAvatar.large({
    super.key,
    this.avatarUrl,
    this.userId,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.showVerifiedBadge = false,
    this.isVerified = false,
    this.verifiedBadgeAlignment = Alignment.bottomRight,
    this.onTap,
    this.placeholderColor,
    this.borderColor,
    this.borderWidth = 0,
    this.fallbackIcon,
    this.fallbackBackgroundColor,
    this.fallbackIconColor,
    this.memCacheWidth,
    this.memCacheHeight,
  }) : size = 56;

  /// 超大尺寸头像（80px）
  const UserAvatar.xlarge({
    super.key,
    this.avatarUrl,
    this.userId,
    this.showOnlineStatus = false,
    this.isOnline = false,
    this.showVerifiedBadge = false,
    this.isVerified = false,
    this.verifiedBadgeAlignment = Alignment.bottomRight,
    this.onTap,
    this.placeholderColor,
    this.borderColor,
    this.borderWidth = 0,
    this.fallbackIcon,
    this.fallbackBackgroundColor,
    this.fallbackIconColor,
    this.memCacheWidth,
    this.memCacheHeight,
  }) : size = 80;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget avatarWidget = _buildAvatar(context);

    // 添加在线状态指示器
    if (showOnlineStatus) {
      avatarWidget = _buildWithOnlineStatus(avatarWidget, colorScheme);
    }

    // 添加认证标识
    if (showVerifiedBadge && isVerified) {
      avatarWidget = _buildWithVerifiedBadge(avatarWidget, colorScheme);
    }

    // 添加点击事件
    if (onTap != null || userId != null) {
      avatarWidget = GestureDetector(
        onTap: onTap ?? () => _navigateToUserProfile(context),
        child: avatarWidget,
      );
    }

    return avatarWidget;
  }

  /// 构建头像
  ///
  /// [context] 构建上下文
  /// @return 头像组件
  Widget _buildAvatar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Widget avatar;
    if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      avatar = CachedImage(
        imageUrl: avatarUrl!,
        width: size,
        height: size,
        isCircular: true,
        placeholderColor: placeholderColor ?? colorScheme.surfaceVariant,
        memCacheWidth: memCacheWidth ?? size.toInt(),
        memCacheHeight: memCacheHeight ?? size.toInt(),
      );
    } else {
      // 默认头像，使用回退参数
      avatar = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color:
              fallbackBackgroundColor ??
              placeholderColor ??
              colorScheme.surfaceVariant,
          shape: BoxShape.circle,
        ),
        child: Icon(
          fallbackIcon ?? Icons.person,
          size: size * 0.5,
          color: fallbackIconColor ?? colorScheme.onSurfaceVariant,
        ),
      );
    }

    // 添加边框
    if (borderWidth > 0 && borderColor != null) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor!, width: borderWidth),
        ),
        child: avatar,
      );
    }

    return avatar;
  }

  /// 构建带在线状态的头像
  Widget _buildWithOnlineStatus(Widget avatar, ColorScheme colorScheme) {
    final onlineIndicatorSize = size * 0.25;

    return Stack(
      children: [
        avatar,
        if (isOnline)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: onlineIndicatorSize,
              height: onlineIndicatorSize,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: colorScheme.background, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  /// 构建带认证标识的头像
  Widget _buildWithVerifiedBadge(Widget avatar, ColorScheme colorScheme) {
    final badgeSize = size * 0.3;

    return Stack(
      children: [
        avatar,
        Positioned(
          right: verifiedBadgeAlignment == Alignment.bottomRight ? 0 : null,
          left: verifiedBadgeAlignment == Alignment.bottomLeft ? 0 : null,
          bottom: 0,
          child: Container(
            width: badgeSize,
            height: badgeSize,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: colorScheme.background, width: 2),
            ),
            child: Icon(
              Icons.check,
              size: badgeSize * 0.6,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  /// 跳转到用户主页
  void _navigateToUserProfile(BuildContext context) {
    if (userId != null) {
      final path = RoutePaths.userProfile.replaceFirst(
        ':username',
        Uri.encodeComponent(userId!),
      );
      context.push(path);
    }
  }
}

/// 用户头像组组件
///
/// 用于展示多个用户头像（如群组成员、共同点赞用户等）
class UserAvatarGroup extends StatelessWidget {
  /// 用户头像 URL 列表
  final List<String> avatarUrls;

  /// 头像尺寸
  final double size;

  /// 最大显示数量
  final int maxCount;

  /// 重叠偏移量
  final double overlap;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  ///
  /// [avatarUrls] 头像 URL 列表（必填）
  /// [size] 头像尺寸，默认 40
  /// [maxCount] 最大显示数量，默认 4
  /// [overlap] 重叠偏移量，默认 0.3（30% 重叠）
  /// [onTap] 点击回调
  const UserAvatarGroup({
    super.key,
    required this.avatarUrls,
    this.size = 40,
    this.maxCount = 4,
    this.overlap = 0.3,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final displayUrls = avatarUrls.take(maxCount).toList();
    final remainingCount = avatarUrls.length - maxCount;
    final itemWidth = size * (1 - overlap);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width:
            itemWidth * (displayUrls.length - 1) +
            size +
            (remainingCount > 0 ? itemWidth : 0),
        height: size,
        child: Stack(
          children: [
            for (int i = 0; i < displayUrls.length; i++)
              Positioned(
                left: i * itemWidth,
                child: UserAvatar(
                  avatarUrl: displayUrls[i],
                  size: size,
                  borderColor: colorScheme.background,
                  borderWidth: 2,
                ),
              ),
            if (remainingCount > 0)
              Positioned(
                left: displayUrls.length * itemWidth,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    shape: BoxShape.circle,
                    border: Border.all(color: colorScheme.background, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      '+$remainingCount',
                      style: TextStyle(
                        fontSize: size * 0.3,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
