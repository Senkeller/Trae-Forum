import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '../../pages/common/image_preview_page.dart';

/// 图片画廊组件
///
/// 支持九宫格图片展示，点击打开预览，长按直接保存/分享等功能
/// 适配单图、四图、多图等不同布局场景
class ImageGallery extends StatelessWidget {
  /// 图片 URL 列表
  final List<String> imageUrls;

  /// 图片点击回调
  final Function(int index)? onImageTap;

  /// 图片长按回调
  final Function(int index)? onImageLongPress;

  /// 图片间距
  final double spacing;

  /// 圆角半径
  final double borderRadius;

  /// 单图宽高比
  final double singleImageAspectRatio;

  /// 是否启用预览
  final bool enablePreview;

  /// 最大显示图片数量
  final int maxDisplayCount;

  /// 是否启用长按快捷操作（直接保存/分享，不进入预览页）
  final bool enableQuickActions;

  /// 构造函数
  ///
  /// [imageUrls] 图片 URL 列表（必填）
  /// [onImageTap] 图片点击回调，参数为图片索引
  /// [onImageLongPress] 图片长按回调，参数为图片索引
  /// [spacing] 图片间距，默认 4
  /// [borderRadius] 圆角半径，默认 8
  /// [singleImageAspectRatio] 单图宽高比，默认 16/9
  /// [enablePreview] 是否启用预览功能，默认 true
  /// [maxDisplayCount] 最大显示图片数量，默认 9
  /// [enableQuickActions] 是否启用长按快捷操作，默认 true
  const ImageGallery({
    super.key,
    required this.imageUrls,
    this.onImageTap,
    this.onImageLongPress,
    this.spacing = 4,
    this.borderRadius = 8,
    this.singleImageAspectRatio = 16 / 9,
    this.enablePreview = true,
    this.maxDisplayCount = 9,
    this.enableQuickActions = true,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    final displayCount = imageUrls.length > maxDisplayCount
        ? maxDisplayCount
        : imageUrls.length;

    if (displayCount == 1) {
      return _buildSingleImage(context);
    } else if (displayCount == 4) {
      return _buildFourImages(context);
    } else {
      return _buildNineGrid(context, displayCount);
    }
  }

  /// 构建单张图片
  Widget _buildSingleImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: singleImageAspectRatio,
        child: _GalleryImageItem(
          imageUrl: imageUrls[0],
          fit: BoxFit.cover,
          onTap: () => _handleImageTap(context, 0),
          onLongPress: () => _handleImageLongPress(context, 0),
        ),
      ),
    );
  }

  /// 构建四张图片（2x2 布局）
  Widget _buildFourImages(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: _GalleryImageItem(
            imageUrl: imageUrls[index],
            fit: BoxFit.cover,
            onTap: () => _handleImageTap(context, index),
            onLongPress: () => _handleImageLongPress(context, index),
          ),
        );
      },
    );
  }

  /// 构建九宫格图片
  Widget _buildNineGrid(BuildContext context, int displayCount) {
    final crossAxisCount = displayCount == 2 || displayCount == 3
        ? displayCount
        : 3;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: displayCount,
      itemBuilder: (context, index) {
        final isLastItem = index == maxDisplayCount - 1;
        final hasMoreImages = imageUrls.length > maxDisplayCount;

        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _GalleryImageItem(
                imageUrl: imageUrls[index],
                fit: BoxFit.cover,
                onTap: () => _handleImageTap(context, index),
                onLongPress: () => _handleImageLongPress(context, index),
              ),
              // 显示更多图片提示
              if (isLastItem && hasMoreImages)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      '+${imageUrls.length - maxDisplayCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  /// 处理图片点击事件
  ///
  /// [context] BuildContext
  /// [index] 图片索引
  void _handleImageTap(BuildContext context, int index) {
    onImageTap?.call(index);

    if (enablePreview) {
      ImagePreviewPage.show(context, imageUrls: imageUrls, initialIndex: index);
    }
  }

  /// 处理图片长按事件
  ///
  /// [context] BuildContext
  /// [index] 图片索引
  void _handleImageLongPress(BuildContext context, int index) {
    onImageLongPress?.call(index);
    if (enableQuickActions) {
      _showQuickActionSheet(context, index);
    }
  }

  /// 显示快捷操作底部弹窗
  ///
  /// [context] BuildContext
  /// [index] 图片索引
  void _showQuickActionSheet(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 拖动指示条
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              // 预览选项
              ListTile(
                leading: Icon(Icons.preview, color: colorScheme.primary),
                title: const Text('预览图片'),
                onTap: () {
                  Navigator.of(context).pop();
                  ImagePreviewPage.show(
                    context,
                    imageUrls: imageUrls,
                    initialIndex: index,
                  );
                },
              ),
              // 直接保存选项
              ListTile(
                leading: Icon(Icons.download, color: colorScheme.primary),
                title: const Text('保存到相册'),
                subtitle: const Text('一步保存，无需进入预览'),
                onTap: () {
                  Navigator.of(context).pop();
                  _quickSaveImage(context, index);
                },
              ),
              // 直接分享选项
              ListTile(
                leading: Icon(Icons.share, color: colorScheme.primary),
                title: const Text('分享图片'),
                subtitle: const Text('一步分享，无需进入预览'),
                onTap: () {
                  Navigator.of(context).pop();
                  _quickShareImage(context, index);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  /// 快速保存图片到相册
  ///
  /// [context] BuildContext
  /// [index] 图片索引
  Future<void> _quickSaveImage(BuildContext context, int index) async {
    _showLoadingSnackBar(context, '正在保存...');

    try {
      // 申请存储权限
      final permission = await _requestStoragePermission();
      if (!permission) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '需要存储权限才能保存图片');
        return;
      }

      // 下载图片
      final imageUrl = imageUrls[index];
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '图片下载失败');
        return;
      }

      // 保存到相册
      final result = await ImageGallerySaver.saveImage(
        response.bodyBytes,
        quality: 100,
        name: 'trae_forum_${DateTime.now().millisecondsSinceEpoch}',
      );

      _hideSnackBar(context);
      if (result['isSuccess'] == true) {
        _showSuccessSnackBar(context, '已保存到相册');
      } else {
        _showErrorSnackBar(context, '保存失败');
      }
    } catch (e) {
      _hideSnackBar(context);
      _showErrorSnackBar(context, '保存失败: $e');
    }
  }

  /// 快速分享图片
  ///
  /// [context] BuildContext
  /// [index] 图片索引
  Future<void> _quickShareImage(BuildContext context, int index) async {
    _showLoadingSnackBar(context, '正在准备分享...');

    try {
      final imageUrl = imageUrls[index];

      // 下载图片到临时目录
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '图片下载失败');
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final fileName = 'share_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      _hideSnackBar(context);

      // 分享图片
      await Share.shareXFiles(
        [XFile(filePath)],
        text: '来自 TRAE 论坛的图片',
      );
    } catch (e) {
      _hideSnackBar(context);
      _showErrorSnackBar(context, '分享失败: $e');
    }
  }

  /// 申请存储权限
  ///
  /// 返回是否获得权限
  Future<bool> _requestStoragePermission() async {
    // Android 13+ 使用新的权限
    if (Platform.isAndroid) {
      // 尝试申请照片权限（Android 13+）
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;

      // 尝试申请存储权限（Android 12 及以下）
      final storage = await Permission.storage.request();
      if (storage.isGranted) return true;
    } else if (Platform.isIOS) {
      // iOS 申请照片权限
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;
    }

    return false;
  }

  /// 显示加载提示
  void _showLoadingSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        duration: const Duration(seconds: 30),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 隐藏提示
  void _hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// 显示成功提示
  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 显示错误提示
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

