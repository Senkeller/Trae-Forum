import 'package:dio/dio.dart';
import '../dio_client.dart';

/// Discourse CSRF Token 管理器
/// 负责获取、存储和更新 Discourse API 所需的 CSRF Token
class DiscourseCsrfToken {
  static String? _token;
  static DateTime? _tokenTime;
  static const Duration _tokenValidityPeriod = Duration(minutes: 30);

  /// 获取当前存储的 CSRF Token
  static String? get token => _token;

  /// 设置 CSRF Token（主要用于测试）
  /// [token] CSRF Token 值
  static void setToken(String token) {
    _token = token;
    _tokenTime = DateTime.now();
  }

  /// 检查 Token 是否已过期
  static bool get isExpired {
    if (_token == null || _tokenTime == null) return true;
    return DateTime.now().difference(_tokenTime!) > _tokenValidityPeriod;
  }

  /// 从 HTTP 响应头中提取 CSRF Token
  /// Discourse 通常在响应头中返回 X-CSRF-Token 或 CSRF-Token
  static void updateFromResponse(Response response) {
    final token = response.headers.value('x-csrf-token') ??
        response.headers.value('csrf-token') ??
        response.headers.value('X-CSRF-Token');
    if (token != null && token.isNotEmpty) {
      _token = token;
      _tokenTime = DateTime.now();
    }
  }

  /// 从 CSRF 专用端点获取 Token
  /// 端点: /session/csrf.json
  /// 返回包含 csrfToken 字段的 JSON 对象
  /// 注意：此端点需要在用户已登录的情况下访问
  static Future<bool> fetchToken(Dio dio) async {
    try {
      final baseUrl = dio.options.baseUrl;
      print('🔍 [DiscourseCsrfToken] 正在获取 CSRF Token from $baseUrl/session/csrf.json');

      // 检查是否有 Cookie（用户是否已登录）
      final hasSession = await DioClient.hasDiscourseSession();
      print('🔍 [DiscourseCsrfToken] 检查 Discourse Session: $hasSession');

      if (!hasSession) {
        print('⚠️ [DiscourseCsrfToken] 用户未登录或 Session Cookie 不存在');
        // 仍然尝试获取，以防万一
      }

      final response = await dio.get(
        '/session/csrf.json',
        options: Options(
          headers: {
            'X-Requested-With': 'XMLHttpRequest',
          },
        ),
      );

      print('🔍 [DiscourseCsrfToken] CSRF 响应状态: ${response.statusCode}');
      print('🔍 [DiscourseCsrfToken] CSRF 响应数据: ${response.data}');

      if (response.data != null && response.data is Map) {
        final payload = response.data as Map;
        final tokenValue = payload['csrfToken'] ?? payload['csrf'] ?? payload['token'];
        final newToken = tokenValue is String ? tokenValue : tokenValue?.toString();
        if (newToken != null && newToken.isNotEmpty) {
          _token = newToken;
          _tokenTime = DateTime.now();
          print('✅ [DiscourseCsrfToken] CSRF Token 获取成功: ${newToken.length > 10 ? '${newToken.substring(0, 10)}...' : newToken}');
          return true;
        }
      }
      print('⚠️ [DiscourseCsrfToken] CSRF Token 为空或格式错误');
      return false;
    } catch (e) {
      print('❌ [DiscourseCsrfToken] CSRF Token 获取失败: $e');
      return false;
    }
  }

  /// 清除存储的 CSRF Token
  static void clear() {
    _token = null;
    _tokenTime = null;
  }

  /// 确保拥有有效的 CSRF Token
  /// 如果没有或已过期，则自动获取
  static Future<void> ensureValid(Dio dio) async {
    if (isExpired) {
      print('🔍 [DiscourseCsrfToken] Token 已过期或不存在，尝试获取新 Token');
      await fetchToken(dio);
    } else {
      print('🔍 [DiscourseCsrfToken] Token 有效，直接使用: ${_token?.substring(0, _token!.length > 10 ? 10 : _token!.length)}...');
    }
  }
}
