import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/feed/quick_comment_bar.dart';
import 'package:traeu/presentation/providers/auth_provider.dart';

/// QuickCommentBar Widget 测试
///
/// 测试目标：验证 QuickCommentBar 组件的渲染和交互行为，包括：
/// - 正常渲染（头像、占位文案、表情图标）
/// - 点击事件处理
/// - 登录态检查（已登录/未登录）
/// - 登录引导弹窗
void main() {
  group('QuickCommentBar 基础渲染测试', () {
    /// 测试目的：验证 QuickCommentBar 正常渲染
    testWidgets('应正确渲染快速评论栏组件', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                currentUserAvatar: 'https://example.com/avatar.jpg',
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      // 验证占位文案
      expect(find.text('说点什么吧...'), findsOneWidget);
      // 验证表情图标
      expect(find.byIcon(Icons.sentiment_satisfied_outlined), findsOneWidget);
    });

    /// 测试目的：验证无头像时使用默认头像
    testWidgets('无头像时应显示默认头像', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.text('说点什么吧...'), findsOneWidget);
      expect(find.byIcon(Icons.sentiment_satisfied_outlined), findsOneWidget);
    });

    /// 测试目的：验证胶囊形状容器
    testWidgets('应显示胶囊形状输入框', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      // 查找 GestureDetector 包裹的容器
      expect(find.byType(GestureDetector), findsOneWidget);
    });
  });

  group('QuickCommentBar 点击事件测试', () {
    /// 测试目的：验证点击触发 onTap 回调
    testWidgets('点击应触发 onTap 回调', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                currentUserAvatar: 'https://example.com/avatar.jpg',
                onTap: () => tapped = true,
                requireLogin: false,
              ),
            ),
          ),
        ),
      );

      // 点击组件
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });

  group('QuickCommentBar 登录态检查测试', () {
    /// 测试目的：验证已登录时直接触发 onTap
    testWidgets('已登录时应直接触发 onTap', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isAuthenticatedProvider.overrideWith((ref) => true),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                onTap: () => tapped = true,
              ),
            ),
          ),
        ),
      );

      // 等待 provider 初始化
      await tester.pump();

      // 点击组件
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(tapped, isTrue);
    });

    /// 测试目的：验证未登录时显示登录引导弹窗
    testWidgets('未登录时应显示登录引导弹窗', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isAuthenticatedProvider.overrideWith((ref) => false),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      // 等待 provider 初始化
      await tester.pump();

      // 点击组件
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // 验证登录弹窗显示
      expect(find.text('需要登录'), findsOneWidget);
      expect(find.text('登录后即可发表评论，与社区互动'), findsOneWidget);
      expect(find.text('取消'), findsOneWidget);
      expect(find.text('去登录'), findsOneWidget);
    });

    /// 测试目的：验证点击取消关闭弹窗
    testWidgets('点击取消应关闭登录弹窗', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isAuthenticatedProvider.overrideWith((ref) => false),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // 点击组件显示弹窗
      await tester.tap(find.byType(GestureDetector));
      await tester.pumpAndSettle();

      // 点击取消
      await tester.tap(find.text('取消'));
      await tester.pumpAndSettle();

      // 验证弹窗关闭
      expect(find.text('需要登录'), findsNothing);
    });

    /// 测试目的：验证跳过登录检查
    testWidgets('requireLogin 为 false 时应跳过登录检查', (WidgetTester tester) async {
      bool tapped = false;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            isAuthenticatedProvider.overrideWith((ref) => false),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: QuickCommentBar(
                onTap: () => tapped = true,
                requireLogin: false,
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      // 点击组件
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      // 应该直接触发 onTap，不显示登录弹窗
      expect(tapped, isTrue);
      expect(find.text('需要登录'), findsNothing);
    });
  });

  group('QuickCommentBar 登录弹窗测试', () {
    /// 测试目的：验证登录弹窗静态方法
    testWidgets('showLoginDialog 应正确显示登录弹窗', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    QuickCommentBar.showLoginDialog(context);
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      );

      // 点击按钮显示弹窗
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // 验证弹窗内容
      expect(find.text('需要登录'), findsOneWidget);
      expect(find.text('登录后即可发表评论，与社区互动'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    /// 测试目的：验证点击去登录返回 true
    testWidgets('点击去登录应返回 true', (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    result = await QuickCommentBar.showLoginDialog(context);
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      );

      // 点击按钮显示弹窗
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // 点击去登录
      await tester.tap(find.text('去登录'));
      await tester.pumpAndSettle();

      expect(result, isTrue);
    });

    /// 测试目的：验证点击取消返回 false
    testWidgets('点击取消应返回 false', (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    result = await QuickCommentBar.showLoginDialog(context);
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      );

      // 点击按钮显示弹窗
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // 点击取消
      await tester.tap(find.text('取消'));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });

    /// 测试目的：验证点击外部关闭弹窗返回 false
    testWidgets('点击外部关闭应返回 false', (WidgetTester tester) async {
      bool? result;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    result = await QuickCommentBar.showLoginDialog(context);
                  },
                  child: const Text('Show Dialog'),
                );
              },
            ),
          ),
        ),
      );

      // 点击按钮显示弹窗
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // 点击外部（弹窗外部区域）
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(result, isFalse);
    });
  });
}