/// 画廊图片项组件
///
/// 内部使用的图片展示组件，支持加载状态和错误状态
class _GalleryImageItem extends StatelessWidget {
  /// 图片 URL
  final String imageUrl;

  /// 填充模式
  final BoxFit fit;

  /// 点击回调
  final VoidCallback? onTap;

  /// 长按回调
  final VoidCallback? onLongPress;

  /// 构造函数
  ///
  /// [imageUrl] 图片 URL（必填）
  /// [fit] 填充模式，默认 BoxFit.cover
  /// [onTap] 点击回调
  /// [onLongPress] 长按回调
  const _GalleryImageItem({
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit,
        placeholder: (context, url) => _buildPlaceholder(context),
        errorWidget: (context, url, error) => _buildErrorWidget(context),
      ),
    );
  }

  /// 构建占位图
  ///
  /// [context] BuildContext
  Widget _buildPlaceholder(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[200]!
        : Colors.grey[800]!;

    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color.withOpacity(0.5),
      child: Container(color: color),
    );
  }

  /// 构建错误组件
  ///
  /// [context] BuildContext
  Widget _buildErrorWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surfaceVariant,
      child: Icon(
        Icons.broken_image,
        color: colorScheme.onSurfaceVariant,
        size: 32,
      ),
    );
  }
}

/// 图片网格组件（简化版）
///
/// 用于评论、聊天等场景的图片展示
class ImageGrid extends StatelessWidget {
  /// 图片 URL 列表
  final List<String> imageUrls;

