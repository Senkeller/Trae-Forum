import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/constants.dart';
import '../../../core/utils/draft_normalizer.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../data/repositories/feed_repository.dart';
import '../../providers/auth_provider.dart';
import '../../providers/settings_provider.dart';
import '../../widgets/editor/quill_composer_editor.dart';

class _PreparedPublishContent {
  const _PreparedPublishContent({
    required this.content,
    required this.failedCount,
  });

  final String content;
  final int failedCount;
}

/// Feed 创建页面（参考线性发帖布局）
class FeedCreatePage extends ConsumerStatefulWidget {
  final String? initialTitle;
  final String? initialContent;

  const FeedCreatePage({super.key, this.initialTitle, this.initialContent});

  @override
  ConsumerState<FeedCreatePage> createState() => _FeedCreatePageState();
}

class _FeedCreatePageState extends ConsumerState<FeedCreatePage> {
  static const int _minTitleLength = 6;
  static const int _minBodyLength = 5;

  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocusNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false;
  String _loadingMessage = '发布中...';
  String? _errorMessage;
  String _selectedCategory = 'discussion';
  bool _isPickingImage = false;

  String _editorContent = '';
  bool _draftSaved = false;
  DateTime? _draftSavedAt;
  final List<XFile> _selectedImages = [];

  final List<Map<String, String>> _categories = const [
    {'id': 'discussion', 'label': '互动交流', 'hint': '选择合适的板块会有更多的赞'},
    {'id': 'help', 'label': '帮助与支持', 'hint': '遇到问题来这里提问'},
    {'id': 'suggestions', 'label': '产品建议', 'hint': '欢迎反馈想法与建议'},
    {'id': 'tips', 'label': '技巧分享', 'hint': '分享你的效率技巧'},
    {'id': 'showcase', 'label': '案例与作品', 'hint': '展示你的实践成果'},
    {'id': 'official', 'label': '官方公告', 'hint': '仅官方团队可发布'},
    {'id': 'events', 'label': '福利活动', 'hint': '活动相关内容'},
  ];

  bool get _canPublish =>
      !_isLoading &&
      _titleController.text.trim().runes.length >= _minTitleLength &&
      _editorContent.trim().runes.length >= _minBodyLength;

  int get _titleLength => _titleController.text.trim().runes.length;

  int get _wordCount =>
      _editorContent.trim().isEmpty ? 0 : _editorContent.length;

  String get _selectedCategoryLabel {
    for (final cat in _categories) {
      if (cat['id'] == _selectedCategory) {
        return cat['label'] ?? '互动交流';
      }
    }
    return '互动交流';
  }

  bool get _hasUnsavedChanges =>
      _titleController.text.trim().isNotEmpty ||
      _editorContent.trim().isNotEmpty ||
      _selectedImages.isNotEmpty;

