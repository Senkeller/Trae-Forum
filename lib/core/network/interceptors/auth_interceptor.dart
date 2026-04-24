import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import 'csrf_token_manager.dart';

/// 认证拦截器
/// 负责处理 Discourse API 认证、CSRF Token 注入和会话管理
class AuthInterceptor extends Interceptor {
  String? _token;

  void setToken(String? token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_token != null && _token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_token';
    }

    if (_isWriteOperation(options.path)) {
      options.headers['X-Requested-With'] = 'XMLHttpRequest';
      options.headers['Discourse-Logged-In'] = 'true';
      options.headers['Discourse-Present'] = 'true';

      final csrfToken = DiscourseCsrfToken.token;
      if (csrfToken != null) {
        options.headers['X-CSRF-Token'] = csrfToken;
      }
    }

    options.headers['X-Device-Id'] = StorageKeys.deviceId;
    options.headers['X-App-Version'] = AppConstants.appVersion;

    handler.next(options);
  }

  @override
  void onResponse(Response response, RequestInterceptorHandler handler) {
    DiscourseCsrfToken.updateFromResponse(response);

    final newToken = response.headers.value('x-auth-token');
    if (newToken != null && newToken.isNotEmpty) {
      _token = newToken;
    }

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      clearToken();
    }

    handler.next(err);
  }

  bool _isWriteOperation(String path) {
    return path.contains('/posts') ||
        path.contains('/post_actions') ||
        path.contains('/bookmarks') ||
        path.contains('/notifications') ||
        path.contains('/messages') ||
        path.contains('/session') ||
        path.contains('/users');
  }
}