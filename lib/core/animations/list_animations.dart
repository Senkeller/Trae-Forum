import 'package:flutter/material.dart';

/// 列表项入场动画类型
enum ListItemAnimationType {
  /// 从底部滑入
  slideFromBottom,

  /// 从左侧滑入
  slideFromLeft,

  /// 从右侧滑入
  slideFromRight,

  /// 淡入
  fade,

  /// 缩放
  scale,

  /// 组合动画（缩放 + 淡入）
  scaleAndFade,

  /// 翻转
  flip,
}

/// 列表项动画配置
class ListItemAnimationConfig {
  /// 动画类型
  final ListItemAnimationType type;

  /// 动画时长
  final Duration duration;

  /// 延迟基础时长（用于交错动画）
  final Duration delayBase;

  /// 动画曲线
  final Curve curve;

  /// 是否启用交错动画
  final bool staggered;

  /// 交错延迟（每个项目之间的延迟）
  final Duration staggerDelay;

  /// 构造函数
  const ListItemAnimationConfig({
    this.type = ListItemAnimationType.slideFromBottom,
    this.duration = const Duration(milliseconds: 400),
    this.delayBase = Duration.zero,
    this.curve = Curves.easeOutCubic,
    this.staggered = true,
    this.staggerDelay = const Duration(milliseconds: 50),
  });

  /// 默认配置
  static const default_ = ListItemAnimationConfig();

  /// 快速配置
  static const fast = ListItemAnimationConfig(
    duration: Duration(milliseconds: 250),
    staggerDelay: Duration(milliseconds: 30),
  );

  /// 慢速配置
  static const slow = ListItemAnimationConfig(
    duration: Duration(milliseconds: 600),
    staggerDelay: Duration(milliseconds: 80),
  );
}

/// 带动画的列表项包装器
class AnimatedListItem extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 索引（用于计算延迟）
  final int index;

  /// 动画配置
  final ListItemAnimationConfig config;

  /// 构造函数
  const AnimatedListItem({
    super.key,
    required this.child,
    required this.index,
    this.config = ListItemAnimationConfig.default_,
  });

  @override
  Widget build(BuildContext context) {
    final delay = config.staggered
        ? config.delayBase + (config.staggerDelay * index)
        : config.delayBase;

    return _AnimatedListItemWrapper(
      delay: delay,
      duration: config.duration,
      curve: config.curve,
      type: config.type,
      child: child,
    );
  }
}

/// 动画列表项包装器（内部实现）
class _AnimatedListItemWrapper extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final ListItemAnimationType type;

  const _AnimatedListItemWrapper({
    required this.child,
    required this.delay,
    required this.duration,
    required this.curve,
    required this.type,
  });

  @override
  State<_AnimatedListItemWrapper> createState() => _AnimatedListItemWrapperState();
}

class _AnimatedListItemWrapperState extends State<_AnimatedListItemWrapper>
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
      curve: widget.curve,
    );

    // 延迟启动动画
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
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
    switch (widget.type) {
      case ListItemAnimationType.slideFromBottom:
        return _buildSlideFromBottom();
      case ListItemAnimationType.slideFromLeft:
        return _buildSlideFromLeft();
      case ListItemAnimationType.slideFromRight:
        return _buildSlideFromRight();
      case ListItemAnimationType.fade:
        return _buildFade();
      case ListItemAnimationType.scale:
        return _buildScale();
      case ListItemAnimationType.scaleAndFade:
        return _buildScaleAndFade();
      case ListItemAnimationType.flip:
        return _buildFlip();
    }
  }

  Widget _buildSlideFromBottom() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final offset = Tween<Offset>(
          begin: const Offset(0, 0.3),
          end: Offset.zero,
        ).evaluate(_animation);

        return Opacity(
          opacity: _animation.value,
          child: Transform.translate(
            offset: Offset(0, offset.dy * 50),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  Widget _buildSlideFromLeft() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.3, 0),
            end: Offset.zero,
          ).animate(_animation),
          child: FadeTransition(
            opacity: _animation,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  Widget _buildSlideFromRight() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.3, 0),
            end: Offset.zero,
          ).animate(_animation),
          child: FadeTransition(
            opacity: _animation,
            child: child,
          ),
        );
      },
      child: widget.child,
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

  Widget _buildScaleAndFade() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: Tween<double>(begin: 0.9, end: 1.0).evaluate(_animation),
          child: Opacity(
            opacity: Tween<double>(begin: 0.0, end: 1.0).evaluate(_animation),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }

  Widget _buildFlip() {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final angle = Tween<double>(begin: 0.5, end: 0.0).evaluate(_animation);
        return Transform(
          transform: Matrix4.rotationX(angle * 3.14159),
          alignment: Alignment.center,
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}

/// 带动画的分隔线列表
class AnimatedListView extends StatelessWidget {
  /// 列表项构建器
  final IndexedWidgetBuilder itemBuilder;

  /// 分隔线构建器
  final IndexedWidgetBuilder? separatorBuilder;

  /// 项目数量
  final int itemCount;

  /// 动画配置
  final ListItemAnimationConfig animationConfig;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 是否可滚动
  final bool shrinkWrap;

  /// 物理效果
  final ScrollPhysics? physics;

  /// 控制器
  final ScrollController? controller;

  /// 构造函数
  const AnimatedListView({
    super.key,
    required this.itemBuilder,
    this.separatorBuilder,
    required this.itemCount,
    this.animationConfig = ListItemAnimationConfig.default_,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: controller,
      physics: physics,
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: separatorBuilder ?? (_, __) => const SizedBox.shrink(),
      itemBuilder: (context, index) {
        return AnimatedListItem(
          index: index,
          config: animationConfig,
          child: itemBuilder(context, index),
        );
      },
    );
  }
}

/// 带动画的 Sliver 列表
class AnimatedSliverList extends StatelessWidget {
  /// 列表项构建器
  final IndexedWidgetBuilder itemBuilder;

  /// 项目数量
  final int itemCount;

  /// 动画配置
  final ListItemAnimationConfig animationConfig;

  /// 构造函数
  const AnimatedSliverList({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.animationConfig = ListItemAnimationConfig.default_,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return AnimatedListItem(
            index: index,
            config: animationConfig,
            child: itemBuilder(context, index),
          );
        },
        childCount: itemCount,
      ),
    );
  }
}

