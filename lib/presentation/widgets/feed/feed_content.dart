import 'package:flutter/material.dart';

import '../common/cached_image.dart';

/// 动态内容组件
///
/// 展示动态的文字内容和图片（支持九宫格布局）
/// 使用性能优化策略：懒加载、内存缓存限制、RepaintBoundary
class FeedContent extends StatelessWidget {
  /// 文字内容
  final String? text;

  /// 图片 URL 列表
  final List<String> images;

  /// 是否展开全文
  final bool isExpanded;

  /// 最大行数（未展开时）
  final int maxLines;

  /// 展开/收起回调
  final VoidCallback? onExpand;

  /// 图片点击回调
  final Function(int index)? onImageTap;

  /// 文字点击回调
  final VoidCallback? onTextTap;

  /// 是否启用图片懒加载
  final bool enableLazyLoad;

  /// 构造函数
  ///
  /// [text] 文字内容
  /// [images] 图片 URL 列表
  /// [isExpanded] 是否展开全文，默认 false
  /// [maxLines] 最大行数，默认 6
  /// [onExpand] 展开/收起回调
  /// [onImageTap] 图片点击回调，参数为图片索引
  /// [onTextTap] 文字点击回调
  /// [enableLazyLoad] 是否启用图片懒加载，默认 true
  const FeedContent({
    super.key,
    this.text,
    this.images = const [],
    this.isExpanded = false,
    this.maxLines = 6,
    this.onExpand,
    this.onImageTap,
    this.onTextTap,
    this.enableLazyLoad = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 文字内容
        if (text != null && text!.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildTextContent(context),
          ),
        ],
        // 图片内容
        if (images.isNotEmpty) ...[
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _buildImageGrid(context),
          ),
        ],
      ],
    );
  }

  /// 构建文字内容
  Widget _buildTextContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTextTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text!,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
              height: 1.5,
            ),
            maxLines: isExpanded ? null : maxLines,
            overflow: isExpanded ? null : TextOverflow.ellipsis,
          ),
          // 展开/收起按钮
          if (_shouldShowExpandButton()) ...[
            const SizedBox(height: 4),
            GestureDetector(
              onTap: onExpand,
              child: Text(
                isExpanded ? '收起' : '展开全文',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 是否需要显示展开按钮
  bool _shouldShowExpandButton() {
    if (text == null || text!.isEmpty) return false;
    // 简化判断：文字长度超过一定阈值时显示展开按钮
    return text!.length > 100;
  }

  /// 构建图片网格
  Widget _buildImageGrid(BuildContext context) {
    // 使用优化的图片网格组件
    return OptimizedImageGrid(
      images: images,
      onImageTap: onImageTap,
      spacing: 4,
      borderRadius: 8,
      maxDisplayCount: 9,
      enableLazyLoad: enableLazyLoad,
    );
  }
}

/// 动态文字内容组件（仅文字）
class FeedTextContent extends StatelessWidget {
  /// 文字内容
  final String text;

  /// 是否展开全文
  final bool isExpanded;

  /// 最大行数
  final int maxLines;

  /// 展开/收起回调
  final VoidCallback? onExpand;

  /// 文字点击回调
  final VoidCallback? onTap;

  /// 是否支持选择复制
  final bool selectable;

  /// 构造函数
  const FeedTextContent({
    super.key,
    required this.text,
    this.isExpanded = false,
    this.maxLines = 6,
    this.onExpand,
    this.onTap,
    this.selectable = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    Widget textWidget = Text(
      text,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurface,
        height: 1.5,
      ),
      maxLines: isExpanded ? null : maxLines,
      overflow: isExpanded ? null : TextOverflow.ellipsis,
    );

    if (selectable) {
      textWidget = SelectableText(
        text,
        style: textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurface,
          height: 1.5,
        ),
        maxLines: isExpanded ? null : maxLines,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          textWidget,
          // 展开/收起按钮
          if (_shouldShowExpandButton()) ...[
            const SizedBox(height: 4),
            GestureDetector(
              onTap: onExpand,
              child: Text(
                isExpanded ? '收起' : '展开全文',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 是否需要显示展开按钮
  bool _shouldShowExpandButton() {
    return text.length > 100;
  }
}

/// 动态图片内容组件（仅图片）
class FeedImageContent extends StatelessWidget {
  /// 图片 URL 列表
  final List<String> images;

  /// 图片点击回调
  final Function(int index)? onImageTap;

  /// 图片间距
  final double spacing;

  /// 圆角半径
  final double borderRadius;

  /// 是否启用懒加载
  final bool enableLazyLoad;

  /// 构造函数
  const FeedImageContent({
    super.key,
    required this.images,
    this.onImageTap,
    this.spacing = 4,
    this.borderRadius = 8,
    this.enableLazyLoad = true,
  });

  @override
  Widget build(BuildContext context) {
    return OptimizedImageGrid(
      images: images,
      onImageTap: onImageTap,
      spacing: spacing,
      borderRadius: borderRadius,
      enableLazyLoad: enableLazyLoad,
    );
  }
}

/// 动态视频内容组件
///
/// 用于展示视频缩略图和播放按钮
class FeedVideoContent extends StatelessWidget {
  /// 视频缩略图 URL
  final String coverUrl;

  /// 视频时长
  final Duration? duration;

  /// 视频宽度
  final double? width;

  /// 视频高度
  final double? height;

  /// 点击播放回调
  final VoidCallback? onPlay;

  /// 构造函数
  const FeedVideoContent({
    super.key,
    required this.coverUrl,
    this.duration,
    this.width,
    this.height,
    this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlay,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 缩略图 - 使用优化后的图片组件
            AspectRatio(
              aspectRatio: width != null && height != null
                  ? width! / height!
                  : 16 / 9,
              child: CachedImage(
                imageUrl: coverUrl,
                fit: BoxFit.cover,
                // 限制内存缓存大小
                memCacheWidth: 400,
                memCacheHeight: 225,
              ),
            ),
            // 播放按钮
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(128),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 36,
              ),
            ),
            // 时长
            if (duration != null)
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(153),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    _formatDuration(duration!),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 格式化时长
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
