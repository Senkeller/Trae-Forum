import 'package:dio/dio.dart';
import '../../../config/constants.dart';
import '../../utils/device_util.dart';
import 'csrf_token_manager.dart';

/// 认证拦截器
/// 负责处理 Discourse API 认证、CSRF Token 注入和会话管理
class AuthInterceptor extends Interceptor {
  String? _token;
  String? _deviceId;

  void setToken(String? token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  /// 设置设备 ID
  /// [deviceId] 设备标识符
  void setDeviceId(String deviceId) {
    _deviceId = deviceId;
  }

  /// 获取设备 ID
  /// 优先使用已设置的设备 ID，否则从 DeviceUtil 获取
  String _getDeviceId() {
    // 优先使用已设置的设备 ID
    if (_deviceId != null && _deviceId!.isNotEmpty) {
      return _deviceId!;
    }
    // 从 DeviceUtil 获取设备 ID
    final deviceId = DeviceUtil.deviceId;
    if (deviceId.isNotEmpty) {
      return deviceId;
    }
    // 如果都获取不到，返回空字符串而不是常量名
    return '';
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

    // 从 DeviceUtil 获取真实的设备 ID，而不是使用常量名
    final deviceId = _getDeviceId();
    if (deviceId.isNotEmpty) {
      options.headers['X-Device-Id'] = deviceId;
    }
    options.headers['X-App-Version'] = AppConstants.appVersion;

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
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