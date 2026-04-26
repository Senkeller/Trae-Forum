import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../common/cached_image.dart';

/// Markdown 预览组件
///
/// 将 Markdown 文本渲染为富文本展示，支持：
/// - 标题（H1-H6）
/// - 文本样式（加粗、斜体、删除线）
/// - 引用块
/// - 代码（行内代码、代码块）
/// - 列表（无序列表、有序列表）
/// - 分割线
/// - 链接
/// - 图片
///
/// 使用示例：
/// ```dart
/// ComposerPreview(
///   markdownText: '# 标题\n\n正文内容',
///   emptyHint: '暂无内容',
/// )
/// ```
class ComposerPreview extends StatelessWidget {
  /// Markdown 文本内容
  final String markdownText;

  /// 空内容提示文字
  final String emptyHint;

  /// 文本颜色
  final Color? textColor;

  /// 链接颜色
  final Color? linkColor;

  /// 代码背景色
  final Color? codeBackgroundColor;

  /// 引用边框颜色
  final Color? quoteBorderColor;

  /// 字体大小
  final double? fontSize;

  /// 行高
  final double? lineHeight;

  /// 内边距
  final EdgeInsets padding;

  /// 链接点击回调
  final Function(String url)? onLinkTap;

  /// 图片点击回调
  final Function(String imageUrl)? onImageTap;

