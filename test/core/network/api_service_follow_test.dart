import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traeu/core/network/api_service.dart';
import 'package:traeu/core/network/discourse_api_service.dart';

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

void main() {
  late ProviderContainer container;
  late MockDiscourseApiService mockDiscourseApi;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(RequestOptions(path: ''));
  });

  setUp(() {
    mockDiscourseApi = MockDiscourseApiService();
    container = ProviderContainer(
      overrides: [
        discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ApiService.postFollowUnFollow', () {
    const testUid = 'test_user_123';

    test('isFollow=true 时调用 followUser 方法', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: true,
        uid: testUid,
      );

      // Assert
      verify(() => mockDiscourseApi.followUser(testUid)).called(1);
      verifyNever(() => mockDiscourseApi.unfollowUser(any()));
      expect(response.status, equals(200));
      expect(response.message, equals('success'));
      expect(response.data?['following'], equals(true));
    });

    test('isFollow=false 时调用 unfollowUser 方法', () async {
      // Arrange
      when(() => mockDiscourseApi.unfollowUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: false,
        uid: testUid,
      );

      // Assert
      verify(() => mockDiscourseApi.unfollowUser(testUid)).called(1);
      verifyNever(() => mockDiscourseApi.followUser(any()));
      expect(response.status, equals(200));
      expect(response.message, equals('success'));
      expect(response.data?['following'], equals(false));
    });

    test('关注操作返回 403 时返回 401 状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          response: Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          ),
        ),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: true,
        uid: testUid,
      );

      // Assert
      expect(response.status, equals(401));
      expect(response.message, contains('Unauthorized'));
    });

    test('取关操作返回 403 时返回 401 状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.unfollowUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          response: Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          ),
        ),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: false,
        uid: testUid,
      );

      // Assert
      expect(response.status, equals(401));
      expect(response.message, contains('Unauthorized'));
    });

    test('关注操作返回其他 DioException 时返回对应状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          ),
        ),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: true,
        uid: testUid,
      );

      // Assert
      expect(response.status, equals(500));
      expect(response.message, contains('Failed to follow/unfollow'));
    });

    test('取关操作返回其他 DioException 时返回对应状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.unfollowUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          ),
        ),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: false,
        uid: testUid,
      );

      // Assert
      expect(response.status, equals(404));
      expect(response.message, contains('Failed to follow/unfollow'));
    });

    test('非 DioException 异常返回 500 状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenThrow(
        Exception('Network error'),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: true,
        uid: testUid,
      );

      // Assert
      expect(response.status, equals(500));
      expect(response.message, contains('Failed to follow/unfollow'));
    });

    test('边界情况：空字符串 uid 也能正常调用', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u//follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final apiService = container.read(apiServiceProvider);

      // Act
      final response = await apiService.postFollowUnFollow(
        isFollow: true,
        uid: '',
      );

      // Assert
      verify(() => mockDiscourseApi.followUser('')).called(1);
      expect(response.status, equals(200));
    });
  });
}
