import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

/// 带缓存的图片组件
///
/// 使用 cached_network_image 实现图片缓存和加载状态展示
/// 支持圆角、占位图、错误图等自定义配置
/// 包含内存优化和性能优化策略
class CachedImage extends StatelessWidget {
  /// 图片 URL
  final String imageUrl;

  /// 图片宽度
  final double? width;

  /// 图片高度
  final double? height;

  /// 圆角半径
  final double? borderRadius;

  /// 是否圆形裁剪
  final bool isCircular;

  /// 填充模式
  final BoxFit fit;

  /// 占位图背景色
  final Color? placeholderColor;

  /// 错误时显示的图标
  final IconData errorIcon;

  /// 点击回调
  final VoidCallback? onTap;

  /// 最大缓存天数
  final int maxAgeDays;

  /// 是否使用内存缓存
  final bool useMemCache;

  /// 内存缓存宽度（用于优化内存占用）
  final int? memCacheWidth;

  /// 内存缓存高度（用于优化内存占用）
  final int? memCacheHeight;

  /// 淡入动画持续时间
  final Duration fadeInDuration;

  /// 语义标签，用于辅助功能
  final String? semanticLabel;

  /// 是否排除在语义树之外
  final bool excludeFromSemantics;

  /// 构造函数
  ///
  /// [imageUrl] 图片 URL（必填）
  /// [width] 图片宽度
  /// [height] 图片高度
  /// [borderRadius] 圆角半径，默认 0
  /// [isCircular] 是否圆形裁剪，默认 false
  /// [fit] 填充模式，默认 BoxFit.cover
  /// [placeholderColor] 占位图背景色
  /// [errorIcon] 错误时显示的图标，默认 Icons.broken_image
  /// [onTap] 点击回调
  /// [maxAgeDays] 最大缓存天数，默认 7 天
  /// [useMemCache] 是否使用内存缓存，默认 true
  /// [memCacheWidth] 内存缓存宽度，用于限制内存占用
  /// [memCacheHeight] 内存缓存高度，用于限制内存占用
  /// [fadeInDuration] 淡入动画持续时间，默认 300ms
  /// [semanticLabel] 语义标签，用于辅助功能描述图片内容
  /// [excludeFromSemantics] 是否排除在语义树之外，默认 false
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircular = false,
    this.fit = BoxFit.cover,
    this.placeholderColor,
    this.errorIcon = Icons.broken_image,
    this.onTap,
    this.maxAgeDays = 7,
    this.useMemCache = true,
    this.memCacheWidth,
    this.memCacheHeight,
    this.fadeInDuration = const Duration(milliseconds: 300),
    this.semanticLabel,
    this.excludeFromSemantics = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final placeholderBgColor =
        placeholderColor ??
        (Theme.of(context).brightness == Brightness.light
            ? Colors.grey[200]
            : Colors.grey[800]);

    // 使用 RepaintBoundary 优化重绘性能
    Widget imageWidget = RepaintBoundary(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: fadeInDuration,
        fadeOutDuration: const Duration(milliseconds: 100),
        // 内存缓存配置 - 限制内存占用
        memCacheWidth: memCacheWidth,
        memCacheHeight: memCacheHeight,
        // 占位图 - 骨架屏效果
        placeholder: (context, url) => _buildPlaceholder(placeholderBgColor!),
        // 错误处理
        errorWidget: (context, url, error) => _buildErrorWidget(colorScheme),
        // 缓存管理配置
        cacheManager: null, // 使用默认缓存管理器
      ),
    );

    // 应用圆角或圆形裁剪
    if (isCircular) {
      imageWidget = ClipOval(child: imageWidget);
    } else if (borderRadius != null && borderRadius! > 0) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: imageWidget,
      );
    }

    // 添加点击手势
    if (onTap != null) {
      imageWidget = GestureDetector(
        onTap: onTap,
        child: imageWidget,
      );
    }

    // 添加语义支持
    if (!excludeFromSemantics) {
      imageWidget = Semantics(
        label: semanticLabel,
        image: true,
        button: onTap != null,
        child: ExcludeSemantics(
          excluding: semanticLabel == null,
          child: imageWidget,
        ),
      );
    }

    return imageWidget;
  }

  /// 构建占位图（骨架屏效果）
  ///
  /// [color] 骨架屏基础颜色
  Widget _buildPlaceholder(Color color) {
    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color.withAlpha(128),
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius != null && borderRadius! > 0
              ? BorderRadius.circular(borderRadius!)
              : null,
        ),
      ),
    );
  }

  /// 构建错误状态组件
  ///
  /// [colorScheme] 当前主题的颜色方案
  Widget _buildErrorWidget(ColorScheme colorScheme) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: borderRadius != null && borderRadius! > 0
            ? BorderRadius.circular(borderRadius!)
            : null,
      ),
      child: Icon(
        errorIcon,
        color: colorScheme.onSurfaceVariant,
        size: (width != null && height != null)
            ? (width! < height! ? width! * 0.3 : height! * 0.3)
            : 24,
      ),
    );
  }
}

