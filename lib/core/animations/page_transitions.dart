import 'package:flutter/material.dart';

/// 页面过渡动画类型枚举
enum PageTransitionType {
  /// 从右向左滑动
  slideFromRight,

  /// 从左向右滑动
  slideFromLeft,

  /// 从底部向上滑动
  slideFromBottom,

  /// 淡入淡出
  fade,

  /// 缩放
  scale,

  /// 组合动画（缩放 + 淡入）
  scaleAndFade,

  /// 旋转
  rotation,

  /// 大小变化
  size,
}

/// 页面过渡动画配置
class PageTransitionConfig {
  /// 动画类型
  final PageTransitionType type;

  /// 动画时长
  final Duration duration;

  /// 反向动画时长
  final Duration reverseDuration;

  /// 动画曲线
  final Curve curve;

  /// 是否全屏对话框
  final bool fullscreenDialog;

  /// 是否保持状态
  final bool maintainState;

  /// 是否使用透明背景
  final bool opaque;

  /// 构造函数
  const PageTransitionConfig({
    this.type = PageTransitionType.slideFromRight,
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOutCubic,
    this.fullscreenDialog = false,
    this.maintainState = true,
    this.opaque = true,
  });

  /// 默认滑动动画配置
  static const slideRight = PageTransitionConfig(
    type: PageTransitionType.slideFromRight,
  );

  /// 默认淡入动画配置
  static const fade = PageTransitionConfig(
    type: PageTransitionType.fade,
    duration: Duration(milliseconds: 250),
  );

  /// 默认缩放动画配置
  static const scale = PageTransitionConfig(
    type: PageTransitionType.scale,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeOutBack,
  );

  /// 底部弹出配置（用于对话框）
  static const bottomSheet = PageTransitionConfig(
    type: PageTransitionType.slideFromBottom,
    duration: Duration(milliseconds: 350),
    curve: Curves.easeOutCubic,
  );
}

/// 自定义页面过渡动画构建器
class PageTransitionBuilder {
  /// 构建过渡动画
  static Widget build({
    required BuildContext context,
    required Animation<double> animation,
    required Animation<double> secondaryAnimation,
    required Widget child,
    required PageTransitionConfig config,
  }) {
    switch (config.type) {
      case PageTransitionType.slideFromRight:
        return _buildSlideTransition(
          animation: animation,
          child: child,
          beginOffset: const Offset(1.0, 0.0),
          curve: config.curve,
        );
      case PageTransitionType.slideFromLeft:
        return _buildSlideTransition(
          animation: animation,
          child: child,
          beginOffset: const Offset(-1.0, 0.0),
          curve: config.curve,
        );
      case PageTransitionType.slideFromBottom:
        return _buildSlideTransition(
          animation: animation,
          child: child,
          beginOffset: const Offset(0.0, 1.0),
          curve: config.curve,
        );
      case PageTransitionType.fade:
        return _buildFadeTransition(
          animation: animation,
          child: child,
          curve: config.curve,
        );
      case PageTransitionType.scale:
        return _buildScaleTransition(
          animation: animation,
          child: child,
          curve: config.curve,
        );
      case PageTransitionType.scaleAndFade:
        return _buildScaleAndFadeTransition(
          animation: animation,
          child: child,
          curve: config.curve,
        );
      case PageTransitionType.rotation:
        return _buildRotationTransition(
          animation: animation,
          child: child,
          curve: config.curve,
        );
      case PageTransitionType.size:
        return _buildSizeTransition(
          animation: animation,
          child: child,
          curve: config.curve,
        );
    }
  }

  /// 构建滑动过渡动画
  static Widget _buildSlideTransition({
    required Animation<double> animation,
    required Widget child,
    required Offset beginOffset,
    required Curve curve,
  }) {
    final tween = Tween(
      begin: beginOffset,
      end: Offset.zero,
    ).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }

  /// 构建淡入过渡动画
  static Widget _buildFadeTransition({
    required Animation<double> animation,
    required Widget child,
    required Curve curve,
  }) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: curve,
      ),
      child: child,
    );
  }

  /// 构建缩放过渡动画
  static Widget _buildScaleTransition({
    required Animation<double> animation,
    required Widget child,
    required Curve curve,
  }) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.85,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: child,
    );
  }

  /// 构建缩放+淡入组合过渡动画
  static Widget _buildScaleAndFadeTransition({
    required Animation<double> animation,
    required Widget child,
    required Curve curve,
  }) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: curve,
    );

    return FadeTransition(
      opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.9, end: 1.0).animate(curvedAnimation),
        child: child,
      ),
    );
  }

  /// 构建旋转过渡动画
  static Widget _buildRotationTransition({
    required Animation<double> animation,
    required Widget child,
    required Curve curve,
  }) {
    return RotationTransition(
      turns: Tween<double>(
        begin: 0.1,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: curve,
      )),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  /// 构建大小过渡动画
  static Widget _buildSizeTransition({
    required Animation<double> animation,
    required Widget child,
    required Curve curve,
  }) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: curve,
      ),
      child: child,
    );
  }
}

