import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../core/utils/html_text_util.dart';
import '../../../data/models/discourse/discourse_post.dart';
import '../../../data/models/discourse/discourse_topic.dart';
import '../../providers/auth_provider.dart';
import '../../providers/private_message_provider.dart';
import '../../widgets/common/empty_widget.dart';
import '../../widgets/common/error_widget.dart';
import '../../widgets/common/loading_widget.dart';
import '../../widgets/user/user_avatar.dart';

/// 私信聊天页面
///
/// 展示单个私信会话的完整聊天记录，支持：
/// - 查看消息列表
/// - 发送新消息
/// - 加载更多历史消息
/// - 显示消息气泡
class ChatPage extends ConsumerStatefulWidget {
  /// 会话话题ID
  final int topicId;

  const ChatPage({
    super.key,
    required this.topicId,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _messageFocusNode = FocusNode();
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_handleMessageChanged);

    // 初始化时加载消息
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(privateMessageChatNotifierProvider.notifier).loadMessages(widget.topicId);
    });
  }

  @override
  void dispose() {
    _messageController.removeListener(_handleMessageChanged);
    _scrollController.dispose();
    _messageController.dispose();
    _messageFocusNode.dispose();
    super.dispose();
  }

  void _handleMessageChanged() {
    final isComposing = _messageController.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() => _isComposing = isComposing);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final state = ref.watch(privateMessageChatNotifierProvider);
    final currentUser = ref.watch(currentUserProvider);

    // 获取对方用户信息
    final otherUser = state.getOtherParticipant(currentUser?.username ?? '');

    return Scaffold(
      appBar: AppBar(
        title: _buildAppBarTitle(otherUser),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showChatOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // 消息列表
          Expanded(
            child: _buildMessageList(state, currentUser?.username ?? ''),
          ),
          // 输入框
          _buildInputArea(colorScheme),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle(DiscourseUserBasic? otherUser) {
    final theme = Theme.of(context);
    final avatarUrl = otherUser?.avatarTemplate != null
        ? DiscourseImageUrlResolver.resolveAvatarUrl(
            otherUser!.avatarTemplate,
            size: 64,
          )
        : null;

    return Row(
      children: [
        UserAvatar(
          avatarUrl: avatarUrl,
          size: 36,
          fallbackIcon: Icons.person,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                otherUser?.name ?? otherUser?.username ?? '私信',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (otherUser?.username != null)
                Text(
                  '@${otherUser!.username}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMessageList(PrivateMessageChatState state, String currentUsername) {
    // 加载中状态
    if (state.isLoading && state.messages.isEmpty) {
      return const Center(child: LoadingWidget());
    }

    // 错误状态
    if (state.errorMessage != null && state.messages.isEmpty) {
      return ErrorWidgetWithRetry(
        message: state.errorMessage!,
        onRetry: () {
          ref.read(privateMessageChatNotifierProvider.notifier).loadMessages(widget.topicId);
        },
      );
    }

    // 空状态
    if (state.messages.isEmpty) {
      return const EmptyWidget(
        icon: Icons.chat_bubble_outline,
        title: '暂无消息',
        description: '开始发送第一条消息吧',
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          // 滚动时收起键盘
          FocusScope.of(context).unfocus();
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        reverse: true,
        itemCount: state.messages.length + (state.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          // 加载更多指示器
          if (index == state.messages.length) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: state.isLoading
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () {
                          ref.read(privateMessageChatNotifierProvider.notifier).loadMoreMessages();
                        },
                        child: const Text('加载更多'),
                      ),
              ),
            );
          }

          final message = state.messages[state.messages.length - 1 - index];
          final isMe = message.username == currentUsername;
          final showAvatar = !isMe;

          return _MessageBubble(
            message: message,
            isMe: isMe,
            showAvatar: showAvatar,
          );
        },
      ),
    );
  }

  Widget _buildInputArea(ColorScheme colorScheme) {
    final state = ref.watch(privateMessageChatNotifierProvider);

    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            // 添加附件按钮
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                // TODO: 实现附件功能
              },
            ),
            // 输入框
            Expanded(
              child: TextField(
                controller: _messageController,
                focusNode: _messageFocusNode,
                decoration: InputDecoration(
                  hintText: '输入消息...',
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: colorScheme.primary, width: 1),
                  ),
                ),
                maxLines: null,
                textInputAction: TextInputAction.send,
                enabled: !state.isSending && !state.isClosed && !state.isArchived,
                onSubmitted: (_) => _handleSendMessage(),
              ),
            ),
            // 发送按钮
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _isComposing
                  ? IconButton(
                      key: const ValueKey('send'),
                      icon: const Icon(Icons.send),
                      color: colorScheme.primary,
                      onPressed: state.isSending ? null : _handleSendMessage,
                    )
                  : IconButton(
                      key: const ValueKey('emoji'),
                      icon: const Icon(Icons.emoji_emotions_outlined),
                      onPressed: () {
                        // TODO: 实现表情选择器
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSendMessage() async {
    final content = _messageController.text.trim();
    if (content.isEmpty) return;

    HapticFeedbackUtil.trigger(ref, HapticScene.message);

    _messageController.clear();
    setState(() => _isComposing = false);

    final success = await ref.read(privateMessageChatNotifierProvider.notifier).sendMessage(content);

    if (mounted && !success) {
      final error = ref.read(privateMessageChatNotifierProvider).errorMessage;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? '发送失败')),
      );
    }
  }

  void _showChatOptions(BuildContext context) {
    final state = ref.read(privateMessageChatNotifierProvider);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.person_outline),
              title: const Text('查看对方资料'),
              onTap: () {
                Navigator.of(context).pop();
                final currentUser = ref.read(currentUserProvider);
                final otherUser = state.getOtherParticipant(currentUser?.username ?? '');
                if (otherUser != null) {
                  context.push('/user/${otherUser.username}');
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline),
              title: const Text('删除会话'),
              onTap: () {
                Navigator.of(context).pop();
                _showLeaveConfirmDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLeaveConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除会话'),
        content: const Text('确定要删除这个会话吗？删除后将无法恢复。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final success = await ref
                  .read(privateMessageChatNotifierProvider.notifier)
                  .leaveConversation();

              if (mounted) {
                if (success) {
                  context.pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('已删除会话')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('删除失败')),
                  );
                }
              }
            },
            child: const Text('删除'),
          ),
        ],
      ),
    );
  }
}

