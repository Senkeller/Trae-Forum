import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/theme.dart';
import '../../../presentation/providers/reply_provider.dart';
import '../../widgets/user/user_avatar.dart';

/// 帖子回复输入组件
///
/// 用于帖子详情页底部的回复输入，支持：
/// - 多行文本输入
/// - 发送按钮（带加载状态）
/// - 字数统计
/// - 回复目标指示（楼中楼回复）
class PostReplyInput extends ConsumerStatefulWidget {
  /// 话题ID
  final int topicId;

  /// 当前用户头像URL
  final String? currentUserAvatar;

  /// 占位提示文字
  final String hintText;

  /// 最大输入长度
  final int maxLength;

  /// 发送成功回调
  final VoidCallback? onSendSuccess;

  /// 构造函数
  const PostReplyInput({
    super.key,
    required this.topicId,
    this.currentUserAvatar,
    this.hintText = '写下你的回复...',
    this.maxLength = 500,
    this.onSendSuccess,
  });

  @override
  ConsumerState<PostReplyInput> createState() => _PostReplyInputState();
}

class _PostReplyInputState extends ConsumerState<PostReplyInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // 加载草稿
    _loadDraft();
  }

  @override
  void dispose() {
    _saveDraft();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// 加载草稿
  Future<void> _loadDraft() async {
    final replyTarget = ref.read(currentReplyTargetProvider);
    final notifier = ref.read(replyNotifierProvider.notifier);

    final draft = await notifier.loadDraft(
      topicId: widget.topicId,
      replyToPostNumber: replyTarget?.postNumber,
    );

    if (draft != null && mounted) {
      _controller.text = draft.content;
    }
  }

  /// 保存草稿
  Future<void> _saveDraft() async {
    final content = _controller.text.trim();
    final replyTarget = ref.read(currentReplyTargetProvider);
    final notifier = ref.read(replyNotifierProvider.notifier);

    await notifier.saveDraft(
      topicId: widget.topicId,
      content: content,
      replyToPostNumber: replyTarget?.postNumber,
    );
  }

  /// 处理发送
  Future<void> _handleSend() async {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    final replyTarget = ref.read(currentReplyTargetProvider);
    final notifier = ref.read(replyNotifierProvider.notifier);

    final result = await notifier.sendReply(
      topicId: widget.topicId,
      content: content,
      replyToPostNumber: replyTarget?.postNumber,
    );

    if (result.success && mounted) {
      _controller.clear();
      ref.read(currentReplyTargetProvider.notifier).clearTarget();
      ref.read(replyListRefreshProvider.notifier).refresh();
      widget.onSendSuccess?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final replyState = ref.watch(replyNotifierProvider);
    final replyTarget = ref.watch(currentReplyTargetProvider);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 回复目标指示器
            if (replyTarget != null)
              ReplyTargetIndicator(
                username: replyTarget.username,
                onCancel: () {
                  ref.read(currentReplyTargetProvider.notifier).clearTarget();
                },
              ),
            // 输入区域
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // 头像
                if (widget.currentUserAvatar != null) ...[
                  UserAvatar(
                    avatarUrl: widget.currentUserAvatar,
                    size: 36,
                  ),
                  const SizedBox(width: 8),
                ],
                // 输入框
                Expanded(
                  child: _buildTextField(context),
                ),
                const SizedBox(width: 8),
                // 发送按钮
                _buildSendButton(context, replyState),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建输入框
  Widget _buildTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: const BoxConstraints(
        minHeight: 40,
        maxHeight: 120,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLines: null,
        maxLength: widget.maxLength,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => _handleSend(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 14,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 10,
          ),
          border: InputBorder.none,
          counterText: '',
        ),
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 14,
        ),
      ),
    );
  }

  /// 构建发送按钮
  Widget _buildSendButton(BuildContext context, ReplyState state) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasContent = _controller.text.trim().isNotEmpty;

    return GestureDetector(
      onTap: state.isLoading || !hasContent ? null : _handleSend,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: hasContent && !state.isLoading
              ? colorScheme.primary
              : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: state.isLoading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                '发送',
                style: TextStyle(
                  color: hasContent
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
      ),
    );
  }
}

