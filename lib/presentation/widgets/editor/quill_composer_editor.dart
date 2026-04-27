import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markdown_quill/markdown_quill.dart';
import 'package:markdown/markdown.dart' as md;

import '../../../core/services/image_upload_service.dart';

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
///   onImageUpload: (file) async => 'https://example.com/image.png',
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

  /// 图片上传回调，返回图片 URL
  final Future<String?> Function(File file)? onImageUpload;

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

  /// 是否显示底部工具栏（图片按钮）
  final bool showBottomToolbar;

  /// 构造函数
  const QuillComposerEditor({
    super.key,
    this.initialText,
    this.hintText = '请输入内容...',
    this.onTextChanged,
    this.onSubmit,
    this.onImageUpload,
    this.maxLength,
    this.minHeight = 150,
    this.maxHeight,
    this.autofocus = false,
    this.showToolbar = true,
    this.readOnly = false,
    this.controller,
    this.showBottomToolbar = true,
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
    try {
      final delta = _mdToDelta.convert(markdown);
      // 确保 Delta 不为空
      if (delta.isEmpty) {
        return Delta()..insert('\n');
      }
      // 确保 Delta 以换行符结尾
      if (delta.last.data is String && !(delta.last.data as String).endsWith('\n')) {
        delta.insert('\n');
      }
      return delta;
    } catch (e) {
      // 转换失败时返回默认 Delta
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

  /// 在光标位置插入文本
  void insertText(String text) {
    final index = _controller.selection.baseOffset;
    final length = _controller.selection.extentOffset - index;
    _controller.replaceText(index, length, text, null);
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

      // 如果有上传回调，使用回调上传
      if (widget.onImageUpload != null) {
        final url = await widget.onImageUpload!(File(image.path));
        if (url != null && mounted) {
          _insertImageMarkdown(url);
        }
      } else {
        // 默认使用 ImageUploadService
        final uploadService = ImageUploadService();
        final result = await uploadService.uploadImage(
          filePath: image.path,
        );

        if (result.success && mounted) {
          _insertImageMarkdown(result.imageUrl!);
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('图片上传失败: ${result.errorMessage}')),
          );
        }
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

  /// 插入图片 Markdown
  void _insertImageMarkdown(String url, {String? alt}) {
    final imageMarkdown = '\n![${alt ?? '图片'}]($url)\n';
    insertText(imageMarkdown);
  }

  /// 显示链接插入对话框
  void _showLinkDialog() {
    final textController = TextEditingController();
    final urlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('插入链接'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: '链接文字',
                hintText: '显示的文字',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: '链接地址',
                hintText: 'https://example.com',
              ),
              keyboardType: TextInputType.url,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              final text = textController.text.isEmpty ? urlController.text : textController.text;
              final url = urlController.text;
              if (url.isNotEmpty) {
                final linkMarkdown = '[$text]($url)';
                insertText(linkMarkdown);
              }
              Navigator.pop(context);
            },
            child: const Text('插入'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 编辑器
        GestureDetector(
          onTap: () {
            // 确保点击编辑器区域时获取焦点
            if (!_focusNode.hasFocus) {
              _focusNode.requestFocus();
            }
          },
          child: Container(
            constraints: BoxConstraints(
              minHeight: widget.minHeight,
              maxHeight: widget.maxHeight ?? 300,
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
                  padding: const EdgeInsets.all(12),
                  autoFocus: widget.autofocus,
                  expands: false,
                  scrollable: true,
                  enableInteractiveSelection: true,
                  enableSelectionToolbar: true,
                  showCursor: true,
                  customStyles: DefaultStyles(
                    placeHolder: DefaultTextBlockStyle(
                      TextStyle(
                        color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                        fontSize: 16,
                        height: 1.5,
                      ),
                      const HorizontalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    paragraph: DefaultTextBlockStyle(
                      TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 16,
                        height: 1.5,
                      ),
                      const HorizontalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    h1: DefaultTextBlockStyle(
                      TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      const HorizontalSpacing(0, 0),
                      const VerticalSpacing(8, 4),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    h2: DefaultTextBlockStyle(
                      TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      const HorizontalSpacing(0, 0),
                      const VerticalSpacing(8, 4),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    h3: DefaultTextBlockStyle(
                      TextStyle(
                        color: colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      const HorizontalSpacing(0, 0),
                      const VerticalSpacing(8, 4),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    code: DefaultTextBlockStyle(
                      TextStyle(
                        color: colorScheme.primary,
                        fontSize: 14,
                        fontFamily: 'monospace',
                        backgroundColor: colorScheme.primaryContainer.withOpacity(0.3),
                      ),
                      const HorizontalSpacing(4, 4),
                      const VerticalSpacing(0, 0),
                      const VerticalSpacing(0, 0),
                      null,
                    ),
                    quote: DefaultTextBlockStyle(
                      TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                      const HorizontalSpacing(16, 16),
                      const VerticalSpacing(8, 8),
                      const VerticalSpacing(0, 0),
                      BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: colorScheme.primary.withOpacity(0.5),
                            width: 4,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // 底部工具栏（包含格式工具和图片按钮）
        if (!widget.readOnly && widget.showBottomToolbar)
          Container(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
            child: Row(
              children: [
                // 工具栏按钮（滚动）
                if (widget.showToolbar)
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 撤销/重做
                          QuillToolbarHistoryButton(
                            controller: _controller,
                            isUndo: true,
                            options: const QuillToolbarHistoryButtonOptions(),
                          ),
                          QuillToolbarHistoryButton(
                            controller: _controller,
                            isUndo: false,
                            options: const QuillToolbarHistoryButtonOptions(),
                          ),
                          _buildDivider(),
                          // 标题
                          QuillToolbarSelectHeaderStyleDropdownButton(
                            controller: _controller,
                          ),
                          _buildDivider(),
                          // 加粗/斜体/下划线/删除线
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.bold,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.italic,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.underline,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.strikeThrough,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          _buildDivider(),
                          // 行内代码/代码块
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.inlineCode,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.codeBlock,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          _buildDivider(),
                          // 引用
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.blockQuote,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          _buildDivider(),
                          // 列表
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.ul,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.ol,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          QuillToolbarToggleStyleButton(
                            controller: _controller,
                            attribute: Attribute.checked,
                            options: const QuillToolbarToggleStyleButtonOptions(),
                          ),
                          _buildDivider(),
                          // 链接按钮
                          IconButton(
                            onPressed: _showLinkDialog,
                            icon: const Icon(Icons.link, size: 20),
                            tooltip: '插入链接',
                            visualDensity: VisualDensity.compact,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
                // 图片上传按钮（始终在右侧）
                IconButton(
                  onPressed: _isUploadingImage ? null : _pickAndUploadImage,
                  icon: _isUploadingImage
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(Icons.image_outlined, size: 20, color: colorScheme.primary),
                  tooltip: '插入图片',
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                ),
                // 字数统计
                if (widget.maxLength != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
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
            ),
          ),
      ],
    );
  }

  /// 构建分隔线
  Widget _buildDivider() {
    return Container(
      height: 24,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
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

  /// 在光标位置插入文本
  void insertText(String text) {
    assert(_state != null, 'Controller 未附加到编辑器');
    _state!.insertText(text);
  }
}
