import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../config/constants.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../data/models/discourse/discourse_notification.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/common/empty_widget.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/user/user_avatar.dart';

/// 消息列表页
///
/// 展示各类消息通知，包括：
/// - 所有通知
/// - 回复（提及、引用、回复）
/// - 赞（点赞、表情回应）
/// - 私信
/// - 书签
/// - 聊天
/// - 其他通知
class MessagePage extends ConsumerStatefulWidget {
  /// 构造函数
  const MessagePage({super.key});

  @override
  ConsumerState<MessagePage> createState() => _MessagePageState();
}

/// 消息页面状态
class _MessagePageState extends ConsumerState<MessagePage>
    with SingleTickerProviderStateMixin {
  /// Tab 控制器
  late TabController _tabController;

  /// 筛选类型列表
  final List<NotificationFilterType> _filterTypes = [
    NotificationFilterType.all,
    NotificationFilterType.replies,
    NotificationFilterType.likes,
    NotificationFilterType.messages,
    NotificationFilterType.bookmarks,
    NotificationFilterType.chat,
    NotificationFilterType.others,
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _filterTypes.length,
      vsync: this,
    );
    
    // 初始化时加载通知
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationNotifierProvider.notifier).loadNotifications();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final notificationState = ref.watch(notificationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('消息'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: '全部已读',
            onPressed: () {
              _showMarkAllReadDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: '消息设置',
            onPressed: () {
              // TODO: 跳转到消息设置页面
              context.push('/settings/notifications');
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          tabs: _filterTypes.map((type) {
            final unreadCount = _getUnreadCountForType(type, notificationState);
            return Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(type.displayName),
                  if (unreadCount > 0)
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '$unreadCount',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }).toList(),
          onTap: (index) {
            final type = _filterTypes[index];
            ref.read(notificationNotifierProvider.notifier).switchFilterType(type);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _filterTypes.map((type) {
          return _NotificationList(filterType: type);
        }).toList(),
      ),
    );
  }

  /// 获取指定类型的未读数量
  int _getUnreadCountForType(NotificationFilterType type, NotificationState state) {
    if (type == NotificationFilterType.all) {
      return state.unreadCount;
    }
    // 其他类型的未读数需要从通知列表中筛选计算
    return state.notifications
        .where((n) => !n.read && _isNotificationMatchType(n.notificationType, type))
        .length;
  }

  /// 判断通知是否匹配筛选类型
  bool _isNotificationMatchType(int notificationType, NotificationFilterType filterType) {
    switch (filterType) {
      case NotificationFilterType.replies:
        return [
          DiscourseNotificationType.mentioned,
          DiscourseNotificationType.groupMentioned,
          DiscourseNotificationType.posted,
          DiscourseNotificationType.quoted,
          DiscourseNotificationType.replied,
        ].contains(notificationType);
      case NotificationFilterType.likes:
        return [
          DiscourseNotificationType.liked,
          DiscourseNotificationType.likedConsolidated,
          DiscourseNotificationType.reaction,
        ].contains(notificationType);
      case NotificationFilterType.chat:
        return [
          DiscourseNotificationType.chatInvitation,
          DiscourseNotificationType.chatMention,
          DiscourseNotificationType.chatMessage,
          DiscourseNotificationType.chatQuoted,
          DiscourseNotificationType.chatWatchedThread,
          DiscourseNotificationType.chatGroupMention,
        ].contains(notificationType);
      default:
        return false;
    }
  }

  /// 显示全部已读确认对话框
  void _showMarkAllReadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('标记全部已读'),
        content: const Text('确定要将所有消息标记为已读吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop();
              ref.read(notificationNotifierProvider.notifier).markAsRead();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

/// 通知列表
class _NotificationList extends ConsumerStatefulWidget {
  final NotificationFilterType filterType;

  const _NotificationList({required this.filterType});

  @override
  ConsumerState<_NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends ConsumerState<_NotificationList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
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

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationNotifierProvider);

    // 如果当前筛选类型不匹配，显示加载状态
    if (notificationState.filterType != widget.filterType) {
      return const Center(child: CircularProgressIndicator());
    }

    // 加载中状态
    if (notificationState.isLoading && notificationState.notifications.isEmpty) {
      return const Center(child: LoadingWidget());
    }

    // 错误状态
    if (notificationState.errorMessage != null &&
        notificationState.notifications.isEmpty) {
      return ErrorWidgetWithRetry(
        message: notificationState.errorMessage!,
        onRetry: () {
          ref.read(notificationNotifierProvider.notifier).loadNotifications();
        },
      );
    }

    // 空状态
    if (notificationState.notifications.isEmpty) {
      return EmptyWidget(
        icon: Icons.notifications_none,
        title: '暂无通知',
        description: widget.filterType == NotificationFilterType.all
            ? '您还没有收到任何通知'
            : '暂无${widget.filterType.displayName}类型的通知',
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(notificationNotifierProvider.notifier).refreshNotifications();
      },
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
          return _NotificationItem(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
          );
        },
      ),
    );
  }

  void _handleNotificationTap(DiscourseNotification notification) {
    // 标记为已读
    if (!notification.read) {
      ref.read(notificationNotifierProvider.notifier).markAsRead(notification.id);
    }

    // 跳转到对应页面
    _navigateToNotificationDetail(notification);
  }

  void _navigateToNotificationDetail(DiscourseNotification notification) {
    if (notification.topicId != null) {
      final path = '/feed/${notification.topicId}';
      if (notification.postNumber != null && notification.postNumber! > 1) {
        context.push('$path?postNumber=${notification.postNumber}');
      } else {
        context.push(path);
      }
    }
  }
}

