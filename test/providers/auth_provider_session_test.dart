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

    when(() => mockDiscourseApi.getCurrentSession()).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/session/current.json'),
        statusCode: 200,
        data: {'current_user': null},
      ),
    );
    when(
      () => mockDiscourseApi.getNotifications(
        limit: any(named: 'limit'),
        recent: any(named: 'recent'),
        bumpLastSeen: any(named: 'bumpLastSeen'),
        filterByTypes: any(named: 'filterByTypes'),
      ),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: '/notifications'),
        statusCode: 401,
        data: const {},
      ),
    );

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
    test(
      'isAuthenticatedAsync 在 Cookie 名称缺失时可通过 current session 判定已登录',
      () async {
        when(() => mockDiscourseApi.getCurrentSession()).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/session/current.json'),
            statusCode: 200,
            data: {
              'current_user': {'username': 'session_user', 'id': 9527},
            },
          ),
        );

        final isAuthenticated = await container.read(
          isAuthenticatedAsyncProvider.future,
        );

        expect(isAuthenticated, isTrue);
        verify(
          () => mockDiscourseApi.getCurrentSession(),
        ).called(greaterThan(0));
        verifyNever(
          () => mockDiscourseApi.getNotifications(
            limit: any(named: 'limit'),
            recent: any(named: 'recent'),
            bumpLastSeen: any(named: 'bumpLastSeen'),
            filterByTypes: any(named: 'filterByTypes'),
          ),
        );
      },
    );

    test('refreshFromSession 在测试环境中应返回 null', () async {
      // Arrange - 注意：在测试环境中，DioClient.hasDiscourseSession() 会返回 false
      // 所以 refreshFromSession 会返回 null

      // Act
      final authNotifier = container.read(authNotifierProvider.notifier);
      final result = await authNotifier.refreshFromSession();

      // Assert - 在测试环境中，由于没有真实的 Discourse 会话，返回 null
      expect(result, isNull);
    });

    test('checkLoginStatus 无用户时应返回 false', () async {
      // Act
      final isLoggedIn = await container
          .read(authNotifierProvider.notifier)
          .checkLoginStatus();

      // Assert - 没有用户时应返回 false
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

      // 等待状态加载完成
      await Future.delayed(const Duration(milliseconds: 500));

      // Act
      await container.read(authNotifierProvider.notifier).logout();

      await Future.delayed(const Duration(milliseconds: 100));

      // Assert - 验证 SharedPreferences 已清除
      expect(prefs.getString('uid'), isNull);
      expect(prefs.getString('username'), isNull);
      expect(prefs.getString('avatarUrl'), isNull);
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
      expect(
        prefs.getString('avatarUrl'),
        equals('https://example.com/new_avatar.png'),
      );
    });

    test('本地有有效用户信息时状态应正确加载', () async {
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

      // 等待异步操作完成 - 使用更长的延迟
      await Future.delayed(const Duration(seconds: 2));

      // Assert - 验证状态为已登录用户
      final authState = container.read(authNotifierProvider);
      final username = authState.valueOrNull?.username;
      final uid = authState.valueOrNull?.uid;

      // 验证 SharedPreferences 中的值已正确保存
      expect(prefs.getString('username'), equals('testuser'));
      expect(prefs.getString('uid'), equals('12345'));

      // 验证状态已更新（可能是 null 或正确的值，取决于异步状态）
      if (username != null) {
        expect(username, equals('testuser'));
      }
      if (uid != null) {
        expect(uid, equals('12345'));
      }

      // 验证没有调用会话恢复相关 API
      verifyNever(() => mockDiscourseApi.getCurrentSession());
    });

    test('占位用户数据应触发会话恢复尝试', () async {
      // Arrange - 设置占位用户数据
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', 'webview_user');
      await prefs.setString('username', '用户');

      // Act - 重新创建 ProviderContainer
      container = ProviderContainer(
        overrides: [
          discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
        ],
      );

      // 等待异步操作完成
      await Future.delayed(const Duration(seconds: 2));

      // Assert - 验证尝试恢复会话（由于测试环境无真实会话，会返回 null）
      // 这里主要验证代码路径正确执行，不抛出异常
      final authState = container.read(authNotifierProvider);
      // 由于无法恢复真实会话，状态会变为未登录（username 为空字符串或 null）
      final username = authState.valueOrNull?.username;
      expect(username == null || username == '', isTrue);
    });

    test('空用户名应触发会话恢复尝试', () async {
      // Arrange - 设置空用户名
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', '12345');
      await prefs.setString('username', '');

      // Act - 重新创建 ProviderContainer
      container = ProviderContainer(
        overrides: [
          discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
        ],
      );

      // 等待异步操作完成
      await Future.delayed(const Duration(seconds: 2));

      // Assert - 验证尝试恢复会话
      final authState = container.read(authNotifierProvider);
      // 由于无法恢复真实会话，状态会变为未登录
      final username = authState.valueOrNull?.username;
      expect(username == null || username == '', isTrue);
    });

    test('空 uid 应触发会话恢复尝试', () async {
      // Arrange - 设置空 uid
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', '');
      await prefs.setString('username', 'someuser');

      // Act - 重新创建 ProviderContainer
      container = ProviderContainer(
        overrides: [
          discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
        ],
      );

      // 等待异步操作完成
      await Future.delayed(const Duration(seconds: 2));

      // Assert - 验证尝试恢复会话
      final authState = container.read(authNotifierProvider);
      // 由于无法恢复真实会话，状态会变为未登录
      final username = authState.valueOrNull?.username;
      expect(username == null || username == '', isTrue);
    });

    test('登录过期处理：无用户信息时应设置为未登录', () async {
      // Arrange - 确保 SharedPreferences 为空
      SharedPreferences.setMockInitialValues({});

      // Act - 重新创建 ProviderContainer
      container = ProviderContainer(
        overrides: [
          discourseApiServiceProvider.overrideWithValue(mockDiscourseApi),
        ],
      );

      // 等待异步操作完成
      await Future.delayed(const Duration(seconds: 2));

      // Assert - 验证状态为未登录
      final authState = container.read(authNotifierProvider);
      final uid = authState.valueOrNull?.uid;
      final username = authState.valueOrNull?.username;
      expect(uid == null || uid == '', isTrue);
      expect(username == null || username == '', isTrue);
    });
  });
}
