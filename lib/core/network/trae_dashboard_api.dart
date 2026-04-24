import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'cookie_manager.dart';
import '../../data/models/trae_dashboard.dart';

part 'trae_dashboard_api.g.dart';

/// Trae Dashboard API 服务
///
/// 负责调用 Trae Dashboard 相关 API
/// 需要登录后的 Cookie 才能访问
@riverpod
TraeDashboardApi traeDashboardApi(TraeDashboardApiRef ref) {
  return TraeDashboardApi();
}

/// Trae Dashboard API 客户端
class TraeDashboardApi {
  late final Dio _dio;

  /// 基础 URL
  static const String _baseUrl = 'https://api.trae.cn';

  /// API 路径前缀
  static const String _apiPrefix = '/cloudide/api/v3/trae';

  TraeDashboardApi() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json, text/plain, */*',
          'Origin': 'https://www.trae.cn',
          'Referer': 'https://www.trae.cn/',
        },
      ),
    );

    // 添加 Cookie 拦截器
    _dio.interceptors.add(_CookieInterceptor());

    // 添加日志拦截器（调试用）
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => print('[TraeDashboardApi] $obj'),
      ),
    );
  }

  /// 获取用户统计数据
  ///
  /// 返回用户的活跃天数、代码采纳、模型偏好等统计数据
  /// 需要用户已登录且 Cookie 有效
  Future<TraeUserStats> getUserStats() async {
    try {
      // 检查是否有有效 Cookie
      final hasCookies = await TraeCookieManager.hasValidCookies();
      if (!hasCookies) {
        throw TraeApiException(
          message: '未登录或 Cookie 已过期',
          code: 'NO_COOKIES',
        );
      }

      final response = await _dio.post(
        '$_apiPrefix/GetUserStasticData',
        data: {
          'LocalTime': DateTime.now().toUtc().toIso8601String(),
        },
      );

      if (response.statusCode != 200) {
        throw TraeApiException(
          message: '请求失败: ${response.statusCode}',
          code: 'HTTP_ERROR',
        );
      }

      final data = response.data as Map<String, dynamic>;

      // 检查响应结构
      if (data['Result'] == null) {
        throw TraeApiException(
          message: '响应数据格式错误',
          code: 'INVALID_RESPONSE',
        );
      }

      final result = data['Result'] as Map<String, dynamic>;
      return TraeUserStats.from