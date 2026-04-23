import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// 日志拦截器
class LogInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 120,
      colors: true,
      printEmojis: true,
    ),
  );
  
  final bool request;
  final bool requestHeader;
  final bool requestBody;
  final bool responseBody;
  final bool responseHeader;
  final bool error;
  
  LogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseBody = true,
    this.responseHeader = false,
    this.error = true,
  });
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (request) {
      _logger.i('⬆️ REQUEST ⬆️');
      _logger.i('${options.method} ${options.uri}');
      
      if (requestHeader) {
        _logger.v('Headers:');
        options.headers.forEach((key, value) {
          _logger.v('  $key: $value');
        });
      }
      
      if (requestBody && options.data != null) {
        _logger.v('Body: ${options.data}');
      }
    }
    
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (responseBody) {
      _logger.i('⬇️ RESPONSE ⬇️');
      _logger.i('${response.statusCode} ${response.requestOptions.uri}');
      
      if (responseHeader) {
        _logger.v('Headers:');
        response.headers.forEach((key, value) {
          _logger.v('  $key: $value');
        });
      }
      
      _logger.v('Body: ${response.data}');
    }
    
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (error) {
      _logger.e('❌ ERROR ❌');
      _logger.e('${err.requestOptions.method} ${err.requestOptions.uri}');
      _logger.e('Error: ${err.message}');
      
      if (err.response != null) {
        _logger.e('Status Code: ${err.response?.statusCode}');
        _logger.e('Response: ${err.response?.data}');
      }
    }
    
    handler.next(err);
  }
}
