import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/network/dio_client.dart';

/// 应用入口函数
///
/// 负责初始化 Flutter 绑定、配置系统 UI、初始化应用并启动
void main() {
  // 捕获 Flutter 框架异常
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // 记录错误日志
    debugPrint('Flutter Error: ${details.exceptionAsString()}');
    debugPrint('Stack: ${details.stack}');
  };

  // 确保 Flutter 绑定初始化（必须在任何 Flutter API 调用之前）
  WidgetsFlutterBinding.ensureInitialized();

  // 设置首选方向
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 设置系统 UI 样式
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // 运行启动流程
  runZonedGuarded(
    () async {
      // 初始化应用
      await AppInitializer.initialize();

      // 启动应用，使用 ProviderScope 包裹
      runApp(
        const ProviderScope(
          child: MyApp(),
        ),
      );
    },
    (error, stack) {
      // 处理启动过程中的错误
      debugPrint('App initialization error: $error');
      debugPrint('Stack trace: $stack');
      runApp(const ErrorApp());
    },
  );
}

/// 应用初始化器
///
/// 负责应用启动时的各项初始化工作
class AppInitializer {
  static bool _initialized = false;

  /// 是否已初始化
  static bool get isInitialized => _initialized;

  /// 初始化应用
  static Future<void> initialize() async {
    if (_initialized) return;

    try {
      // 初始化持久化 CookieManager
      await DioClient.initPersistentCookieManager();

      // 配置图片缓存
      _configureImageCache();

      // 初始化完成
      _initialized = true;
      debugPrint('App initialization completed');
    } catch (e) {
      debugPrint('App initialization error: $e');
      // 即使初始化失败也允许应用启动
      _initialized = true;
    }
  }

  /// 配置图片缓存
  static void _configureImageCache() {
    try {
      final imageCache = PaintingBinding.instance.imageCache;
      imageCache.maximumSize = 200;
      imageCache.maximumSizeBytes = 100 * 1024 * 1024; // 100MB
      debugPrint('Image cache configured');
    } catch (e) {
      debugPrint('Image cache configuration error: $e');
    }
  }
}

/// 初始化失败时的备用应用
class ErrorApp extends StatelessWidget {
  /// 构造函数
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 64,
              ),
              const SizedBox(height: 16),
              const Text(
                '应用初始化失败',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '请检查网络连接后重试',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // 重新初始化
                  main();
                },
                child: const Text('重试'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
