import 'package:flutter/material.dart';

/// 底部导航栏切换动画组件
class AnimatedBottomNavigationBar extends StatefulWidget {
  /// 当前选中索引
  final int currentIndex;

  /// 点击回调
  final ValueChanged<int> onTap;

  /// 导航项列表
  final List<NavigationDestination> destinations;

  /// 背景颜色
  final Color? backgroundColor;

  /// 选中颜色
  final Color? selectedColor;

  /// 未选中颜色
  final Color? unselectedColor;

  /// 是否显示标签
  final bool showLabels;

  /// 是否启用动画
  final bool enableAnimation;

  /// 动画时长
  final Duration animationDuration;

  /// 高度
  final double height;

  /// 构造函数
  const AnimatedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.destinations,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.showLabels = true,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 300),
    this.height = 80,
  });

  @override
  State<AnimatedBottomNavigationBar> createState() => _AnimatedBottomNavigationBarState();
}

class _AnimatedBottomNavigationBarState extends State<AnimatedBottomNavigationBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.destinations.length,
      (index) => AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      ),
    );

    _animations = _controllers.map((controller) {
      return CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutCubic,
      );
    }).toList();

    // 初始化当前选中项的动画
    _controllers[widget.currentIndex].value = 1.0;
  }

  @override
  void didUpdateWidget(AnimatedBottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != oldWidget.currentIndex) {
      // 旧项缩小
      _controllers[oldWidget.currentIndex].reverse();
      // 新项放大
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleTap(int index) {
    if (index == widget.currentIndex) return;
    widget.onTap(index);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = widget.backgroundColor ?? colorScheme.surface;
    final selectedColor = widget.selectedColor ?? colorScheme.primary;
    final unselectedColor = widget.unselectedColor ?? colorScheme.onSurfaceVariant;

    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            widget.destinations.length,
            (index) => _buildNavItem(
              index: index,
              destination: widget.destinations[index],
              isSelected: index == widget.currentIndex,
              selectedColor: selectedColor,
              unselectedColor: unselectedColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required NavigationDestination destination,
    required bool isSelected,
    required Color selectedColor,
    required Color unselectedColor,
  }) {
    final color = isSelected ? selectedColor : unselectedColor;

    return Expanded(
      child: GestureDetector(
        onTap: () => _handleTap(index),
        behavior: HitTestBehavior.opaque,
        child: AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            final scale = widget.enableAnimation
                ? Tween<double>(begin: 1.0, end: 1.1).evaluate(_animations[index])
                : 1.0;
            final opacity = widget.enableAnimation
                ? Tween<double>(begin: 0.7, end: 1.0).evaluate(_animations[index])
                : (isSelected ? 1.0 : 0.7);

            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: opacity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 图标
                    _AnimatedIcon(
                      icon: destination.icon,
                      selectedIcon: destination.selectedIcon,
                      isSelected: isSelected,
                      color: color,
                      enableAnimation: widget.enableAnimation,
                    ),
                    if (widget.showLabels) ...[
                      const SizedBox(height: 4),
                      // 标签
                      AnimatedDefaultTextStyle(
                        duration: widget.animationDuration,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: color,
                        ),
                        child: Text(destination.label),
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// 带动画的图标切换组件
class _AnimatedIcon extends StatelessWidget {
  final Widget icon;
  final Widget? selectedIcon;
  final bool isSelected;
  final Color color;
  final bool enableAnimation;

  const _AnimatedIcon({
    required this.icon,
    this.selectedIcon,
    required this.isSelected,
    required this.color,
    required this.enableAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final displayIcon = isSelected && selectedIcon != null ? selectedIcon! : icon;

    if (!enableAnimation) {
      return IconTheme(
        data: IconThemeData(color: color, size: 24),
        child: displayIcon,
      );
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        return ScaleTransition(
          scale: animation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: IconTheme(
        key: ValueKey<bool>(isSelected),
        data: IconThemeData(color: color, size: 24),
        child: displayIcon,
      ),
    );
  }
}

/// Tab 切换动画组件
class AnimatedTabBar extends StatefulWidget {
  /// Tab 控制器
  final TabController controller;

  /// Tab 列表
  final List<Tab> tabs;

  /// 点击回调
  final ValueChanged<int>? onTap;

  /// 是否可滚动
  final bool isScrollable;

  /// 指示器颜色
  final Color? indicatorColor;

  /// 标签颜色
  final Color? labelColor;

  /// 未选中标签颜色
  final Color? unselectedLabelColor;

  /// 指示器权重
  final double indicatorWeight;

  /// 指示器内边距
  final EdgeInsetsGeometry indicatorPadding;

  /// 标签样式
  final TextStyle? labelStyle;

  /// 未选中标签样式
  final TextStyle? unselectedLabelStyle;

  /// 动画时长
  final Duration animationDuration;

  /// 构造函数
  const AnimatedTabBar({
    super.key,
    required this.controller,
    required this.tabs,
    this.onTap,
    this.isScrollable = false,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedTabBar> createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _indicatorAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.index;
    
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _indicatorAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    widget.controller.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(AnimatedTabBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleTabChange);
      widget.controller.addListener(_handleTabChange);
      _currentIndex = widget.controller.index;
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabChange);
    _animationController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    if (widget.controller.index != _currentIndex) {
      setState(() {
        _currentIndex = widget.controller.index;
      });
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TabBar(
      controller: widget.controller,
      tabs: widget.tabs,
      isScrollable: widget.isScrollable,
      indicatorColor: widget.indicatorColor ?? colorScheme.primary,
      labelColor: widget.labelColor ?? colorScheme.primary,
      unselectedLabelColor: widget.unselectedLabelColor ?? colorScheme.onSurfaceVariant,
      indicatorWeight: widget.indicatorWeight,
      indicatorPadding: widget.indicatorPadding,
      labelStyle: widget.labelStyle,
      unselectedLabelStyle: widget.unselectedLabelStyle,
      onTap: widget.onTap,
      indicator: _AnimatedTabIndicator(
        animation: _indicatorAnimation,
        color: widget.indicatorColor ?? colorScheme.primary,
        weight: widget.indicatorWeight,
      ),
    );
  }
}

/// 带动画的 Tab 指示器
class _AnimatedTabIndicator extends Decoration {
  final Animation<double> animation;
  final Color color;
  final double weight;

  const _AnimatedTabIndicator({
    required this.animation,
    required this.color,
    required this.weight,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _AnimatedTabIndicatorPainter(
      animation: animation,
      color: color,
      weight: weight,
      onChanged: onChanged,
    );
  }
}

class _AnimatedTabIndicatorPainter extends BoxPainter {
  final Animation<double> animation;
  final Color color;
  final double weight;

  _AnimatedTabIndicatorPainter({
    required this.animation,
    required this.color,
    required this.weight,
    VoidCallback? onChanged,
  }) : super(onChanged) {
    animation.addListener(_onAnimationChanged);
  }

  void _onAnimationChanged() {
    // 通知需要重绘
  }

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final rect = offset & configuration.size!;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // 使用弹性效果的指示器
    final progress = Curves.elasticOut.transform(animation.value);
    final width = rect.width * (0.5 + 0.5 * progress);
    final centerX = rect.center.dx;
    final left = centerX - width / 2;
    final right = centerX + width / 2;

    final indicatorRect = Rect.fromLTRB(
      left,
      rect.bottom - weight,
      right,
      rect.bottom,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(indicatorRect, const Radius.circular(1)),
      paint,
    );
  }

  @override
  void dispose() {
    animation.removeListener(_onAnimationChanged);
    super.dispose();
  }
}

/// Tab 内容切换动画包装器
class AnimatedTabView extends StatefulWidget {
  /// Tab 控制器
  final TabController controller;

  /// 子页面列表
  final List<Widget> children;

  /// 动画类型
  final TabAnimationType animationType;

  /// 动画时长
  final Duration animationDuration;

  /// 构造函数
  const AnimatedTabView({
    super.key,
    required this.controller,
    required this.children,
    this.animationType = TabAnimationType.slide,
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  State<AnimatedTabView> createState() => _AnimatedTabViewState();
}

/// Tab 动画类型
enum TabAnimationType {
  /// 滑动
  slide,

  /// 淡入淡出
  fade,

  /// 缩放
  scale,

  /// 无动画
  none,
}

class _AnimatedTabViewState extends State<AnimatedTabView>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.controller.index;
    
    _controllers = List.generate(
      widget.children.length,
      (index) => AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      ),
    );

    // 初始化当前页面的动画
    _controllers[_currentIndex].value = 1.0;

    widget.controller.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(AnimatedTabView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller.removeListener(_handleTabChange);
      widget.controller.addListener(_handleTabChange);
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_handleTabChange);
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _handleTabChange() {
    final newIndex = widget.controller.index;
    if (newIndex != _currentIndex) {
      // 旧页面退出
      _controllers[_currentIndex].reverse();
      // 新页面进入
      _controllers[newIndex].forward();
      
      setState(() {
        _currentIndex = newIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationType == TabAnimationType.none) {
      return IndexedStack(
        index: _currentIndex,
        children: widget.children,
      );
    }

    return AnimatedBuilder(
      animation: Listenable.merge(_controllers),
      builder: (context, child) {
        return Stack(
          children: List.generate(
            widget.children.length,
            (index) => _buildAnimatedPage(index),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedPage(int index) {
    final isCurrent = index == _currentIndex;
    final animation = _controllers[index];

    if (!isCurrent && animation.value == 0) {
      return const SizedBox.shrink();
    }

    Widget child;

    switch (widget.animationType) {
      case TabAnimationType.slide:
        child = _buildSlideTransition(index, animation);
        break;
      case TabAnimationType.fade:
        child = _buildFadeTransition(animation);
        break;
      case TabAnimationType.scale:
        child = _buildScaleTransition(animation);
        break;
      case TabAnimationType.none:
        child = widget.children[index];
        break;
    }

    return IgnorePointer(
      ignoring: !isCurrent,
      child: child,
    );
  }

  Widget _buildSlideTransition(int index, Animation<double> animation) {
    final isMovingRight = index > _currentIndex;
    final beginOffset = isMovingRight ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0);

    return SlideTransition(
      position: Tween<Offset>(
        begin: beginOffset,
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      )),
      child: FadeTransition(
        opacity: animation,
        child: widget.children[index],
      ),
    );
  }

  Widget _buildFadeTransition(Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: widget.children[_currentIndex],
    );
  }

  Widget _buildScaleTransition(Animation<double> animation) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.95, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        ),
      ),
      child: FadeTransition(
        opacity: animation,
        child: widget.children[_currentIndex],
      ),
    );
  }
}

/// 页面切换过渡动画
class PageSwitchAnimation extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 是否选中
  final bool isSelected;

  /// 动画类型
  final TabAnimationType animationType;

  /// 动画时长
  final Duration duration;

  /// 构造函数
  const PageSwitchAnimation({
    super.key,
    required this.child,
    required this.isSelected,
    this.animationType = TabAnimationType.fade,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      transitionBuilder: (child, animation) {
        switch (animationType) {
          case TabAnimationType.slide:
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          case TabAnimationType.fade:
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          case TabAnimationType.scale:
            return ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          case TabAnimationType.none:
            return child;
        }
      },
      child: isSelected ? child : const SizedBox.shrink(),
    );
  }
}
