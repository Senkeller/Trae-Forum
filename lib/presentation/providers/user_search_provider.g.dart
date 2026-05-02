// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userSearchResultsHash() => r'1976cb947252a329a0f7a4ef917483431e519001';

/// 用户搜索结果 Provider
///
/// Copied from [userSearchResults].
@ProviderFor(userSearchResults)
final userSearchResultsProvider =
    AutoDisposeProvider<List<UserSearchResult>>.internal(
      userSearchResults,
      name: r'userSearchResultsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userSearchResultsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserSearchResultsRef = AutoDisposeProviderRef<List<UserSearchResult>>;
String _$isUserSearchingHash() => r'fcfc258a7d4cc688ed668aa684a70e19f8a725fa';

/// 是否正在搜索 Provider
///
/// Copied from [isUserSearching].
@ProviderFor(isUserSearching)
final isUserSearchingProvider = AutoDisposeProvider<bool>.internal(
  isUserSearching,
  name: r'isUserSearchingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUserSearchingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsUserSearchingRef = AutoDisposeProviderRef<bool>;
String _$selectedUserHash() => r'8655402f4095fe4103e4517a83dfaf4c12eebaab';

/// 选中的用户 Provider
///
/// Copied from [selectedUser].
@ProviderFor(selectedUser)
final selectedUserProvider = AutoDisposeProvider<UserSearchResult?>.internal(
  selectedUser,
  name: r'selectedUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedUserRef = AutoDisposeProviderRef<UserSearchResult?>;
String _$userSearchNotifierHash() =>
    r'749eff15bba1f42d309ef6ac379b1dbef5caad5d';

/// 用户搜索状态 Notifier
///
/// Copied from [UserSearchNotifier].
@ProviderFor(UserSearchNotifier)
final userSearchNotifierProvider =
    AutoDisposeNotifierProvider<UserSearchNotifier, UserSearchState>.internal(
      UserSearchNotifier.new,
      name: r'userSearchNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userSearchNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserSearchNotifier = AutoDisposeNotifier<UserSearchState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
