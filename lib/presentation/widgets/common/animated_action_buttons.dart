import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/theme.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/like_provider.dart';
import '../../providers/bookmark_provider.dart';

/// 动画点赞按钮
///
/// 增强版点赞按钮，带有粒子爆炸动画和弹性缩放效果
class AnimatedLikeButton extends ConsumerStatefulWidget {
  /// 帖子ID
  final int postId;

  /// 初始点赞数
  final int initialLikeCount;

  /// 初始是否已点赞
  final bool initialIsLiked;

  /// 操作摘要列表（用于初始化状态）
  final List<dynamic>? actionsSummary;

  /// 图标大小
  final double iconSize;

  /// 文字大小
  final double? fontSize;

  /// 是否显示数字
  final bool showCount;

  /// 点击回调
  final VoidCallback? onLike;

  /// 取消点赞回调
  final VoidCallback? onUnlike;

  /// 错误回调
  final Function(String error)? onError;

  /// 构造函数
  const AnimatedLikeButton({
    super.key,
    required this.postId,
    this.initialLikeCount = 0,
    this.initialIsLiked = false,
    this.actionsSummary,
    this.iconSize = 20,
    this.fontSize,
    this.showCount = true,
    this.onLike,
    this.onUnlike,
    this.onError,
  });

  @override
  ConsumerState<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends ConsumerState<AnimatedLikeButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _particleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();

