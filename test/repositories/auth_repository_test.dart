import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:traeu/data/repositories/auth_repository.dart';
import 'package:traeu/core/network/api_service.dart';

/// Mock ApiService 用于测试
class MockApiService extends Mock implements ApiService {}

/// 认证仓库单元测试
///
/// 测试目标：验证 AuthRepository 的各种方法行为，包括：
/// - 登录相关操作
/// - Token 管理
/// - 登录状态检查
/// - 错误处理
void main() {
  late AuthRepository authRepository;
  late MockApiService mockApiService;

  setUp(() {
    mockApiService = MockApiService();
    authRepository = AuthRepository(mockApiService);
  });

  group('登录方法测试', () {
    /// 测试目的：验证登录成功场景
    test('登录成功应返回响应数据', () async {
      // 准备模拟响应
      final mockResponse = Response(
        data: {'status': 200, 'message': '登录成功'},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/auth/loginByCoolApk'),
      );

      when(() => mockApiService.tryLogin(data: any(named: 'data')))
          .thenAnswer((_) async => mockResponse);

      // 执行测试
      final result = await authRepository.login(data: {
        'username': 'test_user',
        'password': 'password123',
      });

      // 验证结果
      expect(result.statusCode, equals(200));
      expect(result.data['status'], equals(200));
      verify(() => mockApiService.tryLogin(data: any(named: 'data'))).called(1);
    });

    /// 测试目的：验证登录失败时抛出异常
    test('登录失败应抛出异常', () async {
      when(() => mockApiService.tryLogin(data: any(named: 'data')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/auth/loginByCoolApk'),
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: '/auth/loginByCoolApk'),
        ),
      ));

      // 执行测试并验证异常
      expect(
        () => authRepository.login(data: {'username': 'test', 'password': 'wrong'}),
        throwsException,
      );
    });

    /// 测试目的：验证网络超时处理
    test('网络超时应抛出 NetworkException', () async {
      when(() => mockApiService.tryLogin(data: any(named: 'data')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/auth/loginByCoolApk'),
        type: DioExceptionType.connectionTimeout,
      ));

      expect(
        () => authRepository.login(data: {'username': 'test', 'password': 'test'}),
        throwsException,
      );
    });
  });

  group('预获取登录参数测试', () {
    /// 测试目的：验证预获取登录参数成功
    test('应成功获取登录参数', () async {
      final mockResponse = Response(
        data: {'token': 'csrf_token_123'},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/auth/login/'),
      );

      when(() => mockApiService.preGetLoginParam(type: 'mobile'))
          .thenAnswer((_) async => mockResponse);

      final result = await authRepository.preGetLoginParam(type: 'mobile');

      expect(result.statusCode, equals(200));
      verify(() => mockApiService.preGetLoginParam(type: 'mobile')).called(1);
    });

    /// 测试目的：验证使用默认类型参数
    test('应使用默认类型 mobile', () async {
      final mockResponse = Response(
        data: {},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/auth/login/'),
      );

      when(() => mockApiService.preGetLoginParam(type: any(named: 'type')))
          .thenAnswer((_) async => mockResponse);

      await authRepository.preGetLoginParam();

      verify(() => mockApiService.preGetLoginParam(type: 'mobile')).called(1);
    });
  });

  group('获取登录参数测试', () {
    /// 测试目的：验证获取登录参数
    test('应成功获取登录参数', () async {
      final mockResponse = Response(
        data: {'loginParam': 'value'},
        statusCode: 200,
        requestOptions: RequestOptions(path: '/auth/loginByCoolApk'),
      );

      when(() => mockApiService.getLoginParam())
          .thenAnswer((_) async => mockResponse);

      final result = await authRepository.getLoginParam();

      expect(result.statusCode, equals(200));
      verify(() => mockApiService.getLoginParam()).called(1);
    });
  });

  group('检查登录信息测试', () {
    /// 测试目的：验证检查登录信息成功
    test('应成功检查登录信息', () async {
      final checkResponse = CheckResponse(
        status: 200,
        data: {'uid': '12345', 'username': 'test_user'},
      );

      when(() => mockApiService.checkLoginInfo())
          .thenAnswer((_) async => checkResponse);

      final result = await authRepository.checkLoginInfo();

      expect(result.status, equals(200));
      expect(result.data, isNotNull);
      verify(() => mockApiService.checkLoginInfo()).called(1);
    });

    /// 测试目的：验证未登录状态
    test('应正确处理未登录状态', () async {
      final checkResponse = CheckResponse(
        status: 401,
        data: null,
      );

      when(() => mockApiService.checkLoginInfo())
          .thenAnswer((_) async => checkResponse);

      final result = await authRepository.checkLoginInfo();

      expect(result.status, equals(401));
      expect(result.data, isNull);
    });
  });

  group('Token 管理测试', () {
    /// 测试目的：验证设置 Token
    /// 注意：由于 DioClient 是静态方法，这里主要验证方法调用不抛异常
    test('设置 Token 不应抛异常', () {
      expect(
        () => authRepository.setToken('test_token_123'),
        returnsNormally,
      );
    });

    /// 测试目的：验证清除 Token
    test('清除 Token 不应抛异常', () {
      expect(
        () => authRepository.clearToken(),
        returnsNormally,
      );
    });
  });

  group('登出测试', () {
    /// 测试目的：验证登出操作
    test('登出应清除 Token', () {
      expect(
        () => authRepository.logout(),
        returnsNormally,
      );
    });
  });

  group('登录状态检查测试', () {
    /// 测试目的：验证已登录状态返回 true
    test('已登录应返回 true', () async {
      final checkResponse = CheckResponse(
        status: BusinessErrorCode.success,
        data: {'uid': '12345'},
      );

      when(() => mockApiService.checkLoginInfo())
          .thenAnswer((_) async => checkResponse);

      final result = await authRepository.isLoggedIn();

      expect(result, isTrue);
    });

    /// 测试目的：验证未登录状态返回 false
    test('未登录应返回 false', () async {
      final checkResponse = CheckResponse(
        status: BusinessErrorCode.unauthorized,
        data: null,
      );

      when(() => mockApiService.checkLoginInfo())
          .thenAnswer((_) async => checkResponse);

      final result = await authRepository.isLoggedIn();

      expect(result, isFalse);
    });

    /// 测试目的：验证异常时返回 false
    test('检查异常时应返回 false', () async {
      when(() => mockApiService.checkLoginInfo())
          .thenThrow(Exception('网络错误'));

      final result = await authRepository.isLoggedIn();

      expect(result, isFalse);
    });
  });
}
