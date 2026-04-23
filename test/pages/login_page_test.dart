import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traeu/presentation/pages/user/login_page.dart';

/// LoginPage Widget 测试
///
/// 测试目标：验证登录页面的渲染和交互行为，包括：
/// - 页面基础渲染
/// - 表单输入验证
/// - 登录按钮交互
/// - 第三方登录入口
/// - 注册/忘记密码链接
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
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => const Scaffold(body: Text('Forgot Password')),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const Scaffold(body: Text('Register')),
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

    /// 测试目的：验证账号输入框存在
    testWidgets('应显示账号输入框', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.widgetWithText(TextFormField, '邮箱/手机号'), findsOneWidget);
      expect(find.byIcon(Icons.person_outline), findsOneWidget);
    });

    /// 测试目的：验证密码输入框存在
    testWidgets('应显示密码输入框', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.widgetWithText(TextFormField, '密码'), findsOneWidget);
      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });

    /// 测试目的：验证登录按钮存在
    testWidgets('应显示登录按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.widgetWithText(FilledButton, '登录'), findsOneWidget);
    });
  });

  group('LoginPage 表单验证测试', () {
    /// 测试目的：验证空账号验证
    testWidgets('空账号应显示验证错误', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 点击登录按钮
      await tester.tap(find.widgetWithText(FilledButton, '登录'));
      await tester.pump();

      // 验证错误提示
      expect(find.text('请输入账号'), findsOneWidget);
    });

    /// 测试目的：验证空密码验证
    testWidgets('空密码应显示验证错误', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 输入账号
      await tester.enterText(
        find.widgetWithText(TextFormField, '邮箱/手机号'),
        'test@example.com',
      );

      // 点击登录按钮
      await tester.tap(find.widgetWithText(FilledButton, '登录'));
      await tester.pump();

      // 验证错误提示
      expect(find.text('请输入密码'), findsOneWidget);
    });

    /// 测试目的：验证密码长度验证
    testWidgets('短密码应显示验证错误', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 输入账号
      await tester.enterText(
        find.widgetWithText(TextFormField, '邮箱/手机号'),
        'test@example.com',
      );

      // 输入短密码
      await tester.enterText(
        find.widgetWithText(TextFormField, '密码'),
        '123',
      );

      // 点击登录按钮
      await tester.tap(find.widgetWithText(FilledButton, '登录'));
      await tester.pump();

      // 验证错误提示
      expect(find.text('密码长度不能少于6位'), findsOneWidget);
    });

    /// 测试目的：验证有效表单通过验证
    testWidgets('有效表单应通过验证', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 输入有效账号
      await tester.enterText(
        find.widgetWithText(TextFormField, '邮箱/手机号'),
        'test@example.com',
      );

      // 输入有效密码
      await tester.enterText(
        find.widgetWithText(TextFormField, '密码'),
        'password123',
      );

      await tester.pump();

      // 验证输入成功
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('password123'), findsOneWidget);
    });
  });

  group('LoginPage 交互测试', () {
    /// 测试目的：验证密码可见性切换
    testWidgets('应支持切换密码可见性', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 查找密码可见性切换按钮
      final visibilityButton = find.byIcon(Icons.visibility_outlined);
      expect(visibilityButton, findsOneWidget);

      // 点击切换
      await tester.tap(visibilityButton);
      await tester.pump();

      // 验证图标切换
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    /// 测试目的：验证忘记密码链接
    testWidgets('应显示忘记密码链接', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.text('忘记密码?'), findsOneWidget);
    });

    /// 测试目的：验证注册入口
    testWidgets('应显示注册入口', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.text('还没有账号?'), findsOneWidget);
      expect(find.text('立即注册'), findsOneWidget);
    });

    /// 测试目的：验证第三方登录按钮
    testWidgets('应显示第三方登录按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      expect(find.text('或使用以下方式登录'), findsOneWidget);
      expect(find.text('微信'), findsOneWidget);
      expect(find.text('QQ'), findsOneWidget);
      expect(find.text('GitHub'), findsOneWidget);
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
  });

  group('LoginPage 输入交互测试', () {
    /// 测试目的：验证账号输入
    testWidgets('应支持输入账号', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 输入账号
      await tester.enterText(
        find.widgetWithText(TextFormField, '邮箱/手机号'),
        'user@example.com',
      );
      await tester.pump();

      expect(find.text('user@example.com'), findsOneWidget);
    });

    /// 测试目的：验证密码输入
    testWidgets('应支持输入密码', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(
            routerConfig: createTestRouter(),
          ),
        ),
      );

      // 输入密码
      await tester.enterText(
        find.widgetWithText(TextFormField, '密码'),
        'mypassword123',
      );
      await tester.pump();

      // 密码字段通常显示为点，但输入应该成功
      expect(find.text('mypassword123'), findsOneWidget);
    });
  });
}
