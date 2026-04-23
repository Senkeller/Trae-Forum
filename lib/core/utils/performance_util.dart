import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// 性能监控工具类
///
/// 提供帧率检测、内存监控、性能日志等功能
/// 用于监控应用性能并帮助定位性能问题
class PerformanceUtil {
  static final PerformanceUtil _instance = PerformanceUtil._internal();

  /// 单例实例
  static PerformanceUtil get instance => _instance;

  PerformanceUtil._internal();

  /// 帧率计算器
  final FrameRateCalculator _frameRateCalculator = FrameRateCalculator();

  /// 是否正在监控
  bool _isMonitoring = false;

  /// 性能日志流控制器
  final StreamController<PerformanceData> _performanceStreamController =
      StreamController<PerformanceData>.broadcast();

  /// 性能数据流
  Stream<PerformanceData> get performanceStream =>
      _performanceStreamController.stream;

  /// 开始性能监控
  ///
  /// 启动帧率检测和性能数据收集
  void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;

    _frameRateCalculator.start();
    _frameRateCalculator.frameRateStream.listen((fps) {
      final data = PerformanceData(
        timestamp: DateTime.now(),
        fps: fps,
        memoryUsage: _getMemoryUsage(),
      );
      _performanceStreamController.add(data);

      if (kDebugMode) {
        developer.log(
          'Performance: FPS=$fps, Memory=${data.memoryUsage}MB',
          name: 'PerformanceUtil',
        );
      }
    });

    // 监听帧回调
    SchedulerBinding.instance.addTimingsCallback(_onFrameTimings);
  }

  /// 停止性能监控
  ///
  /// 停止帧率检测和性能数据收集
  void stopMonitoring() {
    if (!_isMonitoring) return;
    _isMonitoring = false;

    _frameRateCalculator.stop();
    SchedulerBinding.instance.removeTimingsCallback(_onFrameTimings);
  }

  /// 帧时序回调
  ///
  /// [timings] 帧时序信息列表
  void _onFrameTimings(List<FrameTiming> timings) {
    for (final timing in timings) {
      final buildTime = timing.buildDuration.inMicroseconds / 1000;
      final rasterTime = timing.rasterDuration.inMicroseconds / 1000;
      final totalTime = buildTime + rasterTime;

      // 检测掉帧（超过 16.67ms 即 60fps 的帧时间）
      if (totalTime > 16.67) {
        final droppedFrames = (totalTime / 16.67).floor() - 1;
        if (kDebugMode && droppedFrames > 0) {
          developer.log(
            'Jank detected: build=${buildTime.toStringAsFixed(2)}ms, '
            'raster=${rasterTime.toStringAsFixed(2)}ms, '
            'dropped=$droppedFrames frames',
            name: 'PerformanceUtil',
          );
        }
      }
    }
  }

  /// 获取内存使用情况
  ///
  /// 返回当前内存使用量（MB）
  double _getMemoryUsage() {
    // 注意：Flutter 无法直接获取内存使用，这里返回 0
    // 实际项目中可以使用原生插件获取
    // 例如：使用 device_info_plus 或自定义平台通道
    return 0;
  }

  /// 检查是否发生掉帧
  ///
  /// [thresholdMs] 阈值（毫秒），默认 16.67ms（60fps）
  /// 返回是否发生掉帧
  static bool isJank(double frameTimeMs, {double thresholdMs = 16.67}) {
    return frameTimeMs > thresholdMs;
  }

  /// 计算建议的列表项缓存数量
  ///
  /// [viewportHeight] 视口高度
  /// [itemHeight] 列表项高度
  /// 返回建议的缓存数量
  static int calculateCacheExtent(double viewportHeight, double itemHeight) {
    final visibleCount = (viewportHeight / itemHeight).ceil();
    return visibleCount * 2; // 缓存可见数量的 2 倍
  }

  /// 释放资源
  void dispose() {
    stopMonitoring();
    _performanceStreamController.close();
  }
}

/// 帧率计算器
///
/// 计算应用的实时帧率（FPS）
class FrameRateCalculator {
  final List<FrameTiming> _frameTimings = [];
  Timer? _timer;

  /// 帧率流控制器
  final StreamController<double> _frameRateController =
      StreamController<double>.broadcast();

  /// 帧率流
  Stream<double> get frameRateStream => _frameRateController.stream;

