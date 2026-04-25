// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pinned_topics_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pinnedTopicsListHash() => r'2dc24be30016b7839468a747d4126a9fdc66ef02';

/// 置顶话题列表Provider
///
/// Copied from [pinnedTopicsList].
@ProviderFor(pinnedTopicsList)
final pinnedTopicsListProvider =
    AutoDisposeProvider<List<PinnedTopic>>.internal(
      pinnedTopicsList,
      name: r'pinnedTopicsListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pinnedTopicsListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PinnedTopicsListRef = AutoDisposeProviderRef<List<PinnedTopic>>;
String _$isPinnedTopicsLoadingHash() =>
    r'a703eb7124bc4eaaf4d3b8a99f0bc40373edb5fd';

/// 置顶话题加载状态Provider
///
/// Copied from [isPinnedTopicsLoading].
@ProviderFor(isPinnedTopicsLoading)
final isPinnedTopicsLoadingProvider = AutoDisposeProvider<bool>.internal(
  isPinnedTopicsLoading,
  name: r'isPinnedTopicsLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isPinnedTopicsLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsPinnedTopicsLoadingRef = AutoDisposeProviderRef<bool>;
String _$pinnedTopicsErrorHash() => r'64aa999ef52f796f22efc5c9ae24d72f4b09c0d5';

/// 置顶话题错误信息Provider
///
/// Copied from [pinnedTopicsError].
@ProviderFor(pinnedTopicsError)
final pinnedTopicsErrorProvider = AutoDisposeProvider<String?>.internal(
  pinnedTopicsError,
  name: r'pinnedTopicsErrorProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pinnedTopicsErrorHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PinnedTopicsErrorRef = AutoDisposeProviderRef<String?>;
String _$pinnedTopicsNotifierHash() =>
    r'1f8c63584513104ed82a7a47f4d802520c373c37';

/// 置顶话题Notifier
///
/// Copied from [PinnedTopicsNotifier].
@ProviderFor(PinnedTopicsNotifier)
final pinnedTopicsNotifierProvider =
    AutoDisposeNotifierProvider<
      PinnedTopicsNotifier,
      PinnedTopicsState
    >.internal(
      PinnedTopicsNotifier.new,
      name: r'pinnedTopicsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$pinnedTopicsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PinnedTopicsNotifier = AutoDisposeNotifier<PinnedTopicsState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
