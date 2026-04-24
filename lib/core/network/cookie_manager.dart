import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Trae Cookie 管理器
///
/// 负责管理 Trae Dashboard API 所需的 Cookie
/// 包括提取、保存、读取和清除 Cookie
class TraeCookieManager {
  static const String _prefix = 'trae_cookie_';

  /// 关键 Cookie 名称列表
  static const List<String> _essentialCookies = [
    'sessionid',
    'sessionid_ss',
    'sid_tt',
    'ttwid',
    'X-Cloudide-Session',
    'sid_guard',
    'uid_tt',
    'passport_auth_status',
  ];

  /// 从 WebView 提取并保存 Trae Cookie
  ///
  /// [controller] WebView 控制器
  /// 返回是否成功保存 Cookie
  static Future<bool> extractAndSaveCookies(WebViewController controller) async {
    try {
      final cookieManager = WebViewCookieManager();
      final cookies = await cookieManager.getCookies(
        WebViewCookieManager.getCookiesUrl(
          Uri.parse('https://www.trae.cn'),
        ),
      );

      if (cookies == null || cookies.isEmpty) {
        // 尝试从 api.trae.cn 获取
        final apiCookies = await cookieManager.getCookies(
          WebViewCookieManager.getCookiesUrl(
            Uri.parse('https://api.trae.cn'),
          ),
        );
        if (apiCookies != null && apiCookies.isNotEmpty) {
          await _saveCookies(apiCookies);
          return true;
        }
        return false;
      }

      await _saveCookies(cookies);
      return true;
    } catch (e) {
      print('❌ [TraeCookieManager] 提取 Cookie 失败: $e');
      return false;
    }
  }

  /// 保存 Cookie 到本地存储
  ///
  /// [cookies] Cookie 列表
  static Future<void> _saveCookies(List<WebViewCookie> cookies) async {
    final prefs = await SharedPreferences.getInstance();

    for (final cookie in cookies) {
      final key = '$_prefix${cookie.name}';
      await prefs.setString(key, cookie.value);
      print('💾 [TraeCookieManager] 保存 Cookie: ${cookie.name}=${cookie.value.substring(0, cookie.value.length > 20 ? 20 : cookie.value.length)}...');
    }

    // 记录保存时间
    await prefs.setInt('${_prefix}saved_at', DateTime.now().millisecondsSinceEpoch);
    print('✅ [TraeCookieManager] Cookie 保存完成，共 ${cookies.length} 个');
  }

  /// 获取指定名称的 Cookie 值
  ///
  /// [name] Cookie 名称
  /// 返回 Cookie 值，如果不存在返回 null
  static Future<String?> getCookie(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('$_prefix$name');
  }

  /// 获取所有 Trae Cookie
  ///
  /// 返回 Cookie Map (name -> value)
  static Future<Map<String, String>> getAllCookies() async {
    final prefs = await SharedPreferences.getInstance();
    final cookies = <String, String>{};

    for (final name in _essentialCookies) {
      final value = prefs.getString('$_prefix$name');
      if (value != null && value.isNotEmpty) {
        cookies[name] = value;
      }
    }

    return cookies;
  }

  /// 获取格式化的 Cookie 字符串（用于 HTTP 请求头）
  ///
  /// 返回格式: "name1=value1; name2=value2"
  static Future<String> getCookieString() async {
    final cookies = await getAllCookies();
    if (cookies.isEmpty) return '';

    return cookies.entries.map((e) => '${e.key}=${e.value}').join('; ');
  }

  /// 检查是否有有效的 Trae Cookie
  ///
  /// 返回是否存在关键 Cookie
  static Future<bool> hasValidCookies() async {
    final cookies = await getAllCookies();
    // 至少需要 sessionid 或 ttwid
    return cookies.containsKey('sessionid') || cookies.containsKey('ttwid');
  }

  /// 清除所有 Trae Cookie
  static Future<void> clearCookies() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((k) => k.startsWith(_prefix)).toList();

    for (final key in keys) {
      await prefs.remove(key);
    }

    print('🗑️ [TraeCookieManager] Cookie 已清除');
  }

  /// 获取 Cookie 保存时间
  ///
  /// 返回保存时间的时间戳，如果没有保存过返回 null
  static Future<DateTime?> getSavedTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt('${_prefix}saved_at');
    if (timestamp == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// 检查 Cookie 是否过期（超过7天）
  ///
  /// 返回是否过期
  static Future<bool> isExpired() async {
    final savedTime = await getSavedTime();
    if (savedTime == null) return true;

    final now = DateTime.now();
    final diff = now.difference(savedTime);
    return diff.inDays > 7;
  }
}

/// WebViewCookieManager 扩展方法
extension WebViewCookieManagerExtension on WebViewCookieManager {
  static Uri getCookiesUrl(Uri url) => url;
}
