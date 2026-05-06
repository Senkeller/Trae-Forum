import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/feed/feed_card.dart';
import 'package:traeu/presentation/widgets/common/loading_widget.dart';

/// FeedCard Widget 测试
///
/// 测试目标：验证 FeedCard 组件的渲染和交互行为，包括：
/// - 正常渲染
/// - 点击事件
/// - 各种回调触发
/// - 不同配置选项
void main() {
  /// 构建带 ProviderScope 的测试组件
  Widget buildTestWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: child,
          ),
        ),
      ),
    );
  }

  /// 清理测试资源
  Future<void> cleanupTest(WidgetTester tester) async {
    // 等待所有微任务完成
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    // 额外等待以确保 Shimmer 动画停止
    await Future.delayed(const Duration(milliseconds: 200));
  }

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
        buildTestWidget(FeedCard(data: feedData)),
      );

      // 等待组件渲染完成
      await tester.pump();

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
        buildTestWidget(FeedCard(data: feedData)),
      );

      // 等待组件渲染完成
      await tester.pump();

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
        buildTestWidget(FeedCardSimple(data: feedData)),
      );

      // 等待组件渲染完成
      await tester.pump();

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

      // 等待组件渲染完成
      await tester.pump();

      // 骨架屏应渲染 CardSkeletonWidget 组件
      expect(find.byType(CardSkeletonWidget), findsOneWidget);
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
        buildTestWidget(
          FeedCard(
            data: feedData,
            onTap: () => tapped = true,
          ),
        ),
      );

      // 等待组件渲染完成
      await tester.pump();

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
        buildTestWidget(
          FeedCard(
            data: feedData,
            onLike: () => liked = true,
          ),
        ),
      );

      // 等待组件渲染完成
      await tester.pump();

      // 查找并点击点赞按钮（使用 favorite_border 图标）
      final likeButton = find.byIcon(Icons.favorite_border);
      expect(likeButton, findsOneWidget, reason: '应找到点赞按钮');
      await tester.tap(likeButton);
      await tester.pump();
      expect(liked, isTrue);
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
        buildTestWidget(
          FeedCard(
            data: feedData,
            onComment: () => commented = true,
          ),
        ),
      );

      // 等待组件渲染完成
      await tester.pump();

      // 查找并点击评论按钮（使用 chat_bubble_outline 图标）
      final commentButton = find.byIcon(Icons.chat_bubble_outline);
      expect(commentButton, findsOneWidget, reason: '应找到评论按钮');
      await tester.tap(commentButton);
      await tester.pump();
      expect(commented, isTrue);
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
        buildTestWidget(
          FeedCard(
            data: feedData,
            onShare: () => shared = true,
          ),
        ),
      );

      // 等待组件渲染完成
      await tester.pump();

      // 查找并点击分享按钮（使用 share 图标）
      final shareButton = find.byIcon(Icons.share);
      expect(shareButton, findsOneWidget, reason: '应找到分享按钮');
      await tester.tap(shareButton);
      await tester.pump();
      expect(shared, isTrue);
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
        buildTestWidget(
          FeedCard(
            data: feedData,
            showFollowButton: false,
          ),
        ),
      );

      // 等待组件渲染完成
      await tester.pump();

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
        buildTestWidget(
          FeedCard(
            data: feedData,
            showFavoriteButton: false,
          ),
        ),
      );

      // 等待组件渲染完成
      await tester.pump();

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
        buildTestWidget(
          FeedCard(
            data: feedData,
            margin: const EdgeInsets.all(20),
          ),
        ),
      );

      // 等待组件渲染完成
      await tester.pump();

      expect(find.byType(FeedCard), findsOneWidget);
    });
  });
}