  /// 每行显示的图片数量
  final int crossAxisCount;

  /// 图片间距
  final double spacing;

  /// 圆角半径
  final double borderRadius;

  /// 图片高度
  final double? imageHeight;

  /// 是否启用预览
  final bool enablePreview;

  /// 是否启用长按快捷操作
  final bool enableQuickActions;

  /// 构造函数
  ///
  /// [imageUrls] 图片 URL 列表（必填）
  /// [crossAxisCount] 每行显示的图片数量，默认 3
  /// [spacing] 图片间距，默认 4
  /// [borderRadius] 圆角半径，默认 8
  /// [imageHeight] 图片高度
  /// [enablePreview] 是否启用预览功能，默认 true
  /// [enableQuickActions] 是否启用长按快捷操作，默认 true
  const ImageGrid({
    super.key,
    required this.imageUrls,
    this.crossAxisCount = 3,
    this.spacing = 4,
    this.borderRadius = 8,
    this.imageHeight,
    this.enablePreview = true,
    this.enableQuickActions = true,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return const SizedBox.shrink();
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: spacing,
        mainAxisSpacing: spacing,
        childAspectRatio: 1,
      ),
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: GestureDetector(
            onTap: () {
              if (enablePreview) {
                ImagePreviewPage.show(
                  context,
                  imageUrls: imageUrls,
                  initialIndex: index,
                );
              }
            },
            onLongPress: enableQuickActions
                ? () => _showQuickActionSheet(context, index)
                : null,
            child: CachedNetworkImage(
              imageUrl: imageUrls[index],
              fit: BoxFit.cover,
              placeholder: (context, url) => _buildPlaceholder(context),
              errorWidget: (context, url, error) => _buildErrorWidget(context),
            ),
          ),
        );
      },
    );
  }

  /// 显示快捷操作底部弹窗
  void _showQuickActionSheet(BuildContext context, int index) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.preview, color: colorScheme.primary),
                title: const Text('预览图片'),
                onTap: () {
                  Navigator.of(context).pop();
                  ImagePreviewPage.show(
                    context,
                    imageUrls: imageUrls,
                    initialIndex: index,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.download, color: colorScheme.primary),
                title: const Text('保存到相册'),
                onTap: () {
                  Navigator.of(context).pop();
                  _quickSaveImage(context, index);
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: colorScheme.primary),
                title: const Text('分享图片'),
                onTap: () {
                  Navigator.of(context).pop();
                  _quickShareImage(context, index);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  /// 快速保存图片
  Future<void> _quickSaveImage(BuildContext context, int index) async {
    _showLoadingSnackBar(context, '正在保存...');

    try {
      final permission = await _requestStoragePermission();
      if (!permission) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '需要存储权限');
        return;
      }

      final imageUrl = imageUrls[index];
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '图片下载失败');
        return;
      }

      final result = await ImageGallerySaver.saveImage(
        response.bodyBytes,
        quality: 100,
        name: 'trae_forum_${DateTime.now().millisecondsSinceEpoch}',
      );

      _hideSnackBar(context);
      if (result['isSuccess'] == true) {
        _showSuccessSnackBar(context, '已保存到相册');
      } else {
        _showErrorSnackBar(context, '保存失败');
      }
    } catch (e) {
      _hideSnackBar(context);
      _showErrorSnackBar(context, '保存失败: $e');
    }
  }

  /// 快速分享图片
  Future<void> _quickShareImage(BuildContext context, int index) async {
    _showLoadingSnackBar(context, '正在准备...');

    try {
      final imageUrl = imageUrls[index];
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '图片下载失败');
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final fileName = 'share_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      _hideSnackBar(context);
      await Share.shareXFiles(
        [XFile(filePath)],
        text: '来自 TRAE 论坛的图片',
      );
    } catch (e) {
      _hideSnackBar(context);
      _showErrorSnackBar(context, '分享失败: $e');
    }
  }

  /// 申请存储权限
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;
      final storage = await Permission.storage.request();
      if (storage.isGranted) return true;
    } else if (Platform.isIOS) {
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;
    }
    return false;
  }

  /// 显示加载提示
  void _showLoadingSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        duration: const Duration(seconds: 30),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 隐藏提示
  void _hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// 显示成功提示
  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 显示错误提示
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 构建占位图
  Widget _buildPlaceholder(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[200]!
        : Colors.grey[800]!;

    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color.withOpacity(0.5),
      child: Container(color: color),
    );
  }

  /// 构建错误组件
  Widget _buildErrorWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surfaceVariant,
      child: Icon(
        Icons.broken_image,
        color: colorScheme.onSurfaceVariant,
        size: 24,
      ),
    );
  }
}

