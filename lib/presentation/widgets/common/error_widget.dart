import 'package:flutter/material.dart';

/// 错误状态组件
///
/// 用于展示网络错误、加载失败等场景
/// 支持自定义图标、文字和重试按钮
class ErrorWidget extends StatelessWidget {
  /// 错误图标
  final IconData icon;

  /// 错误标题
  final String title;

  /// 错误描述
  final String? message;

  /// 重试按钮文字
  final String retryText;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 图标大小
  final double iconSize;

  /// 图标颜色
  final Color? iconColor;

  /// 构造函数
  ///
  /// [icon] 错误图标，默认 Icons.error_outline
  /// [title] 错误标题（必填）
  /// [message] 错误描述
  /// [retryText] 重试按钮文字，默认 "重试"
  /// [onRetry] 重试回调
  /// [iconSize] 图标大小，默认 80
  /// [iconColor] 图标颜色
  const ErrorWidget({
    super.key,
    this.icon = Icons.error_outline,
    required this.title,
    this.message,
    this.retryText = '重试',
    this.onRetry,
    this.iconSize = 80,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final defaultIconColor = iconColor ?? colorScheme.error.withOpacity(0.5);

    return Semantics(
      label: '错误提示：$title，${message ?? ''}',
      hint: onRetry != null ? '双击$retryText按钮重试' : '',
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: iconSize,
                color: defaultIconColor,
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: textTheme.titleLarge?.copyWith(
                  color: colorScheme.onBackground,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              if (message != null) ...[
                const SizedBox(height: 8),
                Text(
                  message!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              if (onRetry != null) ...[
                const SizedBox(height: 24),
                Semantics(
                  label: retryText,
                  button: true,
                  child: FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                    label: Text(retryText),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// 网络错误组件
///
/// 专门用于网络连接失败的场景
class NetworkErrorWidget extends StatelessWidget {
  /// 错误描述
  final String? message;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 构造函数
  ///
  /// [message] 错误描述，默认 "网络连接失败，请检查网络设置"
  /// [onRetry] 重试回调
  const NetworkErrorWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      icon: Icons.wifi_off,
      title: '网络错误',
      message: message ?? '网络连接失败，请检查网络设置',
      onRetry: onRetry,
    );
  }
}

/// 服务器错误组件
///
/// 专门用于服务器返回错误的场景
class ServerErrorWidget extends StatelessWidget {
  /// 错误代码
  final int? statusCode;

  /// 错误描述
  final String? message;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 构造函数
  ///
  /// [statusCode] HTTP 状态码
  /// [message] 错误描述
  /// [onRetry] 重试回调
  const ServerErrorWidget({
    super.key,
    this.statusCode,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final defaultMessage = message ??
        (statusCode != null
            ? '服务器返回错误 (代码: $statusCode)'
            : '服务器暂时不可用，请稍后重试');

    return ErrorWidget(
      icon: Icons.cloud_off,
      title: '服务器错误',
      message: defaultMessage,
      onRetry: onRetry,
    );
  }
}

/// 加载失败组件
///
/// 专门用于数据加载失败的场景
class LoadErrorWidget extends StatelessWidget {
  /// 错误描述
  final String? message;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 构造函数
  ///
  /// [message] 错误描述，默认 "数据加载失败"
  /// [onRetry] 重试回调
  const LoadErrorWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      icon: Icons.refresh,
      title: '加载失败',
      message: message ?? '数据加载失败，请稍后重试',
      onRetry: onRetry,
    );
  }
}

/// 权限错误组件
///
/// 专门用于权限不足的场景
class PermissionErrorWidget extends StatelessWidget {
  /// 错误描述
  final String? message;

  /// 去设置回调
  final VoidCallback? onGoSettings;

  /// 构造函数
  ///
  /// [message] 错误描述，默认 "您没有权限访问此内容"
  /// [onGoSettings] 去设置回调
  const PermissionErrorWidget({
    super.key,
    this.message,
    this.onGoSettings,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      icon: Icons.lock_outline,
      title: '权限不足',
      message: message ?? '您没有权限访问此内容',
      retryText: '去设置',
      onRetry: onGoSettings,
    );
  }
}

/// 404 错误组件
///
/// 专门用于页面不存在的场景
class NotFoundErrorWidget extends StatelessWidget {
  /// 错误描述
  final String? message;

  /// 返回首页回调
  final VoidCallback? onGoHome;

  /// 构造函数
  ///
  /// [message] 错误描述，默认 "您访问的页面不存在"
  /// [onGoHome] 返回首页回调
  const NotFoundErrorWidget({
    super.key,
    this.message,
    this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      icon: Icons.search_off,
      title: '页面不存在',
      message: message ?? '您访问的页面不存在或已被删除',
      retryText: '返回首页',
      onRetry: onGoHome,
    );
  }
}

/// 全屏错误组件
///
/// 用于需要全屏展示错误的场景，带背景色
class FullScreenErrorWidget extends StatelessWidget {
  /// 错误图标
  final IconData icon;

  /// 错误标题
  final String title;

  /// 错误描述
  final String? message;

  /// 重试按钮文字
  final String retryText;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 构造函数
  ///
  /// [icon] 错误图标
  /// [title] 错误标题（必填）
  /// [message] 错误描述
  /// [retryText] 重试按钮文字
  /// [onRetry] 重试回调
  const FullScreenErrorWidget({
    super.key,
    this.icon = Icons.error_outline,
    required this.title,
    this.message,
    this.retryText = '重试',
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background,
      child: ErrorWidget(
        icon: icon,
        title: title,
        message: message,
        retryText: retryText,
        onRetry: onRetry,
      ),
    );
  }
}

/// 带重试功能的错误组件
///
/// 简化版的错误组件，用于列表等场景的错误展示
class ErrorWidgetWithRetry extends StatelessWidget {
  /// 错误描述
  final String message;

  /// 重试回调
  final VoidCallback onRetry;

  /// 构造函数
  ///
  /// [message] 错误描述（必填）
  /// [onRetry] 重试回调（必填）
  const ErrorWidgetWithRetry({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return ErrorWidget(
      title: '加载失败',
      message: message,
      onRetry: onRetry,
    );
  }
}
