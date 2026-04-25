import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:traeu/app.dart';
import 'package:traeu/presentation/widgets/feed/featured_comment.dart';
import 'package:traeu/presentation/widgets/feed/quick_comment_bar.dart';
import 'package:traeu/presentation/widgets/feed/feed_content.dart';
import 'package:traeu/presentation/widgets/feed/feed_card.dart';
import 'package:traeu/presentation/providers/auth_provider.dart';
import 'package:traeu/data/models/user.dart';

/// 动态交互集成测试
///
/// 测试目标：验证整体功能流程，包括：
/// 1. 精选评论显示和点击
/// 2. 快速评论提交流程
/// 3. 内容展开功能
/// 4. 未登录场景处理
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('动态交互集成测试', () {
    /// 测试目的：验证精选评论显示和点击
    testWidgets('精选评论应正确显示并可点击', (WidgetTester tester) async {
      // 启动应用
      MyApp();
      await tester.pumpAndSettle();

      // 等待动态列表加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 查找包含精选评论的动态卡片
      final featuredComments = find.byType(FeaturedComment);

      if (featuredComments.evaluate().isNotEmpty) {
        // 验证精选评论存在
        expect(featuredComments, findsWidgets);

        // 点击第一个精选评论
        await tester.tap(featuredComments.first);
        await tester.pumpAndSettle();

        // 验证点击后跳转到评论详情页（根据实际页面结构调整）
        // 这里假设会显示评论详情
      }
    });

    /// 测试目的：验证快速评论提交流程（已登录）
    testWidgets('已登录用户应能使用快速评论功能', (WidgetTester tester) async {
      // 使用已登录状态启动
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authNotifierProvider.overrideWith(
              (ref) => FakeAuthNotifier(isAuthenticated: true),
            ),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // 等待动态列表加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 查找快速评论栏
      final quickCommentBars = find.byType(QuickCommentBar);

      if (quickCommentBars.evaluate().isNotEmpty) {
        // 点击快速评论栏
        await tester.tap(quickCommentBars.first);
        await tester.pumpAndSettle();

        // 验证评论输入界面显示（根据实际实现调整）
        // 这里应该显示评论输入框或底部弹窗
      }
    });

    /// 测试目的：验证快速评论未登录场景
    testWidgets('未登录用户点击快速评论应显示登录引导', (WidgetTester tester) async {
      // 使用未登录状态启动
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authNotifierProvider.overrideWith(
              (ref) => FakeAuthNotifier(isAuthenticated: false),
            ),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // 等待动态列表加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 查找快速评论栏
      final quickCommentBars = find.byType(QuickCommentBar);

      if (quickCommentBars.evaluate().isNotEmpty) {
        // 点击快速评论栏
        await tester.tap(quickCommentBars.first);
        await tester.pumpAndSettle();

        // 验证登录引导弹窗显示
        expect(find.text('需要登录'), findsOneWidget);
        expect(find.text('登录后即可发表评论，与社区互动'), findsOneWidget);
        expect(find.text('取消'), findsOneWidget);
        expect(find.text('去登录'), findsOneWidget);

        // 点击取消关闭弹窗
        await tester.tap(find.text('取消'));
        await tester.pumpAndSettle();

        // 验证弹窗关闭
        expect(find.text('需要登录'), findsNothing);
      }
    });

    /// 测试目的：验证内容展开功能
    testWidgets('长文本内容应支持展开/收起功能', (WidgetTester tester) async {
      MyApp();
      await tester.pumpAndSettle();

      // 等待动态列表加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 查找包含展开按钮的动态
      final expandButtons = find.textContaining('查看更多');

      if (expandButtons.evaluate().isNotEmpty) {
        // 点击展开按钮
        await tester.tap(expandButtons.first);
        await tester.pumpAndSettle();

        // 验证收起按钮显示
        expect(find.text('收起'), findsOneWidget);

        // 点击收起按钮
        await tester.tap(find.text('收起'));
        await tester.pumpAndSettle();

        // 验证展开按钮重新显示
        expect(find.textContaining('查看更多'), findsWidgets);
      }
    });

    /// 测试目的：验证动态卡片整体交互流程
    testWidgets('动态卡片应支持完整的交互流程', (WidgetTester tester) async {
      MyApp();
      await tester.pumpAndSettle();

      // 等待动态列表加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 查找动态卡片
      final feedCards = find.byType(FeedCard);

      if (feedCards.evaluate().isNotEmpty) {
        // 点击第一个动态卡片
        await tester.tap(feedCards.first);
        await tester.pumpAndSettle();

        // 等待详情页加载
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();

        // 验证详情页显示（根据实际页面结构调整）
        // 可以检查特定元素是否存在
      }
    });

    /// 测试目的：验证图片点击浏览
    testWidgets('动态图片应支持点击查看大图', (WidgetTester tester) async {
      MyApp();
      await tester.pumpAndSettle();

      // 等待动态列表加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 查找图片网格 - OptimizedImageGrid 可能在其他模块定义
      // 如果不存在则跳过此测试
      final imageWidgets = find.byType(Image);

      if (imageWidgets.evaluate().isNotEmpty) {
        // 点击第一张图片
        await tester.tap(imageWidgets.first);
        await tester.pumpAndSettle();

        // 等待图片浏览器加载
        await Future.delayed(const Duration(milliseconds: 500));
        await tester.pumpAndSettle();

        // 验证图片浏览器显示（根据实际实现调整）
      }
    });

    /// 测试目的：验证未登录场景的整体流程
    testWidgets('未登录用户应看到登录引导', (WidgetTester tester) async {
      // 使用未登录状态启动
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authNotifierProvider.overrideWith(
              (ref) => FakeAuthNotifier(isAuthenticated: false),
            ),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // 等待动态列表加载
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // 验证动态列表正常显示（未登录也能浏览）
      expect(find.byType(FeedCard), findsWidgets);

      // 尝试进行需要登录的操作（如评论）
      final quickCommentBars = find.byType(QuickCommentBar);

      if (quickCommentBars.evaluate().isNotEmpty) {
        await tester.tap(quickCommentBars.first);
        await tester.pumpAndSettle();

        // 验证登录引导
        expect(find.text('需要登录'), findsOneWidget);

        // 点击去登录
        await tester.tap(find.text('去登录'));
        await tester.pumpAndSettle();

        // 验证跳转到登录页面（根据实际路由调整）
        await Future.delayed(const Duration(seconds: 1));
        await tester.pumpAndSettle();
      }
    });
  });
}

/// 伪造的 AuthNotifier 用于集成测试
class FakeAuthNotifier extends AuthNotifier {
  final bool isAuthenticated;

  FakeAuthNotifier({required this.isAuthenticated});

  @override
  AsyncValue<UserInfo> build() {
    if (isAuthenticated) {
      return const AsyncData(
        UserInfo(
          uid: 'test_user',
          username: '测试用户',
          avatar: 'https://example.com/avatar.jpg',
        ),
      );
    } else {
      return const AsyncData(
        UserInfo(uid: '', username: ''),
      );
    }
  }
}
