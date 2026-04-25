import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

part 'user_activity.freezed.dart';
part 'user_activity.g.dart';

/// 本地收藏数据模型
@HiveType(typeId: 1)
@freezed
class LocalFavorite with _$LocalFavorite {
  const factory LocalFavorite({
    @HiveField(0) required String id,
    @HiveField(1) required String feedId,
    @HiveField(2) required String uid,
    @HiveField(3) required String username,
    @HiveField(4) required String avatarUrl,
    @HiveField(5) required String deviceTitle,
    @HiveField(6) required String message,
    @HiveField(7) required String dateline,
    @HiveField(8) required DateTime createdAt,
  }) = _LocalFavorite;

  factory LocalFavorite.fromJson(Map<String, dynamic> json) =>
      _$LocalFavoriteFromJson(json);
}

/// 浏览历史数据模型
@HiveType(typeId: 2)
@freezed
class BrowseHistory with _$BrowseHistory {
  const factory BrowseHistory({
    @HiveField(0) required String id,
    @HiveField(1) required String feedId,
    @HiveField(2) required String uid,
    @HiveField(3) required String username,
    @HiveField(4) required String avatarUrl,
    @HiveField(5) required String deviceTitle,
    @HiveField(6) required String message,
    @HiveField(7) required String dateline,
    @HiveField(8) required DateTime viewedAt,
  }) = _BrowseHistory;

  factory BrowseHistory.fromJson(Map<String, dynamic> json) =>
      _$BrowseHistoryFromJson(json);
}

/// 我常去数据模型
@HiveType(typeId: 3)
@freezed
class FrequentlyVisited with _$FrequentlyVisited {
  const factory FrequentlyVisited({
    @HiveField(0) required String id,
    @HiveField(1) required String topicId,
    @HiveField(2) required String topicName,
    @HiveField(3) String? topicTag,
    @HiveField(4) required int visitCount,
    @HiveField(5) required DateTime lastVisitedAt,
    @HiveField(6) String? coverUrl,
  }) = _FrequentlyVisited;

  factory FrequentlyVisited.fromJson(Map<String, dynamic> json) =>
      _$FrequentlyVisitedFromJson(json);
}

/// 用户活动类型枚举
enum UserActivityType {
  localFavorite,
  browseHistory,
  frequentlyVisited,
  myFavorites,
  myLikes,
  myReplies,
}

/// 用户活动项统一接口
abstract class UserActivityItem {
  String get id;
  DateTime get timestamp;
}
