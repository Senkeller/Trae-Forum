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
      // 使用 JavaScript 从页面获取 Cookie
      final cookiesString = await controller.runJavaScriptReturningResult(
        'document.cookie',
      );

      if (cookiesString == null || cookiesString.toString().isEmpty) {
        print('⚠️ [TraeCookieManager] 未获取到 Cookie');
        return false;
      }

      final cookies = _parseCookieString(cookiesString.toString());
      if (cookies.isEmpty) {
        print('⚠️ [TraeCookieManager] 解析 Cookie 为空');
        return false;
      }

      await _saveCookies(cookies);
      return true;
    } catch (e) {
      print('❌ [TraeCookieManager] 提取 Cookie 失败: $e');
      return false;
    }
  }

  /// 解析 Cookie 字符串
  ///
  /// [cookieString] 格式: "name1=value1; name2=value2"
  /// 返回 Cookie Map
  static Map<String, String> _parseCookieString(String cookieString) {
    final cookies = <String, String>{};

    // 移除可能的引号
    var cleanString = cookieString;
    if (cleanString.startsWith('"') && cleanString.endsWith('"')) {
      cleanString = cleanString.substring(1, cleanString.length - 1);
    }

    final pairs = cleanString.split(';');
    for (final pair in pairs) {
      final trimmed = pair.trim();
      if (trimmed.isEmpty) continue;

      final index = trimmed.indexOf('=');
      if (index > 0) {
        final name = trimmed.substring(0, index).trim();
        final value = trimmed.substring(index + 1).trim();
        cookies[name] = value;
      }
    }

    return cookies;
  }

  /// 保存 Cookie 到本地存储
  ///
  /// [cookies] Cookie Map
  static Future<void> _saveCookies(Map<String, String> cookies) async {
    final prefs = await SharedPreferences.getInstance();
    int savedCount = 0;

    for (final entry in cookies.entries) {
      // 只保存关键 Cookie
      if (_essentialCookies.contains(entry.key)) {
        final key = '$_prefix${entry.key}';
        await prefs.setString(key, entry.value);
        savedCount++;
        print('💾 [TraeCookieManager] 保存 Cookie: ${entry.key}=${entry.value.substring(0, entry.value.length > 20 ? 20 : entry.value.length)}...');
      }
    }

    // 记录保存时间
    await prefs.setInt('${_prefix}saved_at', DateTime.now().millisecondsSinceEpoch);
    print('✅ [TraeCookieManager] Cookie 保存完成，共 $savedCount 个关键 Cookie');
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
