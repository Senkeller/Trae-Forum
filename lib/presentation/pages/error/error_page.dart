import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';

class ErrorPage extends StatelessWidget {
  final Exception? error;

  const ErrorPage({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('出错了'),
        leading: IconButton(
          icon: const Icon(Icons.home_outlined),
          onPressed: () => context.go(RoutePaths.main),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: colorScheme.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline,
                  size: 56,
                  color: colorScheme.onErrorContainer,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '页面出错了',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              Text(
                _getErrorMessage(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                textAlign: TextAlign.center,
              ),
              if (error != null) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.bug_report_outlined,
                            size: 16,
                            color: colorScheme.error,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '错误详情',
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        error.toString(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontFamily: 'monospace',
                              color: colorScheme.error,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    context.go(RoutePaths.main);
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('返回首页'),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    context.go(RoutePaths.home);
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('刷新页面'),
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          size: 20,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '遇到问题了？',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '你可以尝试刷新页面或返回首页。如果问题持续存在，请联系我们的客服团队。',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('反馈功能开发中')),
                      );
                    },
                    icon: const Icon(Icons.feedback_outlined, size: 18),
                    label: const Text('反馈问题'),
                  ),
                  const SizedBox(width: 16),
                  TextButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('帮助中心开发中')),
                      );
                    },
                    icon: const Icon(Icons.help_outline, size: 18),
                    label: const Text('帮助中心'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getErrorMessage() {
    if (error == null) {
      return '抱歉，页面加载时遇到了问题。';
    }

    final errorStr = error.toString().toLowerCase();

    if (errorStr.contains('timeout') || errorStr.contains('timed out')) {
      return '网络请求超时，请检查网络连接后重试。';
    }

    if (errorStr.contains('network') || errorStr.contains('connection')) {
      return '网络连接失败，请检查网络设置后重试。';
    }

    if (errorStr.contains('permission') || errorStr.contains('denied')) {
      return '权限不足，请检查应用权限设置。';
    }

    if (errorStr.contains('not found') || errorStr.contains('404')) {
      return '请求的内容不存在或已被删除。';
    }

    if (errorStr.contains('server') || errorStr.contains('500')) {
      return '服务器错误，请稍后重试。';
    }

    return '抱歉，页面加载时遇到了问题。';
  }
}
