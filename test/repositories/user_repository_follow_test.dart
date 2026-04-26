import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traeu/core/network/discourse_api_service.dart';
import 'package:traeu/data/repositories/user_repository.dart';

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

  group('UserRepository 关注/取关分支测试', () {
    const testUid = 'test_user_123';

    test('followUser 调用时应该使用 isFollow=true 参数', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: testUid);

      // Assert
      verify(() => mockDiscourseApi.followUser(testUid)).called(1);
      verifyNever(() => mockDiscourseApi.unfollowUser(any()));
      expect(response.status, equals(200));
      expect(response.message, equals('success'));
    });

    test('unfollowUser 调用时应该使用 isFollow=false 参数', () async {
      // Arrange
      when(() => mockDiscourseApi.unfollowUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.unfollowUser(uid: testUid);

      // Assert
      verify(() => mockDiscourseApi.unfollowUser(testUid)).called(1);
      verifyNever(() => mockDiscourseApi.followUser(any()));
      expect(response.status, equals(200));
      expect(response.message, equals('success'));
    });

    test('关注操作边界情况：空字符串 uid', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u//follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: '');

      // Assert
      verify(() => mockDiscourseApi.followUser('')).called(1);
      expect(response.status, equals(200));
    });

    test('取关操作边界情况：空字符串 uid', () async {
      // Arrange
      when(() => mockDiscourseApi.unfollowUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u//follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.unfollowUser(uid: '');

      // Assert
      verify(() => mockDiscourseApi.unfollowUser('')).called(1);
      expect(response.status, equals(200));
    });

    test('关注操作边界情况：特殊字符 uid', () async {
      // Arrange
      const specialUid = 'user@example.com';
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$specialUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: specialUid);

      // Assert
      verify(() => mockDiscourseApi.followUser(specialUid)).called(1);
      expect(response.status, equals(200));
    });

    test('取关操作边界情况：特殊字符 uid', () async {
      // Arrange
      const specialUid = 'user-name_123';
      when(() => mockDiscourseApi.unfollowUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$specialUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.unfollowUser(uid: specialUid);

      // Assert
      verify(() => mockDiscourseApi.unfollowUser(specialUid)).called(1);
      expect(response.status, equals(200));
    });

    test('关注操作返回 403 时应该返回 401 状态码', () async {
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

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: testUid);

      // Assert
      expect(response.status, equals(401));
      expect(response.message, contains('Unauthorized'));
    });

    test('取关操作返回 403 时应该返回 401 状态码', () async {
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

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.unfollowUser(uid: testUid);

      // Assert
      expect(response.status, equals(401));
      expect(response.message, contains('Unauthorized'));
    });

    test('关注操作返回 404 时应该返回 404 状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          ),
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: testUid);

      // Assert
      expect(response.status, equals(404));
      expect(response.message, contains('Failed to follow/unfollow'));
    });

    test('取关操作返回 500 时应该返回 500 状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.unfollowUser(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          ),
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.unfollowUser(uid: testUid);

      // Assert
      expect(response.status, equals(500));
      expect(response.message, contains('Failed to follow/unfollow'));
    });

    test('关注操作网络异常时应该返回 500 状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenThrow(
        Exception('Network error'),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: testUid);

      // Assert
      expect(response.status, equals(500));
      expect(response.message, contains('Failed to follow/unfollow'));
    });

    test('取关操作网络异常时应该返回 500 状态码', () async {
      // Arrange
      when(() => mockDiscourseApi.unfollowUser(any())).thenThrow(
        Exception('Network error'),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.unfollowUser(uid: testUid);

      // Assert
      expect(response.status, equals(500));
      expect(response.message, contains('Failed to follow/unfollow'));
    });

    test('连续关注和取关操作应该调用正确的 API', () async {
      // Arrange
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );
      when(() => mockDiscourseApi.unfollowUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$testUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act - 先关注
      final followResponse = await userRepository.followUser(uid: testUid);

      // Assert - 关注
      expect(followResponse.status, equals(200));
      verify(() => mockDiscourseApi.followUser(testUid)).called(1);

      // Act - 再取关
      final unfollowResponse = await userRepository.unfollowUser(uid: testUid);

      // Assert - 取关
      expect(unfollowResponse.status, equals(200));
      verify(() => mockDiscourseApi.unfollowUser(testUid)).called(1);

      // 验证总调用次数
      verifyNoMoreInteractions(mockDiscourseApi);
    });

    test('边界情况：超长 uid 字符串', () async {
      // Arrange
      final longUid = 'a' * 1000;
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$longUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: longUid);

      // Assert
      verify(() => mockDiscourseApi.followUser(longUid)).called(1);
      expect(response.status, equals(200));
    });

    test('边界情况：包含 Unicode 字符的 uid', () async {
      // Arrange
      const unicodeUid = '用户_测试_123';
      when(() => mockDiscourseApi.followUser(any())).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/u/$unicodeUid/follow'),
          statusCode: 200,
          data: {'success': true},
        ),
      );

      final userRepository = container.read(userRepositoryProvider);

      // Act
      final response = await userRepository.followUser(uid: unicodeUid);

      // Assert
      verify(() => mockDiscourseApi.followUser(unicodeUid)).called(1);
      expect(response.status, equals(200));
    });
  });
}
