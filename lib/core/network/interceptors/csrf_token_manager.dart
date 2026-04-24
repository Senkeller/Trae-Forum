import 'package:dio/dio.dart';

/// Discourse CSRF Token 管理器
/// 负责获取、存储和更新 Discourse API 所需的 CSRF Token
class DiscourseCsrfToken {
  static String? _token;
  static DateTime? _tokenTime;
  static const Duration _tokenValidityPeriod = Duration(hours: 1);

  /// 获取当前存储的 CSRF Token
  static String? get token => _token;

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
  static Future<bool> fetchToken(Dio dio) async {
    try {
      final response = await dio.get('/session/csrf.json');
      if (response.data != null && response.data is Map) {
        final newToken = response.data['csrfToken'] as String?;
        if (newToken != null && newToken.isNotEmpty) {
          _token = newToken;
          _tokenTime = DateTime.now();
          return true;
        }
      }
      return false;
    } catch (e) {
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
      await fetchToken(dio);
    }
  }
}