/// 消息气泡组件
class _MessageBubble extends StatelessWidget {
  final DiscoursePost message;
  final bool isMe;
  final bool showAvatar;

  const _MessageBubble({
    required this.message,
    required this.isMe,
    required this.showAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final avatarUrl = DiscourseImageUrlResolver.resolveAvatarUrl(
            message.avatarTemplate,
            size: 64,
          );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            // 对方头像
            UserAvatar(
              avatarUrl: avatarUrl,
              size: 36,
              fallbackIcon: Icons.person,
            ),
            const SizedBox(width: 8),
          ],
          // 消息内容
          Flexible(
            child: Column(
              crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // 用户名（仅显示对方的）
                if (!isMe)
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 2),
                    child: Text(
                      message.name ?? message.username,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                // 消息气泡
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isMe
                        ? colorScheme.primary
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16),
                      bottomLeft: Radius.circular(isMe ? 16 : 4),
                      bottomRight: Radius.circular(isMe ? 4 : 16),
                    ),
                  ),
                  child: _buildMessageContent(theme, colorScheme),
                ),
                // 时间
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 4, right: 4),
                  child: Text(
                    _formatTime(message.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isMe) const SizedBox(width: 44), // 保持对齐
        ],
      ),
    );
  }

  Widget _buildMessageContent(ThemeData theme, ColorScheme colorScheme) {
    // 处理 HTML 内容
    final cooked = message.cooked ?? '';
    final processedContent = HtmlTextUtil.simplifyHtml(cooked);

    return Html(
      data: processedContent,
      style: {
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          color: isMe ? colorScheme.onPrimary : colorScheme.onSurface,
          fontSize: FontSize(14),
          lineHeight: const LineHeight(1.4),
        ),
        'p': Style(
          margin: Margins.zero,
        ),
        'a': Style(
          color: isMe ? colorScheme.onPrimary : colorScheme.primary,
          textDecoration: TextDecoration.underline,
        ),
      },
      onLinkTap: (url, _, __) {
        // 处理链接点击
        if (url != null) {
          // TODO: 处理链接跳转
        }
      },
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

      if (difference.inDays < 1) {
        return DateFormat('HH:mm').format(dateTime);
      } else if (difference.inDays < 7) {
        return DateFormat('MM-dd HH:mm').format(dateTime);
      } else {
        return DateFormat('yyyy-MM-dd').format(dateTime);
      }
    } catch (e) {
      return timeString;
    }
  }
}
