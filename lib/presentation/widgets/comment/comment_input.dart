import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../user/user_avatar.dart';

/// 评论输入框组件
///
/// 支持以下功能：
/// - 文字输入
/// - 表情选择
/// - 图片选择
/// - @用户
/// - 发送按钮
class CommentInput extends StatefulWidget {
  /// 当前用户头像 URL
  final String? currentUserAvatar;

  /// 占位提示文字
  final String hintText;

  /// 发送回调
  final ValueChanged<String>? onSend;

  /// 表情按钮点击回调
  final VoidCallback? onEmojiTap;

  /// 图片按钮点击回调
  final VoidCallback? onImageTap;

  /// @用户按钮点击回调
  final VoidCallback? onAtTap;

  /// 最大输入长度
  final int maxLength;

  /// 最小输入高度
  final double minHeight;

  /// 最大输入高度
  final double maxHeight;

  /// 是否自动聚焦
  final bool autofocus;

  /// 初始文字
  final String? initialText;

  /// 回复对象用户名
  final String? replyToUsername;

  /// 构造函数
  ///
  /// [currentUserAvatar] 当前用户头像 URL
  /// [hintText] 占位提示文字，默认 "说点什么..."
  /// [onSend] 发送回调
  /// [onEmojiTap] 表情按钮点击回调
  /// [onImageTap] 图片按钮点击回调
  /// [onAtTap] @用户按钮点击回调
  /// [maxLength] 最大输入长度，默认 500
  /// [minHeight] 最小输入高度，默认 48
  /// [maxHeight] 最大输入高度，默认 120
  /// [autofocus] 是否自动聚焦，默认 false
  /// [initialText] 初始文字
  /// [replyToUsername] 回复对象用户名
  const CommentInput({
    super.key,
    this.currentUserAvatar,
    this.hintText = '说点什么...',
    this.onSend,
    this.onEmojiTap,
    this.onImageTap,
    this.onAtTap,
    this.maxLength = 500,
    this.minHeight = 48,
    this.maxHeight = 120,
    this.autofocus = false,
    this.initialText,
    this.replyToUsername,
  });

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _isComposing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _focusNode = FocusNode();
    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// 处理文字变化
  void _handleTextChange() {
    final isComposing = _controller.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
      });
    }
  }

  /// 处理发送
  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSend?.call(text);
      _controller.clear();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
            // 回复提示
            if (widget.replyToUsername != null)
              _buildReplyHint(context),
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
                _buildSendButton(context),
              ],
            ),
            // 工具栏
            _buildToolbar(context),
          ],
        ),
      ),
    );
  }

  /// 构建回复提示
  Widget _buildReplyHint(BuildContext context) {
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
            '回复 @${widget.replyToUsername}',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建输入框
  Widget _buildTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
        maxHeight: widget.maxHeight,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        maxLength: widget.maxLength,
        maxLines: null,
        textInputAction: TextInputAction.send,
        onSubmitted: (_) => _handleSend(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: InputBorder.none,
          counterText: '',
        ),
      ),
    );
  }

  /// 构建发送按钮
  Widget _buildSendButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _isComposing ? _handleSend : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isComposing
              ? colorScheme.primary
              : colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '发送',
          style: TextStyle(
            color: _isComposing
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// 构建工具栏
  Widget _buildToolbar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 44),
      child: Row(
        children: [
          // 表情按钮
          if (widget.onEmojiTap != null)
            _buildToolbarButton(
              context,
              icon: Icons.emoji_emotions_outlined,
              onTap: widget.onEmojiTap,
            ),
          // 图片按钮
          if (widget.onImageTap != null)
            _buildToolbarButton(
              context,
              icon: Icons.image_outlined,
              onTap: widget.onImageTap,
            ),
          // @用户按钮
          if (widget.onAtTap != null)
            _buildToolbarButton(
              context,
              icon: Icons.alternate_email,
              onTap: widget.onAtTap,
            ),
          const Spacer(),
          // 字数统计
          Text(
            '${_controller.text.length}/${widget.maxLength}',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建工具栏按钮
  Widget _buildToolbarButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Icon(
          icon,
          size: 22,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

/// 底部评论输入栏
///
/// 固定在底部的评论输入组件
class BottomCommentInput extends StatelessWidget {
  /// 当前用户头像 URL
  final String? currentUserAvatar;

  /// 占位提示文字
  final String hintText;

  /// 点击输入框回调
  final VoidCallback? onTap;

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
  ///
  /// [currentUserAvatar] 当前用户头像 URL
  /// [hintText] 占位提示文字，默认 "说点什么..."
  /// [onTap] 点击输入框回调
  /// [likeCount] 点赞数，默认 0
  /// [commentCount] 评论数，默认 0
  /// [isLiked] 是否已点赞，默认 false
  /// [onLike] 点赞回调
  /// [onShare] 分享回调
  /// [onFavorite] 收藏回调
  /// [isFavorited] 是否已收藏，默认 false
  const BottomCommentInput({
    super.key,
    this.currentUserAvatar,
    this.hintText = '说点什么...',
    this.onTap,
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
            // 输入框
            Expanded(
              child: GestureDetector(
                onTap: onTap,
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
              onTap: onTap,
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

/// 评论输入对话框
///
/// 全屏评论输入弹窗
class CommentInputDialog extends StatelessWidget {
  /// 标题
  final String title;

  /// 占位提示文字
  final String hintText;

  /// 发送回调
  final ValueChanged<String>? onSend;

  /// 构造函数
  ///
  /// [title] 标题，默认 "发表评论"
  /// [hintText] 占位提示文字，默认 "说点什么..."
  /// [onSend] 发送回调
  const CommentInputDialog({
    super.key,
    this.title = '发表评论',
    this.hintText = '说点什么...',
    this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
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
                const SizedBox(width: 24), // 平衡关闭按钮
              ],
            ),
          ),
          // 输入区域
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: CommentInput(
                hintText: hintText,
                onSend: (text) {
                  onSend?.call(text);
                  Navigator.of(context).pop();
                },
                autofocus: true,
                maxHeight: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
