import 'package:flutter/material.dart';

/// 表情文本组件
///
/// 支持在文本中插入表情符号，支持自定义表情大小和样式
class EmojiText extends StatelessWidget {
  /// 文本内容
  final String text;

  /// 文本样式
  final TextStyle? style;

  /// 表情大小
  final double emojiSize;

  /// 最大行数
  final int? maxLines;

  /// 文本溢出处理
  final TextOverflow? overflow;

  /// 文本对齐方式
  final TextAlign? textAlign;

  /// 是否支持选择复制
  final bool selectable;

  /// 表情匹配正则表达式
  final RegExp? emojiPattern;

  /// 自定义表情映射
  final Map<String, Widget>? customEmojis;

  /// 构造函数
  ///
  /// [text] 文本内容（必填）
  /// [style] 文本样式
  /// [emojiSize] 表情大小，默认 20
  /// [maxLines] 最大行数
  /// [overflow] 文本溢出处理
  /// [textAlign] 文本对齐方式
  /// [selectable] 是否支持选择复制，默认 false
  /// [emojiPattern] 自定义表情匹配正则
  /// [customEmojis] 自定义表情映射
  const EmojiText({
    super.key,
    required this.text,
    this.style,
    this.emojiSize = 20,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.selectable = false,
    this.emojiPattern,
    this.customEmojis,
  });

  @override
  Widget build(BuildContext context) {
    final spans = _buildTextSpans(context);

    if (selectable) {
      return SelectableText.rich(
        TextSpan(children: spans),
        maxLines: maxLines,
        textAlign: textAlign,
        style: style,
      );
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      textAlign: textAlign,
    );
  }

  /// 构建文本 Span 列表
  ///
  /// [context] BuildContext
  /// 返回 InlineSpan 列表
  List<InlineSpan> _buildTextSpans(BuildContext context) {
    final spans = <InlineSpan>[];
    final defaultStyle = DefaultTextStyle.of(context).style.merge(style);

    // 使用默认或自定义的表情匹配正则
    final pattern = emojiPattern ?? _defaultEmojiPattern;

    int lastEnd = 0;
    for (final match in pattern.allMatches(text)) {
      // 添加匹配前的普通文本
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: defaultStyle,
        ));
      }

      final emoji = match.group(0)!;

      // 检查是否有自定义表情
      if (customEmojis != null && customEmojis!.containsKey(emoji)) {
        spans.add(WidgetSpan(
          child: SizedBox(
            width: emojiSize,
            height: emojiSize,
            child: customEmojis![emoji],
          ),
          alignment: PlaceholderAlignment.middle,
        ));
      } else {
        // 使用系统表情
        spans.add(WidgetSpan(
          child: Text(
            emoji,
            style: defaultStyle.copyWith(
              fontSize: emojiSize,
              height: 1.0,
            ),
          ),
          alignment: PlaceholderAlignment.middle,
        ));
      }

      lastEnd = match.end;
    }

    // 添加剩余文本
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: defaultStyle,
      ));
    }

    return spans;
  }

  /// 默认表情匹配正则
  /// 匹配 Unicode 表情符号范围
  static final RegExp _defaultEmojiPattern = RegExp(
    r'[\u{1F600}-\u{1F64F}' // 表情符号
    r'\u{1F300}-\u{1F5FF}' // 符号和象形文字
    r'\u{1F680}-\u{1F6FF}' // 交通和地图符号
    r'\u{1F1E0}-\u{1F1FF}' // 国旗
    r'\u{2600}-\u{26FF}' // 杂项符号
    r'\u{2700}-\u{27BF}' // 装饰符号
    r'\u{1F900}-\u{1F9FF}' // 补充符号和象形文字
    r'\u{1F018}-\u{1F270}' // 麻将和扑克牌
    r'\u{238C}\u{238D}' // 其他符号
    r'\u{1F3FB}-\u{1F3FF}' // 肤色修饰符
    r']',
    unicode: true,
  );
}

/// 富表情文本组件
///
/// 支持系统表情、自定义图片表情、@用户、#话题# 等多种高亮样式
class RichEmojiText extends StatelessWidget {
  /// 文本内容
  final String text;

  /// 基础文本样式
  final TextStyle? style;

  /// 表情大小
  final double emojiSize;

  /// 链接颜色
  final Color? linkColor;

  /// @用户颜色
  final Color? mentionColor;

  /// #话题# 颜色
  final Color? topicColor;

  /// 最大行数
  final int? maxLines;

  /// 文本溢出处理
  final TextOverflow? overflow;

  /// 文本对齐方式
  final TextAlign? textAlign;

  /// 链接点击回调
  final Function(String url)? onLinkTap;

  /// @用户点击回调
  final Function(String username)? onMentionTap;

  /// #话题# 点击回调
  final Function(String topic)? onTopicTap;

  /// 自定义表情映射（key: 表情代码如 [微笑]，value: Widget）
  final Map<String, Widget>? customEmojis;

  /// 是否支持选择复制
  final bool selectable;

