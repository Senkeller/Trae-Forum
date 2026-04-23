import 'package:dio/dio.dart';
import '../dio_client.dart';

/// 错误拦截器
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final error = _handleError(err);
    handler.reject(error);
  }

  DioException _handleError(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return DioException(
          requestOptions: err.requestOptions,
          type: err.type,
          error: NetworkException(
            type: NetworkExceptionType.connectTimeout,
            message: '连接超时，请检查网络',
            error: err.error,
          ),
        );

      case DioExceptionType.badResponse:
        return _handleBadResponse(err);

      case DioExceptionType.cancel:
        return DioException(
          requestOptions: err.requestOptions,
          type: err.type,
          error: NetworkException(
            type: NetworkExceptionType.cancel,
            message: '请求已取消',
            error: err.error,
          ),
        );

      case DioExceptionType.connectionError:
        return DioException(
          requestOptions: err.requestOptions,
          type: err.type,
          error: NetworkException(
            type: NetworkExceptionType.other,
            message: '网络连接错误，请检查网络设置',
            error: err.error,
          ),
        );

      default:
        return DioException(
          requestOptions: err.requestOptions,
          type: err.type,
          error: NetworkException(
            type: NetworkExceptionType.other,
            message: '网络错误: ${err.message}',
            error: err.error,
          ),
        );
    }
  }

  DioException _handleBadResponse(DioException err) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    String message;
    switch (statusCode) {
      case 400:
        message = data?['message'] ?? '请求参数错误';
        break;
      case 401:
        message = '登录已过期，请重新登录';
        break;
      case 403:
        message = '没有权限访问';
        break;
      case 404:
        message = '请求的资源不存在';
        break;
      case 500:
      case 502:
      case 503:
      case 504:
        message = '服务器错误，请稍后重试';
        break;
      default:
        message = data?['message'] ?? '请求失败: $statusCode';
    }

    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: ApiException(
        code: statusCode,
        message: message,
        data: data,
      ),
    );
  }
}
