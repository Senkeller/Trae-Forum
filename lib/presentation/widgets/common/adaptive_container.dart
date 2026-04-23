import 'package:flutter/material.dart';

/// 自适应深浅色的容器组件
///
/// 根据当前主题自动调整背景色、文字颜色、边框颜色等
/// 支持自定义圆角、阴影、边框等样式
class AdaptiveContainer extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 圆角半径
  final double borderRadius;

  /// 背景色（如未设置则根据主题自动选择）
  final Color? backgroundColor;

  /// 边框颜色（如未设置则根据主题自动选择）
  final Color? borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 是否显示阴影
  final bool showShadow;

  /// 阴影颜色（如未设置则根据主题自动选择）
  final Color? shadowColor;

  /// 阴影模糊半径
  final double shadowBlurRadius;

  /// 阴影偏移
  final Offset shadowOffset;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 水波纹颜色
  final Color? splashColor;

  /// 是否裁剪子组件
  final bool clipChild;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 对齐方式
  final AlignmentGeometry? alignment;

  /// 构造函数
  ///
  /// [child] 子组件（必填）
  /// [padding] 内边距，默认 EdgeInsets.all(16)
  /// [margin] 外边距
  /// [borderRadius] 圆角半径，默认 12
  /// [backgroundColor] 背景色（如未设置则根据主题自动选择）
  /// [borderColor] 边框颜色
  /// [borderWidth] 边框宽度，默认 0
  /// [showShadow] 是否显示阴影，默认 false
  /// [shadowColor] 阴影颜色
  /// [shadowBlurRadius] 阴影模糊半径，默认 8
  /// [shadowOffset] 阴影偏移，默认 Offset(0, 2)
  /// [onTap] 点击回调
  /// [onLongPress] 长按回调
  /// [splashColor] 水波纹颜色
  /// [clipChild] 是否裁剪子组件，默认 true
  /// [width] 宽度
  /// [height] 高度
  /// [alignment] 对齐方式
  const AdaptiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 12,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.showShadow = false,
    this.shadowColor,
    this.shadowBlurRadius = 8,
    this.shadowOffset = const Offset(0, 2),
    this.onTap,
    this.onLongPress,
    this.splashColor,
    this.clipChild = true,
    this.width,
    this.height,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 确定背景色
    final bgColor = backgroundColor ?? colorScheme.surface;

    // 确定边框
    BoxBorder? border;
    if (borderWidth > 0 || borderColor != null) {
      border = Border.all(
        color: borderColor ?? colorScheme.outline.withOpacity(0.2),
        width: borderWidth > 0 ? borderWidth : 1,
      );
    }

    // 确定阴影
    List<BoxShadow>? shadows;
    if (showShadow) {
      shadows = [
        BoxShadow(
          color: shadowColor ??
              (Theme.of(context).brightness == Brightness.dark
                  ? Colors.black.withOpacity(0.3)
                  : Colors.black.withOpacity(0.1)),
          blurRadius: shadowBlurRadius,
          offset: shadowOffset,
        ),
      ];
    }

    // 构建容器装饰
    final decoration = BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border,
      boxShadow: shadows,
    );

    // 构建基础容器
    Widget container = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      alignment: alignment,
      decoration: decoration,
      child: child,
    );

    // 如果需要裁剪，添加裁剪
    if (clipChild) {
      container = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: container,
      );
    }

    // 如果有点击事件，添加 InkWell
    if (onTap != null || onLongPress != null) {
      container = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: splashColor ?? colorScheme.primary.withOpacity(0.1),
          child: container,
        ),
      );
    }

    return container;
  }
}

