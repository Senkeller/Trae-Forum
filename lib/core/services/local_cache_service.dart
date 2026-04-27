import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 本地缓存服务
///
/// 用于缓存通知列表和 Feed 详情，减少重复网络请求
/// 提升应用性能和用户体验
class LocalCacheService {
  static final LocalCacheService _instance = LocalCacheService._internal();
  factory LocalCacheService() => _instance;
  LocalCacheService._internal();

  SharedPreferences? _prefs;

  /// 初始化缓存服务
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// 缓存键前缀
  static const String _notificationPrefix = 'notification_';
  static const String _feedPrefix = 'feed_';
  static const String _cacheTimePrefix = 'cache_time_';

  /// 默认缓存有效期（小时）
  static const int _defaultCacheDurationHours = 1;

  /// 缓存通知列表
  ///
  /// [filterType] 筛选类型
  /// [page] 页码
  /// [data] 通知数据列表
  Future<void> cacheNotifications(
    String filterType,
    int page,
    List<dynamic> data,
  ) async {
    await init();
    final key = '$_notificationPrefix${filterType}_$page';
    final cacheData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': data,
    };
    await _prefs!.setString(key, jsonEncode(cacheData));
  }

  /// 获取缓存的通知列表
  ///
  /// [filterType] 筛选类型
  /// [page] 页码
  /// [maxAgeHours] 缓存最大有效期（小时）
  /// 返回 null 表示缓存不存在或已过期
  List<dynamic>? getCachedNotifications(
    String filterType,
    int page, {
    int maxAgeHours = _defaultCacheDurationHours,
  }) {
    if (_prefs == null) return null;

    final key = '$_notificationPrefix${filterType}_$page';
    final cachedString = _prefs!.getString(key);

    if (cachedString == null) return null;

    try {
      final cacheData = jsonDecode(cachedString) as Map<String, dynamic>;
      final timestamp = cacheData['timestamp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;
      final ageMs = now - timestamp;
      final maxAgeMs = maxAgeHours * 60 * 60 * 1000;

      // 检查缓存是否过期
      if (ageMs > maxAgeMs) {
        // 删除过期缓存
        _prefs!.remove(key);
        return null;
      }

      return cacheData['data'] as List<dynamic>;
    } catch (e) {
      // 解析失败，删除无效缓存
      _prefs!.remove(key);
      return null;
    }
  }

  /// 缓存 Feed 详情
  ///
  /// [feedId] Feed ID
  /// [data] Feed 详情数据
  Future<void> cacheFeedDetail(String feedId, Map<String, dynamic> data) async {
    await init();
    final key = '$_feedPrefix$feedId';
    final cacheData = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': data,
    };
    await _prefs!.setString(key, jsonEncode(cacheData));
  }

  /// 获取缓存的 Feed 详情
  ///
  /// [feedId] Feed ID
  /// [maxAgeHours] 缓存最大有效期（小时）
  /// 返回 null 表示缓存不存在或已过期
  Map<String, dynamic>? getCachedFeedDetail(
    String feedId, {
    int maxAgeHours = _defaultCacheDurationHours,
  }) {
    if (_prefs == null) return null;

    final key = '$_feedPrefix$feedId';
    final cachedString = _prefs!.getString(key);

    if (cachedString == null) return null;

    try {
      final cacheData = jsonDecode(cachedString) as Map<String, dynamic>;
      final timestamp = cacheData['timestamp'] as int;
      final now = DateTime.now().millisecondsSinceEpoch;
      final ageMs = now - timestamp;
      final maxAgeMs = maxAgeHours * 60 * 60 * 1000;

      // 检查缓存是否过期
      if (ageMs > maxAgeMs) {
        // 删除过期缓存
        _prefs!.remove(key);
        return null;
      }

      return cacheData['data'] as Map<String, dynamic>;
    } catch (e) {
      // 解析失败，删除无效缓存
      _prefs!.remove(key);
      return null;
    }
  }

  /// 清除所有通知缓存
  Future<void> clearNotificationCache() async {
    await init();
    final keys = _prefs!.getKeys();
    for (final key in keys) {
      if (key.startsWith(_notificationPrefix)) {
        await _prefs!.remove(key);
      }
    }
  }

  /// 清除所有 Feed 缓存
  Future<void> clearFeedCache() async {
    await init();
    final keys = _prefs!.getKeys();
    for (final key in keys) {
      if (key.startsWith(_feedPrefix)) {
        await _prefs!.remove(key);
      }
    }
  }

  /// 清除所有缓存
  Future<void> clearAllCache() async {
    await init();
    await clearNotificationCache();
    await clearFeedCache();
  }

  /// 获取缓存大小（用于调试）
  Future<int> getCacheSize() async {
    await init();
    int size = 0;
    final keys = _prefs!.getKeys();
    for (final key in keys) {
      if (key.startsWith(_notificationPrefix) || key.startsWith(_feedPrefix)) {
        final value = _prefs!.getString(key);
        if (value != null) {
          size += value.length;
        }
      }
    }
    return size;
  }
}
