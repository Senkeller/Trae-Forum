import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants.dart';
import 'online_status_indicator.dart';

/// 用户等级枚举
enum UserLevel {
  /// 普通用户
  normal,

  /// VIP 用户
  vip,

  /// SVIP 用户
  svip,

  /// 管理员
  admin,

  /// 版主
  moderator,

  /// 官方账号
  official,
}

/// 用户等级配置
class UserLevelConfig {
  /// 等级标识颜色
  final Color badgeColor;

  /// 等级背景颜色
  final Color backgroundColor;

  /// 等级文字颜色
  final Color textColor;

  /// 等级显示文字
  final String label;

  /// 等级图标
  final IconData? icon;

  const UserLevelConfig({
    required this.badgeColor,
    required this.backgroundColor,
    required this.textColor,
    required this.label,
    this.icon,
  });

  /// 获取等级配置
  static UserLevelConfig getConfig(UserLevel level, ColorScheme colorScheme) {
    switch (level) {
      case UserLevel.normal:
        return UserLevelConfig(
          badgeColor: colorScheme.outline,
          backgroundColor: colorScheme.surfaceVariant,
          textColor: colorScheme.onSurfaceVariant,
          label: 'Lv1',
        );
      case UserLevel.vip:
        return const UserLevelConfig(
          badgeColor: Color(0xFFFFC107),
          backgroundColor: Color(0xFFFFF8E1),
          textColor: Color(0xFFFF8F00),
          label: 'VIP',
          icon: Icons.star,
        );
      case UserLevel.svip:
        return const UserLevelConfig(
          badgeColor: Color(0xFFE91E63),
          backgroundColor: Color(0xFFFCE4EC),
          textColor: Color(0xFFC2185B),
          label: 'SVIP',
          icon: Icons.diamond,
        );
      case UserLevel.admin:
        return const UserLevelConfig(
          badgeColor: Color(0xFFF44336),
          backgroundColor: Color(0xFFFFEBEE),
          textColor: Color(0xFFC62828),
          label: '管理员',
          icon: Icons.shield,
        );
      case UserLevel.moderator:
        return const UserLevelConfig(
          badgeColor: Color(0xFF4CAF50),
          backgroundColor: Color(0xFFE8F5E9),
          textColor: Color(0xFF2E7D32),
          label: '版主',
          icon: Icons.verified_user,
        );
      case UserLevel.official:
        return const UserLevelConfig(
          badgeColor: Color(0xFF2196F3),
          backgroundColor: Color(0xFFE3F2FD),
          textColor: Color(0xFF1565C0),
          label: '官方',
          icon: Icons.verified,
        );
    }
  }
}

/// 用户名显示组件
///
/// 支持以下功能：
/// - 显示用户名
/// - 显示用户等级标识
/// - 显示认证标识
/// - 自定义文字样式
/// - 点击跳转用户主页
class UserName extends StatelessWidget {
  /// 用户名
  final String username;

  /// 用户 ID（用于点击跳转）
  final String? userId;

  /// 用户等级
  final UserLevel level;

  /// 用户等级数值（如 Lv5 中的 5）
  final int? levelNumber;

  /// 是否显示等级标识
  final bool showLevel;

  /// 是否显示认证标识
  final bool showVerified;

  /// 是否认证用户
  final bool isVerified;

  /// 文字样式
  final TextStyle? style;

  /// 最大行数
  final int? maxLines;

  /// 文字溢出处理
  final TextOverflow? overflow;

  /// 点击回调
  final VoidCallback? onTap;

  /// 等级标识大小
  final double badgeSize;

  /// 是否显示在线状态
  final bool showOnlineStatus;

  /// 在线状态圆点大小
  final double onlineStatusDotSize;

