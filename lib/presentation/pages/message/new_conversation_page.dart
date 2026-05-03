import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/private_message_provider.dart';
import '../../providers/user_search_provider.dart';
import '../../widgets/common/empty_widget.dart';
import '../../widgets/common/loading_widget.dart';

/// 新建私信页面
///
/// 类似微信的新建聊天页面，支持：
/// - 顶部搜索栏搜索用户
/// - 显示搜索结果列表
/// - 选择用户后进入私信编辑页面
class NewConversationPage extends ConsumerStatefulWidget {
  const NewConversationPage({super.key});

  @override
  ConsumerState<NewConversationPage> createState() => _NewConversationPageState();
}

class _NewConversationPageState extends ConsumerState<NewConversationPage> {
  final _searchFocusNode = FocusNode();
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // 页面打开时清除之前的搜索状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userSearchNotifierProvider.notifier).clear();
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final searchState = ref.watch(userSearchNotifierProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('新建私信'),
        centerTitle: true,
        actions: [
          // 取消按钮
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 搜索栏
          _buildSearchBar(theme, colorScheme, searchState),
          
          // 搜索结果区域
          Expanded(
            child: _buildSearchResults(theme, colorScheme, searchState),
          ),
        ],
      ),
    );
  }

  /// 构建搜索栏
  Widget _buildSearchBar(
    ThemeData theme,
    ColorScheme colorScheme,
    UserSearchState searchState,
  ) {
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          autofocus: true,
          decoration: InputDecoration(
            hintText: '搜索用户',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: colorScheme.onSurfaceVariant,
            ),
            suffixIcon: searchState.keyword.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(userSearchNotifierProvider.notifier).clear();
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          style: theme.textTheme.bodyMedium,
          onChanged: (value) {
            ref.read(userSearchNotifierProvider.notifier).setKeyword(value);
          },
        ),
      ),
    );
  }

  /// 构建搜索结果区域
  Widget _buildSearchResults(
    ThemeData theme,
    ColorScheme colorScheme,
    UserSearchState searchState,
  ) {
    // 搜索中状态
    if (searchState.isSearching) {
      return const Center(child: LoadingWidget());
    }

    // 空状态 - 未输入关键词
    if (searchState.keyword.isEmpty) {
      return EmptyWidget(
        icon: Icons.search,
        title: '搜索用户',
        description: '输入用户名查找要私信的人',
      );
    }

    // 无搜索结果
    if (searchState.results.isEmpty) {
      return EmptyWidget(
        icon: Icons.search_off,
        title: '未找到用户',
        description: '换个关键词试试',
      );
    }

    // 显示搜索结果列表
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: searchState.results.length,
      itemBuilder: (context, index) {
        final user = searchState.results[index];
        return _UserListItem(
          user: user,
          onTap: () => _onUserSelected(user),
        );
      },
    );
  }

  /// 用户被选中
  void _onUserSelected(UserSearchResult user) {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);
    
    // 清除搜索状态
    ref.read(userSearchNotifierProvider.notifier).clear();
    
    // 跳转到私信编辑页面
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ComposeMessagePage(
          recipient: user,
        ),
      ),
    );
  }
}

/// 用户列表项
class _UserListItem extends StatelessWidget {
  final UserSearchResult user;
  final VoidCallback onTap;

  const _UserListItem({
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
          color: colorScheme.surface,
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withOpacity(0.1),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            // 用户头像
            _buildAvatar(),
            const SizedBox(width: 12),
            // 用户信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.displayName,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (user.name != null && user.name!.isNotEmpty)
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
          ],
        ),
      ),
    );
  }

  /// 构建头像
  Widget _buildAvatar() {
    final avatarUrl = DiscourseImageUrlResolver.resolveAvatarUrl(
      user.avatarTemplate,
      size: 96,
    );

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          avatarUrl,
          width: 48,
          height: 48,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return _buildFallbackAvatar();
          },
        ),
      );
    }

    return _buildFallbackAvatar();
  }

  /// 构建默认头像
  Widget _buildFallbackAvatar() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.grey,
        size: 28,
      ),
    );
  }
}

/// 私信编辑页面
///
/// 类似微信的聊天输入页面，包含：
/// - 顶部显示接收者信息
/// - 标题输入框
/// - 内容输入框
/// - 发送按钮
class ComposeMessagePage extends ConsumerStatefulWidget {
  final UserSearchResult recipient;

  const ComposeMessagePage({
    super.key,
    required this.recipient,
  });

  @override
  ConsumerState<ComposeMessagePage> createState() => _ComposeMessagePageState();
}

class _ComposeMessagePageState extends ConsumerState<ComposeMessagePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _contentFocusNode = FocusNode();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    // 自动聚焦到内容输入框
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _contentFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.recipient.displayName),
        centerTitle: true,
        actions: [
          // 发送按钮
          TextButton(
            onPressed: _isSending ? null : _sendMessage,
            child: _isSending
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.primary,
                    ),
                  )
                : const Text('发送'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 接收者信息卡片
          _buildRecipientCard(theme, colorScheme),
          
          // 分割线
          Divider(
            height: 1,
            color: colorScheme.outline.withOpacity(0.2),
          ),
          
          // 标题输入
          _buildTitleInput(theme, colorScheme),
          
          // 分割线
          Divider(
            height: 1,
            color: colorScheme.outline.withOpacity(0.2),
          ),
          
          // 内容输入
          Expanded(
            child: _buildContentInput(theme, colorScheme),
          ),
        ],
      ),
    );
  }

  /// 构建接收者信息卡片
  Widget _buildRecipientCard(ThemeData theme, ColorScheme colorScheme) {
    final avatarUrl = DiscourseImageUrlResolver.resolveAvatarUrl(
      widget.recipient.avatarTemplate,
      size: 96,
    );

    return Container(
      color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // 头像
          if (avatarUrl != null && avatarUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                avatarUrl,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _buildFallbackAvatar();
                },
              ),
            )
          else
            _buildFallbackAvatar(),
          const SizedBox(width: 12),
          // 用户信息
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipient.displayName,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '@${widget.recipient.username}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          // 更换按钮
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('更换'),
          ),
        ],
      ),
    );
  }

  /// 构建默认头像
  Widget _buildFallbackAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Icon(
        Icons.person,
        color: Colors.grey,
        size: 24,
      ),
    );
  }

  /// 构建标题输入
  Widget _buildTitleInput(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _titleController,
        decoration: InputDecoration(
          hintText: '标题（可选）',
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        style: theme.textTheme.bodyMedium,
        enabled: !_isSending,
      ),
    );
  }

  /// 构建内容输入
  Widget _buildContentInput(ThemeData theme, ColorScheme colorScheme) {
    return Container(
      color: colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        controller: _contentController,
        focusNode: _contentFocusNode,
        decoration: InputDecoration(
          hintText: '输入私信内容...',
          hintStyle: theme.textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: theme.textTheme.bodyMedium,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        enabled: !_isSending,
      ),
    );
  }

  /// 发送私信
  Future<void> _sendMessage() async {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      _showError('请输入私信内容');
      return;
    }

    setState(() => _isSending = true);

    final topicId = await ref.read(privateMessageChatNotifierProvider.notifier).createConversation(
          title: title.isEmpty ? '私信' : title,
          content: content,
          targetUsernames: [widget.recipient.username],
        );

    if (mounted) {
      if (topicId != null) {
        // 发送成功，关闭当前页面并跳转到聊天页面
        Navigator.of(context).pop(); // 关闭 ComposeMessagePage
        Navigator.of(context).pop(); // 关闭 NewConversationPage
        
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

  /// 显示错误提示
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