  /// 开始计算帧率
  void start() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateFrameRate();
    });
  }

  /// 停止计算帧率
  void stop() {
    _timer?.cancel();
    _timer = null;
    _frameTimings.clear();
  }

  /// 计算帧率
  void _calculateFrameRate() {
    if (_frameTimings.isEmpty) return;

    // 只保留最近1秒的帧数据
    // 由于 FrameTiming 的时间戳是相对于某个 epoch 的原始微秒值，
    // 我们简单地限制列表大小来模拟时间窗口
    const maxFrames = 60; // 假设最高 60fps，保留约1秒的数据
    if (_frameTimings.length > maxFrames) {
      _frameTimings.removeRange(0, _frameTimings.length - maxFrames);
    }

    // 计算 FPS
    final fps = _frameTimings.length.toDouble();
    _frameRateController.add(fps);
  }

  /// 添加帧时序
  void addFrameTiming(FrameTiming timing) {
    _frameTimings.add(timing);
  }

  /// 释放资源
  void dispose() {
    stop();
    _frameRateController.close();
  }
}

/// 性能数据
///
/// 包含某一时刻的性能指标
class PerformanceData {
  /// 时间戳
  final DateTime timestamp;

  /// 帧率（FPS）
  final double fps;

  /// 内存使用量（MB）
  final double memoryUsage;

  /// 构造函数
  ///
  /// [timestamp] 时间戳
  /// [fps] 帧率
  /// [memoryUsage] 内存使用量
  const PerformanceData({
    required this.timestamp,
    required this.fps,
    this.memoryUsage = 0,
  });

  @override
  String toString() {
    return 'PerformanceData(timestamp: $timestamp, fps: $fps, memoryUsage: ${memoryUsage}MB)';
  }
}

/// 性能监控 Widget
///
/// 用于在界面上显示实时性能数据
class PerformanceOverlay extends StatefulWidget {
  /// 是否显示
  final bool show;

  /// 构造函数
  ///
  /// [show] 是否显示性能监控，默认 true
  const PerformanceOverlay({super.key, this.show = true});

  @override
  State<PerformanceOverlay> createState() => _PerformanceOverlayState();
}

class _PerformanceOverlayState extends State<PerformanceOverlay> {
  double _currentFps = 60;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    if (widget.show) {
      _startMonitoring();
    }
  }

  @override
  void didUpdateWidget(PerformanceOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.show && !oldWidget.show) {
      _startMonitoring();
    } else if (!widget.show && oldWidget.show) {
      _stopMonitoring();
    }
  }

  void _startMonitoring() {
    PerformanceUtil.instance.startMonitoring();
    _subscription = PerformanceUtil.instance.performanceStream.listen((data) {
      if (mounted) {
        setState(() {
          _currentFps = data.fps;
        });
      }
    });
  }

  void _stopMonitoring() {
    _subscription?.cancel();
    PerformanceUtil.instance.stopMonitoring();
  }

  @override
  void dispose() {
    _stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.show) return const SizedBox.shrink();

    final color = _currentFps >= 55
        ? Colors.green
        : _currentFps >= 30
            ? Colors.orange
            : Colors.red;

    return Positioned(
      top: 50,
      right: 10,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withAlpha((0.7 * 255).round()),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '${_currentFps.toStringAsFixed(1)} FPS',
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// 列表性能优化包装器
///
/// 提供列表项缓存、预加载等优化功能
class OptimizedListView<T> extends StatelessWidget {
  /// 数据列表
  final List<T> items;

  /// 列表项构建器
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  /// 列表项高度（用于计算缓存区域）
  final double? itemExtent;

  /// 缓存区域大小
  final double? cacheExtent;

  /// 预加载的列表项数量
  final int? preloadItemCount;

  /// 滚动控制器
  final ScrollController? scrollController;

  /// 内边距
  final EdgeInsetsGeometry? padding;

  /// 构造函数
  ///
  /// [items] 数据列表
  /// [itemBuilder] 列表项构建器
  /// [itemExtent] 列表项固定高度，用于性能优化
  /// [cacheExtent] 缓存区域大小
  /// [preloadItemCount] 预加载的列表项数量
  /// [scrollController] 滚动控制器
  /// [padding] 内边距
  const OptimizedListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.itemExtent,
    this.cacheExtent,
    this.preloadItemCount,
    this.scrollController,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: padding,
      itemCount: items.length,
      itemExtent: itemExtent,
      cacheExtent: cacheExtent ?? 250,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      addSemanticIndexes: false,
      itemBuilder: (context, index) {
        final item = items[index];

        // 使用 RepaintBoundary 隔离重绘
        Widget child = RepaintBoundary(
          child: itemBuilder(context, index, item),
        );

        // 如果指定了预加载数量，使用 VisibilityDetector 预加载
        if (preloadItemCount != null) {
          child = _PreloadWrapper(
            index: index,
            preloadItemCount: preloadItemCount!,
            itemCount: items.length,
            child: child,
          );
        }

        return child;
      },
    );
  }
}

/// 预加载包装器
///
/// 用于在列表项即将进入视口时预加载数据
class _PreloadWrapper extends StatelessWidget {
  /// 当前索引
  final int index;

  /// 预加载数量
  final int preloadItemCount;

  /// 总数量
  final int itemCount;