/// 自适应卡片容器
///
/// 专门用于展示卡片内容的自适应容器
class AdaptiveCard extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 圆角半径
  final double borderRadius;

  /// 背景色（如未设置则根据主题自动选择）
  final Color? backgroundColor;

  /// 是否显示阴影
  final bool showShadow;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 构造函数
  ///
  /// [child] 子组件（必填）
  /// [padding] 内边距，默认 EdgeInsets.all(16)
  /// [margin] 外边距，默认 EdgeInsets.symmetric(vertical: 4, horizontal: 16)
  /// [borderRadius] 圆角半径，默认 12
  /// [backgroundColor] 背景色（如未设置则根据主题自动选择）
  /// [showShadow] 是否显示阴影，默认 false
  /// [onTap] 点击回调
  /// [onLongPress] 长按回调
  /// [width] 宽度
  /// [height] 高度
  const AdaptiveCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    this.borderRadius = 12,
    this.backgroundColor,
    this.showShadow = false,
    this.onTap,
    this.onLongPress,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveContainer(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      showShadow: showShadow,
      onTap: onTap,
      onLongPress: onLongPress,
      child: child,
    );
  }
}

/// 自适应输入框容器
///
/// 专门用于包裹输入框的自适应容器
class AdaptiveInputContainer extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 圆角半径
  final double borderRadius;

  /// 背景色（如未设置则根据主题自动选择）
  final Color? backgroundColor;

  /// 边框颜色
  final Color? borderColor;

  /// 边框宽度
  final double borderWidth;

  /// 是否聚焦状态
  final bool isFocused;

  /// 是否错误状态
  final bool hasError;

  /// 宽度
  final double? width;

  /// 高度
  final double? height;

  /// 构造函数
  ///
  /// [child] 子组件（必填）
  /// [padding] 内边距，默认 EdgeInsets.symmetric(horizontal: 16, vertical: 12)
  /// [margin] 外边距
  /// [borderRadius] 圆角半径，默认 8
  /// [backgroundColor] 背景色（如未设置则根据主题自动选择）
  /// [borderColor] 边框颜色
  /// [borderWidth] 边框宽度，默认 0
  /// [isFocused] 是否聚焦状态，默认 false
  /// [hasError] 是否错误状态，默认 false
  /// [width] 宽度
  /// [height] 高度
  const AdaptiveInputContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.margin,
    this.borderRadius = 8,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
    this.isFocused = false,
    this.hasError = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 确定背景色
    final bgColor = backgroundColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF2C2C2C)
            : const Color(0xFFF5F5F5));

    // 确定边框颜色
    Color? finalBorderColor = borderColor;
    if (hasError) {
      finalBorderColor = colorScheme.error;
    } else if (isFocused) {
      finalBorderColor = colorScheme.primary;
    }

    return AdaptiveContainer(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      backgroundColor: bgColor,
      borderColor: finalBorderColor,
      borderWidth: hasError || isFocused ? 1 : borderWidth,
      clipChild: false,
      child: child,
    );
  }
}

/// 自适应列表项容器
///
/// 专门用于列表项的自适应容器
class AdaptiveListItem extends StatelessWidget {
  /// 子组件
  final Widget child;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 背景色（如未设置则根据主题自动选择）
  final Color? backgroundColor;

  /// 是否显示底部分割线
  final bool showDivider;

  /// 分割线颜色
  final Color? dividerColor;

  /// 分割线高度
  final double dividerHeight;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 是否选中状态
  final bool isSelected;

  /// 选中状态背景色
  final Color? selectedColor;

  /// 构造函数
  ///
  /// [child] 子组件（必填）
  /// [padding] 内边距，默认 EdgeInsets.symmetric(horizontal: 16, vertical: 12)
  /// [backgroundColor] 背景色（如未设置则根据主题自动选择）
  /// [showDivider] 是否显示底部分割线，默认 true
  /// [dividerColor] 分割线颜色
  /// [dividerHeight] 分割线高度，默认 0.5
  /// [onTap] 点击回调
  /// [onLongPress] 长按回调
  /// [isSelected] 是否选中状态，默认 false
  /// [selectedColor] 选中状态背景色
  const AdaptiveListItem({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.backgroundColor,
    this.showDivider = true,
    this.dividerColor,
    this.dividerHeight = 0.5,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // 确定背景色
    Color bgColor = backgroundColor ?? colorScheme.surface;
    if (isSelected) {
      bgColor = selectedColor ?? colorScheme.primaryContainer.withOpacity(0.3);
    }

    // 确定分割线颜色
    final divColor = dividerColor ?? colorScheme.outline.withOpacity(0.2);

    Widget item = Container(
      padding: padding,
      color: bgColor,
      child: child,
    );

    // 添加分割线
    if (showDivider) {
      item = Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          item,
          Divider(
            height: dividerHeight,
            thickness: dividerHeight,
            color: divColor,
            indent: padding is EdgeInsets
                ? (padding as EdgeInsets).left
                : null,
            endIndent: padding is EdgeInsets
                ? (padding as EdgeInsets).right
                : null,
          ),
        ],
      );
    }

