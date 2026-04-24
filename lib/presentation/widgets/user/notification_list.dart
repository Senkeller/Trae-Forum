import 'package:flutter/material.dart';

/// 通知项数据模型
class NotificationItemData {
  /// 通知ID
  final String id;

  /// 图标
  final IconData icon;

  /// 图标背景颜色
  final Color iconBackgroundColor;

  /// 图标颜色
  final Color iconColor;

  /// 通知标题
  final String title;

  /// 未读数量
  final int unreadCount;

  /// 点击回调
  final VoidCallback? onTap;

  const NotificationItemData({
    required this.id,
    required this.icon,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.title,
    this.unreadCount = 0,
    this.onTap,
  });
}

/// 消息通知列表组件
///
/// 展示各类消息通知入口，如@我的动态、@我的评论、我收到的赞等
/// 支持自定义图标、颜色、未读数量显示
class NotificationList extends StatelessWidget {
  /// 通知列表
  final List<NotificationItemData> items;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 项间距
  final double itemSpacing;

  /// 是否显示分隔线
  final bool showDivider;

  /// 卡片圆角
  final double borderRadius;

  /// 卡片背景色
  final Color? backgroundColor;

  const NotificationList({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.itemSpacing = 8,
    this.showDivider = false,
    this.borderRadius = 12,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveBackgroundColor = backgroundColor ??
        (colorScheme.brightness == Brightness.light
            ? Colors.white
            : colorScheme.surface);

    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < items.length; i++) ...[
              if (i > 0 && showDivider)
                Divider(
                  height: 1,
                  indent: 64,
                  endIndent: 16,
                  color: colorScheme.outline.withValues(alpha: 0.3),
                ),
              _NotificationItem(
                data: items[i],
                isLast: i == items.length - 1,
                borderRadius: borderRadius,
              ),
              if (i < items.length - 1 && !showDivider)
                SizedBox(height: itemSpacing),
            ],
          ],
        ),
      ),
    );
  }
}

/// 单个通知项组件
class _NotificationItem extends StatelessWidget {
  final NotificationItemData data;
  final bool isLast;
  final double borderRadius;

