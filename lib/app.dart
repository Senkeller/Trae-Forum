import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'config/routes.dart';
import 'config/theme.dart';

/// 应用入口
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  /// 初始化 Hive 数据库
  Future<void> _initHive() async {
    try {
      // 获取应用文档目录
      final appDocumentDir = await getApplicationDocumentsDirectory();
      
      // 初始化 Hive
      Hive.init(appDocumentDir.path);
      
      // 注册 Hive 适配器
      _registerHiveAdapters();
      
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      setState(() {
        _error = '初始化失败: $e';
      });
    }
  }

  /// 注册 Hive 类型适配器
  void _registerHiveAdapters() {
    // 注意：适配器需要通过 build_runner 生成
    // 运行命令: dart run build_runner build
    // 生成的适配器类名为: LocalFavoriteAdapter, BrowseHistoryAdapter, FrequentlyVisitedAdapter
    
    // TODO: 取消注释以下代码（在运行 build_runner 生成适配器后）
    // Hive.registerAdapter(LocalFavoriteAdapter());
    // Hive.registerAdapter(BrowseHistoryAdapter());
    // Hive.registerAdapter(FrequentlyVisitedAdapter());
  }

  @override
  Widget build(BuildContext context) {
    // 显示加载界面
    if (!_initialized && _error == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(
                  '正在初始化...',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 显示错误界面
    if (_error != null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  _error!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 正常显示应用
    return MaterialApp.router(
      title: 'TRAE Forum',
      debugShowCheckedModeBanner: false,
      
      // 主题配置
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // 临时使用系统主题
      
      // 路由配置
      routerConfig: AppRouter.router,
      
      // Builder 配置
      builder: (context, child) {
        // TODO: 添加全局加载指示器、错误处理等
        return child ?? const SizedBox.shrink();
      },
    );
  }
}

/// 应用初始化
class AppInitializer {
  static bool _initialized = false;
  
  /// 初始化应用
  static Future<void> initialize() async {
    if (_initialized) return;
    
    // TODO: 初始化 Hive
    // await Hive.initFlutter();
    
    // TODO: 注册 Hive Adapter
    // Hive.registerAdapter(UserInfoAdapter());
    
    // TODO: 初始化 SharedPreferences
    // await SharedPreferences.getInstance();
    
    // TODO: 初始化日志
    // Logger.init();
    
    // TODO: 检查登录状态
    // await AuthRepository.checkLoginStatus();
    
    _initialized = true;
  }
  
  /// 是否已初始化
  static bool get isInitialized => _initialized;
}

/// 错误处理 Widget
class AppErrorWidget extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  /// 构造函数
  ///
  /// [errorDetails] 错误详情
  const AppErrorWidget({super.key, required this.errorDetails});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      child: Container(
        color: colorScheme.surface,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              '应用出现错误',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorDetails.exception.toString(),
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.onBackground,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
