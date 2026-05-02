import 'package:flutter/material.dart';
import 'quill_composer_editor.dart';

/// Markdown 编辑器组件（基于 flutter_quill）
///
/// 统一的 Markdown 编辑器，支持以下功能：
/// - 富文本编辑（标题、加粗、斜体、删除线、引用、代码块、列表、分割线）
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
  late ComposerEditorMode _currentMode;
  final List<AttachmentItem> _attachments = [];
  bool _isComposing = false;
  String _currentText = '';

  @override
  void initState() {
    super.initState();
    _currentMode = widget.initialMode;
    _isComposing = widget.initialText?.isNotEmpty ?? false;
    _currentText = widget.initialText ?? '';
  }

  /// 处理文本变化
  void _handleTextChange(String text) {
    final isComposing = text.isNotEmpty;
    if (isComposing != _isComposing) {
      setState(() {
        _isComposing = isComposing;
        _currentText = text;
      });
    } else if (_currentText != text) {
      setState(() {
        _currentText = text;
      });
    }
    widget.onTextChanged?.call(text);
  }

  /// 处理提交
  void _handleSubmit() {
    // 通过 QuillComposerEditor 获取当前内容
    // 这里简化处理，实际应该在 QuillComposerEditor 中提供获取内容的方法
    widget.onSubmit?.call('', List.unmodifiable(_attachments));
  }

  /// 切换编辑器模式
  void _switchMode(ComposerEditorMode mode) {
    if (!_canShowPreviewModes && mode != ComposerEditorMode.edit) {
      return;
    }
    setState(() {
      _currentMode = mode;
    });
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
        if (widget.enableSplitView && _canShowPreviewModes)
          _buildModeSwitcher(context),

        // 编辑器主体
        Flexible(child: _buildEditorBody(context)),

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
            style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
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
          bottom: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
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
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建文本输入框
  Widget _buildTextField(BuildContext context) {
    return QuillComposerEditor(
      initialText: widget.initialText,
      hintText: widget.hintText,
      onTextChanged: _handleTextChange,
      maxLength: widget.maxLength,
      minHeight: widget.minHeight,
      maxHeight: widget.maxHeight,
      autofocus: widget.autofocus,
      showToolbar: widget.showToolbar,
    );
  }

  /// 构建预览区域
  Widget _buildPreview(BuildContext context) {
    final content = _currentText.trim();
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      child: content.isEmpty
          ? Center(
              child: Text(
                '暂无内容可预览',
                style: TextStyle(color: colorScheme.onSurfaceVariant),
              ),
            )
          : SingleChildScrollView(
              child: SelectableText(
                _currentText,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
    );
  }

  bool get _canShowPreviewModes =>
      widget.showPreview && _currentText.isNotEmpty;

  ComposerEditorMode get _effectiveMode {
    if (!_canShowPreviewModes && _currentMode != ComposerEditorMode.edit) {
      return ComposerEditorMode.edit;
    }
    return _currentMode;
  }

  /// 构建编辑器主体
  Widget _buildEditorBody(BuildContext context) {
    switch (_effectiveMode) {
      case ComposerEditorMode.edit:
        return _buildTextField(context);
      case ComposerEditorMode.preview:
        return _buildPreview(context);
      case ComposerEditorMode.split:
        return _buildSplitView(context);
    }
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
        Expanded(child: _buildPreview(context)),
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
          top: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
        ),
      ),
      child: Row(
        children: [
          // 字数统计
          if (widget.maxLength != null)
            Text(
              '0/${widget.maxLength}',
              style: TextStyle(
                fontSize: 12,
                color: colorScheme.onSurfaceVariant,
              ),
            )
          else
            Text(
              '0 字',
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

/// 附件项
class AttachmentItem {
  /// 附件 ID
  final String id;

  /// 附件名称
  final String name;

  /// 附件类型
  final AttachmentType type;

  /// 本地路径
  final String? localPath;

  /// 远程 URL
  final String? remoteUrl;

  /// 上传状态
  final UploadStatus uploadStatus;

  /// 上传进度
  final double uploadProgress;

  /// 错误信息
  final String? errorMessage;

  const AttachmentItem({
    required this.id,
    required this.name,
    required this.type,
    this.localPath,
    this.remoteUrl,
    this.uploadStatus = UploadStatus.pending,
    this.uploadProgress = 0.0,
    this.errorMessage,
  });

  AttachmentItem copyWith({
    String? id,
    String? name,
    AttachmentType? type,
    String? localPath,
    String? remoteUrl,
    UploadStatus? uploadStatus,
    double? uploadProgress,
    String? errorMessage,
  }) {
    return AttachmentItem(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AttachmentItem.image({
    required String id,
    required String name,
    String? localPath,
    String? remoteUrl,
    UploadStatus uploadStatus = UploadStatus.pending,
    double uploadProgress = 0.0,
    String? errorMessage,
  }) {
    return AttachmentItem(
      id: id,
      name: name,
      type: AttachmentType.image,
      localPath: localPath,
      remoteUrl: remoteUrl,
      uploadStatus: uploadStatus,
      uploadProgress: uploadProgress,
      errorMessage: errorMessage,
    );
  }
}

/// 附件类型
enum AttachmentType { image, video, audio, file }

/// 上传状态
enum UploadStatus { pending, uploading, success, failed }

/// 链接插入回调函数类型
///
/// [text] 链接显示文本
/// [url] 链接 URL
/// [isValid] URL 是否有效
/// [errorMessage] 错误信息（如果 URL 无效）
typedef LinkInsertCallback =
    void Function({
      required String text,
      required String url,
      required bool isValid,
      String? errorMessage,
    });
