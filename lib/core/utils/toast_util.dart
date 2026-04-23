import 'package:flutter/material.dart';
import '../../config/theme.dart';

/// Toast 工具类
/// 提供成功、错误、加载等提示的显示功能
class ToastUtil {
  ToastUtil._();

  static OverlayEntry? _currentToast;
  static OverlayEntry? _loadingToast;

  /// 显示成功提示
  /// [context] BuildContext
  /// [message] 提示消息
  /// [duration] 显示时长，默认为 2 秒
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _showToast(
      context,
      message: message,
      icon: Icons.check_circle,
      backgroundColor: AppTheme.successColor,
      duration: duration,
    );
  }

  /// 显示错误提示
  /// [context] BuildContext
  /// [message] 提示消息
  /// [duration] 显示时长，默认为 2 秒
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _showToast(
      context,
      message: message,
      icon: Icons.error,
      backgroundColor: AppTheme.errorColor,
      duration: duration,
    );
  }

  /// 显示警告提示
  /// [context] BuildContext
  /// [message] 提示消息
  /// [duration] 显示时长，默认为 2 秒
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _showToast(
      context,
      message: message,
      icon: Icons.warning,
      backgroundColor: AppTheme.warningColor,
      duration: duration,
    );
  }

  /// 显示信息提示
  /// [context] BuildContext
  /// [message] 提示消息
  /// [duration] 显示时长，默认为 2 秒
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _showToast(
      context,
      message: message,
      icon: Icons.info,
      backgroundColor: AppTheme.infoColor,
      duration: duration,
    );
  }

  /// 显示纯文本提示
  /// [context] BuildContext
  /// [message] 提示消息
  /// [duration] 显示时长，默认为 2 秒
  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
  }) {
    _showToast(
      context,
      message: message,
      backgroundColor: Colors.black87,
      duration: duration,
    );
  }

  /// 显示加载提示
  /// [context] BuildContext
  /// [message] 提示消息，默认为 '加载中...'
  /// 返回用于关闭加载提示的函数
  static VoidCallback showLoading(
    BuildContext context, {
    String message = '加载中...',
  }) {
    _hideLoading();

    final overlay = Overlay.of(context);
    _loadingToast = OverlayEntry(
      builder: (context) => _LoadingToastWidget(message: message),
    );
    overlay.insert(_loadingToast!);

    return _hideLoading;
  }

  /// 隐藏加载提示
  static void _hideLoading() {
    _loadingToast?.remove();
    _loadingToast = null;
  }

  /// 显示通用 Toast
  /// [context] BuildContext
  /// [message] 提示消息
  /// [icon] 图标，可选
  /// [backgroundColor] 背景颜色
  /// [duration] 显示时长
  static void _showToast(
    BuildContext context, {
    required String message,
    IconData? icon,
    required Color backgroundColor,
    required Duration duration,
  }) {
    _hideCurrentToast();

    final overlay = Overlay.of(context);
    _currentToast = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        icon: icon,
        backgroundColor: backgroundColor,
      ),
    );
    overlay.insert(_currentToast!);

    Future.delayed(duration, _hideCurrentToast);
  }

  /// 隐藏当前 Toast
  static void _hideCurrentToast() {
    _currentToast?.remove();
    _currentToast = null;
  }
}

/// Toast 组件
class _ToastWidget extends StatelessWidget {
  /// 提示消息
  final String message;

  /// 图标
  final IconData? icon;

  /// 背景颜色
  final Color backgroundColor;

  const _ToastWidget({
    required this.message,
    this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 40),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            color: backgroundColor.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
              ],
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 加载 Toast 组件
class _LoadingToastWidget extends StatelessWidget {
  /// 提示消息
  final String message;

  const _LoadingToastWidget({required this.message});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 36,
                height: 36,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Toast 扩展
extension ToastExtension on BuildContext {
  /// 显示成功提示
  /// [message] 提示消息
  /// [duration] 显示时长
  void showSuccess(String message, {Duration? duration}) {
    ToastUtil.showSuccess(
      this,
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// 显示错误提示
  /// [message] 提示消息
  /// [duration] 显示时长
  void showError(String message, {Duration? duration}) {
    ToastUtil.showError(
      this,
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// 显示警告提示
  /// [message] 提示消息
  /// [duration] 显示时长
  void showWarning(String message, {Duration? duration}) {
    ToastUtil.showWarning(
      this,
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// 显示信息提示
  /// [message] 提示消息
  /// [duration] 显示时长
  void showInfo(String message, {Duration? duration}) {
    ToastUtil.showInfo(
      this,
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// 显示纯文本提示
  /// [message] 提示消息
  /// [duration] 显示时长
  void showToast(String message, {Duration? duration}) {
    ToastUtil.show(
      this,
      message,
      duration: duration ?? const Duration(seconds: 2),
    );
  }

  /// 显示加载提示
  /// [message] 提示消息
  /// 返回用于关闭加载提示的函数
  VoidCallback showLoading({String message = '加载中...'}) {
    return ToastUtil.showLoading(this, message: message);
  }
}
