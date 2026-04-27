import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traeu/core/network/discourse_api_service.dart';
import 'package:traeu/presentation/providers/home_provider.dart';

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDiscourseApiService mockDiscourseApiService;
  late ProviderContainer container;
  late ProviderSubscription<HomeState> homeStateSubscription;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    mockDiscourseApiService = MockDiscourseApiService();

    when(
      () => mockDiscourseApiService.getNewTopics(page: any(named: 'page')),
    ).thenAnswer((invocation) async {
      final page = invocation.namedArguments[#page] as int? ?? 0;
      final topics = page == 0
          ? List.generate(
              20,
              (index) => {
                'id': 1001 + index,
                'title': '缓存测试帖子-第一页-${index + 1}',
                'excerpt': '内容摘要',
                'category_id': 9,
                'posts_count': 2,
                'views': 10,
                'last_posted_at': '2026-04-28T10:00:00Z',
                'posters': [
                  {'user_id': 88},
                ],
              },
            )
          : [
              {
                'id': 2001,
                'title': '缓存测试帖子-第二页',
                'excerpt': '内容摘要',
                'category_id': 9,
                'posts_count': 2,
                'views': 10,
                'last_posted_at': '2026-04-28T10:00:00Z',
                'posters': [
                  {'user_id': 88},
                ],
              },
            ];

      return Response(
        requestOptions: RequestOptions(path: '/new.json'),
        statusCode: 200,
        data: {
          'topic_list': {'topics': topics},
          'users': [
            {
              'id': 88,
              'username': 'cache_user',
              'avatar_template':
                  '/user_avatar/forum.trae.cn/cache_user/{size}/1.png',
            },
          ],
        },
      );
    });

    container = ProviderContainer(
      overrides: [
        discourseApiServiceProvider.overrideWith(
          (ref) => mockDiscourseApiService,
        ),
      ],
    );
    homeStateSubscription = container.listen(
      homeNotifierProvider,
      (_, _) {},
      fireImmediately: true,
    );
  });

  tearDown(() {
    homeStateSubscription.close();
    container.dispose();
  });

  Future<void> waitRefreshDone({int minItems = 0}) async {
    for (var i = 0; i < 120; i++) {
      final homeState = container.read(homeNotifierProvider);
      final latestState = homeState.tabStates[FeedType.latest];
      if (latestState != null &&
          latestState.isRefreshing == false &&
          latestState.feedList.length >= minItems) {
        return;
      }
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
  }

  test('首页最新Tab在短时间重复刷新时不重复请求，强制刷新才会重新打网', () async {
    final notifier = container.read(homeNotifierProvider.notifier);

    notifier.switchTab(1);
    await waitRefreshDone(minItems: 1);
    clearInteractions(mockDiscourseApiService);

    await notifier.refreshFeeds();
    await waitRefreshDone();
    verifyNever(
      () => mockDiscourseApiService.getNewTopics(page: any(named: 'page')),
    );

    await Future<void>.delayed(const Duration(seconds: 3));
    await notifier.refreshFeeds();
    await waitRefreshDone();
    verifyNever(
      () => mockDiscourseApiService.getNewTopics(page: any(named: 'page')),
    );

    await notifier.refreshFeeds(force: true);
    await waitRefreshDone();
    verify(
      () => mockDiscourseApiService.getNewTopics(page: any(named: 'page')),
    ).called(1);
  });

  test('首页翻页数据会缓存，重复刷新后再次加载下一页不重复请求', () async {
    final notifier = container.read(homeNotifierProvider.notifier);

    notifier.switchTab(1);
    await waitRefreshDone(minItems: 1);
    await notifier.loadMoreFeeds();
    await waitRefreshDone(minItems: 2);

    clearInteractions(mockDiscourseApiService);

    await Future<void>.delayed(const Duration(seconds: 3));
    await notifier.refreshFeeds();
    await waitRefreshDone(minItems: 1);
    await notifier.loadMoreFeeds();
    await waitRefreshDone(minItems: 2);

    verifyNever(
      () => mockDiscourseApiService.getNewTopics(page: any(named: 'page')),
    );

    final state = container.read(homeNotifierProvider);
    final latestState = state.tabStates[FeedType.latest];
    expect(latestState, isNotNull);
    expect(latestState!.feedList.length, equals(21));
    expect(latestState.currentPage, equals(2));
    expect(latestState.feedList.first.id, equals('1001'));
    expect(latestState.feedList.last.id, equals('2001'));
  });
}
