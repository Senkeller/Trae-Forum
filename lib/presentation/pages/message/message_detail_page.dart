import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:intl/intl.dart';

import '../../../config/constants.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../../data/models/discourse/discourse_notification.dart';
import '../../providers/auth_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/user/user_avatar.dart';

class MessageDetailPage extends ConsumerStatefulWidget {
  final String type;

  const MessageDetailPage({
    super.key,
    required this.type,
  });

  @override
  ConsumerState<MessageDetailPage> createState() => _MessageDetailPageState();
}

class _MessageDetailPageState extends ConsumerState<MessageDetailPage> {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理消息列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  NotificationFilterType? _filterType;

  @override
  void initState() {
    super.initState();
    _filterType = _parseFilterType(widget.type);
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_filterType != null) {
        ref.read(notificationNotifierProvider.notifier).switchFilterType(_filterType!);
      } else {
        ref.read(notificationNotifierProvider.notifier).loadNotifications();
      }
    });
  }

  @override
  void didUpdateWidget(covariant MessageDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type) {
      final newFilterType = _parseFilterType(widget.type);
      if (newFilterType != _filterType) {
        _filterType = newFilterType;
        if (_filterType != null) {
          ref.read(notificationNotifierProvider.notifier).switchFilterType(_filterType!);
        }
      }
    }
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  NotificationFilterType? _parseFilterType(String type) {
    switch (type) {
      case 'replies':
        return NotificationFilterType.replies;
      case 'likes':
        return NotificationFilterType.likes;
      case 'messages':
        return NotificationFilterType.messages;
      case 'bookmarks':
        return NotificationFilterType.bookmarks;
      case 'chat':
        return NotificationFilterType.chat;
      case 'others':
        return NotificationFilterType.others;
      default:
        return null;
    }
  }

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多消息。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _onScroll() {
    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        ref.read(notificationNotifierProvider.notifier).loadMoreNotifications();
      },
    );
  }

  String get _title {
    final filterType = _filterType;
    if (filterType == null) {
      return '消息详情';
    }
    return filterType.displayName;
  }

  Future<void> _onRefresh() async {
    if (_filterType != null) {
      ref.read(notificationNotifierProvider.notifier).switchFilterType(_filterType!);
      await Future.delayed(const Duration(milliseconds: 300));
    } else {
      await ref.read(notificationNotifierProvider.notifier).refreshNotifications();
    }
    _refreshController.refreshCompleted();
  }

  Future<void> _markAsRead(int notificationId) async {
    await ref.read(notificationNotifierProvider.notifier).markAsRead(notificationId);
  }

  Future<void> _markAllAsRead() async {
    await ref.read(notificationNotifierProvider.notifier).markAsRead();
  }

  void _handleNotificationTap(DiscourseNotification notification) {
    if (!notification.read) {
      ref.read(notificationNotifierProvider.notifier).markAsRead(notification.id);
    }

    // 根据通知类型跳转到不同页面
    switch (notification.notificationType) {
      // 聊天相关通知
      case DiscourseNotificationType.chatMessage:
      case DiscourseNotificationType.chatMention:
      case DiscourseNotificationType.chatQuoted:
      case DiscourseNotificationType.chatInvitation:
      case DiscourseNotificationType.chatWatchedThread:
      case DiscourseNotificationType.chatGroupMention:
        if (notification.data?.chatChannelId != null) {
          context.push('/chat/${notification.data!.chatChannelId}');
        } else {
          context.push('/chat');
        }
        return;

      // 私信相关通知
      case DiscourseNotificationType.invitedToPrivateMessage:
      case DiscourseNotificationType.inviteeAccepted:
        if (notification.topicId != null) {
          // 跳转到 Feed 详情页，Discourse topicId 映射为 Feed id
          context.push('/feed/${notification.topicId}');
        } else {
          context.push('/messages');
        }
        return;

      // 普通话题通知
      default:
        if (notification.topicId != null) {
          // 跳转到 Feed 详情页，Discourse topicId 映射为 Feed id
          context.push('/feed/${notification.topicId}');
        } else {
          // 如果没有 topicId，显示提示
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法跳转到该通知')),
          );
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
        appBar: AppBar(
          title: Text(_title),
        ),
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
        title: Text(_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: notificationState.notifications.isNotEmpty ? _markAllAsRead : null,
            tooltip: '全部已读',
          ),
        ],
      ),
      body: _buildBody(notificationState),
    );
  }

  Widget _buildBody(NotificationState notificationState) {
    if (notificationState.isLoading && notificationState.notifications.isEmpty) {
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
                if (_filterType != null) {
                  ref.read(notificationNotifierProvider.notifier).switchFilterType(_filterType!);
                } else {
                  ref.read(notificationNotifierProvider.notifier).loadNotifications();
                }
              },
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (notificationState.notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_getEmptyIcon(), size: 56),
            const SizedBox(height: 16),
            Text(_getEmptyMessage()),
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
              ref.read(notificationNotifierProvider.notifier).loadMoreNotifications();
              _refreshController.loadComplete();
            }
          : null,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: notificationState.notifications.length +
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
          return _MessageCard(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
            onMarkAsRead: () => _markAsRead(notification.id),
          );
        },
      ),
    );
  }

  IconData _getEmptyIcon() {
    switch (widget.type) {
      case 'replies':
        return Icons.reply_outlined;
      case 'likes':
        return Icons.thumb_up_outlined;
      case 'messages':
        return Icons.mail_outlined;
      case 'bookmarks':
        return Icons.bookmark_outlined;
      case 'chat':
        return Icons.chat_outlined;
      case 'others':
        return Icons.notifications_outlined;
      default:
        return Icons.inbox_outlined;
    }
  }

  String _getEmptyMessage() {
    switch (widget.type) {
      case 'replies':
        return '暂无回复通知';
      case 'likes':
        return '暂无赞通知';
      case 'messages':
        return '暂无私信';
      case 'bookmarks':
        return '暂无书签';
      case 'chat':
        return '暂无聊天消息';
      case 'others':
        return '暂无其他通知';
      default:
        return '暂无消息';
    }
  }
}

class _MessageCard extends StatelessWidget {
  final DiscourseNotification notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const _MessageCard({
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
      color: isUnread ? colorScheme.primaryContainer.withValues(alpha: 0.3) : null,
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
                          color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
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
                            const Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: Colors.grey,
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
        color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.5),
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
    // 显示话题标题
    final topicTitle = notification.topicTitle ?? notification.fancyTitle;
    if (topicTitle != null && topicTitle.isNotEmpty) {
      return topicTitle;
    }
    return '点击查看详情';
  }

  /// 去除HTML标签
  String _stripHtmlTags(String htmlText) {
    return htmlText
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .trim();
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
