import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/feed/feed_content.dart';
import 'package:traeu/presentation/widgets/common/cached_image.dart';

/// FeedContent Widget 测试
///
/// 测试目标：验证 FeedContent 组件的渲染和交互行为
void main() {
  group('FeedImageContent 测试', () {
    /// 测试目的：验证 FeedImageContent 正常渲染
    testWidgets('FeedImageContent 应正确渲染图片', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedImageContent(
              images: [
                'https://example.com/image1.jpg',
                'https://example.com/image2.jpg',
              ],
            ),
          ),
        ),
      );

      expect(find.byType(OptimizedImageGrid), findsOneWidget);
    });

    testWidgets('1 张图片保持单图样式', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedImageContent(images: ['https://example.com/image1.jpg']),
          ),
        ),
      );

      expect(find.byType(AspectRatio), findsOneWidget);
      expect(find.byType(GridView), findsNothing);
    });

    testWidgets('2 张图片应为并排双图', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedImageContent(
              images: [
                'https://example.com/image1.jpg',
                'https://example.com/image2.jpg',
              ],
            ),
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 2);
      expect(grid.semanticChildCount, 2);
    });

    testWidgets('3 张图片应为并排三图', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedImageContent(
              images: [
                'https://example.com/image1.jpg',
                'https://example.com/image2.jpg',
                'https://example.com/image3.jpg',
              ],
            ),
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
      expect(grid.semanticChildCount, 3);
    });

    testWidgets('大于 9 张图片应按九宫格展示并显示剩余数量', (WidgetTester tester) async {
      final images = List.generate(
        11,
        (index) => 'https://example.com/image$index.jpg',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: FeedImageContent(images: images)),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;
      expect(delegate.crossAxisCount, 3);
      expect(grid.semanticChildCount, 9);
      expect(find.text('+3'), findsOneWidget);
    });

    testWidgets('懒加载模式下点击图片应触发 onImageTap', (WidgetTester tester) async {
      int? tappedIndex;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedImageContent(
              images: const ['https://example.com/image1.jpg'],
              onImageTap: (index) => tappedIndex = index,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(OptimizedImageGrid));
      await tester.pump();

      expect(tappedIndex, 0);
    });
  });

  group('FeedVideoContent 测试', () {
    /// 测试目的：验证 FeedVideoContent 正常渲染
    testWidgets('FeedVideoContent 应正确渲染视频缩略图', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedVideoContent(coverUrl: 'https://example.com/cover.jpg'),
          ),
        ),
      );

      // 验证播放按钮
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
    });

    /// 测试目的：验证视频时长显示
    testWidgets('FeedVideoContent 应正确显示时长', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedVideoContent(
              coverUrl: 'https://example.com/cover.jpg',
              duration: const Duration(minutes: 3, seconds: 45),
            ),
          ),
        ),
      );

      // 验证时长显示
      expect(find.text('03:45'), findsOneWidget);
    });

    /// 测试目的：验证视频点击播放
    testWidgets('点击视频应触发 onPlay 回调', (WidgetTester tester) async {
      bool played = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FeedVideoContent(
              coverUrl: 'https://example.com/cover.jpg',
              onPlay: () => played = true,
            ),
          ),
        ),
      );

      // 点击视频区域
      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(played, isTrue);
    });
  });
}