  String get _selectedCategoryHint {
    for (final cat in _categories) {
      if (cat['id'] == _selectedCategory) {
        return cat['hint'] ?? '选择合适的板块会有更多的赞';
      }
    }
    return '选择合适的板块会有更多的赞';
  }

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_onInputChanged);
    _applyInitialPayloadOrLoadDraft();
  }

  @override
  void dispose() {
    _titleController.removeListener(_onInputChanged);
    _titleController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  Future<void> _applyInitialPayloadOrLoadDraft() async {
    final initialTitle = widget.initialTitle?.trim();
    final initialContent = widget.initialContent?.trim();
    if ((initialTitle?.isNotEmpty ?? false) ||
        (initialContent?.isNotEmpty ?? false)) {
      setState(() {
        if (initialTitle != null && initialTitle.isNotEmpty) {
          _titleController.text = initialTitle;
        }
        if (initialContent != null && initialContent.isNotEmpty) {
          _editorContent = initialContent;
        }
      });
      return;
    }
    await _loadDraft();
  }

  void _onInputChanged() {
    if (!mounted) return;
    setState(() {
      _errorMessage = null;
    });
  }

  void _onEditorTextChanged(String text) {
    if (!mounted) return;
    setState(() {
      _editorContent = text;
      _errorMessage = null;
      _draftSaved = false;
    });
  }

  Future<void> _loadDraft() async {
    try {
      final repository = ref.read(commentRepositoryProvider);
      final draft = await repository.getDraft(
        topicId: 0,
        replyToPostNumber: null,
      );

      if (!mounted || draft == null || draft.content.isEmpty) return;
      final normalized = DraftNormalizer.normalize(draft.content);
      final normalizedContent = normalized.content?.trim();
      if (normalizedContent == null || normalizedContent.isEmpty) return;
      setState(() {
        _editorContent = normalizedContent;
      });
    } catch (_) {
      // 忽略草稿加载错误
    }
  }

  Future<void> _saveDraft() async {
    if (_editorContent.trim().isEmpty) return;

    try {
      final repository = ref.read(commentRepositoryProvider);
      final success = await repository.saveDraft(
        topicId: 0,
        content: _editorContent.trim(),
      );

      if (!mounted) return;
      setState(() {
        _draftSaved = success;
        if (success) _draftSavedAt = DateTime.now();
      });
    } catch (_) {
      // 忽略草稿保存错误
    }
  }

  Future<void> _deleteDraft() async {
    try {
      final repository = ref.read(commentRepositoryProvider);
      await repository.deleteDraft(topicId: 0);
    } catch (_) {
      // 忽略删除错误
    }
  }

  Future<void> _publish() async {
    final hasSession = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!mounted) return;
    if (!hasSession) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先登录'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () => context.push(RoutePaths.login),
          ),
        ),
      );
      return;
    }

    final title = _titleController.text.trim();
    final contentTrimmed = _editorContent.trim();
    if (title.isEmpty || contentTrimmed.isEmpty) {
      setState(() {
        _errorMessage = title.isEmpty ? '请输入标题' : '请输入正文内容';
      });
      return;
    }
    final validationError = _validateBeforePublish(
      title: title,
      content: contentTrimmed,
    );
    if (validationError != null) {
      _focusInvalidField(title: title, content: contentTrimmed);
      setState(() {
        _errorMessage = validationError;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _loadingMessage = _selectedImages.isEmpty ? '发布中...' : '上传图片中...';
      _errorMessage = null;
    });

    try {
      final prepared = await _preparePublishContent(contentTrimmed);
      if (!mounted || prepared == null) return;

      if (_selectedImages.isNotEmpty) {
        setState(() {
          _loadingMessage = '发布中...';
        });
      }

      final categoryId = AppConstants.forumCategoryIds[_selectedCategory];
      final data = <String, String>{
        'title': title,
        'content': prepared.content,
        if (categoryId != null) 'category': categoryId.toString(),
      };

      final response = await ref
          .read(feedRepositoryProvider)
          .createFeed(data: data);
      if (!mounted) return;

      if (response.status == 200) {
        await _deleteDraft();
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('发布成功')));
        if (prepared.failedCount > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('有 ${prepared.failedCount} 张图片上传失败，已发布其余内容。'),
            ),
          );
        }
        context.pop(true);
        return;
      }

      setState(() {
        _errorMessage = _resolvePublishError(
          status: response.status,
          message: response.message,
        );
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '发布失败，请稍后重试';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<_PreparedPublishContent?> _preparePublishContent(
    String baseContent,
  ) async {
    if (_selectedImages.isEmpty) {
      return _PreparedPublishContent(content: baseContent, failedCount: 0);
    }

    final repository = ref.read(commentRepositoryProvider);
    final markdowns = <String>[];
    int failedCount = 0;

    for (var index = 0; index < _selectedImages.length; index++) {
      if (!mounted) return null;
      setState(() {
        _loadingMessage = '上传图片中...(${index + 1}/${_selectedImages.length})';
      });

      final file = _selectedImages[index];
      final result = await repository.uploadCommentImage(
        filePath: file.path,
        fileName: file.name,
      );
      if (result.success && result.markdown != null) {
        markdowns.add(result.markdown!);
      } else {
        failedCount += 1;
      }
    }

    if (markdowns.isEmpty) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = '图片上传失败，请重试或移除后发布';
        });
      }
      return null;
    }

    final imageMarkdown = markdowns.join('\n');
    final mergedContent = baseContent.trim().isEmpty
        ? imageMarkdown
        : '${baseContent.trimRight()}\n\n$imageMarkdown';

    return _PreparedPublishContent(
      content: mergedContent,
      failedCount: failedCount,
    );
  }

  String _resolvePublishError({int? status, String? message}) {
    final normalized = (message ?? '').trim();
    switch (status) {
      case 401:
      case 403:
        return '请先登录后再发布';
      case 422:
        if (normalized.isNotEmpty &&
            !normalized.startsWith('Failed to create feed:')) {
          return normalized;
        }
        return '标题或正文不符合要求（标题至少$_minTitleLength字，正文至少$_minBodyLength字）';
      case 429:
        return '发布过于频繁，请稍后重试';
      default:
        return normalized.isNotEmpty ? normalized : '发布失败，请稍后重试';
    }
  }

  String? _validateBeforePublish({
    required String title,
    required String content,
  }) {
    if (title.runes.length < _minTitleLength) {
      return '标题至少$_minTitleLength个字';
    }
    if (content.runes.length < _minBodyLength) {
      return '正文至少$_minBodyLength个字';
    }
    return null;
  }

  void _focusInvalidField({required String title, required String content}) {
    if (title.runes.length < _minTitleLength) {
      _titleFocusNode.requestFocus();
    }
  }

  Future<void> _onClosePressed() async {
    if (_isLoading || !_hasUnsavedChanges) {
      context.pop();
      return;
    }

    final shouldExit = await showModalBottomSheet<bool>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                title: Text(
                  '是否保存草稿后退出？',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('你当前输入的标题和正文还没有发布'),
              ),
              ListTile(
                leading: const Icon(Icons.save_outlined),
                title: const Text('保存草稿并退出'),
                onTap: () => Navigator.of(context).pop(true),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text('直接退出'),
                onTap: () => Navigator.of(context).pop(false),
              ),
            ],
          ),
        );
      },
    );

    if (!mounted || shouldExit == null) return;
    if (shouldExit) {
      await _saveDraft();
    }
    if (!mounted) return;
    context.pop();
  }

  Future<void> _openCategorySheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: [
              const ListTile(
                title: Text(
                  '选择发布板块',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              ..._categories.map((cat) {
                final id = cat['id']!;
                final selected = id == _selectedCategory;
                return ListTile(
                  title: Text(cat['label'] ?? ''),
                  subtitle: Text(cat['hint'] ?? ''),
                  trailing: selected
                      ? const Icon(Icons.check_circle, color: Color(0xFF10A37F))
                      : null,
                  onTap: () => Navigator.of(context).pop(id),
                );
              }),
            ],
          ),
        );
      },
    );

    if (!mounted || selected == null) return;
    setState(() {
      _selectedCategory = selected;
    });
  }

  Future<void> _importFromClipboard() async {
    final clipboardData = await Clipboard.getData('text/plain');
    final text = clipboardData?.text?.trim() ?? '';
    if (text.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('剪贴板暂无可导入文本')));
      return;
    }

    if (!mounted) return;
    setState(() {
      if (_editorContent.trim().isEmpty) {
        _editorContent = text;
      } else {
        _editorContent = '${_editorContent.trimRight()}\n\n$text';
      }
      _draftSaved = false;
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('已从剪贴板导入内容')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _onClosePressed,
          tooltip: '关闭',
        ),
        title: const Text('发布话题'),
        centerTitle: false,
        actions: [
          if (!_isLoading)
            IconButton(
              onPressed: _saveDraft,
              icon: Icon(
                _draftSaved ? Icons.check_circle : Icons.save_outlined,
                color: _draftSaved ? const Color(0xFF10A37F) : null,
              ),
              tooltip: '保存草稿',
            ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton(
              onPressed: _canPublish ? _publish : null,
              child: _isLoading
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 6),
                        Text(_loadingMessage),
                      ],
                    )
                  : const Text('发布'),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryBar(),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.12),
          ),
          _buildTitleSection(),
          Divider(
            height: 1,
            thickness: 1,
            color: Theme.of(
              context,
            ).colorScheme.outline.withValues(alpha: 0.12),
          ),
          Expanded(child: _buildBodyEditor()),
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          _buildSettingRows(),
          _buildEditorToolbar(),
        ],
      ),
    );
  }

  Widget _buildCategoryBar() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _openCategorySheet,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7F7EF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF10A37F),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text('发布到板块', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedCategoryLabel,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _selectedCategoryHint,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, size: 28),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    final isTitleValid = _titleLength >= _minTitleLength;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            focusNode: _titleFocusNode,
            decoration: const InputDecoration(
              hintText: '标题',
              border: InputBorder.none,
              counterText: '',
            ),
            style: const TextStyle(
              fontSize: 52 / 2,
              fontWeight: FontWeight.w600,
            ),
            maxLength: 100,
          ),
          Text(
            isTitleValid
                ? '标题长度合格（$_titleLength/100）'
                : '标题至少$_minTitleLength个字（$_titleLength/100）',
            style: TextStyle(
              fontSize: 12,
              color: isTitleValid
                  ? const Color(0xFF10A37F)
                  : Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyEditor() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: QuillComposerEditor(
        initialText: _editorContent,
        hintText: '分享你的想法，支持富文本编辑...',
        onTextChanged: _onEditorTextChanged,
        minHeight: 250,
        maxHeight: 500,
        showToolbar: true,
      ),
    );
  }

  Widget _buildSettingRows() {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: Column(
        children: [
          _buildSettingItem(
            icon: Icons.upload_file_outlined,
            title: '导入文档',
            value: '剪贴板',
            onTap: _importFromClipboard,
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                icon,
                size: 28,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text(title, style: const TextStyle(fontSize: 20)),
              const Spacer(),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right, size: 26),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditorToolbar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_draftSaved && _draftSavedAt != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(
                  '草稿已保存 ${_draftSavedAt!.hour.toString().padLeft(2, '0')}:${_draftSavedAt!.minute.toString().padLeft(2, '0')} · 正文$_wordCount字',
                  style: TextStyle(
                    fontSize: 11,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            Row(
              children: [
                _buildToolButton(
                  icon: Icons.image_outlined,
                  tooltip: '图片',
                  active: _selectedImages.isNotEmpty,
                  onTap: _pickImagesFromDevice,
                ),
              ],
            ),
            if (_selectedImages.isNotEmpty) ...[
              const SizedBox(height: 8),
              SizedBox(
                height: 72,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  separatorBuilder: (_, index) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final image = _selectedImages[index];
                    return _buildSelectedImageCard(image, index);
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedImageCard(XFile image, int index) {
    return Container(
      width: 72,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(image.path),
                fit: BoxFit.cover,
                errorBuilder: (_, error, stackTrace) {
                  return const Center(child: Icon(Icons.broken_image_outlined));
                },
              ),
            ),
          ),
          Positioned(
            top: 2,
            right: 2,
            child: InkWell(
              onTap: () => _removeSelectedImage(index),
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
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
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
          foregroundColor: active
              ? const Color(0xFF0B8A6A)
              : colorScheme.onSurfaceVariant,
          minimumSize: const Size(34, 34),
        ),
        icon: Icon(icon, size: 18),
      ),
    );
  }

  Future<void> _pickImagesFromDevice() async {
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
      final quality = ref.read(imageQualityProvider).imagePickerQuality;
      final files = await _imagePicker.pickMultiImage(imageQuality: quality);
      if (!mounted || files.isEmpty) return;

      setState(() {
        final existingPaths = _selectedImages.map((e) => e.path).toSet();
        for (final file in files) {
          if (!existingPaths.contains(file.path)) {
            _selectedImages.add(file);
          }
        }
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('选择图片失败，请稍后重试')));
    } finally {
      _isPickingImage = false;
    }
  }

  void _removeSelectedImage(int index) {
    if (index < 0 || index >= _selectedImages.length) return;
    setState(() {
      _selectedImages.removeAt(index);
    });
  }
}