    // 缩放动画控制器 - 弹性效果
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.8),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.8, end: 1.4).chain(CurveTween(curve: Curves.easeOutCubic)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.4, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 50,
      ),
    ]).animate(_scaleController);

    // 粒子动画控制器
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _particleAnimation = CurvedAnimation(
      parent: _particleController,
      curve: Curves.easeOutCubic,
    );

    // 初始化点赞状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(likeProvider.notifier);
      if (widget.actionsSummary != null) {
        notifier.initializeFromActionsSummary(
          widget.postId,
          widget.actionsSummary,
        );
      } else {
        notifier.initializePost(
          widget.postId,
          likeCount: widget.initialLikeCount,
          isLiked: widget.initialIsLiked,
        );
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    final notifier = ref.read(likeProvider.notifier);
    final state = ref.read(postLikeStateProvider(widget.postId));

    if (state == null || state.isLoading) return;

    final wasLiked = state.isLiked;
    
    // 触发触觉反馈
    await HapticFeedbackUtil.trigger(
      ref,
      wasLiked ? HapticScene.unlike : HapticScene.like,
    );

    // 执行动画
    if (!wasLiked) {
      // 点赞时播放粒子动画
      _scaleController.forward(from: 0);
      _particleController.forward(from: 0);
    } else {
      // 取消点赞时播放简单缩放动画
      _scaleController.forward(from: 0);
    }

    // 执行点赞/取消点赞操作
    await notifier.toggleLike(widget.postId);

    // 检查操作结果
    final newState = ref.read(postLikeStateProvider(widget.postId));
    if (newState?.errorMessage != null) {
      if (widget.onError != null) {
        widget.onError!(newState!.errorMessage!);
      } else {
        _showErrorSnackBar(newState!.errorMessage!);
      }
    } else {
      if (newState?.isLiked == true && widget.onLike != null) {
        widget.onLike!();
      } else if (newState?.isLiked == false && widget.onUnlike != null) {
        widget.onUnlike!();
      }
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer(
      builder: (context, ref, child) {
        final likeState = ref.watch(postLikeStateProvider(widget.postId));

        final isLiked = likeState?.isLiked ?? widget.initialIsLiked;
        final likeCount = likeState?.likeCount ?? widget.initialLikeCount;
        final isLoading = likeState?.isLoading ?? false;

        final iconColor = isLiked
            ? AppTheme.likeColor
            : colorScheme.onSurfaceVariant;
        final textColor = isLiked
            ? AppTheme.likeColor
            : colorScheme.onSurfaceVariant;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : _handleTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _scaleAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // 粒子效果
                            if (isLiked)
                              AnimatedBuilder(
                                animation: _particleAnimation,
                                builder: (context, child) {
                                  return _ParticleEffect(
                                    animation: _particleAnimation,
                                    color: AppTheme.likeColor,
                                  );
                                },
                              ),
                            // 图标
                            isLoading
                                ? SizedBox(
                                    width: widget.iconSize,
                                    height: widget.iconSize,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        iconColor,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    isLiked
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: widget.iconSize,
                                    color: iconColor,
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (widget.showCount) ...[
                    const SizedBox(width: 4),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: Text(
                        _formatCount(likeCount),
                        key: ValueKey<int>(likeCount),
                        style: textTheme.bodySmall?.copyWith(
                          color: textColor,
                          fontSize: widget.fontSize,
                          fontWeight: isLiked
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

/// 粒子效果组件
class _ParticleEffect extends StatelessWidget {
  final Animation<double> animation;
  final Color color;

  const _ParticleEffect({
    required this.animation,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(60, 60),
      painter: _ParticlePainter(
        animation: animation,
        color: color,
      ),
    );
  }
}

/// 粒子绘制器
class _ParticlePainter extends CustomPainter {
  final Animation<double> animation;
  final Color color;

  _ParticlePainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final particleCount = 8;
    
    for (int i = 0; i < particleCount; i++) {
      final angle = (i * 2 * 3.14159) / particleCount;
      final distance = 15 + (animation.value * 20);
      final particleSize = 3 * (1 - animation.value);
      
      if (particleSize > 0) {
        final offset = Offset(
          center.dx + math.cos(angle) * distance,
          center.dy + math.sin(angle) * distance,
        );
        
        final paint = Paint()
          ..color = color.withOpacity(1 - animation.value)
          ..style = PaintingStyle.fill;
        
        canvas.drawCircle(offset, particleSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

/// 动画收藏按钮
///
/// 带旋转和缩放效果的收藏按钮
class AnimatedBookmarkButton extends ConsumerStatefulWidget {
  /// 话题ID
  final int topicId;

  /// 初始收藏状态
  final bool initialIsBookmarked;

  /// 图标大小
  final double iconSize;

  /// 是否显示标签
  final bool showLabel;

  /// 点击回调
  final VoidCallback? onBookmark;

  /// 取消收藏回调
  final VoidCallback? onUnbookmark;

  /// 构造函数
  const AnimatedBookmarkButton({
    super.key,
    required this.topicId,
    this.initialIsBookmarked = false,
    this.iconSize = 20,
    this.showLabel = true,
    this.onBookmark,
    this.onUnbookmark,
  });

  @override
  ConsumerState<AnimatedBookmarkButton> createState() => _AnimatedBookmarkButtonState();
}

class _AnimatedBookmarkButtonState extends ConsumerState<AnimatedBookmarkButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.7),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.7, end: 1.2).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 30,
      ),
    ]).animate(_controller);

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    // 初始化状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(bookmarkProvider.notifier).initializePost(
        widget.topicId,
        isBookmarked: widget.initialIsBookmarked,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    final notifier = ref.read(bookmarkProvider.notifier);
    final state = ref.read(postBookmarkStateProvider(widget.topicId));

    if (state?.isLoading == true) return;

    final wasBookmarked = state?.isBookmarked ?? widget.initialIsBookmarked;
    
    await HapticFeedbackUtil.trigger(
      ref,
      wasBookmarked ? HapticScene.unlike : HapticScene.like,
    );

    _controller.forward(from: 0);
    await notifier.toggleBookmark(widget.topicId);

    final newState = ref.read(postBookmarkStateProvider(widget.topicId));
    if (newState?.isBookmarked == true && widget.onBookmark != null) {
      widget.onBookmark!();
    } else if (newState?.isBookmarked == false && widget.onUnbookmark != null) {
      widget.onUnbookmark!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Consumer(
      builder: (context, ref, child) {
        final bookmarkState = ref.watch(postBookmarkStateProvider(widget.topicId));
        final isBookmarked = bookmarkState?.isBookmarked ?? widget.initialIsBookmarked;
        final isLoading = bookmarkState?.isLoading ?? false;

        final iconColor = isBookmarked
            ? AppTheme.favoriteColor
            : colorScheme.onSurfaceVariant;
        final textColor = isBookmarked
            ? AppTheme.favoriteColor
            : colorScheme.onSurfaceVariant;

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isLoading ? null : _handleTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Transform.rotate(
                          angle: _rotationAnimation.value * 3.14159,
                          child: isLoading
                              ? SizedBox(
                                  width: widget.iconSize,
                                  height: widget.iconSize,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      iconColor,
                                    ),
                                  ),
                                )
                              : Icon(
                                  isBookmarked
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: widget.iconSize,
                                  color: iconColor,
                                ),
                        ),
                      );
                    },
                  ),
                  if (widget.showLabel) ...[
                    const SizedBox(width: 4),
                    Text(
                      isBookmarked ? '已收藏' : '收藏',
                      style: textTheme.bodySmall?.copyWith(
                        color: textColor,
                        fontWeight: isBookmarked
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/// 动画分享按钮
///
/// 带扩散波纹效果的分享按钮
class AnimatedShareButton extends StatefulWidget {
  /// 图标大小
  final double iconSize;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  const AnimatedShareButton({
    super.key,
    this.iconSize = 20,
    this.onTap,
  });

  @override
  State<AnimatedShareButton> createState() => _AnimatedShareButtonState();
}

class _AnimatedShareButtonState extends State<AnimatedShareButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rippleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _rippleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _handleTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // 波纹效果
                  ...List.generate(3, (index) {
                    final delay = index * 0.2;
                    final adjustedValue = math.max(
                      0.0,
                      math.min(1.0, (_rippleAnimation.value - delay) / (1 - delay)),
                    );
                    
                    return Container(
                      width: widget.iconSize * (1 + adjustedValue * 2),
                      height: widget.iconSize * (1 + adjustedValue * 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(
                            (1 - adjustedValue) * 0.5,
                          ),
                          width: 1,
                        ),
                      ),
                    );
                  }),
                  // 图标
                  Icon(
                    Icons.share,
                    size: widget.iconSize,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// 动画关注按钮
///
/// 带背景填充动画的关注按钮
class AnimatedFollowButton extends StatefulWidget {
  /// 当前关注状态
  final bool isFollowing;

  /// 是否正在加载
  final bool isLoading;

  /// 点击回调
  final VoidCallback? onTap;

  /// 按钮高度
  final double height;

  /// 是否为小尺寸
  final bool isSmall;

  /// 构造函数
  const AnimatedFollowButton({
    super.key,
    required this.isFollowing,
    this.isLoading = false,
    this.onTap,
    this.height = 36,
    this.isSmall = false,
  });

  @override
  State<AnimatedFollowButton> createState() => _AnimatedFollowButtonState();
}

class _AnimatedFollowButtonState extends State<AnimatedFollowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fillAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fillAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    
    if (widget.isFollowing) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedFollowButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFollowing != oldWidget.isFollowing) {
      if (widget.isFollowing) {
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: widget.isLoading ? null : widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: widget.isSmall ? 64 : 80,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.height / 2),
          border: Border.all(
            color: widget.isFollowing
                ? colorScheme.outline
                : colorScheme.primary,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.height / 2),
          child: Stack(
            children: [
              // 填充动画
              AnimatedBuilder(
                animation: _fillAnimation,
                builder: (context, child) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: 1 - _fillAnimation.value,
                      child: Container(
                        color: colorScheme.primary,
                      ),
                    ),
                  );
                },
              ),
              // 内容
              Center(
                child: widget.isLoading
                    ? SizedBox(
                        width: widget.isSmall ? 16 : 20,
                        height: widget.isSmall ? 16 : 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: widget.isFollowing
                              ? colorScheme.primary
                              : Colors.white,
                        ),
                      )
                    : AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          widget.isFollowing ? '已关注' : '关注',
                          key: ValueKey<bool>(widget.isFollowing),
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: widget.isSmall ? 12 : 14,
                            fontWeight: FontWeight.w600,
                            color: widget.isFollowing
                                ? colorScheme.onSurfaceVariant
                                : Colors.white,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