  /// 子组件
  final Widget child;

  /// 构造函数
  const _PreloadWrapper({
    required this.index,
    required this.preloadItemCount,
    required this.itemCount,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // 这里可以实现预加载逻辑
    // 例如：当列表项接近视口时提前加载数据
    return child;
  }
}

/// 避免不必要的重建的 Widget
///
/// 使用 const 构造函数和 ValueKey 优化列表项重建
class OptimizedListItem extends StatelessWidget {
  /// 唯一标识
  final String id;

  /// 子组件
  final Widget child;

  /// 是否保持存活状态
  final bool keepAlive;

  /// 构造函数
  ///
  /// [id] 唯一标识，用于优化重建
  /// [child] 子组件
  /// [keepAlive] 是否保持存活状态，默认 false
  const OptimizedListItem({
    super.key,
    required this.id,
    required this.child,
    this.keepAlive = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget result = KeyedSubtree(
      key: ValueKey(id),
      child: child,
    );

    if (keepAlive) {
      result = KeepAliveWrapper(child: result);
    }

    return result;
  }
}

/// 保持存活包装器
///
/// 使用 AutomaticKeepAliveClientMixin 保持列表项状态
class KeepAliveWrapper extends StatefulWidget {
  /// 子组件
  final Widget child;

  /// 是否保持存活
  final bool keepAlive;

  /// 构造函数
  ///
  /// [child] 子组件
  /// [keepAlive] 是否保持存活，默认 true
  const KeepAliveWrapper({
    super.key,
    required this.child,
    this.keepAlive = true,
  });

  @override
  State<KeepAliveWrapper> createState() => _KeepAliveWrapperState();
}

class _KeepAliveWrapperState extends State<KeepAliveWrapper>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}

/// 图片预加载工具
///
/// 用于预加载图片资源，提升图片显示速度
class ImagePreloader {
  /// 预加载图片
  ///
  /// [context] 构建上下文
  /// [imageUrls] 图片 URL 列表
  /// 返回预加载的 Future
  static Future<void> preloadImages(
    BuildContext context,
    List<String> imageUrls,
  ) async {
    for (final url in imageUrls) {
      if (url.isNotEmpty) {
        precacheImage(
          NetworkImage(url),
          context,
        );
      }
    }
  }

  /// 预加载单个图片
  ///
  /// [context] 构建上下文
  /// [imageUrl] 图片 URL
  static void preloadImage(BuildContext context, String imageUrl) {
    if (imageUrl.isNotEmpty) {
      precacheImage(
        NetworkImage(imageUrl),
        context,
      );
    }
  }
}

/// 内存优化工具
///
/// 提供内存优化相关的工具方法
class MemoryOptimizer {
  /// 建议的图片缓存大小
  static const int recommendedImageCacheSize = 100;

  /// 建议的图片缓存条目数
  static const int recommendedImageCacheEntries = 1000;

  /// 配置图片缓存
  ///
  /// 设置图片缓存的大小和条目数限制
  static void configureImageCache() {
    PaintingBinding.instance.imageCache.maximumSize =
        recommendedImageCacheSize;
    PaintingBinding.instance.imageCache.maximumSizeBytes =
        recommendedImageCacheEntries * 1024 * 1024; // 1000MB
  }

  /// 清理图片缓存
  ///
  /// 释放所有缓存的图片资源
  static void clearImageCache() {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// 获取缓存统计信息
  ///
  /// 返回当前图片缓存的统计信息
  static ImageCacheStats getCacheStats() {
    final cache = PaintingBinding.instance.imageCache;
    return ImageCacheStats(
      currentSize: cache.currentSize,
      maximumSize: cache.maximumSize,
      currentSizeBytes: cache.currentSizeBytes,
      maximumSizeBytes: cache.maximumSizeBytes,
      liveImageCount: cache.liveImageCount,
    );
  }
}

/// 图片缓存统计信息
class ImageCacheStats {
  /// 当前缓存大小
  final int currentSize;

  /// 最大缓存大小
  final int maximumSize;

  /// 当前缓存字节数
  final int currentSizeBytes;

  /// 最大缓存字节数
  final int maximumSizeBytes;

  /// 活跃图片数量
  final int liveImageCount;

  /// 构造函数
  const ImageCacheStats({
    required this.currentSize,
    required this.maximumSize,
    required this.currentSizeBytes,
    required this.maximumSizeBytes,
    required this.liveImageCount,
  });

  @override
  String toString() {
    return 'ImageCacheStats(currentSize: $currentSize/$maximumSize, '
        'bytes: ${(currentSizeBytes / 1024 / 1024).toStringAsFixed(2)}MB/'
        '${(maximumSizeBytes / 1024 / 1024).toStringAsFixed(2)}MB, '
        'live: $liveImageCount)';
  }
}
