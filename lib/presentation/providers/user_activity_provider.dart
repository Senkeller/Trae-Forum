import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/user_activity.dart';
import '../../data/repositories/user_activity_repository.dart';

part 'user_activity_provider.g.dart';

// ==================== 本地收藏 Provider ====================

/// 本地收藏列表 Provider
@riverpod
class LocalFavorites extends _$LocalFavorites {
  @override
  Future<List<LocalFavorite>> build() async {
    final repo = ref.read(userActivityRepositoryProvider);
    return repo.getAllLocalFavorites();
  }

  /// 刷新列表
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(userActivityRepositoryProvider);
    state = AsyncData(await repo.getAllLocalFavorites());
  }

  /// 添加收藏
  Future<void> addFavorite({
    required String feedId,
    required String uid,
    required String username,
    required String avatarUrl,
    required String deviceTitle,
    required String message,
    required String dateline,
  }) async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.addLocalFavorite(
      feedId: feedId,
      uid: uid,
      username: username,
      avatarUrl: avatarUrl,
      deviceTitle: deviceTitle,
      message: message,
      dateline: dateline,
    );
    state = AsyncData(await repo.getAllLocalFavorites());
  }

  /// 移除收藏
  Future<void> removeFavorite(String feedId) async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.removeLocalFavorite(feedId);
    state = AsyncData(await repo.getAllLocalFavorites());
  }

  /// 清空所有收藏
  Future<void> clearAll() async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.clearAllLocalFavorites();
    state = const AsyncData([]);
  }
}

/// 检查是否已收藏 Provider
@riverpod
Future<bool> isFavorite(Ref ref, String feedId) async {
  final repo = ref.read(userActivityRepositoryProvider);
  return repo.isFavorite(feedId);
}

// ==================== 浏览历史 Provider ====================

/// 浏览历史列表 Provider
@riverpod
class BrowseHistories extends _$BrowseHistories {
  @override
  Future<List<BrowseHistory>> build() async {
    final repo = ref.read(userActivityRepositoryProvider);
    return repo.getAllBrowseHistory();
  }

  /// 刷新列表
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(userActivityRepositoryProvider);
    state = AsyncData(await repo.getAllBrowseHistory());
  }

  /// 添加浏览历史
  Future<void> addHistory({
    required String feedId,
    required String uid,
    required String username,
    required String avatarUrl,
    required String deviceTitle,
    required String message,
    required String dateline,
  }) async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.addBrowseHistory(
      feedId: feedId,
      uid: uid,
      username: username,
      avatarUrl: avatarUrl,
      deviceTitle: deviceTitle,
      message: message,
      dateline: dateline,
    );
    state = AsyncData(await repo.getAllBrowseHistory());
  }

  /// 移除单条历史
  Future<void> removeHistory(String feedId) async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.removeBrowseHistory(feedId);
    state = AsyncData(await repo.getAllBrowseHistory());
  }

  /// 清空所有历史
  Future<void> clearAll() async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.clearAllBrowseHistory();
    state = const AsyncData([]);
  }
}

// ==================== 我常去 Provider ====================

/// 我常去列表 Provider
@riverpod
class FrequentlyVisitedList extends _$FrequentlyVisitedList {
  @override
  Future<List<FrequentlyVisited>> build() async {
    final repo = ref.read(userActivityRepositoryProvider);
    return repo.getAllFrequentlyVisited();
  }

  /// 刷新列表
  Future<void> refresh() async {
    state = const AsyncLoading();
    final repo = ref.read(userActivityRepositoryProvider);
    state = AsyncData(await repo.getAllFrequentlyVisited());
  }

  /// 记录访问
  Future<void> recordVisit({
    required String topicId,
    required String topicName,
    String? topicTag,
    String? coverUrl,
  }) async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.recordVisit(
      topicId: topicId,
      topicName: topicName,
      topicTag: topicTag,
      coverUrl: coverUrl,
    );
    state = AsyncData(await repo.getAllFrequentlyVisited());
  }

  /// 移除记录
  Future<void> remove(String topicId) async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.removeFrequentlyVisited(topicId);
    state = AsyncData(await repo.getAllFrequentlyVisited());
  }

  /// 清空所有
  Future<void> clearAll() async {
    final repo = ref.read(userActivityRepositoryProvider);
    await repo.clearAllFrequentlyVisited();
    state = const AsyncData([]);
  }
}

// ==================== 便捷方法 ====================

/// 保存浏览历史的便捷方法
Future<void> saveBrowseHistory(
  Ref ref, {
  required String feedId,
  required String uid,
  required String username,
  required String avatarUrl,
  required String deviceTitle,
  required String message,
  required String dateline,
}) async {
  final repo = ref.read(userActivityRepositoryProvider);
  await repo.addBrowseHistory(
    feedId: feedId,
    uid: uid,
    username: username,
    avatarUrl: avatarUrl,
    deviceTitle: deviceTitle,
    message: message,
    dateline: dateline,
  );
  // 刷新浏览历史列表
  ref.invalidate(browseHistoriesProvider);
}

/// 切换收藏状态的便捷方法
Future<void> toggleFavorite(
  Ref ref, {
  required String feedId,
  required String uid,
  required String username,
  required String avatarUrl,
  required String deviceTitle,
  required String message,
  required String dateline,
}) async {
  final repo = ref.read(userActivityRepositoryProvider);
  final isFav = await repo.isFavorite(feedId);

  if (isFav) {
    await repo.removeLocalFavorite(feedId);
  } else {
    await repo.addLocalFavorite(
      feedId: feedId,
      uid: uid,
      username: username,
      avatarUrl: avatarUrl,
      deviceTitle: deviceTitle,
      message: message,
      dateline: dateline,
    );
  }

  // 刷新收藏列表和状态
  ref.invalidate(localFavoritesProvider);
  ref.invalidate(isFavoriteProvider(feedId));
}
