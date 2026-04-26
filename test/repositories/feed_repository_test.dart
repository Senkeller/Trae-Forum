import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/data/repositories/feed_repository.dart';
import 'package:traeu/core/network/api_service.dart' as api;
import 'package:traeu/data/models/feed.dart';

class MockApiService extends Mock implements api.ApiService {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  late FeedRepository feedRepository;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    feedRepository = FeedRepository(mockApiService);
  });

  group('获取首页 Feed 测试', () {
    test('应成功获取首页 Feed 列表', () async {
      final mockResponse = HomeFeedResponse(
        status: 200,
        message: 'success',
        data: [
          HomeFeedData(
            id: 'feed_001',
            entityType: 'feed',
            message: '测试动态',
          ),
        ],
        total: 100,
        page: 1,
      );

      when(() => mockApiService.getHomeFeed(
        page: any(named: 'page'),
        firstLaunch: any(named: 'firstLaunch'),
        installTime: any(named: 'installTime'),
        firstItem: any(named: 'firstItem'),
        lastItem: any(named: 'lastItem'),
        ids: any(named: 'ids'),
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.getHomeFeed(
        page: 1,
        installTime: '1713945600',
      );

      expect(result.status, equals(200));
      expect(result.data.length, equals(1));
      expect(result.data[0].id, equals('feed_001'));
      expect(result.total, equals(100));
    });

    test('应正确传递分页参数', () async {
      final mockResponse = HomeFeedResponse(status: 200, data: []);

      when(() => mockApiService.getHomeFeed(
        page: 2,
        firstLaunch: 0,
        installTime: '1713945600',
        firstItem: 'feed_001',
        lastItem: 'feed_020',
        ids: 'feed_001,feed_002',
      )).thenAnswer((_) async => mockResponse);

      await feedRepository.getHomeFeed(
        page: 2,
        installTime: '1713945600',
        firstItem: 'feed_001',
        lastItem: 'feed_020',
        ids: 'feed_001,feed_002',
      );

      verify(() => mockApiService.getHomeFeed(
        page: 2,
        firstLaunch: 0,
        installTime: '1713945600',
        firstItem: 'feed_001',
        lastItem: 'feed_020',
        ids: 'feed_001,feed_002',
      )).called(1);
    });

    test('网络错误应抛出异常', () async {
      when(() => mockApiService.getHomeFeed(
        page: any(named: 'page'),
        firstLaunch: any(named: 'firstLaunch'),
        installTime: any(named: 'installTime'),
        firstItem: any(named: 'firstItem'),
        lastItem: any(named: 'lastItem'),
        ids: any(named: 'ids'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/latest.json'),
        type: DioExceptionType.connectionTimeout,
      ));

      expect(
        () => feedRepository.getHomeFeed(page: 1, installTime: '1713945600'),
        throwsException,
      );
    });
  });

  group('获取动态详情测试', () {
    test('应成功获取动态详情', () async {
      final mockResponse = FeedContentResponse(
        status: 200,
        message: 'success',
        data: FeedContentData(
          id: 'feed_001',
          entityType: 'feed',
          message: '动态详情内容',
          isTop: true,
        ),
      );

      when(() => mockApiService.getFeedContent(id: 'feed_001', rid: null))
          .thenAnswer((_) async => mockResponse);

      final result = await feedRepository.getFeedDetail(id: 'feed_001');

      expect(result.status, equals(200));
      expect(result.data, isNotNull);
      expect(result.data!.id, equals('feed_001'));
      expect(result.data!.isTop, isTrue);
    });

    test('应支持带回复 ID 的详情获取', () async {
      final mockResponse = FeedContentResponse(
        status: 200,
        data: FeedContentData(
          id: 'feed_001',
          entityType: 'feed',
        ),
      );

      when(() => mockApiService.getFeedContent(id: 'feed_001', rid: 'reply_001'))
          .thenAnswer((_) async => mockResponse);

      final result = await feedRepository.getFeedDetail(
        id: 'feed_001',
        rid: 'reply_001',
      );

      expect(result.status, equals(200));
      verify(() => mockApiService.getFeedContent(
        id: 'feed_001',
        rid: 'reply_001',
      )).called(1);
    });
  });

  group('发布动态测试', () {
    test('应成功发布动态', () async {
      final mockResponse = api.CreateFeedResponse(
        status: 200,
        message: '发布成功',
        data: HomeFeedData(
          id: 'feed_new',
          entityType: 'feed',
          message: '新发布的动态',
        ),
      );

      when(() => mockApiService.postCreateFeed(data: any(named: 'data')))
          .thenAnswer((_) async => mockResponse);

      final result = await feedRepository.createFeed(data: {
        'title': '测试动态标题',
        'content': '测试动态内容',
      });

      expect(result.status, equals(200));
      expect(result.message, equals('发布成功'));
    });
  });

  group('点赞操作测试', () {
    test('应成功点赞动态', () async {
      final mockResponse = api.LikeFeedResponse(
        status: 200,
        data: {'liked': true},
      );

      when(() => mockApiService.likeFeed(
        id: 'feed_001',
        isLike: true,
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.likeFeed(id: 'feed_001');

      expect(result.status, equals(200));
      verify(() => mockApiService.likeFeed(
        id: 'feed_001',
        isLike: true,
      )).called(1);
    });

    test('应成功取消点赞', () async {
      final mockResponse = api.LikeFeedResponse(
        status: 200,
        data: {'liked': false},
      );

      when(() => mockApiService.likeFeed(
        id: 'feed_001',
        isLike: false,
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.unlikeFeed(id: 'feed_001');

      expect(result.status, equals(200));
      verify(() => mockApiService.likeFeed(
        id: 'feed_001',
        isLike: false,
      )).called(1);
    });

    test('点赞操作使用正确的语义参数', () async {
      final mockResponse = api.LikeFeedResponse(
        status: 200,
        data: {'liked': true},
      );

      when(() => mockApiService.likeFeed(
        id: any(named: 'id'),
        isLike: any(named: 'isLike'),
      )).thenAnswer((_) async => mockResponse);

      await feedRepository.likeFeed(id: 'feed_001');

      verify(() => mockApiService.likeFeed(
        id: 'feed_001',
        isLike: true,
      )).called(1);
    });

    test('取消点赞操作使用正确的语义参数', () async {
      final mockResponse = api.LikeFeedResponse(
        status: 200,
        data: {'liked': false},
      );

      when(() => mockApiService.likeFeed(
        id: any(named: 'id'),
        isLike: any(named: 'isLike'),
      )).thenAnswer((_) async => mockResponse);

      await feedRepository.unlikeFeed(id: 'feed_001');

      verify(() => mockApiService.likeFeed(
        id: 'feed_001',
        isLike: false,
      )).called(1);
    });
  });

  group('删除动态测试', () {
    test('应成功删除动态', () async {
      final mockResponse = api.LikeReplyResponse(
        status: 200,
        message: '删除成功',
      );

      when(() => mockApiService.postDelete(
        url: any(named: 'url'),
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.deleteFeed(id: 'feed_001');

      expect(result.status, equals(200));
      verify(() => mockApiService.postDelete(
        url: any(named: 'url'),
        id: 'feed_001',
      )).called(1);
    });
  });

  group('收藏操作测试', () {
    test('应成功收藏动态', () async {
      final mockResponse = api.LikeFeedResponse(
        status: 200,
        data: {'is_favorite': true},
      );

      when(() => mockApiService.postLikeFeed(
        url: any(named: 'url'),
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.favoriteFeed(id: 'feed_001');

      expect(result.status, equals(200));
    });

    test('应成功取消收藏', () async {
      final mockResponse = api.LikeFeedResponse(
        status: 200,
        data: {'is_favorite': false},
      );

      when(() => mockApiService.postLikeFeed(
        url: any(named: 'url'),
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.unfavoriteFeed(id: 'feed_001');

      expect(result.status, equals(200));
    });
  });

  group('API 语义测试', () {
    test('likeFeed 应使用 isLike 参数而不是 url 参数', () async {
      final mockResponse = api.LikeFeedResponse(
        status: 200,
        data: {'liked': true},
      );

      when(() => mockApiService.likeFeed(
        id: any(named: 'id'),
        isLike: any(named: 'isLike'),
      )).thenAnswer((_) async => mockResponse);

      await feedRepository.likeFeed(id: 'feed_001');

      verify(() => mockApiService.likeFeed(
        id: 'feed_001',
        isLike: true,
      )).called(1);

      verifyNever(() => mockApiService.postLikeFeed(
        url: any(named: 'url'),
        id: any(named: 'id'),
      ));
    });
  });
}
