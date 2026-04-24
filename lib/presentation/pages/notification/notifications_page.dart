import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';

class NotificationsPage extends ConsumerStatefulWidget {
  const NotificationsPage({super.key});

  @override
  ConsumerState<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends ConsumerState<NotificationsPage> {
  final RefreshController _refreshController = RefreshController();

  List<Map<String, dynamic>> _notifications = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _loadNotifications() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.uid.isEmpty) {
      setState(() {
        _errorMessage = '请先登录';
      });
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isLoading = false;
        _notifications = [];
        _hasMore = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '加载失败: $e';
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadNotifications();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    if (_isLoadingMore || !_hasMore) {
      _refreshController.loadComplete();
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoadingMore = false;
      _hasMore = false;
    });

    _refreshController.loadComplete();
  }

  Future<void> _markAsRead(String notificationId) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('标记已读功能开发中')),
    );
  }

  Future<void> _markAllAsRead() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('全部已读功能开发中')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('通知'),
        ),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可查看通知',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            onPressed: _notifications.isNotEmpty ? _markAllAsRead : null,
            tooltip: '全部标为已读',
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(RoutePaths.settings),
            tooltip: '通知设置',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _notifications.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && _notifications.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadNotifications,
      );
    }

    if (_notifications.isEmpty) {
      return _StateView(
        icon: Icons.notifications_outlined,
        title: '暂无通知',
        message: '还没有任何通知',
      );
    }

    final unreadCount = _notifications.where((n) => n['isRead'] != true).length;

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: _hasMore,
      onRefresh: _onRefresh,
      onLoading: _hasMore ? _onLoading : null,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _notifications.length + 1,
        itemBuilder: (context, index) {
          if (index == 0 && unreadCount > 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '未读通知 ($unreadCount)',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _markAllAsRead,
                    child: const Text('全部已读'),
                  ),
                ],
              ),
            );
          }

          final notificationIndex = index - (unreadCount > 0 ? 1 : 0);
          if (notificationIndex < 0) return const SizedBox.shrink();

          final notification = _notifications[notificationIndex];
          return _NotificationCard(
            notification: notification,
            onTap: () => _handleNotificationTap(notification),
            onMarkAsRead: () => _markAsRead(notification['id']?.toString() ?? ''),
          );
        },
      ),
    );
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    final topicId = notification['topicId']?.toString();
    if (topicId != null && topicId.isNotEmpty) {
      context.push(RoutePaths.feedDetail.replaceFirst(':id', topicId));
    }
  }
}

class _NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;
  final VoidCallback onMarkAsRead;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final username = notification['username']?.toString() ?? '';
    final avatarUrl = notification['avatarUrl']?.toString() ?? '';
    final content = notification['content']?.toString() ?? '';
    final time = notification['time']?.toString() ?? '';
    final isRead = notification['isRead'] == true;
    final type = notification['type']?.toString() ?? 'system';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isRead ? null : colorScheme.primaryContainer.withValues(alpha: 0.3),
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
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: avatarUrl.isNotEmpty
                        ? NetworkImage(avatarUrl)
                        : null,
                    child: avatarUrl.isEmpty
                        ? Icon(_getTypeIcon(type), size: 22)
                        : null,
                  ),
                  if (!isRead)
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
                        _buildTypeChip(context, type),
                        const Spacer(),
                        Text(
                          time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      content.isNotEmpty ? content : '通知内容',
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (!isRead)
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

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'reply':
        return Icons.reply;
      case 'like':
        return Icons.thumb_up;
      case 'mention':
        return Icons.alternate_email;
      case 'follow':
        return Icons.person_add;
      default:
        return Icons.notifications;
    }
  }

  Widget _buildTypeChip(BuildContext context, String type) {
    final colorScheme = Theme.of(context).colorScheme;

    String label;
    switch (type) {
      case 'reply':
        label = '回复';
        break;
      case 'like':
        label = '赞';
        break;
      case 'mention':
        label = '@';
        break;
      case 'follow':
        label = '关注';
        break;
      default:
        label = '通知';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.primary,
            ),
      ),
    );
  }
}

class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