/// 通知项
class _NotificationItem extends StatelessWidget {
  final DiscourseNotification notification;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnread = !notification.read;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnread
              ? colorScheme.primaryContainer.withOpacity(0.2)
              : null,
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withOpacity(0.2),
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 发送者头像
            _buildAvatar(colorScheme),
            const SizedBox(width: 12),
            // 消息内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _getTitle(),
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                      Text(
                        _formatTime(notification.createdAt),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getContent(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // 相关内容预览
                  if (notification.topicTitle != null ||
                      notification.fancyTitle != null)
                    _buildTopicPreview(theme, colorScheme),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(ColorScheme colorScheme) {
    final avatarUrl = notification.actingUserAvatarTemplate != null
        ? DiscourseImageUrlResolver.resolveAvatarUrl(
            notification.actingUserAvatarTemplate!,
            size: 96,
          )
        : null;

    final iconData = _getIconData();
    final iconColor = _getIconColor(colorScheme);

    return Stack(
      children: [
        UserAvatar(
          avatarUrl: avatarUrl,
          size: 48,
          fallbackIcon: iconData,
          fallbackBackgroundColor: iconColor.withOpacity(0.2),
          fallbackIconColor: iconColor,
        ),
        if (!notification.read)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 12,
              height: 12,
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
    );
  }

  Widget _buildTopicPreview(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
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
    );
  }

  IconData _getIconData() {
    final iconName = DiscourseNotificationType.getTypeIcon(
      notification.notificationType,
    );
    return _getIconFromName(iconName);
  }

  Color _getIconColor(ColorScheme colorScheme) {
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

  String _getTitle() {
    final typeName = DiscourseNotificationType.getTypeName(
      notification.notificationType,
    );
    final username = notification.actingUserName ??
        notification.displayUsername ??
        '用户';
    return '$username $typeName了你';
  }

  String _getContent() {
    // 根据通知类型返回不同的内容描述
    switch (notification.notificationType) {
      case DiscourseNotificationType.mentioned:
      case DiscourseNotificationType.groupMentioned:
        return '在话题中提到了你';
      case DiscourseNotificationType.replied:
        return '回复了你的帖子';
      case DiscourseNotificationType.quoted:
        return '引用了你的内容';
      case DiscourseNotificationType.liked:
      case DiscourseNotificationType.likedConsolidated:
        final count = notification.data?.count ?? 1;
        return count > 1 ? '等$count人赞了你' : '赞了你';
      case DiscourseNotificationType.reaction:
        return '对你的内容做出了回应';
      case DiscourseNotificationType.grantedBadge:
        return '你获得了徽章：${notification.data?.badgeName ?? ''}';
      default:
        return '点击查看详情';
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
