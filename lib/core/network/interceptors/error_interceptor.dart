import 'package:dio/dio.dart';
import '../dio_client.dart';

/// 登录过期回调函数类型
typedef OnAuthExpiredCallback = void Function();

/// 错误拦截器
///
/// 处理 HTTP 请求中的各种错误情况，包括网络错误、超时、HTTP 状态码错误等
/// 注意：DioClient 配置了 validateStatus: (status) => true，所以所有状态码都会走 onResponse
class ErrorInterceptor extends Interceptor {
  /// 登录过期回调，用于通知上层更新登录状态
  static OnAuthExpiredCallback? onAuthExpired;
  static DateTime? _lastAuthExpiredNotifyAt;
  static const Duration _authExpiredNotifyCooldown = Duration(seconds: 2);

  static void _notifyAuthExpiredIfNeeded() {
    final now = DateTime.now();
    final last = _lastAuthExpiredNotifyAt;
    if (last != null && now.difference(last) < _authExpiredNotifyCooldown) {
      return;
    }
    _lastAuthExpiredNotifyAt = now;
    onAuthExpired?.call();
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '🔍 [ErrorInterceptor] onResponse: statusCode=${response.statusCode}',
    );

    // 检查响应状态码，非 2xx 状态码视为错误
    final statusCode = response.statusCode ?? 0;
    if (statusCode < 200 || statusCode >= 300) {
      print(
        '⚠️ [ErrorInterceptor] 非 2xx 状态码: $statusCode, data=${response.data}',
      );

      // 创建 DioException 并通过 onError 处理
      final error = DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        error: _createApiException(statusCode, response.data),
      );
      handler.reject(error);
      return;
    }
    handler.next(response);
  }

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

    final apiException = _createApiException(statusCode, data);

    return DioException(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: apiException,
    );
  }

  /// 根据状态码和数据创建 ApiException
  ApiException _createApiException(int? statusCode, dynamic data) {
    String message;
    switch (statusCode) {
      case 400:
        message = data?['message'] ?? '请求参数错误';
        break;
      case 401:
        message = '登录已过期，请重新登录';
        // 触发登录过期回调
        _notifyAuthExpiredIfNeeded();
        break;
      case 403:
        // 403 可能是未登录或权限不足
        final errors = data?['errors'];
        if (errors is List && errors.isNotEmpty) {
          message = errors.first.toString();
        } else {
          message = data?['message'] ?? '没有权限访问';
        }
        // 检查是否是登录过期导致的 403
        final errorType = data?['error_type']?.toString();
        final isNotLoggedIn =
            errorType == 'not_logged_in' ||
            (errors is List &&
                errors.any(
                  (e) =>
                      e.toString().contains('登录') ||
                      e.toString().contains('需要登录'),
                ));
        if (isNotLoggedIn) {
          message = '登录已过期，请重新登录';
          _notifyAuthExpiredIfNeeded();
        }
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

    return ApiException(code: statusCode, message: message, data: data);
  }
}
