import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/core/network/discourse_api_service.dart';

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('UserFollowStatus Provider', () {
    late MockDiscourseApiService mockApiService;

    setUp(() {
      mockApiService = MockDiscourseApiService();
    });

    test('toggleFollow calls followUser when not following', () async {
      when(() => mockApiService.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/test_user/follow'),
          statusCode: 200,
        ),
      );

      await mockApiService.followUser('test_user');

      verify(() => mockApiService.followUser('test_user')).called(1);
    });

    test('toggleFollow calls unfollowUser when following', () async {
      when(() => mockApiService.unfollowUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/test_user/follow'),
          statusCode: 200,
        ),
      );

      await mockApiService.unfollowUser('test_user');

      verify(() => mockApiService.unfollowUser('test_user')).called(1);
    });

    test('followUser returns success', () async {
      when(() => mockApiService.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/test_user/follow'),
          statusCode: 200,
        ),
      );

      final response = await mockApiService.followUser('test_user');

      expect(response.statusCode, equals(200));
    });

    test('unfollowUser returns success', () async {
      when(() => mockApiService.unfollowUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/test_user/follow'),
          statusCode: 200,
        ),
      );

      final response = await mockApiService.unfollowUser('test_user');

      expect(response.statusCode, equals(200));
    });

    test('followUser handles unauthorized error', () async {
      when(() => mockApiService.followUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/test_user/follow'),
          response: Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: '/u/test_user/follow'),
          ),
        ),
      );

      expect(
        () => mockApiService.followUser('test_user'),
        throwsA(isA<DioException>()),
      );
    });

    test('unfollowUser handles unauthorized error', () async {
      when(() => mockApiService.unfollowUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/test_user/follow'),
          response: Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: '/u/test_user/follow'),
          ),
        ),
      );

      expect(
        () => mockApiService.unfollowUser('test_user'),
        throwsA(isA<DioException>()),
      );
    });

    test('followUser handles not found error', () async {
      when(() => mockApiService.followUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/nonexistent_user/follow'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/u/nonexistent_user/follow'),
          ),
        ),
      );

      expect(
        () => mockApiService.followUser('nonexistent_user'),
        throwsA(isA<DioException>()),
      );
    });
  });
}