  /// 构造函数
  ///
  /// [markdownText] Markdown 文本内容（必填）
  /// [emptyHint] 空内容提示文字，默认 "暂无内容"
  /// [textColor] 文本颜色
  /// [linkColor] 链接颜色
  /// [codeBackgroundColor] 代码背景色
  /// [quoteBorderColor] 引用边框颜色
  /// [fontSize] 字体大小
  /// [lineHeight] 行高
  /// [padding] 内边距，默认 EdgeInsets.all(16)
  /// [onLinkTap] 链接点击回调
  /// [onImageTap] 图片点击回调
  const ComposerPreview({
    super.key,
    required this.markdownText,
    this.emptyHint = '暂无内容',
    this.textColor,
    this.linkColor,
    this.codeBackgroundColor,
    this.quoteBorderColor,
    this.fontSize,
    this.lineHeight,
    this.padding = const EdgeInsets.all(16),
    this.onLinkTap,
    this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 如果内容为空，显示空状态
    if (markdownText.trim().isEmpty) {
      return _buildEmptyState(context);
    }

    // 将 Markdown 转换为 HTML
    final htmlContent = _markdownToHtml(markdownText);

    return Container(
      padding: padding,
      child: SingleChildScrollView(
        child: Html(
          data: htmlContent,
          style: _buildStyles(context, colorScheme),
          onLinkTap: (url, attributes, element) {
            if (url != null) {
              onLinkTap?.call(url);
            }
          },
          extensions: [
            // 自定义图片渲染
            ImageExtension(
              builder: (extensionContext) {
                final imageUrl = DiscourseImageUrlResolver.resolveFromAttributes(
                  extensionContext.attributes,
                );
                if (imageUrl == null) return const SizedBox.shrink();

                return GestureDetector(
                  onTap: () => onImageTap?.call(imageUrl),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: double.infinity,
                        maxHeight: 300,
                      ),
                      child: CachedImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.visibility_off_outlined,
              size: 48,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            Text(
              emptyHint,
              style: TextStyle(
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建 HTML 样式
  Map<String, Style> _buildStyles(BuildContext context, ColorScheme colorScheme) {
    final baseTextColor = textColor ?? colorScheme.onSurface;
    final baseLinkColor = linkColor ?? colorScheme.primary;
    final baseCodeBg = codeBackgroundColor ?? colorScheme.surfaceContainerHighest.withValues(alpha: 0.5);
    final baseQuoteBorder = quoteBorderColor ?? colorScheme.primary.withValues(alpha: 0.5);

    return {
      'body': Style(
        color: baseTextColor,
        fontSize: fontSize != null ? FontSize(fontSize!) : FontSize.medium,
        lineHeight: lineHeight != null ? LineHeight(lineHeight!) : LineHeight.percent(160),
        margin: Margins.zero,
        padding: HtmlPaddings.zero,
      ),
      // 标题样式
      'h1': Style(
        fontSize: FontSize.xxLarge,
        fontWeight: FontWeight.bold,
        color: baseTextColor,
        margin: Margins.only(bottom: 16, top: 8),
      ),
      'h2': Style(
        fontSize: FontSize.xLarge,
        fontWeight: FontWeight.bold,
        color: baseTextColor,
        margin: Margins.only(bottom: 14, top: 8),
      ),
      'h3': Style(
        fontSize: FontSize.large,
        fontWeight: FontWeight.bold,
        color: baseTextColor,
        margin: Margins.only(bottom: 12, top: 8),
      ),
      'h4': Style(
        fontSize: FontSize.larger,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        margin: Margins.only(bottom: 10, top: 8),
      ),
      'h5': Style(
        fontSize: FontSize.medium,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
        margin: Margins.only(bottom: 8, top: 8),
      ),
      'h6': Style(
        fontSize: FontSize.small,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurfaceVariant,
        margin: Margins.only(bottom: 8, top: 8),
      ),
      // 段落
      'p': Style(
        margin: Margins.only(bottom: 12),
        color: baseTextColor,
      ),
      // 链接
      'a': Style(
        color: baseLinkColor,
        textDecoration: TextDecoration.none,
      ),
      // 加粗
      'strong': Style(
        fontWeight: FontWeight.bold,
        color: baseTextColor,
      ),
      // 斜体
      'em': Style(
        fontStyle: FontStyle.italic,
        color: baseTextColor,
      ),
      // 删除线
      's': Style(
        textDecoration: TextDecoration.lineThrough,
        color: colorScheme.onSurfaceVariant,
      ),
      // 行内代码
      'code': Style(
        backgroundColor: baseCodeBg,
        padding: HtmlPaddings.symmetric(horizontal: 4, vertical: 2),
        fontFamily: 'monospace',
        fontSize: FontSize.small,
        color: colorScheme.primary,
      ),
      // 代码块
      'pre': Style(
        backgroundColor: baseCodeBg,
        padding: HtmlPaddings.all(12),
        margin: Margins.only(bottom: 12),
      ),
      'pre code': Style(
        backgroundColor: Colors.transparent,
        padding: HtmlPaddings.zero,
        fontFamily: 'monospace',
        fontSize: FontSize.small,
        color: baseTextColor,
      ),
      // 引用块
      'blockquote': Style(
        border: Border(
          left: BorderSide(
            color: baseQuoteBorder,
            width: 4,
          ),
        ),
        padding: HtmlPaddings.only(left: 12),
        margin: Margins.only(bottom: 12, left: 0),
        backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      'blockquote p': Style(
        margin: Margins.zero,
        color: colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ),
      // 无序列表
      'ul': Style(
        margin: Margins.only(bottom: 12, left: 16),
        padding: HtmlPaddings.zero,
        listStyleType: ListStyleType.disc,
      ),
      'ul li': Style(
        margin: Margins.only(bottom: 4),
        color: baseTextColor,
      ),
      // 有序列表
      'ol': Style(
        margin: Margins.only(bottom: 12, left: 16),
        padding: HtmlPaddings.zero,
        listStyleType: ListStyleType.decimal,
      ),
      'ol li': Style(
        margin: Margins.only(bottom: 4),
        color: baseTextColor,
      ),
      // 分割线
      'hr': Style(
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        margin: Margins.symmetric(vertical: 16),
      ),
      // 图片
      'img': Style(
        width: Width.auto(),
        height: Height.auto(),
        margin: Margins.only(bottom: 12),
      ),
    };
  }

  /// 将 Markdown 转换为 HTML
  ///
  /// [markdown] Markdown 文本
  /// 返回 HTML 字符串
  String _markdownToHtml(String markdown) {
    String html = markdown;

    // 转义 HTML 特殊字符
    html = _escapeHtml(html);

    // 处理代码块（必须在处理其他内联元素之前）
    html = _processCodeBlocks(html);

    // 处理行内代码
    html = _processInlineCode(html);

    // 处理标题
    html = _processHeadings(html);

    // 处理加粗
    html = _processBold(html);

    // 处理斜体
    html = _processItalic(html);

    // 处理删除线
    html = _processStrikethrough(html);

    // 处理引用
    html = _processBlockquotes(html);

    // 处理无序列表
    html = _processUnorderedLists(html);

    // 处理有序列表
    html = _processOrderedLists(html);

    // 处理分割线
    html = _processHorizontalRules(html);

    // 处理链接
    html = _processLinks(html);

    // 处理图片
    html = _processImages(html);

    // 处理段落和换行
    html = _processParagraphs(html);

    return '<body>$html</body>';
  }

  /// 转义 HTML 特殊字符
  String _escapeHtml(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }

  /// 处理代码块
  String _processCodeBlocks(String text) {
    final regex = RegExp(r'```(\w*)\n([\s\S]*?)```', multiLine: true);
    return text.replaceAllMapped(regex, (match) {
      final language = match.group(1) ?? '';
      final code = match.group(2) ?? '';
      return '<pre><code class="language-$language">$code</code></pre>';
    });
  }

  /// 处理行内代码
  String _processInlineCode(String text) {
    final regex = RegExp(r'`([^`]+)`');
    return text.replaceAllMapped(regex, (match) {
      final code = match.group(1) ?? '';
      return '<code>$code</code>';
    });
  }

  /// 处理标题
  String _processHeadings(String text) {
    // H1
    text = text.replaceAllMapped(
      RegExp(r'^# (.+)$', multiLine: true),
      (match) => '<h1>${match.group(1)}</h1>',
    );
    // H2
    text = text.replaceAllMapped(
      RegExp(r'^## (.+)$', multiLine: true),
      (match) => '<h2>${match.group(1)}</h2>',
    );
    // H3
    text = text.replaceAllMapped(
      RegExp(r'^### (.+)$', multiLine: true),
      (match) => '<h3>${match.group(1)}</h3>',
    );
    // H4
    text = text.replaceAllMapped(
      RegExp(r'^#### (.+)$', multiLine: true),
      (match) => '<h4>${match.group(1)}</h4>',
    );
    // H5
    text = text.replaceAllMapped(
      RegExp(r'^##### (.+)$', multiLine: true),
      (match) => '<h5>${match.group(1)}</h5>',
    );
    // H6
    text = text.replaceAllMapped(
      RegExp(r'^###### (.+)$', multiLine: true),
      (match) => '<h6>${match.group(1)}</h6>',
    );
    return text;
  }

  /// 处理加粗
  String _processBold(String text) {
    // **text** 或 __text__
    text = text.replaceAllMapped(
      RegExp(r'\*\*(.+?)\*\*'),
      (match) => '<strong>${match.group(1)}</strong>',
    );
    text = text.replaceAllMapped(
      RegExp(r'__(.+?)__'),
      (match) => '<strong>${match.group(1)}</strong>',
    );
    return text;
  }

  /// 处理斜体
  String _processItalic(String text) {
    // *text* 或 _text_
    text = text.replaceAllMapped(
      RegExp(r'\*(.+?)\*'),
      (match) => '<em>${match.group(1)}</em>',
    );
    text = text.replaceAllMapped(
      RegExp(r'_(.+?)_'),
      (match) => '<em>${match.group(1)}</em>',
    );
    return text;
  }

  /// 处理删除线
  String _processStrikethrough(String text) {
    // ~~text~~
    return text.replaceAllMapped(
      RegExp(r'~~(.+?)~~'),
      (match) => '<s>${match.group(1)}</s>',
    );
  }

  /// 处理引用
  String _processBlockquotes(String text) {
    final lines = text.split('\n');
    final result = <String>[];
    var inBlockquote = false;
    var blockquoteContent = <String>[];

    for (final line in lines) {
      if (line.startsWith('> ')) {
        if (!inBlockquote) {
          inBlockquote = true;
          blockquoteContent = [];
        }
        blockquoteContent.add(line.substring(2));
      } else {
        if (inBlockquote) {
          result.add('<blockquote><p>${blockquoteContent.join('<br>')}</p></blockquote>');
          inBlockquote = false;
        }
        result.add(line);
      }
    }

    if (inBlockquote) {
      result.add('<blockquote><p>${blockquoteContent.join('<br>')}</p></blockquote>');
    }

    return result.join('\n');
  }

  /// 处理无序列表
  String _processUnorderedLists(String text) {
    final lines = text.split('\n');
    final result = <String>[];
    var inList = false;
    var listItems = <String>[];

    for (final line in lines) {
      final match = RegExp(r'^[\s]*[-*+] (.+)$').firstMatch(line);
      if (match != null) {
        if (!inList) {
          inList = true;
          listItems = [];
        }
        listItems.add(match.group(1)!);
      } else {
        if (inList) {
          result.add('<ul>${listItems.map((item) => '<li>$item</li>').join()}</ul>');
          inList = false;
        }
        result.add(line);
      }
    }

    if (inList) {
      result.add('<ul>${listItems.map((item) => '<li>$item</li>').join()}</ul>');
    }

    return result.join('\n');
  }

  /// 处理有序列表
  String _processOrderedLists(String text) {
    final lines = text.split('\n');
    final result = <String>[];
    var inList = false;
    var listItems = <String>[];

    for (final line in lines) {
      final match = RegExp(r'^[\s]*\d+\. (.+)$').firstMatch(line);
      if (match != null) {
        if (!inList) {
          inList = true;
          listItems = [];
        }
        listItems.add(match.group(1)!);
      } else {
        if (inList) {
          result.add('<ol>${listItems.map((item) => '<li>$item</li>').join()}</ol>');
          inList = false;
        }
        result.add(line);
      }
    }

    if (inList) {
      result.add('<ol>${listItems.map((item) => '<li>$item</li>').join()}</ol>');
    }

    return result.join('\n');
  }

  /// 处理分割线
  String _processHorizontalRules(String text) {
    return text.replaceAllMapped(
      RegExp(r'^[\s]*[-*_]{3,}[\s]*$', multiLine: true),
      (match) => '<hr>',
    );
  }

  /// 处理链接
  String _processLinks(String text) {
    // [text](url)
    return text.replaceAllMapped(
      RegExp(r'\[([^\]]+)\]\(([^)]+)\)'),
      (match) => '<a href="${match.group(2)}">${match.group(1)}</a>',
    );
  }

  /// 处理图片
  String _processImages(String text) {
    // ![alt](url)
    return text.replaceAllMapped(
      RegExp(r'!\[([^\]]*)\]\(([^)]+)\)'),
      (match) => '<img src="${match.group(2)}" alt="${match.group(1)}">',
    );
  }

  /// 处理段落
  String _processParagraphs(String text) {
    final blocks = text.split('\n\n');
    final result = <String>[];

    for (final block in blocks) {
      final trimmed = block.trim();
      if (trimmed.isEmpty) continue;

      // 如果已经是块级元素，不添加段落标签
      if (trimmed.startsWith('<h') ||
          trimmed.startsWith('<p>') ||
          trimmed.startsWith('<ul>') ||
          trimmed.startsWith('<ol>') ||
          trimmed.startsWith('<pre>') ||
          trimmed.startsWith('<blockquote>') ||
          trimmed.startsWith('<hr>')) {
        result.add(trimmed);
      } else {
        // 处理换行
        final withBreaks = trimmed.replaceAll('\n', '<br>');
        result.add('<p>$withBreaks</p>');
      }
    }

    return result.join('\n');
  }
}

/// 简化版 Markdown 预览
///
/// 用于展示简单的 Markdown 内容，性能更好
class SimpleMarkdownPreview extends StatelessWidget {
  /// Markdown 文本
  final String markdownText;

  /// 空内容提示
  final String emptyHint;

  /// 最大行数
  final int? maxLines;

  /// 构造函数
  const SimpleMarkdownPreview({
    super.key,
    required this.markdownText,
    this.emptyHint = '暂无内容',
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    if (markdownText.trim().isEmpty) {
      return _buildEmptyState(context);
    }

    // 简化处理：只处理最基本的 Markdown 语法
    final spans = _parseMarkdown(context, markdownText);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Text.rich(
        TextSpan(children: spans),
        maxLines: maxLines,
        overflow: maxLines != null ? TextOverflow.ellipsis : TextOverflow.clip,
      ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text(
          emptyHint,
          style: TextStyle(
            color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  /// 解析 Markdown 为 TextSpan 列表
  List<InlineSpan> _parseMarkdown(BuildContext context, String text) {
    final colorScheme = Theme.of(context).colorScheme;
    final spans = <InlineSpan>[];

    // 简单的正则表达式匹配
    final regex = RegExp(
      r'(\*\*[^*]+\*\*)'  // 加粗
      r'|(\*[^*]+\*)'     // 斜体
      r'|(`[^`]+`)'       // 行内代码
      r'|(~~[^~]+~~)',    // 删除线
      multiLine: true,
    );

    int lastEnd = 0;
    for (final match in regex.allMatches(text)) {
      // 添加匹配前的普通文本
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: TextStyle(color: colorScheme.onSurface),
        ));
      }

      final matchedText = match.group(0)!;

      // 判断匹配类型
      if (matchedText.startsWith('**')) {
        // 加粗
        spans.add(TextSpan(
          text: matchedText.substring(2, matchedText.length - 2),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ));
      } else if (matchedText.startsWith('*')) {
        // 斜体
        spans.add(TextSpan(
          text: matchedText.substring(1, matchedText.length - 1),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontStyle: FontStyle.italic,
          ),
        ));
      } else if (matchedText.startsWith('`')) {
        // 行内代码
        spans.add(TextSpan(
          text: matchedText.substring(1, matchedText.length - 1),
          style: TextStyle(
            color: colorScheme.primary,
            fontFamily: 'monospace',
            backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          ),
        ));
      } else if (matchedText.startsWith('~~')) {
        // 删除线
        spans.add(TextSpan(
          text: matchedText.substring(2, matchedText.length - 2),
          style: TextStyle(
            color: colorScheme.onSurfaceVariant,
            decoration: TextDecoration.lineThrough,
          ),
        ));
      }

      lastEnd = match.end;
    }

    // 添加剩余文本
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: TextStyle(color: colorScheme.onSurface),
      ));
    }

    return spans;
  }
}
