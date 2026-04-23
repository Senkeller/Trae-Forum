import 'package:logger/logger.dart';

/// 日志级别枚举
enum LogLevel {
  /// 详细日志（最详细）
  verbose,

  /// 调试日志
  debug,

  /// 信息日志
  info,

  /// 警告日志
  warning,

  /// 错误日志
  error,

  /// 严重错误日志
  wtf,

  /// 不记录日志
  nothing,
}

/// 日志工具类
/// 封装 Logger 包，提供不同级别的日志输出功能
class LogUtil {
  LogUtil._();

  static Logger? _logger;
  static LogLevel _minLevel = LogLevel.debug;
  static bool _isDebugMode = true;

  /// 初始化日志工具
  /// [isDebugMode] 是否为调试模式，默认为 true
  /// [minLevel] 最小日志级别，默认为 debug
  static void init({
    bool isDebugMode = true,
    LogLevel minLevel = LogLevel.debug,
  }) {
    _isDebugMode = isDebugMode;
    _minLevel = minLevel;

    if (!_isDebugMode) {
      _logger = null;
      return;
    }

    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
      level: _mapLogLevel(minLevel),
    );
  }

  /// 将自定义 LogLevel 映射为 Logger 的 Level
  /// [level] 自定义日志级别
  /// 返回 Logger 的 Level
  static Level _mapLogLevel(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
        return Level.trace;
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.info:
        return Level.info;
      case LogLevel.warning:
        return Level.warning;
      case LogLevel.error:
        return Level.error;
      case LogLevel.wtf:
        return Level.fatal;
      case LogLevel.nothing:
        return Level.off;
    }
  }

  /// 检查日志级别是否应该被记录
  /// [level] 要检查的日志级别
  /// 返回是否应该记录
  static bool _shouldLog(LogLevel level) {
    if (!_isDebugMode) return false;

    final levelOrder = [
      LogLevel.verbose,
      LogLevel.debug,
      LogLevel.info,
      LogLevel.warning,
      LogLevel.error,
      LogLevel.wtf,
    ];

    final minIndex = levelOrder.indexOf(_minLevel);
    final currentIndex = levelOrder.indexOf(level);

    return currentIndex >= minIndex;
  }

  /// 获取 Logger 实例
  /// 返回 Logger 实例
  static Logger get _log {
    _logger ??= Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
    );
    return _logger!;
  }

  // ==================== 详细日志 ====================

  /// 输出详细日志
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  static void v(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.verbose)) return;
    _log.t(message, error: error, stackTrace: stackTrace);
  }

  /// 输出详细日志（带标签）
  /// [tag] 日志标签
  /// [message] 日志消息
  static void vTag(String tag, dynamic message) {
    if (!_shouldLog(LogLevel.verbose)) return;
    _log.t('[$tag] $message');
  }

  // ==================== 调试日志 ====================

  /// 输出调试日志
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  static void d(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.debug)) return;
    _log.d(message, error: error, stackTrace: stackTrace);
  }

  /// 输出调试日志（带标签）
  /// [tag] 日志标签
  /// [message] 日志消息
  static void dTag(String tag, dynamic message) {
    if (!_shouldLog(LogLevel.debug)) return;
    _log.d('[$tag] $message');
  }

  // ==================== 信息日志 ====================

  /// 输出信息日志
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  static void i(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.info)) return;
    _log.i(message, error: error, stackTrace: stackTrace);
  }

  /// 输出信息日志（带标签）
  /// [tag] 日志标签
  /// [message] 日志消息
  static void iTag(String tag, dynamic message) {
    if (!_shouldLog(LogLevel.info)) return;
    _log.i('[$tag] $message');
  }

  // ==================== 警告日志 ====================

  /// 输出警告日志
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  static void w(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.warning)) return;
    _log.w(message, error: error, stackTrace: stackTrace);
  }

  /// 输出警告日志（带标签）
  /// [tag] 日志标签
  /// [message] 日志消息
  static void wTag(String tag, dynamic message) {
    if (!_shouldLog(LogLevel.warning)) return;
    _log.w('[$tag] $message');
  }

  // ==================== 错误日志 ====================

  /// 输出错误日志
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  static void e(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.error)) return;
    _log.e(message, error: error, stackTrace: stackTrace);
  }

  /// 输出错误日志（带标签）
  /// [tag] 日志标签
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  static void eTag(
    String tag,
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.error)) return;
    _log.e('[$tag] $message', error: error, stackTrace: stackTrace);
  }

  // ==================== 严重错误日志 ====================

  /// 输出严重错误日志
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  static void wtf(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!_shouldLog(LogLevel.wtf)) return;
    _log.f(message, error: error, stackTrace: stackTrace);
  }

  /// 输出严重错误日志（带标签）
  /// [tag] 日志标签
  /// [message] 日志消息
  static void wtfTag(String tag, dynamic message) {
    if (!_shouldLog(LogLevel.wtf)) return;
    _log.f('[$tag] $message');
  }

  // ==================== 快捷方法 ====================

  /// 输出网络请求日志
  /// [method] 请求方法
  /// [url] 请求 URL
  /// [params] 请求参数，可选
  static void http(String method, String url, {Map<String, dynamic>? params}) {
    if (!_shouldLog(LogLevel.debug)) return;
    final paramStr = params != null ? ' | Params: $params' : '';
    _log.d('🌐 HTTP $method $url$paramStr');
  }

  /// 输出网络响应日志
  /// [url] 请求 URL
  /// [statusCode] 状态码
  /// [response] 响应数据，可选
  static void httpResponse(
    String url,
    int statusCode, {
    dynamic response,
  }) {
    if (!_shouldLog(LogLevel.debug)) return;
    final emoji = statusCode >= 200 && statusCode < 300 ? '✅' : '❌';
    final responseStr = response != null ? ' | Response: $response' : '';
    _log.d('$emoji HTTP Response [$statusCode] $url$responseStr');
  }

  /// 输出路由导航日志
  /// [from] 来源路由
  /// [to] 目标路由
  /// [arguments] 路由参数，可选
  static void route(
    String from,
    String to, {
    dynamic arguments,
  }) {
    if (!_shouldLog(LogLevel.debug)) return;
    final argStr = arguments != null ? ' | Args: $arguments' : '';
    _log.d('🧭 Route: $from → $to$argStr');
  }

  /// 输出生命周期日志
  /// [widget] Widget 名称
  /// [state] 生命周期状态
  static void lifecycle(String widget, String state) {
    if (!_shouldLog(LogLevel.verbose)) return;
    _log.t('🔄 Lifecycle: $widget - $state');
  }

  /// 输出性能日志
  /// [operation] 操作名称
  /// [duration] 耗时
  static void performance(String operation, Duration duration) {
    if (!_shouldLog(LogLevel.debug)) return;
    _log.d('⏱️ Performance: $operation took ${duration.inMilliseconds}ms');
  }

  /// 输出用户行为日志
  /// [action] 用户行为
  /// [details] 详细信息，可选
  static void userAction(String action, {dynamic details}) {
    if (!_shouldLog(LogLevel.info)) return;
    final detailStr = details != null ? ' | Details: $details' : '';
    _log.i('👤 User Action: $action$detailStr');
  }

  /// 输出数据库操作日志
  /// [operation] 数据库操作
  /// [table] 表名
  /// [data] 数据，可选
  static void database(
    String operation,
    String table, {
    dynamic data,
  }) {
    if (!_shouldLog(LogLevel.debug)) return;
    final dataStr = data != null ? ' | Data: $data' : '';
    _log.d('💾 Database: $operation $table$dataStr');
  }

  /// 输出缓存操作日志
  /// [operation] 缓存操作
  /// [key] 缓存键
  /// [value] 缓存值，可选
  static void cache(
    String operation,
    String key, {
    dynamic value,
  }) {
    if (!_shouldLog(LogLevel.debug)) return;
    final valueStr = value != null ? ' | Value: $value' : '';
    _log.d('📦 Cache: $operation $key$valueStr');
  }

  // ==================== 配置方法 ====================

  /// 设置最小日志级别
  /// [level] 最小日志级别
  static void setMinLevel(LogLevel level) {
    _minLevel = level;
    init(isDebugMode: _isDebugMode, minLevel: level);
  }

  /// 设置调试模式
  /// [isDebug] 是否为调试模式
  static void setDebugMode(bool isDebug) {
    _isDebugMode = isDebug;
    init(isDebugMode: isDebug, minLevel: _minLevel);
  }

  /// 关闭日志
  static void close() {
    _isDebugMode = false;
    _logger = null;
  }

  /// 获取当前日志配置
  /// 返回当前日志配置信息
  static Map<String, dynamic> get config => {
        'isDebugMode': _isDebugMode,
        'minLevel': _minLevel.toString(),
      };
}

/// 日志扩展
extension LogExtension on Object {
  /// 输出详细日志
  /// [message] 日志消息
  void logV(dynamic message) {
    LogUtil.vTag(runtimeType.toString(), message);
  }

  /// 输出调试日志
  /// [message] 日志消息
  void logD(dynamic message) {
    LogUtil.dTag(runtimeType.toString(), message);
  }

  /// 输出信息日志
  /// [message] 日志消息
  void logI(dynamic message) {
    LogUtil.iTag(runtimeType.toString(), message);
  }

  /// 输出警告日志
  /// [message] 日志消息
  void logW(dynamic message) {
    LogUtil.wTag(runtimeType.toString(), message);
  }

  /// 输出错误日志
  /// [message] 日志消息
  /// [error] 错误对象，可选
  /// [stackTrace] 堆栈跟踪，可选
  void logE(
    dynamic message, {
    dynamic error,
    StackTrace? stackTrace,
  }) {
    LogUtil.eTag(
      runtimeType.toString(),
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
