import 'package:collection/collection.dart';
import 'package:hive_ce/hive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user_activity.dart';

part 'user_activity_repository.g.dart';

/// 用户活动仓库Provider
@riverpod
UserActivityRepository userActivityRepository(Ref ref) {
  return UserActivityRepository();
}

/// 用户活动统一仓库
/// 
/// 管理本地收藏、浏览历史、我常去等本地数据
class UserActivityRepository {
  static const String _localFavoriteBoxName = 'local_favorites';
  static const String _browseHistoryBoxName = 'browse_history';
  static const String _frequentlyVisitedBoxName = 'frequently_visited';

  Box<LocalFavorite>? _localFavoriteBox;
  Box<BrowseHistory>? _browseHistoryBox;
  Box<FrequentlyVisited>? _frequentlyVisitedBox;

  // ==================== 本地收藏 ====================

  /// 获取本地收藏Box
  Future<Box<LocalFavorite>> get _localFavoriteBoxAsync async {
    _localFavoriteBox ??= await Hive.openBox<LocalFavorite>(_localFavoriteBoxName);
    return _localFavoriteBox!;
  }

  /// 获取所有本地收藏（按时间倒序）
  Future<List<LocalFavorite>> getAllLocalFavorites() async {
    final box = await _localFavoriteBoxAsync;
    final list = box.values.toList();
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  /// 检查是否已收藏
  Future<bool> isFavorite(String feedId) async {
    final box = await _localFavoriteBoxAsync;
    return box.values.any((item) => item.feedId == feedId);
  }

  /// 添加本地收藏
  Future<void> addLocalFavorite({
    required String feedId,
    required String uid,
    required String username,
    required String avatarUrl,
    required String deviceTitle,
    required String message,
    required String dateline,
  }) async {
    final box = await _localFavoriteBoxAsync;
    
    // 去重检查
    if (await isFavorite(feedId)) return;

    final favorite = LocalFavorite(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      feedId: feedId,
      uid: uid,
      username: username,
      avatarUrl: avatarUrl,
      deviceTitle: deviceTitle,
      message: message,
      dateline: dateline,
      createdAt: DateTime.now(),
    );

    await box.add(favorite);
  }

  /// 删除本地收藏
  Future<void> removeLocalFavorite(String feedId) async {
    final box = await _localFavoriteBoxAsync;
    final key = box.keys.firstWhere(
      (k) => box.get(k)?.feedId == feedId,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }

  /// 清空所有本地收藏
  Future<void> clearAllLocalFavorites() async {
    final box = await _localFavoriteBoxAsync;
    await box.clear();
  }

  // ==================== 浏览历史 ====================

  /// 获取浏览历史Box
  Future<Box<BrowseHistory>> get _browseHistoryBoxAsync async {
    _browseHistoryBox ??= await Hive.openBox<BrowseHistory>(_browseHistoryBoxName);
    return _browseHistoryBox!;
  }

  /// 获取所有浏览历史（按时间倒序）
  Future<List<BrowseHistory>> getAllBrowseHistory() async {
    final box = await _browseHistoryBoxAsync;
    final list = box.values.toList();
    list.sort((a, b) => b.viewedAt.compareTo(a.viewedAt));
    return list;
  }

  /// 检查浏览历史是否存在
  Future<bool> isHistoryExist(String feedId) async {
    final box = await _browseHistoryBoxAsync;
    return box.values.any((item) => item.feedId == feedId);
  }

  /// 添加浏览历史（带去重）
  Future<void> addBrowseHistory({
    required String feedId,
    required String uid,
    required String username,
    required String avatarUrl,
    required String deviceTitle,
    required String message,
    required String dateline,
  }) async {
    final box = await _browseHistoryBoxAsync;

    // 去重检查：如果已存在，先删除旧的
    final existingKey = box.keys.firstWhere(
      (k) => box.get(k)?.feedId == feedId,
      orElse: () => null,
    );
    if (existingKey != null) {
      await box.delete(existingKey);
    }

    final history = BrowseHistory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      feedId: feedId,
      uid: uid,
      username: username,
      avatarUrl: avatarUrl,
      deviceTitle: deviceTitle,
      message: message,
      dateline: dateline,
      viewedAt: DateTime.now(),
    );

    await box.add(history);
  }

  /// 删除单条浏览历史
  Future<void> removeBrowseHistory(String feedId) async {
    final box = await _browseHistoryBoxAsync;
    final key = box.keys.firstWhere(
      (k) => box.get(k)?.feedId == feedId,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }

  /// 清空所有浏览历史
  Future<void> clearAllBrowseHistory() async {
    final box = await _browseHistoryBoxAsync;
    await box.clear();
  }

  // ==================== 我常去 ====================

  /// 获取我常去Box
  Future<Box<FrequentlyVisited>> get _frequentlyVisitedBoxAsync async {
    _frequentlyVisitedBox ??= await Hive.openBox<FrequentlyVisited>(_frequentlyVisitedBoxName);
    return _frequentlyVisitedBox!;
  }

  /// 获取所有我常去（按访问次数和时间综合排序）
  Future<List<FrequentlyVisited>> getAllFrequentlyVisited() async {
    final box = await _frequentlyVisitedBoxAsync;
    final list = box.values.toList();
    
    // 排序算法：访问次数 * 时间权重
    final now = DateTime.now();
    list.sort((a, b) {
      final aDaysSince = now.difference(a.lastVisitedAt).inDays;
      final bDaysSince = now.difference(b.lastVisitedAt).inDays;
      
      // 时间权重：越近访问权重越高
      final aTimeWeight = 1.0 / (aDaysSince + 1);
      final bTimeWeight = 1.0 / (bDaysSince + 1);
      
      // 综合得分 = 访问次数 * 时间权重
      final aScore = a.visitCount * aTimeWeight;
      final bScore = b.visitCount * bTimeWeight;
      
      return bScore.compareTo(aScore);
    });
    
    return list;
  }

  /// 记录访问
  ///
  /// [topicId] 话题ID
  /// [topicName] 话题名称
  /// [topicTag] 话题标签（可选）
  /// [coverUrl] 封面URL（可选）
  Future<void> recordVisit({
    required String topicId,
    required String topicName,
    String? topicTag,
    String? coverUrl,
  }) async {
    final box = await _frequentlyVisitedBoxAsync;

    // 查找是否已存在 - 使用 firstWhereOrNull 安全查找
    final existingEntry = box.values.firstWhereOrNull(
      (item) => item.topicId == topicId,
    );

    if (existingEntry != null) {
      // 更新访问次数和时间
      final key = box.keys.firstWhereOrNull(
        (k) => box.get(k)?.topicId == topicId,
      );

      if (key != null) {
        final updated = existingEntry.copyWith(
          visitCount: existingEntry.visitCount + 1,
          lastVisitedAt: DateTime.now(),
        );

        await box.put(key, updated);
      }
    } else {
      // 创建新记录
      final visit = FrequentlyVisited(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        topicId: topicId,
        topicName: topicName,
        topicTag: topicTag,
        visitCount: 1,
        lastVisitedAt: DateTime.now(),
        coverUrl: coverUrl,
      );

      await box.add(visit);
    }
  }

  /// 删除我常去记录
  Future<void> removeFrequentlyVisited(String topicId) async {
    final box = await _frequentlyVisitedBoxAsync;
    final key = box.keys.firstWhere(
      (k) => box.get(k)?.topicId == topicId,
      orElse: () => null,
    );
    if (key != null) {
      await box.delete(key);
    }
  }

  /// 清空所有我常去
  Future<void> clearAllFrequentlyVisited() async {
    final box = await _frequentlyVisitedBoxAsync;
    await box.clear();
  }

  // ==================== 通用方法 ====================

  /// 关闭所有Box
  Future<void> closeAll() async {
    await _localFavoriteBox?.close();
    await _browseHistoryBox?.close();
    await _frequentlyVisitedBox?.close();
    
    _localFavoriteBox = null;
    _browseHistoryBox = null;
    _frequentlyVisitedBox = null;
  }
}
