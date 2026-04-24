import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../config/theme.dart';
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
  /// [maxLines] 最大行数，默认 4
  /// [onExpand] 展开/收起回调
  /// [onImageTap] 图片点击回调，参数为图片索引
  /// [onTextTap] 文字点击回调
  /// [enableLazyLoad] 是否启用图片懒加载，默认 true
  const FeedContent({
    super.key,
    this.text,
    this.images = const [],
    this.isExpanded = false,
    this.maxLines = 4,
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
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTextTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return _ExpandableText(
            text: text!,
            maxLines: maxLines,
            isExpanded: isExpanded,
            onExpand: onExpand,
            textStyle: textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
            maxWidth: constraints.maxWidth,
          );
        },
      ),
    );
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

/// 可展开文本组件
///
/// 使用 TextPainter 精确计算文本行数，实现 4 行截断和「查看更多」功能
class _ExpandableText extends StatefulWidget {
  /// 文本内容
  final String text;

  /// 最大显示行数
  final int maxLines;

  /// 是否已展开
  final bool isExpanded;

  /// 展开回调
  final VoidCallback? onExpand;

  /// 文本样式
  final TextStyle? textStyle;

  /// 最大宽度
  final double maxWidth;

  const _ExpandableText({
    required this.text,
    required this.maxLines,
    required this.isExpanded,
    this.onExpand,
    this.textStyle,
    required this.maxWidth,
  });

  @override
  State<_ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<_ExpandableText> {
  /// 是否需要显示展开按钮
  bool _needsExpand = false;

  @override
  void initState() {
    super.initState();
    _calculateTextLines();
  }

  @override
  void didUpdateWidget(_ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text ||
        oldWidget.maxWidth != widget.maxWidth ||
        oldWidget.maxLines != widget.maxLines) {
      _calculateTextLines();
    }
  }

  /// 计算文本行数，判断是否需要展开按钮
  void _calculateTextLines() {
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: widget.textStyle,
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
      textScaler: MediaQuery.of(context).textScaler,
    );

    textPainter.layout(maxWidth: widget.maxWidth);

    // 如果文本被截断（didExceedMaxLines 为 true），则需要显示展开按钮
    final needsExpand = textPainter.didExceedMaxLines;
    textPainter.dispose();

    // 仅在状态变化时调用 setState，减少不必要的重建
    if (needsExpand != _needsExpand) {
      setState(() {
        _needsExpand = needsExpand;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 如果已展开或不需要展开，直接显示完整文本
    if (widget.isExpanded || !_needsExpand) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            style: widget.textStyle?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
          // 展开状态下显示收起按钮
          if (_needsExpand && widget.isExpanded) ...[
            const SizedBox(height: 4),
            GestureDetector(
              onTap: widget.onExpand,
              child: Text(
                '收起',
                style: widget.textStyle?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      );
    }

    // 未展开状态：显示截断文本 + 「查看更多」
    return _buildTruncatedText(context);
  }

  /// 构建截断文本，在第四行末尾添加「...查看更多」
  Widget _buildTruncatedText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RichText(
      maxLines: widget.maxLines,
      overflow: TextOverflow.clip,
      text: TextSpan(
        style: widget.textStyle?.copyWith(
          color: colorScheme.onSurface,
        ),
        children: _buildTextSpans(context),
      ),
    );
  }

  /// 构建文本片段，包含截断文本和「查看更多」按钮
  List<TextSpan> _buildTextSpans(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textSpans = <TextSpan>[];

    // 计算截断位置
    final truncatedText = _calculateTruncatedText();

    // 添加截断后的文本
    textSpans.add(
      TextSpan(
        text: truncatedText,
      ),
    );

    // 添加「查看更多」按钮
    textSpans.add(
      TextSpan(
        text: '...查看更多',
        style: widget.textStyle?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
        recognizer: TapGestureRecognizer()..onTap = widget.onExpand,
      ),
    );

    return textSpans;
  }

  /// 计算截断后的文本
  ///
  /// 使用二分查找找到合适的截断位置，确保截断后加上「...查看更多」不超过 maxLines 行
  /// 优化处理：
  /// - 正确处理 Unicode 字符（如表情符号）
  /// - 避免在字符中间截断
  /// - 确保计算精度
  String _calculateTruncatedText() {
    const ellipsisText = '...查看更多';

    // 如果文本很短，直接返回
    if (widget.text.length <= 10) {
      return widget.text;
    }

    // 使用字符列表处理 Unicode 字符（包括表情符号）
    final characters = widget.text.characters.toList();
    int left = 0;
    int right = characters.length;
    String bestFit = '';

    while (left <= right) {
      final mid = (left + right) ~/ 2;
      final testText = characters.take(mid).join();
      final fullText = testText + ellipsisText;

      final textPainter = TextPainter(
        text: TextSpan(
          text: fullText,
          style: widget.textStyle,
        ),
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
        // 确保正确处理中文和 emoji
        textScaler: MediaQuery.of(context).textScaler,
      );

      textPainter.layout(maxWidth: widget.maxWidth);

      if (textPainter.didExceedMaxLines) {
        // 超出最大行数，需要减少文本
        right = mid - 1;
      } else {
        // 未超出最大行数，记录当前位置并尝试更多文本
        bestFit = testText;
        left = mid + 1;
      }

      textPainter.dispose();
    }

    // 确保不在单词或字符中间截断，尝试找到合适的截断点
    if (bestFit.isNotEmpty && bestFit.length < characters.length) {
      // 移除末尾的不完整字符或空格
      bestFit = bestFit.trimRight();
    }

    return bestFit;
  }
}

/// 动态文字内容组件（仅文字）
///
/// 支持精确的行数计算和「查看更多」功能
class FeedTextContent extends StatefulWidget {
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
    this.maxLines = 4,
    this.onExpand,
    this.onTap,
    this.selectable = false,
  });

  @override
  State<FeedTextContent> createState() => _FeedTextContentState();
}

class _FeedTextContentState extends State<FeedTextContent> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: widget.onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (widget.selectable) {
            return _buildSelectableText(context, constraints.maxWidth);
          }
          return _ExpandableText(
            text: widget.text,
            maxLines: widget.maxLines,
            isExpanded: widget.isExpanded,
            onExpand: widget.onExpand,
            textStyle: textTheme.bodyMedium?.copyWith(
              height: 1.5,
            ),
            maxWidth: constraints.maxWidth,
          );
        },
      ),
    );
  }

  /// 构建可选择文本
  Widget _buildSelectableText(BuildContext context, double maxWidth) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 计算是否需要展开
    final textPainter = TextPainter(
      text: TextSpan(
        text: widget.text,
        style: textTheme.bodyMedium?.copyWith(
          height: 1.5,
        ),
      ),
      maxLines: widget.maxLines,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);
    final needsExpand = textPainter.didExceedMaxLines;
    textPainter.dispose();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectableText(
          widget.text,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
            height: 1.5,
          ),
          maxLines: widget.isExpanded ? null : widget.maxLines,
        ),
        // 展开/收起按钮
        if (needsExpand) ...[
          const SizedBox(height: 4),
          GestureDetector(
            onTap: widget.onExpand,
            child: Text(
              widget.isExpanded ? '收起' : '展开全文',
              style: textTheme.bodyMedium?.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
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
