import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traeu/config/constants.dart';
import 'package:traeu/data/models/user_activity.dart';
import 'package:traeu/presentation/pages/user/frequently_visited_page.dart';
import 'package:traeu/presentation/providers/user_activity_provider.dart';

/// 集成测试：验证 "我常去" 到话题详情页的跳转路径
///
/// 测试目标：
/// 1. 验证点击 "我常去" 条目使用 topicTag 而非 topicId 进行跳转
/// 2. 验证路由参数正确传递
/// 3. 验证当 topicTag 为空时使用 topicId 作为回退
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('FrequentlyVisited Navigation Integration Tests', () {
    /// 创建测试用的 FrequentlyVisited 数据
    FrequentlyVisited createTestItem({
      required String id,
      required String topicId,
      required String topicName,
      String? topicTag,
      int visitCount = 1,
      DateTime? lastVisitedAt,
      String? coverUrl,
    }) {
      return FrequentlyVisited(
        id: id,
        topicId: topicId,
        topicName: topicName,
        topicTag: topicTag,
        visitCount: visitCount,
        lastVisitedAt: lastVisitedAt ?? DateTime.now(),
        coverUrl: coverUrl,
      );
    }

    /// 构建带模拟路由的测试应用
    Widget buildTestApp({
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

    testWidgets(
        '从"我常去"页面点击条目应正确跳转到话题详情页并使用 topicTag',
        (WidgetTester tester) async {
      // 准备测试数据
      final testItems = [
        createTestItem(
          id: 'test-1',
          topicId: 'internal-id-123',
          topicName: 'SOLO挑战赛',
          topicTag: 'solo',
          visitCount: 10,
        ),
      ];

      String? capturedTag;

      // 构建测试路由
      final router = GoRouter(
        initialLocation: RoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: RoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
          GoRoute(
            path: RoutePaths.topicDetail,
            builder: (context, state) {
              capturedTag = state.pathParameters['tag'];
              // 返回一个简单的模拟页面来验证跳转
              return Scaffold(
                appBar: AppBar(title: Text('Topic: $capturedTag')),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Route: ${state.uri.path}'),
                      Text('Tag Parameter: $capturedTag'),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );

      // 渲染页面
      await tester.pumpWidget(buildTestApp(items: testItems, router: router));
      await tester.pumpAndSettle();

      // 验证初始页面
      expect(find.text('我常去'), findsOneWidget);
      expect(find.text('SOLO挑战赛'), findsOneWidget);

      // 点击条目
      await tester.tap(find.text('SOLO挑战赛'));
      await tester.pumpAndSettle();

      // 验证跳转后的路由参数
      // 关键验证：使用的是 topicTag ('solo') 而不是 topicId ('internal-id-123')
      expect(capturedTag, equals('solo'));
      expect(find.text('Route: /topic/solo'), findsOneWidget);
      expect(find.text('Tag Parameter: solo'), findsOneWidget);
    });

    testWidgets('当 topicTag 为空时应使用 topicId 作为回退值',
        (WidgetTester tester) async {
      // 准备测试数据 - topicTag 为空
      final testItems = [
        createTestItem(
          id: 'test-2',
          topicId: 'fallback-id-456',
          topicName: '无标签话题',
          topicTag: null, // topicTag 为空
          visitCount: 5,
        ),
      ];

      String? capturedTag;

      final router = GoRouter(
        initialLocation: RoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: RoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
          GoRoute(
            path: RoutePaths.topicDetail,
            builder: (context, state) {
              capturedTag = state.pathParameters['tag'];
              return Scaffold(
                appBar: AppBar(title: Text('Topic: $capturedTag')),
                body: Center(child: Text('Tag: $capturedTag')),
              );
            },
          ),
        ],
      );

      await tester.pumpWidget(buildTestApp(items: testItems, router: router));
      await tester.pumpAndSettle();

      // 验证初始页面
      expect(find.text('无标签话题'), findsOneWidget);

      // 点击条目
      await tester.tap(find.text('无标签话题'));
      await tester.pumpAndSettle();

      // 验证回退逻辑：当 topicTag 为空时使用 topicId
      expect(capturedTag, equals('fallback-id-456'));
      expect(find.text('Tag: fallback-id-456'), findsOneWidget);
    });

    testWidgets('多个条目的跳转应各自使用正确的 topicTag',
        (WidgetTester tester) async {
      // 准备多个测试数据
      final testItems = [
        createTestItem(
          id: 'test-1',
          topicId: 'id-1',
          topicName: 'Flutter 开发',
          topicTag: 'flutter',
          visitCount: 8,
        ),
        createTestItem(
          id: 'test-2',
          topicId: 'id-2',
          topicName: 'Dart 编程',
          topicTag: 'dart',
          visitCount: 5,
        ),
        createTestItem(
          id: 'test-3',
          topicId: 'id-3',
          topicName: 'AI 技术',
          topicTag: 'ai',
          visitCount: 3,
        ),
      ];

      final List<String> capturedTags = [];

      final router = GoRouter(
        initialLocation: RoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: RoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
          GoRoute(
            path: RoutePaths.topicDetail,
            builder: (context, state) {
              final tag = state.pathParameters['tag']!;
              capturedTags.add(tag);
              return Scaffold(
                appBar: AppBar(title: Text('Topic: $tag')),
                body: Center(
                  child: TextButton(
                    onPressed: () => context.go(RoutePaths.frequentlyVisited),
                    child: const Text('Back'),
                  ),
                ),
              );
            },
          ),
        ],
      );

      await tester.pumpWidget(buildTestApp(items: testItems, router: router));
      await tester.pumpAndSettle();

      // 点击第一个条目
      await tester.tap(find.text('Flutter 开发'));
      await tester.pumpAndSettle();
      expect(capturedTags.last, equals('flutter'));

      // 返回
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      // 点击第二个条目
      await tester.tap(find.text('Dart 编程'));
      await tester.pumpAndSettle();
      expect(capturedTags.last, equals('dart'));

      // 返回
      await tester.tap(find.text('Back'));
      await tester.pumpAndSettle();

      // 点击第三个条目
      await tester.tap(find.text('AI 技术'));
      await tester.pumpAndSettle();
      expect(capturedTags.last, equals('ai'));

      // 验证所有跳转都使用了正确的 tag
      expect(capturedTags, equals(['flutter', 'dart', 'ai']));
    });

    testWidgets('路由路径应符合 RoutePaths.topicDetail 定义',
        (WidgetTester tester) async {
      final testItems = [
        createTestItem(
          id: 'test-1',
          topicId: 'id-123',
          topicName: '测试话题',
          topicTag: 'test-tag',
          visitCount: 1,
        ),
      ];

      String? actualRoutePath;

      final router = GoRouter(
        initialLocation: RoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: RoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
          GoRoute(
            path: RoutePaths.topicDetail,
            builder: (context, state) {
              actualRoutePath = state.uri.path;
              return Scaffold(
                body: Center(child: Text('Route: $actualRoutePath')),
              );
            },
          ),
        ],
      );

      await tester.pumpWidget(buildTestApp(items: testItems, router: router));
      await tester.pumpAndSettle();

      await tester.tap(find.text('测试话题'));
      await tester.pumpAndSettle();

      // 验证实际跳转的路由路径
      expect(actualRoutePath, equals('/topic/test-tag'));

      // 验证与 RoutePaths.topicDetail 格式一致
      final expectedPath = RoutePaths.topicDetail.replaceFirst(':tag', 'test-tag');
      expect(actualRoutePath, equals(expectedPath));
    });

    testWidgets('特殊字符的 topicTag 应正确编码', (WidgetTester tester) async {
      final testItems = [
        createTestItem(
          id: 'test-1',
          topicId: 'id-123',
          topicName: '特殊话题',
          topicTag: 'hello-ai', // 带连字符的 tag
          visitCount: 1,
        ),
      ];

      String? capturedTag;

      final router = GoRouter(
        initialLocation: RoutePaths.frequentlyVisited,
        routes: [
          GoRoute(
            path: RoutePaths.frequentlyVisited,
            builder: (context, state) => const FrequentlyVisitedPage(),
          ),
          GoRoute(
            path: RoutePaths.topicDetail,
            builder: (context, state) {
              capturedTag = state.pathParameters['tag'];
              return Scaffold(
                body: Center(child: Text('Tag: $capturedTag')),
              );
            },
          ),
        ],
      );

      await tester.pumpWidget(buildTestApp(items: testItems, router: router));
      await tester.pumpAndSettle();

      await tester.tap(find.text('特殊话题'));
      await tester.pumpAndSettle();

      // 验证特殊字符正确处理
      expect(capturedTag, equals('hello-ai'));
    });
  });

  group('FrequentlyVisited Route Semantic Tests', () {
    /// 验证路由语义正确性
    test('RoutePaths.topicDetail 应使用 :tag 参数而非 :id', () {
      // 验证路由路径定义
      expect(RoutePaths.topicDetail, equals('/topic/:tag'));

      // 验证路径中包含 :tag 而非 :id
      expect(RoutePaths.topicDetail.contains(':tag'), isTrue);
      expect(RoutePaths.topicDetail.contains(':id'), isFalse);
    });

    test('路由替换逻辑应正确工作', () {
      const routePattern = '/topic/:tag';

      // 测试正常替换
      final result1 = routePattern.replaceFirst(':tag', 'flutter');
      expect(result1, equals('/topic/flutter'));

      // 测试带连字符的 tag
      final result2 = routePattern.replaceFirst(':tag', 'hello-ai');
      expect(result2, equals('/topic/hello-ai'));

      // 测试空字符串（边界情况）
      final result3 = routePattern.replaceFirst(':tag', '');
      expect(result3, equals('/topic/'));
    });
  });
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
