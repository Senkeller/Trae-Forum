import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// 加载状态组件
///
/// 提供多种加载状态展示方式：
/// - 圆形进度指示器
/// - 线性进度指示器
/// - 骨架屏（Shimmer 效果）
/// - 列表骨架屏
class LoadingWidget extends StatelessWidget {
  /// 加载提示文字
  final String? message;

  /// 进度指示器颜色
  final Color? color;

  /// 背景颜色
  final Color? backgroundColor;

  /// 构造函数
  ///
  /// [message] 加载提示文字
  /// [color] 进度指示器颜色
  /// [backgroundColor] 背景颜色
  const LoadingWidget({
    super.key,
    this.message,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final indicatorColor = color ?? colorScheme.primary;
    final bgColor = backgroundColor ?? colorScheme.background;

    return Container(
      color: bgColor,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: indicatorColor,
            ),
            if (message != null) ...[
              const SizedBox(height: 16),
              Text(
                message!,
                style: TextStyle(
                  color: colorScheme.onBackground,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 骨架屏组件
///
/// 使用 Shimmer 效果展示加载中的内容占位
class SkeletonWidget extends StatelessWidget {
  /// 骨架屏宽度
  final double? width;

  /// 骨架屏高度
  final double? height;

  /// 圆角半径
  final double borderRadius;

  /// 构造函数
  ///
  /// [width] 宽度
  /// [height] 高度
  /// [borderRadius] 圆角半径，默认 8
  const SkeletonWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final highlightColor = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

/// 列表骨架屏
///
/// 用于列表加载时的占位展示
class ListSkeletonWidget extends StatelessWidget {
  /// 列表项数量
  final int itemCount;

  /// 列表项高度
  final double itemHeight;

  /// 列表项内边距
  final EdgeInsetsGeometry padding;

  /// 是否显示分隔线
  final bool showDivider;

  /// 构造函数
  ///
  /// [itemCount] 列表项数量，默认 5
  /// [itemHeight] 列表项高度，默认 80
  /// [padding] 列表项内边距，默认 EdgeInsets.all(16)
  /// [showDivider] 是否显示分隔线，默认 true
  const ListSkeletonWidget({
    super.key,
    this.itemCount = 5,
    this.itemHeight = 80,
    this.padding = const EdgeInsets.all(16),
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      padding: padding,
      separatorBuilder: (context, index) =>
          showDivider ? const Divider(height: 1) : const SizedBox.shrink(),
      itemBuilder: (context, index) => _buildListItemSkeleton(),
    );
  }

  /// 构建列表项骨架屏
  Widget _buildListItemSkeleton() {
    return SizedBox(
      height: itemHeight,
      child: Row(
        children: [
          // 头像占位
          const SkeletonWidget(
            width: 48,
            height: 48,
            borderRadius: 24,
          ),
          const SizedBox(width: 12),
          // 内容占位
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 标题占位
                const SkeletonWidget(
                  width: 120,
                  height: 16,
                ),
                const SizedBox(height: 8),
                // 副标题占位
                const SkeletonWidget(
                  width: double.infinity,
                  height: 12,
                ),
                const SizedBox(height: 4),
                // 描述占位
                SkeletonWidget(
                  width: double.infinity,
                  height: 12,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 卡片骨架屏
///
/// 用于卡片加载时的占位展示
class CardSkeletonWidget extends StatelessWidget {
  /// 卡片数量
  final int cardCount;

  /// 卡片间距
  final double spacing;

  /// 卡片内边距
  final EdgeInsetsGeometry padding;

  /// 是否显示图片区域
  final bool showImage;

  /// 图片高度
  final double imageHeight;

  /// 构造函数
  ///
  /// [cardCount] 卡片数量，默认 2
  /// [spacing] 卡片间距，默认 16
  /// [padding] 卡片内边距，默认 EdgeInsets.all(16)
  /// [showImage] 是否显示图片区域，默认 true
  /// [imageHeight] 图片高度，默认 160
  const CardSkeletonWidget({
    super.key,
    this.cardCount = 2,
    this.spacing = 16,
    this.padding = const EdgeInsets.all(16),
    this.showImage = true,
    this.imageHeight = 160,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: padding,
      itemCount: cardCount,
      separatorBuilder: (context, index) => SizedBox(height: spacing),
      itemBuilder: (context, index) => _buildCardSkeleton(),
    );
  }

  /// 构建卡片骨架屏
  Widget _buildCardSkeleton() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 作者信息占位
          Row(
            children: [
              const SkeletonWidget(
                width: 40,
                height: 40,
                borderRadius: 20,
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonWidget(
                    width: 100,
                    height: 14,
                  ),
                  const SizedBox(height: 4),
                  SkeletonWidget(
                    width: 60,
                    height: 12,
                    borderRadius: 4,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 内容占位
          const SkeletonWidget(
            width: double.infinity,
            height: 14,
          ),
          const SizedBox(height: 4),
          SkeletonWidget(
            width: double.infinity,
            height: 14,
            borderRadius: 4,
          ),
          if (showImage) ...[
            const SizedBox(height: 12),
            SkeletonWidget(
              width: double.infinity,
              height: imageHeight,
              borderRadius: 8,
            ),
          ],
        ],
      ),
    );
  }
}

/// 全屏加载遮罩
///
/// 用于需要全屏加载状态的场景
class FullScreenLoading extends StatelessWidget {
  /// 是否显示
  final bool isLoading;

  /// 加载提示文字
  final String? message;

  /// 背景透明度
  final double backgroundOpacity;

  /// 构造函数
  ///
  /// [isLoading] 是否显示加载状态
  /// [message] 加载提示文字
  /// [backgroundOpacity] 背景透明度，默认 0.5
  const FullScreenLoading({
    super.key,
    required this.isLoading,
    this.message,
    this.backgroundOpacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    if (!isLoading) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background.withOpacity(backgroundOpacity),
      child: LoadingWidget(
        message: message,
      ),
    );
  }
}
