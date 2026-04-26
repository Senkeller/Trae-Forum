import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 表情包缓存服务
///
/// 用于管理最近使用的表情包记录，支持本地持久化存储
/// 功能包括：
/// - 记录表情包使用历史
/// - 获取最近使用的表情包列表
/// - 清空历史记录
/// - 限制最大缓存数量
class EmojiCacheService {
  static const String _recentEmojisKey = 'recent_emojis';
  static const String _recentStickerEmojisKey = 'recent_sticker_emojis';
  static const int _maxCacheSize = 30;

  static final EmojiCacheService _instance = EmojiCacheService._internal();
  factory EmojiCacheService() => _instance;
  EmojiCacheService._internal();

  SharedPreferences? _prefs;

  /// 初始化缓存服务
  ///
  /// 必须在应用启动时调用
  /// 返回是否初始化成功
  Future<bool> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs != null;
  }

  /// 获取最近使用的 Unicode 表情列表
  ///
  /// 返回表情字符串列表，按最近使用排序
  List<String> getRecentEmojis() {
    if (_prefs == null) return [];
    final jsonString = _prefs!.getString(_recentEmojisKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  /// 获取最近使用的图片表情（表情包）列表
  ///
  /// 返回图片 URL 列表，按最近使用排序
  List<String> getRecentStickerEmojis() {
    if (_prefs == null) return [];
    final jsonString = _prefs!.getString(_recentStickerEmojisKey);
    if (jsonString == null || jsonString.isEmpty) return [];
    try {
      final List<dynamic> decoded = jsonDecode(jsonString);
      return decoded.cast<String>();
    } catch (e) {
      return [];
    }
  }

  /// 记录表情使用
  ///
  /// [emoji] 表情字符串
  /// 将该表情添加到最近使用列表的最前面
  Future<void> recordEmojiUsage(String emoji) async {
    if (_prefs == null || emoji.isEmpty) return;
    final recentList = getRecentEmojis();
    // 移除已存在的相同表情
    recentList.remove(emoji);
    // 添加到最前面
    recentList.insert(0, emoji);
    // 限制数量
    while (recentList.length > _maxCacheSize) {
      recentList.removeLast();
    }
    await _prefs!.setString(_recentEmojisKey, jsonEncode(recentList));
  }

  /// 记录图片表情（表情包）使用
  ///
  /// [imageUrl] 图片 URL
  /// 将该图片添加到最近使用列表的最前面
  Future<void> recordStickerUsage(String imageUrl) async {
    if (_prefs == null || imageUrl.isEmpty) return;
    final recentList = getRecentStickerEmojis();
    // 移除已存在的相同图片
    recentList.remove(imageUrl);
    // 添加到最前面
    recentList.insert(0, imageUrl);
    // 限制数量
    while (recentList.length > _maxCacheSize) {
      recentList.removeLast();
    }
    await _prefs!.setString(_recentStickerEmojisKey, jsonEncode(recentList));
  }

  /// 清空所有表情缓存
  Future<void> clearAllCache() async {
    if (_prefs == null) return;
    await _prefs!.remove(_recentEmojisKey);
    await _prefs!.remove(_recentStickerEmojisKey);
  }

  /// 清空 Unicode 表情缓存
  Future<void> clearEmojiCache() async {
    if (_prefs == null) return;
    await _prefs!.remove(_recentEmojisKey);
  }

  /// 清空图片表情缓存
  Future<void> clearStickerCache() async {
    if (_prefs == null) return;
    await _prefs!.remove(_recentStickerEmojisKey);
  }
}
