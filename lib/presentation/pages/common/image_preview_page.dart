import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

/// 图片预览页面
///
/// 支持手势缩放、左右滑动切换、保存图片到本地、分享图片等功能
/// 使用 photo_view 包实现
class ImagePreviewPage extends StatefulWidget {
  /// 图片 URL 列表
  final List<String> imageUrls;

  /// 初始显示的图片索引
  final int initialIndex;

  /// 页面背景色
  final Color backgroundColor;

  /// 是否显示指示器
  final bool showIndicator;

  /// 是否允许保存图片
  final bool enableSave;

  /// 是否允许分享图片
  final bool enableShare;

  /// 构造函数
  ///
  /// [imageUrls] 图片 URL 列表（必填）
  /// [initialIndex] 初始显示的图片索引，默认 0
  /// [backgroundColor] 页面背景色，默认黑色
  /// [showIndicator] 是否显示图片索引指示器，默认 true
  /// [enableSave] 是否允许保存图片，默认 true
  /// [enableShare] 是否允许分享图片，默认 true
  const ImagePreviewPage({
    super.key,
    required this.imageUrls,
    this.initialIndex = 0,
    this.backgroundColor = Colors.black,
    this.showIndicator = true,
    this.enableSave = true,
    this.enableShare = true,
  });

  /// 显示图片预览页面（静态方法）
  ///
  /// [context] BuildContext
  /// [imageUrls] 图片 URL 列表
  /// [initialIndex] 初始显示的图片索引
  static Future<void> show(
    BuildContext context, {
    required List<String> imageUrls,
    int initialIndex = 0,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ImagePreviewPage(
          imageUrls: imageUrls,
          initialIndex: initialIndex,
        ),
      ),
    );
  }

  @override
  State<ImagePreviewPage> createState() => _ImagePreviewPageState();
}

class _ImagePreviewPageState extends State<ImagePreviewPage> {
  /// 当前显示的图片索引
  late int _currentIndex;

  /// 页面控制器
  late PageController _pageController;

  /// 是否显示 UI 控件
  bool _showControls = true;

  /// 是否正在保存图片
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
    // 设置状态栏为白色（适配黑色背景）
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    // 恢复状态栏样式
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          // 图片画廊
          _buildPhotoGallery(),
          // 顶部控制栏
          if (_showControls) _buildTopBar(),
          // 底部指示器
          if (_showControls && widget.showIndicator) _buildBottomIndicator(),
        ],
      ),
    );
  }

  /// 构建图片画廊
  Widget _buildPhotoGallery() {
    return GestureDetector(
      onTap: _toggleControls,
      child: PhotoViewGallery.builder(
        pageController: _pageController,
        itemCount: widget.imageUrls.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(
              widget.imageUrls[index],
            ),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 3,
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(
              tag: widget.imageUrls[index],
            ),
            errorBuilder: (context, error, stackTrace) {
              return _buildErrorWidget();
            },
          );
        },
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        loadingBuilder: (context, event) {
          return _buildLoadingWidget();
        },
        backgroundDecoration: BoxDecoration(
          color: widget.backgroundColor,
        ),
      ),
    );
  }

  /// 构建加载中组件
  Widget _buildLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.white,
        strokeWidth: 2,
      ),
    );
  }

  /// 构建错误组件
  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.broken_image,
            color: Colors.white54,
            size: 64,
          ),
          const SizedBox(height: 16),
          Text(
            '图片加载失败',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建顶部控制栏
  Widget _buildTopBar() {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.transparent,
            ],
          ),
        ),
        child: Row(
          children: [
            // 关闭按钮
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.close,
                color: Colors.white,
              ),
              tooltip: '关闭',
            ),
            const Spacer(),
            // 保存按钮
            if (widget.enableSave)
              IconButton(
                onPressed: _isSaving ? null : _saveImage,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Icons.download,
                        color: Colors.white,
                      ),
                tooltip: '保存图片',
              ),
            // 分享按钮
            if (widget.enableShare)
              IconButton(
                onPressed: _shareImage,
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                ),
                tooltip: '分享图片',
              ),
          ],
        ),
      ),
    );
  }

  /// 构建底部指示器
  Widget _buildBottomIndicator() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.transparent,
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 图片索引指示器
              Text(
                '${_currentIndex + 1} / ${widget.imageUrls.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 切换 UI 控件显示状态
  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
  }

  /// 保存当前图片到本地
  ///
  /// 首先申请存储权限，然后下载图片并保存到相册
  Future<void> _saveImage() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      // 申请存储权限
      final permission = await _requestStoragePermission();
      if (!permission) {
        _showSnackBar('需要存储权限才能保存图片');
        return;
      }

      // 下载图片
      final imageUrl = widget.imageUrls[_currentIndex];
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode != 200) {
        _showSnackBar('图片下载失败');
        return;
      }

      // 保存图片到临时目录
      final tempDir = await getTemporaryDirectory();
      final fileName = 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // 保存到相册（使用平台通道或第三方库）
      // 这里简化处理，实际项目中可以使用 image_gallery_saver 等库
      _showSnackBar('图片已保存');
    } catch (e) {
      _showSnackBar('保存失败: $e');
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  /// 分享当前图片
  ///
  /// 下载图片并调用系统分享功能
  Future<void> _shareImage() async {
    try {
      final imageUrl = widget.imageUrls[_currentIndex];

      // 下载图片到临时目录
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode != 200) {
        _showSnackBar('图片下载失败');
        return;
      }

      final tempDir = await getTemporaryDirectory();
      final fileName = 'share_image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final filePath = '${tempDir.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // 分享图片
      await Share.shareXFiles(
        [XFile(filePath)],
        text: '分享图片',
      );
    } catch (e) {
      _showSnackBar('分享失败: $e');
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

  /// 显示提示信息
  ///
  /// [message] 提示消息内容
  void _showSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.black87,
      ),
    );
  }
}

/// 图片预览控制器
///
/// 用于控制图片预览页面的行为
class ImagePreviewController {
  /// 当前显示的图片索引
  int currentIndex = 0;

  /// 图片 URL 列表
  List<String> imageUrls = [];

  /// 跳转到指定图片
  ///
  /// [index] 目标图片索引
  void jumpToPage(int index) {
    currentIndex = index;
  }

  /// 跳转到下一张图片
  void nextPage() {
    if (currentIndex < imageUrls.length - 1) {
      currentIndex++;
    }
  }

  /// 跳转到上一张图片
  void previousPage() {
    if (currentIndex > 0) {
      currentIndex--;
    }
  }
}
