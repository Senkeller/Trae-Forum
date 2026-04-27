import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markdown_quill/markdown_quill.dart';
import 'package:markdown/markdown.dart' as md;

import '../../core/services/image_upload_service.dart';

/// 评论输入栏组件
///
/// 支持两种模式：
/// 1. 收起模式：左侧显示提示文本，右侧显示功能按钮
/// 2. 展开模式：显示富文本编辑器，右侧显示发布按钮
///
/// 参考设计：
/// - 收起状态：左侧输入框提示"说说你的看法"，右侧评论、点赞、收藏、分享按钮
/// - 展开状态：显示键盘，顶部有表情、图片、@、话题、+按钮，右侧绿色"发布"按钮
class CommentInputBar extends StatefulWidget {
  /// 是否已登录
  final bool isLoggedIn;

  /// 是否正在发送
  final bool isSending;

  /// 回复目标用户名
  final String? replyingToUsername;

  /// 取消回复回调
  final VoidCallback? onCancelReply;

  /// 发送回调
  final Future<void> Function(String content) onSend;

  /// 登录回调
  final VoidCallback onLoginTap;

  /// 评论数量
  final int commentCount;

  /// 点赞数量
  final int likeCount;

  /// 收藏数量
  final int favoriteCount;

  /// 分享数量
  final int shareCount;

  /// 是否已点赞
  final bool isLiked;

  /// 是否已收藏
  final bool isFavorited;

  /// 点赞回调
  final VoidCallback? onLikeTap;

  /// 收藏回调
  final VoidCallback? onFavoriteTap;

  /// 分享回调
  final VoidCallback? onShareTap;

  /// 评论点击回调（展开输入框）
  final VoidCallback? onCommentTap;

  const CommentInputBar({
    super.key,
    required this.isLoggedIn,
    required this.isSending,
    this.replyingToUsername,
    this.onCancelReply,
    required this.onSend,
    required this.onLoginTap,
    this.commentCount = 0,
    this.likeCount = 0,
    this.favoriteCount = 0,
    this.shareCount = 0,
    this.isLiked = false,
    this.isFavorited = false,
    this.onLikeTap,
    this.onFavoriteTap,
    this.onShareTap,
    this.onCommentTap,
  });

  @override
  State<CommentInputBar> createState() => _CommentInputBarState();
}

class _CommentInputBarState extends State<CommentInputBar> {
  bool _isExpanded = false;
  String _currentContent = '';

  // 编辑器相关
  late final QuillController _controller;
  late final md.Document _mdDocument;
  late final MarkdownToDelta _mdToDelta;
  late final DeltaToMarkdown _deltaToMd;
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;
  final ImagePicker _imagePicker = ImagePicker();
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();

    // 初始化 Markdown 转换器
    _mdDocument = md.Document(
      encodeHtml: false,
      extensionSet: md.ExtensionSet.gitHubFlavored,
    );
    _mdToDelta = MarkdownToDelta(markdownDocument: _mdDocument);
    _deltaToMd = DeltaToMarkdown();

    // 初始化滚动控制器和焦点节点
    _scrollController = ScrollController();
    _focusNode = FocusNode();

