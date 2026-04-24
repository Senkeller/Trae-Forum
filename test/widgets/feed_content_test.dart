import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/feed/feed_content.dart';

/// FeedContent Widget 测试
///
/// 测试目标：验证 FeedContent 组件的渲染和交互行为，包括：
/// - 文字内容渲染和截断逻辑
/// - 展开/收起功能
/// - 图片网格渲染
/// - 点击事件处理
void main() {
  group('FeedContent 文字内容测试', () {
    /// 测试目的：验证文字内容正常渲染
    testWidgets('应正确渲染文字内容', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedContent(
              text: '这是一条测试动态内容',
            ),
          ),
        ),
      );

      expect(find.text('这是一条测试动态内容'), findsOneWidget);
    });

    /// 测试目的：验证空文字不渲染
    testWidgets('空文字内容不应渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedContent(
              text: '',
            ),
          ),
        ),
      );

      // 空文字时不应渲染文字内容区域
      expect(find.byType(GestureDetector), findsNothing);
    });

    /// 测试目的：验证 null 文字不渲染
    testWidgets('null 文字内容不应渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedContent(),
          ),
        ),
      );

      // null 文字时不应渲染文字内容区域
      expect(find.byType(GestureDetector), findsNothing);
    });

    /// 测试目的：验证长文本截断逻辑
    testWidgets('长文本应显示展开按钮', (WidgetTester tester) async {
      // 构造一个超过4行的长文本
      final longText = '这是一段很长的文本内容。' * 20;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedContent(
              text: longText,
              isExpanded: false,
              maxLines: 4,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 应该显示展开按钮（...查看更多）
      expect(find.textContaining('查看更多'), findsOneWidget);
    });

    /// 测试目的：验证展开状态显示完整内容
    testWidgets('展开状态应显示完整内容', (WidgetTester tester) async {
      final longText = '这是一段很长的文本内容。' * 20;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedContent(
              text: longText,
              isExpanded: true,
              maxLines: 4,
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 展开状态不应显示展开按钮，而应显示收起按钮
      expect(find.text('收起'), findsOneWidget);
    });

    /// 测试目的：验证点击展开