/// Hero 动画标签生成器
class HeroTagGenerator {
  /// 生成图片 Hero 标签
  static String image(String url, {String? prefix}) {
    final baseTag = 'hero_image_${url.hashCode}';
    return prefix != null ? '${prefix}_$baseTag' : baseTag;
  }

  /// 生成头像 Hero 标签
  static String avatar(String username, {String? prefix}) {
    final baseTag = 'hero_avatar_$username';
    return prefix != null ? '${prefix}_$baseTag' : baseTag;
  }

  /// 生成卡片 Hero 标签
  static String card(String id, {String? prefix}) {
    final baseTag = 'hero_card_$id';
    return prefix != null ? '${prefix}_$baseTag' : baseTag;
  }

  /// 生成自定义 Hero 标签
  static String custom(String type, String id, {String? prefix}) {
    final baseTag = 'hero_${type}_$id';
    return prefix != null ? '${prefix}_$baseTag' : baseTag;
  }
}

/// Hero 动画包装器
class HeroWrapper extends StatelessWidget {
  /// Hero 标签
  final String tag;

  /// 子组件
  final Widget child;

  /// 飞行构建器
  final HeroFlightShuttleBuilder? flightShuttleBuilder;

  /// 占位构建器
  final HeroPlaceholderBuilder? placeholderBuilder;

  /// 是否禁用 Hero 动画
  final bool disabled;

  /// 构造函数
  const HeroWrapper({
    super.key,
    required this.tag,
    required this.child,
    this.flightShuttleBuilder,
    this.placeholderBuilder,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    if (disabled) {
      return child;
    }

    return Hero(
      tag: tag,
      flightShuttleBuilder: flightShuttleBuilder,
      placeholderBuilder: placeholderBuilder,
      transitionOnUserGestures: true,
      child: child,
    );
  }
}

/// 带 Hero 动画的图片组件
class HeroImage extends StatelessWidget {
  /// 图片 URL
  final String imageUrl;

  /// Hero 标签前缀
  final String? heroPrefix;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 圆角
  final BorderRadius? borderRadius;

  /// 适应模式
  final BoxFit fit;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  const HeroImage({
    super.key,
    required this.imageUrl,
    this.heroPrefix,
    this.width,
    this.height,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tag = HeroTagGenerator.image(imageUrl, prefix: heroPrefix);

    Widget image = HeroWrapper(
      tag: tag,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Image.network(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
        ),
      ),
    );

    if (onTap != null) {
      image = GestureDetector(
        onTap: onTap,
        child: image,
      );
    }

    return image;
  }
}

/// 带 Hero 动画的头像组件
class HeroAvatar extends StatelessWidget {
  /// 头像 URL
  final String? avatarUrl;

  /// 用户名（用于生成 Hero 标签）
  final String username;

  /// Hero 标签前缀
  final String? heroPrefix;

  /// 半径
  final double radius;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  const HeroAvatar({
    super.key,
    this.avatarUrl,
    required this.username,
    this.heroPrefix,
    this.radius = 20,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tag = HeroTagGenerator.avatar(username, prefix: heroPrefix);

    Widget avatar = HeroWrapper(
      tag: tag,
      child: CircleAvatar(
        radius: radius,
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null
            ? Text(
                username.isNotEmpty ? username[0].toUpperCase() : '?',
                style: TextStyle(fontSize: radius * 0.8),
              )
            : null,
      ),
    );

    if (onTap != null) {
      avatar = GestureDetector(
        onTap: onTap,
        child: avatar,
      );
    }

    return avatar;
  }
}

/// 页面过渡动画扩展方法
extension PageTransitionExtension on BuildContext {
  /// 使用自定义过渡动画导航
  Future<T?> pushWithTransition<T>(
    Widget page, {
    PageTransitionConfig config = PageTransitionConfig.slideRight,
  }) {
    return Navigator.of(this).push<T>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return PageTransitionBuilder.build(
            context: context,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
            config: config,
          );
        },
        transitionDuration: config.duration,
        reverseTransitionDuration: config.reverseDuration,
        fullscreenDialog: config.fullscreenDialog,
        maintainState: config.maintainState,
        opaque: config.opaque,
      ),
    );
  }

  /// 使用自定义过渡动画替换当前页面
  Future<T?> pushReplacementWithTransition<T, TO>(
    Widget page, {
    PageTransitionConfig config = PageTransitionConfig.slideRight,
  }) {
    return Navigator.of(this).pushReplacement<T, TO>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return PageTransitionBuilder.build(
            context: context,
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
            config: config,
          );
        },
        transitionDuration: config.duration,
        reverseTransitionDuration: config.reverseDuration,
        fullscreenDialog: config.fullscreenDialog,
        maintainState: config.maintainState,
        opaque: config.opaque,
      ),
    );
  }
}