/// 回复目标指示器
///
/// 显示当前正在回复的目标用户和楼层
class ReplyTargetIndicator extends StatelessWidget {
  /// 目标用户名
  final String username;

  /// 取消回调
  final VoidCallback onCancel;

  /// 构造函数
  const ReplyTargetIndicator({
    super.key,
    required this.username,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            Icons.reply,
            size: 16,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 4),
          Text(
            '回复 @$username',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onCancel,
            child: Icon(
              Icons.close,
              size: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// 帖子回复底部操作栏
///
/// 固定在帖子详情页底部的操作栏，包含输入框占位和操作按钮
class PostReplyBottomBar extends StatelessWidget {
  /// 当前用户头像URL
  final String? currentUserAvatar;

  /// 占位提示文字
  final String hintText;

  /// 点击输入框回调
  final VoidCallback? onInputTap;

  /// 点赞数
  final int likeCount;

  /// 评论数
  final int commentCount;

  /// 是否已点赞
  final bool isLiked;

  /// 点赞回调
  final VoidCallback? onLike;

  /// 分享回调
  final VoidCallback? onShare;

  /// 收藏回调
  final VoidCallback? onFavorite;

  /// 是否已收藏
  final bool isFavorited;

  /// 构造函数
  const PostReplyBottomBar({
    super.key,
    this.currentUserAvatar,
    this.hintText = '说点什么...',
    this.onInputTap,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
    this.onLike,
    this.onShare,
    this.onFavorite,
    this.isFavorited = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // 输入框占位
            Expanded(
              child: GestureDetector(
                onTap: onInputTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      if (currentUserAvatar != null) ...[
                        UserAvatar(
                          avatarUrl: currentUserAvatar,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                      ],
                      Text(
                        hintText,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // 操作按钮
            _buildActionButton(
              context,
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              count: likeCount,
              isActive: isLiked,
              activeColor: AppTheme.likeColor,
              onTap: onLike,
            ),
            _buildActionButton(
              context,
              icon: Icons.chat_bubble_outline,
              count: commentCount,
              onTap: onInputTap,
            ),
            if (onFavorite != null)
              _buildActionButton(
                context,
                icon: isFavorited ? Icons.star : Icons.star_border,
                isActive: isFavorited,
                activeColor: AppTheme.favoriteColor,
                onTap: onFavorite,
              ),
            if (onShare != null)
              _buildActionButton(
                context,
                icon: Icons.share,
                onTap: onShare,
              ),
          ],
        ),
      ),
    );
  }

  /// 构建操作按钮
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    int count = 0,
    bool isActive = false,
    Color? activeColor,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final iconColor = isActive
        ? (activeColor ?? colorScheme.primary)
        : colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: iconColor,
            ),
            if (count > 0)
              Text(
                _formatCount(count),
                style: textTheme.labelSmall?.copyWith(
                  color: iconColor,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 格式化数量
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

/// 回复输入弹窗
///
/// 全屏回复输入弹窗，用于展开更多输入空间
class ReplyInputDialog extends StatelessWidget {
  /// 话题ID
  final int topicId;

  /// 当前用户头像URL
  final String? currentUserAvatar;

  /// 标题
  final String title;

  /// 占位提示文字
  final String hintText;

  /// 发送成功回调
  final VoidCallback? onSendSuccess;

  /// 构造函数
  const ReplyInputDialog({
    super.key,
    required this.topicId,
    this.currentUserAvatar,
    this.title = '发表评论',
    this.hintText = '写下你的回复...',
    this.onSendSuccess,
  });

  /// 显示弹窗
  static Future<void> show({
    required BuildContext context,
    required int topicId,
    String? currentUserAvatar,
    String title = '发表评论',
    String hintText = '写下你的回复...',
    VoidCallback? onSendSuccess,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReplyInputDialog(
        topicId: topicId,
        currentUserAvatar: currentUserAvatar,
        title: title,
        hintText: hintText,
        onSendSuccess: onSendSuccess,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          // 顶部拖动条
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
          // 标题栏
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close),
                ),
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                const SizedBox(width: 24),
              ],
            ),
          ),
          // 输入区域
          Expanded(
            child: PostReplyInput(
              topicId: topicId,
              currentUserAvatar: currentUserAvatar,
              hintText: hintText,
              onSendSuccess: () {
                onSendSuccess?.call();
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
