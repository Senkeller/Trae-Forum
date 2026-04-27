// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_post_content_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$notificationPostContentHash() =>
    r'6ffa6fe1efc0acacb9765a59844d079f49993410';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$NotificationPostContent
    extends BuildlessAutoDisposeNotifier<PostContentState> {
  late final int topicId;
  late final int postNumber;

  PostContentState build(int topicId, int postNumber);
}

/// 获取通知帖子内容的 Provider
///
/// 根据 topicId 和 postNumber 获取对应的帖子内容
///
/// Copied from [NotificationPostContent].
@ProviderFor(NotificationPostContent)
const notificationPostContentProvider = NotificationPostContentFamily();

/// 获取通知帖子内容的 Provider
///
/// 根据 topicId 和 postNumber 获取对应的帖子内容
///
/// Copied from [NotificationPostContent].
class NotificationPostContentFamily extends Family<PostContentState> {
  /// 获取通知帖子内容的 Provider
  ///
  /// 根据 topicId 和 postNumber 获取对应的帖子内容
  ///
  /// Copied from [NotificationPostContent].
  const NotificationPostContentFamily();

  /// 获取通知帖子内容的 Provider
  ///
  /// 根据 topicId 和 postNumber 获取对应的帖子内容
  ///
  /// Copied from [NotificationPostContent].
  NotificationPostContentProvider call(int topicId, int postNumber) {
    return NotificationPostContentProvider(topicId, postNumber);
  }

  @override
  NotificationPostContentProvider getProviderOverride(
    covariant NotificationPostContentProvider provider,
  ) {
    return call(provider.topicId, provider.postNumber);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'notificationPostContentProvider';
}

/// 获取通知帖子内容的 Provider
///
/// 根据 topicId 和 postNumber 获取对应的帖子内容
///
/// Copied from [NotificationPostContent].
class NotificationPostContentProvider
    extends
        AutoDisposeNotifierProviderImpl<
          NotificationPostContent,
          PostContentState
        > {
  /// 获取通知帖子内容的 Provider
  ///
  /// 根据 topicId 和 postNumber 获取对应的帖子内容
  ///
  /// Copied from [NotificationPostContent].
  NotificationPostContentProvider(int topicId, int postNumber)
    : this._internal(
        () => NotificationPostContent()
          ..topicId = topicId
          ..postNumber = postNumber,
        from: notificationPostContentProvider,
        name: r'notificationPostContentProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$notificationPostContentHash,
        dependencies: NotificationPostContentFamily._dependencies,
        allTransitiveDependencies:
            NotificationPostContentFamily._allTransitiveDependencies,
        topicId: topicId,
        postNumber: postNumber,
      );

  NotificationPostContentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.topicId,
    required this.postNumber,
  }) : super.internal();

  final int topicId;
  final int postNumber;

  @override
  PostContentState runNotifierBuild(
    covariant NotificationPostContent notifier,
  ) {
    return notifier.build(topicId, postNumber);
  }

  @override
  Override overrideWith(NotificationPostContent Function() create) {
    return ProviderOverride(
      origin: this,
      override: NotificationPostContentProvider._internal(
        () => create()
          ..topicId = topicId
          ..postNumber = postNumber,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        topicId: topicId,
        postNumber: postNumber,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<NotificationPostContent, PostContentState>
  createElement() {
    return _NotificationPostContentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is NotificationPostContentProvider &&
        other.topicId == topicId &&
        other.postNumber == postNumber;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, topicId.hashCode);
    hash = _SystemHash.combine(hash, postNumber.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin NotificationPostContentRef
    on AutoDisposeNotifierProviderRef<PostContentState> {
  /// The parameter `topicId` of this provider.
  int get topicId;

  /// The parameter `postNumber` of this provider.
  int get postNumber;
}

class _NotificationPostContentProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          NotificationPostContent,
          PostContentState
        >
    with NotificationPostContentRef {
  _NotificationPostContentProviderElement(super.provider);

  @override
  int get topicId => (origin as NotificationPostContentProvider).topicId;
  @override
  int get postNumber => (origin as NotificationPostContentProvider).postNumber;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