/// 图片预览组件
///
/// 支持点击查看大图，可配合 photo_view 使用
/// 包含懒加载和预加载优化
class CachedImageWithPreview extends StatelessWidget {
  /// 图片 URL
  final String imageUrl;

  /// 缩略图 URL（可选，用于列表展示）
  final String? thumbnailUrl;

  /// 图片宽度
  final double? width;

  /// 图片高度
  final double? height;

  /// 圆角半径
  final double? borderRadius;

  /// 是否圆形裁剪
  final bool isCircular;

  /// 填充模式
  final BoxFit fit;

  /// 是否启用预览
  final bool enablePreview;

  /// 预览图列表（用于多图预览）
  final List<String>? previewImages;

  /// 当前图片在预览列表中的索引
  final int previewIndex;

  /// 构造函数
  ///
  /// [imageUrl] 原图 URL（必填）
  /// [thumbnailUrl] 缩略图 URL，默认使用 imageUrl
  /// [width] 图片宽度
  /// [height] 图片高度
  /// [borderRadius] 圆角半径
  /// [isCircular] 是否圆形裁剪
  /// [fit] 填充模式
  /// [enablePreview] 是否启用预览，默认 true
  /// [previewImages] 预览图列表，用于多图预览
  /// [previewIndex] 当前图片在预览列表中的索引，默认 0
  const CachedImageWithPreview({
    super.key,
    required this.imageUrl,
    this.thumbnailUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircular = false,
    this.fit = BoxFit.cover,
    this.enablePreview = true,
    this.previewImages,
    this.previewIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    // 使用缩略图作为列表展示，减少内存占用
    return CachedImage(
      imageUrl: thumbnailUrl ?? imageUrl,
      width: width,
      height: height,
      borderRadius: borderRadius,
      isCircular: isCircular,
      fit: fit,
      // 限制内存缓存大小
      memCacheWidth: width?.toInt(),
      memCacheHeight: height?.toInt(),
      onTap: enablePreview ? () => _showImagePreview(context) : null,
    );
  }

  /// 显示图片预览
  ///
  /// [context] BuildContext
  void _showImagePreview(BuildContext context) {
    // TODO: 集成 photo_view 实现大图预览
    // 这里预留接口，后续可替换为实际的图片预览实现
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.zero,
        child: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            // 预览图使用原图尺寸
            memCacheWidth: null,
            memCacheHeight: null,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Center(
              child: Icon(Icons.broken_image, color: Colors.white, size: 48),
            ),
          ),
        ),
      ),
    );
  }
}

/// 懒加载图片组件
///
/// 仅在图片进入视口时才开始加载，优化列表性能
class LazyLoadImage extends StatefulWidget {
  /// 图片 URL
  final String imageUrl;

  /// 图片宽度
  final double? width;

  /// 图片高度
  final double? height;

  /// 圆角半径
  final double? borderRadius;

  /// 是否圆形裁剪
  final bool isCircular;

  /// 填充模式
  final BoxFit fit;

  /// 滚动控制器（用于监听滚动位置）
  final ScrollController? scrollController;

  /// 预加载偏移量（提前多少像素开始加载）
  final double preloadOffset;

