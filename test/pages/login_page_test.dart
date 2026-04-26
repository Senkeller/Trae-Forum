import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traeu/presentation/pages/user/login_page.dart';

/// LoginPage Widget 测试
///
/// 测试目标：验证登录页面的渲染和交互行为，包括：
/// - 页面基础渲染
/// - WebView 登录按钮
/// - 浏览器打开选项
/// - 页面关闭按钮
/// - 用户协议显示
void main() {
  // 创建一个测试用的 GoRouter
  GoRouter createTestRouter() {
    return GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const Scaffold(body: Text('Home')),
        ),
      ],
    );
  }

  group('LoginPage 基础渲染测试', () {
    /// 测试目的：验证登录页面正常渲染
    testWidgets('应正确渲染登录页面', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 验证页面标题和关键元素
      expect(find.text('欢迎回来'), findsOneWidget);
      expect(find.text('登录以继续探索精彩内容'), findsOneWidget);
      expect(find.byIcon(Icons.forum), findsOneWidget);
    });

    /// 测试目的：验证关闭按钮存在
    testWidgets('应显示关闭按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.byIcon(Icons.close), findsOneWidget);
    });

    /// 测试目的：验证 WebView 登录按钮存在
    testWidgets('应显示 WebView 登录按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 使用 find.text 查找按钮文字
      expect(find.text('使用 TRAE 账号登录'), findsOneWidget);
      expect(find.byIcon(Icons.login), findsOneWidget);
      // 验证是 ButtonStyleButton 类型（FilledButton 的父类）
      expect(find.bySubtype<ButtonStyleButton>(), findsWidgets);
    });

    /// 测试目的：验证登录说明区域
    testWidgets('应显示登录说明', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.text('登录说明'), findsOneWidget);
      expect(
        find.text('TRAE 论坛使用统一的账号体系，点击上方按钮将跳转到官方登录页面完成认证。登录成功后即可在应用内访问论坛的所有功能。'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });
  });

  group('LoginPage 其他登录方式测试', () {
    /// 测试目的：验证分隔线文字
    testWidgets('应显示其他方式分隔线', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.text('其他方式'), findsOneWidget);
    });

    /// 测试目的：验证浏览器打开按钮
    testWidgets('应显示浏览器打开按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.text('在浏览器中打开论坛'), findsOneWidget);
      expect(find.byIcon(Icons.open_in_browser), findsOneWidget);
      // 验证是 OutlinedButton 类型
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });

  group('LoginPage 用户协议测试', () {
    /// 测试目的：验证用户协议文字
    testWidgets('应显示用户协议文字', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(
        find.text('登录即表示您同意我们的服务条款和隐私政策'),
        findsOneWidget,
      );
    });
  });

  group('LoginPage 交互测试', () {
    /// 测试目的：验证 WebView 登录按钮存在且可交互
    /// 注意：不实际点击按钮，因为点击后会导航到 WebViewLoginPage
    /// 而 WebView 在测试环境中需要平台实现
    testWidgets('应显示 WebView 登录按钮并可交互', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 查找登录按钮
      final loginButton = find.text('使用 TRAE 账号登录');
      expect(loginButton, findsOneWidget);

      // 验证按钮是 ButtonStyleButton 类型（FilledButton 的父类）
      final button = find.bySubtype<ButtonStyleButton>();
      expect(button, findsWidgets);

      // 获取第一个按钮 widget 验证 onPressed 不为 null
      final buttonWidget = tester.widget<ButtonStyleButton>(button.first);
      expect(buttonWidget.onPressed, isNotNull);
    });

    /// 测试目的：验证浏览器打开按钮可点击
    testWidgets('应能点击浏览器打开按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 先滚动确保按钮可见
      await tester.pumpAndSettle();

      // 查找浏览器打开按钮文字
      final browserButton = find.text('在浏览器中打开论坛');
      expect(browserButton, findsOneWidget);

      // 滚动到按钮位置
      await tester.ensureVisible(browserButton);
      await tester.pumpAndSettle();

      // 点击按钮
      await tester.tap(browserButton);
      await tester.pump();

      // 验证显示 SnackBar 提示
      expect(find.text('将在浏览器中打开论坛登录页面'), findsOneWidget);
    });

    /// 测试目的：验证关闭按钮存在且可交互
    testWidgets('应显示关闭按钮并可交互', (WidgetTester tester) async {
      // 使用 Navigator 包装以支持 pop 操作
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                  settings: settings,
                );
              },
            ),
          ),
        ),
      );

      // 查找关闭按钮
      final closeButton = find.byIcon(Icons.close);
      expect(closeButton, findsOneWidget);

      // 验证按钮是 IconButton 类型
      expect(find.byType(IconButton), findsOneWidget);
    });
  });

  group('LoginPage 样式测试', () {
    /// 测试目的：验证页面布局结构
    testWidgets('应包含 SingleChildScrollView 布局', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 页面内部应该包含 SingleChildScrollView
      expect(find.byType(SingleChildScrollView), findsWidgets);
    });

    /// 测试目的：验证页面使用 Scaffold
    testWidgets('应使用 Scaffold 作为页面根布局', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 验证 LoginPage 内部包含 Scaffold
      final loginPageScaffolds = find.descendant(
        of: find.byType(LoginPage),
        matching: find.byType(Scaffold),
      );
      expect(loginPageScaffolds, findsOneWidget);
    });

    /// 测试目的：验证页面包含 SafeArea
    testWidgets('应包含 SafeArea 布局', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 页面内部应该包含 SafeArea
      expect(find.byType(SafeArea), findsWidgets);
    });
  });
}