/// 刷新指示器包装器（带动画）
class AnimatedRefreshIndicator extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 刷新回调
  final RefreshCallback onRefresh;

  /// 指示器颜色
  final Color? color;

  /// 背景颜色
  final Color? backgroundColor;

  /// 位移阈值
  final double displacement;

  /// 构造函数
  const AnimatedRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
    this.color,
    this.backgroundColor,
    this.displacement = 40.0,
  });

  @override
  State<AnimatedRefreshIndicator> createState() => _AnimatedRefreshIndicatorState();
}

class _AnimatedRefreshIndicatorState extends State<AnimatedRefreshIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    _controller.repeat();
    await widget.onRefresh();
    _controller.stop();
    _controller.reset();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: widget.color ?? colorScheme.primary,
      backgroundColor: widget.backgroundColor ?? colorScheme.surface,
      displacement: widget.displacement,
      child: widget.child,
    );
  }
}

/// 加载更多指示器（带动画）
class AnimatedLoadMoreIndicator extends StatefulWidget {
  /// 是否正在加载
  final bool isLoading;

  /// 是否还有更多数据
  final bool hasMore;

  /// 加载回调
  final VoidCallback? onLoadMore;

  /// 指示器高度
  final double height;

  /// 构造函数
  const AnimatedLoadMoreIndicator({
    super.key,
    required this.isLoading,
    required this.hasMore,
    this.onLoadMore,
    this.height = 60,
  });

  @override
  State<AnimatedLoadMoreIndicator> createState() => _AnimatedLoadMoreIndicatorState();
}

class _AnimatedLoadMoreIndicatorState extends State<AnimatedLoadMoreIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    if (widget.isLoading) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(AnimatedLoadMoreIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading) {
      if (widget.isLoading) {
        _controller.repeat();
      } else {
        _controller.stop();
        _controller.reset();
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    if (!widget.hasMore) {
      return Container(
        height: widget.height,
        alignment: Alignment.center,
        child: Text(
          '已经到底了',
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onLoadMore,
      child: Container(
        height: widget.height,
        alignment: Alignment.center,
        child: widget.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '加载中...',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.expand_more,
                    size: 20,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '点击加载更多',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// 空状态过渡动画包装器
class AnimatedEmptyWidget extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 是否显示
  final bool isVisible;

  /// 动画时长
  final Duration duration;

  /// 构造函数
  const AnimatedEmptyWidget({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<AnimatedEmptyWidget> createState() => _AnimatedEmptyWidgetState();
}

class _AnimatedEmptyWidgetState extends State<AnimatedEmptyWidget>
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
      curve: Curves.easeOutCubic,
    );

    if (widget.isVisible) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(AnimatedEmptyWidget oldWidget) {
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
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Transform.scale(
            scale: Tween<double>(begin: 0.9, end: 1.0).evaluate(_animation),
            child: child,
          ),
        );
      },
      child: widget.isVisible ? widget.child : const SizedBox.shrink(),
    );
  }
}
