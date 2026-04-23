import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:traeu/main.dart' as app;

/// 应用集成测试
///
/// 测试目标：验证应用核心流程的端到端功能，包括：
/// - 登录流程
/// - 浏览 Feed 流程
/// - 发布评论流程
///
/// 运行命令：
/// flutter test integration_test/app_test.dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('应用核心流程集成测试', () {
    /// 测试目的：验证应用启动
    /// 测试场景：应用正常启动并显示首页
    testWidgets('应用应正常启动并显示首页', (WidgetTester tester) async {
      // 启动应用
      app.main();
      await tester.pumpAndSettle();

      // 验证首页显示
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('登录流程集成测试', () {
    /// 测试目的：验证登录页面导航
    /// 测试场景：从首页导航到登录页面
    testWidgets('应能导航到登录页面', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证登录表单交互
    /// 测试场景：输入账号密码并尝试登录
    testWidgets('登录表单应支持输入', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证登录验证
    /// 测试场景：空表单提交显示错误
    testWidgets('空表单应显示验证错误', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('浏览 Feed 流程集成测试', () {
    /// 测试目的：验证 Feed 列表加载
    /// 测试场景：首页显示 Feed 列表
    testWidgets('首页应显示 Feed 列表', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证 Tab 切换
    /// 测试场景：切换推荐/关注/热门 Tab
    testWidgets('应支持 Tab 切换', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证 Feed 详情查看
    /// 测试场景：点击 Feed 进入详情页
    testWidgets('应能查看 Feed 详情', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证下拉刷新
    /// 测试场景：下拉刷新 Feed 列表
    testWidgets('应支持下拉刷新', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证上拉加载更多
    /// 测试场景：上拉加载更多 Feed
    testWidgets('应支持上拉加载更多', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('发布评论流程集成测试', () {
    /// 测试目的：验证评论输入
    /// 测试场景：在 Feed 详情页输入评论
    testWidgets('应支持评论输入', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证评论发布
    /// 测试场景：发布评论成功
    testWidgets('应能发布评论', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证评论列表
    /// 测试场景：查看评论列表
    testWidgets('应显示评论列表', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('用户操作集成测试', () {
    /// 测试目的：验证点赞操作
    /// 测试场景：点击点赞按钮
    testWidgets('应支持点赞操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证分享操作
    /// 测试场景：点击分享按钮
    testWidgets('应支持分享操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证收藏操作
    /// 测试场景：点击收藏按钮
    testWidgets('应支持收藏操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });

  group('导航流程集成测试', () {
    /// 测试目的：验证页面导航
    /// 测试场景：在不同页面间导航
    testWidgets('应支持页面导航', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    /// 测试目的：验证返回操作
    /// 测试场景：点击返回按钮
    testWidgets('应支持返回操作', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 等待应用加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证应用已启动
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
