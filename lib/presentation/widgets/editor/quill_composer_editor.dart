import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:markdown_quill/markdown_quill.dart';
import 'package:markdown/markdown.dart' as md;

/// Quill 富文本编辑器组件
///
/// 基于 flutter_quill 的统一编辑器，支持：
/// - 富文本编辑（加粗、斜体、标题、列表等）
/// - Markdown 格式导入/导出
/// - 图片上传与插入
///
/// 使用示例：
/// ```dart
/// QuillComposerEditor(
///   initialText: '# 标题\n\n正文内容',
///   onTextChanged: (text) => print(text),
///   onSubmit: (text) => print('提交: $text'),
/// )
/// ```
class QuillComposerEditor extends StatefulWidget {
  /// 初始文本内容（Markdown 格式）
  final String? initialText;

  /// 占位提示文字
  final String hintText;

  /// 文本变化回调（返回 Markdown 格式）
  final ValueChanged<String>? onTextChanged;

  /// 提交回调
  final ValueChanged<String>? onSubmit;

  /// 最大输入长度
  final int? maxLength;

  /// 最小高度
  final double minHeight;

  /// 最大高度
  final double? maxHeight;

  /// 是否自动聚焦
  final bool autofocus;

  /// 是否显示工具栏
  final bool showToolbar;

  /// 是否只读
  final bool readOnly;

  /// 外部控制器
  final QuillComposerEditorController? controller;

  /// 构造函数
  const QuillComposerEditor({
    super.key,
    this.initialText,
    this.hintText = '请输入内容...',
    this.onTextChanged,
    this.onSubmit,
    this.maxLength,
    this.minHeight = 200,
    this.maxHeight,
    this.autofocus = false,
    this.showToolbar = true,
    this.readOnly = false,
    this.controller,
  });

  @override
  State<QuillComposerEditor> createState() => _QuillComposerEditorState();
}

class _QuillComposerEditorState extends State<QuillComposerEditor> {
  late final QuillController _controller;
  late final md.Document _mdDocument;
  late final MarkdownToDelta _mdToDelta;
  late final DeltaToMarkdown _deltaToMd;
  late final ScrollController _scrollController;
  late final FocusNode _focusNode;

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
    final delta = _convertMarkdownToDelta(widget.initialText ?? '');
    _controller = QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );

    // 监听文本变化
    _controller.addListener(_handleTextChange);

    // 附加外部控制器
    widget.controller?._attach(this);
  }

  @override
  void dispose() {
    // 分离外部控制器
    widget.controller?._detach();
    _controller.removeListener(_handleTextChange);
    _scrollController.dispose();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  /// 将 Markdown 转换为 Delta
  Delta _convertMarkdownToDelta(String markdown) {
    if (markdown.isEmpty) {
      // flutter_quill 需要至少包含一个换行符的 Delta
      return Delta()..insert('\n');
    }
    final delta = _mdToDelta.convert(markdown);
    // 确保 Delta 不为空
    if (delta.isEmpty) {
      return Delta()..insert('\n');
    }
    return delta;
  }

  /// 将 Delta 转换为 Markdown
  String _convertDeltaToMarkdown() {
    final delta = _controller.document.toDelta();
    return _deltaToMd.convert(delta);
  }

  /// 处理文本变化
  void _handleTextChange() {
    final markdown = _convertDeltaToMarkdown();
    widget.onTextChanged?.call(markdown);
  }

  /// 获取当前 Markdown 内容
  String getMarkdown() {
    return _convertDeltaToMarkdown();
  }

  /// 设置 Markdown 内容
  void setMarkdown(String markdown) {
    final delta = _convertMarkdownToDelta(markdown);
    _controller.document = Document.fromDelta(delta);
    _controller.updateSelection(
      TextSelection.collapsed(offset: _controller.document.length - 1),
      ChangeSource.local,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 工具栏
        if (widget.showToolbar && !widget.readOnly)
          QuillSimpleToolbar(
            controller: _controller,
            config: QuillSimpleToolbarConfig(
              toolbarIconAlignment: WrapAlignment.start,
              showAlignmentButtons: true,
              showBackgroundColorButton: true,
              showBoldButton: true,
              showCenterAlignment: true,
              showColorButton: true,
              showDirection: true,
              showFontFamily: false,
              showFontSize: false,
              showIndent: true,
              showInlineCode: true,
              showItalicButton: true,
              showJustifyAlignment: true,
              showLeftAlignment: true,
              showLineHeightButton: false,
              showListBullets: true,
              showListCheck: true,
              showListNumbers: true,
              showRightAlignment: true,
              showSearchButton: false,
              showSmallButton: false,
              showStrikeThrough: true,
              showSubscript: false,
              showSuperscript: false,
              showUnderLineButton: true,
              multiRowsDisplay: false,
              toolbarSectionSpacing: 8,
              buttonOptions: QuillSimpleToolbarButtonOptions(
                base: QuillToolbarBaseButtonOptions(
                  iconTheme: QuillIconTheme(
                    iconButtonSelectedData: IconButtonData(
                      style: IconButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        backgroundColor: colorScheme.primaryContainer,
                      ),
                    ),
                    iconButtonUnselectedData: IconButtonData(
                      style: IconButton.styleFrom(
                        foregroundColor: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        // 编辑器
        Container(
          constraints: BoxConstraints(
            minHeight: widget.minHeight,
            maxHeight: widget.maxHeight ?? double.infinity,
          ),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            border: Border.all(
              color: colorScheme.outline.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: QuillEditor(
              controller: _controller,
              scrollController: _scrollController,
              focusNode: _focusNode,
              config: QuillEditorConfig(
                placeholder: widget.hintText,
                padding: const EdgeInsets.all(16),
                autoFocus: widget.autofocus,
                expands: false,
                scrollable: true,
                enableInteractiveSelection: true,
                enableSelectionToolbar: true,
                customStyles: DefaultStyles(
                  placeHolder: DefaultTextBlockStyle(
                    TextStyle(
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                    const HorizontalSpacing(0, 0),
                    const VerticalSpacing(0, 0),
                    const VerticalSpacing(0, 0),
                    null,
                  ),
                ),
              ),
            ),
          ),
        ),

        // 底部字数统计
        if (widget.maxLength != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                final length = _controller.document.length - 1;
                return Text(
                  '$length/${widget.maxLength}',
                  style: TextStyle(
                    fontSize: 12,
                    color: length > widget.maxLength!
                        ? colorScheme.error
                        : colorScheme.onSurfaceVariant,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

/// QuillComposerEditor 控制器扩展
///
/// 用于在编辑器外部控制编辑器内容
class QuillComposerEditorController {
  _QuillComposerEditorState? _state;

  void _attach(_QuillComposerEditorState state) {
    _state = state;
  }

  void _detach() {
    _state = null;
  }

  /// 获取 Markdown 内容
  String getMarkdown() {
    assert(_state != null, 'Controller 未附加到编辑器');
    return _state!.getMarkdown();
  }

  /// 设置 Markdown 内容
  void setMarkdown(String markdown) {
    assert(_state != null, 'Controller 未附加到编辑器');
    _state!.setMarkdown(markdown);
  }
}
