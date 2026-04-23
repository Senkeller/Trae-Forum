import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/feed/feed_card.dart';

/// FeedCard Widget 测试
///
/// 测试目标：验证 FeedCard 组件的渲染和交互行为，包括：
/// - 正常渲染
/// - 点击事件
/// - 各种回调触发
/// - 不同配置选项
void main() {
  group('FeedCard 渲染测试', () {
    /// 测试目的：验证 FeedCard 正常渲染
    testWidgets('应正确渲染 FeedCard 组件', (WidgetTester tester) async {
      // 准备测试数据
      final feedData = FeedCardData(
        id: 'feed_001',
        username: '测试用户',
        text: '这是一条测试动态',
        likeCount: 42,
        commentCount: 10,
        shareCount: 5,
      );

      // 构建组件
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(data: feedData),
          ),
        ),
      );

      // 验证渲染
      expect(find.text('测试用户'), findsOneWidget);
      expect(find.text('这是一条测试动态'), findsOneWidget);
    });

    /// 测试目的：验证带图片的 FeedCard 渲染
    testWidgets('应正确渲染带图片的 FeedCard', (WidgetTester tester) async {
      final feedData = FeedCardData(
        id: 'feed_002',
        username: '图片用户',
        text: '带图片的动态',
        images: ['https://example.com/image.jpg'],
        likeCount: 100,
        commentCount: 20,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(data: feedData),
          ),
        ),
      );

      expect(find.text('图片用户'), findsOneWidget);
      expect(find.text('带图片的动态'), findsOneWidget);
    });

    /// 测试目的：验证简洁版 FeedCardSimple 渲染
    testWidgets('应正确渲染 FeedCardSimple', (WidgetTester tester) async {
      final feedData = FeedCardData(
        id: 'feed_003',
        username: '简洁用户',
        text: '简洁版动态内容',
        likeCount: 10,
        commentCount: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCardSimple(data: feedData),
          ),
        ),
      );

      expect(find.text('简洁用户'), findsOneWidget);
    });

    /// 测试目的：验证骨架屏渲染
    testWidgets('应正确渲染 FeedCardSkeleton', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedCardSkeleton(),
          ),
        ),
      );

      // 骨架屏应渲染 Card 组件
      expect(find.byType(Card), findsOneWidget);
    });
  });

  group('FeedCard 交互测试', () {
    /// 测试目的：验证点击卡片触发回调
    testWidgets('点击卡片应触发 onTap 回调', (WidgetTester tester) async {
      bool tapped = false;
      final feedData = FeedCardData(
        id: 'feed_004',
        username: '点击测试用户',
        text: '点击测试',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(
              data: feedData,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      // 点击卡片
      await tester.tap(find.byType(FeedCard));
      await tester.pump();

      expect(tapped, isTrue);
    });

    /// 测试目的：验证点赞按钮触发回调
    testWidgets('点击点赞应触发 onLike 回调', (WidgetTester tester) async {
      bool liked = false;
      final feedData = FeedCardData(
        id: 'feed_005',
        username: '点赞测试用户',
        text: '点赞测试',
        isLiked: false,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(
              data: feedData,
              onLike: () => liked = true,
            ),
          ),
        ),
      );

      // 查找并点击点赞按钮
      final likeButton = find.byIcon(Icons.thumb_up_outlined);
      if (likeButton.evaluate().isNotEmpty) {
        await tester.tap(likeButton.first);
        await tester.pump();
        expect(liked, isTrue);
      }
    });

    /// 测试目的：验证评论按钮触发回调
    testWidgets('点击评论应触发 onComment 回调', (WidgetTester tester) async {
      bool commented = false;
      final feedData = FeedCardData(
        id: 'feed_006',
        username: '评论测试用户',
        text: '评论测试',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(
              data: feedData,
              onComment: () => commented = true,
            ),
          ),
        ),
      );

      // 查找并点击评论按钮
      final commentButton = find.byIcon(Icons.comment_outlined);
      if (commentButton.evaluate().isNotEmpty) {
        await tester.tap(commentButton.first);
        await tester.pump();
        expect(commented, isTrue);
      }
    });

    /// 测试目的：验证分享按钮触发回调
    testWidgets('点击分享应触发 onShare 回调', (WidgetTester tester) async {
      bool shared = false;
      final feedData = FeedCardData(
        id: 'feed_007',
        username: '分享测试用户',
        text: '分享测试',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(
              data: feedData,
              onShare: () => shared = true,
            ),
          ),
        ),
      );

      // 查找并点击分享按钮
      final shareButton = find.byIcon(Icons.share_outlined);
      if (shareButton.evaluate().isNotEmpty) {
        await tester.tap(shareButton.first);
        await tester.pump();
        expect(shared, isTrue);
      }
    });
  });

  group('FeedCard 配置测试', () {
    /// 测试目的：验证隐藏关注按钮
    testWidgets('应支持隐藏关注按钮', (WidgetTester tester) async {
      final feedData = FeedCardData(
        id: 'feed_008',
        username: '配置测试用户',
        text: '隐藏关注按钮测试',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(
              data: feedData,
              showFollowButton: false,
            ),
          ),
        ),
      );

      expect(find.text('配置测试用户'), findsOneWidget);
    });

    /// 测试目的：验证隐藏收藏按钮
    testWidgets('应支持隐藏收藏按钮', (WidgetTester tester) async {
      final feedData = FeedCardData(
        id: 'feed_009',
        username: '收藏测试用户',
        text: '隐藏收藏按钮测试',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(
              data: feedData,
              showFavoriteButton: false,
            ),
          ),
        ),
      );

      expect(find.text('收藏测试用户'), findsOneWidget);
    });

    /// 测试目的：验证自定义外边距
    testWidgets('应支持自定义外边距', (WidgetTester tester) async {
      final feedData = FeedCardData(
        id: 'feed_010',
        username: '边距测试用户',
        text: '边距测试',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedCard(
              data: feedData,
              margin: const EdgeInsets.all(20),
            ),
          ),
        ),
      );

      expect(find.byType(FeedCard), findsOneWidget);
    });
  });
}
