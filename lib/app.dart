import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes.dart';
import 'config/theme.dart';

/// 应用入口
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: 从 Provider 获取主题设置
    // final themeMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      title: 'TRAE Forum',
      debugShowCheckedModeBanner: false,
      
      // 主题配置
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // themeMode: themeMode, // 从 Provider 获取
      themeMode: ThemeMode.system, // 临时使用系统主题
      
      // 路由配置
      routerConfig: AppRouter.router,
      
      // 本地化配置
      // localizationsDelegates: const [
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('zh', 'CN'),
      //   Locale('en', 'US'),
      // ],
      // locale: const Locale('zh', 'CN'),
      
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
