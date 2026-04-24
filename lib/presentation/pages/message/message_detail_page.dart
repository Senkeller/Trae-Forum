import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';

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

  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  String get _title {
    switch (widget.type) {
      case 'reply':
        return '回复我的';
      case 'like':
        return '收到的赞';
      case 'mention':
        return '@我的';
      case 'follow':
        return '新增关注';
      case 'system':
        return '系统消息';
      default:
        return '消息详情';
    }
  }

  Future<void> _loadMessages() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      setState(() {
        _isLoading = false;
        _messages = [];
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
    await _loadMessages();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && _messages.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadMessages,
      );
    }

    if (_messages.isEmpty) {
      return _StateView(
        icon: _getEmptyIcon(),
        title: '暂无$_title',
        message: _getEmptyMessage(),
      );
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: _hasMore,
      onRefresh: _onRefresh,
      onLoading: _hasMore ? _onLoading : null,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[index];
          return _MessageCard(
            message: message,
            messageType: widget.type,
            onTap: () => _handleMessageTap(message),
          );
        },
      ),
    );
  }

  IconData _getEmptyIcon() {
    switch (widget.type) {
      case 'reply':
        return Icons.reply_outlined;
      case 'like':
        return Icons.thumb_up_outlined;
      case 'mention':
        return Icons.alternate_email;
      case 'follow':
        return Icons.person_add_outlined;
      case 'system':
        return Icons.notifications_outlined;
      default:
        return Icons.inbox_outlined;
    }
  }

  String _getEmptyMessage() {
    switch (widget.type) {
      case 'reply':
        return '暂无回复通知';
      case 'like':
        return '暂无赞通知';
      case 'mention':
        return '暂无@通知';
      case 'follow':
        return '暂无新增关注';
      case 'system':
        return '暂无系统消息';
      default:
        return '暂无消息';
    }
  }

  void _handleMessageTap(Map<String, dynamic> message) {
    final topicId = message['topicId']?.toString();
    if (topicId != null && topicId.isNotEmpty) {
      context.push(RoutePaths.feedDetail.replaceFirst(':id', topicId));
    }
  }
}

class _MessageCard extends StatelessWidget {
  final Map<String, dynamic> message;
  final String messageType;
  final VoidCallback onTap;

  const _MessageCard({
    required this.message,
    required this.messageType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final username = message['username']?.toString() ?? '';
    final avatarUrl = message['avatarUrl']?.toString() ?? '';
    final content = message['content']?.toString() ?? '';
    final time = message['time']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 22,
                backgroundImage: avatarUrl.isNotEmpty
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl.isEmpty
                    ? const Icon(Icons.person, size: 22)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '@$username',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: colorScheme.primary,
                              ),
                        ),
                        const Spacer(),
                        Text(
                          time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                    if (content.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        content,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildTypeChip(context),
                        const Spacer(),
                        const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    String label;
    IconData icon;

    switch (messageType) {
      case 'reply':
        label = '回复';
        icon = Icons.reply;
        break;
      case 'like':
        label = '赞';
        icon = Icons.thumb_up;
        break;
      case 'mention':
        label = '@';
        icon = Icons.alternate_email;
        break;
      case 'follow':
        label = '关注';
        icon = Icons.person_add;
        break;
      case 'system':
        label = '系统';
        icon = Icons.notifications;
        break;
      default:
        label = '消息';
        icon = Icons.message;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.primary,
                ),
          ),
        ],
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
