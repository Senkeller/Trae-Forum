import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../providers/settings_provider.dart';

enum _QuickToolbarAction { heading, bold, italic, quote, codeBlock, list }

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
  const QuickCommentSheet({super.key, required this.topicId, this.onSubmit});

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
      builder: (context) =>
          QuickCommentSheet(topicId: topicId, onSubmit: onSubmit),
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

  /// 是否正在上传图片
  bool _isUploadingImage = false;

  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();

    // 延迟获取焦点，确保面板动画完成
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  TextSelection _safeSelection() {
    final selection = _controller.selection;
    final textLength = _controller.text.length;
    final start = selection.start.clamp(0, textLength);
    final end = selection.end.clamp(0, textLength);
    return TextSelection(baseOffset: start, extentOffset: end);
  }

  bool _canEdit() => !_isLoading && !_isUploadingImage;

  bool _isCurrentLinePrefixed(String prefix) {
    final text = _controller.text;
    if (text.isEmpty) return false;
    final selection = _safeSelection();
    final cursor = selection.start;
    final lineStart = text.lastIndexOf('\n', cursor - 1);
    final startIndex = lineStart == -1 ? 0 : lineStart + 1;
    final lineEndRaw = text.indexOf('\n', cursor);
    final lineEnd = lineEndRaw == -1 ? text.length : lineEndRaw;
    final line = text.substring(startIndex, lineEnd).trimLeft();
    return line.startsWith(prefix);
  }

  bool _isCurrentLineList() {
    final text = _controller.text;
    if (text.isEmpty) return false;
    final selection = _safeSelection();
    final cursor = selection.start;
    final lineStart = text.lastIndexOf('\n', cursor - 1);
    final startIndex = lineStart == -1 ? 0 : lineStart + 1;
    final lineEndRaw = text.indexOf('\n', cursor);
    final lineEnd = lineEndRaw == -1 ? text.length : lineEndRaw;
    final line = text.substring(startIndex, lineEnd).trimLeft();
    return line.startsWith('- ') ||
        line.startsWith('* ') ||
        RegExp(r'^\d+\.\s').hasMatch(line);
  }

  bool _hasInlineMarker(String marker) {
    final text = _controller.text;
    if (text.isEmpty) return false;
    final selection = _safeSelection();
    final start = selection.start;
    final end = selection.end;

    if (start != end) {
      if (start < marker.length || end + marker.length > text.length) {
        return false;
      }
      final left = text.substring(start - marker.length, start);
      final right = text.substring(end, end + marker.length);
      return left == marker && right == marker;
    }

    final cursor = start;
    final left = text.lastIndexOf(marker, cursor - 1);
    if (left == -1) return false;
    final right = text.indexOf(marker, left + marker.length);
    if (right == -1 || right <= left + marker.length) return false;
    final contentStart = left + marker.length;
    return cursor >= contentStart && cursor <= right;
  }

  bool _hasItalicMarker() {
    if (_hasInlineMarker('**')) return false;
    return _hasInlineMarker('*');
  }

  bool _isInCodeBlock() {
    final text = _controller.text;
    if (text.isEmpty) return false;
    final selection = _safeSelection();
    final beforeCursor = text.substring(0, selection.start);
    final fenceCount = RegExp(r'```').allMatches(beforeCursor).length;
    return fenceCount.isOdd;
  }

  Set<_QuickToolbarAction> _activeToolbarActions() {
    final actions = <_QuickToolbarAction>{};
    if (_isCurrentLinePrefixed('# ')) {
      actions.add(_QuickToolbarAction.heading);
    }
    if (_isCurrentLinePrefixed('> ')) {
      actions.add(_QuickToolbarAction.quote);
    }
    if (_isCurrentLineList()) {
      actions.add(_QuickToolbarAction.list);
    }
    if (_hasInlineMarker('**')) {
      actions.add(_QuickToolbarAction.bold);
    }
    if (_hasItalicMarker()) {
      actions.add(_QuickToolbarAction.italic);
    }
    if (_isInCodeBlock()) {
      actions.add(_QuickToolbarAction.codeBlock);
    }
    return actions;
  }

  void _updateText(String value, {int? cursor, TextSelection? selection}) {
    final safeCursor = (cursor ?? value.length).clamp(0, value.length);
    _controller.value = TextEditingValue(
      text: value,
      selection: selection ?? TextSelection.collapsed(offset: safeCursor),
    );
    _focusNode.requestFocus();
  }

  void _wrapSelection(String prefix, String suffix) {
    if (!_canEdit()) return;
    final original = _controller.text;
    final selection = _safeSelection();
    final start = selection.start;
    final end = selection.end;
    final selected = original.substring(start, end);
    final replacement = '$prefix$selected$suffix';
    final updated = original.replaceRange(start, end, replacement);

    if (start == end) {
      _updateText(updated, cursor: start + prefix.length);
      return;
    }
    final newStart = start + prefix.length;
    final newEnd = newStart + selected.length;
    _updateText(
      updated,
      selection: TextSelection(baseOffset: newStart, extentOffset: newEnd),
    );
  }

  void _toggleInlineMarker(String marker) {
    if (!_canEdit()) return;
    if (_tryUnwrapInlineMarker(marker)) return;
    _wrapSelection(marker, marker);
  }

  bool _tryUnwrapInlineMarker(String marker) {
    final original = _controller.text;
    final selection = _safeSelection();
    final start = selection.start;
    final end = selection.end;

    if (start != end) {
      if (start < marker.length || end + marker.length > original.length) {
        return false;
      }
      final left = original.substring(start - marker.length, start);
      final right = original.substring(end, end + marker.length);
      if (left != marker || right != marker) return false;

      final removedRight = original.replaceRange(end, end + marker.length, '');
      final updated = removedRight.replaceRange(
        start - marker.length,
        start,
        '',
      );
      final newStart = start - marker.length;
      final selectedLen = end - start;
      _updateText(
        updated,
        selection: TextSelection(
          baseOffset: newStart,
          extentOffset: newStart + selectedLen,
        ),
      );
      return true;
    }

    final cursor = start;
    final leftMarker = original.lastIndexOf(marker, cursor - 1);
    if (leftMarker == -1) return false;
    final rightMarker = original.indexOf(marker, leftMarker + marker.length);
    if (rightMarker == -1 || rightMarker <= leftMarker + marker.length) {
      return false;
    }
    final contentStart = leftMarker + marker.length;
    if (cursor < contentStart || cursor > rightMarker) return false;

    final removedRight = original.replaceRange(
      rightMarker,
      rightMarker + marker.length,
      '',
    );
    final updated = removedRight.replaceRange(
      leftMarker,
      leftMarker + marker.length,
      '',
    );
    final newCursor = (cursor - marker.length).clamp(0, updated.length);
    _updateText(updated, cursor: newCursor);
    return true;
  }

  void _toggleLinePrefix(String prefix) {
    if (!_canEdit()) return;
    final original = _controller.text;
    final selection = _safeSelection();
    final start = selection.start;
    final end = selection.end;
    final lineStartRaw = original.lastIndexOf('\n', start - 1);
    final lineStart = lineStartRaw == -1 ? 0 : lineStartRaw + 1;
    final lineEndRaw = original.indexOf('\n', end);
    final lineEnd = lineEndRaw == -1 ? original.length : lineEndRaw;
    final line = original.substring(lineStart, lineEnd);
    final indentLength = line.length - line.trimLeft().length;
    final prefixStart = lineStart + indentLength;
    final trimmed = line.trimLeft();

    if (trimmed.startsWith(prefix)) {
      final updated = original.replaceRange(
        prefixStart,
        prefixStart + prefix.length,
        '',
      );
      final newStart = (start - prefix.length).clamp(0, updated.length);
      final newEnd = (end - prefix.length).clamp(0, updated.length);
      _updateText(
        updated,
        selection: TextSelection(baseOffset: newStart, extentOffset: newEnd),
      );
      return;
    }

    final updated = original.replaceRange(prefixStart, prefixStart, prefix);
    final newStart = (start + prefix.length).clamp(0, updated.length);
    final newEnd = (end + prefix.length).clamp(0, updated.length);
    _updateText(
      updated,
      selection: TextSelection(baseOffset: newStart, extentOffset: newEnd),
    );
  }

  void _toggleCodeBlock() {
    if (!_canEdit()) return;
    if (_isInCodeBlock()) {
      _removeCurrentCodeBlockFence();
      return;
    }
    _wrapSelection('\n```\n', '\n```\n');
  }

  void _removeCurrentCodeBlockFence() {
    final original = _controller.text;
    if (original.isEmpty) return;
    final selection = _safeSelection();
    final cursor = selection.start;
    final leftFence = original.lastIndexOf('```', cursor);
    if (leftFence == -1) return;
    final rightFence = original.indexOf('```', cursor);
    if (rightFence == -1 || rightFence <= leftFence) return;

    final removedRight = original.replaceRange(rightFence, rightFence + 3, '');
    final updated = removedRight.replaceRange(leftFence, leftFence + 3, '');
    final newCursor = (cursor - 3).clamp(0, updated.length);
    _updateText(updated, cursor: newCursor);
  }

  void _insertTemplate(String template, {int? cursorOffset}) {
    if (!_canEdit()) return;
    final original = _controller.text;
    final selection = _safeSelection();
    final start = selection.start;
    final end = selection.end;
    final updated = original.replaceRange(start, end, template);
    final cursor = cursorOffset != null
        ? (start + cursorOffset).clamp(0, updated.length)
        : start + template.length;
    _updateText(updated, cursor: cursor);
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

  /// 从设备选择图片并插入到评论中
  Future<void> _pickImagesFromDevice() async {
    if (_isLoading || _isUploadingImage) return;

    try {
      final quality = ref.read(imageQualityProvider).imagePickerQuality;
      final files = await _imagePicker.pickMultiImage(imageQuality: quality);
      if (files.isEmpty || !mounted) return;

      setState(() {
        _isUploadingImage = true;
      });

      final repository = ref.read(commentRepositoryProvider);
      final markdowns = <String>[];
      String? firstError;

      for (final file in files) {
        final result = await repository.uploadCommentImage(
          filePath: file.path,
          fileName: file.name,
        );
        if (result.success && result.markdown != null) {
          markdowns.add(result.markdown!);
        } else {
          firstError ??= result.errorMessage;
        }
      }

      if (!mounted) return;

      if (markdowns.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(firstError ?? '上传表情包失败，请稍后重试。'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }

      final oldText = _controller.text.trimRight();
      final appendText = markdowns.join('\n');
      final merged = oldText.isEmpty ? appendText : '$oldText\n$appendText';
      _controller.value = TextEditingValue(
        text: merged,
        selection: TextSelection.collapsed(offset: merged.length),
      );
      _focusNode.requestFocus();

      final failedCount = files.length - markdowns.length;
      if (failedCount > 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('已添加 ${markdowns.length} 张图片，$failedCount 张上传失败。'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('上传表情包失败，请稍后重试。'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isUploadingImage = false;
        });
      }
    }
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
        constraints: const BoxConstraints(maxHeight: 400, minHeight: 200),
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
            Flexible(child: _buildInputArea(context)),
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
            color: colorScheme.outline.withValues(alpha: 0.3),
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
            color: colorScheme.outline.withValues(alpha: 0.2),
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

    return Semantics(
      label: '评论输入框',
      hint: '输入评论内容，支持 Markdown 格式',
      textField: true,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 120),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
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
              hintText: '说点什么（支持 Markdown）...',
              hintStyle: TextStyle(color: colorScheme.onSurfaceVariant),
              contentPadding: const EdgeInsets.all(12),
              border: InputBorder.none,
              counterText: '',
              labelText: '评论内容',
            ),
            style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
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
            color: colorScheme.outline.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
      ),
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: _controller,
        builder: (context, value, _) {
          final hasText = value.text.trim().isNotEmpty;
          final activeActions = _activeToolbarActions();
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  _buildIconButton(
                    context,
                    icon: _isUploadingImage
                        ? Icons.hourglass_top
                        : Icons.image_outlined,
                    onTap: _isUploadingImage ? null : _pickImagesFromDevice,
                  ),
                  const Spacer(),
                  Text(
                    '${value.text.length}/500',
                    style: TextStyle(
                      fontSize: 12,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 12),
                  _buildSendButton(context, hasText: hasText),
                ],
              ),
              const SizedBox(height: 6),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildMdToolButton(
                      icon: Icons.title,
                      tooltip: '标题',
                      active: activeActions.contains(
                        _QuickToolbarAction.heading,
                      ),
                      onTap: () => _toggleLinePrefix('# '),
                    ),
                    _buildMdToolButton(
                      icon: Icons.format_bold,
                      tooltip: '加粗',
                      active: activeActions.contains(_QuickToolbarAction.bold),
                      onTap: () => _toggleInlineMarker('**'),
                    ),
                    _buildMdToolButton(
                      icon: Icons.format_italic,
                      tooltip: '斜体',
                      active: activeActions.contains(
                        _QuickToolbarAction.italic,
                      ),
                      onTap: () => _toggleInlineMarker('*'),
                    ),
                    _buildMdToolButton(
                      icon: Icons.format_quote,
                      tooltip: '引用',
                      active: activeActions.contains(_QuickToolbarAction.quote),
                      onTap: () => _toggleLinePrefix('> '),
                    ),
                    _buildMdToolButton(
                      icon: Icons.code,
                      tooltip: '代码块',
                      active: activeActions.contains(
                        _QuickToolbarAction.codeBlock,
                      ),
                      onTap: _toggleCodeBlock,
                    ),
                    _buildMdToolButton(
                      icon: Icons.link,
                      tooltip: '链接',
                      onTap: () =>
                          _insertTemplate('[链接文本](https://)', cursorOffset: 1),
                    ),
                    _buildMdToolButton(
                      icon: Icons.format_list_bulleted,
                      tooltip: '列表',
                      active: activeActions.contains(_QuickToolbarAction.list),
                      onTap: () => _toggleLinePrefix('- '),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 构建图标按钮
  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    VoidCallback? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: icon == Icons.hourglass_top
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorScheme.primary,
                ),
              )
            : Icon(icon, size: 24, color: colorScheme.onSurfaceVariant),
      ),
    );
  }

  Widget _buildMdToolButton({
    required IconData icon,
    required String tooltip,
    bool active = false,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        visualDensity: VisualDensity.compact,
        style: IconButton.styleFrom(
          backgroundColor: active
              ? const Color(0xFFDFF4E8)
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
          foregroundColor: active
              ? const Color(0xFF0B8A6A)
              : colorScheme.onSurfaceVariant,
          minimumSize: const Size(32, 32),
        ),
        icon: Icon(icon, size: 17),
      ),
    );
  }

  /// 构建发送按钮
  Widget _buildSendButton(BuildContext context, {required bool hasText}) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label: '发送评论',
      hint: hasText ? '双击发送评论' : '请先输入评论内容',
      button: true,
      enabled: hasText && !_isLoading && !_isUploadingImage,
      child: GestureDetector(
        onTap: hasText && !_isLoading && !_isUploadingImage ? _handleSend : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: hasText && !_isLoading && !_isUploadingImage
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
                    color: hasText
                        ? colorScheme.onPrimary
                        : colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
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
