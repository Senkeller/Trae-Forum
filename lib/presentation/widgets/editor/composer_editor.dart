import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'composer_toolbar.dart';
import 'composer_preview.dart';
import 'composer_attachment_panel.dart';
import 'emoji_picker_panel.dart';
import '../../../core/services/image_upload_service.dart';

/// Markdown 编辑器组件
///
/// 统一的 Markdown 编辑器，支持以下功能：
/// - Markdown 语法编辑（标题、加粗、斜体、删除线、引用、代码块、列表、分割线）
/// - 实时预览
/// - 工具栏快捷操作
/// - 附件管理
/// - 分屏/全屏模式切换
/// - 图片上传与 Markdown 插入
/// - 表情包选择
/// - 光标处插入内容
///
/// 使用示例：
/// ```dart
/// ComposerEditor(
///   initialText: '# 标题\n\n正文内容',
///   onTextChanged: (text) => print(text),
///   onSubmit: (text, attachments) => print('提交: $text'),
/// )
/// ```
class ComposerEditor extends StatefulWidget {
  /// 初始文本内容
  final String? initialText;

  /// 占位提示文字
  final String hintText;

  /// 文本变化回调
  final ValueChanged<String>? onTextChanged;

  /// 提交回调
  final Function(String text, List<AttachmentItem> attachments)? onSubmit;

  /// 最大输入长度
  final int? maxLength;

  /// 最小高度
  final double minHeight;

  /// 最大高度
  final double? maxHeight;

  /// 是否自动聚焦
  final bool autofocus;

  /// 是否显示预览
  final bool showPreview;

  /// 是否显示工具栏
  final bool showToolbar;

  /// 是否显示附件面板
  final bool showAttachmentPanel;

  /// 是否启用分屏模式
  final bool enableSplitView;

  /// 编辑器模式
  final ComposerEditorMode initialMode;

  /// 标题
  final String? title;

  /// 提交按钮文字
  final String submitButtonText;

  /// 是否显示表情按钮
  final bool enableEmojiPicker;

  /// 自定义表情包 URL 列表
  final List<String> stickerUrls;

  /// 图片上传接口地址
  final String? imageUploadUrl;

  /// 图片上传字段名
  final String imageUploadFieldName;

  /// 图片上传额外参数
  final Map<String, dynamic>? imageUploadExtraData;

  /// 构造函数
  ///
  /// [initialText] 初始文本内容
  /// [hintText] 占位提示文字，默认 "请输入内容..."
  /// [onTextChanged] 文本变化回调
  /// [onSubmit] 提交回调，返回文本内容和附件列表
  /// [maxLength] 最大输入长度
  /// [minHeight] 最小高度，默认 200
  /// [maxHeight] 最大高度
  /// [autofocus] 是否自动聚焦，默认 false
  /// [showPreview] 是否显示预览，默认 true
  /// [showToolbar] 是否显示工具栏，默认 true
  /// [showAttachmentPanel] 是否显示附件面板，默认 false
  /// [enableSplitView] 是否启用分屏模式，默认 true
  /// [initialMode] 初始编辑器模式，默认 ComposerEditorMode.edit
  /// [title] 编辑器标题
  /// [submitButtonText] 提交按钮文字，默认 "发布"
  /// [enableEmojiPicker] 是否启用表情包选择器，默认 true
  /// [stickerUrls] 自定义表情包 URL 列表
  /// [imageUploadUrl] 图片上传接口地址
  /// [imageUploadFieldName] 图片上传字段名，默认 'file'
  /// [imageUploadExtraData] 图片上传额外参数
  const ComposerEditor({
    super.key,
    this.initialText,
    this.hintText = '请输入内容...',
    this.onTextChanged,
    this.onSubmit,
    this.maxLength,
    this.minHeight = 200,
    this.maxHeight,
    this.autofocus = false,
    this.showPreview = true,
    this.showToolbar = true,
    this.showAttachmentPanel = false,
    this.enableSplitView = true,
    this.initialMode = ComposerEditorMode.edit,
    this.title,
    this.submitButtonText = '发布',
    this.enableEmojiPicker = true,
    this.stickerUrls = const [],
    this.imageUploadUrl,
    this.imageUploadFieldName = 'file',
    this.imageUploadExtraData,
  });

  @override
  State<ComposerEditor> createState() => _ComposerEditorState();
}

/// 编辑器模式枚举
enum ComposerEditorMode {
  /// 编辑模式
  edit,

  /// 预览模式
  preview,

  /// 分屏模式
  split,
}

