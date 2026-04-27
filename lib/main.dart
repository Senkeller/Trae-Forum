import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'core/network/dio_client.dart';
import 'hive_registrar.g.dart';

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
      debugPrint('App initialization error in zone: $error');
      debugPrint('Stack trace: $stack');
      // 只有在真正致命错误时才显示 ErrorApp
      // 其他情况让应用继续启动
    },
  );
}

/// 应用初始化器
///
/// 负责应用启动时的各项初始化工作，作为应用初始化的单一真源
class AppInitializer {
  static bool _initialized = false;

  /// 是否已初始化
  static bool get isInitialized => _initialized;

  /// 初始化应用
  static Future<void> initialize() async {
    if (_initialized) return;

    // 初始化 Hive 数据库
    try {
      await _initHive();
    } catch (e, stackTrace) {
      debugPrint('⚠️ [AppInitializer] Hive 初始化失败: $e');
      debugPrint('Stack trace: $stackTrace');
    }

    // 初始化持久化 CookieManager - 使用 try-catch 确保即使失败也不影响应用启动
    try {
      await DioClient.initPersistentCookieManager();
    } catch (e, stackTrace) {
      debugPrint('⚠️ [AppInitializer] CookieManager 初始化失败，使用内存存储: $e');
      debugPrint('Stack trace: $stackTrace');
      // 失败时 DioClient 内部会自动降级到内存 CookieJar
    }

    // 配置图片缓存
    try {
      _configureImageCache();
    } catch (e) {
      debugPrint('⚠️ [AppInitializer] 图片缓存配置失败: $e');
    }

    // 初始化完成 - 无论成功与否都标记为已初始化，让应用继续启动
    _initialized = true;
    debugPrint('✅ [AppInitializer] 应用初始化完成');
  }

  /// 初始化 Hive 数据库
  static Future<void> _initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);
    _registerHiveAdapters();
    debugPrint('✅ [AppInitializer] Hive 初始化完成');
  }

  /// 注册 Hive 类型适配器
  ///
  /// 使用自动生成的 registerAdapters() 扩展方法注册所有适配器
  /// 包括: LocalFavoriteAdapter, BrowseHistoryAdapter, FrequentlyVisitedAdapter
  static void _registerHiveAdapters() {
    Hive.registerAdapters();
    debugPrint('✅ [AppInitializer] Hive 适配器注册完成');
  }

  /// 配置图片缓存
  static void _configureImageCache() {
    final imageCache = PaintingBinding.instance.imageCache;
    imageCache.maximumSize = 200;
    imageCache.maximumSizeBytes = 100 * 1024 * 1024; // 100MB
    debugPrint('✅ [AppInitializer] 图片缓存已配置');
  }
}

/// 初始化失败时的备用应用
///
/// 仅在应用完全无法启动时显示
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
