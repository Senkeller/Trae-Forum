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

  /// 基础 URL（dashboard 统计接口网关）
  ///
  /// `www.trae.cn/dashboard` 页面本身是 SSR 壳，真实统计数据来自
  /// `/cloudide/api/v3/trae/*` API 网关。
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
          'Referer': 'https://www.trae.cn/dashboard',
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
      // 先尝试从系统 CookieManager 补齐完整 Cookie（含 HttpOnly）
      await TraeCookieManager.syncCookiesFromNativeBridge();

      // 检查是否有有效 Cookie
      final hasCookies = await TraeCookieManager.hasValidCookies();
      print('[TraeDashboardApi] hasValidCookies: $hasCookies');

      if (!hasCookies) {
        throw TraeApiException(
          message: '未登录或 Cookie 已过期，请先登录 Trae 账号',
          code: 'NO_COOKIES',
        );
      }

      final cookieString = await TraeCookieManager.getCookieString();
      print('[TraeDashboardApi] Cookie string length: ${cookieString.length}');

      final stats = await _requestBestStats();
      print(
        '[TraeDashboardApi] 选中统计结果: userId=${stats.userId}, '
        'registerDays=${stats.registerDays}, '
        'codeAcceptCount7d=${stats.codeAcceptCount7d}, '
        'conversationCount7d=${stats.conversationCount7d}',
      );
      return stats;
    } on DioException catch (e) {
      print(
        '[TraeDashboardApi] DioException: ${e.message}, status: ${e.response?.statusCode}',
      );
      if (e.response?.statusCode == 401) {
        throw TraeApiException(message: '登录已过期，请重新登录', code: 'UNAUTHORIZED');
      }
      throw TraeApiException(
        message: '网络请求失败: ${e.message}',
        code: 'NETWORK_ERROR',
      );
    } on TraeApiException {
      rethrow;
    } catch (e, stackTrace) {
      print('[TraeDashboardApi] Error: $e');
      print('[TraeDashboardApi] StackTrace: $stackTrace');
      throw TraeApiException(message: '获取统计数据失败: $e', code: 'UNKNOWN_ERROR');
    }
  }

  Future<TraeUserStats> _requestBestStats() async {
    final now = DateTime.now();
    final payloadCandidates = <Map<String, dynamic>>[
      {'LocalTime': now.toIso8601String()},
      {'LocalTime': now.toUtc().toIso8601String()},
      {'LocalTime': now.toIso8601String(), 'IsIde': true},
      {'LocalTime': now.toIso8601String(), 'isIde': true},
      const <String, dynamic>{},
    ];

    TraeUserStats? bestStats;
    int bestScore = -1;
    Object? lastError;

    for (final payload in payloadCandidates) {
      try {
        final response = await _dio.post(
          '$_apiPrefix/GetUserStasticData',
          data: payload,
        );
        print(
          '[TraeDashboardApi] 请求统计 payload=$payload, status=${response.statusCode}',
        );

        if (response.statusCode != 200) {
          continue;
        }

        final contentType = response.headers.value('content-type') ?? '';
        if (contentType.contains('text/html')) {
          print('[TraeDashboardApi] 响应为 HTML，疑似命中网页路由而非 API');
          continue;
        }

        final data = response.data;
        if (data is! Map<String, dynamic>) {
          continue;
        }

        final result = data['Result'];
        if (result is! Map<String, dynamic>) {
          continue;
        }

        final parsed = _parseStatsFromDynamicResult(result);
        final score = _scoreStats(parsed);
        print('[TraeDashboardApi] 候选统计 score=$score, userId=${parsed.userId}');

        if (score > bestScore) {
          bestScore = score;
          bestStats = parsed;
        }
      } catch (e) {
        lastError = e;
        print('[TraeDashboardApi] 候选统计请求失败 payload=$payload, error=$e');
      }
    }

    if (bestStats != null) {
      return bestStats;
    }

    throw TraeApiException(
      message: '获取统计数据失败: ${lastError ?? '无可用结果'}',
      code: 'INVALID_RESPONSE',
    );
  }

  TraeUserStats _parseStatsFromDynamicResult(Map<String, dynamic> result) {
    final userId = _asString(_pick(result, const ['UserID', 'UserId', 'uid']));
    final registerDays = _asInt(
      _pick(result, const ['RegisterDays', 'RegisterDay', 'registerDays']),
    );
    final dataDate = _asString(
      _pick(result, const ['DataDate', 'Date', 'dataDate']),
    );

    final dailyActivity = _asIntMap(
      _pick(result, const ['AiCnt365d', 'AiCnt365D', 'DailyActivity']),
    );
    final languageStats = _asIntMap(
      _pick(result, const [
        'CodeAiAcceptDiffLanguageCnt7d',
        'CodeAiAcceptDiffLanguageCnt7D',
        'LanguageStats',
      ]),
    );
    final agentStats = _asIntMap(
      _pick(result, const [
        'CodeCompDiffAgentCnt7d',
        'CodeCompDiffAgentCnt7D',
        'AgentStats',
      ]),
    );
    final modelStats = _asIntMap(
      _pick(result, const [
        'CodeCompDiffModelCnt7d',
        'CodeCompDiffModelCnt7D',
        'ModelStats',
      ]),
    );
    final hourlyActivity = _asIntMap(
      _pick(result, const [
        'IdeActiveDiffHourCnt7d',
        'IdeActiveDiffHourCnt7D',
        'HourlyActivity',
      ]),
    );

    return TraeUserStats(
      userId: userId,
      registerDays: registerDays,
      dailyActivity: dailyActivity,
      codeAcceptCount7d: _asInt(
        _pick(result, const ['CodeAiAcceptCnt7d', 'CodeAiAcceptCnt7D']),
      ),
      languageStats: languageStats,
      conversationCount7d: _asInt(
        _pick(result, const ['CodeCompCnt7d', 'CodeCompCnt7D']),
      ),
      agentStats: agentStats,
      modelStats: modelStats,
      hourlyActivity: hourlyActivity,
      dataDate: dataDate,
      isIde: _asBool(
        _pick(result, const ['IsIde', 'IsIDE']),
        defaultValue: true,
      ),
    );
  }

  int _scoreStats(TraeUserStats stats) {
    final mapTotals =
        stats.dailyActivity.values.fold<int>(0, (sum, v) => sum + v) +
        stats.languageStats.values.fold<int>(0, (sum, v) => sum + v) +
        stats.agentStats.values.fold<int>(0, (sum, v) => sum + v) +
        stats.modelStats.values.fold<int>(0, (sum, v) => sum + v) +
        stats.hourlyActivity.values.fold<int>(0, (sum, v) => sum + v);

    return stats.registerDays +
        stats.codeAcceptCount7d +
        stats.conversationCount7d +
        mapTotals +
        (stats.userId.isNotEmpty ? 10 : 0);
  }

  Object? _pick(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      if (map.containsKey(key)) {
        return map[key];
      }
    }
    return null;
  }

  String _asString(Object? value, {String defaultValue = ''}) {
    if (value == null) return defaultValue;
    final text = value.toString().trim();
    return text;
  }

  int _asInt(Object? value, {int defaultValue = 0}) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is num) return value.toInt();
    final parsed = int.tryParse(value.toString().trim());
    if (parsed != null) return parsed;
    final parsedNum = double.tryParse(value.toString().trim());
    return parsedNum?.toInt() ?? defaultValue;
  }

  bool _asBool(Object? value, {required bool defaultValue}) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    final text = value.toString().trim().toLowerCase();
    if (text == 'true' || text == '1') return true;
    if (text == 'false' || text == '0') return false;
    return defaultValue;
  }

  Map<String, int> _asIntMap(Object? raw) {
    if (raw is! Map) return const <String, int>{};
    final out = <String, int>{};
    raw.forEach((key, value) {
      final k = key.toString();
      if (k.isEmpty) return;
      out[k] = _asInt(value);
    });
    return out;
  }

  /// 获取用户信息
  ///
  /// 返回用户的基本信息（昵称、头像等）
  Future<TraeUserInfo> getUserInfo() async {
    try {
      // 先尝试从系统 CookieManager 补齐完整 Cookie（含 HttpOnly）
      await TraeCookieManager.syncCookiesFromNativeBridge();

      // 检查是否有有效 Cookie
      final hasCookies = await TraeCookieManager.hasValidCookies();
      if (!hasCookies) {
        throw TraeApiException(message: '未登录或 Cookie 已过期', code: 'NO_COOKIES');
      }

      final response = await _dio.post('$_apiPrefix/GetUserInfo', data: {});

      if (response.statusCode != 200) {
        throw TraeApiException(
          message: '请求失败: ${response.statusCode}',
          code: 'HTTP_ERROR',
        );
      }

      final contentType = response.headers.value('content-type') ?? '';
      if (contentType.contains('text/html')) {
        throw TraeApiException(
          message: '接口返回网页内容，未命中仪表盘数据接口',
          code: 'INVALID_ENDPOINT',
        );
      }

      final data = response.data as Map<String, dynamic>;

      if (data['Result'] == null) {
        throw TraeApiException(message: '响应数据格式错误', code: 'INVALID_RESPONSE');
      }

      final result = data['Result'] as Map<String, dynamic>;
      return TraeUserInfo.fromJson(result);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw TraeApiException(message: '登录已过期，请重新登录', code: 'UNAUTHORIZED');
      }
      throw TraeApiException(
        message: '网络请求失败: ${e.message}',
        code: 'NETWORK_ERROR',
      );
    } catch (e) {
      throw TraeApiException(message: '获取用户信息失败: $e', code: 'UNKNOWN_ERROR');
    }
  }

  /// 检查登录状态
  ///
  /// 返回是否已登录且 Cookie 有效
  Future<bool> checkLoginStatus() async {
    try {
      await getUserInfo();
      return true;
    } on TraeApiException catch (e) {
      if (e.code == 'UNAUTHORIZED' || e.code == 'NO_COOKIES') {
        return false;
      }
      rethrow;
    }
  }
}

/// Cookie 拦截器
///
/// 自动从 CookieManager 获取 Cookie 并添加到请求头
class _CookieInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      await TraeCookieManager.syncCookiesFromNativeBridge();
      final cookieString = await TraeCookieManager.getCookieString();
      if (cookieString.isNotEmpty) {
        options.headers['Cookie'] = cookieString;
        print('🔑 [CookieInterceptor] 已添加 Cookie');
      } else {
        print('⚠️ [CookieInterceptor] Cookie 为空');
      }
    } catch (e) {
      print('❌ [CookieInterceptor] 获取 Cookie 失败: $e');
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 可以在这里处理响应中的 Set-Cookie
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 处理错误，如 401 未授权
    if (err.response?.statusCode == 401) {
      print('🚫 [CookieInterceptor] 收到 401 未授权响应');
    }
    handler.next(err);
  }
}

/// Trae API 异常
class TraeApiException implements Exception {
  /// 错误信息
  final String message;

  /// 错误代码
  final String code;

  TraeApiException({required this.message, required this.code});

  @override
  String toString() => 'TraeApiException($code): $message';
}
