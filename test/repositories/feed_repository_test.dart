import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/data/repositories/feed_repository.dart';
import 'package:traeu/core/network/api_service.dart';
import 'package:traeu/data/models/feed.dart';

/// Mock ApiService 用于测试
class MockApiService extends Mock implements ApiService {}

/// Feed 仓库单元测试
///
/// 测试目标：验证 FeedRepository 的各种方法行为，包括：
/// - 获取首页 Feed 列表
/// - 获取动态详情
/// - 发布动态
/// - 点赞/取消点赞
/// - 其他动态操作
void main() {
  late FeedRepository feedRepository;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    feedRepository = FeedRepository(mockApiService);
  });

  group('获取首页 Feed 测试', () {
    /// 测试目的：验证成功获取首页 Feed
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

    /// 测试目的：验证分页参数传递
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

    /// 测试目的：验证网络错误处理
    test('网络错误应抛出异常', () async {
      when(() => mockApiService.getHomeFeed(
        page: any(named: 'page'),
        firstLaunch: any(named: 'firstLaunch'),
        installTime: any(named: 'installTime'),
        firstItem: any(named: 'firstItem'),
        lastItem: any(named: 'lastItem'),
        ids: any(named: 'ids'),
      )).thenThrow(DioException(
        requestOptions: RequestOptions(path: '/v6/main/indexV8'),
        type: DioExceptionType.connectionTimeout,
      ));

      expect(
        () => feedRepository.getHomeFeed(page: 1, installTime: '1713945600'),
        throwsException,
      );
    });
  });

  group('获取动态详情测试', () {
    /// 测试目的：验证成功获取动态详情
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

    /// 测试目的：验证带回复 ID 的详情获取
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

    /// 测试目的：验证动态不存在的情况
    test('动态不存在应抛出异常', () async {
      when(() => mockApiService.getFeedContent(id: any(named: 'id'), rid: any(named: 'rid')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/v6/feed/detail'),
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: '/v6/feed/detail'),
        ),
      ));

      expect(
        () => feedRepository.getFeedDetail(id: 'non_existent'),
        throwsException,
      );
    });
  });

  group('发布动态测试', () {
    /// 测试目的：验证成功发布动态
    test('应成功发布动态', () async {
      final mockResponse = CreateFeedResponse(
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
        'message': '测试动态内容',
        'type': 'feed',
      });

      expect(result.status, equals(200));
      expect(result.message, equals('发布成功'));
      expect(result.data, isNotNull);
      expect(result.data!.message, equals('新发布的动态'));
    });

    /// 测试目的：验证发布失败处理
    test('发布失败应抛出异常', () async {
      when(() => mockApiService.postCreateFeed(data: any(named: 'data')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/v6/feed/createFeed'),
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 400,
          data: {'message': '内容不能为空'},
          requestOptions: RequestOptions(path: '/v6/feed/createFeed'),
        ),
      ));

      expect(
        () => feedRepository.createFeed(data: {'message': ''}),
        throwsException,
      );
    });
  });

  group('点赞操作测试', () {
    /// 测试目的：验证点赞成功
    test('应成功点赞动态', () async {
      final mockResponse = LikeFeedResponse(
        status: 200,
        data: {'is_like': true, 'like_num': 1},
      );

      when(() => mockApiService.postLikeFeed(
        url: '/v6/feed/like',
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.likeFeed(id: 'feed_001');

      expect(result.status, equals(200));
      verify(() => mockApiService.postLikeFeed(
        url: '/v6/feed/like',
        id: 'feed_001',
      )).called(1);
    });

    /// 测试目的：验证取消点赞成功
    test('应成功取消点赞', () async {
      final mockResponse = LikeFeedResponse(
        status: 200,
        data: {'is_like': false, 'like_num': 0},
      );

      when(() => mockApiService.postLikeFeed(
        url: '/v6/feed/unlike',
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.unlikeFeed(id: 'feed_001');

      expect(result.status, equals(200));
      verify(() => mockApiService.postLikeFeed(
        url: '/v6/feed/unlike',
        id: 'feed_001',
      )).called(1);
    });
  });

  group('删除动态测试', () {
    /// 测试目的：验证删除动态成功
    test('应成功删除动态', () async {
      final mockResponse = LikeReplyResponse(
        status: 200,
        message: '删除成功',
      );

      when(() => mockApiService.postDelete(
        url: '/v6/feed/deleteFeed',
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.deleteFeed(id: 'feed_001');

      expect(result.status, equals(200));
      verify(() => mockApiService.postDelete(
        url: '/v6/feed/deleteFeed',
        id: 'feed_001',
      )).called(1);
    });
  });

  group('收藏操作测试', () {
    /// 测试目的：验证收藏成功
    test('应成功收藏动态', () async {
      final mockResponse = LikeFeedResponse(
        status: 200,
        data: {'is_favorite': true},
      );

      when(() => mockApiService.postLikeFeed(
        url: '/v6/feed/favorite',
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.favoriteFeed(id: 'feed_001');

      expect(result.status, equals(200));
    });

    /// 测试目的：验证取消收藏成功
    test('应成功取消收藏', () async {
      final mockResponse = LikeFeedResponse(
        status: 200,
        data: {'is_favorite': false},
      );

      when(() => mockApiService.postLikeFeed(
        url: '/v6/feed/unfavorite',
        id: 'feed_001',
      )).thenAnswer((_) async => mockResponse);

      final result = await feedRepository.unfavoriteFeed(id: 'feed_001');

      expect(result.status, equals(200));
    });
  });

  group('转发动态测试', () {
    /// 测试目的：验证转发成功
    test('应成功转发动态', () async {
      final mockResponse = {
        'status': 200,
        'data': {'forward_num': 1},
      };

      when(() => mockApiService.postLikeFeed(
        url: '/v6/feed/forward',
        id: 'feed_001',
      )).thenAnswer((_) async => LikeFeedResponse(status: 200));

      final result = await feedRepository.forwardFeed(id: 'feed_001');

      expect(result, isNotNull);
    });
  });
}
