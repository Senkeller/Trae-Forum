// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_news_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$aiNewsListHash() => r'b5a42e44f528e90a6e38f9865b6b960f0731a69a';

/// AI快讯列表Provider
///
/// Copied from [aiNewsList].
@ProviderFor(aiNewsList)
final aiNewsListProvider = AutoDisposeProvider<List<AINews>>.internal(
  aiNewsList,
  name: r'aiNewsListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiNewsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiNewsListRef = AutoDisposeProviderRef<List<AINews>>;
String _$isAINewsRefreshingHash() =>
    r'71e7140c9749ca5cef695102c6180a42975cb91b';

/// 是否正在刷新Provider
///
/// Copied from [isAINewsRefreshing].
@ProviderFor(isAINewsRefreshing)
final isAINewsRefreshingProvider = AutoDisposeProvider<bool>.internal(
  isAINewsRefreshing,
  name: r'isAINewsRefreshingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAINewsRefreshingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAINewsRefreshingRef = AutoDisposeProviderRef<bool>;
String _$isAINewsLoadingMoreHash() =>
    r'1dc843f16d2c51205d3ac8492fe422b6d3cf7bbc';

/// 是否正在加载更多Provider
///
/// Copied from [isAINewsLoadingMore].
@ProviderFor(isAINewsLoadingMore)
final isAINewsLoadingMoreProvider = AutoDisposeProvider<bool>.internal(
  isAINewsLoadingMore,
  name: r'isAINewsLoadingMoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAINewsLoadingMoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAINewsLoadingMoreRef = AutoDisposeProviderRef<bool>;
String _$hasMoreAINewsHash() => r'37e106b6d8694b6f6d73d7f63ba6112510d88012';

/// 是否有更多数据Provider
///
/// Copied from [hasMoreAINews].
@ProviderFor(hasMoreAINews)
final hasMoreAINewsProvider = AutoDisposeProvider<bool>.internal(
  hasMoreAINews,
  name: r'hasMoreAINewsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasMoreAINewsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasMoreAINewsRef = AutoDisposeProviderRef<bool>;
String _$aiNewsErrorMessageHash() =>
    r'cb5147b23c0008ffc98908e7163f635a39b20232';

/// AI快讯错误信息Provider
///
/// Copied from [aiNewsErrorMessage].
@ProviderFor(aiNewsErrorMessage)
final aiNewsErrorMessageProvider = AutoDisposeProvider<String?>.internal(
  aiNewsErrorMessage,
  name: r'aiNewsErrorMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$aiNewsErrorMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AiNewsErrorMessageRef = AutoDisposeProviderRef<String?>;
String _$aINewsNotifierHash() => r'392f169d03acfce1b0781cb8cb77817a3d8d5a9f';

/// AI快讯Notifier
///
/// Copied from [AINewsNotifier].
@ProviderFor(AINewsNotifier)
final aINewsNotifierProvider =
    AutoDisposeNotifierProvider<AINewsNotifier, AINewsState>.internal(
      AINewsNotifier.new,
      name: r'aINewsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$aINewsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AINewsNotifier = AutoDisposeNotifier<AINewsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
