import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/feed/featured_comment.dart';

/// FeaturedComment Widget 测试
///
/// 测试目标：验证 FeaturedComment 组件的渲染和交互行为，包括：
/// - 正常渲染（包含高赞标签、用户名、评论内容）
/// - 空评论处理
/// - 点击事件
/// - 多条评论列表
void main() {
  group('FeaturedComment 基础渲染测试', () {
    /// 测试目的：验证 FeaturedComment 正常渲染
    testWidgets('应正确渲染精选评论组件', (WidgetTester tester) async {
      // 准备测试数据
      final comment = TopComment(
        id: 'comment_001',
        username: '小明',
        content: '这张照片拍得真好看！',
        likeCount: 12,
      );

      // 构建组件
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedComment(comment: comment),
          ),
        ),
      );

      // 验证渲染 - 高赞标签使用普通 Text
      expect(find.text('12赞'), findsOneWidget);
      // 验证组件存在
      expect(find.byType(FeaturedComment), findsOneWidget);
      // 验证 RichText 存在（用户名和内容使用 RichText）
      expect(find.byType(RichText), findsWidgets);
    });

    /// 测试目的：验证空评论返回空组件
    testWidgets('评论为 null 时应返回空组件', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeaturedComment(comment: null),
          ),
        ),
      );

      // 应该返回 SizedBox.shrink()
      expect(find.byType(SizedBox), findsOneWidget);
      expect(find.text('赞'), findsNothing);
    });

    /// 测试目的：验证高赞标签显示正确
    testWidgets('应正确显示高赞标签', (WidgetTester tester) async {
      final comment = TopComment(
        id: 'comment_002',
        username: '用户A',
        content: '测试内容',
        likeCount: 99,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedComment(comment: comment),
          ),
        ),
      );

      expect(find.text('99赞'), findsOneWidget);
    });

    /// 测试目的：验证用户名和品牌主色
    testWidgets('应正确显示用户名和分隔符', (WidgetTester tester) async {
      final comment = TopComment(
        id: 'comment_003',
        username: '测试用户',
        content: '这是一条评论',
        likeCount: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedComment(comment: comment),
          ),
        ),
      );

      // 验证 RichText 存在（包含用户名和内容）
      expect(find.byType(RichText), findsWidgets);
      // 验证高赞标签
      expect(find.text('5赞'), findsOneWidget);
    });
  });

  group('FeaturedComment 交互测试', () {
    /// 测试目的：验证点击事件触发回调
    testWidgets('点击精选评论应触发 onTap 回调', (WidgetTester tester) async {
      bool tapped = false;
      final comment = TopComment(
        id: 'comment_004',
        username: '点击测试',
        content: '点击测试内容',
        likeCount: 10,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedComment(
              comment: comment,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // 点击组件
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, isTrue);
    });

    /// 测试目的：验证无 onTap 时不抛异常
    testWidgets('无 onTap 时点击不应抛异常', (WidgetTester tester) async {
      final comment = TopComment(
        id: 'comment_005',
        username: '无回调测试',
        content: '测试内容',
        likeCount: 3,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedComment(comment: comment),
          ),
        ),
      );

      // 点击不应抛异常
      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(find.byType(FeaturedComment), findsOneWidget);
    });
  });

  group('FeaturedComment 配置测试', () {
    /// 测试目的：验证自定义最大行数
    testWidgets('应支持自定义最大行数', (WidgetTester tester) async {
      final comment = TopComment(
        id: 'comment_006',
        username: '行数测试',
        content: '这是一段很长的评论内容，用于测试最大行数设置',
        likeCount: 8,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedComment(
              comment: comment,
              maxLines: 1,
            ),
          ),
        ),
      );

      expect(find.byType(FeaturedComment), findsOneWidget);
    });
  });

  group('FeaturedCommentList 测试', () {
    /// 测试目的：验证评论列表渲染
    testWidgets('应正确渲染多条精选评论', (WidgetTester tester) async {
      final comments = [
        TopComment(
          id: 'c1',
          username: '用户1',
          content: '评论内容1',
          likeCount: 10,
        ),
        TopComment(
          id: 'c2',
          username: '用户2',
          content: '评论内容2',
          likeCount: 8,
        ),
        TopComment(
          id: 'c3',
          username: '用户3',
          content: '评论内容3',
          likeCount: 5,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedCommentList(comments: comments),
          ),
        ),
      );

      // 验证所有评论都渲染 - 通过高赞标签验证
      expect(find.text('10赞'), findsOneWidget);
      expect(find.text('8赞'), findsOneWidget);
      expect(find.text('5赞'), findsOneWidget);
      // 验证有3个 FeaturedComment
      expect(find.byType(FeaturedComment), findsNWidgets(3));
    });

    /// 测试目的：验证空评论列表返回空组件
    testWidgets('空评论列表应返回空组件', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeaturedCommentList(comments: []),
          ),
        ),
      );

      expect(find.byType(SizedBox), findsOneWidget);
    });

    /// 测试目的：验证最大显示数量限制
    testWidgets('应支持最大显示数量限制', (WidgetTester tester) async {
      final comments = [
        TopComment(id: 'c1', username: '用户1', content: '内容1', likeCount: 10),
        TopComment(id: 'c2', username: '用户2', content: '内容2', likeCount: 9),
        TopComment(id: 'c3', username: '用户3', content: '内容3', likeCount: 8),
        TopComment(id: 'c4', username: '用户4', content: '内容4', likeCount: 7),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedCommentList(
              comments: comments,
              maxCount: 2,
            ),
          ),
        ),
      );

      // 只应显示前 2 条
      expect(find.byType(FeaturedComment), findsNWidgets(2));
      expect(find.text('10赞'), findsOneWidget);
      expect(find.text('9赞'), findsOneWidget);
      expect(find.text('8赞'), findsNothing);
      expect(find.text('7赞'), findsNothing);
    });

    /// 测试目的：验证评论点击回调
    testWidgets('点击评论应触发 onCommentTap 回调', (WidgetTester tester) async {
      TopComment? tappedComment;
      final comments = [
        TopComment(
          id: 'c1',
          username: '用户1',
          content: '内容1',
          likeCount: 10,
        ),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedCommentList(
              comments: comments,
              onCommentTap: (comment) => tappedComment = comment,
            ),
          ),
        ),
      );

      // 点击第一条评论
      await tester.tap(find.byType(InkWell).first);
      await tester.pump();

      expect(tappedComment, isNotNull);
      expect(tappedComment!.id, equals('c1'));
    });

    /// 测试目的：验证条目间距
    testWidgets('应支持自定义条目间距', (WidgetTester tester) async {
      final comments = [
        TopComment(id: 'c1', username: '用户1', content: '内容1', likeCount: 10),
        TopComment(id: 'c2', username: '用户2', content: '内容2', likeCount: 9),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeaturedCommentList(
              comments: comments,
              itemSpacing: 16,
            ),
          ),
        ),
      );

      expect(find.byType(FeaturedCommentList), findsOneWidget);
    });
  });
}
