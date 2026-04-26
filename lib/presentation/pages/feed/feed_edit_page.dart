import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../data/models/feed.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../data/repositories/feed_repository.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/editor/composer_editor.dart';

/// 编辑帖子页面
///
/// 用于编辑话题首帖内容，接入 ComposerEditor 提供 Markdown 编辑能力
/// 路由: `/feed/:id/edit`
class FeedEditPage extends ConsumerStatefulWidget {
  /// 话题ID
  final String feedId;

  /// 构造函数
  ///
  /// [feedId] 话题ID，从路由参数获取
  const FeedEditPage({super.key, required this.feedId});

  @override
  ConsumerState<FeedEditPage> createState() => _FeedEditPageState();
}

class _FeedEditPageState extends ConsumerState<FeedEditPage> {
  /// 话题详情数据
  FeedContentData? _topicDetail;

  /// 首帖ID（用于编辑API）
  int? _firstPostId;

  /// 是否加载中
  bool _isLoading = true;

  /// 是否正在保存
  bool _isSaving = false;

  /// 错误信息
  String? _errorMessage;

  /// 当前编辑内容
  String _currentContent = '';

  /// 编辑原因
  final TextEditingController _editReasonController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTopicDetail();
  }

  @override
  void dispose() {
    _editReasonController.dispose();
    super.dispose();
  }

  /// 加载话题详情
  ///
  /// 获取话题首帖内容作为编辑器初始值
  /// 同时获取首帖ID用于后续编辑API调用
  Future<void> _loadTopicDetail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final feedRepository = ref.read(feedRepositoryProvider);
      final response = await feedRepository.getFeedDetail(id: widget.feedId);

      if (!mounted) return;

      if (response.status == 200 && response.data != null) {
        final detail = response.data!;

        // 获取首帖ID - 需要从评论列表中获取
        final commentRepository = ref.read(commentRepositoryProvider);
        final commentResponse = await commentRepository.getCommentList(
          id: widget.feedId,
          page: 1,
          listType: '',
        );

        int? firstPostId;
        if (commentResponse.status == 200 && commentResponse.data.isNotEmpty) {
          final firstReply = commentResponse.data.first;
          // 检查是否是首帖（楼主发的且内容与话题内容一致）
          final topicAuthorId = detail.userInfo?.uid;
          if (topicAuthorId != null && firstReply.uid == topicAuthorId) {
            firstPostId = int.tryParse(firstReply.id);
          }
        }

        setState(() {
          _topicDetail = detail;
          _firstPostId = firstPostId;
          _currentContent = detail.message;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message.isNotEmpty
              ? response.message
              : '加载话题详情失败';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = '加载失败: $e';
        _isLoading = false;
      });
    }
  }

  /// 保存编辑
  ///
  /// 调用 editPost API 保存修改后的内容
  /// 成功后返回上一页并刷新详情
  Future<void> _saveEdit() async {
    // 检查登录状态
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

    // 检查首帖ID
    if (_firstPostId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('无法获取帖子ID，请稍后重试')),
      );
      return;
    }

    // 检查内容是否为空
    final content = _currentContent.trim();
    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('帖子内容不能为空')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final commentRepository = ref.read(commentRepositoryProvider);
      final result = await commentRepository.editComment(
        postId: _firstPostId!,
        content: content,
        editReason: _editReasonController.text.trim().isNotEmpty
            ? _editReasonController.text.trim()
            : null,
      );

      if (!mounted) return;

      if (result.success) {
        await HapticFeedbackUtil.trigger(ref, HapticScene.commentSuccess);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('编辑成功')),
        );
        // 返回上一页并传递 true 表示编辑成功
        context.pop(true);
      } else {
        setState(() {
          _isSaving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.errorMessage ?? '编辑失败'),
            action: SnackBarAction(
              label: '重试',
              onPressed: _saveEdit,
            ),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('编辑失败: $e'),
          action: SnackBarAction(
            label: '重试',
            onPressed: _saveEdit,
          ),
        ),
      );
    }
  }

  /// 取消编辑
  ///
  /// 如果有未保存的修改，显示确认对话框
  void _cancelEdit() {
    // 检查是否有修改
    final originalContent = _topicDetail?.message ?? '';
    if (_currentContent.trim() != originalContent.trim()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('确认放弃编辑？'),
          content: const Text('您有未保存的修改，确定要放弃吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('继续编辑'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              child: const Text('放弃'),
            ),
          ],
        ),
      );
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: _cancelEdit,
          tooltip: '关闭',
        ),
        title: Text(_topicDetail?.title ?? '编辑帖子'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: FilledButton(
              onPressed: _isSaving ? null : _saveEdit,
              child: _isSaving
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('保存'),
            ),
          ),
        ],
      ),
      body: _buildBody(colorScheme),
    );
  }

  /// 构建页面主体
  Widget _buildBody(ColorScheme colorScheme) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('加载中...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 56,
              color: colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(
              _errorMessage!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: _loadTopicDetail,
              child: const Text('重试'),
            ),
          ],
        ),
      );
    }

    if (_topicDetail == null) {
      return const Center(
        child: Text('话题不存在'),
      );
    }

    return Column(
      children: [
        // 编辑原因输入框（可选）
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _editReasonController,
            decoration: InputDecoration(
              hintText: '编辑原因（可选）',
              prefixIcon: const Icon(Icons.edit_note),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ),
        const Divider(height: 1),
        // 编辑器区域
        Expanded(
          child: ComposerEditor(
            initialText: _topicDetail!.message,
            hintText: '编辑帖子内容...',
            autofocus: true,
            showPreview: true,
            showToolbar: true,
            enableSplitView: true,
            initialMode: ComposerEditorMode.edit,
            minHeight: 300,
            onTextChanged: (text) {
              setState(() {
                _currentContent = text;
              });
            },
          ),
        ),
      ],
    );
  }
}