  /// 构造函数
  ///
  /// [imageUrl] 图片 URL（必填）
  /// [width] 图片宽度
  /// [height] 图片高度
  /// [borderRadius] 圆角半径
  /// [isCircular] 是否圆形裁剪
  /// [fit] 填充模式
  /// [scrollController] 滚动控制器
  /// [preloadOffset] 预加载偏移量，默认 200 像素
  const LazyLoadImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircular = false,
    this.fit = BoxFit.cover,
    this.scrollController,
    this.preloadOffset = 200,
    this.onTap,
  });

  /// 点击回调
  final VoidCallback? onTap;

  @override
  State<LazyLoadImage> createState() => _LazyLoadImageState();
}

class _LazyLoadImageState extends State<LazyLoadImage> {
  /// 是否应当加载图片
  /// true 表示停止滚动，可以加载图片；false 表示正在滚动，展示占位图
  bool _shouldLoad = false;

  @override
  void initState() {
    super.initState();
    // 延迟检查滚动状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkScrollState();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 依赖变化时重新检查滚动状态
    _checkScrollState();
  }

  /// 检查当前滚动状态
  ///
  /// 使用 [Scrollable.recommendDeferredLoadingForContext] 判断当前是否正在滚动
  /// 如果正在滚动，展示轻量级占位图；如果停止滚动，开始加载图片
  void _checkScrollState() {
    if (_shouldLoad) return;

    final context = this.context;
    if (!context.mounted) return;

    // 使用 Scrollable.recommendDeferredLoadingForContext 判断滚动状态
    // 返回 true 表示建议延迟加载（正在滚动），false 表示可以立即加载（停止滚动）
    final shouldDefer = Scrollable.recommendDeferredLoadingForContext(context);

    if (shouldDefer) {
      // 正在滚动中，延迟加载，继续监听滚动状态变化
      // 使用微任务在下一帧再次检查
      Future.microtask(() {
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _checkScrollState();
          });
        }
      });
    } else {
      // 停止滚动，开始加载图片
      if (mounted) {
        setState(() {
          _shouldLoad = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageWidget = _shouldLoad
        ? CachedImage(
            imageUrl: widget.imageUrl,
            width: widget.width,
            height: widget.height,
            borderRadius: widget.borderRadius,
            isCircular: widget.isCircular,
            fit: widget.fit,
          )
        : _buildPlaceholder(context);

    if (widget.onTap == null) {
      return imageWidget;
    }

    return GestureDetector(onTap: widget.onTap, child: imageWidget);
  }

  /// 构建轻量级占位图
  ///
  /// [context] BuildContext，用于获取主题颜色
  ///
  /// 返回一个灰色背景的占位容器，用于滚动期间展示
  /// 避免使用 Shimmer 等复杂动画，减少滚动时的性能开销
  Widget _buildPlaceholder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final placeholderColor = colorScheme.surfaceContainerHighest;

    Widget placeholder = Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: placeholderColor,
        borderRadius: widget.borderRadius != null && widget.borderRadius! > 0
            ? BorderRadius.circular(widget.borderRadius!)
            : null,
      ),
    );

    // 应用圆角或圆形裁剪
    if (widget.isCircular) {
      placeholder = ClipOval(child: placeholder);
    } else if (widget.borderRadius != null && widget.borderRadius! > 0) {
      placeholder = ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius!),
        child: placeholder,
      );
    }

    return placeholder;
  }
}

/// 图片网格组件（九宫格等）
///
/// 优化多图展示的性能，支持懒加载和内存管理
class OptimizedImageGrid extends StatelessWidget {
  /// 图片 URL 列表
  final List<String> images;

  /// 图片点击回调
  final Function(int index)? onImageTap;

  /// 图片间距
  final double spacing;

  /// 圆角半径
  final double borderRadius;

  /// 最大显示数量（超过显示 +n）
  final int maxDisplayCount;

  /// 是否启用懒加载
  final bool enableLazyLoad;

