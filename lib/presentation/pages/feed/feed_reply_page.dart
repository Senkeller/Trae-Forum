import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';
import '../../providers/reply_provider.dart';
import '../../widgets/editor/quill_composer_editor.dart';

class FeedReplyPage extends ConsumerStatefulWidget {
  final String feedId;

  const FeedReplyPage({
    super.key,
    required this.feedId,
  });

  @override
  ConsumerState<FeedReplyPage> createState() => _FeedReplyPageState();
}

class _FeedReplyPageState extends ConsumerState<FeedReplyPage> {
  final QuillComposerEditorController _editorController = QuillComposerEditorController();

  bool _isReplyingToFloor = false;
  String? _replyingToUsername;

  Future<void> _sendReply() async {
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

    final content = _editorController.getMarkdown().trim();
    final topicId = int.tryParse(widget.feedId);
    if (topicId == null || topicId <= 0) {
      // 使用 ReplyProvider 的状态管理 - 通过调用方法来设置错误状态
      await ref.read(replyNotifierProvider.notifier).sendReply(
        topicId: -1, // 无效ID会触发错误
        content: content,
      );
      return;
    }

    final notifier = ref.read(replyNotifierProvider.notifier);
    final result = await notifier.sendReply(
      topicId: topicId,
      content: content,
      replyToPostNumber:
          _isReplyingToFloor ? _extractPostNumberFromContent(content) : null,
    );

    if (!mounted) return;

    if (result.success) {
      ref.read(replyListRefreshProvider.notifier).refresh();
      context.pop(true);
    }
    // 错误处理由 Provider 自动管理，UI 通过 watch 自动更新
  }

  /// 重试发送回复
  Future<void> _retrySendReply() async {
    final content = _editorController.getMarkdown().trim();
    final topicId = int.tryParse(widget.feedId);
    if (topicId == null) return;

    final notifier = ref.read(replyNotifierProvider.notifier);
    await notifier.sendReply(
      topicId: topicId,
      content: content,
      replyToPostNumber:
          _isReplyingToFloor ? _extractPostNumberFromContent(content) : null,
    );
  }

  int? _extractPostNumberFromContent(String content) {
    final regExp = RegExp(r'>@\w+\s*#(\d+)');
    final match = regExp.firstMatch(content);
    if (match != null) {
      return int.tryParse(match.group(1) ?? '');
    }
    return null;
  }

  void _setQuoteReply(String? username) {
    setState(() {
      if (username != null) {
        _isReplyingToFloor = true;
        _replyingToUsername = username;
        _editorController.setMarkdown('>@$username\n');
      } else {
        _isReplyingToFloor = false;
        _replyingToUsername = null;
        _editorController.setMarkdown('');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;
    final colorScheme = Theme.of(context).colorScheme;

    // 监听回复状态
    final replyState = ref.watch(replyNotifierProvider);
    final isLoading = replyState.isLoading;
    final errorMessage = replyState.error;
    final loadingState = replyState.loadingState;
    final retryCount = replyState.retryCount;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('回复'),
        ),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可参与回复',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('回复'),
        actions: [
          TextButton(
            onPressed: isLoading ? null : _sendReply,
            child: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('发送'),
          ),
        ],
      ),
      body: Column(
        children: [
          // 回复目标提示条
          if (_isReplyingToFloor && _replyingToUsername != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              child: Row(
                children: [
                  Icon(
                    Icons.format_quote,
                    size: 18,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '回复 @$_replyingToUsername',
                      style: TextStyle(color: colorScheme.primary),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => _setQuoteReply(null),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),

          // 重试状态提示
          if (loadingState == LoadingState.retrying)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '网络异常，正在重试 (${retryCount + 1}/3)...',
                      style: TextStyle(color: colorScheme.onPrimaryContainer),
                    ),
                  ),
                ],
              ),
            ),

          // 错误提示
          if (errorMessage != null && loadingState != LoadingState.retrying)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: colorScheme.onErrorContainer,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: colorScheme.onErrorContainer),
                    ),
                  ),
                  TextButton(
                    onPressed: isLoading ? null : _retrySendReply,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.onErrorContainer,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    child: const Text('重试'),
                  ),
                ],
              ),
            ),

          // 编辑器区域
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: QuillComposerEditor(
                controller: _editorController,
                hintText: '输入回复内容...',
                autofocus: true,
                maxLength: 10000,
              ),
            ),
          ),
        ],
      ),
    );
  }
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
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