    // 初始化 Quill 控制器
    final delta = _convertMarkdownToDelta('');
    _controller = QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );

    // 监听文本变化
    _controller.addListener(_handleTextChange);

    // 监听焦点变化
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _focusNode.removeListener(_handleFocusChange);
    _scrollController.dispose();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus && !_isExpanded) {
      setState(() {
        _isExpanded = true;
      });
    }
  }

  /// 将 Markdown 转换为 Delta
  Delta _convertMarkdownToDelta(String markdown) {
    if (markdown.isEmpty) {
      return Delta()..insert('\n');
    }
    try {
      final delta = _mdToDelta.convert(markdown);
      if (delta.isEmpty) {
        return Delta()..insert('\n');
      }
      if (delta.last.data is String && !(delta.last.data as String).endsWith('\n')) {
        delta.insert('\n');
      }
      return delta;
    } catch (e) {
      return Delta()..insert('\n');
    }
  }

  /// 将 Delta 转换为 Markdown
  String _convertDeltaToMarkdown() {
    try {
      final delta = _controller.document.toDelta();
      return _deltaToMd.convert(delta);
    } catch (e) {
      return '';
    }
  }

  /// 处理文本变化
  void _handleTextChange() {
    final markdown = _convertDeltaToMarkdown();
    setState(() {
      _currentContent = markdown;
    });
  }

  /// 选择图片并上传
  Future<void> _pickAndUploadImage() async {
    if (_isUploadingImage) return;

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) return;

      setState(() {
        _isUploadingImage = true;
      });

      final uploadService = ImageUploadService();
      final result = await uploadService.uploadImage(
        filePath: image.path,
      );

      if (result.success && mounted) {
        final imageMarkdown = '\n![图片](${result.imageUrl})\n';
        _insertText(imageMarkdown);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('图片上传失败: ${result.errorMessage}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('选择图片失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploadingImage = false;
        });
      }
    }
  }

  /// 插入文本
  void _insertText(String text) {
    final index = _controller.selection.baseOffset;
    final length = _controller.selection.extentOffset - index;
    _controller.replaceText(index, length, text, null);
  }

  /// 处理发送
  Future<void> _handleSend() async {
    if (!widget.isLoggedIn) {
      widget.onLoginTap();
      return;
    }

    final content = _currentContent.trim();
    if (content.isEmpty || widget.isSending) {
      return;
    }

    await widget.onSend(content);

    // 发送成功后重置
    if (mounted) {
      setState(() {
        _isExpanded = false;
        _currentContent = '';
      });
      _controller.document = Document.fromDelta(_convertMarkdownToDelta(''));
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.fromLTRB(12, _isExpanded ? 8 : 8, 12, 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 回复目标提示条
            if (widget.replyingToUsername != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.reply_rounded,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '正在回复 @${widget.replyingToUsername}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onCancelReply,
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

            // 主内容区域
            if (_isExpanded)
              _buildExpandedView(colorScheme)
            else
              _buildCollapsedView(colorScheme),
          ],
        ),
      ),
    );
  }

  /// 收起状态视图
  Widget _buildCollapsedView(ColorScheme colorScheme) {
    return Row(
      children: [
        // 左侧输入框提示
        Expanded(
          child: GestureDetector(
            onTap: () {
              if (widget.onCommentTap != null) {
                widget.onCommentTap!();
              }
              setState(() {
                _isExpanded = true;
              });
              _focusNode.requestFocus();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.edit_note,
                    size: 18,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.isLoggedIn ? '说说你的看法...' : '登录后参与讨论',
                    style: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // 右侧功能按钮
        // 评论按钮
        _buildActionButton(
          icon: Icons.chat_bubble_outline,
          count: widget.commentCount,
          onTap: () {
            if (widget.onCommentTap != null) {
              widget.onCommentTap!();
            }
            setState(() {
              _isExpanded = true;
            });
            _focusNode.requestFocus();
          },
          colorScheme: colorScheme,
        ),

        // 点赞按钮
        _buildActionButton(
          icon: widget.isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
          count: widget.likeCount,
          onTap: widget.onLikeTap,
          isActive: widget.isLiked,
          activeColor: colorScheme.primary,
          colorScheme: colorScheme,
        ),

        // 收藏按钮
        _buildActionButton(
          icon: widget.isFavorited ? Icons.star : Icons.star_outline,
          count: widget.favoriteCount,
          onTap: widget.onFavoriteTap,
          isActive: widget.isFavorited,
          activeColor: Colors.amber,
          colorScheme: colorScheme,
        ),

        // 分享按钮
        _buildActionButton(
          icon: Icons.share_outlined,
          count: widget.shareCount,
          onTap: widget.onShareTap,
          colorScheme: colorScheme,
        ),
      ],
    );
  }

  /// 展开状态视图
  Widget _buildExpandedView(ColorScheme colorScheme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 编辑器
        Container(
          constraints: const BoxConstraints(
            minHeight: 80,
            maxHeight: 200,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(color: colorScheme.outline.withOpacity(0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: QuillEditor(
              controller: _controller,
              scrollController: _scrollController,
              focusNode: _focusNode,
              config: QuillEditorConfig(
                placeholder: widget.isLoggedIn ? '写下你的回复...' : '登录后参与回复',
                padding: const EdgeInsets.all(12),
                autoFocus: true,
                expands: false,
                scrollable: true,
                enableInteractiveSelection: true,
                enableSelectionToolbar: true,
                showCursor: true,
              ),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // 底部工具栏
        Row(
          children: [
            // 左侧工具按钮
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 表情按钮
                    IconButton(
                      onPressed: () {
                        // TODO: 显示表情选择器
                      },
                      icon: const Icon(Icons.emoji_emotions_outlined, size: 22),
                      color: colorScheme.onSurfaceVariant,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                    // 图片按钮
                    IconButton(
                      onPressed: _isUploadingImage ? null : _pickAndUploadImage,
                      icon: _isUploadingImage
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.image_outlined, size: 22),
                      color: colorScheme.onSurfaceVariant,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                    // @按钮
                    IconButton(
                      onPressed: () {
                        _insertText('@');
                      },
                      icon: const Icon(Icons.alternate_email, size: 22),
                      color: colorScheme.onSurfaceVariant,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                    // 话题按钮
                    IconButton(
                      onPressed: () {
                        _insertText('#');
                      },
                      icon: const Icon(Icons.tag, size: 22),
                      color: colorScheme.onSurfaceVariant,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                    // 更多按钮
                    IconButton(
                      onPressed: () {
                        // TODO: 显示更多选项
                      },
                      icon: const Icon(Icons.add_circle_outline, size: 22),
                      color: colorScheme.onSurfaceVariant,
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                    ),
                  ],
                ),
              ),
            ),

            // 右侧发布按钮
            GestureDetector(
              onTap: widget.isSending ? null : _handleSend,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _currentContent.trim().isNotEmpty && !widget.isSending
                      ? colorScheme.primary
                      : colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: widget.isSending
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        '发布',
                        style: TextStyle(
                          color: _currentContent.trim().isNotEmpty && !widget.isSending
                              ? Colors.white
                              : colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 构建功能按钮
  Widget _buildActionButton({
    required IconData icon,
    required int count,
    required VoidCallback? onTap,
    bool isActive = false,
    Color? activeColor,
    required ColorScheme colorScheme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isActive
                  ? (activeColor ?? colorScheme.primary)
                  : colorScheme.onSurfaceVariant,
            ),
            if (count > 0)
              Text(
                _formatCount(count),
                style: TextStyle(
                  fontSize: 10,
                  color: isActive
                      ? (activeColor ?? colorScheme.primary)
                      : colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 格式化数字
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
