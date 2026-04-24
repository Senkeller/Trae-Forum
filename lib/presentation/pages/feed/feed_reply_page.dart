import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';

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
  final TextEditingController _replyController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool _isLoading = false;
  bool _isReplyingToFloor = false;
  String? _replyingToUsername;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _replyController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

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

    final content = _replyController.text.trim();
    if (content.isEmpty) {
      setState(() {
        _errorMessage = '回复内容不能为空';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('回复功能开发中')),
      );

      context.pop();
    } catch (e) {
      setState(() {
        _errorMessage = '发送失败: $e';
        _isLoading = false;
      });
    }
  }

  void _setQuoteReply(String? username) {
    setState(() {
      if (username != null) {
        _isReplyingToFloor = true;
        _replyingToUsername = username;
        _replyController.text = '>@$username\n';
        _focusNode.requestFocus();
      } else {
        _isReplyingToFloor = false;
        _replyingToUsername = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;
    final colorScheme = Theme.of(context).colorScheme;

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
            onPressed: _isLoading ? null : _sendReply,
            child: _isLoading
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
          if (_errorMessage != null)
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
                      _errorMessage!,
                      style: TextStyle(color: colorScheme.onErrorContainer),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _replyController,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: '输入回复内容...',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
          _buildBottomBar(colorScheme),
        ],
      ),
    );
  }

  Widget _buildBottomBar(ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.format_bold),
              onPressed: () {},
              tooltip: '加粗',
            ),
            IconButton(
              icon: const Icon(Icons.format_italic),
              onPressed: () {},
              tooltip: '斜体',
            ),
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: () {},
              tooltip: '代码',
            ),
            IconButton(
              icon: const Icon(Icons.link),
              onPressed: () {},
              tooltip: '链接',
            ),
            IconButton(
              icon: const Icon(Icons.image_outlined),
              onPressed: () {},
              tooltip: '图片',
            ),
            const Spacer(),
            Text(
              '${_replyController.text.length}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              ' / 10000',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
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
