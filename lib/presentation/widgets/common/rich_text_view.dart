import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import 'cached_image.dart';

/// 富文本展示组件
///
/// 支持 HTML 标签渲染、链接点击、图片点击预览、@用户和#话题高亮
/// 基于 flutter_html 实现，提供丰富的富文本展示能力
class RichTextView extends StatelessWidget {
  /// HTML 内容
  final String htmlContent;

  /// 最大行数（用于限制高度）
  final int? maxLines;

  /// 是否支持链接点击
  final bool enableLinkTap;

  /// 是否支持图片点击
  final bool enableImageTap;

  /// 链接点击回调
  final Function(String url)? onLinkTap;

  /// 图片点击回调
  final Function(String imageUrl)? onImageTap;

  /// @用户点击回调
  final Function(String username)? onMentionTap;

  /// #话题点击回调
  final Function(String topic)? onTopicTap;

  /// 自定义样式
  final Map<String, Style>? customStyles;

  /// 文本颜色
  final Color? textColor;

  /// 链接颜色
  final Color? linkColor;

  /// 字体大小
  final double? fontSize;

  /// 行高
  final double? lineHeight;

  /// 构造函数
  ///
  /// [htmlContent] HTML 内容（必填）
  /// [maxLines] 最大行数
  /// [enableLinkTap] 是否支持链接点击，默认 true
  /// [enableImageTap] 是否支持图片点击，默认 true
  /// [onLinkTap] 链接点击回调
  /// [onImageTap] 图片点击回调
  /// [onMentionTap] @用户点击回调
  /// [onTopicTap] #话题点击回调
  /// [customStyles] 自定义 HTML 样式
  /// [textColor] 文本颜色
  /// [linkColor] 链接颜色
  /// [fontSize] 字体大小
  /// [lineHeight] 行高
  const RichTextView({
    super.key,
    required this.htmlContent,
    this.maxLines,
    this.enableLinkTap = true,
    this.enableImageTap = true,
    this.onLinkTap,
    this.onImageTap,
    this.onMentionTap,
    this.onTopicTap,
    this.customStyles,
    this.textColor,
    this.linkColor,
    this.fontSize,
    this.lineHeight,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 处理 HTML 内容，转换 @用户 和 #话题
    final processedHtml = _processMentionsAndTopics(htmlContent);

    // 构建基础样式
    final baseStyle = Style(
      color: textColor != null ? Color(textColor!.value) : null,
      fontSize: fontSize != null ? FontSize(fontSize!) : null,
      lineHeight: lineHeight != null ? LineHeight(lineHeight!) : null,
      margin: Margins.zero,
      padding: HtmlPaddings.zero,
    );

    // 合并自定义样式
    final styles = {
      'body': baseStyle,
      'p': Style(
        margin: Margins.only(bottom: 8.0),
      ),
      'a': Style(
        color: linkColor ?? colorScheme.primary,
        textDecoration: TextDecoration.none,
      ),
      'img': Style(
        width: Width.auto(),
        height: Height.auto(),
      ),
      'strong': Style(
        fontWeight: FontWeight.bold,
      ),
      'em': Style(
        fontStyle: FontStyle.italic,
      ),
      'u': Style(
        textDecoration: TextDecoration.underline,
      ),
      's': Style(
        textDecoration: TextDecoration.lineThrough,
      ),
      'mention': Style(
        color: colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      'topic': Style(
        color: colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      ...?customStyles,
    };

    return Html(
      data: processedHtml,
      style: styles,
      onLinkTap: enableLinkTap
          ? (url, _, __) => _handleLinkTap(context, url)
          : null,
      extensions: [
        // 自定义图片渲染
        if (enableImageTap)
          ImageExtension(
            builder: (extensionContext) {
              final imageUrl = DiscourseImageUrlResolver.resolveFromAttributes(
                extensionContext.attributes,
              );
              final originalImageUrl =
                  DiscourseImageUrlResolver.resolveOriginalFromAttributes(
                extensionContext.attributes,
              );
              if (imageUrl == null) return const SizedBox.shrink();

              return GestureDetector(
                onTap: () => _handleImageTap(originalImageUrl ?? imageUrl),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 120,
                      maxHeight: 120,
                    ),
                    child: CachedImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                      memCacheWidth: 240,
                      memCacheHeight: 240,
                    ),
                  ),
                ),
              );
            },
          ),
        // 自定义标签扩展
        TagExtension(
          tagsToExtend: {'mention'},
          builder: (extensionContext) {
            final username = extensionContext.attributes['data-user'] ?? '';
            return GestureDetector(
              onTap: () => onMentionTap?.call(username),
              child: Text(
                '@$username',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
        TagExtension(
          tagsToExtend: {'topic'},
          builder: (extensionContext) {
            final topic = extensionContext.attributes['data-topic'] ?? '';
            return GestureDetector(
              onTap: () => onTopicTap?.call(topic),
              child: Text(
                '#$topic#',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  /// 处理 @用户 和 #话题 标记
  ///
  /// [content] 原始内容
  /// 返回处理后的 HTML 字符串
  String _processMentionsAndTopics(String content) {
    String result = content;

    // 转换 @用户名 为自定义标签
    result = result.replaceAllMapped(
      RegExp(r'@([\w\u4e00-\u9fa5]+)'),
      (match) => '<mention data-user="${match.group(1)}">@${match.group(1)}</mention>',
    );

    // 转换 #话题# 为自定义标签
    result = result.replaceAllMapped(
      RegExp(r'#([^#\s]+)#'),
      (match) => '<topic data-topic="${match.group(1)}">#${match.group(1)}#</topic>',
    );

    // 包裹在 body 标签中
    if (!result.startsWith('<')) {
      result = '<p>$result</p>';
    }

    return result;
  }

  /// 处理链接点击
  ///
  /// [context] BuildContext
  /// [url] 链接地址
  Future<void> _handleLinkTap(BuildContext context, String? url) async {
    if (url == null) return;

    // 优先调用自定义回调
    if (onLinkTap != null) {
      onLinkTap!(url);
      return;
    }

    // 默认使用 url_launcher 打开链接
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// 处理图片点击
  ///
  /// [imageUrl] 图片地址
  void _handleImageTap(String imageUrl) {
    if (onImageTap != null) {
      onImageTap!(imageUrl);
    }
  }
}

/// 简化版富文本组件
///
/// 用于展示简单的富文本内容，不支持复杂的 HTML 标签
class SimpleRichText extends StatelessWidget {
  /// 文本内容
  final String text;

  /// 文本样式
  final TextStyle? style;

  /// 链接颜色
  final Color? linkColor;

  /// 链接点击回调
  final Function(String url)? onLinkTap;

  /// @用户点击回调
  final Function(String username)? onMentionTap;

  /// #话题点击回调
  final Function(String topic)? onTopicTap;

  /// 最大行数
  final int? maxLines;

  /// 文本溢出处理
  final TextOverflow? overflow;

  /// 构造函数
  ///
  /// [text] 文本内容（必填）
  /// [style] 文本样式
  /// [linkColor] 链接颜色
  /// [onLinkTap] 链接点击回调
  /// [onMentionTap] @用户点击回调
  /// [onTopicTap] #话题点击回调
  /// [maxLines] 最大行数
  /// [overflow] 文本溢出处理
  const SimpleRichText({
    super.key,
    required this.text,
    this.style,
    this.linkColor,
    this.onLinkTap,
    this.onMentionTap,
    this.onTopicTap,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final defaultStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onBackground,
      height: 1.5,
    );

    final spans = _buildTextSpans(context, text, style ?? defaultStyle);

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }

  /// 构建文本 Span 列表
  ///
  /// [context] BuildContext
  /// [text] 原始文本
  /// [baseStyle] 基础样式
  /// 返回 InlineSpan 列表
  List<InlineSpan> _buildTextSpans(
    BuildContext context,
    String text,
    TextStyle? baseStyle,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final spans = <InlineSpan>[];

    // 正则表达式匹配 URL、@用户、#话题#
    final regex = RegExp(
      r'(https?://[^\s]+)|(@[\w\u4e00-\u9fa5]+)|(#[^#\s]+#)',
    );

    int lastEnd = 0;
    for (final match in regex.allMatches(text)) {
      // 添加匹配前的普通文本
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: baseStyle,
        ));
      }

      final matchedText = match.group(0)!;

      // 判断匹配类型并添加对应的 Span
      if (match.group(1) != null) {
        // URL
        spans.add(_buildLinkSpan(context, matchedText, baseStyle));
      } else if (match.group(2) != null) {
        // @用户
        final username = matchedText.substring(1);
        spans.add(_buildMentionSpan(context, username, baseStyle));
      } else if (match.group(3) != null) {
        // #话题#
        final topic = matchedText.substring(1, matchedText.length - 1);
        spans.add(_buildTopicSpan(context, topic, baseStyle));
      }

      lastEnd = match.end;
    }

    // 添加剩余文本
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: baseStyle,
      ));
    }

    return spans;
  }

  /// 构建链接 Span
  ///
  /// [context] BuildContext
  /// [url] 链接地址
  /// [baseStyle] 基础样式
  /// 返回 TextSpan
  InlineSpan _buildLinkSpan(BuildContext context, String url, TextStyle? baseStyle) {
    final colorScheme = Theme.of(context).colorScheme;

    return WidgetSpan(
      child: GestureDetector(
        onTap: () => _handleLinkTap(context, url),
        child: Text(
          url,
          style: baseStyle?.copyWith(
            color: linkColor ?? colorScheme.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  /// 构建 @用户 Span
  ///
  /// [context] BuildContext
  /// [username] 用户名
  /// [baseStyle] 基础样式
  /// 返回 TextSpan
  InlineSpan _buildMentionSpan(BuildContext context, String username, TextStyle? baseStyle) {
    final colorScheme = Theme.of(context).colorScheme;

    return WidgetSpan(
      child: GestureDetector(
        onTap: () => onMentionTap?.call(username),
        child: Text(
          '@$username',
          style: baseStyle?.copyWith(
            color: linkColor ?? colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// 构建 #话题# Span
  ///
  /// [context] BuildContext
  /// [topic] 话题名称
  /// [baseStyle] 基础样式
  /// 返回 TextSpan
  InlineSpan _buildTopicSpan(BuildContext context, String topic, TextStyle? baseStyle) {
    final colorScheme = Theme.of(context).colorScheme;

    return WidgetSpan(
      child: GestureDetector(
        onTap: () => onTopicTap?.call(topic),
        child: Text(
          '#$topic#',
          style: baseStyle?.copyWith(
            color: linkColor ?? colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// 处理链接点击
  ///
  /// [context] BuildContext
  /// [url] 链接地址
  Future<void> _handleLinkTap(BuildContext context, String url) async {
    if (onLinkTap != null) {
      onLinkTap!(url);
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// 富文本图片预览对话框
///
/// 用于展示富文本中的图片大图预览
class RichTextImagePreview extends StatelessWidget {
  /// 图片 URL
  final String imageUrl;

  /// 图片列表（用于多图预览）
  final List<String>? imageUrls;

  /// 当前图片索引
  final int initialIndex;

  /// 构造函数
  ///
  /// [imageUrl] 图片 URL（必填）
  /// [imageUrls] 图片列表
  /// [initialIndex] 当前图片索引，默认 0
  const RichTextImagePreview({
    super.key,
    required this.imageUrl,
    this.imageUrls,
    this.initialIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    final images = imageUrls ?? [imageUrl];

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        children: [
          // 图片展示
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: Colors.black.withOpacity(0.9),
              child: Center(
                child: CachedImage(
                  imageUrl: images[initialIndex],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          // 关闭按钮
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
          // 图片计数器
          if (images.length > 1)
            Positioned(
              bottom: 32,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    '${initialIndex + 1} / ${images.length}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// 显示图片预览
  ///
  /// [context] BuildContext
  /// [imageUrl] 图片 URL
  /// [imageUrls] 图片列表
  /// [initialIndex] 初始索引
  static void show(
    BuildContext context, {
    required String imageUrl,
    List<String>? imageUrls,
    int initialIndex = 0,
  }) {
    showDialog(
      context: context,
      builder: (context) => RichTextImagePreview(
        imageUrl: imageUrl,
        imageUrls: imageUrls,
        initialIndex: initialIndex,
      ),
    );
  }
}