  /// 构造函数
  ///
  /// [text] 文本内容（必填）
  /// [style] 基础文本样式
  /// [emojiSize] 表情大小，默认 20
  /// [linkColor] 链接颜色
  /// [mentionColor] @用户颜色
  /// [topicColor] #话题# 颜色
  /// [maxLines] 最大行数
  /// [overflow] 文本溢出处理
  /// [textAlign] 文本对齐方式
  /// [onLinkTap] 链接点击回调
  /// [onMentionTap] @用户点击回调
  /// [onTopicTap] #话题# 点击回调
  /// [customEmojis] 自定义表情映射
  /// [selectable] 是否支持选择复制，默认 false
  const RichEmojiText({
    super.key,
    required this.text,
    this.style,
    this.emojiSize = 20,
    this.linkColor,
    this.mentionColor,
    this.topicColor,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.onLinkTap,
    this.onMentionTap,
    this.onTopicTap,
    this.customEmojis,
    this.selectable = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final spans = _buildTextSpans(context, colorScheme);

    if (selectable) {
      return SelectableText.rich(
        TextSpan(children: spans),
        maxLines: maxLines,
        textAlign: textAlign,
        style: style,
      );
    }

    return Text.rich(
      TextSpan(children: spans),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      textAlign: textAlign,
    );
  }

  /// 构建文本 Span 列表
  ///
  /// [context] BuildContext
  /// [colorScheme] 颜色方案
  /// 返回 InlineSpan 列表
  List<InlineSpan> _buildTextSpans(BuildContext context, ColorScheme colorScheme) {
    final spans = <InlineSpan>[];
    final defaultStyle = DefaultTextStyle.of(context).style.merge(style);

    // 正则表达式匹配：URL、@用户、#话题#、自定义表情 [表情名]、系统表情
    final regex = RegExp(
      r'(https?://[^\s]+)|(@[\w\u4e00-\u9fa5]+)|(#[^#\s]+#)|(\[[\w\u4e00-\u9fa5]+\])',
    );

    int lastEnd = 0;
    for (final match in regex.allMatches(text)) {
      // 添加匹配前的普通文本（需要处理系统表情）
      if (match.start > lastEnd) {
        final plainText = text.substring(lastEnd, match.start);
        spans.addAll(_parsePlainTextWithEmojis(plainText, defaultStyle));
      }

      final matchedText = match.group(0)!;

      // 判断匹配类型
      if (match.group(1) != null) {
        // URL
        spans.add(_buildLinkSpan(context, matchedText, defaultStyle, colorScheme));
      } else if (match.group(2) != null) {
        // @用户
        final username = matchedText.substring(1);
        spans.add(_buildMentionSpan(context, username, defaultStyle, colorScheme));
      } else if (match.group(3) != null) {
        // #话题#
        final topic = matchedText.substring(1, matchedText.length - 1);
        spans.add(_buildTopicSpan(context, topic, defaultStyle, colorScheme));
      } else if (match.group(4) != null) {
        // 自定义表情 [表情名]
        final emojiName = matchedText.substring(1, matchedText.length - 1);
        spans.add(_buildCustomEmojiSpan(emojiName, defaultStyle));
      }

      lastEnd = match.end;
    }

    // 添加剩余文本（需要处理系统表情）
    if (lastEnd < text.length) {
      final plainText = text.substring(lastEnd);
      spans.addAll(_parsePlainTextWithEmojis(plainText, defaultStyle));
    }

    return spans;
  }

  /// 解析普通文本中的系统表情
  ///
  /// [text] 普通文本
  /// [defaultStyle] 默认样式
  /// 返回 InlineSpan 列表
  List<InlineSpan> _parsePlainTextWithEmojis(String text, TextStyle defaultStyle) {
    final spans = <InlineSpan>[];

    int lastEnd = 0;
    for (final match in EmojiText._defaultEmojiPattern.allMatches(text)) {
      // 添加表情前的文本
      if (match.start > lastEnd) {
        spans.add(TextSpan(
          text: text.substring(lastEnd, match.start),
          style: defaultStyle,
        ));
      }

      // 添加表情
      final emoji = match.group(0)!;
      spans.add(WidgetSpan(
        child: Text(
          emoji,
          style: defaultStyle.copyWith(
            fontSize: emojiSize,
            height: 1.0,
          ),
        ),
        alignment: PlaceholderAlignment.middle,
      ));

      lastEnd = match.end;
    }

    // 添加剩余文本
    if (lastEnd < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastEnd),
        style: defaultStyle,
      ));
    }

    return spans;
  }

  /// 构建链接 Span
  ///
  /// [context] BuildContext
  /// [url] 链接地址
  /// [baseStyle] 基础样式
  /// [colorScheme] 颜色方案
  /// 返回 InlineSpan
  InlineSpan _buildLinkSpan(
    BuildContext context,
    String url,
    TextStyle baseStyle,
    ColorScheme colorScheme,
  ) {
    return WidgetSpan(
      child: GestureDetector(
        onTap: () => onLinkTap?.call(url),
        child: Text(
          url,
          style: baseStyle.copyWith(
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
  /// [colorScheme] 颜色方案
  /// 返回 InlineSpan
  InlineSpan _buildMentionSpan(
    BuildContext context,
    String username,
    TextStyle baseStyle,
    ColorScheme colorScheme,
  ) {
    return WidgetSpan(
      child: GestureDetector(
        onTap: () => onMentionTap?.call(username),
        child: Text(
          '@$username',
          style: baseStyle.copyWith(
            color: mentionColor ?? colorScheme.primary,
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
  /// [colorScheme] 颜色方案
  /// 返回 InlineSpan
  InlineSpan _buildTopicSpan(
    BuildContext context,
    String topic,
    TextStyle baseStyle,
    ColorScheme colorScheme,
  ) {
    return WidgetSpan(
      child: GestureDetector(
        onTap: () => onTopicTap?.call(topic),
        child: Text(
          '#$topic#',
          style: baseStyle.copyWith(
            color: topicColor ?? colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// 构建自定义表情 Span
  ///
  /// [emojiName] 表情名称
  /// [baseStyle] 基础样式
  /// 返回 InlineSpan
  InlineSpan _buildCustomEmojiSpan(String emojiName, TextStyle baseStyle) {
    if (customEmojis != null && customEmojis!.containsKey('[$emojiName]')) {
      return WidgetSpan(
        child: SizedBox(
          width: emojiSize,
          height: emojiSize,
          child: customEmojis!['[$emojiName]'],
        ),
        alignment: PlaceholderAlignment.middle,
      );
    }

    // 如果没有找到自定义表情，显示原始文本
    return TextSpan(
      text: '[$emojiName]',
      style: baseStyle,
    );
  }
}

/// 表情选择器组件
///
/// 用于展示和选择表情
class EmojiPicker extends StatelessWidget {
  /// 表情选择回调
  final Function(String emoji) onEmojiSelected;

  /// 自定义表情列表
  final List<String>? customEmojis;

  /// 每行显示的表情数量
  final int crossAxisCount;

  /// 表情大小
  final double emojiSize;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 构造函数
  ///
  /// [onEmojiSelected] 表情选择回调（必填）
  /// [customEmojis] 自定义表情列表
  /// [crossAxisCount] 每行显示的表情数量，默认 8
  /// [emojiSize] 表情大小，默认 32
  /// [padding] 内边距，默认 EdgeInsets.all(16)
  const EmojiPicker({
    super.key,
    required this.onEmojiSelected,
    this.customEmojis,
    this.crossAxisCount = 8,
    this.emojiSize = 32,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    final emojis = customEmojis ?? _defaultEmojis;

    return Container(
      padding: padding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1,
        ),
        itemCount: emojis.length,
        itemBuilder: (context, index) {
          final emoji = emojis[index];
          return GestureDetector(
            onTap: () => onEmojiSelected(emoji),
            child: Center(
              child: Text(
                emoji,
                style: TextStyle(
                  fontSize: emojiSize,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// 默认表情列表
  static final List<String> _defaultEmojis = [
    '😀', '😃', '😄', '😁', '😆', '😅', '😂', '🤣',
    '😊', '😇', '🙂', '🙃', '😉', '😌', '😍', '🥰',
    '😘', '😗', '😙', '😚', '😋', '😛', '😝', '😜',
    '🤪', '🤨', '🧐', '🤓', '😎', '🥸', '🤩', '🥳',
    '😏', '😒', '😞', '😔', '😟', '😕', '🙁', '☹️',
    '😣', '😖', '😫', '😩', '🥺', '😢', '😭', '😤',
    '😠', '😡', '🤬', '🤯', '😳', '🥵', '🥶', '😱',
    '😨', '😰', '😥', '😓', '🤗', '🤔', '🤭', '🤫',
    '🤥', '😶', '😐', '😑', '😬', '🙄', '😯', '😦',
    '👍', '👎', '👏', '🙌', '🤝', '🤞', '✌️', '🤟',
    '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
    '🔥', '⭐', '✨', '💯', '💢', '💥', '💫', '💦',
  ];
}

/// 图片表情组件
///
/// 用于展示自定义图片表情
class ImageEmoji extends StatelessWidget {
  /// 图片路径或 URL
  final String imagePath;

  /// 表情大小
  final double size;

  /// 是否网络图片
  final bool isNetwork;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  ///
  /// [imagePath] 图片路径或 URL（必填）
  /// [size] 表情大小，默认 24
  /// [isNetwork] 是否网络图片，默认 false
  /// [onTap] 点击回调
  const ImageEmoji({
    super.key,
    required this.imagePath,
    this.size = 24,
    this.isNetwork = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (isNetwork) {
      image = Image.network(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    } else {
      image = Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorWidget();
        },
      );
    }

    if (onTap != null) {
      image = GestureDetector(
        onTap: onTap,
        child: image,
      );
    }

    return image;
  }

  /// 构建错误组件
  ///
  /// 返回 Widget
  Widget _buildErrorWidget() {
    return Container(
      width: size,
      height: size,
      color: Colors.grey[300],
      child: Icon(
        Icons.image_not_supported,
        size: size * 0.6,
        color: Colors.grey[500],
      ),
    );
  }
}
