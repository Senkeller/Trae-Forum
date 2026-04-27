// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationListHash() => r'a8482745a50ae7e9d01161790d3af093ada30dd0';

/// 通知列表 Provider
///
/// Copied from [notificationList].
@ProviderFor(notificationList)
final notificationListProvider =
    AutoDisposeProvider<List<DiscourseNotification>>.internal(
      notificationList,
      name: r'notificationListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationListRef =
    AutoDisposeProviderRef<List<DiscourseNotification>>;
String _$unreadNotificationCountHash() =>
    r'26fd0b7feda70bd86f6eacd5c289f569c8fbdf1e';

/// 未读通知数量 Provider
///
/// Copied from [unreadNotificationCount].
@ProviderFor(unreadNotificationCount)
final unreadNotificationCountProvider = AutoDisposeProvider<int>.internal(
  unreadNotificationCount,
  name: r'unreadNotificationCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadNotificationCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadNotificationCountRef = AutoDisposeProviderRef<int>;
String _$currentNotificationFilterTypeHash() =>
    r'19d237449eb26d11dd9a032978d5fd9fbf6967af';

/// 当前筛选类型 Provider
///
/// Copied from [currentNotificationFilterType].
@ProviderFor(currentNotificationFilterType)
final currentNotificationFilterTypeProvider =
    AutoDisposeProvider<NotificationFilterType>.internal(
      currentNotificationFilterType,
      name: r'currentNotificationFilterTypeProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentNotificationFilterTypeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentNotificationFilterTypeRef =
    AutoDisposeProviderRef<NotificationFilterType>;
String _$isNotificationLoadingHash() =>
    r'3b5be5dafb1e0d1259ec3da9f5f048732fbf4b56';

/// 是否正在加载通知 Provider
///
/// Copied from [isNotificationLoading].
@ProviderFor(isNotificationLoading)
final isNotificationLoadingProvider = AutoDisposeProvider<bool>.internal(
  isNotificationLoading,
  name: r'isNotificationLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isNotificationLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsNotificationLoadingRef = AutoDisposeProviderRef<bool>;
String _$notificationStateHash() => r'54ca150dff0016a611cca12ee8403973e2ab2875';

/// 通知状态 Provider
///
/// Copied from [notificationState].
@ProviderFor(notificationState)
final notificationStateProvider =
    AutoDisposeProvider<NotificationState>.internal(
      notificationState,
      name: r'notificationStateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationStateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NotificationStateRef = AutoDisposeProviderRef<NotificationState>;
String _$notificationNotifierHash() =>
    r'2725aa97633a580552319c7580ea2e4fe317bdb9';

/// 通知状态 Notifier
///
/// Copied from [NotificationNotifier].
@ProviderFor(NotificationNotifier)
final notificationNotifierProvider =
    AutoDisposeNotifierProvider<
      NotificationNotifier,
      NotificationState
    >.internal(
      NotificationNotifier.new,
      name: r'notificationNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$notificationNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$NotificationNotifier = AutoDisposeNotifier<NotificationState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
