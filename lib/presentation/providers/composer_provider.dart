import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../widgets/editor/composer_attachment_panel.dart';

part 'composer_provider.g.dart';

/// Composer 编辑器状态类
///
/// 管理编辑器的状态，包括文本内容、选区、附件、预览模式等
@immutable
class ComposerState {
  /// 原始文本内容
  final String rawText;

  /// 当前文本选区
  final TextSelection selection;

  /// 附件列表
  final List<AttachmentItem> attachments;

  /// 是否处于预览模式
  final bool isPreview;

  /// 是否正在上传
  final bool isUploading;

  /// 错误信息
  final String? errorMessage;

  /// 构造函数
  ///
  /// [rawText] 原始文本内容
  /// [selection] 当前文本选区
  /// [attachments] 附件列表
  /// [isPreview] 是否处于预览模式
  /// [isUploading] 是否正在上传
  /// [errorMessage] 错误信息
  const ComposerState({
    this.rawText = '',
    this.selection = const TextSelection.collapsed(offset: 0),
    this.attachments = const [],
    this.isPreview = false,
    this.isUploading = false,
    this.errorMessage,
  });

  /// 初始状态
  factory ComposerState.initial() => const ComposerState();

  /// 创建副本并修改属性
  ///
  /// [rawText] 原始文本内容
  /// [selection] 当前文本选区
  /// [attachments] 附件列表
  /// [isPreview] 是否处于预览模式
  /// [isUploading] 是否正在上传
  /// [errorMessage] 错误信息
  ComposerState copyWith({
    String? rawText,
    TextSelection? selection,
    List<AttachmentItem>? attachments,
    bool? isPreview,
    bool? isUploading,
    String? errorMessage,
  }) {
    return ComposerState(
      rawText: rawText ?? this.rawText,
      selection: selection ?? this.selection,
      attachments: attachments ?? this.attachments,
      isPreview: isPreview ?? this.isPreview,
      isUploading: isUploading ?? this.isUploading,
      errorMessage: errorMessage,
    );
  }

  /// 获取当前选中的文本
  String? get selectedText {
    if (!selection.isValid || selection.isCollapsed) return null;
    if (selection.start < 0 || selection.end > rawText.length) return null;
    return rawText.substring(selection.start, selection.end);
  }

  /// 获取选区前的文本
  String get textBeforeSelection {
    if (!selection.isValid || selection.start < 0) return '';
    return rawText.substring(0, selection.start);
  }

  /// 获取选区后的文本
  String get textAfterSelection {
    if (!selection.isValid || selection.end > rawText.length) return '';
    return rawText.substring(selection.end);
  }

  /// 是否有选中的文本
  bool get hasSelection => selectedText != null && selectedText!.isNotEmpty;

  /// 附件数量
  int get attachmentCount => attachments.length;

  /// 是否有附件
  bool get hasAttachments => attachments.isNotEmpty;

  /// 是否为空（无文本且无附件）
  bool get isEmpty => rawText.trim().isEmpty && attachments.isEmpty;

  /// 是否不为空
  bool get isNotEmpty => !isEmpty;

  /// 文本长度
  int get textLength => rawText.length;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ComposerState &&
        other.rawText == rawText &&
        other.selection == selection &&
        other.attachments.length == attachments.length &&
        other.isPreview == isPreview &&
        other.isUploading == isUploading &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return Object.hash(
      rawText,
      selection,
      attachments.length,
      isPreview,
      isUploading,
      errorMessage,
    );
  }
}

/// Composer 状态管理器
///
/// 提供编辑器状态的管理和操作，包括：
/// - 文本编辑和选区管理
/// - Markdown 语法包裹
/// - 附件管理
/// - 预览模式切换
/// - URL 校验与自动转换
@riverpod
class ComposerNotifier extends _$ComposerNotifier {
  @override
  ComposerState build() {
    return ComposerState.initial();
  }

  // ==================== 基础状态操作 ====================

  /// 设置原始文本
  ///
  /// [text] 要设置的文本内容
  void setRawText(String text) {
    state = state.copyWith(rawText: text);
  }

  /// 更新文本选区
  ///
  /// [selection] 新的文本选区
  void updateSelection(TextSelection selection) {
    state = state.copyWith(selection: selection);
  }

  /// 设置错误信息
  ///
  /// [error] 错误信息
  void setError(String? error) {
    state = state.copyWith(errorMessage: error);
  }

