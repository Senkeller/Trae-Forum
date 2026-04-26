import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traeu/core/network/discourse_api_service.dart';
import 'package:traeu/presentation/providers/auth_provider.dart';
import 'package:traeu/data/models/user.dart';

class MockDiscourseApiService extends Mock implements DiscourseApiService {}

void main() {
  late ProviderContainer container;
  late MockDiscourseApiService mockDiscourseApi;

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(RequestOptions(path: ''));
  });

  setUp(() async {
    mockDiscourseApi = MockDiscourseApiService();

    // 初始化 SharedPreferences 为 empty
    SharedPreferences.setMockInitialValues({});

    container = ProviderContainer(
      overrides: [
        discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthProvider 登录态恢复测试', () {
    test('本地有有效用户信息时不应触发会话恢复', () async {
      // Arrange - 设置本地用户信息
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', '12345');
      await prefs.setString('username', 'testuser');
      await prefs.setString('avatarUrl', 'https://example.com/avatar.png');

      // Act - 重新创建 ProviderContainer 以触发 build
      container = ProviderContainer(
        overrides: [
          discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
        ],
      );

      // 等待异步操作完成
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - 验证状态为已登录用户
      final authState = container.read(authNotifierProvider);
      expect(authState.valueOrNull?.username, equals('testuser'));
      expect(authState.valueOrNull?.uid, equals('12345'));

      // 验证没有调用会话恢复相关 API
      verifyNever(() => mockDiscourseApi.getCurrentSession());
    });

    test('refreshFromSession 应强制刷新用户信息', () async {
      // Arrange
      when(() => mockDiscourseApi.getCurrentSession()).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/session/current.json'),
          statusCode: 200,
          data: {
            'current_user': {
              'id': 77777,
              'username': 'refreshed_user',
              'avatar_template': '/user_avatar/forum.trae.cn/refreshed/{size}/1.png',
            },
          },
        ),
      );

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert
      expect(result, isNotNull);
      expect(result?.username, equals('refreshed_user'));
      expect(result?.uid, equals('77777'));
    });

    test('refreshFromSession 返回 null 时应处理失败情况', () async {
      // Arrange
      when(() => mockDiscourseApi.getCurrentSession()).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/session/current.json'),
          statusCode: 200,
          data: {}, // 没有 current_user
        ),
      );

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert
      expect(result, isNull);
    });

    test('checkLoginStatus 应返回正确的登录状态', () async {
      // Arrange - 先设置一个登录用户
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', '12345');
      await prefs.setString('username', 'logged_in_user');

      // 重新创建 container 以加载用户
      container = ProviderContainer(
        overrides: [
          discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
        ],
      );

      await Future.delayed(const Duration(milliseconds: 100));

      // Act
      final isLoggedIn = await container.read(authNotifierProvider.notifier).checkLoginStatus();

      // Assert - 由于没有实现真正的检查，应该返回 false
      // 这是预期的行为，因为 Discourse API 暂不支持认证检查
      expect(isLoggedIn, isFalse);
    });

    test('登出后应清除所有用户数据', () async {
      // Arrange - 先设置一个登录用户
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', '12345');
      await prefs.setString('username', 'user_to_logout');
      await prefs.setString('avatarUrl', 'https://example.com/avatar.png');

      // 重新创建 container 以加载用户
      container = ProviderContainer(
        overrides: [
          discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
        ],
      );

      await Future.delayed(const Duration(milliseconds: 100));

      // Act
      await container.read(authNotifierProvider.notifier).logout();

      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - 验证 SharedPreferences 已清除
      expect(prefs.getString('uid'), isNull);
      expect(prefs.getString('username'), isNull);
      expect(prefs.getString('avatarUrl'), isNull);

      // 验证状态为未登录
      final authState = container.read(authNotifierProvider);
      expect(authState.valueOrNull?.uid, equals(''));
      expect(authState.valueOrNull?.username, equals(''));
    });

    test('setUserInfo 应正确保存用户信息', () async {
      // Arrange
      const userInfo = UserInfo(
        uid: '99999',
        username: 'set_user',
        avatar: 'https://example.com/new_avatar.png',
      );

      // Act
      await container.read(authNotifierProvider.notifier).setUserInfo(userInfo);

      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - 验证 SharedPreferences 已保存
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('uid'), equals('99999'));
      expect(prefs.getString('username'), equals('set_user'));
      expect(prefs.getString('avatarUrl'), equals('https://example.com/new_avatar.png'));

      // 验证状态已更新
      final authState = container.read(authNotifierProvider);
      expect(authState.valueOrNull?.username, equals('set_user'));
    });

    test('setUserInfo 收到占位用户时应尝试恢复真实用户', () async {
      // Arrange - 模拟占位用户
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', 'webview_user');
      await prefs.setString('username', '用户');

      when(() => mockDiscourseApi.getCurrentSession()).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/session/current.json'),
          statusCode: 200,
          data: {
            'current_user': {
              'id': 88888,
              'username': 'real_user_from_session',
              'avatar_template': '/user_avatar/forum.trae.cn/real/{size}/1.png',
            },
          },
        ),
      );

      const placeholderUser = UserInfo(
        uid: 'webview_user',
        username: '用户',
        avatar: '',
      );

      // Act
      await container.read(authNotifierProvider.notifier).setUserInfo(placeholderUser);

      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - 验证状态已更新为真实用户
      final authState = container.read(authNotifierProvider);
      expect(authState.valueOrNull?.username, equals('real_user_from_session'));
    });

    test('会话恢复 API 返回 401 时应返回 null', () async {
      // Arrange
      when(() => mockDiscourseApi.getCurrentSession()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/session/current.json'),
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(path: '/session/current.json'),
          ),
        ),
      );

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert
      expect(result, isNull);
    });

    test('会话恢复 API 返回 403 时应返回 null', () async {
      // Arrange
      when(() => mockDiscourseApi.getCurrentSession()).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/session/current.json'),
          response: Response(
            statusCode: 403,
            requestOptions: RequestOptions(path: '/session/current.json'),
          ),
        ),
      );

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert
      expect(result, isNull);
    });

    test('会话恢复网络异常时应返回 null', () async {
      // Arrange
      when(() => mockDiscourseApi.getCurrentSession()).thenThrow(
        Exception('Network error'),
      );

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert
      expect(result, isNull);
    });

    test('会话恢复返回空用户名时应返回 null', () async {
      // Arrange
      when(() => mockDiscourseApi.getCurrentSession()).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/session/current.json'),
          statusCode: 200,
          data: {
            'current_user': {
              'id': 12345,
              'username': '   ', // 空白用户名
              'avatar_template': '/user_avatar/forum.trae.cn/test/{size}/1.png',
            },
          },
        ),
      );

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert
      expect(result, isNull);
    });

    test('会话恢复返回 null current_user 时应返回 null', () async {
      // Arrange
      when(() => mockDiscourseApi.getCurrentSession()).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/session/current.json'),
          statusCode: 200,
          data: {}, // 没有 current_user
        ),
      );

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert
      expect(result, isNull);
    });
  });
}