  const _NotificationItem({
    required this.data,
    required this.isLast,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(data.id == 'first' ? borderRadius : 0),
          bottom: Radius.circular(isLast ? borderRadius : 0),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // 图标容器
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: data.iconBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  data.icon,
                  color: data.iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              // 标题
              Expanded(
                child: Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
              // 未读数量或箭头
              if (data.unreadCount > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    data.unreadCount > 99 ? '99+' : '${data.unreadCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                Icon(
                  Icons.chevron_right,
                  color: colorScheme.onSurfaceVariant,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 预定义的通知项配置
class NotificationPresets {
  /// @我的动态
  static NotificationItemData mentionMe({
    VoidCallback? onTap,
    int unreadCount = 0,
  }) =>
      NotificationItemData(
        id: 'mention_me',
        icon: Icons.alternate_email,
        iconBackgroundColor: const Color(0xFFE3F2FD),
        iconColor: const Color(0xFF2196F3),
        title: '@我的动态',
        unreadCount: unreadCount,
        onTap: onTap,
      );

  /// @我的评论
  static NotificationItemData mentionComment({
    VoidCallback? onTap,
    int unreadCount = 0,
  }) =>
      NotificationItemData(
        id: 'mention_comment',
        icon: Icons.chat_bubble_outline,
        iconBackgroundColor: const Color(0xFFE0F7FA),
        iconColor: const Color(0xFF00BCD4),
        title: '@我的评论',
        unreadCount: unreadCount,
        onTap: onTap,
      );

  /// 我收到的赞
  static NotificationItemData receivedLikes({
    VoidCallback? onTap,
    int unreadCount = 0,
  }) =>
      NotificationItemData(
        id: 'received_likes',
        icon: Icons.thumb_up_outlined,
        iconBackgroundColor: const Color(0xFFE8F5E9),
        iconColor: const Color(0xFF4CAF50),
        title: '我收到的赞',
        unreadCount: unreadCount,
        onTap: onTap,
      );

  /// 好友关注
  static NotificationItemData friendFollow({
    VoidCallback? onTap,
    int unreadCount = 0,
  }) =>
      NotificationItemData(
        id: 'friend_follow',
        icon: Icons.person_add_outlined,
        iconBackgroundColor: const Color(0xFFFFF3E0),
        iconColor: const Color(0xFFFF9800),
        title: '好友关注',
        unreadCount: unreadCount,
        onTap: onTap,
      );

  /// 系统通知
  static NotificationItemData systemNotification({
    VoidCallback? onTap,
    int unreadCount = 0,
  }) =>
      NotificationItemData(
        id: 'system_notification',
        icon: Icons.notifications_outlined,
        iconBackgroundColor: const Color(0xFFF3E5F5),
        iconColor: const Color(0xFF9C27B0),
        title: '系统通知',
        unreadCount: unreadCount,
        onTap: onTap,
      );

  /// 私信消息
  static NotificationItemData privateMessage({
    VoidCallback? onTap,
    int unreadCount = 0,
  }) =>
      NotificationItemData(
        id: 'private_message',
        icon: Icons.mail_outline,
        iconBackgroundColor: const Color(0xFFFCE4EC),
        iconColor: const Color(0xFFE91E63),
        title: '私信消息',
        unreadCount: unreadCount,
        onTap: onTap,
      );
}

/// 用户资料卡片组件
///
/// 展示用户头像、昵称、简介和统计数据
class UserProfileCard extends StatelessWidget {
  /// 用户头像URL
  final String? avatarUrl;

  /// 用户名
  final String username;

  /// 用户昵称
  final String? nickname;

  /// 用户简介
  final String? bio;

  /// 动态数量
  final int feedCount;

  /// 关注数量
  final int followCount;

  /// 粉丝数量
  final int fansCount;

  /// 点击头像回调
  final VoidCallback? onAvatarTap;

  /// 点击编辑资料回调
  final VoidCallback? onEditProfile;

  /// 点击统计项回调
  final Function(int index)? onStatTap;

  const UserProfileCard({
    super.key,
    this.avatarUrl,
    required this.username,
    this.nickname,
    this.bio,
    this.feedCount = 0,
    this.followCount = 0,
    this.fansCount = 0,
    this.onAvatarTap,
    this.onEditProfile,
    this.onStatTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // 头像和统计
          Row(
            children: [
              // 头像
              GestureDetector(
                onTap: onAvatarTap,
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipOval(
                    child: avatarUrl != null && avatarUrl!.isNotEmpty
                        ? Image.network(
                            avatarUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildDefaultAvatar(colorScheme),
                          )
                        : _buildDefaultAvatar(colorScheme),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              // 统计数据
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatItem('动态', feedCount, 0, colorScheme, textTheme),
                    _buildStatItem('关注', followCount, 1, colorScheme, textTheme),
                    _buildStatItem('粉丝', fansCount, 2, colorScheme, textTheme),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 用户名和简介
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nickname ?? username,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (bio != null && bio!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    bio!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),
          // 编辑资料按钮
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onEditProfile,
              icon: const Icon(Icons.edit, size: 18),
              label: const Text('编辑资料'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建默认头像
  Widget _buildDefaultAvatar(ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.person,
        size: 36,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// 构建统计项
  Widget _buildStatItem(
    String label,
    int count,
    int index,
    ColorScheme colorScheme,
    TextTheme textTheme,
  ) {
    return InkWell(
      onTap: onStatTap != null ? () => onStatTap!(index) : null,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Text(
              _formatCount(count),
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 格式化数字（超过1000显示为1k）
  String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

/// 未登录状态卡片
class UnauthenticatedCard extends StatelessWidget {
  /// 登录按钮文字
  final String loginText;

  /// 登录按钮点击回调
  final VoidCallback onLoginTap;

  /// 提示文字
  final String? hintText;

  const UnauthenticatedCard({
    super.key,
    this.loginText = '点击登录',
    required this.onLoginTap,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 默认头像占位
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surfaceContainerHighest,
              border: Border.all(
                color: colorScheme.outline.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.person_outline,
              size: 40,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          if (hintText != null) ...[
            Text(
              hintText!,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
          // 登录按钮
          SizedBox(
            width: 160,
            height: 44,
            child: FilledButton(
              onPressed: onLoginTap,
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: Text(
                loginText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
