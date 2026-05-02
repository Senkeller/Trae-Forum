import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../../data/models/discourse/discourse_private_message.dart';
import '../../providers/auth_provider.dart';
import '../../providers/private_message_provider.dart';
import '../../providers/user_search_provider.dart';
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
            onPressed: () => _showNewMessageDialog(context),
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
        onButtonPressed: () => _showNewMessageDialog(context),
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

  /// 显示新建私信对话框
  void _showNewMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _NewMessageDialog(),
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
    final currentUser = ref.watch(currentUserProvider);
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

/// 新建私信对话框
///
/// 支持用户搜索功能，类似微博的搜索体验：
/// - 输入关键词实时搜索用户
/// - 显示用户头像和用户名
/// - 选择用户后填充到接收者字段
class _NewMessageDialog extends ConsumerStatefulWidget {
  const _NewMessageDialog();

  @override
  ConsumerState<_NewMessageDialog> createState() => _NewMessageDialogState();
}

class _NewMessageDialogState extends ConsumerState<_NewMessageDialog> {
  final _searchFocusNode = FocusNode();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    // 对话框打开时清除之前的搜索状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userSearchNotifierProvider.notifier).clear();
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final searchState = ref.watch(userSearchNotifierProvider);

    return AlertDialog(
      title: const Text('新建私信'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户搜索区域
              _buildUserSearchArea(theme, colorScheme, searchState),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: '标题',
                  hintText: '输入私信标题',
                  prefixIcon: Icon(Icons.title),
                ),
                enabled: !_isSending,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: '内容',
                  hintText: '输入私信内容',
                  prefixIcon: Icon(Icons.message_outlined),
                  alignLabelWithHint: true,
                ),
                enabled: !_isSending,
                maxLines: 4,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _sendMessage(),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSending ? null : () => Navigator.of(context).pop(),
          child: const Text('取消'),
        ),
        FilledButton(
          onPressed: _isSending || searchState.selectedUser == null ? null : _sendMessage,
          child: _isSending
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('发送'),
        ),
      ],
    );
  }

  /// 构建用户搜索区域
  Widget _buildUserSearchArea(
    ThemeData theme,
    ColorScheme colorScheme,
    UserSearchState searchState,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 搜索输入框
        _buildSearchInput(theme, colorScheme, searchState),
        
        // 搜索结果列表
        if (searchState.showResults && searchState.results.isNotEmpty)
          _buildSearchResults(theme, colorScheme, searchState),
        
        // 搜索中状态
        if (searchState.isSearching)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '搜索中...',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        
        // 无搜索结果提示
        if (searchState.showResults && 
            !searchState.isSearching && 
            searchState.results.isEmpty &&
            searchState.keyword.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              '未找到用户',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        
        // 已选中的用户显示
        if (searchState.selectedUser != null)
          _buildSelectedUserChip(theme, colorScheme, searchState.selectedUser!),
      ],
    );
  }

  /// 构建搜索输入框
  Widget _buildSearchInput(
    ThemeData theme,
    ColorScheme colorScheme,
    UserSearchState searchState,
  ) {
    return TextField(
      focusNode: _searchFocusNode,
      decoration: InputDecoration(
        labelText: '接收者',
        hintText: searchState.selectedUser == null ? '搜索用户名' : null,
        prefixIcon: const Icon(Icons.person_outline),
        suffixIcon: searchState.keyword.isNotEmpty || searchState.selectedUser != null
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  ref.read(userSearchNotifierProvider.notifier).clearSelection();
                  _searchFocusNode.requestFocus();
                },
              )
            : null,
      ),
      enabled: !_isSending && searchState.selectedUser == null,
      textInputAction: TextInputAction.search,
      onChanged: (value) {
        ref.read(userSearchNotifierProvider.notifier).setKeyword(value);
      },
      onSubmitted: (value) {
        if (value.isNotEmpty) {
          ref.read(userSearchNotifierProvider.notifier).search(value);
        }
      },
    );
  }

  /// 构建搜索结果列表
  Widget _buildSearchResults(
    ThemeData theme,
    ColorScheme colorScheme,
    UserSearchState searchState,
  ) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      constraints: const BoxConstraints(maxHeight: 200),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outline.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: searchState.results.length,
          itemBuilder: (context, index) {
            final user = searchState.results[index];
            return _UserSearchResultItem(
              user: user,
              onTap: () {
                ref.read(userSearchNotifierProvider.notifier).selectUser(user);
                _searchFocusNode.unfocus();
              },
            );
          },
        ),
      ),
    );
  }

  /// 构建已选中的用户Chip
  Widget _buildSelectedUserChip(
    ThemeData theme,
    ColorScheme colorScheme,
    UserSearchResult user,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Chip(
        avatar: CircleAvatar(
          backgroundImage: NetworkImage(user.avatarUrl),
          radius: 14,
          onBackgroundImageError: (_, __) {},
        ),
        label: Text('@${user.username}'),
        deleteIcon: const Icon(Icons.close, size: 18),
        onDeleted: _isSending
            ? null
            : () {
                ref.read(userSearchNotifierProvider.notifier).clearSelection();
                _searchFocusNode.requestFocus();
              },
        backgroundColor: colorScheme.primaryContainer.withOpacity(0.5),
        side: BorderSide(color: colorScheme.primary.withOpacity(0.3)),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final searchState = ref.read(userSearchNotifierProvider);
    final selectedUser = searchState.selectedUser;
    
    if (selectedUser == null) {
      _showError('请选择接收者');
      return;
    }
    
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty) {
      _showError('请输入标题');
      return;
    }
    if (content.isEmpty) {
      _showError('请输入内容');
      return;
    }

    setState(() => _isSending = true);

    final topicId = await ref.read(privateMessageChatNotifierProvider.notifier).createConversation(
          title: title,
          content: content,
          targetUsernames: [selectedUser.username],
        );

    if (mounted) {
      if (topicId != null) {
        // 清除搜索状态
        ref.read(userSearchNotifierProvider.notifier).clear();
        Navigator.of(context).pop();
        // 刷新会话列表
        ref.read(privateMessageConversationNotifierProvider.notifier).loadConversations();
        // 跳转到新会话
        context.push('/chat/$topicId');
      } else {
        setState(() => _isSending = false);
        final error = ref.read(privateMessageChatNotifierProvider).errorMessage;
        _showError(error ?? '发送失败');
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

/// 用户搜索结果项
///
/// 显示用户头像、用户名和显示名称
class _UserSearchResultItem extends StatelessWidget {
  final UserSearchResult user;
  final VoidCallback onTap;

  const _UserSearchResultItem({
    required this.user,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: colorScheme.outline.withOpacity(0.1)),
          ),
        ),
        child: Row(
          children: [
            // 用户头像
            CircleAvatar(
              backgroundImage: NetworkImage(user.avatarUrl),
              radius: 20,
              onBackgroundImageError: (_, __) {},
              child: user.avatarTemplate.isEmpty
                  ? const Icon(Icons.person, size: 20)
                  : null,
            ),
            const SizedBox(width: 12),
            // 用户信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '@${user.username}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // 选择指示器
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: colorScheme.onSurfaceVariant.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
