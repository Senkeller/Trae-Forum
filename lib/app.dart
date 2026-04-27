import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'presentation/providers/settings_provider.dart';
import 'presentation/providers/push_bootstrap_provider.dart';

/// 应用根组件
///
/// 应用初始化已在 [main.dart] 的 [AppInitializer] 中完成
/// 此类仅负责构建应用 UI 和路由
class MyApp extends ConsumerWidget {
  /// 构造函数
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 启动系统推送轮询服务（幂等）
    ref.watch(pushBootstrapProvider);
    final fontScale = ref.watch(fontSizeProvider).scaleFactor;

    return MaterialApp.router(
      title: 'TRAE Forum',
      debugShowCheckedModeBanner: false,

      // 主题配置
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // 临时使用系统主题
      // 本地化配置
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
      locale: const Locale('zh', 'CN'),

      // 路由配置
      routerConfig: AppRouter.router,

      // Builder 配置
      builder: (context, child) {
        final currentMediaQuery = MediaQuery.of(context);
        final scaledMediaQuery = currentMediaQuery.copyWith(
          textScaler: TextScaler.linear(fontScale),
        );
        return MediaQuery(
          data: scaledMediaQuery,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

/// 错误处理 Widget
///
/// 用于捕获和显示应用运行时的错误
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
            Icon(Icons.error_outline, color: colorScheme.error, size: 48),
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
              style: TextStyle(fontSize: 14, color: colorScheme.onBackground),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