class _ComposerEditorState extends State<ComposerEditor> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  late final ScrollController _scrollController;
  late ComposerEditorMode _currentMode;
  final List<AttachmentItem> _attachments = [];
  bool _isComposing = false;
  bool _showEmojiPicker = false;

  final ImageUploadService _uploadService = ImageUploadService();

  /// URL 正则表达式模式（用于粘贴识别）
  static final RegExp _urlPattern = RegExp(
    r'^(https?:\/\/)?' // 协议（可选）
    r'(([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,})' // 域名
    r'(:\d+)?' // 端口（可选）
    r'(\/[^\s]*)?' // 路径（可选）
    r'$',
    caseSensitive: false,
  );

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    _currentMode = widget.initialMode;
    _isComposing = widget.initialText?.isNotEmpty ?? false;

    _controller.addListener(_handleTextChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 处理文本变化
  void _handleTextChange() {
    final isComposing = _controller.text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
      });
    }
    widget.onTextChanged?.call(_controller.text);
  }

  /// 处理工具栏操作
  void _handleToolbarAction(MarkdownSyntax syntax, String? insertedText) {
    _insertMarkdownSyntax(syntax, insertedText);
  }

  /// 在光标处插入文本
  ///
  /// [text] 要插入的文本
  /// [selectInserted] 是否选中插入的文本，默认 false
  void insertTextAtCursor(String text, {bool selectInserted = false}) {
    final currentText = _controller.text;
    final selection = _controller.selection;
    final start = selection.start;
    final end = selection.end;

    // 确保光标位置有效
    final validStart = start < 0 ? 0 : start;
    final validEnd = end < 0 ? validStart : end;

    final before = currentText.substring(0, validStart);
    final after = currentText.substring(validEnd);

    final newText = '$before$text$after';
    final newCursorPosition = validStart + text.length;

    _controller.value = TextEditingValue(
      text: newText,
      selection: selectInserted
          ? TextSelection(baseOffset: validStart, extentOffset: newCursorPosition)
          : TextSelection.collapsed(offset: newCursorPosition),
    );

    _focusNode.requestFocus();
  }

  /// 插入 Markdown 图片语法
  ///
  /// [imageUrl] 图片 URL
  /// [altText] 图片描述文字，默认 '图片'
  void insertImageMarkdown(String imageUrl, {String altText = '图片'}) {
    final markdown = '![$altText]($imageUrl)';
    insertTextAtCursor(markdown);
  }

  /// 上传图片并插入 Markdown
  ///
  /// [filePath] 本地图片文件路径
  /// [altText] 图片描述文字
  Future<void> uploadAndInsertImage(String filePath, {String altText = '图片'}) async {
    // 先插入占位符
    final placeholder = '![$altText](上传中...)';
    insertTextAtCursor(placeholder);

    // 记录占位符位置
    final placeholderStart = _controller.text.indexOf(placeholder);

    // 执行上传
    final result = await _uploadService.uploadImage(
      filePath: filePath,
      uploadUrl: widget.imageUploadUrl ?? '/upload/image',
      fieldName: widget.imageUploadFieldName,
      additionalData: widget.imageUploadExtraData,
    );

    if (result.success && result.imageUrl != null) {
      // 上传成功，替换占位符
      final newMarkdown = '![$altText](${result.imageUrl})';
      final newText = _controller.text.replaceFirst(placeholder, newMarkdown);
      
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: placeholderStart + newMarkdown.length,
        ),
      );

      // 添加到附件列表
      _handleAttachmentAdded(
        AttachmentItem.image(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: result.fileName ?? 'image.jpg',
          remoteUrl: result.imageUrl,
          uploadStatus: UploadStatus.success,
        ),
      );
    } else {
      // 上传失败，替换为错误标记
      final errorMarkdown = '![$altText](上传失败: ${result.errorMessage})';
      final newText = _controller.text.replaceFirst(placeholder, errorMarkdown);
      
      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: newText.indexOf(errorMarkdown) + errorMarkdown.length,
        ),
      );

      // 显示错误提示
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('图片上传失败: ${result.errorMessage}'),
          action: SnackBarAction(
            label: '重试',
            onPressed: () => uploadAndInsertImage(filePath, altText: altText),
          ),
        ),
      );
    }

    _focusNode.requestFocus();
  }

  /// 插入 Markdown 语法
  void _insertMarkdownSyntax(MarkdownSyntax syntax, String? selectedText) {
    final text = _controller.text;
    final selection = _controller.selection;
    final start = selection.start;
    final end = selection.end;

    String before = text.substring(0, start);
    String selected = selectedText ?? text.substring(start, end);
    String after = text.substring(end);

    String newText;
    int cursorOffset;

    switch (syntax) {
      case MarkdownSyntax.heading:
        newText = '$before# $selected$after';
        cursorOffset = start + 2 + selected.length;
        break;
      case MarkdownSyntax.heading2:
        newText = '$before## $selected$after';
        cursorOffset = start + 3 + selected.length;
        break;
      case MarkdownSyntax.heading3:
        newText = '$before### $selected$after';
        cursorOffset = start + 4 + selected.length;
        break;
      case MarkdownSyntax.bold:
        newText = '$before**$selected**$after';
        cursorOffset = start + 2 + selected.length + 2;
        break;
      case MarkdownSyntax.italic:
        newText = '$before*$selected*$after';
        cursorOffset = start + 1 + selected.length + 1;
        break;
      case MarkdownSyntax.strikethrough:
        newText = '$before~~$selected~~$after';
        cursorOffset = start + 2 + selected.length + 2;
        break;
      case MarkdownSyntax.quote:
        newText = '$before> $selected$after';
        cursorOffset = start + 2 + selected.length;
        break;
      case MarkdownSyntax.code:
        newText = '$before`$selected`$after';
        cursorOffset = start + 1 + selected.length + 1;
        break;
      case MarkdownSyntax.codeBlock:
        newText = '$before```\n$selected\n```$after';
        cursorOffset = start + 4 + selected.length + 4;
        break;
      case MarkdownSyntax.unorderedList:
        newText = '$before- $selected$after';
        cursorOffset = start + 2 + selected.length;
        break;
      case MarkdownSyntax.orderedList:
        newText = '${before}1. $selected$after';
        cursorOffset = start + 3 + selected.length;
        break;
      case MarkdownSyntax.divider:
        newText = '$before\n---\n$selected$after';
        cursorOffset = start + 5 + selected.length;
        break;
      case MarkdownSyntax.link:
        // 如果有选中文本，将其作为链接文本
        if (selected.isNotEmpty) {
          newText = '$before[$selected](url)$after';
          cursorOffset = start + selected.length + 3;
        } else {
          newText = '$before[链接文字](url)$after';
          cursorOffset = start + 10;
        }
        break;
      case MarkdownSyntax.image:
        newText = '$before![图片描述](url)$after';
        cursorOffset = start + 12;
        break;
    }

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );

    _focusNode.requestFocus();
  }

  /// 处理链接插入
  ///
  /// [text] 链接显示文本
  /// [url] 链接 URL
  void _handleLinkInsert({
    required String text,
    required String url,
    required bool isValid,
    String? errorMessage,
  }) {
    if (!isValid) return;

    final selection = _controller.selection;
    final start = selection.start;
    final end = selection.end;
    final fullText = _controller.text;

    String before = fullText.substring(0, start);
    String after = fullText.substring(end);

    // 自动补全协议
    String normalizedUrl = url;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      normalizedUrl = 'https://$url';
    }

    // 插入 Markdown 链接
    String newText = '$before[$text]($normalizedUrl)$after';
    int cursorOffset = start + text.length + normalizedUrl.length + 4;

    _controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: cursorOffset),
    );

    _focusNode.requestFocus();
  }

  /// 检查文本是否为有效的 URL
  bool _isValidUrl(String text) {
    String normalizedUrl = text.trim();
    if (!normalizedUrl.startsWith('http://') &&
        !normalizedUrl.startsWith('https://')) {
      normalizedUrl = 'https://$normalizedUrl';
    }
    return _urlPattern.hasMatch(normalizedUrl);
  }

  /// 处理粘贴事件
  ///
  /// 如果粘贴的内容是 URL，自动转换为 Markdown 链接格式
  void _handlePaste(TextSelection selection, String pastedText) {
    final trimmedText = pastedText.trim();

    // 检查粘贴的内容是否为 URL
    if (_isValidUrl(trimmedText)) {
      // 自动补全协议
      String normalizedUrl = trimmedText;
      if (!trimmedText.startsWith('http://') &&
          !trimmedText.startsWith('https://')) {
        normalizedUrl = 'https://$trimmedText';
      }

      final text = _controller.text;
      final start = selection.start;
      final end = selection.end;
      String before = text.substring(0, start);
      String after = text.substring(end);

      // 转换为 Markdown 链接格式
      String newText = '$before[$normalizedUrl]($normalizedUrl)$after';
      int cursorOffset = start + normalizedUrl.length * 2 + 4;

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: cursorOffset),
      );
    } else {
      // 普通粘贴
      final text = _controller.text;
      final start = selection.start;
      final end = selection.end;
      String before = text.substring(0, start);
      String after = text.substring(end);

      String newText = before + pastedText + after;
      int cursorOffset = start + pastedText.length;

      _controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: cursorOffset),
      );
    }
  }

  /// 切换编辑器模式
  void _switchMode(ComposerEditorMode mode) {
    setState(() {
      _currentMode = mode;
    });
  }

  /// 切换表情选择器显示
  void _toggleEmojiPicker() {
    setState(() {
      _showEmojiPicker = !_showEmojiPicker;
    });
    if (_showEmojiPicker) {
      _focusNode.unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  /// 处理表情选择
  void _onEmojiSelected(String emoji) {
    insertTextAtCursor(emoji);
  }

  /// 处理表情包选择
  void _onStickerSelected(String imageUrl) {
    insertImageMarkdown(imageUrl, altText: '表情包');
    setState(() {
      _showEmojiPicker = false;
    });
  }

  /// 处理附件添加
  void _handleAttachmentAdded(AttachmentItem attachment) {
    setState(() {
      _attachments.add(attachment);
    });
  }

  /// 处理附件删除
  void _handleAttachmentRemoved(AttachmentItem attachment) {
    setState(() {
      _attachments.remove(attachment);
    });
  }

  /// 重试上传失败的附件
  Future<void> _retryAttachmentUpload(AttachmentItem attachment) async {
    if (attachment.localPath == null) return;

    // 更新附件状态为上传中
    final index = _attachments.indexWhere((a) => a.id == attachment.id);
    if (index == -1) return;

    setState(() {
      _attachments[index] = attachment.copyWith(
        uploadStatus: UploadStatus.uploading,
        uploadProgress: 0.0,
        errorMessage: null,
      );
    });

    // 执行上传
    final result = await _uploadService.uploadImage(
      filePath: attachment.localPath!,
      uploadUrl: widget.imageUploadUrl ?? '/upload/image',
      fieldName: widget.imageUploadFieldName,
      additionalData: widget.imageUploadExtraData,
      onProgress: (progress) {
        setState(() {
          _attachments[index] = _attachments[index].copyWith(
            uploadProgress: progress,
          );
        });
      },
    );

    // 更新附件状态
    setState(() {
      if (result.success && result.imageUrl != null) {
        _attachments[index] = _attachments[index].copyWith(
          remoteUrl: result.imageUrl,
          uploadStatus: UploadStatus.success,
          uploadProgress: 1.0,
        );

        // 同时插入 Markdown
        insertImageMarkdown(result.imageUrl!, altText: attachment.name);
      } else {
        _attachments[index] = _attachments[index].copyWith(
          uploadStatus: UploadStatus.failed,
          errorMessage: result.errorMessage,
        );
      }
    });
  }

  /// 处理提交
  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit?.call(text, List.unmodifiable(_attachments));
    }
  }

  /// 获取当前选中的文本
  String? _getSelectedText() {
    final selection = _controller.selection;
    if (selection.isValid && !selection.isCollapsed) {
      return _controller.text.substring(selection.start, selection.end);
    }
    return null;
  }

  /// 获取当前光标位置
  int get cursorPosition => _controller.selection.baseOffset;

  /// 设置光标位置
  set cursorPosition(int position) {
    _controller.selection = TextSelection.collapsed(
      offset: position.clamp(0, _controller.text.length),
    );
  }

  /// 显示链接插入对话框
  void _showLinkDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => LinkInsertDialog(
        initialText: _getSelectedText(),
        onConfirm: _handleLinkInsert,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 标题栏
        if (widget.title != null) _buildHeader(context),

        // 模式切换栏
        if (widget.enableSplitView && widget.showPreview)
          _buildModeSwitcher(context),

        // 编辑器主体
        Flexible(
          child: _buildEditorBody(context),
        ),

        // 附件面板
        if (widget.showAttachmentPanel)
          ComposerAttachmentPanel(
            attachments: _attachments,
            onAttachmentAdded: _handleAttachmentAdded,
            onAttachmentRemoved: _handleAttachmentRemoved,
            onAttachmentTap: (attachment) {
              if (attachment.uploadStatus == UploadStatus.failed) {
                _retryAttachmentUpload(attachment);
              }
            },
          ),

        // 表情选择器
        if (_showEmojiPicker && widget.enableEmojiPicker)
          EmojiPickerPanel(
            onEmojiSelected: _onEmojiSelected,
            onStickerSelected: _onStickerSelected,
            stickerUrls: widget.stickerUrls,
            height: 300,
          ),

        // 工具栏
        if (widget.showToolbar)
          ComposerToolbar(
            onAction: _handleToolbarAction,
            selectedText: _getSelectedText(),
            onLinkTap: () => _showLinkDialog(context),
          ),

        // 底部操作栏
        _buildBottomBar(context),
      ],
    );
  }

  /// 构建标题栏
  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            widget.title!,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建模式切换栏
  Widget _buildModeSwitcher(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          _buildModeButton(
            context,
            label: '编辑',
            icon: Icons.edit,
            mode: ComposerEditorMode.edit,
          ),
          const SizedBox(width: 8),
          _buildModeButton(
            context,
            label: '预览',
            icon: Icons.visibility,
            mode: ComposerEditorMode.preview,
          ),
          if (widget.enableSplitView) ...[
            const SizedBox(width: 8),
            _buildModeButton(
              context,
              label: '分屏',
              icon: Icons.splitscreen,
              mode: ComposerEditorMode.split,
            ),
          ],
        ],
      ),
    );
  }

  /// 构建模式切换按钮
  Widget _buildModeButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required ComposerEditorMode mode,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _currentMode == mode;

    return GestureDetector(
      onTap: () => _switchMode(mode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建编辑器主体
  Widget _buildEditorBody(BuildContext context) {
    switch (_currentMode) {
      case ComposerEditorMode.edit:
        return _buildTextField(context);
      case ComposerEditorMode.preview:
        return _buildPreview(context);
      case ComposerEditorMode.split:
        return _buildSplitView(context);
    }
  }

  /// 构建文本输入框
  Widget _buildTextField(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      constraints: BoxConstraints(
        minHeight: widget.minHeight,
        maxHeight: widget.maxHeight ?? double.infinity,
      ),
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: widget.autofocus,
        maxLines: null,
        maxLength: widget.maxLength,
        scrollController: _scrollController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          counterText: '',
        ),
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 16,
          height: 1.6,
        ),
        contextMenuBuilder: _buildContextMenu,
      ),
    );
  }

  /// 构建自定义上下文菜单
  ///
  /// 拦截粘贴操作，实现 URL 自动识别转换为链接
  Widget _buildContextMenu(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    final List<ContextMenuButtonItem> buttonItems =
        editableTextState.contextMenuButtonItems;

    // 查找并替换粘贴按钮
    final List<ContextMenuButtonItem> modifiedButtonItems =
        buttonItems.map((item) {
      if (item.type == ContextMenuButtonType.paste) {
        return ContextMenuButtonItem(
          label: item.label,
          onPressed: () async {
            // 获取剪贴板内容
            final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
            final pastedText = clipboardData?.text;

            if (pastedText != null && pastedText.isNotEmpty) {
              // 检查是否为 URL，如果是则自动转换
              if (_isValidUrl(pastedText.trim())) {
                _handlePaste(editableTextState.textEditingValue.selection,
                    pastedText);
              } else {
                // 普通粘贴，使用默认行为
                editableTextState.pasteText(SelectionChangedCause.toolbar);
              }
            }
          },
        );
      }
      return item;
    }).toList();

    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: modifiedButtonItems,
    );
  }

  /// 构建预览区域
  Widget _buildPreview(BuildContext context) {
    return ComposerPreview(
      markdownText: _controller.text,
      emptyHint: '暂无内容',
    );
  }

  /// 构建分屏视图
  Widget _buildSplitView(BuildContext context) {
    return Row(
      children: [
        // 编辑区域
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
            ),
            child: _buildTextField(context),
          ),
        ),
        // 预览区域
        Expanded(
          child: _buildPreview(context),
        ),
      ],
    );
  }

  /// 构建底部操作栏
  Widget _buildBottomBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          // 字数统计
          if (widget.maxLength != null)
            Text(
              '${_controller.text.length}/${widget.maxLength}',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            )
          else
            Text(
              '${_controller.text.length} 字',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            ),

          const Spacer(),

          // 提交按钮
          GestureDetector(
            onTap: _isComposing ? _handleSubmit : null,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: _isComposing
                    ? colorScheme.primary
                    : colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.submitButtonText,
                style: TextStyle(
                  color: _isComposing
                      ? colorScheme.onPrimary
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Markdown 语法类型枚举
enum MarkdownSyntax {
  /// 一级标题
  heading,

  /// 二级标题
  heading2,

  /// 三级标题
  heading3,

  /// 加粗
  bold,

  /// 斜体
  italic,

  /// 删除线
  strikethrough,

  /// 引用
  quote,

  /// 行内代码
  code,

  /// 代码块
  codeBlock,

  /// 无序列表
  unorderedList,

  /// 有序列表
  orderedList,

  /// 分割线
  divider,

  /// 链接
  link,

  /// 图片
  image,
}