  /// 清除错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// 切换预览模式
  void togglePreview() {
    state = state.copyWith(isPreview: !state.isPreview);
  }

  /// 设置预览模式
  ///
  /// [isPreview] 是否处于预览模式
  void setPreview(bool isPreview) {
    state = state.copyWith(isPreview: isPreview);
  }

  /// 设置上传状态
  ///
  /// [isUploading] 是否正在上传
  void setUploading(bool isUploading) {
    state = state.copyWith(isUploading: isUploading);
  }

  /// 重置状态
  void reset() {
    state = ComposerState.initial();
  }

  // ==================== 文本编辑操作 ====================

  /// 在光标位置插入文本
  ///
  /// [text] 要插入的文本
  /// [moveCursorToEnd] 是否将光标移动到插入文本的末尾，默认为 true
  void insertText(String text, {bool moveCursorToEnd = true}) {
    final before = state.textBeforeSelection;
    final after = state.textAfterSelection;
    final newText = before + text + after;

    final newOffset = moveCursorToEnd
        ? before.length + text.length
        : state.selection.start;

    state = state.copyWith(
      rawText: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  /// 替换选中的文本
  ///
  /// [text] 用于替换的文本
  /// [keepSelection] 是否保持选区，默认为 false
  void replaceSelection(String text, {bool keepSelection = false}) {
    final before = state.textBeforeSelection;
    final after = state.textAfterSelection;
    final newText = before + text + after;

    final newOffset = keepSelection
        ? before.length
        : before.length + text.length;

    state = state.copyWith(
      rawText: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  /// 删除选中的文本
  void deleteSelection() {
    if (!state.hasSelection) return;
    replaceSelection('');
  }

  // ==================== Markdown 语法包裹 ====================

  /// 包裹选中的文本（或插入包裹符号）
  ///
  /// [prefix] 前缀符号
  /// [suffix] 后缀符号（如果为 null，则使用与前缀相同的符号）
  /// [placeholder] 当没有选中内容时插入的占位文本
  /// [selectPlaceholder] 是否选中占位文本，默认为 true
  void wrapSelection({
    required String prefix,
    String? suffix,
    String? placeholder,
    bool selectPlaceholder = true,
  }) {
    final actualSuffix = suffix ?? prefix;
    final selected = state.selectedText;

    if (selected != null && selected.isNotEmpty) {
      // 有选中文本：包裹选中的内容
      _wrapSelectedText(prefix, actualSuffix);
    } else {
      // 无选中文本：插入占位符并包裹
      _insertWrappedPlaceholder(prefix, actualSuffix, placeholder ?? '', selectPlaceholder);
    }
  }

  /// 包裹选中的文本
  ///
  /// [prefix] 前缀
  /// [suffix] 后缀
  void _wrapSelectedText(String prefix, String suffix) {
    final before = state.textBeforeSelection;
    final selected = state.selectedText!;
    final after = state.textAfterSelection;

    final newText = before + prefix + selected + suffix + after;
    final newOffset = before.length + prefix.length + selected.length + suffix.length;

    state = state.copyWith(
      rawText: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  /// 插入包裹的占位符
  ///
  /// [prefix] 前缀
  /// [suffix] 后缀
  /// [placeholder] 占位文本
  /// [selectPlaceholder] 是否选中占位文本
  void _insertWrappedPlaceholder(
    String prefix,
    String suffix,
    String placeholder,
    bool selectPlaceholder,
  ) {
    final before = state.textBeforeSelection;
    final after = state.textAfterSelection;
    final wrappedText = prefix + placeholder + suffix;
    final newText = before + wrappedText + after;

    TextSelection newSelection;
    if (selectPlaceholder) {
      // 选中占位文本
      final start = before.length + prefix.length;
      final end = start + placeholder.length;
      newSelection = TextSelection(baseOffset: start, extentOffset: end);
    } else {
      // 光标放在后缀之后
      newSelection = TextSelection.collapsed(
        offset: before.length + wrappedText.length,
      );
    }

    state = state.copyWith(
      rawText: newText,
      selection: newSelection,
    );
  }

  /// 在选区前添加行前缀（如引用、列表等）
  ///
  /// [linePrefix] 行前缀（如 "> "、"- "、"1. " 等）
  /// [applyToEachLine] 是否应用到每一行，默认为 true
  void addLinePrefix(String linePrefix, {bool applyToEachLine = true}) {
    final before = state.textBeforeSelection;
    final selected = state.selectedText ?? '';
    final after = state.textAfterSelection;

    String newSelected;
    if (applyToEachLine && selected.contains('\n')) {
      // 应用到每一行
      final lines = selected.split('\n');
      newSelected = lines.map((line) => linePrefix + line).join('\n');
    } else {
      newSelected = linePrefix + selected;
    }

    final newText = before + newSelected + after;
    final newOffset = before.length + newSelected.length;

    state = state.copyWith(
      rawText: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  /// 插入 Markdown 标题
  ///
  /// [level] 标题级别（1-6）
  void insertHeading(int level) {
    assert(level >= 1 && level <= 6, '标题级别必须在 1-6 之间');
    final prefix = '${'#' * level} ';
    addLinePrefix(prefix, applyToEachLine: false);
  }

  /// 插入加粗文本
  ///
  /// [text] 要加粗的文本，如果为 null 则使用当前选区
  void insertBold([String? text]) {
    if (text != null) {
      insertText('**$text**');
    } else {
      wrapSelection(prefix: '**', placeholder: '加粗文本');
    }
  }

  /// 插入斜体文本
  ///
  /// [text] 要斜体的文本，如果为 null 则使用当前选区
  void insertItalic([String? text]) {
    if (text != null) {
      insertText('*$text*');
    } else {
      wrapSelection(prefix: '*', placeholder: '斜体文本');
    }
  }

  /// 插入删除线文本
  ///
  /// [text] 要添加删除线的文本，如果为 null 则使用当前选区
  void insertStrikethrough([String? text]) {
    if (text != null) {
      insertText('~~$text~~');
    } else {
      wrapSelection(prefix: '~~', placeholder: '删除线文本');
    }
  }

  /// 插入行内代码
  ///
  /// [text] 代码内容，如果为 null 则使用当前选区
  void insertInlineCode([String? text]) {
    if (text != null) {
      insertText('`$text`');
    } else {
      wrapSelection(prefix: '`', placeholder: '代码');
    }
  }

  /// 插入代码块
  ///
  /// [language] 代码语言（可选）
  /// [code] 代码内容，如果为 null 则使用当前选区
  void insertCodeBlock({String? language, String? code}) {
    final lang = language ?? '';
    final content = code ?? state.selectedText ?? '';
    final codeBlock = '```$lang\n$content\n```';

    if (code != null || state.hasSelection) {
      replaceSelection(codeBlock);
    } else {
      insertText(codeBlock);
    }
  }

  /// 插入引用
  void insertQuote() {
    addLinePrefix('> ', applyToEachLine: true);
  }

  /// 插入无序列表
  void insertUnorderedList() {
    addLinePrefix('- ', applyToEachLine: true);
  }

  /// 插入有序列表
  void insertOrderedList() {
    final before = state.textBeforeSelection;
    final selected = state.selectedText ?? '';
    final after = state.textAfterSelection;

    String newSelected;
    if (selected.isEmpty) {
      newSelected = '1. ';
    } else if (selected.contains('\n')) {
      final lines = selected.split('\n');
      newSelected = lines.asMap().entries.map((entry) {
        return '${entry.key + 1}. ${entry.value}';
      }).join('\n');
    } else {
      newSelected = '1. $selected';
    }

    final newText = before + newSelected + after;
    final newOffset = before.length + newSelected.length;

    state = state.copyWith(
      rawText: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }

  /// 插入分割线
  void insertDivider() {
    insertText('\n---\n');
  }

  /// 插入链接
  ///
  /// [url] 链接地址
  /// [text] 链接文本，如果为 null 则使用当前选区或 URL
  void insertLink({required String url, String? text}) {
    final linkText = text ?? state.selectedText ?? url;
    final link = '[$linkText]($url)';
    replaceSelection(link, keepSelection: false);
  }

  /// 插入图片
  ///
  /// [url] 图片地址
  /// [alt] 图片描述，如果为 null 则使用默认描述
  void insertImage({required String url, String? alt}) {
    final altText = alt ?? '图片描述';
    final image = '![$altText]($url)';
    insertText(image);
  }

  // ==================== URL 校验与自动转换 ====================

  /// URL 正则表达式模式
  static final RegExp _urlPattern = RegExp(
    r'^(https?:\/\/)?' // 协议（可选）
    r'(([a-zA-Z0-9_-]+\.)+[a-zA-Z]{2,})' // 域名
    r'(:\d+)?' // 端口（可选）
    r'(\/[^\s]*)?$', // 路径（可选）
    caseSensitive: false,
  );

  /// 检查文本是否为有效的 URL
  ///
  /// [text] 要检查的文本
  /// @return 是否为有效的 URL
  bool isValidUrl(String text) {
    return _urlPattern.hasMatch(text.trim());
  }

  /// 自动检测并转换文本中的 URL 为链接
  ///
  /// [text] 要处理的文本
  /// @return 转换后的 Markdown 文本
  String autoConvertUrls(String text) {
    // 匹配 URL 的正则表达式
    final urlRegex = RegExp(
      r'https?://[a-zA-Z0-9][-a-zA-Z0-9]*\.?[a-zA-Z0-9][-a-zA-Z0-9]*\.?[a-z]{2,}[^\s]*',
      caseSensitive: false,
    );

    return text.replaceAllMapped(urlRegex, (match) {
      final url = match.group(0)!;
      // 避免重复转换已经是链接的 URL
      if (text.substring(0, match.start).endsWith('](')) {
        return url;
      }
      return '[$url]($url)';
    });
  }

  /// 尝试将选中的文本转换为链接
  ///
  /// 如果选中的文本是有效的 URL，则将其转换为 Markdown 链接格式
  /// @return 是否成功转换
  bool tryConvertSelectionToLink() {
    final selected = state.selectedText;
    if (selected == null || selected.isEmpty) return false;

    final trimmed = selected.trim();
    if (isValidUrl(trimmed)) {
      // 确保 URL 有协议前缀
      String url = trimmed;
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }
      insertLink(url: url, text: trimmed);
      return true;
    }
    return false;
  }

  /// 智能粘贴处理
  ///
  /// 检测剪贴板内容，如果是 URL 则自动转换为链接格式
  /// [text] 要粘贴的文本
  /// @return 是否进行了特殊处理
  bool handleSmartPaste(String text) {
    if (isValidUrl(text.trim())) {
      String url = text.trim();
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }

      // 如果有选中文本，使用选中文本作为链接文本
      if (state.hasSelection) {
        insertLink(url: url);
      } else {
        // 否则直接使用 URL 作为文本
        insertLink(url: url, text: url);
      }
      return true;
    }
    return false;
  }

  // ==================== 附件管理 ====================

  /// 添加附件
  ///
  /// [attachment] 要添加的附件
  void addAttachment(AttachmentItem attachment) {
    final newAttachments = [...state.attachments, attachment];
    state = state.copyWith(attachments: newAttachments);
  }

  /// 移除附件
  ///
  /// [attachmentId] 要移除的附件 ID
  void removeAttachment(String attachmentId) {
    final newAttachments = state.attachments
        .where((a) => a.id != attachmentId)
        .toList();
    state = state.copyWith(attachments: newAttachments);
  }

  /// 更新附件
  ///
  /// [attachment] 更新后的附件
  void updateAttachment(AttachmentItem attachment) {
    final newAttachments = state.attachments.map((a) {
      return a.id == attachment.id ? attachment : a;
    }).toList();
    state = state.copyWith(attachments: newAttachments);
  }

  /// 更新附件上传进度
  ///
  /// [attachmentId] 附件 ID
  /// [progress] 上传进度（0.0 - 1.0）
  void updateAttachmentProgress(String attachmentId, double progress) {
    final attachment = state.attachments.firstWhere(
      (a) => a.id == attachmentId,
      orElse: () => throw StateError('Attachment not found: $attachmentId'),
    );

    final updatedAttachment = attachment.copyWith(
      uploadProgress: progress,
      uploadStatus: progress >= 1.0 ? UploadStatus.success : UploadStatus.uploading,
    );

    updateAttachment(updatedAttachment);
  }

  /// 设置附件上传失败
  ///
  /// [attachmentId] 附件 ID
  /// [errorMessage] 错误信息
  void setAttachmentFailed(String attachmentId, String errorMessage) {
    final attachment = state.attachments.firstWhere(
      (a) => a.id == attachmentId,
      orElse: () => throw StateError('Attachment not found: $attachmentId'),
    );

    final updatedAttachment = attachment.copyWith(
      uploadStatus: UploadStatus.failed,
      errorMessage: errorMessage,
    );

    updateAttachment(updatedAttachment);
  }

  /// 设置附件上传成功
  ///
  /// [attachmentId] 附件 ID
  /// [remoteUrl] 远程 URL
  void setAttachmentSuccess(String attachmentId, String remoteUrl) {
    final attachment = state.attachments.firstWhere(
      (a) => a.id == attachmentId,
      orElse: () => throw StateError('Attachment not found: $attachmentId'),
    );

    final updatedAttachment = attachment.copyWith(
      remoteUrl: remoteUrl,
      uploadStatus: UploadStatus.success,
      uploadProgress: 1.0,
    );

    updateAttachment(updatedAttachment);

    // 如果是图片，自动插入到编辑器中
    if (attachment.type == AttachmentType.image) {
      insertImage(url: remoteUrl, alt: attachment.name);
    }
  }

  /// 清除所有附件
  void clearAttachments() {
    state = state.copyWith(attachments: const []);
  }

  /// 获取指定类型的附件
  ///
  /// [type] 附件类型
  /// @return 该类型的附件列表
  List<AttachmentItem> getAttachmentsByType(AttachmentType type) {
    return state.attachments.where((a) => a.type == type).toList();
  }

  /// 获取待上传的附件
  ///
  /// @return 上传状态为 pending 的附件列表
  List<AttachmentItem> getPendingAttachments() {
    return state.attachments
        .where((a) => a.uploadStatus == UploadStatus.pending)
        .toList();
  }

  /// 检查是否所有附件都已上传完成
  ///
  /// @return 是否所有附件都上传成功
  bool areAllAttachmentsUploaded() {
    if (state.attachments.isEmpty) return true;
    return state.attachments.every((a) => a.uploadStatus == UploadStatus.success);
  }

  /// 获取上传中的附件数量
  int get uploadingAttachmentCount {
    return state.attachments
        .where((a) => a.uploadStatus == UploadStatus.uploading)
        .length;
  }

  // ==================== 批量操作 ====================

  /// 设置完整的编辑器内容
  ///
  /// [text] 文本内容
  /// [attachments] 附件列表
  void setContent({
    required String text,
    List<AttachmentItem>? attachments,
  }) {
    state = state.copyWith(
      rawText: text,
      attachments: attachments ?? state.attachments,
    );
  }

  /// 获取提交内容
  ///
  /// @return 包含文本和附件的提交数据
  ComposerSubmitData getSubmitData() {
    return ComposerSubmitData(
      text: state.rawText.trim(),
      attachments: state.attachments,
    );
  }
}

/// Composer 提交数据类
///
/// 包含提交时的文本内容和附件列表
@immutable
class ComposerSubmitData {
  /// 文本内容
  final String text;

  /// 附件列表
  final List<AttachmentItem> attachments;

  /// 构造函数
  ///
  /// [text] 文本内容
  /// [attachments] 附件列表
  const ComposerSubmitData({
    required this.text,
    required this.attachments,
  });

  /// 是否为空内容
  bool get isEmpty => text.isEmpty && attachments.isEmpty;

  /// 是否不为空
  bool get isNotEmpty => !isEmpty;

  /// 附件数量
  int get attachmentCount => attachments.length;
}

/// 全局 Composer 状态 Provider
///
/// 用于在应用中共享编辑器状态
@riverpod
ComposerState composerState(ComposerStateRef ref) {
  return ref.watch(composerNotifierProvider);
}

/// 原始文本 Provider
@riverpod
String composerRawText(ComposerRawTextRef ref) {
  return ref.watch(composerNotifierProvider).rawText;
}

/// 是否为空 Provider
@riverpod
bool composerIsEmpty(ComposerIsEmptyRef ref) {
  return ref.watch(composerNotifierProvider).isEmpty;
}

/// 附件列表 Provider
@riverpod
List<AttachmentItem> composerAttachments(ComposerAttachmentsRef ref) {
  return ref.watch(composerNotifierProvider).attachments;
}

/// 是否处于预览模式 Provider
@riverpod
bool composerIsPreview(ComposerIsPreviewRef ref) {
  return ref.watch(composerNotifierProvider).isPreview;
}

/// 是否正在上传 Provider
@riverpod
bool composerIsUploading(ComposerIsUploadingRef ref) {
  return ref.watch(composerNotifierProvider).isUploading;
}
