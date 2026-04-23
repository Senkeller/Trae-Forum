import 'package:dio/dio.dart' as dio_lib;
import '../../config/constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/log_interceptor.dart' as app_log;
import 'interceptors/error_interceptor.dart';

/// Dio 客户端配置
class DioClient {
  static dio_lib.Dio? _dio;

  /// 获取 Dio 实例
  static dio_lib.Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  /// 创建 Dio 实例
  static dio_lib.Dio _createDio() {
    final dio = dio_lib.Dio(
      dio_lib.BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        sendTimeout: AppConstants.sendTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': _buildUserAgent(),
        },
      ),
    );

    // 添加拦截器
    dio.interceptors.addAll([
      AuthInterceptor(),
      app_log.LogInterceptor(),
      ErrorInterceptor(),
    ]);

    return dio;
  }

  /// 构建 User-Agent
  static String _buildUserAgent() {
    // TODO: 从设备信息获取
    return 'TRAE-Forum-Flutter/1.0.0';
  }

  /// 重置 Dio 实例
  static void reset() {
    _dio?.close();
    _dio = null;
  }

  /// 更新 Token
  static void updateToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// 清除 Token
  static void clearToken() {
    dio.options.headers.remove('Authorization');
  }
}

/// API 异常
class ApiException implements Exception {
  final int? code;
  final String message;
  final dynamic data;

  ApiException({
    this.code,
    required this.message,
    this.data,
  });

  @override
  String toString() => 'ApiException(code: $code, message: $message, data: $data)';
}

/// 网络异常类型
enum NetworkExceptionType {
  /// 连接超时
  connectTimeout,
  /// 发送超时
  sendTimeout,
  /// 接收超时
  receiveTimeout,
  /// 响应错误
  response,
  /// 取消请求
  cancel,
  /// 其他错误
  other,
}

/// 网络异常
class NetworkException implements Exception {
  final NetworkExceptionType type;
  final String message;
  final dynamic error;

  NetworkException({
    required this.type,
    required this.message,
    this.error,
  });

  @override
  String toString() => 'NetworkException(type: $type, message: $message, error: $error)';
}

/// 业务错误码
class BusinessErrorCode {
  /// 成功
  static const int success = 0;

  /// 未登录
  static const int unauthorized = 401;

  /// 禁止访问
  static const int forbidden = 403;

  /// 资源不存在
  static const int notFound = 404;

  /// 服务器错误
  static const int serverError = 500;

  /// 参数错误
  static const int badRequest = 400;

  /// 请求过于频繁
  static const int tooManyRequests = 429;
}
