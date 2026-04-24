import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/repositories/comment_repository.dart';

/// 快速评论输入面板
///
/// 一个底部弹出的快速评论输入面板，支持：
/// - 多行文本输入（最大高度 120px）
/// - 表情选择按钮
/// - 发送按钮
/// - 自动获取焦点
/// - 发送加载状态
/// - 发送成功回调
///
/// 使用示例：
/// ```dart
/// QuickCommentSheet.show(
///   context: context,
///   topicId: 123,
///   onSubmit: (content) {
///     print('评论内容: $content');
///   },
/// );
/// ```
class QuickCommentSheet extends ConsumerStatefulWidget {
  /// 话题ID
  final int topicId;

  /// 提交回调
  final Function(String content)? onSubmit;

  /// 构造函数
  ///
  /// [topicId] 话题ID（必填）
  /// [onSubmit] 提交成功回调（可选）
  const QuickCommentSheet({
    super.key,
    required this.topicId,
    this.onSubmit,
  });

  /// 显示快速评论面板
  ///
  /// [context] BuildContext
  /// [topicId] 话题ID
  /// [onSubmit] 提交成功回调
  static Future<void> show({
    required BuildContext context,
    required int topicId,
    Function(String content)? onSubmit,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickCommentSheet(
        topicId: topicId,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  ConsumerState<QuickCommentSheet> createState() => _QuickCommentSheetState();
}

class _QuickCommentSheetState extends ConsumerState<QuickCommentSheet> {
  /// 文本控制器
  late final TextEditingController _controller;

  /// 焦点节点
  late final FocusNode _focusNode;

  /// 是否正在发送
  bool _isLoading = false;

  /// 是否有输入内容
  bool _hasContent = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _controller.addListener(_handleTextChange);

    // 延迟获取焦点，确保面板动画完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  /// 处理文本变化
  void _handleTextChange() {
    final hasContent = _controller.text.trim().isNotEmpty;
    if (hasContent != _hasContent) {
      setState(() {
        _hasContent = hasContent;
      });
    }
  }

  /// 处理发送
  Future<void> _handleSend() async {
    final content = _controller.text.trim();
    if (content.isEmpty || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final repository = ref.read(commentRepositoryProvider);
      final result = await repository.createComment(
        topicId: widget.topicId,
        content: content,
      );

      if (mounted) {
        if (result.success) {
          // 发送成功
          widget.onSubmit?.call(content);
          Navigator.of(context).pop();
        } else {
          // 发送失败
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result.errorMessage ?? '发送失败'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('发送失败: $e'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 处理表情按钮点击
  void _handleEmojiTap() {
    // TODO: 实现表情选择器
    // 这里可以展开表情面板或跳转到表情选择页面
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;
    final viewInsets = mediaQuery.viewInsets.bottom;

    return AnimatedPadding(
      padding: EdgeInsets.only(bottom: viewInsets),
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 400,
          minHeight: 200,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 顶部拖动条
            _buildDragHandle(context),
            // 标题栏
            _buildHeader(context),
            // 输入区域
            Flexible(
              child: _buildInputArea(context),
            ),
            // 底部工具栏
            _buildToolbar(context, bottomPadding),
          ],
        ),
      ),
    );
  }

  /// 构建顶部拖动条
  Widget _buildDragHandle(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
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
    );
  }

  /// 构建标题栏
  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // 关闭按钮
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.close,
              size: 24,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const Spacer(),
          // 标题
          Text(
            '发表评论',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          // 占位，保持标题居中
          const SizedBox(width: 24),
        ],
      ),
    );
  }

  /// 构建输入区域
  Widget _buildInputArea(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        constraints: const BoxConstraints(
          maxHeight: 120,
        ),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,
          maxLength: 500,
          textInputAction: TextInputAction.newline,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintText: '说点什么...',
            hintStyle: TextStyle(
              color: colorScheme.onSurfaceVariant,
            ),
            contentPadding: const EdgeInsets.all(12),
            border: InputBorder.none,
            counterText: '',
          ),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  /// 构建底部工具栏
  Widget _buildToolbar(BuildContext context, double bottomPadding) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: bottomPadding + 8,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // 表情按钮
          _buildIconButton(
            context,
            icon: Icons.emoji_emotions_outlined,
            onTap: _handleEmojiTap,
          ),
          const Spacer(),
          // 字数统计
          Text(
            '${_controller.text.length}/500',
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(width: 12),
          // 发送按钮
          _buildSendButton(context),
        ],
      ),
    );
  }

  /// 构建图标按钮
  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Icon(
          icon,
          size: 24,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }

  /// 构建发送按钮
  Widget _buildSendButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _hasContent && !_isLoading ? _handleSend : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: _hasContent && !_isLoading
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: _isLoading
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
                  color: _hasContent
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

/// 快速评论面板扩展方法
///
/// 为 BuildContext 添加显示快速评论面板的便捷方法
extension QuickCommentSheetExtension on BuildContext {
  /// 显示快速评论面板
  ///
  /// [topicId] 话题ID
  /// [onSubmit] 提交成功回调
  Future<void> showQuickCommentSheet({
    required int topicId,
    Function(String content)? onSubmit,
  }) async {
    await QuickCommentSheet.show(
      context: this,
      topicId: topicId,
      onSubmit: onSubmit,
    );
  }
}
