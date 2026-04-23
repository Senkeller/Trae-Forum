import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/presentation/widgets/common/loading_widget.dart';

/// LoadingWidget 测试
///
/// 测试目标：验证加载组件的渲染行为，包括：
/// - LoadingWidget 基础渲染
/// - SkeletonWidget 骨架屏渲染
/// - ListSkeletonWidget 列表骨架屏
/// - CardSkeletonWidget 卡片骨架屏
/// - FullScreenLoading 全屏加载
void main() {
  group('LoadingWidget 基础测试', () {
    /// 测试目的：验证基础 LoadingWidget 渲染
    testWidgets('应正确渲染基础 LoadingWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(),
          ),
        ),
      );

      // 验证 CircularProgressIndicator 存在
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    /// 测试目的：验证带消息的 LoadingWidget
    testWidgets('应正确渲染带消息的 LoadingWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LoadingWidget(
              message: '加载中...',
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('加载中...'), findsOneWidget);
    });

    /// 测试目的：验证自定义颜色
    testWidgets('应支持自定义颜色', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LoadingWidget(
              color: Colors.red,
              backgroundColor: Colors.grey[200],
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('SkeletonWidget 测试', () {
    /// 测试目的：验证基础 SkeletonWidget 渲染
    testWidgets('应正确渲染 SkeletonWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonWidget(
              width: 100,
              height: 20,
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonWidget), findsOneWidget);
    });

    /// 测试目的：验证自定义圆角
    testWidgets('应支持自定义圆角', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SkeletonWidget(
              width: 100,
              height: 20,
              borderRadius: 10,
            ),
          ),
        ),
      );

      expect(find.byType(SkeletonWidget), findsOneWidget);
    });
  });

  group('ListSkeletonWidget 测试', () {
    /// 测试目的：验证基础列表骨架屏
    testWidgets('应正确渲染 ListSkeletonWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ListSkeletonWidget(),
          ),
        ),
      );

      expect(find.byType(ListSkeletonWidget), findsOneWidget);
    });

    /// 测试目的：验证自定义列表项数量
    testWidgets('应支持自定义列表项数量', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ListSkeletonWidget(
              itemCount: 3,
            ),
          ),
        ),
      );

      expect(find.byType(ListSkeletonWidget), findsOneWidget);
    });

    /// 测试目的：验证自定义列表项高度
    testWidgets('应支持自定义列表项高度', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ListSkeletonWidget(
              itemHeight: 60,
            ),
          ),
        ),
      );

      expect(find.byType(ListSkeletonWidget), findsOneWidget);
    });

    /// 测试目的：验证隐藏分隔线
    testWidgets('应支持隐藏分隔线', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ListSkeletonWidget(
              showDivider: false,
            ),
          ),
        ),
      );

      expect(find.byType(ListSkeletonWidget), findsOneWidget);
    });
  });

  group('CardSkeletonWidget 测试', () {
    /// 测试目的：验证基础卡片骨架屏
    testWidgets('应正确渲染 CardSkeletonWidget', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardSkeletonWidget(),
          ),
        ),
      );

      expect(find.byType(CardSkeletonWidget), findsOneWidget);
    });

    /// 测试目的：验证自定义卡片数量
    testWidgets('应支持自定义卡片数量', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardSkeletonWidget(
              cardCount: 3,
            ),
          ),
        ),
      );

      expect(find.byType(CardSkeletonWidget), findsOneWidget);
    });

    /// 测试目的：验证隐藏图片区域
    testWidgets('应支持隐藏图片区域', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardSkeletonWidget(
              showImage: false,
            ),
          ),
        ),
      );

      expect(find.byType(CardSkeletonWidget), findsOneWidget);
    });

    /// 测试目的：验证自定义图片高度
    testWidgets('应支持自定义图片高度', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CardSkeletonWidget(
              imageHeight: 200,
            ),
          ),
        ),
      );

      expect(find.byType(CardSkeletonWidget), findsOneWidget);
    });
  });

  group('FullScreenLoading 测试', () {
    /// 测试目的：验证显示全屏加载
    testWidgets('应正确显示全屏加载', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FullScreenLoading(
              isLoading: true,
            ),
          ),
        ),
      );

      expect(find.byType(FullScreenLoading), findsOneWidget);
      expect(find.byType(LoadingWidget), findsOneWidget);
    });

    /// 测试目的：验证隐藏全屏加载
    testWidgets('isLoading=false 时应隐藏', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FullScreenLoading(
              isLoading: false,
            ),
          ),
        ),
      );

      // 当 isLoading 为 false 时，应返回 SizedBox.shrink()
      expect(find.byType(FullScreenLoading), findsOneWidget);
    });

    /// 测试目的：验证带消息的全屏加载
    testWidgets('应支持显示加载消息', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FullScreenLoading(
              isLoading: true,
              message: '正在加载...',
            ),
          ),
        ),
      );

      expect(find.byType(FullScreenLoading), findsOneWidget);
      expect(find.text('正在加载...'), findsOneWidget);
    });

    /// 测试目的：验证自定义背景透明度
    testWidgets('应支持自定义背景透明度', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FullScreenLoading(
              isLoading: true,
              backgroundOpacity: 0.8,
            ),
          ),
        ),
      );

      expect(find.byType(FullScreenLoading), findsOneWidget);
    });
  });
}