  /// 构造函数
  ///
  /// [images] 图片 URL 列表（必填）
  /// [onImageTap] 图片点击回调
  /// [spacing] 图片间距，默认 4
  /// [borderRadius] 圆角半径，默认 8
  /// [maxDisplayCount] 最大显示数量，默认 9
  /// [enableLazyLoad] 是否启用懒加载，默认 true
  const OptimizedImageGrid({
    super.key,
    required this.images,
    this.onImageTap,
    this.spacing = 4,
    this.borderRadius = 8,
    this.maxDisplayCount = 9,
    this.enableLazyLoad = true,
  });

  @override
  Widget build(BuildContext context) {
    final imageCount = images.length;

    if (imageCount == 0) {
      return const SizedBox.shrink();
    }

    if (imageCount == 1) {
      return _buildSingleImage(context);
    }

    if (imageCount == 2) {
      return _buildGrid(context, crossAxisCount: 2, itemCount: 2);
    }

    if (imageCount == 3) {
      return _buildGrid(context, crossAxisCount: 3, itemCount: 3);
    }

    if (imageCount == 4) {
      return _buildGrid(context, crossAxisCount: 2, itemCount: 4);
    }

    return _buildNineGrid(context);
  }

  /// 构建单张图片
  Widget _buildSingleImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: _buildImage(0, fit: BoxFit.cover),
      ),
    );
  }

  /// 构建网格布局
  Widget _buildGrid(
    BuildContext context, {
    required int crossAxisCount,
    required int itemCount,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return _buildGridItem(index);
      },
    );
  }

  /// 构建九宫格
  Widget _buildNineGrid(BuildContext context) {
    final displayCount = images.length > maxDisplayCount
        ? maxDisplayCount
        : images.length;
    final hasMore = images.length > maxDisplayCount;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: displayCount,
      itemBuilder: (context, index) {
        if (hasMore && index == displayCount - 1) {
          return _buildMoreOverlay(index);
        }
        return _buildGridItem(index);
      },
    );
  }

  /// 构建网格项
  Widget _buildGridItem(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: _buildImage(index),
    );
  }

  /// 构建图片
  Widget _buildImage(int index, {BoxFit fit = BoxFit.cover}) {
    final imageUrl = images[index];

    if (enableLazyLoad) {
      return LazyLoadImage(
        imageUrl: imageUrl,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        onTap: onImageTap != null ? () => onImageTap!(index) : null,
      );
    }

    return CachedImage(
      imageUrl: imageUrl,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      // 限制内存缓存大小，网格图片使用较小尺寸
      memCacheWidth: 300,
      memCacheHeight: 300,
      onTap: onImageTap != null ? () => onImageTap!(index) : null,
    );
  }

  /// 构建更多图片覆盖层
  Widget _buildMoreOverlay(int index) {
    final remainingCount = images.length - maxDisplayCount + 1;

    return Stack(
      fit: StackFit.expand,
      children: [
        _buildImage(index),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(128),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Text(
              '+$remainingCount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 图片缓存配置
///
/// 用于配置全局图片缓存策略
class ImageCacheConfig {
  /// 最大缓存数量
  static const int maxCacheObjects = 200;

  /// 最大缓存大小（100MB）
  static const int maxCacheBytes = 100 * 1024 * 1024;

  /// 缓存有效期（天）
  static const int cacheValidDays = 7;

  /// 配置缓存
  ///
  /// 设置全局图片缓存参数
  static void configure() {
    // 配置 Flutter 图片缓存
    PaintingBinding.instance.imageCache.maximumSize = maxCacheObjects;
    PaintingBinding.instance.imageCache.maximumSizeBytes = maxCacheBytes;
  }

  /// 清理缓存
  ///
  /// 清理过期的图片缓存
  static void clearCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// 获取缓存信息
  ///
  /// 返回当前缓存状态信息
  static Map<String, dynamic> getCacheInfo() {
    final cache = PaintingBinding.instance.imageCache;
    return {
      'currentSize': cache.currentSize,
      'maximumSize': cache.maximumSize,
      'currentSizeBytes': cache.currentSizeBytes,
      'maximumSizeBytes': cache.maximumSizeBytes,
      'liveImageCount': cache.liveImageCount,
    };
  }
}