  /// 构造函数
  ///
  /// [username] 用户名（必填）
  /// [userId] 用户 ID
  /// [level] 用户等级，默认 normal
  /// [levelNumber] 等级数值
  /// [showLevel] 是否显示等级标识，默认 true
  /// [showVerified] 是否显示认证标识，默认 false
  /// [isVerified] 是否认证用户，默认 false
  /// [style] 文字样式
  /// [maxLines] 最大行数，默认 1
  /// [overflow] 文字溢出处理，默认 ellipsis
  /// [onTap] 点击回调
  /// [badgeSize] 等级标识大小，默认 16
  /// [showOnlineStatus] 是否显示在线状态，默认 false
  /// [onlineStatusDotSize] 在线状态圆点大小，默认 6
  const UserName({
    super.key,
    required this.username,
    this.userId,
    this.level = UserLevel.normal,
    this.levelNumber,
    this.showLevel = true,
    this.showVerified = false,
    this.isVerified = false,
    this.style,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.onTap,
    this.badgeSize = 16,
    this.showOnlineStatus = false,
    this.onlineStatusDotSize = 6,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final defaultStyle =
        style ??
        textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground,
        );

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 用户名
        Flexible(
          child: Text(
            username,
            style: defaultStyle,
            maxLines: maxLines,
            overflow: overflow,
          ),
        ),
        // 在线状态
        if (showOnlineStatus) ...[
          const SizedBox(width: 6),
          OnlineStatusIndicator(
            username: username,
            style: OnlineStatusStyle.dotOnly,
            dotSize: onlineStatusDotSize,
          ),
        ],
        // 认证标识
        if (showVerified && isVerified) ...[
          const SizedBox(width: 4),
          _buildVerifiedBadge(colorScheme),
        ],
        // 等级标识
        if (showLevel && level != UserLevel.normal) ...[
          const SizedBox(width: 4),
          _buildLevelBadge(colorScheme),
        ],
      ],
    );

    if (onTap != null || userId != null) {
      content = GestureDetector(
        onTap: onTap ?? () => _navigateToUserProfile(context),
        child: content,
      );
    }

    return content;
  }

  /// 构建认证标识
  Widget _buildVerifiedBadge(ColorScheme colorScheme) {
    return Icon(Icons.verified, size: badgeSize, color: colorScheme.primary);
  }

  /// 构建等级标识
  Widget _buildLevelBadge(ColorScheme colorScheme) {
    final config = UserLevelConfig.getConfig(level, colorScheme);
    final label = levelNumber != null && level == UserLevel.normal
        ? 'Lv$levelNumber'
        : config.label;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: config.badgeColor, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (config.icon != null) ...[
            Icon(config.icon, size: badgeSize * 0.7, color: config.textColor),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: badgeSize * 0.65,
              fontWeight: FontWeight.w600,
              color: config.textColor,
            ),
          ),
        ],
      ),
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

/// 简洁版用户名组件
///
/// 用于需要简洁展示用户名的场景
class UserNameSimple extends StatelessWidget {
  /// 用户名
  final String username;

  /// 用户 ID
  final String? userId;

  /// 文字样式
  final TextStyle? style;

  /// 最大行数
  final int? maxLines;

  /// 文字溢出处理
  final TextOverflow? overflow;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  ///
  /// [username] 用户名（必填）
  /// [userId] 用户 ID
  /// [style] 文字样式
  /// [maxLines] 最大行数
  /// [overflow] 文字溢出处理
  /// [onTap] 点击回调
  const UserNameSimple({
    super.key,
    required this.username,
    this.userId,
    this.style,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final defaultStyle =
        style ??
        textTheme.bodyMedium?.copyWith(color: colorScheme.onBackground);

    Widget content = Text(
      username,
      style: defaultStyle,
      maxLines: maxLines,
      overflow: overflow,
    );

    if (onTap != null || userId != null) {
      content = GestureDetector(
        onTap: onTap ?? () => _navigateToUserProfile(context),
        child: content,
      );
    }

    return content;
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

/// 用户信息行组件
///
/// 用于同时展示用户名和其他信息（如时间、地点等）
class UserNameWithInfo extends StatelessWidget {
  /// 用户名
  final String username;

  /// 用户 ID
  final String? userId;

  /// 附加信息
  final String? info;

  /// 用户等级
  final UserLevel level;

  /// 是否显示等级
  final bool showLevel;

  /// 是否显示认证
  final bool showVerified;

  /// 是否认证用户
  final bool isVerified;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  ///
  /// [username] 用户名（必填）
  /// [userId] 用户 ID
  /// [info] 附加信息（如时间、地点）
  /// [level] 用户等级
  /// [showLevel] 是否显示等级
  /// [showVerified] 是否显示认证
  /// [isVerified] 是否认证用户
  /// [onTap] 点击回调
  const UserNameWithInfo({
    super.key,
    required this.username,
    this.userId,
    this.info,
    this.level = UserLevel.normal,
    this.showLevel = true,
    this.showVerified = false,
    this.isVerified = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap ?? () => _navigateToUserProfile(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          UserName(
            username: username,
            level: level,
            showLevel: showLevel,
            showVerified: showVerified,
            isVerified: isVerified,
          ),
          if (info != null) ...[
            const SizedBox(height: 2),
            Text(
              info!,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
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
