import 'package:dio/dio.dart';

/// 重试拦截器
/// 负责处理 429 Too Many Requests 错误的指数退避重试
class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final int _maxRetries;
  final void Function(DioException err, int retryCount)? onRetry;

  RetryInterceptor({
    required Dio dio,
    int maxRetries = 3,
    void Function(DioException err, int retryCount)? onRetry,
  })  : _dio = dio,
        _maxRetries = maxRetries,
        onRetry = onRetry;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 429) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;

      if (retryCount < _maxRetries) {
        final delay = Duration(milliseconds: 1000 * (1 << retryCount));

        err.requestOptions.extra['retryCount'] = retryCount + 1;

        onRetry?.call(err, retryCount + 1);

        try {
          await Future.delayed(delay);
          final response = await _dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e) {
          // 重试失败，继续传递错误
        }
      }
    }

    handler.next(err);
  }
}