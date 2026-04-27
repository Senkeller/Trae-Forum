import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'cached_image.dart';

/// 懒加载图片组件
///
/// 图片只有在进入可视区域时才会开始加载
/// 用于优化长列表中的图片加载性能
class LazyImage extends StatefulWidget {
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

  /// 可视阈值（0.0 - 1.0）
  /// 当图片进入可视区域的比例超过此值时开始加载
  final double visibilityThreshold;

  const LazyImage({
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
    this.visibilityThreshold = 0.1,
  });

  @override
  State<LazyImage> createState() => _LazyImageState();
}

class _LazyImageState extends State<LazyImage> {
  /// 是否应该加载图片
  bool _shouldLoad = false;

  @override
  Widget build(BuildContext context) {
    // 如果已经应该加载，直接显示图片
    if (_shouldLoad) {
      return CachedImage(
        imageUrl: widget.imageUrl,
        width: widget.width,
        height: widget.height,
        borderRadius: widget.borderRadius,
        isCircular: widget.isCircular,
        fit: widget.fit,
        placeholderColor: widget.placeholderColor,
        errorIcon: widget.errorIcon,
        onTap: widget.onTap,
      );
    }

    // 使用 VisibilityDetector 检测图片是否进入可视区域
    return VisibilityDetector(
      key: Key('lazy_image_${widget.imageUrl}'),
      onVisibilityChanged: (info) {
        // 当图片进入可视区域超过阈值时，开始加载
        if (info.visibleFraction > widget.visibilityThreshold && !_shouldLoad) {
          setState(() {
            _shouldLoad = true;
          });
        }
      },
      child: _buildPlaceholder(),
    );
  }

  /// 构建占位图
  Widget _buildPlaceholder() {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = widget.placeholderColor ??
        (Theme.of(context).brightness == Brightness.light
            ? Colors.grey[200]
            : Colors.grey[800]);

    Widget placeholder = Container(
      width: widget.width,
      height: widget.height,
      color: bgColor,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          color: colorScheme.onSurfaceVariant.withOpacity(0.3),
          size: 32,
        ),
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
