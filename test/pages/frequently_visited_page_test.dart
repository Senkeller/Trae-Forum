import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traeu/data/models/user_activity.dart';
import 'package:traeu/presentation/pages/user/frequently_visited_page.dart';
import 'package:traeu/presentation/providers/user_activity_provider.dart';

/// 测试路由路径
class TestRoutePaths {
  static const String frequentlyVisited = '/user/frequently-visited';
  static const String topicDetail = '/topic/:tag';
}

/// 模拟话题详情页
class MockTopicDetailPage extends StatelessWidget {
  final String tag;

  const MockTopicDetailPage({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Topic: $tag')),
      body: Center(child: Text('Tag: $tag')),
    );
  }
}

/// Mock FrequentlyVisitedList Provider
class MockFrequentlyVisitedList extends FrequentlyVisitedList {
  final List<FrequentlyVisited> items;

  MockFrequentlyVisitedList(this.items);

  @override
  Future<List<FrequentlyVisited>> build() async {
    return items;
  }
}

void main() {
  group('FrequentlyVisitedPage Widget Tests', () {
    /// 创建测试用的 FrequentlyVisited 数据
    FrequentlyVisited createTestItem({
      required String id,
      required String topicId,
      required String topicName,
      String? topicTag,
      int visitCount = 1,
      DateTime? lastVisitedAt,
    }) {
      return FrequentlyVisited(
        id: id,
        topicId: topicId,
        topicName: topicName,
        topicTag: topicTag,
        visitCount: visitCount,
        lastVisitedAt: lastVisitedAt ?? DateTime.now(),
      );
    }

    /// 构建测试用的 ProviderScope
    ProviderScope buildTestScope({
      required List<FrequentlyVisited> items,
      required GoRouter router,
    }) {
      return ProviderScope(
        overrides: [
          frequentlyVisitedListProvider.overrideWith(() => MockFrequentlyVisitedList(items)),
        ],
        child: MaterialApp.router(
          routerConfig: router,
        ),
      );
    }

    testWidgets('页面应该正确渲染标题', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: [], router: router),
      );

      await tester.pumpAndSettle();

      expect(find.text('我常去'), findsOneWidget);
    });

    testWidgets('空状态应该显示正确提示', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: [], router: router),
      );

      await tester.pumpAndSettle();

      expect(find.text('暂无常去记录'), findsOneWidget);
      expect(find.text('浏览话题时会自动记录'), findsOneWidget);
      expect(find.byIcon(Icons.location_on_outlined), findsOneWidget);
    });

    testWidgets('列表应该正确渲染条目', (WidgetTester tester) async {
      final testItems = [
        createTestItem(
          id: '1',
          topicId: 'topic-123',
          topicName: 'Flutter 开发',
          topicTag: 'flutter',
          visitCount: 5,
        ),
        createTestItem(
          id: '2',
          topicId: 'topic-456',
          topicName: 'Dart 编程',
          topicTag: 'dart',
          visitCount: 3,
        ),
      ];

      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: testItems, router: router),
      );

      await tester.pumpAndSettle();

      // 验证话题名称显示
      expect(find.text('Flutter 开发'), findsOneWidget);
      expect(find.text('Dart 编程'), findsOneWidget);

      // 验证访问次数显示
      expect(find.text('访问 5 次'), findsOneWidget);
      expect(find.text('访问 3 次'), findsOneWidget);

      // 验证标签显示
      expect(find.text('flutter'), findsOneWidget);
      expect(find.text('dart'), findsOneWidget);
    });

    testWidgets('点击条目应该使用 topicTag 跳转到话题详情页', (WidgetTester tester) async {
      final testItems = [
        createTestItem(
          id: '1',
          topicId: 'topic-123',
          topicName: 'Flutter 开发',
          topicTag: 'flutter-dev',
          visitCount: 5,
        ),
      ];

      String? capturedTag;

      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
          GoRoute(
            path: TestRoutePaths.topicDetail,
            builder: (context, state) {
              capturedTag = state.pathParameters['tag'];
              return MockTopicDetailPage(tag: capturedTag!);
            },
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: testItems, router: router),
      );

      await tester.pumpAndSettle();

      // 点击条目
      await tester.tap(find.text('Flutter 开发'));
      await tester.pumpAndSettle();

      // 验证跳转时使用的是 topicTag 而不是 topicId
      expect(capturedTag, equals('flutter-dev'));
      expect(find.text('Tag: flutter-dev'), findsOneWidget);
    });

    testWidgets('当 topicTag 为空时应该使用 topicId 作为回退', (WidgetTester tester) async {
      final testItems = [
        createTestItem(
          id: '1',
          topicId: 'fallback-topic-id',
          topicName: '无标签话题',
          topicTag: null, // topicTag 为空
          visitCount: 2,
        ),
      ];

      String? capturedTag;

      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
          GoRoute(
            path: TestRoutePaths.topicDetail,
            builder: (context, state) {
              capturedTag = state.pathParameters['tag'];
              return MockTopicDetailPage(tag: capturedTag!);
            },
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: testItems, router: router),
      );

      await tester.pumpAndSettle();

      // 点击条目
      await tester.tap(find.text('无标签话题'));
      await tester.pumpAndSettle();

      // 验证当 topicTag 为空时，使用 topicId 作为回退
      expect(capturedTag, equals('fallback-topic-id'));
      expect(find.text('Tag: fallback-topic-id'), findsOneWidget);
    });

    testWidgets('删除按钮应该存在', (WidgetTester tester) async {
      final testItems = [
        createTestItem(
          id: '1',
          topicId: 'topic-123',
          topicName: 'Flutter 开发',
          topicTag: 'flutter',
          visitCount: 5,
        ),
      ];

      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: testItems, router: router),
      );

      await tester.pumpAndSettle();

      // 验证删除按钮存在（使用 tooltip 来精确定位）
      expect(find.byTooltip('删除'), findsOneWidget);
    });

    testWidgets('清空按钮应该在有数据时显示', (WidgetTester tester) async {
      final testItems = [
        createTestItem(
          id: '1',
          topicId: 'topic-123',
          topicName: 'Flutter 开发',
          topicTag: 'flutter',
          visitCount: 5,
        ),
      ];

      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: testItems, router: router),
      );

      await tester.pumpAndSettle();

      // 验证清空按钮存在
      expect(find.byTooltip('清空记录'), findsOneWidget);
    });

    testWidgets('时间显示应该正确格式化', (WidgetTester tester) async {
      final now = DateTime.now();
      final testItems = [
        createTestItem(
          id: '1',
          topicId: 'topic-1',
          topicName: '今天访问',
          topicTag: 'today',
          visitCount: 1,
          lastVisitedAt: now,
        ),
        createTestItem(
          id: '2',
          topicId: 'topic-2',
          topicName: '昨天访问',
          topicTag: 'yesterday',
          visitCount: 1,
          lastVisitedAt: now.subtract(const Duration(days: 1)),
        ),
        createTestItem(
          id: '3',
          topicId: 'topic-3',
          topicName: '三天前访问',
          topicTag: 'three-days',
          visitCount: 1,
          lastVisitedAt: now.subtract(const Duration(days: 3)),
        ),
      ];

      final router = GoRouter(
        initialLocation: TestRoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: TestRoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
        ],
      );

      await tester.pumpWidget(
        buildTestScope(items: testItems, router: router),
      );

      await tester.pumpAndSettle();

      // 验证时间显示
      expect(find.text('今天'), findsOneWidget);
      expect(find.text('昨天'), findsOneWidget);
      expect(find.text('3天前'), findsOneWidget);
    });
  });
}
