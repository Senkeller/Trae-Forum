import 'package:flutter/material.dart';

/// 可折叠文本组件
///
/// 当文本内容超过指定行数时，显示折叠状态并提供展开/收起功能
class ExpandableText extends StatefulWidget {
  /// 文本内容
  final String text;

  /// 最大显示行数（折叠状态）
  final int maxLines;

  /// 文本样式
  final TextStyle? style;

  /// 展开按钮文本
  final String expandText;

  /// 收起按钮文本
  final String collapseText;

  /// 按钮文本样式
  final TextStyle? buttonStyle;

  /// 按钮颜色
  final Color? buttonColor;

  /// 是否默认展开
  final bool initiallyExpanded;

  /// 内容变化回调
  final ValueChanged<bool>? onExpandedChanged;

  /// 构造函数
  const ExpandableText({
    super.key,
    required this.text,
    this.maxLines = 6,
    this.style,
    this.expandText = '展开',
    this.collapseText = '收起',
    this.buttonStyle,
    this.buttonColor,
    this.initiallyExpanded = false,
    this.onExpandedChanged,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  /// 是否已展开
  late bool _isExpanded;

  /// 是否需要折叠（文本是否超过最大行数）
  bool _needsCollapse = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(ExpandableText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      // 内容变化时重置展开状态
      setState(() {
        _isExpanded = widget.initiallyExpanded;
        _needsCollapse = false;
      });
    }
  }

  /// 切换展开/折叠状态
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onExpandedChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final defaultStyle = textTheme.bodyMedium?.copyWith(
      color: colorScheme.onSurface,
      height: 1.5,
    );

    final effectiveStyle = widget.style ?? defaultStyle;

    final defaultButtonStyle = textTheme.bodyMedium?.copyWith(
      color: widget.buttonColor ?? colorScheme.primary,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );

    final effectiveButtonStyle = widget.buttonStyle ?? defaultButtonStyle;

    return LayoutBuilder(
      builder: (context, constraints) {
        // 测量文本是否需要折叠
        final textSpan = TextSpan(
          text: widget.text,
          style: effectiveStyle,
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.start,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);
        _needsCollapse = textPainter.didExceedMaxLines;

        // 如果不需要折叠，直接显示全部文本
        if (!_needsCollapse) {
          return Text(
            widget.text,
            style: effectiveStyle,
          );
        }

        // 需要折叠的情况
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // 文本内容
            _isExpanded
                ? Text(
                    widget.text,
                    style: effectiveStyle,
                  )
                : Text(
                    widget.text,
                    style: effectiveStyle,
                    maxLines: widget.maxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
            // 展开/收起按钮
            const SizedBox(height: 4),
            GestureDetector(
              onTap: _toggleExpanded,
              child: Text(
                _isExpanded ? widget.collapseText : widget.expandText,
                style: effectiveButtonStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// HTML 内容可折叠组件
///
/// 用于显示 HTML 内容，支持超过指定行数时折叠
class ExpandableHtml extends StatefulWidget {
  /// HTML 内容
  final String htmlData;

  /// 最大显示行数（折叠状态）
  final int maxLines;

  /// 展开按钮文本
  final String expandText;

  /// 收起按钮文本
  final String collapseText;

  /// 按钮文本样式
  final TextStyle? buttonStyle;

  /// 按钮颜色
  final Color? buttonColor;

  /// 是否默认展开
  final bool initiallyExpanded;

  /// HTML 样式配置
  final Map<String, dynamic>? htmlStyle;

  /// HTML 扩展
  final List<dynamic>? htmlExtensions;

  /// 构造函数
  const ExpandableHtml({
    super.key,
    required this.htmlData,
    this.maxLines = 6,
    this.expandText = '展开',
    this.collapseText = '收起',
    this.buttonStyle,
    this.buttonColor,
    this.initiallyExpanded = false,
    this.htmlStyle,
    this.htmlExtensions,
  });

  @override
  State<ExpandableHtml> createState() => _ExpandableHtmlState();
}

class _ExpandableHtmlState extends State<ExpandableHtml> {
  /// 是否已展开
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(ExpandableHtml oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.htmlData != widget.htmlData) {
      setState(() {
        _isExpanded = widget.initiallyExpanded;
      });
    }
  }

  /// 切换展开/折叠状态
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final defaultButtonStyle = textTheme.bodyMedium?.copyWith(
      color: widget.buttonColor ?? colorScheme.primary,
      fontWeight: FontWeight.w600,
      height: 1.5,
    );

    final effectiveButtonStyle = widget.buttonStyle ?? defaultButtonStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // HTML 内容容器
        _isExpanded
            ? _buildHtmlContent(context)
            : _buildCollapsedContent(context),
        // 展开/收起按钮
        const SizedBox(height: 4),
        GestureDetector(
          onTap: _toggleExpanded,
          child: Text(
            _isExpanded ? widget.collapseText : widget.expandText,
            style: effectiveButtonStyle,
          ),
        ),
      ],
    );
  }

  /// 构建展开的 HTML 内容
  Widget _buildHtmlContent(BuildContext context) {
    // 这里使用 flutter_html 或其他 HTML 渲染组件
    // 由于需要 flutter_html 包，这里提供一个占位实现
    // 实际使用时需要导入 flutter_html
    return Container();
  }

  /// 构建折叠的 HTML 内容
  Widget _buildCollapsedContent(BuildContext context) {
    // 折叠状态下限制高度
    return Container();
  }
}
