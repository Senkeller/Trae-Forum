import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/scroll_load_guard.dart';
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
  /// 初始筛选类型（通过 URL query 参数传入）
  final String? initialFilter;

  /// 构造函数
  const MessagePage({super.key, this.initialFilter});

  @override
  ConsumerState<MessagePage> createState() => _MessagePageState();
}

/// 消息页面状态
class _MessagePageState extends ConsumerState<MessagePage>
    with SingleTickerProviderStateMixin {
  /// Tab 控制器
  late TabController _tabController;
  bool _initialFilterApplied = false;

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
    _tabController = TabController(length: _filterTypes.length, vsync: this);
    _tabController.addListener(_handleTabChange);

    // 初始化时加载通知
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(notificationNotifierProvider.notifier).loadNotifications();
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_initialFilterApplied) return;

    // 优先使用 widget 传入的 initialFilter，其次从 URL 解析
    final filterQuery = widget.initialFilter ??
        GoRouterState.of(context).uri.queryParameters['filter'];
    final initialFilter = notificationFilterTypeFromQuery(filterQuery);
    if (initialFilter == NotificationFilterType.all) {
      _initialFilterApplied = true;
      return;
    }

    final initialIndex = _filterTypes.indexOf(initialFilter);
    if (initialIndex > 0) {
      _tabController.index = initialIndex;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref
            .read(notificationNotifierProvider.notifier)
            .switchFilterType(initialFilter);
      });
    }
    _initialFilterApplied = true;
  }

  /// 处理 Tab 切换事件
  ///
  /// 监听 TabController 的 index 变化，当用户点击或滑动切换 Tab 时触发
  /// 通过判断 indexIsChanging 避免重复触发，确保状态与 UI 一致
  void _handleTabChange() {
    // 当动画正在进行时跳过，避免重复触发
    if (_tabController.indexIsChanging) return;

    final type = _filterTypes[_tabController.index];
    final current = ref.read(currentNotificationFilterTypeProvider);

    // 如果当前类型与目标类型相同，无需切换
    if (current == type) return;

    // 触发触觉反馈
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);

    // 切换筛选类型并加载对应数据
    ref.read(notificationNotifierProvider.notifier).switchFilterType(type);
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
              context.push(RoutePaths.notificationSettings);
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
  int _getUnreadCountForType(
    NotificationFilterType type,
    NotificationState state,
  ) {
    if (type == NotificationFilterType.all) {
      return state.unreadCount;
    }
    return state.notifications
        .where(
          (n) => !n.read && type.matchesNotificationType(n.notificationType),
        )
        .length;
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
              HapticFeedbackUtil.trigger(ref, HapticScene.message);
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

  /// 滚动加载守卫，用于管理通知列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

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

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多通知。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _onScroll() {
    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        ref.read(notificationNotifierProvider.notifier).loadMoreNotifications();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final notificationState = ref.watch(notificationNotifierProvider);

    // 如果当前筛选类型不匹配，显示加载状态
    if (notificationState.filterType != widget.filterType) {
      return const Center(child: CircularProgressIndicator());
    }

    // 加载中状态
    if (notificationState.isLoading &&
        notificationState.notifications.isEmpty) {
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
        await HapticFeedbackUtil.trigger(ref, HapticScene.refresh);
        await ref
            .read(notificationNotifierProvider.notifier)
            .refreshNotifications();
        await HapticFeedbackUtil.trigger(ref, HapticScene.refreshDone);
      },
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
          return _NotificationItem(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
            onDelete: () => _handleDeleteNotification(notification.id),
            onMarkAsRead: () => _handleMarkAsRead(notification.id),
            onMarkAsUnread: () => _handleMarkAsUnread(notification.id),
          );
        },
      ),
    );
  }

  void _handleNotificationTap(DiscourseNotification notification) {
    HapticFeedbackUtil.trigger(ref, HapticScene.message);

    // 标记为已读
    if (!notification.read) {
      ref
          .read(notificationNotifierProvider.notifier)
          .markAsRead(notification.id);
    }

    // 跳转到对应页面
    _navigateToNotificationDetail(notification);
  }

  void _navigateToNotificationDetail(DiscourseNotification notification) {
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
          _openDiscourseTopic(notification.topicId!, notification.slug,
              postNumber: notification.postNumber,
              title: notification.topicTitle ?? notification.fancyTitle ?? '话题详情');
        } else {
          context.push('/messages');
        }
        return;

      // 普通话题通知
      default:
        if (notification.topicId != null) {
          _openDiscourseTopic(notification.topicId!, notification.slug,
              postNumber: notification.postNumber,
              title: notification.topicTitle ?? notification.fancyTitle ?? '话题详情');
        } else {
          // 如果没有 topicId，显示提示
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('无法跳转到该通知')),
          );
        }
    }
  }

  /// 使用 WebView 打开 Discourse 话题
  void _openDiscourseTopic(int topicId, String? slug, {int? postNumber, String? title}) {
    // 构建 Discourse 话题 URL
    // 格式: https://forum.trae.cn/t/{slug}/{topicId}/{postNumber}
    final baseUrl = 'https://forum.trae.cn';
    final topicSlug = slug ?? 'topic';
    String url = '$baseUrl/t/$topicSlug/$topicId';

    // 如果有特定楼层号，添加到 URL
    if (postNumber != null && postNumber > 1) {
      url = '$url/$postNumber';
    }

    // 使用 WebView 打开
    context.push(
      '/webview?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(title ?? '话题详情')}',
    );
  }

  void _handleDeleteNotification(int notificationId) {
    HapticFeedbackUtil.trigger(ref, HapticScene.message);
    ref
        .read(notificationNotifierProvider.notifier)
        .deleteNotification(notificationId);
  }

  void _handleMarkAsRead(int notificationId) {
    HapticFeedbackUtil.trigger(ref, HapticScene.message);
    ref.read(notificationNotifierProvider.notifier).markAsRead(notificationId);
  }

  void _handleMarkAsUnread(int notificationId) {
    HapticFeedbackUtil.trigger(ref, HapticScene.message);
    ref
        .read(notificationNotifierProvider.notifier)
        .markAsUnread(notificationId);
  }
}

