import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/core/network/interceptors/auth_interceptor.dart';
import 'package:traeu/core/network/interceptors/csrf_token_manager.dart';

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockResponseInterceptorHandler extends Mock
    implements ResponseInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    registerFallbackValue(RequestOptions(path: ''));
    registerFallbackValue(Response(requestOptions: RequestOptions(path: '')));
    registerFallbackValue(
      DioException(requestOptions: RequestOptions(path: '')),
    );
  });

  late AuthInterceptor authInterceptor;
  late MockRequestInterceptorHandler mockRequestHandler;
  late MockResponseInterceptorHandler mockResponseHandler;
  late MockErrorInterceptorHandler mockErrorHandler;

  setUp(() {
    authInterceptor = AuthInterceptor();
    mockRequestHandler = MockRequestInterceptorHandler();
    mockResponseHandler = MockResponseInterceptorHandler();
    mockErrorHandler = MockErrorInterceptorHandler();
  });

  group('AuthInterceptor 设备 ID 测试', () {
    test('不应将 StorageKeys.deviceId 常量名作为 Header 值', () async {
      final options = RequestOptions(path: '/test');

      authInterceptor.onRequest(options, mockRequestHandler);

      // 验证 X-Device-Id 不是常量名 'device_id'
      final deviceId = options.headers['X-Device-Id'];
      expect(deviceId, isNot(equals('device_id')));

      verify(() => mockRequestHandler.next(options)).called(1);
    });

    test('setDeviceId 设置的设备 ID 应正确添加到 Header', () async {
      const testDeviceId = 'test-device-123';
      authInterceptor.setDeviceId(testDeviceId);

      final options = RequestOptions(path: '/test');
      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers['X-Device-Id'], equals(testDeviceId));
      verify(() => mockRequestHandler.next(options)).called(1);
    });

    test('当设备 ID 为空时不应添加 X-Device-Id Header', () async {
      final options = RequestOptions(path: '/test');

      authInterceptor.onRequest(options, mockRequestHandler);

      // 当设备 ID 为空时，不应设置 X-Device-Id
      final deviceId = options.headers['X-Device-Id'];
      expect(deviceId == null || deviceId == '', isTrue);

      verify(() => mockRequestHandler.next(options)).called(1);
    });

    test('X-App-Version Header 应正确设置', () async {
      final options = RequestOptions(path: '/test');

      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers['X-App-Version'], isNotNull);
      expect(options.headers['X-App-Version'], isNotEmpty);

      verify(() => mockRequestHandler.next(options)).called(1);
    });
  });

  group('AuthInterceptor 认证测试', () {
    test('设置 token 后应在 Header 中添加 Authorization', () async {
      const testToken = 'test-token-123';
      authInterceptor.setToken(testToken);

      final options = RequestOptions(path: '/test');
      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers['Authorization'], equals('Bearer $testToken'));
      verify(() => mockRequestHandler.next(options)).called(1);
    });

    test('未设置 token 时不应添加 Authorization Header', () async {
      final options = RequestOptions(path: '/test');

      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers.containsKey('Authorization'), isFalse);
      verify(() => mockRequestHandler.next(options)).called(1);
    });

    test('clearToken 后不应再添加 Authorization Header', () async {
      const testToken = 'test-token-123';
      authInterceptor.setToken(testToken);
      authInterceptor.clearToken();

      final options = RequestOptions(path: '/test');
      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers.containsKey('Authorization'), isFalse);
      verify(() => mockRequestHandler.next(options)).called(1);
    });
  });

  group('AuthInterceptor 写操作测试', () {
    test('写操作路径应添加 Discourse 相关 Headers', () async {
      final options = RequestOptions(path: '/posts/123');

      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers['X-Requested-With'], equals('XMLHttpRequest'));
      expect(options.headers['Discourse-Logged-In'], equals('true'));
      expect(options.headers['Discourse-Present'], equals('true'));

      verify(() => mockRequestHandler.next(options)).called(1);
    });

    test('非写操作路径不应添加 Discourse 相关 Headers', () async {
      final options = RequestOptions(path: '/latest.json');

      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers.containsKey('X-Requested-With'), isFalse);
      expect(options.headers.containsKey('Discourse-Logged-In'), isFalse);
      expect(options.headers.containsKey('Discourse-Present'), isFalse);

      verify(() => mockRequestHandler.next(options)).called(1);
    });

    test('CSRF Token 应添加到写操作 Header', () async {
      const testCsrfToken = 'test-csrf-token';
      DiscourseCsrfToken.setToken(testCsrfToken);

      final options = RequestOptions(path: '/posts/123');

      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers['X-CSRF-Token'], equals(testCsrfToken));

      verify(() => mockRequestHandler.next(options)).called(1);
    });
  });

  group('AuthInterceptor 响应处理测试', () {
    test('应从响应头中提取 x-auth-token', () async {
      const testToken = 'new-auth-token';
      final response = Response(
        requestOptions: RequestOptions(path: '/test'),
        headers: Headers.fromMap({
          'x-auth-token': [testToken],
        }),
      );

      authInterceptor.onResponse(response, mockResponseHandler);

      // 验证 token 被更新 - 通过下一次请求验证
      final options = RequestOptions(path: '/test');
      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers['Authorization'], equals('Bearer $testToken'));
      verify(() => mockResponseHandler.next(response)).called(1);
    });
  });

  group('AuthInterceptor 错误处理测试', () {
    test('401 错误应清除 token', () async {
      const testToken = 'test-token';
      authInterceptor.setToken(testToken);

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/test'),
        ),
      );

      authInterceptor.onError(error, mockErrorHandler);

      // 验证 token 被清除 - 通过下一次请求验证
      final options = RequestOptions(path: '/test');
      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers.containsKey('Authorization'), isFalse);
      verify(() => mockErrorHandler.next(error)).called(1);
    });

    test('非 401 错误不应清除 token', () async {
      const testToken = 'test-token';
      authInterceptor.setToken(testToken);

      final error = DioException(
        requestOptions: RequestOptions(path: '/test'),
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: '/test'),
        ),
      );

      authInterceptor.onError(error, mockErrorHandler);

      // 验证 token 未被清除
      final options = RequestOptions(path: '/test');
      authInterceptor.onRequest(options, mockRequestHandler);

      expect(options.headers['Authorization'], equals('Bearer $testToken'));
      verify(() => mockErrorHandler.next(error)).called(1);
    });
  });
}
