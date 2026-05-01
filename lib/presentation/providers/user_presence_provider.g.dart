// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_presence_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentUserPresenceHash() =>
    r'a1cad0372f5bcf64d14b4e32038b0c8b4dcef6ed';

/// 当前用户在线状态 Provider（同步版本）
///
/// Copied from [currentUserPresence].
@ProviderFor(currentUserPresence)
final currentUserPresenceProvider =
    AutoDisposeProvider<UserPresenceStatus>.internal(
      currentUserPresence,
      name: r'currentUserPresenceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentUserPresenceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentUserPresenceRef = AutoDisposeProviderRef<UserPresenceStatus>;
String _$isUserOnlineHash() => r'cfa49eaafca63891b4e9fcf1b4be490e78668f74';

/// 是否在线 Provider
///
/// Copied from [isUserOnline].
@ProviderFor(isUserOnline)
final isUserOnlineProvider = AutoDisposeProvider<bool>.internal(
  isUserOnline,
  name: r'isUserOnlineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUserOnlineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsUserOnlineRef = AutoDisposeProviderRef<bool>;
String _$isUserOfflineHash() => r'fed47859b3262f4323cb4b1581e25a4710519211';

/// 是否离线 Provider
///
/// Copied from [isUserOffline].
@ProviderFor(isUserOffline)
final isUserOfflineProvider = AutoDisposeProvider<bool>.internal(
  isUserOffline,
  name: r'isUserOfflineProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUserOfflineHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsUserOfflineRef = AutoDisposeProviderRef<bool>;
String _$userPresenceNotifierHash() =>
    r'135cf1296c6e892cd245ef499cd7bb17a74d8e83';

/// 用户在线状态 Notifier
///
/// Copied from [UserPresenceNotifier].
@ProviderFor(UserPresenceNotifier)
final userPresenceNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      UserPresenceNotifier,
      UserPresenceStatus
    >.internal(
      UserPresenceNotifier.new,
      name: r'userPresenceNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$userPresenceNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UserPresenceNotifier = AutoDisposeAsyncNotifier<UserPresenceStatus>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
