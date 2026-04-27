import 'package:dio/dio.dart' as dio_lib;
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:logger/logger.dart';
import '../../config/constants.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/log_interceptor.dart' as app_log;
import 'interceptors/error_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// Dio 客户端配置
class DioClient {
  static dio_lib.Dio? _dio;
  static CookieJar? _cookieJar;
  static final Logger _logger = Logger();
  static final Map<String, String> _lastCookiePayloadByUrl = <String, String>{};

  /// 获取 Dio 实例
  static dio_lib.Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  /// 获取 CookieJar 实例
  static CookieJar? get cookieJar => _cookieJar;

  /// 创建 Dio 实例
  static dio_lib.Dio _createDio() {
    _logger.i('🔧 [DioClient] 创建 Dio 实例...');

    final dio = dio_lib.Dio(
      dio_lib.BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: AppConstants.connectTimeout,
        sendTimeout: AppConstants.sendTimeout,
        receiveTimeout: AppConstants.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': _buildUserAgent(),
        },
        // 允许所有状态码，让 ErrorInterceptor 来处理错误
        validateStatus: (status) {
          _logger.i('🔍 [DioClient] validateStatus called: $status');
          return true;
        },
      ),
    );

    _logger.i('✅ [DioClient] Dio 实例创建完成，validateStatus 已配置');

    // 添加拦截器
    dio.interceptors.addAll([
      RetryInterceptor(dio: dio),
      AuthInterceptor(),
      app_log.LogInterceptor(),
      ErrorInterceptor(),
    ]);

    // 初始化 CookieManager（如果尚未初始化）
    // CookieManager 需要在其他拦截器之后添加，以确保 Cookie 处理在最后
    _initCookieManager(dio);

    return dio;
  }

  /// 初始化 CookieManager
  /// 如果 _cookieJar 已经存在（如持久化的 PersistCookieJar），则使用现有的
  /// 否则创建一个新的内存 CookieJar
  static void _initCookieManager(dio_lib.Dio dio) {
    // 如果 _cookieJar 已经存在，说明已经初始化过（如持久化的 CookieJar）
    _cookieJar ??= CookieJar();
    dio.interceptors.add(CookieManager(_cookieJar!));
  }

  /// 初始化持久化 CookieManager
  /// 在应用启动时调用，确保 Cookie 持久化
  static Future<void> initPersistentCookieManager() async {
    _logger.i('🔧 [DioClient] 初始化持久化 CookieManager...');
    try {
      // 如果 Dio 实例已存在，先重置
      if (_dio != null) {
        _logger.i('🔄 [DioClient] 重置现有 Dio 实例');
        reset();
      }

      final directory = await getApplicationDocumentsDirectory();
      final cookiePath = path.join(directory.path, '.cookies/');
      _logger.i('📁 [DioClient] Cookie 存储路径: $cookiePath');

      // 先设置持久化的 CookieJar
      // cookie_jar 4.x 版本使用路径字符串而不是 FileStorage
      _cookieJar = PersistCookieJar(
        ignoreExpires: true,
        storage: FileStorage(cookiePath),
      );
      _logger.i('✅ [DioClient] PersistCookieJar 已创建');

      // 创建新的 Dio 实例
      // 此时 _createDio 中的 _initCookieManager 会使用已设置的 _cookieJar
      final dio = DioClient.dio;
      _logger.i('✅ [DioClient] Dio 实例已获取，拦截器数量: ${dio.interceptors.length}');

      _logger.i('✅ [DioClient] 持久化 CookieManager 初始化成功');
    } catch (e, stackTrace) {
      _logger.e('❌ [DioClient] 初始化持久化 CookieManager 失败: $e');
      _logger.e('❌ [DioClient] 错误堆栈: $stackTrace');
      // 使用内存 CookieJar 作为降级方案
      _cookieJar = CookieJar();
      _logger.w('⚠️ [DioClient] 已降级使用内存 CookieJar');
    }
  }

  /// 从 WebView Cookie 字符串加载 Cookie 到 CookieJar
  /// 在 WebView 登录成功后调用，将 WebView 的 Cookie 同步到 Dio
  static Future<void> loadCookiesFromWebView(
    String cookieString,
    String url,
  ) async {
    try {
      if (_cookieJar == null) {
        _logger.w('⚠️ [DioClient] CookieJar 未初始化');
        return;
      }

      final uri = Uri.parse(url);
      final cookies = <Cookie>[];
      var normalized = cookieString.trim();
      if (normalized.startsWith('"') &&
          normalized.endsWith('"') &&
          normalized.length >= 2) {
        normalized = normalized.substring(1, normalized.length - 1);
      }
      normalized = normalized.replaceAll(r'\"', '"');
      final lastPayload = _lastCookiePayloadByUrl[url];
      if (lastPayload == normalized) {
        _logger.d('ℹ️ [DioClient] Cookie 未变化，跳过重复同步: $url');
        return;
      }

      // 解析 Cookie 字符串
      final pairs = normalized.split(';');
      for (final pair in pairs) {
        final trimmed = pair.trim();
        if (trimmed.isEmpty) continue;

        final index = trimmed.indexOf('=');
        if (index > 0) {
          final name = trimmed.substring(0, index).trim();
          final value = trimmed.substring(index + 1).trim();

          // 移除可能的引号
          final cleanValue = value.replaceAll('"', '');

          if (name.contains('"') ||
              name.contains('\n') ||
              name.contains('\r')) {
            _logger.w('⚠️ [DioClient] 跳过非法 Cookie 名称: $name');
            continue;
          }

          cookies.add(Cookie(name, cleanValue));
        }
      }

      if (cookies.isEmpty) {
        _logger.w('⚠️ [DioClient] 未解析到可用 Cookie: $url');
        return;
      }

      // 保存 Cookie 到 CookieJar
      await _cookieJar!.saveFromResponse(uri, cookies);
      _lastCookiePayloadByUrl[url] = normalized;
      _logger.i('✅ [DioClient] WebView Cookie 已同步到 Dio，共 ${cookies.length} 个');
    } catch (e) {
      _logger.e('❌ [DioClient] 加载 WebView Cookie 失败: $e');
    }
  }

  /// 获取指定 URL 的 Cookie 字符串
  static Future<String> getCookieString(String url) async {
    try {
      if (_cookieJar == null) return '';

      final uri = Uri.parse(url);
      final cookies = await _cookieJar!.loadForRequest(uri);

      if (cookies.isEmpty) return '';

      return cookies.map((c) => '${c.name}=${c.value}').join('; ');
    } catch (e) {
      _logger.e('❌ [DioClient] 获取 Cookie 字符串失败: $e');
      return '';
    }
  }

  /// 获取指定 URL 的 Cookie 名称列表（调试用）
  static Future<List<String>> getCookieNames(String url) async {
    try {
      if (_cookieJar == null) return const [];
      final uri = Uri.parse(url);
      final cookies = await _cookieJar!.loadForRequest(uri);
      return cookies.map((c) => c.name).toList();
    } catch (e) {
      _logger.e('❌ [DioClient] 获取 Cookie 名称失败: $e');
      return const [];
    }
  }

  /// 清除所有 Cookie
  static Future<void> clearCookies() async {
    try {
      if (_cookieJar != null) {
        await _cookieJar!.deleteAll();
        _logger.i('🗑️ [DioClient] 所有 Cookie 已清除');
      }
    } catch (e) {
      _logger.e('❌ [DioClient] 清除 Cookie 失败: $e');
    }
  }

  /// 构建 User-Agent
  static String _buildUserAgent() {
    // TODO: 从设备信息获取
    return 'TRAE-Forum-Flutter/1.0.0';
  }

  /// 重置 Dio 实例
  static void reset() {
    _dio?.close();
    _dio = null;
  }

  /// 更新 Token
  static void updateToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// 清除 Token
  static void clearToken() {
    dio.options.headers.remove('Authorization');
  }

  /// 检查是否有 Discourse 登录 session
  ///
  /// 通过检查 CookieJar 中是否存在 Discourse 的 session cookie 来判断
  /// 返回 true 表示用户已登录 Discourse
  static Future<bool> hasDiscourseSession() async {
    try {
      if (_cookieJar == null) return false;

      final uri = Uri.parse('https://forum.trae.cn');
      final cookies = await _cookieJar!.loadForRequest(uri);

      // 检查是否有 Discourse 的 session cookie（_t 是 Discourse 的主要 session cookie）
      final hasSession = cookies.any(
        (cookie) => cookie.name == '_t' || cookie.name == '_forum_session',
      );

      _logger.i(
        '🔍 [DioClient] Discourse session check: $hasSession, cookies: ${cookies.map((c) => c.name).join(', ')}',
      );
      return hasSession;
    } catch (e) {
      _logger.e('❌ [DioClient] 检查 Discourse session 失败: $e');
      return false;
    }
  }
}

/// API 异常
class ApiException implements Exception {
  final int? code;
  final String message;
  final dynamic data;

  ApiException({this.code, required this.message, this.data});

  @override
  String toString() =>
      'ApiException(code: $code, message: $message, data: $data)';
}

/// 网络异常类型
enum NetworkExceptionType {
  /// 连接超时
  connectTimeout,

  /// 发送超时
  sendTimeout,

  /// 接收超时
  receiveTimeout,

  /// 响应错误
  response,

  /// 取消请求
  cancel,

  /// 其他错误
  other,
}

/// 网络异常
class NetworkException implements Exception {
  final NetworkExceptionType type;
  final String message;
  final dynamic error;

  NetworkException({required this.type, required this.message, this.error});

  @override
  String toString() =>
      'NetworkException(type: $type, message: $message, error: $error)';
}

/// 业务错误码
class BusinessErrorCode {
  /// 成功
  static const int success = 0;

  /// 未登录
  static const int unauthorized = 401;

  /// 禁止访问
  static const int forbidden = 403;

  /// 资源不存在
  static const int notFound = 404;

  /// 服务器错误
  static const int serverError = 500;

  /// 参数错误
  static const int badRequest = 400;

  /// 请求过于频繁
  static const int tooManyRequests = 429;
}
