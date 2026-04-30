// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_stats_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayNewPostsCountHash() =>
    r'62e732af2a227c5bb50edf1df4db4d3c6301c152';

/// 今日新帖数量Provider（简化版，直接获取数字）
///
/// Copied from [TodayNewPostsCount].
@ProviderFor(TodayNewPostsCount)
final todayNewPostsCountProvider =
    AutoDisposeAsyncNotifierProvider<TodayNewPostsCount, int>.internal(
      TodayNewPostsCount.new,
      name: r'todayNewPostsCountProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$todayNewPostsCountHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$TodayNewPostsCount = AutoDisposeAsyncNotifier<int>;
String _$cachedForumStatsHash() => r'5dc0fcebea33d5aadd2c23d520a12e19132e8644';

/// 带缓存的论坛统计数据Provider
/// 缓存时间为5分钟
///
/// Copied from [CachedForumStats].
@ProviderFor(CachedForumStats)
final cachedForumStatsProvider =
    AutoDisposeAsyncNotifierProvider<CachedForumStats, ForumStats>.internal(
      CachedForumStats.new,
      name: r'cachedForumStatsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cachedForumStatsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CachedForumStats = AutoDisposeAsyncNotifier<ForumStats>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
