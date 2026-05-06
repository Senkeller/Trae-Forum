import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../config/constants.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../../data/models/discourse/discourse_private_message.dart';
import '../../providers/private_message_provider.dart';
import '../../widgets/common/empty_widget.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/user/user_avatar.dart';

/// 私信会话列表页面
///
/// 展示用户的所有私信会话，支持：
/// - 查看会话列表
/// - 显示未读消息数
/// - 进入单一会话
/// - 创建新私信
/// - 删除会话
class ConversationListPage extends ConsumerStatefulWidget {
  const ConversationListPage({super.key});

  @override
  ConsumerState<ConversationListPage> createState() => _ConversationListPageState();
}

class _ConversationListPageState extends ConsumerState<ConversationListPage> {
  final ScrollController _scrollController = ScrollController();
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    // 初始化时加载会话列表
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(privateMessageConversationNotifierProvider.notifier).loadConversations();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 处理滚动事件，实现触底加载更多
  void _onScroll() {
    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        await ref.read(privateMessageConversationNotifierProvider.notifier).loadMoreConversations();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final state = ref.watch(privateMessageConversationNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('私信'),
        actions: [
          // 新建私信按钮
          IconButton(
            icon: const Icon(Icons.edit_note),
            tooltip: '新建私信',
            onPressed: () => context.push(RoutePaths.newConversation),
          ),
        ],
      ),
      body: _buildBody(context, state, colorScheme),
    );
  }

  Widget _buildBody(BuildContext context, PrivateMessageConversationState state, ColorScheme colorScheme) {
    // 加载中状态
    if (state.isLoading && state.conversations.isEmpty) {
      return const Center(child: LoadingWidget());
    }

    // 错误状态
    if (state.errorMessage != null && state.conversations.isEmpty) {
      return ErrorWidgetWithRetry(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(privateMessageConversationNotifierProvider.notifier).loadConversations();
        },
      );
    }

    // 空状态
    if (state.conversations.isEmpty) {
      return EmptyWidget(
        icon: Icons.mail_outline,
        title: '暂无私信',
        description: '您还没有收到任何私信\n点击右上角按钮开始新对话',
        buttonText: '发私信',
        onButtonPressed: () => context.push(RoutePaths.newConversation),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await HapticFeedbackUtil.trigger(ref, HapticScene.refresh);
        await ref.read(privateMessageConversationNotifierProvider.notifier).refreshConversations();
        await HapticFeedbackUtil.trigger(ref, HapticScene.refreshDone);
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.conversations.length + (state.isLoadingMore ? 1 : 0),
        cacheExtent: 200,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          if (index == state.conversations.length) {
            // 加载更多指示器
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
          }

          final conversation = state.conversations[index];
          return _ConversationItem(
            conversation: conversation,
            onTap: () => _openConversation(conversation),
            onLongPress: () => _showConversationOptions(context, conversation),
          );
        },
      ),
    );
  }

  /// 打开会话详情
  void _openConversation(PrivateMessageConversation conversation) {
    HapticFeedbackUtil.trigger(ref, HapticScene.message);
    context.push('/chat/${conversation.id}');
  }

  /// 显示会话选项菜单
  void _showConversationOptions(BuildContext context, PrivateMessageConversation conversation) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除会话'),
              onTap: () {
                Navigator.of(context).pop();
                _showDeleteConfirmDialog(context, conversation);
              },
            ),
            if (conversation.unreadCount > 0)
              ListTile(
                leading: const Icon(Icons.mark_email_read),
                title: const Text('标记为已读'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: 实现标记已读
                },
              ),
          ],
        ),
      ),
    );
  }

  /// 显示删除确认对话框
  void _showDeleteConfirmDialog(BuildContext context, PrivateMessageConversation conversation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除会话'),
        content: Text('确定要删除与 "${conversation.otherParticipant?.username ?? '该用户'}" 的会话吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await ref
                  .read(privateMessageConversationNotifierProvider.notifier)
                  .leaveConversation(conversation.id);

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success ? '已删除会话' : '删除失败'),
                  ),
                );
              }
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }

}

/// 会话列表项
class _ConversationItem extends ConsumerWidget {
  final PrivateMessageConversation conversation;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _ConversationItem({
    required this.conversation,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isUnread = conversation.unreadCount > 0;

    // 获取对方用户信息
    final otherUser = conversation.otherParticipant;
    final avatarUrl = otherUser?.avatarTemplate != null
        ? DiscourseImageUrlResolver.resolveAvatarUrl(
            otherUser!.avatarTemplate,
            size: 96,
          )
        : null;

    return Dismissible(
      key: ValueKey('conversation_${conversation.id}'),
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
            title: const Text('删除会话'),
            content: Text('确定要删除与 "${otherUser?.username ?? '该用户'}" 的会话吗？'),
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
      onDismissed: (direction) async {
        await ref
            .read(privateMessageConversationNotifierProvider.notifier)
            .leaveConversation(conversation.id);
      },
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isUnread ? colorScheme.primaryContainer.withOpacity(0.15) : null,
            border: Border(
              bottom: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
            ),
          ),
          child: Row(
            children: [
              // 头像
              Stack(
                children: [
                  UserAvatar(
                    avatarUrl: avatarUrl,
                    size: 52,
                    fallbackIcon: Icons.person,
                  ),
                  if (isUnread)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: colorScheme.error,
                          shape: BoxShape.circle,
                          border: Border.all(color: colorScheme.surface, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 12),
              // 内容
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            otherUser?.name ?? otherUser?.username ?? '未知用户',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _formatTime(conversation.lastPostedAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            conversation.lastMessage ?? conversation.title,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: isUnread
                                  ? colorScheme.onSurface
                                  : colorScheme.onSurfaceVariant,
                              fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (conversation.unreadCount > 0) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: colorScheme.error,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '${conversation.unreadCount}',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: colorScheme.onError,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
      } else if (difference.inDays < 365) {
        return DateFormat('MM-dd').format(dateTime);
      } else {
        return DateFormat('yyyy-MM-dd').format(dateTime);
      }
    } catch (e) {
      return timeString;
    }
  }
}


