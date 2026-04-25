import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path_util;

import '../../../config/constants.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../data/repositories/feed_repository.dart';
import '../../providers/auth_provider.dart';

enum _PostLayoutMode { cover, grid }

class FeedCreatePage extends ConsumerStatefulWidget {
  const FeedCreatePage({super.key});

  @override
  ConsumerState<FeedCreatePage> createState() => _FeedCreatePageState();
}

class _FeedCreatePageState extends ConsumerState<FeedCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final FocusNode _contentFocusNode = FocusNode();
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false;
  String _loadingMessage = '发布中...';
  String? _errorMessage;
  _PostLayoutMode _layoutMode = _PostLayoutMode.cover;
  String _selectedCategory = 'discussion';
  final List<String> _selectedTags = [];
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

  final List<String> _availableTags = const [
    '数码日常',
    'DeepSeek',
    'Trae',
    '薅羊毛小分队',
    '效率工具',
    '编程经验',
  ];

  bool get _canPublish =>
      !_isLoading &&
      _titleController.text.trim().isNotEmpty &&
      _contentController.text.trim().isNotEmpty;

  int get _maxImageCount => _layoutMode == _PostLayoutMode.cover ? 1 : 9;

  String get _selectedCategoryLabel {
    for (final cat in _categories) {
      if (cat['id'] == _selectedCategory) return cat['label'] ?? '互动交流';
    }
    return '互动交流';
  }

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
    _contentController.addListener(_onInputChanged);
  }

  @override
  void dispose() {
    _titleController.removeListener(_onInputChanged);
    _contentController.removeListener(_onInputChanged);
    _titleController.dispose();
    _contentController.dispose();
    _contentFocusNode.dispose();
    super.dispose();
  }

  void _onInputChanged() {
    if (mounted) {
      setState(() {
        _errorMessage = null;
      });
    }
  }

  Future<void> _publish() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.uid.isEmpty) {
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
    final contentRaw = _contentController.text;
    final contentTrimmed = contentRaw.trim();
    if (title.isEmpty || contentTrimmed.isEmpty) {
      setState(() {
        _errorMessage = title.isEmpty ? '请输入标题' : '请输入正文内容';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _loadingMessage = '发布中...';
      _errorMessage = null;
    });

    try {
      final categoryId = AppConstants.forumCategoryIds[_selectedCategory];
      final selection = _contentController.selection;
      final rawContent = await _composeRawContentWithUploadedImages(
        contentRaw,
        selectionStart: selection.isValid ? selection.start : contentRaw.length,
        selectionEnd: selection.isValid ? selection.end : contentRaw.length,
      );
      final data = <String, String>{
        'title': title,
        'content': rawContent.trim(),
        if (categoryId != null) 'category': categoryId.toString(),
      };

      final response = await ref
          .read(feedRepositoryProvider)
          .createFeed(data: data);
      if (!mounted) return;

      if (response.status == 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('发布成功')));
        context.pop(true);
        return;
      }

      setState(() {
        _errorMessage = _resolvePublishError(
          status: response.status,
          message: response.message,
        );
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e is _TopicImageUploadException
            ? e.message
            : '发布失败，请稍后重试';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<String> _composeRawContentWithUploadedImages(
    String content, {
    required int selectionStart,
    required int selectionEnd,
  }) async {
    if (_selectedImages.isEmpty) {
      return content;
    }

    final repository = ref.read(commentRepositoryProvider);
    final markdownSnippets = <String>[];

    for (int i = 0; i < _selectedImages.length; i++) {
      if (!mounted) break;

      setState(() {
        _loadingMessage = '上传图片 ${i + 1}/${_selectedImages.length}...';
      });

      final image = _selectedImages[i];
      final fileName = path_util.basename(image.path);
      final result = await repository.uploadCommentImage(
        filePath: image.path,
        fileName: fileName,
      );

      if (!result.success ||
          result.markdown == null ||
          result.markdown!.trim().isEmpty) {
        throw _TopicImageUploadException(result.errorMessage ?? '图片上传失败，请稍后重试');
      }

      markdownSnippets.add(result.markdown!.trim());
    }

    if (markdownSnippets.isEmpty) {
      return content;
    }

    final imageMarkdownBlock = markdownSnippets.join('\n\n');
    return _insertAtSelection(
      text: content,
      inserted: imageMarkdownBlock,
      selectionStart: selectionStart,
      selectionEnd: selectionEnd,
    );
  }

  String _insertAtSelection({
    required String text,
    required String inserted,
    required int selectionStart,
    required int selectionEnd,
  }) {
    final safeStart = selectionStart.clamp(0, text.length);
    final safeEnd = selectionEnd.clamp(0, text.length);
    final start = safeStart <= safeEnd ? safeStart : safeEnd;
    final end = safeStart <= safeEnd ? safeEnd : safeStart;

    final prefix = text.substring(0, start);
    final suffix = text.substring(end);

    final needsPrefixBreak = prefix.isNotEmpty && !prefix.endsWith('\n');
    final needsSuffixBreak = suffix.isNotEmpty && !suffix.startsWith('\n');

    final buffer = StringBuffer(prefix);
    if (needsPrefixBreak) {
      buffer.write('\n\n');
    }
    buffer.write(inserted);
    if (needsSuffixBreak) {
      buffer.write('\n\n');
    }
    buffer.write(suffix);
    return buffer.toString();
  }

  String _resolvePublishError({int? status, String? message}) {
    switch (status) {
      case 401:
      case 403:
        return '请先登录后再发布';
      case 422:
        return '标题或正文不符合要求，请检查后重试';
      case 429:
        return '发布过于频繁，请稍后重试';
      default:
        final normalized = (message ?? '').trim();
        return normalized.isNotEmpty ? normalized : '发布失败，请稍后重试';
    }
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

  Future<void> _pickImages() async {
    final remaining = _maxImageCount - _selectedImages.length;
    if (remaining <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _layoutMode == _PostLayoutMode.cover
                ? '大封面模式只能选择 1 张图片'
                : '最多可选择 9 张图片',
          ),
        ),
      );
      return;
    }

    try {
      if (_layoutMode == _PostLayoutMode.cover) {
        final picked = await _imagePicker.pickImage(
          source: ImageSource.gallery,
        );
        if (picked == null || !mounted) return;
        setState(() {
          _selectedImages
            ..clear()
            ..add(picked);
        });
        return;
      }

      final picked = await _imagePicker.pickMultiImage(imageQuality: 92);
      if (!mounted || picked.isEmpty) return;

      setState(() {
        _selectedImages.addAll(picked.take(remaining));
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('选择图片失败，请检查权限后重试')));
    }
  }

  void _changeLayoutMode(_PostLayoutMode mode) {
    if (_layoutMode == mode) return;
    setState(() {
      _layoutMode = mode;
      if (_layoutMode == _PostLayoutMode.cover && _selectedImages.length > 1) {
        _selectedImages.removeRange(1, _selectedImages.length);
      }
    });
  }

  void _removeImageAt(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  void _insertAtCursor(String text) {
    final oldValue = _contentController.value;
    final selection = oldValue.selection;
    final start = selection.isValid ? selection.start : oldValue.text.length;
    final end = selection.isValid ? selection.end : oldValue.text.length;
    final safeStart = start < 0 ? oldValue.text.length : start;
    final safeEnd = end < 0 ? oldValue.text.length : end;

    final newText = oldValue.text.replaceRange(safeStart, safeEnd, text);
    final offset = safeStart + text.length;

    _contentController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: offset),
    );

    _contentFocusNode.requestFocus();
  }

  void _showNotReadyMessage(String feature) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$feature 功能开发中')));
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;
    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(title: const Text('新建话题')),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可发布话题',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
          tooltip: '关闭',
        ),
        centerTitle: true,
        title: SegmentedButton<_PostLayoutMode>(
          segments: const [
            ButtonSegment(value: _PostLayoutMode.cover, label: Text('大封面')),
            ButtonSegment(value: _PostLayoutMode.grid, label: Text('九宫格')),
          ],
          selected: {_layoutMode},
          onSelectionChanged: (selection) {
            _changeLayoutMode(selection.first);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton(
              onPressed: _canPublish ? _publish : null,
              child: _isLoading
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                        const SizedBox(width: 8),
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
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryCard(),
                  const SizedBox(height: 12),
                  const Divider(height: 1),
                  const SizedBox(height: 14),
                  _buildImageSection(),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: '请输入标题（必填）',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLength: 100,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _contentController,
                    focusNode: _contentFocusNode,
                    decoration: const InputDecoration(
                      hintText: '分享你此刻的想法...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    minLines: 8,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  if (_errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  _buildSettingItem(
                    icon: Icons.shopping_bag_outlined,
                    title: '添加商品',
                    trailing: '分享你的好物',
                    onTap: () => _showNotReadyMessage('添加商品'),
                  ),
                  _buildSettingItem(
                    icon: Icons.remove_red_eye_outlined,
                    title: '谁可以看',
                    trailing: '公开',
                    onTap: () => _showNotReadyMessage('可见范围设置'),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _availableTags.length,
                      separatorBuilder: (_, index) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final tag = _availableTags[index];
                        final selected = _selectedTags.contains(tag);
                        return FilterChip(
                          label: Text('#$tag'),
                          selected: selected,
                          onSelected: (_) => _toggleTag(tag),
                          side: BorderSide.none,
                          showCheckmark: false,
                          selectedColor: const Color(0xFFDFF4E8),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomToolbar(),
        ],
      ),
    );
  }

  Widget _buildCategoryCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _openCategorySheet,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F7EE),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF10A37F),
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              const Text('发布到', style: TextStyle(fontSize: 18)),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  '$_selectedCategoryLabel · $_selectedCategoryHint',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 15,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    final helperText = _layoutMode == _PostLayoutMode.cover
        ? '大封面模式最多 1 张图'
        : '九宫格模式最多 9 张图，可继续添加';

    if (_layoutMode == _PostLayoutMode.cover) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageTile(
            size: 120,
            image: _selectedImages.isEmpty ? null : _selectedImages.first,
            onTap: _pickImages,
            onRemove: _selectedImages.isEmpty ? null : () => _removeImageAt(0),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              '$helperText\n发无关图、色情图将会被禁言',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            const gap = 8.0;
            final size = (constraints.maxWidth - gap * 2) / 3;
            final List<Widget> items = [];
            for (int i = 0; i < _selectedImages.length; i++) {
              items.add(
                _buildImageTile(
                  size: size,
                  image: _selectedImages[i],
                  onTap: () => _showNotReadyMessage('图片预览'),
                  onRemove: () => _removeImageAt(i),
                ),
              );
            }
            if (_selectedImages.length < _maxImageCount) {
              items.add(
                _buildImageTile(size: size, image: null, onTap: _pickImages),
              );
            }
            return Wrap(spacing: gap, runSpacing: gap, children: items);
          },
        ),
        const SizedBox(height: 10),
        Text(
          '$helperText，发无关图、色情图将会被禁言',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildImageTile({
    required double size,
    required VoidCallback onTap,
    XFile? image,
    VoidCallback? onRemove,
  }) {
    final borderRadius = BorderRadius.circular(12);

    return Stack(
      children: [
        Material(
          color: const Color(0xFFF0F0F4),
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: SizedBox(
              width: size,
              height: size,
              child: image == null
                  ? const Icon(Icons.add, size: 44, color: Color(0xFF7A7A7A))
                  : ClipRRect(
                      borderRadius: borderRadius,
                      child: Image.file(File(image.path), fit: BoxFit.cover),
                    ),
            ),
          ),
        ),
        if (onRemove != null)
          Positioned(
            top: 6,
            right: 6,
            child: InkWell(
              onTap: onRemove,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.close, size: 14, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.onSurfaceVariant),
            const SizedBox(width: 12),
            Text(title, style: const TextStyle(fontSize: 16)),
            const Spacer(),
            Text(
              trailing,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomToolbar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _ToolbarAction(
              icon: Icons.emoji_emotions_outlined,
              onTap: () => _insertAtCursor('😀 '),
            ),
            _ToolbarAction(icon: Icons.image_outlined, onTap: _pickImages),
            _ToolbarAction(
              icon: Icons.alternate_email,
              onTap: () => _insertAtCursor('@'),
            ),
            _ToolbarAction(icon: Icons.tag, onTap: () => _insertAtCursor('#')),
            _ToolbarAction(
              icon: Icons.add_circle_outline,
              onTap: () => _showNotReadyMessage('更多功能'),
            ),
            _ToolbarAction(
              icon: Icons.apps,
              onTap: () => _showNotReadyMessage('快捷面板'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolbarAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ToolbarAction({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 28,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _TopicImageUploadException implements Exception {
  final String message;

  const _TopicImageUploadException(this.message);
}

class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
