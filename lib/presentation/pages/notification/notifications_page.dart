import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../data/models/discourse/discourse_notification.dart';
import '../../providers/auth_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/user/user_avatar.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationNotifierProvider.notifier).loadNotifications();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(notificationNotifierProvider.notifier).loadMoreNotifications();
    }
  }

  Future<void> _onRefresh() async {
    await HapticFeedbackUtil.trigger(ref, HapticScene.refresh);
    await ref
        .read(notificationNotifierProvider.notifier)
        .refreshNotifications();
    _refreshController.refreshCompleted();
    await HapticFeedbackUtil.trigger(ref, HapticScene.refreshDone);
  }

  Future<void> _markAsRead(int notificationId) async {
    await HapticFeedbackUtil.trigger(ref, HapticScene.message);
    await ref
        .read(notificationNotifierProvider.notifier)
        .markAsRead(notificationId);
  }

  Future<void> _markAllAsRead() async {
    await HapticFeedbackUtil.trigger(ref, HapticScene.message);
    await ref.read(notificationNotifierProvider.notifier).markAsRead();
  }

  void _handleNotificationTap(DiscourseNotification notification) {
    HapticFeedbackUtil.trigger(ref, HapticScene.message);
    if (!notification.read) {
      ref
          .read(notificationNotifierProvider.notifier)
          .markAsRead(notification.id);
    }

    if (notification.topicId != null) {
      final path = '/feed/${notification.topicId}';
      if (notification.postNumber != null && notification.postNumber! > 1) {
        context.push('$path?postNumber=${notification.postNumber}');
      } else {
        context.push(path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;
    final notificationState = ref.watch(notificationNotifierProvider);

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('通知')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.account_circle_outlined, size: 56),
              const SizedBox(height: 16),
              const Text('未登录'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.push(RoutePaths.login),
                child: const Text('去登录'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: notificationState.notifications.isNotEmpty
                ? _markAllAsRead
                : null,
            tooltip: '全部标为已读',
          ),
        ],
      ),
      body: _buildBody(notificationState),
    );
  }

  Widget _buildBody(NotificationState notificationState) {
    if (notificationState.isLoading &&
        notificationState.notifications.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (notificationState.errorMessage != null &&
        notificationState.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 56),
            const SizedBox(height: 16),
            Text(notificationState.errorMessage!),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                ref
                    .read(notificationNotifierProvider.notifier)
                    .loadNotifications();
              },
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (notificationState.notifications.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.notifications_outlined, size: 56),
            SizedBox(height: 16),
            Text('暂无通知'),
          ],
        ),
      );
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: notificationState.hasMore,
      onRefresh: _onRefresh,
      onLoading: notificationState.hasMore
          ? () {
              ref
                  .read(notificationNotifierProvider.notifier)
                  .loadMoreNotifications();
              _refreshController.loadComplete();
            }
          : null,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount:
            notificationState.notifications.length +
            (notificationState.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= notificationState.notifications.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final notification = notificationState.notifications[index];
          return _NotificationCard(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
            onMarkAsRead: () => _markAsRead(notification.id),
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final DiscourseNotification notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnread = !notification.read;

    final avatarUrl = notification.actingUserAvatarTemplate != null
        ? DiscourseImageUrlResolver.resolveAvatarUrl(
            notification.actingUserAvatarTemplate!,
            size: 96,
          )
        : null;

    final iconData = _getIconData();
    final iconColor = _getIconColor();

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isUnread
          ? colorScheme.primaryContainer.withValues(alpha: 0.3)
          : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  UserAvatar(
                    avatarUrl: avatarUrl,
                    size: 48,
                    fallbackIcon: iconData,
                    fallbackBackgroundColor: iconColor.withValues(alpha: 0.2),
                    fallbackIconColor: iconColor,
                  ),
                  if (isUnread)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: colorScheme.surface,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildTypeChip(context),
                        const Spacer(),
                        Text(
                          _formatTime(notification.createdAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getContent(),
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (notification.topicTitle != null ||
                        notification.fancyTitle != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colorScheme.surfaceContainerHighest.withValues(
                            alpha: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.article_outlined,
                              size: 16,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                notification.topicTitle ??
                                    notification.fancyTitle ??
                                    '相关内容',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (!isUnread)
                IconButton(
                  icon: const Icon(Icons.check_circle_outline, size: 20),
                  onPressed: onMarkAsRead,
                  tooltip: '标为已读',
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIconData() {
    final iconName = DiscourseNotificationType.getTypeIcon(
      notification.notificationType,
    );
    return _getIconFromName(iconName);
  }

  Color _getIconColor() {
    final colorHex = DiscourseNotificationType.getTypeColor(
      notification.notificationType,
    );
    return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
  }

  IconData _getIconFromName(String iconName) {
    switch (iconName) {
      case 'alternate_email':
        return Icons.alternate_email;
      case 'comment':
        return Icons.comment;
      case 'format_quote':
        return Icons.format_quote;
      case 'favorite':
        return Icons.favorite;
      case 'emoji_emotions':
        return Icons.emoji_emotions;
      case 'edit':
        return Icons.edit;
      case 'mail':
        return Icons.mail;
      case 'move':
        return Icons.move_up;
      case 'link':
        return Icons.link;
      case 'emoji_events':
        return Icons.emoji_events;
      case 'visibility':
        return Icons.visibility;
      case 'alarm':
        return Icons.alarm;
      case 'check_circle':
        return Icons.check_circle;
      case 'person_add':
        return Icons.person_add;
      case 'how_to_vote':
        return Icons.how_to_vote;
      case 'chat':
        return Icons.chat;
      case 'assignment_ind':
        return Icons.assignment_ind;
      case 'person':
        return Icons.person;
      case 'new_releases':
        return Icons.new_releases;
      case 'warning':
        return Icons.warning;
      default:
        return Icons.notifications;
    }
  }

  Widget _buildTypeChip(BuildContext context) {
    final typeName = DiscourseNotificationType.getTypeName(
      notification.notificationType,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        typeName,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  String _getContent() {
    final typeName = DiscourseNotificationType.getTypeName(
      notification.notificationType,
    );
    final username =
        notification.actingUserName ?? notification.displayUsername ?? '用户';

    switch (notification.notificationType) {
      case DiscourseNotificationType.mentioned:
      case DiscourseNotificationType.groupMentioned:
        return '$username 在话题中提到了你';
      case DiscourseNotificationType.replied:
        return '$username 回复了你的帖子';
      case DiscourseNotificationType.quoted:
        return '$username 引用了你的内容';
      case DiscourseNotificationType.liked:
      case DiscourseNotificationType.likedConsolidated:
        final count = notification.data?.count ?? 1;
        return count > 1 ? '等$count人赞了你' : '$username 赞了你';
      case DiscourseNotificationType.reaction:
        return '$username 对你的内容做出了回应';
      case DiscourseNotificationType.grantedBadge:
        return '你获得了徽章：${notification.data?.badgeName ?? ''}';
      default:
        return username == '用户' ? typeName : '$username $typeName';
    }
  }

  String _formatTime(String? timeString) {
    if (timeString == null || timeString.isEmpty) {
      return '';
    }

    try {
      final dateTime = DateTime.parse(timeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return '刚刚';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes}分钟前';
      } else if (difference.inDays < 1) {
        return '${difference.inHours}小时前';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}天前';
      } else {
        return DateFormat('MM-dd').format(dateTime);
      }
    } catch (e) {
      return timeString;
    }
  }
}
