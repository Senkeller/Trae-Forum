import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../config/constants.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../data/repositories/feed_repository.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/editor/composer_editor.dart';
import '../../widgets/editor/composer_preview.dart';

enum _PostLayoutMode { cover, grid }

/// Feed 创建页面
///
/// 使用 ComposerEditor 编辑器，支持：
/// - Markdown 语法编辑
/// - 实时预览模式
/// - 图片上传与 Markdown 插入
/// - 分类选择
/// - 标签选择
/// - 草稿保存/恢复
class FeedCreatePage extends ConsumerStatefulWidget {
  const FeedCreatePage({super.key});

  @override
  ConsumerState<FeedCreatePage> createState() => _FeedCreatePageState();
}

class _FeedCreatePageState extends ConsumerState<FeedCreatePage> {
  final TextEditingController _titleController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  bool _isLoading = false;
  String _loadingMessage = '发布中...';
  String? _errorMessage;
  _PostLayoutMode _layoutMode = _PostLayoutMode.cover;
  String _selectedCategory = 'discussion';
  final List<String> _selectedTags = [];
  final List<XFile> _selectedImages = [];

  /// 编辑器内容
  String _editorContent = '';

  /// 是否显示预览模式
  bool _isPreviewMode = false;

  /// 草稿是否已保存
  bool _draftSaved = false;

  /// 草稿保存时间
  DateTime? _draftSavedAt;

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

