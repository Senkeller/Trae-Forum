import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/theme.dart';
import '../../providers/like_provider.dart';

/// 点赞按钮组件
///
/// 用于显示和操作帖子点赞功能
class LikeButton extends ConsumerStatefulWidget {
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
  const LikeButton({
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
  ConsumerState<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<LikeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // 初始化动画控制器
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
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
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    final notifier = ref.read(likeProvider.notifier);
    final state = ref.read(postLikeStateProvider(widget.postId));

    if (state == null || state.isLoading) return;

    // 执行动画
    await _animationController.forward();
    await _animationController.reverse();

    // 执行点赞/取消点赞操作
    await notifier.toggleLike(widget.postId);

    // 检查操作结果
    final newState = ref.read(postLikeStateProvider(widget.postId));
    if (newState?.errorMessage != null) {
      // 显示错误
      if (widget.onError != null) {
        widget.onError!(newState!.errorMessage!);
      } else {
        _showErrorSnackBar(newState!.errorMessage!);
      }
    } else {
      // 执行回调
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

        // 如果状态还未初始化，显示初始状态
        final isLiked = likeState?.isLiked ?? widget.initialIsLiked;
        final likeCount = likeState?.likeCount ?? widget.initialLikeCount;
        final isLoading = likeState?.isLoading ?? false;

        final iconColor = isLiked ? AppTheme.likeColor : colorScheme.onSurfaceVariant;
        final textColor = isLiked ? AppTheme.likeColor : colorScheme.onSurfaceVariant;

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
                                isLiked ? Icons.favorite : Icons.favorite_border,
                                size: widget.iconSize,
                                color: iconColor,
                              ),
                      );
                    },
                  ),
                  if (widget.showCount) ...[
                    const SizedBox(width: 4),
                    Text(
                      _formatCount(likeCount),
                      style: textTheme.bodySmall?.copyWith(
                        color: textColor,
                        fontSize: widget.fontSize,
                        fontWeight: isLiked ? FontWeight.w600 : FontWeight.normal,
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

  /// 格式化数量
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

/// 简洁版点赞按钮
///
/// 用于需要简洁展示的场景
class LikeButtonSimple extends ConsumerWidget {
  /// 帖子ID
  final int postId;

  /// 初始点赞数
  final int initialLikeCount;

  /// 初始是否已点赞
  final bool initialIsLiked;

  /// 操作摘要列表
  final List<dynamic>? actionsSummary;

  /// 图标大小
  final double iconSize;

  /// 构造函数
  const LikeButtonSimple({
    super.key,
    required this.postId,
    this.initialLikeCount = 0,
    this.initialIsLiked = false,
    this.actionsSummary,
    this.iconSize = 16,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 初始化状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(likeProvider.notifier);
      if (actionsSummary != null) {
        notifier.initializeFromActionsSummary(postId, actionsSummary);
      } else {
        notifier.initializePost(
          postId,
          likeCount: initialLikeCount,
          isLiked: initialIsLiked,
        );
      }
    });

    final likeState = ref.watch(postLikeStateProvider(postId));
    final isLiked = likeState?.isLiked ?? initialIsLiked;
    final likeCount = likeState?.likeCount ?? initialLikeCount;

    return GestureDetector(
      onTap: () => ref.read(likeProvider.notifier).toggleLike(postId),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isLiked ? Icons.favorite : Icons.favorite_border,
            size: iconSize,
            color: isLiked ? AppTheme.likeColor : colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 2),
          Text(
            _formatCount(likeCount),
            style: textTheme.bodySmall?.copyWith(
              color: isLiked ? AppTheme.likeColor : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化数量
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
