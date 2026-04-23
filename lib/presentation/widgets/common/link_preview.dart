import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'cached_image.dart';

/// 链接预览卡片组件
///
/// 用于展示链接的标题、描述、图标等信息，点击可打开链接
class LinkPreview extends StatelessWidget {
  /// 链接地址
  final String url;

  /// 链接标题
  final String? title;

  /// 链接描述
  final String? description;

  /// 链接图标/图片 URL
  final String? imageUrl;

  /// 网站域名
  final String? domain;

  /// 点击回调
  final VoidCallback? onTap;

  /// 圆角半径
  final double borderRadius;

  /// 背景颜色
  final Color? backgroundColor;

  /// 是否显示边框
  final bool showBorder;

  /// 边框颜色
  final Color? borderColor;

  /// 卡片高度
  final double? height;

  /// 是否紧凑模式
  final bool compact;

  /// 构造函数
  ///
  /// [url] 链接地址（必填）
  /// [title] 链接标题
  /// [description] 链接描述
  /// [imageUrl] 链接图标/图片 URL
  /// [domain] 网站域名
  /// [onTap] 点击回调
  /// [borderRadius] 圆角半径，默认 8
  /// [backgroundColor] 背景颜色
  /// [showBorder] 是否显示边框，默认 true
  /// [borderColor] 边框颜色
  /// [height] 卡片高度
  /// [compact] 是否紧凑模式，默认 false
  const LinkPreview({
    super.key,
    required this.url,
    this.title,
    this.description,
    this.imageUrl,
    this.domain,
    this.onTap,
    this.borderRadius = 8,
    this.backgroundColor,
    this.showBorder = true,
    this.borderColor,
    this.height,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final bgColor = backgroundColor ??
        (colorScheme.brightness == Brightness.light
            ? const Color(0xFFF5F5F5)
            : const Color(0xFF2C2C2C));

    final bdColor = borderColor ??
        (colorScheme.brightness == Brightness.light
            ? const Color(0xFFE0E0E0)
            : const Color(0xFF424242));

    return GestureDetector(
      onTap: onTap ?? () => _openUrl(context),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: showBorder
              ? Border.all(
                  color: bdColor,
                  width: 1,
                )
              : null,
        ),
        child: compact ? _buildCompactLayout(context) : _buildNormalLayout(context),
      ),
    );
  }

  /// 构建普通布局
  ///
  /// [context] BuildContext
  /// 返回 Widget
  Widget _buildNormalLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // 左侧图片
        if (imageUrl != null) ...[
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(borderRadius),
            ),
            child: SizedBox(
              width: 100,
              height: double.infinity,
              child: CachedImage(
                imageUrl: imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        // 右侧内容
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 标题
                if (title != null) ...[
                  Text(
                    title!,
                    style: textTheme.titleSmall?.copyWith(
                      color: colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                ],
                // 描述
                if (description != null) ...[
                  Text(
                    description!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                ],
                // 域名
                Text(
                  domain ?? _extractDomain(url),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// 构建紧凑布局
  ///
  /// [context] BuildContext
  /// 返回 Widget
  Widget _buildCompactLayout(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          // 图标
          if (imageUrl != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CachedImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
          ] else ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.link,
                color: colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
          ],
          // 内容
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 标题
                if (title != null)
                  Text(
                    title!,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onBackground,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                // 域名
                Text(
                  domain ?? _extractDomain(url),
                  style: textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // 箭头
          Icon(
            Icons.arrow_forward_ios,
            color: colorScheme.onSurfaceVariant,
            size: 16,
          ),
        ],
      ),
    );
  }

  /// 从 URL 提取域名
  ///
  /// [url] 链接地址
  /// 返回域名字符串
  String _extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (e) {
      return url;
    }
  }

  /// 打开链接
  ///
  /// [context] BuildContext
  Future<void> _openUrl(BuildContext context) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// 链接预览数据模型
///
/// 用于存储链接预览的相关信息
class LinkPreviewData {
  /// 链接地址
  final String url;

  /// 链接标题
  final String? title;

  /// 链接描述
  final String? description;

  /// 链接图标/图片 URL
  final String? imageUrl;

  /// 网站域名
  final String? domain;

  /// 构造函数
  ///
  /// [url] 链接地址（必填）
  /// [title] 链接标题
  /// [description] 链接描述
  /// [imageUrl] 链接图标/图片 URL
  /// [domain] 网站域名
  const LinkPreviewData({
    required this.url,
    this.title,
    this.description,
    this.imageUrl,
    this.domain,
  });

  /// 从 JSON 创建实例
  ///
  /// [json] JSON 数据
  /// 返回 LinkPreviewData 实例
  factory LinkPreviewData.fromJson(Map<String, dynamic> json) {
    return LinkPreviewData(
      url: json['url'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      domain: json['domain'] as String?,
    );
  }

  /// 转换为 JSON
  ///
  /// 返回 Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'domain': domain,
    };
  }

  /// 复制并修改属性
  ///
  /// [url] 链接地址
  /// [title] 链接标题
  /// [description] 链接描述
  /// [imageUrl] 链接图标/图片 URL
  /// [domain] 网站域名
  /// 返回新的 LinkPreviewData 实例
  LinkPreviewData copyWith({
    String? url,
    String? title,
    String? description,
    String? imageUrl,
    String? domain,
  }) {
    return LinkPreviewData(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      domain: domain ?? this.domain,
    );
  }
}

/// 链接预览加载器
///
/// 用于异步加载链接预览信息
class LinkPreviewLoader extends StatelessWidget {
  /// 链接地址
  final String url;

  /// 加载中的占位组件
  final Widget? loadingWidget;

  /// 加载失败的组件
  final Widget? errorWidget;

  /// 链接预览数据
  final LinkPreviewData? data;

  /// 是否正在加载
  final bool isLoading;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  ///
  /// [url] 链接地址（必填）
  /// [data] 链接预览数据
  /// [isLoading] 是否正在加载，默认 false
  /// [loadingWidget] 加载中的占位组件
  /// [errorWidget] 加载失败的组件
  /// [onTap] 点击回调
  const LinkPreviewLoader({
    super.key,
    required this.url,
    this.data,
    this.isLoading = false,
    this.loadingWidget,
    this.errorWidget,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingWidget ?? _buildLoadingWidget(context);
    }

    if (data == null) {
      return errorWidget ?? _buildErrorWidget(context);
    }

    return LinkPreview(
      url: data!.url,
      title: data!.title,
      description: data!.description,
      imageUrl: data!.imageUrl,
      domain: data!.domain,
      onTap: onTap,
    );
  }

  /// 构建加载中组件
  ///
  /// [context] BuildContext
  /// 返回 Widget
  Widget _buildLoadingWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }

  /// 构建错误组件
  ///
  /// [context] BuildContext
  /// 返回 Widget
  Widget _buildErrorWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.outline.withOpacity(0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Icon(
              Icons.link,
              color: colorScheme.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _extractDomain(url),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onBackground,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '点击打开链接',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.open_in_new,
              color: colorScheme.onSurfaceVariant,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  /// 从 URL 提取域名
  ///
  /// [url] 链接地址
  /// 返回域名字符串
  String _extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host.replaceFirst('www.', '');
    } catch (e) {
      return url;
    }
  }
}

/// 多链接预览列表
///
/// 用于展示多个链接预览
class LinkPreviewList extends StatelessWidget {
  /// 链接预览数据列表
  final List<LinkPreviewData> links;

  /// 链接点击回调
  final Function(String url)? onLinkTap;

  /// 项间距
  final double spacing;

  /// 是否紧凑模式
  final bool compact;

  /// 构造函数
  ///
  /// [links] 链接预览数据列表（必填）
  /// [onLinkTap] 链接点击回调
  /// [spacing] 项间距，默认 8
  /// [compact] 是否紧凑模式，默认 false
  const LinkPreviewList({
    super.key,
    required this.links,
    this.onLinkTap,
    this.spacing = 8,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: links.asMap().entries.map((entry) {
        final index = entry.key;
        final link = entry.value;

        return Padding(
          padding: EdgeInsets.only(
            bottom: index < links.length - 1 ? spacing : 0,
          ),
          child: LinkPreview(
            url: link.url,
            title: link.title,
            description: link.description,
            imageUrl: link.imageUrl,
            domain: link.domain,
            compact: compact,
            onTap: () => onLinkTap?.call(link.url),
          ),
        );
      }).toList(),
    );
  }
}