/// 通知项
class _NotificationItem extends StatelessWidget {
  final DiscourseNotification notification;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onMarkAsRead;
  final VoidCallback? onMarkAsUnread;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
    this.onDelete,
    this.onMarkAsRead,
    this.onMarkAsUnread,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnread = !notification.read;

    // 使用 Dismissible 实现滑动删除
    Widget content = InkWell(
      onTap: onTap,
      onLongPress: () => _showContextMenu(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUnread
              ? colorScheme.primaryContainer.withOpacity(0.2)
              : null,
          border: Border(
            bottom: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
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
                            fontWeight: isUnread
                                ? FontWeight.bold
                                : FontWeight.normal,
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

    // 包裹在 Dismissible 中实现滑动删除
    if (onDelete != null) {
      content = Dismissible(
        key: ValueKey(notification.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          color: colorScheme.error,
          child: Icon(Icons.delete, color: colorScheme.onError),
        ),
        confirmDismiss: (direction) async {
          return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('删除通知'),
              content: const Text('确定要删除这条通知吗？'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('取消'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('删除'),
                ),
              ],
            ),
          );
        },
        onDismissed: (direction) {
          onDelete?.call();
        },
        child: content,
      );
    }

    return content;
  }

  /// 显示长按菜单
  void _showContextMenu(BuildContext context) {
    final isUnread = !notification.read;

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isUnread && onMarkAsRead != null)
              ListTile(
                leading: const Icon(Icons.mark_email_read),
                title: const Text('标记为已读'),
                onTap: () {
                  Navigator.of(context).pop();
                  onMarkAsRead?.call();
                },
              ),
            if (!isUnread && onMarkAsUnread != null)
              ListTile(
                leading: const Icon(Icons.mark_email_unread),
                title: const Text('标记为未读'),
                onTap: () {
                  Navigator.of(context).pop();
                  onMarkAsUnread?.call();
                },
              ),
            if (onDelete != null)
              ListTile(
                leading: Icon(
                  Icons.delete,
                  color: Theme.of(context).colorScheme.error,
                ),
                title: Text(
                  '删除',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  onDelete?.call();
                },
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
                border: Border.all(color: colorScheme.surface, width: 2),
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
              notification.topicTitle ?? notification.fancyTitle ?? '相关内容',
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
    final username = notification.actingUserName ??
        notification.displayUsername ??
        notification.data?.displayUsername ??
        '用户';
    final actionText = _getActionText(notification.notificationType);
    return '$username $actionText';
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

  String _getActionText(int notificationType) {
    switch (notificationType) {
      case DiscourseNotificationType.mentioned:
      case DiscourseNotificationType.groupMentioned:
        return '在话题中提到了你';
      case DiscourseNotificationType.replied:
        return '回复了你的帖子';
      case DiscourseNotificationType.posted:
        return '在话题中回复了';
      case DiscourseNotificationType.quoted:
        return '引用了你的内容';
      case DiscourseNotificationType.liked:
      case DiscourseNotificationType.likedConsolidated:
        final count = notification.data?.count ?? 1;
        return count > 1 ? '等$count人赞了你' : '赞了你';
      case DiscourseNotificationType.reaction:
        return '对你的内容做出了回应';
      case DiscourseNotificationType.grantedBadge:
        return '你获得了徽章';
      case DiscourseNotificationType.following:
        return '关注了你';
      case DiscourseNotificationType.followingCreatedTopic:
        return '发布了新话题';
      case DiscourseNotificationType.followingReplied:
        return '回复了话题';
      case DiscourseNotificationType.edited:
        return '编辑了你的帖子';
      case DiscourseNotificationType.invitedToPrivateMessage:
        return '邀请你加入私信';
      case DiscourseNotificationType.invitedToTopic:
        return '邀请你参与话题';
      case DiscourseNotificationType.linked:
      case DiscourseNotificationType.linkedConsolidated:
        return '链接了你的帖子';
      case DiscourseNotificationType.movedPost:
        return '移动了你的帖子';
      case DiscourseNotificationType.chatMention:
        return '在聊天中提到了你';
      case DiscourseNotificationType.chatMessage:
        return '发送了聊天消息';
      case DiscourseNotificationType.chatQuoted:
        return '在聊天中引用了你';
      case DiscourseNotificationType.chatInvitation:
        return '邀请你加入聊天';
      case DiscourseNotificationType.eventInvitation:
        return '邀请你参加活动';
      case DiscourseNotificationType.eventReminder:
        return '活动提醒';
      case DiscourseNotificationType.topicReminder:
        return '话题提醒';
      case DiscourseNotificationType.watchingFirstPost:
        return '首帖更新';
      case DiscourseNotificationType.postApproved:
        return '你的帖子已通过审核';
      case DiscourseNotificationType.membershipRequestAccepted:
        return '你的成员请求已被接受';
      case DiscourseNotificationType.assigned:
        return '分配给你';
      default:
        return '通知了你';
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