  /// 是否可以发布
  bool get _canPublish =>
      !_isLoading &&
      _titleController.text.trim().isNotEmpty &&
      _editorContent.trim().isNotEmpty;

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
    _loadDraft();
  }

  @override
  void dispose() {
    _titleController.removeListener(_onInputChanged);
    _titleController.dispose();
    super.dispose();
  }

  /// 输入变化回调
  void _onInputChanged() {
    if (mounted) {
      setState(() {
        _errorMessage = null;
      });
    }
  }

  /// 编辑器内容变化回调
  void _onEditorTextChanged(String text) {
    setState(() {
      _editorContent = text;
      _errorMessage = null;
      _draftSaved = false;
    });
  }

  /// 加载草稿
  Future<void> _loadDraft() async {
    try {
      final repository = ref.read(commentRepositoryProvider);
      final draft = await repository.getDraft(
        topicId: 0,
        replyToPostNumber: null,
      );

      if (draft != null && draft.content.isNotEmpty && mounted) {
        setState(() {
          _editorContent = draft.content;
        });
      }
    } catch (e) {
      // 忽略草稿加载错误
    }
  }

  /// 保存草稿
  Future<void> _saveDraft() async {
    if (_editorContent.trim().isEmpty) return;

    try {
      final repository = ref.read(commentRepositoryProvider);
      final success = await repository.saveDraft(
        topicId: 0,
        content: _editorContent.trim(),
      );

      if (mounted) {
        setState(() {
          _draftSaved = success;
          if (success) {
            _draftSavedAt = DateTime.now();
          }
        });
      }
    } catch (e) {
      // 忽略草稿保存错误
    }
  }

  /// 删除草稿
  Future<void> _deleteDraft() async {
    try {
      final repository = ref.read(commentRepositoryProvider);
      await repository.deleteDraft(topicId: 0);
    } catch (e) {
      // 忽略删除错误
    }
  }

  /// 发布话题
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
    final contentTrimmed = _editorContent.trim();
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
      final data = <String, String>{
        'title': title,
        'content': contentTrimmed,
        if (categoryId != null) 'category': categoryId.toString(),
      };

      final response = await ref
          .read(feedRepositoryProvider)
          .createFeed(data: data, tags: _selectedTags);
      if (!mounted) return;

      if (response.status == 200) {
        // 发布成功后删除草稿
        await _deleteDraft();

        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('发布成功')));
        if (!mounted) return;
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

  /// 打开分类选择面板
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

  /// 选择图片
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

  /// 切换布局模式
  void _changeLayoutMode(_PostLayoutMode mode) {
    if (_layoutMode == mode) return;
    setState(() {
      _layoutMode = mode;
      if (_layoutMode == _PostLayoutMode.cover && _selectedImages.length > 1) {
        _selectedImages.removeRange(1, _selectedImages.length);
      }
    });
  }

  /// 删除图片
  void _removeImageAt(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  /// 切换标签选择
  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        _selectedTags.add(tag);
      }
    });
  }

  /// 切换预览模式
  void _togglePreviewMode() {
    setState(() {
      _isPreviewMode = !_isPreviewMode;
    });
  }

  /// 显示未就绪功能提示
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
          // 预览模式切换按钮
          IconButton(
            onPressed: _togglePreviewMode,
            icon: Icon(
              _isPreviewMode ? Icons.edit : Icons.remove_red_eye,
              color: _isPreviewMode
                  ? Theme.of(context).colorScheme.primary
                  : null,
            ),
            tooltip: _isPreviewMode ? '编辑模式' : '预览模式',
          ),
          // 草稿保存按钮
          if (!_isLoading)
            IconButton(
              onPressed: _saveDraft,
              icon: Icon(
                _draftSaved ? Icons.check_circle : Icons.save_outlined,
                color: _draftSaved
                    ? const Color(0xFF10A37F)
                    : null,
              ),
              tooltip: '保存草稿',
            ),
          // 发布按钮
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
          // 分类选择卡片
          _buildCategoryCard(),
          const Divider(height: 1),
          // 图片选择区域
          _buildImageSection(),
          const Divider(height: 1),
          // 标题输入
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: '请输入标题（必填）',
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: Theme.of(context).textTheme.titleMedium,
              maxLength: 100,
            ),
          ),
          // 编辑器区域
          Expanded(
            child: _isPreviewMode
                ? _buildPreviewSection()
                : _buildEditorSection(),
          ),
          // 错误信息
          if (_errorMessage != null)
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
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
          // 标签选择区域
          _buildTagsSection(),
        ],
      ),
    );
  }

  /// 构建分类选择卡片
  Widget _buildCategoryCard() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _openCategorySheet,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

  /// 构建图片选择区域
  Widget _buildImageSection() {
    final helperText = _layoutMode == _PostLayoutMode.cover
        ? '大封面模式最多 1 张图'
        : '九宫格模式最多 9 张图，可继续添加';

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_layoutMode == _PostLayoutMode.cover)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageTile(
                  size: 120,
                  image: _selectedImages.isEmpty ? null : _selectedImages.first,
                  onTap: _pickImages,
                  onRemove:
                      _selectedImages.isEmpty ? null : () => _removeImageAt(0),
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
            )
          else
            Column(
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
                        _buildImageTile(
                            size: size, image: null, onTap: _pickImages),
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
            ),
        ],
      ),
    );
  }

  /// 构建图片格子
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

  /// 构建编辑器区域
  Widget _buildEditorSection() {
    return ComposerEditor(
      initialText: _editorContent,
      hintText: '分享你此刻的想法...（支持 Markdown 语法）',
      onTextChanged: _onEditorTextChanged,
      showPreview: false,
      showToolbar: true,
      showAttachmentPanel: false,
      enableSplitView: false,
      minHeight: 200,
      maxLength: 10000,
      submitButtonText: '发布',
      enableEmojiPicker: true,
    );
  }

  /// 构建预览区域
  Widget _buildPreviewSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_titleController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  _titleController.text,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ComposerPreview(
              markdownText: _editorContent,
              emptyHint: '暂无内容',
            ),
          ],
        ),
      ),
    );
  }

  /// 构建标签选择区域
  Widget _buildTagsSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_draftSaved && _draftSavedAt != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '草稿已保存 ${_draftSavedAt!.hour.toString().padLeft(2, '0')}:${_draftSavedAt!.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
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
    );
  }
}

/// 状态视图组件
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
