import 'package:flutter/material.dart';

/// 空状态组件
///
/// 用于展示列表为空、搜索无结果等场景
/// 支持自定义图标、文字和按钮
class EmptyWidget extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标题文字
  final String title;

  /// 副标题/描述文字
  final String? subtitle;

  /// 按钮文字
  final String? buttonText;

  /// 按钮点击回调
  final VoidCallback? onButtonPressed;

  /// 图标大小
  final double iconSize;

  /// 图标颜色
  final Color? iconColor;

  /// 构造函数
  ///
  /// [icon] 图标，默认 Icons.inbox
  /// [title] 标题文字（必填）
  /// [subtitle] 副标题/描述文字
  /// [buttonText] 按钮文字
  /// [onButtonPressed] 按钮点击回调
  /// [iconSize] 图标大小，默认 80
  /// [iconColor] 图标颜色
  const EmptyWidget({
    super.key,
    this.icon = Icons.inbox,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.onButtonPressed,
    this.iconSize = 80,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final defaultIconColor = iconColor ?? colorScheme.primary.withOpacity(0.5);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: defaultIconColor,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onBackground,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subtitle!,
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              FilledButton(
                onPressed: onButtonPressed,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// 搜索为空组件
///
/// 专门用于搜索无结果的场景
class EmptySearchWidget extends StatelessWidget {
  /// 搜索关键词
  final String? keyword;

  /// 提示文字
  final String? message;

  /// 构造函数
  ///
  /// [keyword] 搜索关键词
  /// [message] 提示文字，默认 "没有找到相关内容"
  const EmptySearchWidget({
    super.key,
    this.keyword,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final defaultMessage = message ??
        (keyword != null && keyword!.isNotEmpty
            ? '没有找到与 "$keyword" 相关的内容'
            : '请输入搜索关键词');

    return EmptyWidget(
      icon: Icons.search_off,
      title: '搜索无结果',
      subtitle: defaultMessage,
    );
  }
}

/// 网络为空组件
///
/// 专门用于网络请求返回空数据的场景
class EmptyNetworkWidget extends StatelessWidget {
  /// 提示文字
  final String? message;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 构造函数
  ///
  /// [message] 提示文字，默认 "暂无数据"
  /// [onRetry] 重试回调
  const EmptyNetworkWidget({
    super.key,
    this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      icon: Icons.cloud_off,
      title: '暂无数据',
      subtitle: message ?? '当前没有可显示的内容',
      buttonText: onRetry != null ? '刷新' : null,
      onButtonPressed: onRetry,
    );
  }
}

/// 通知为空组件
///
/// 专门用于通知列表为空的场景
class EmptyNotificationWidget extends StatelessWidget {
  /// 提示文字
  final String? message;

  /// 构造函数
  ///
  /// [message] 提示文字，默认 "暂无通知"
  const EmptyNotificationWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      icon: Icons.notifications_none,
      title: '暂无通知',
      subtitle: message ?? '当您收到新通知时，会在这里显示',
    );
  }
}

/// 收藏为空组件
///
/// 专门用于收藏列表为空的场景
class EmptyFavoriteWidget extends StatelessWidget {
  /// 提示文字
  final String? message;

  /// 去浏览回调
  final VoidCallback? onBrowse;

  /// 构造函数
  ///
  /// [message] 提示文字，默认 "暂无收藏内容"
  /// [onBrowse] 去浏览回调
  const EmptyFavoriteWidget({
    super.key,
    this.message,
    this.onBrowse,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      icon: Icons.favorite_border,
      title: '暂无收藏',
      subtitle: message ?? '您收藏的内容会在这里显示',
      buttonText: onBrowse != null ? '去浏览' : null,
      onButtonPressed: onBrowse,
    );
  }
}

/// 消息为空组件
///
/// 专门用于消息列表为空的场景
class EmptyMessageWidget extends StatelessWidget {
  /// 提示文字
  final String? message;

  /// 构造函数
  ///
  /// [message] 提示文字，默认 "暂无消息"
  const EmptyMessageWidget({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(
      icon: Icons.chat_bubble_outline,
      title: '暂无消息',
      subtitle: message ?? '当您收到新消息时，会在这里显示',
    );
  }
}
