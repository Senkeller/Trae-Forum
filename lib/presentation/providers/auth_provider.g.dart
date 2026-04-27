// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserHash() => r'5ba5fe5c7165288c23479e8771ede13d8393774d';

/// 当前用户信息 Provider
///
/// 提供当前登录用户的信息，未登录时返回 null
///
/// Copied from [currentUser].
@ProviderFor(currentUser)
final currentUserProvider = AutoDisposeProvider<UserInfo?>.internal(
  currentUser,
  name: r'currentUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserRef = AutoDisposeProviderRef<UserInfo?>;
String _$isAuthenticatedHash() => r'fe6f954f2d7938a820a402d3f97973c87930d8b5';

/// 是否已登录 Provider（同步版本）
///
/// 返回当前用户是否已登录（仅检查本地有效用户）
/// 用于需要同步检查的场景
///
/// Copied from [isAuthenticated].
@ProviderFor(isAuthenticated)
final isAuthenticatedProvider = AutoDisposeProvider<bool>.internal(
  isAuthenticated,
  name: r'isAuthenticatedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedRef = AutoDisposeProviderRef<bool>;
String _$isAuthenticatedAsyncHash() =>
    r'f97054a3d54734b56f15ccfa0ad4231090752243';

/// 是否已登录 Provider（异步版本）
///
/// 返回当前用户是否已登录（支持本地缓存与论坛会话）
/// 用于需要完整检查登录状态的场景
///
/// Copied from [isAuthenticatedAsync].
@ProviderFor(isAuthenticatedAsync)
final isAuthenticatedAsyncProvider = AutoDisposeFutureProvider<bool>.internal(
  isAuthenticatedAsync,
  name: r'isAuthenticatedAsyncProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isAuthenticatedAsyncHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsAuthenticatedAsyncRef = AutoDisposeFutureProviderRef<bool>;
String _$authTokenHash() => r'9a41745586309e28c4623885edf5dc759eae968d';

/// 用户 Token Provider
///
/// 返回当前用户的 token，未登录时返回 null
///
/// Copied from [authToken].
@ProviderFor(authToken)
final authTokenProvider = AutoDisposeProvider<String?>.internal(
  authToken,
  name: r'authTokenProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authTokenHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthTokenRef = AutoDisposeProviderRef<String?>;
String _$authNotifierHash() => r'fc74dfe1d90f7ac773da7a35fe37eddb02ab5de9';

/// 认证状态 Notifier
///
/// Copied from [AuthNotifier].
@ProviderFor(AuthNotifier)
final authNotifierProvider =
    AutoDisposeNotifierProvider<AuthNotifier, AsyncValue<UserInfo>>.internal(
      AuthNotifier.new,
      name: r'authNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$authNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AuthNotifier = AutoDisposeNotifier<AsyncValue<UserInfo>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