/// 可点击的单图组件
///
/// 用于头像、封面等场景，点击可预览
class TapableImage extends StatelessWidget {
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

  /// 是否启用长按快捷操作
  final bool enableQuickActions;

  /// 构造函数
  ///
  /// [imageUrl] 图片 URL（必填）
  /// [width] 图片宽度
  /// [height] 图片高度
  /// [borderRadius] 圆角半径
  /// [isCircular] 是否圆形裁剪，默认 false
  /// [fit] 填充模式，默认 BoxFit.cover
  /// [enableQuickActions] 是否启用长按快捷操作，默认 true
  const TapableImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.borderRadius,
    this.isCircular = false,
    this.fit = BoxFit.cover,
    this.enableQuickActions = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) => _buildPlaceholder(context),
      errorWidget: (context, url, error) => _buildErrorWidget(context),
    );

    // 应用圆角或圆形裁剪
    if (isCircular) {
      imageWidget = ClipOval(child: imageWidget);
    } else if (borderRadius != null && borderRadius! > 0) {
      imageWidget = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: imageWidget,
      );
    }

    return GestureDetector(
      onTap: () {
        ImagePreviewPage.show(context, imageUrls: [imageUrl], initialIndex: 0);
      },
      onLongPress: enableQuickActions
          ? () => _showQuickActionSheet(context)
          : null,
      child: imageWidget,
    );
  }

  /// 显示快捷操作底部弹窗
  void _showQuickActionSheet(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.outline.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.preview, color: colorScheme.primary),
                title: const Text('预览图片'),
                onTap: () {
                  Navigator.of(context).pop();
                  ImagePreviewPage.show(
                    context,
                    imageUrls: [imageUrl],
                    initialIndex: 0,
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.download, color: colorScheme.primary),
                title: const Text('保存到相册'),
                onTap: () {
                  Navigator.of(context).pop();
                  _quickSaveImage(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.share, color: colorScheme.primary),
                title: const Text('分享图片'),
                onTap: () {
                  Navigator.of(context).pop();
                  _quickShareImage(context);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  /// 快速保存图片
  Future<void> _quickSaveImage(BuildContext context) async {
    _showLoadingSnackBar(context, '正在保存...');

    try {
      final permission = await _requestStoragePermission();
      if (!permission) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '需要存储权限');
        return;
      }

      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '图片下载失败');
        return;
      }

      final result = await ImageGallerySaver.saveImage(
        response.bodyBytes,
        quality: 100,
        name: 'trae_forum_${DateTime.now().millisecondsSinceEpoch}',
      );

      _hideSnackBar(context);
      if (result['isSuccess'] == true) {
        _showSuccessSnackBar(context, '已保存到相册');
      } else {
        _showErrorSnackBar(context, '保存失败');
      }
    } catch (e) {
      _hideSnackBar(context);
      _showErrorSnackBar(context, '保存失败: $e');
    }
  }

  /// 快速分享图片
  Future<void> _quickShareImage(BuildContext context) async {
    _showLoadingSnackBar(context, '正在准备...');

    try {
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        _hideSnackBar(context);
        _showErrorSnackBar(context, '图片下载失败');
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final fileName = 'share_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      _hideSnackBar(context);
      await Share.shareXFiles(
        [XFile(filePath)],
        text: '来自 TRAE 论坛的图片',
      );
    } catch (e) {
      _hideSnackBar(context);
      _showErrorSnackBar(context, '分享失败: $e');
    }
  }

  /// 申请存储权限
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;
      final storage = await Permission.storage.request();
      if (storage.isGranted) return true;
    } else if (Platform.isIOS) {
      final photos = await Permission.photos.request();
      if (photos.isGranted) return true;
    }
    return false;
  }

  /// 显示加载提示
  void _showLoadingSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        duration: const Duration(seconds: 30),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// 隐藏提示
  void _hideSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  /// 显示成功提示
  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(message),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 显示错误提示
  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  /// 构建占位图
  Widget _buildPlaceholder(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.light
        ? Colors.grey[200]!
        : Colors.grey[800]!;

    return Shimmer.fromColors(
      baseColor: color,
      highlightColor: color.withOpacity(0.5),
      child: Container(width: width, height: height, color: color),
    );
  }

  /// 构建错误组件
  Widget _buildErrorWidget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: width,
      height: height,
      color: colorScheme.surfaceVariant,
      child: Icon(
        Icons.broken_image,
        color: colorScheme.onSurfaceVariant,
        size: (width != null && height != null)
            ? (width! < height! ? width! * 0.3 : height! * 0.3)
            : 24,
      ),
    );
  }
}
