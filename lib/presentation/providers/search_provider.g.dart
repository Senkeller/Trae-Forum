// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchKeywordHash() => r'b786be3c721e0ef892d08f3a6c18b64322ffe9be';

/// 搜索关键词 Provider
///
/// Copied from [searchKeyword].
@ProviderFor(searchKeyword)
final searchKeywordProvider = AutoDisposeProvider<String>.internal(
  searchKeyword,
  name: r'searchKeywordProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchKeywordHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchKeywordRef = AutoDisposeProviderRef<String>;
String _$searchResultsHash() => r'fe06191e75ebf6f9e739c7e476febeab2450f982';

/// 搜索结果 Provider
///
/// Copied from [searchResults].
@ProviderFor(searchResults)
final searchResultsProvider = AutoDisposeProvider<List<SearchResult>>.internal(
  searchResults,
  name: r'searchResultsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchResultsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchResultsRef = AutoDisposeProviderRef<List<SearchResult>>;
String _$searchHistoryHash() => r'dee0bee1eb5ef3b1a677531d17b2f46aac4c8a65';

/// 搜索历史 Provider
///
/// Copied from [searchHistory].
@ProviderFor(searchHistory)
final searchHistoryProvider = AutoDisposeProvider<List<String>>.internal(
  searchHistory,
  name: r'searchHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchHistoryRef = AutoDisposeProviderRef<List<String>>;
String _$isSearchingHash() => r'ab222e3431706a931f2ffd38377865336cb0a814';

/// 是否正在搜索 Provider
///
/// Copied from [isSearching].
@ProviderFor(isSearching)
final isSearchingProvider = AutoDisposeProvider<bool>.internal(
  isSearching,
  name: r'isSearchingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isSearchingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsSearchingRef = AutoDisposeProviderRef<bool>;
String _$currentSearchTypeHash() => r'4dbd646a4ab97639634bf17e3442f85ce1376f2a';

/// 搜索类型 Provider
///
/// Copied from [currentSearchType].
@ProviderFor(currentSearchType)
final currentSearchTypeProvider = AutoDisposeProvider<SearchType>.internal(
  currentSearchType,
  name: r'currentSearchTypeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSearchTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSearchTypeRef = AutoDisposeProviderRef<SearchType>;
String _$searchNotifierHash() => r'c31319611295d9b5ab585f0782e9e8f4a312a117';

/// 搜索状态 Notifier
///
/// Copied from [SearchNotifier].
@ProviderFor(SearchNotifier)
final searchNotifierProvider =
    AutoDisposeNotifierProvider<SearchNotifier, SearchState>.internal(
      SearchNotifier.new,
      name: r'searchNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$searchNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchNotifier = AutoDisposeNotifier<SearchState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