    // 添加点击效果
    if (onTap != null || onLongPress != null) {
      item = InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: item,
      );
    }

    return item;
  }
}

/// 自适应分组合容器
///
/// 用于将多个列表项组合在一起，自动处理圆角和分割线
class AdaptiveGroupContainer extends StatelessWidget {
  /// 子组件列表
  final List<Widget> children;

  /// 外边距
  final EdgeInsetsGeometry margin;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 圆角半径
  final double borderRadius;

  /// 背景色（如未设置则根据主题自动选择）
  final Color? backgroundColor;

  /// 是否显示阴影
  final bool showShadow;

  /// 构造函数
  ///
  /// [children] 子组件列表（必填）
  /// [margin] 外边距，默认 EdgeInsets.symmetric(vertical: 8, horizontal: 16)
  /// [padding] 内边距
  /// [borderRadius] 圆角半径，默认 12
  /// [backgroundColor] 背景色（如未设置则根据主题自动选择）
  /// [showShadow] 是否显示阴影，默认 false
  const AdaptiveGroupContainer({
    super.key,
    required this.children,
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.padding,
    this.borderRadius = 12,
    this.backgroundColor,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = backgroundColor ?? colorScheme.surface;

    // 为子组件添加分割线
    final List<Widget> itemsWithDividers = [];
    for (int i = 0; i < children.length; i++) {
      itemsWithDividers.add(children[i]);
      if (i < children.length - 1) {
        itemsWithDividers.add(
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: colorScheme.outline.withOpacity(0.2),
          ),
        );
      }
    }

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: itemsWithDividers,
        ),
      ),
    );
  }
}

/// 自适应文本容器
///
/// 专门用于展示文本内容的自适应容器
class AdaptiveTextContainer extends StatelessWidget {
  /// 文本内容
  final String text;

  /// 文本样式
  final TextStyle? style;

  /// 内边距
  final EdgeInsetsGeometry padding;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 圆角半径
  final double borderRadius;

  /// 背景色（如未设置则根据主题自动选择）
  final Color? backgroundColor;

  /// 文本颜色（如未设置则根据主题自动选择）
  final Color? textColor;

  /// 对齐方式
  final TextAlign textAlign;

  /// 最大行数
  final int? maxLines;

  /// 溢出处理方式
  final TextOverflow? overflow;

  /// 构造函数
  ///
  /// [text] 文本内容（必填）
  /// [style] 文本样式
  /// [padding] 内边距，默认 EdgeInsets.all(12)
  /// [margin] 外边距
  /// [borderRadius] 圆角半径，默认 8
  /// [backgroundColor] 背景色（如未设置则根据主题自动选择）
  /// [textColor] 文本颜色（如未设置则根据主题自动选择）
  /// [textAlign] 对齐方式，默认 TextAlign.start
  /// [maxLines] 最大行数
  /// [overflow] 溢出处理方式
  const AdaptiveTextContainer({
    super.key,
    required this.text,
    this.style,
    this.padding = const EdgeInsets.all(12),
    this.margin,
    this.borderRadius = 8,
    this.backgroundColor,
    this.textColor,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 确定背景色
    final bgColor = backgroundColor ?? colorScheme.surfaceVariant.withOpacity(0.5);

    // 确定文本颜色
    final txtColor = textColor ?? colorScheme.onSurface;

    // 确定文本样式
    final textStyle = style?.copyWith(color: txtColor) ??
        textTheme.bodyMedium?.copyWith(color: txtColor);

    return AdaptiveContainer(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      backgroundColor: bgColor,
      child: Text(
        text,
        style: textStyle,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
