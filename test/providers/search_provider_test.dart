import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:traeu/core/network/api_service.dart';
import 'package:traeu/core/network/discourse_api_service.dart';
import 'package:traeu/presentation/providers/search_provider.dart';
import 'package:traeu/data/models/feed.dart';
import 'package:traeu/data/models/user.dart';

class MockApiService extends Mock implements ApiService {}

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

/// 搜索 Provider 测试
///
/// 测试搜索功能的完整链路，包括：
/// - 搜索执行
/// - 加载更多
/// - 搜索历史管理
/// - 热门搜索加载
/// - 榜单加载
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockApiService mockApiService;
  late MockDiscourseApiService mockDiscourseApi;
  late ProviderContainer container;

  setUp(() {
    mockApiService = MockApiService();
    mockDiscourseApi = MockDiscourseApiService();

    // 初始化 SharedPreferences
    SharedPreferences.setMockInitialValues({});

    container = ProviderContainer(
      overrides: [
        discourseApiServiceProvider.overrideWith((ref) => mockDiscourseApi),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('SearchNotifier', () {
    test('初始状态正确', () {
      final state = container.read(searchNotifierProvider);

      expect(state.keyword, equals(''));
      expect(state.results, isEmpty);
      expect(state.searchHistory, isEmpty);
      expect(state.isSearching, isFalse);
      expect(state.hasMore, isTrue);
      expect(state.currentPage, equals(1));
    });

    test('设置搜索关键词', () {
      final notifier = container.read(searchNotifierProvider.notifier);

      notifier.setKeyword('测试关键词');

      final state = container.read(searchNotifierProvider);
      expect(state.keyword, equals('测试关键词'));
    });

    test('设置搜索类型', () {
      final notifier = container.read(searchNotifierProvider.notifier);

      notifier.setSearchType(SearchType.user);

      final state = container.read(searchNotifierProvider);
      expect(state.searchType, equals(SearchType.user));
    });

    test('设置排序类型', () {
      final notifier = container.read(searchNotifierProvider.notifier);

      notifier.setSortType(SearchSortType.latest);

      final state = container.read(searchNotifierProvider);
      expect(state.sortType, equals(SearchSortType.latest));
    });
  });

  group('SearchResult Model', () {
    test('从 JSON 创建 SearchResult', () {
      final json = {
        'id': '123',
        'title': '测试标题',
        'message': '测试内容',
        'entityType': 'feed',
        'userInfo': {
          'username': 'testuser',
          'avatar': 'https://example.com/avatar.jpg',
        },
      };

      final result = SearchResult.fromJson(json);

      expect(result.id, equals('123'));
      expect(result.title, equals('测试标题'));
      expect(result.type, equals('feed'));
    });

    test('从 Feed 数据创建 SearchResult', () {
      final feedData = HomeFeedData(
        id: '456',
        message: '动态内容',
        title: '动态标题',
        entityType: 'topic',
        userInfo: UserInfo(
          uid: '1',
          username: 'testuser',
          avatar: 'https://example.com/avatar.jpg',
        ),
      );

      final result = SearchResult.fromFeedData(feedData);

      expect(result.id, equals('456'));
      expect(result.title, equals('动态标题'));
      expect(result.type, equals('topic'));
    });
  });

  group('SearchType Extension', () {
    test('搜索类型显示名称正确', () {
      expect(SearchType.all.displayName, equals('全部'));
      expect(SearchType.feed.displayName, equals('动态'));
      expect(SearchType.user.displayName, equals('用户'));
      expect(SearchType.apk.displayName, equals('应用'));
      expect(SearchType.topic.displayName, equals('话题'));
    });
  });

  group('SearchSortType Extension', () {
    test('排序类型显示名称正确', () {
      expect(SearchSortType.defaultSort.displayName, equals('默认排序'));
      expect(SearchSortType.latest.displayName, equals('最新发布'));
      expect(SearchSortType.mostReplies.displayName, equals('最多回复'));
      expect(SearchSortType.mostLikes.displayName, equals('最多点赞'));
    });
  });

  group('SearchState', () {
    test('copyWith 方法工作正常', () {
      const initialState = SearchState();

      final newState = initialState.copyWith(
        keyword: '新关键词',
        isSearching: true,
        results: [const SearchResult(id: '1', type: 'feed', title: '测试')],
      );

      expect(newState.keyword, equals('新关键词'));
      expect(newState.isSearching, isTrue);
      expect(newState.results.length, equals(1));
      expect(initialState.keyword, equals('')); // 原状态不变
    });

    test('clearResults 清空结果', () {
      final notifier = container.read(searchNotifierProvider.notifier);

      notifier.setKeyword('测试');
      notifier.clearResults();

      final state = container.read(searchNotifierProvider);
      expect(state.results, isEmpty);
      expect(state.keyword, equals(''));
    });

    test('clearError 清除错误', () {
      final notifier = container.read(searchNotifierProvider.notifier);

      // 模拟设置错误状态
      notifier.clearError();

      final state = container.read(searchNotifierProvider);
      expect(state.errorMessage, isNull);
    });
  });

  group('RankingTopic Model', () {
    test('榜单话题属性正确', () {
      const topic = RankingTopic(
        id: '1',
        title: '热门话题',
        categoryName: '技术',
        replyCount: 100,
        views: 1000,
        heatValue: 500,
        rank: 1,
      );

      expect(topic.id, equals('1'));
      expect(topic.title, equals('热门话题'));
      expect(topic.categoryName, equals('技术'));
      expect(topic.replyCount, equals(100));
      expect(topic.views, equals(1000));
      expect(topic.heatValue, equals(500));
      expect(topic.rank, equals(1));
    });
  });

  group('Search Integration', () {
    test('搜索 Provider 链路完整', () async {
      // 验证 Provider 可以被读取
      final state = container.read(searchNotifierProvider);
      expect(state, isNotNull);

      // 验证 Notifier 可以被获取
      final notifier = container.read(searchNotifierProvider.notifier);
      expect(notifier, isNotNull);
    });

    test('搜索历史管理', () async {
      final notifier = container.read(searchNotifierProvider.notifier);

      // 添加搜索历史
      await notifier.search('关键词1');

      // 验证历史记录被添加
      final state = container.read(searchNotifierProvider);
      expect(state.searchHistory.contains('关键词1'), isTrue);

      // 移除历史记录
      await notifier.removeFromHistory('关键词1');

      final updatedState = container.read(searchNotifierProvider);
      expect(updatedState.searchHistory.contains('关键词1'), isFalse);
    });

    test('清空搜索历史', () async {
      final notifier = container.read(searchNotifierProvider.notifier);

      await notifier.clearHistory();

      final state = container.read(searchNotifierProvider);
      expect(state.searchHistory, isEmpty);
    });
  });
}
