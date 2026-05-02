import 'package:flutter/material.dart';

/// SnackBar 动画类型
enum SnackBarAnimationType {
  /// 从底部滑入
  slideFromBottom,

  /// 从顶部滑入
  slideFromTop,

  /// 淡入
  fade,

  /// 缩放
  scale,

  /// 弹性
  bounce,
}

/// 带动画的 SnackBar
class AnimatedSnackBar {
  /// 显示成功 SnackBar
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarAnimationType animationType = SnackBarAnimationType.slideFromBottom,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.check_circle_outline,
      backgroundColor: Colors.green.shade700,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      animationType: animationType,
    );
  }

  /// 显示错误 SnackBar
  static void showError(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 4),
    SnackBarAnimationType animationType = SnackBarAnimationType.slideFromBottom,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.error_outline,
      backgroundColor: Colors.red.shade700,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      animationType: animationType,
    );
  }

  /// 显示警告 SnackBar
  static void showWarning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarAnimationType animationType = SnackBarAnimationType.slideFromBottom,
  }) {
    _show(
      context,
      message: message,
      icon: Icons.warning_amber_outlined,
      backgroundColor: Colors.orange.shade700,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      animationType: animationType,
    );
  }

  /// 显示信息 SnackBar
  static void showInfo(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration duration = const Duration(seconds: 3),
    SnackBarAnimationType animationType = SnackBarAnimationType.slideFromBottom,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    _show(
      context,
      message: message,
      icon: Icons.info_outline,
      backgroundColor: colorScheme.primaryContainer,
      textColor: colorScheme.onPrimaryContainer,
      actionLabel: actionLabel,
      onAction: onAction,
      duration: duration,
      animationType: animationType,
    );
  }

  /// 显示自定义 SnackBar
  static void _show(
    BuildContext context, {
    required String message,
    required IconData icon,
    required Color backgroundColor,
    Color? textColor,
    String? actionLabel,
    VoidCallback? onAction,
    required Duration duration,
    required SnackBarAnimationType animationType,
  }) {
    final defaultTextColor = textColor ?? Colors.white;

    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            icon,
            color: defaultTextColor,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: defaultTextColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: defaultTextColor,
              onPressed: onAction ?? () {},
            )
          : null,
    );

    final scaffoldMessenger = ScaffoldMessenger.of(context);

    // 先隐藏当前的 SnackBar
    scaffoldMessenger.hideCurrentSnackBar();

    // 显示新的 SnackBar
    scaffoldMessenger.showSnackBar(snackBar);
  }
}



/// 自定义 SnackBar 动画组件
class AnimatedSnackBarContent extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 动画类型
  final SnackBarAnimationType animationType;

  /// 动画时长
  final Duration duration;

  /// 是否显示
  final bool isVisible;

  /// 构造函数
  const AnimatedSnackBarContent({
    super.key,
    required this.child,
    this.animationType = SnackBarAnimationType.slideFromBottom,
    this.duration = const Duration(milliseconds: 300),
    this.isVisible = true,
  });

  @override
  State<AnimatedSnackBarContent> createState() => _AnimatedSnackBarContentState();
}

class _AnimatedSnackBarContentState extends State<AnimatedSnackBarContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: _getCurve(),
    );

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedSnackBarContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Curve _getCurve() {
    switch (widget.animationType) {
      case SnackBarAnimationType.bounce:
        return Curves.elasticOut;
      case SnackBarAnimationType.scale:
        return Curves.easeOutBack;
      default:
        return Curves.easeOutCubic;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        switch (widget.animationType) {
          case SnackBarAnimationType.slideFromBottom:
            return _buildSlideFromBottom();
          case SnackBarAnimationType.slideFromTop:
            return _buildSlideFromTop();
          case SnackBarAnimationType.fade:
            return _buildFade();
          case SnackBarAnimationType.scale:
            return _buildScale();
          case SnackBarAnimationType.bounce:
            return _buildBounce();
        }
      },
      child: widget.child,
    );
  }

  Widget _buildSlideFromBottom() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(_animation),
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }

  Widget _buildSlideFromTop() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, -1),
        end: Offset.zero,
      ).animate(_animation),
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }

  Widget _buildFade() {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }

  Widget _buildScale() {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(_animation),
      child: FadeTransition(
        opacity: _animation,
        child: widget.child,
      ),
    );
  }

  Widget _buildBounce() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(_animation),
      child: widget.child,
    );
  }
}

/// Toast 提示组件（轻量级 SnackBar）
class AnimatedToast {
  /// 显示 Toast
  static void show(
    BuildContext context, {
    required String message,
    IconData? icon,
    Duration duration = const Duration(seconds: 2),
    SnackBarAnimationType animationType = SnackBarAnimationType.fade,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        icon: icon,
        duration: duration,
        animationType: animationType,
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration + const Duration(milliseconds: 300), () {
      overlayEntry.remove();
    });
  }
}

/// Toast 组件
class _ToastWidget extends StatefulWidget {
  final String message;
  final IconData? icon;
  final Duration duration;
  final SnackBarAnimationType animationType;

  const _ToastWidget({
    required this.message,
    this.icon,
    required this.duration,
    required this.animationType,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );

    _controller.forward();

    Future.delayed(widget.duration, () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16,
      left: 0,
      right: 0,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Opacity(
            opacity: _animation.value,
            child: Transform.translate(
              offset: Offset(0, -20 * (1 - _animation.value)),
              child: child,
            ),
          );
        },
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: colorScheme.inverseSurface.withOpacity(0.9),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    color: colorScheme.onInverseSurface,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  widget.message,
                  style: TextStyle(
                    color: colorScheme.onInverseSurface,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 浮动操作按钮动画包装器
class AnimatedFloatingActionButton extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 是否可见
  final bool isVisible;

  /// 动画时长
   final Duration duration;

  /// 构造函数
  const AnimatedFloatingActionButton({
    super.key,
    required this.child,
    this.isVisible = true,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedFloatingActionButton> createState() => _AnimatedFloatingActionButtonState();
}

class _AnimatedFloatingActionButtonState extends State<AnimatedFloatingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.5,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedFloatingActionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: Tween<double>(begin: 0.0, end: 1.0).evaluate(_scaleAnimation),
          child: Transform.rotate(
            angle: _rotationAnimation.value * 3.14159,
            child: Opacity(
              opacity: _scaleAnimation.value,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
