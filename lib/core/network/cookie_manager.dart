import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'native_cookie_bridge.dart';

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

  /// Trae 相关域名（用于从系统 CookieManager 同步完整 Cookie）
  static const List<String> _traeCookieUrls = [
    'https://www.trae.cn',
    'https://api.trae.cn',
    'https://trae.cn',
  ];

  /// 从 WebView 提取并保存 Trae Cookie
  ///
  /// [controller] WebView 控制器
  /// 返回是否成功保存 Cookie
  static Future<bool> extractAndSaveCookies(
    WebViewController controller,
  ) async {
    try {
      // 使用 JavaScript 从页面获取 Cookie
      final cookiesString = await controller.runJavaScriptReturningResult(
        'document.cookie',
      );

      if (cookiesString.toString().isEmpty) {
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

  /// 从原生 CookieBridge 同步完整 Cookie（含 HttpOnly）
  ///
  /// 返回是否成功获取到任意 Cookie
  static Future<bool> syncCookiesFromNativeBridge() async {
    var hasAny = false;

    for (final url in _traeCookieUrls) {
      try {
        final cookieString = await NativeCookieBridge.getCookieString(url);
        if (cookieString.isEmpty) continue;

        final cookies = _parseCookieString(cookieString);
        if (cookies.isEmpty) continue;

        await _saveCookies(cookies);
        hasAny = true;
        print('✅ [TraeCookieManager] 从 NativeBridge 同步 Cookie 成功: $url');
      } catch (e) {
        print(
          '⚠️ [TraeCookieManager] 从 NativeBridge 同步 Cookie 失败: $url, error=$e',
        );
      }
    }

    return hasAny;
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

    // 打印所有获取到的 Cookie 名称
    print('🔍 [TraeCookieManager] 获取到的所有 Cookie: ${cookies.keys.toList()}');

    for (final entry in cookies.entries) {
      // 保存所有 Cookie（不只是关键 Cookie）
      final key = '$_prefix${entry.key}';
      await prefs.setString(key, entry.value);
      savedCount++;
      print(
        '💾 [TraeCookieManager] 保存 Cookie: ${entry.key}=${entry.value.substring(0, entry.value.length > 20 ? 20 : entry.value.length)}...',
      );
    }

    // 记录保存时间
    await prefs.setInt(
      '${_prefix}saved_at',
      DateTime.now().millisecondsSinceEpoch,
    );
    print('✅ [TraeCookieManager] Cookie 保存完成，共 $savedCount 个 Cookie');
    print(
      '🔍 [TraeCookieManager] 关键 Cookie 检查: sessionid=${cookies.containsKey('sessionid')}, ttwid=${cookies.containsKey('ttwid')}',
    );
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

    // 获取所有以 _prefix 开头的 key
    final keys = prefs.getKeys().where(
      (k) => k.startsWith(_prefix) && k != '${_prefix}saved_at',
    );

    for (final key in keys) {
      final value = prefs.getString(key);
      if (value != null && value.isNotEmpty) {
        // 移除前缀获取原始 Cookie 名称
        final name = key.substring(_prefix.length);
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
    // 先尝试从原生 CookieManager 同步（可补齐 HttpOnly Cookie）
    await syncCookiesFromNativeBridge();

    final cookies = await getAllCookies();
    if (cookies.isEmpty) {
      print('[TraeCookieManager] hasValidCookies check: no cookies');
      return false;
    }

    // 兼容不同环境 Cookie 命名差异：只要有核心认证 Cookie 或 Cookie 总数>0 都视为可尝试请求
    final hasKnownAuthCookie =
        _essentialCookies.any(cookies.containsKey) ||
        cookies.containsKey('passport_csrf_token');

    print(
      '[TraeCookieManager] hasValidCookies check: sessionid=${cookies.containsKey('sessionid')}, '
      'ttwid=${cookies.containsKey('ttwid')}, '
      'passport_csrf_token=${cookies.containsKey('passport_csrf_token')}, '
      'passport_auth_status=${cookies.containsKey('passport_auth_status')}, '
      'cookie_count=${cookies.length}, '
      'hasKnownAuthCookie=$hasKnownAuthCookie',
    );

    return hasKnownAuthCookie || cookies.isNotEmpty;
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
