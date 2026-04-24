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
  });

  group('FeedVideoContent 测试', () {
    /// 测试目的：验证 FeedVideoContent 正常渲染
    testWidgets('FeedVideoContent 应正确渲染视频缩略图', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FeedVideoContent(
              coverUrl: 'https://example.com/cover.jpg',
            ),
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
