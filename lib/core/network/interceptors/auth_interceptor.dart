import 'package:dio/dio.dart';
import '../../../config/constants.dart';

/// 认证拦截器
class AuthInterceptor extends Interceptor {
  String? _token;
  
  /// 设置 Token
  void setToken(String? token) {
    _token = token;
  }
  
  /// 清除 Token
  void clearToken() {
    _token = null;
  }
  
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 添加认证 Token
    if (_token != null && _token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $_token';
    }
    
    // 添加设备信息
    // TODO: 从设备信息获取
    options.headers['X-Device-Id'] = StorageKeys.deviceId;
    options.headers['X-App-Version'] = AppConstants.appVersion;
    
    handler.next(options);
  }
  
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 检查响应中是否包含新的 Token
    final newToken = response.headers.value('x-auth-token');
    if (newToken != null && newToken.isNotEmpty) {
      _token = newToken;
      // TODO: 保存到本地存储
    }
    
    handler.next(response);
  }
  
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 处理认证错误
    if (err.response?.statusCode == 401) {
      // Token 过期，清除 Token
      clearToken();
      // TODO: 跳转到登录页面
    }
    
    handler.next(err);
  }
}
