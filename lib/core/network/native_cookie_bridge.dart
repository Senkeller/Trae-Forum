import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dio_client.dart';

/// 原生 Cookie 桥接
///
/// 用于从系统 WebView CookieManager 读取完整 Cookie（含 HttpOnly），
/// 并同步到 Dio 的 CookieJar。
class NativeCookieBridge {
  static const MethodChannel _channel = MethodChannel('com.trae.forum/cookies');

  /// 从系统 CookieManager 读取指定 URL 的 Cookie 字符串
  static Future<String> getCookieString(String url) async {
    if (kIsWeb || !Platform.isAndroid) {
      return '';
    }

    try {
      final cookieString = await _channel.invokeMethod<String>(
        'getCookies',
        <String, String>{'url': url},
      );
      return cookieString?.trim() ?? '';
    } catch (_) {
      return '';
    }
  }

  /// 从系统 CookieManager 同步 Cookie 到 Dio
  static Future<bool> syncCookiesToDio(String url) async {
    final cookieString = await getCookieString(url);
    if (cookieString.isEmpty) {
      return false;
    }
    await DioClient.loadCookiesFromWebView(cookieString, url);
    return true;
  }
}
