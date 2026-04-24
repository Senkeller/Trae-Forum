// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentTabIndexHash() => r'10db3fe6212295f35a3edb02f34d94232c53c136';

/// 当前 Tab 索引 Provider
///
/// Copied from [currentTabIndex].
@ProviderFor(currentTabIndex)
final currentTabIndexProvider = AutoDisposeProvider<int>.internal(
  currentTabIndex,
  name: r'currentTabIndexProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentTabIndexHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentTabIndexRef = AutoDisposeProviderRef<int>;
String _$feedListHash() => r'2129817084c59aee6fa19faa061ca838ec9adc1c';

/// Feed 列表 Provider
///
/// Copied from [feedList].
@ProviderFor(feedList)
final feedListProvider = AutoDisposeProvider<List<FeedItem>>.internal(
  feedList,
  name: r'feedListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$feedListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeedListRef = AutoDisposeProviderRef<List<FeedItem>>;
String _$isFeedRefreshingHash() => r'34f50297c75926ab7c3a834638b979653f087d51';

/// 是否正在刷新 Provider
///
/// Copied from [isFeedRefreshing].
@ProviderFor(isFeedRefreshing)
final isFeedRefreshingProvider = AutoDisposeProvider<bool>.internal(
  isFeedRefreshing,
  name: r'isFeedRefreshingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isFeedRefreshingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsFeedRefreshingRef = AutoDisposeProviderRef<bool>;
String _$isFeedLoadingMoreHash() => r'3994443e3a0036eac71c58a3915ae7666b69255a';

/// 是否正在加载更多 Provider
///
/// Copied from [isFeedLoadingMore].
@ProviderFor(isFeedLoadingMore)
final isFeedLoadingMoreProvider = AutoDisposeProvider<bool>.internal(
  isFeedLoadingMore,
  name: r'isFeedLoadingMoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isFeedLoadingMoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsFeedLoadingMoreRef = AutoDisposeProviderRef<bool>;
String _$hasMoreFeedsHash() => r'3190c239bbe8895411720dd46509ad0e91afacd2';

/// 是否有更多数据 Provider
///
/// Copied from [hasMoreFeeds].
@ProviderFor(hasMoreFeeds)
final hasMoreFeedsProvider = AutoDisposeProvider<bool>.internal(
  hasMoreFeeds,
  name: r'hasMoreFeedsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasMoreFeedsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasMoreFeedsRef = AutoDisposeProviderRef<bool>;
String _$homeErrorMessageHash() => r'914f0ed46cbd5b53472c798240efa5d24ae1301f';

/// 首页错误信息 Provider
///
/// Copied from [homeErrorMessage].
@ProviderFor(homeErrorMessage)
final homeErrorMessageProvider = AutoDisposeProvider<String?>.internal(
  homeErrorMessage,
  name: r'homeErrorMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeErrorMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeErrorMessageRef = AutoDisposeProviderRef<String?>;
String _$homeNotifierHash() => r'ea06e71ade663f81c02fa76868d556e56e66b718';

/// 首页状态 Notifier
///
/// Copied from [HomeNotifier].
@ProviderFor(HomeNotifier)
final homeNotifierProvider =
    AutoDisposeNotifierProvider<HomeNotifier, HomeState>.internal(
      HomeNotifier.new,
      name: r'homeNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$homeNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HomeNotifier = AutoDisposeNotifier<HomeState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
