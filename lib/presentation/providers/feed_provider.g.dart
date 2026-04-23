// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedDetailHash() => r'ffb91068c9d131d91f00da65c60938494ee722d6';

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

/// 动态详情 Provider（带参数）
///
/// [feedId] 动态ID
///
/// Copied from [feedDetail].
@ProviderFor(feedDetail)
const feedDetailProvider = FeedDetailFamily();

/// 动态详情 Provider（带参数）
///
/// [feedId] 动态ID
///
/// Copied from [feedDetail].
class FeedDetailFamily extends Family<FeedItem?> {
  /// 动态详情 Provider（带参数）
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [feedDetail].
  const FeedDetailFamily();

  /// 动态详情 Provider（带参数）
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [feedDetail].
  FeedDetailProvider call(String feedId) {
    return FeedDetailProvider(feedId);
  }

  @override
  FeedDetailProvider getProviderOverride(
    covariant FeedDetailProvider provider,
  ) {
    return call(provider.feedId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'feedDetailProvider';
}

/// 动态详情 Provider（带参数）
///
/// [feedId] 动态ID
///
/// Copied from [feedDetail].
class FeedDetailProvider extends AutoDisposeProvider<FeedItem?> {
  /// 动态详情 Provider（带参数）
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [feedDetail].
  FeedDetailProvider(String feedId)
    : this._internal(
        (ref) => feedDetail(ref as FeedDetailRef, feedId),
        from: feedDetailProvider,
        name: r'feedDetailProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$feedDetailHash,
        dependencies: FeedDetailFamily._dependencies,
        allTransitiveDependencies: FeedDetailFamily._allTransitiveDependencies,
        feedId: feedId,
      );

  FeedDetailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feedId,
  }) : super.internal();

  final String feedId;

  @override
  Override overrideWith(FeedItem? Function(FeedDetailRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: FeedDetailProvider._internal(
        (ref) => create(ref as FeedDetailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feedId: feedId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<FeedItem?> createElement() {
    return _FeedDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedDetailProvider && other.feedId == feedId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feedId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedDetailRef on AutoDisposeProviderRef<FeedItem?> {
  /// The parameter `feedId` of this provider.
  String get feedId;
}

class _FeedDetailProviderElement extends AutoDisposeProviderElement<FeedItem?>
    with FeedDetailRef {
  _FeedDetailProviderElement(super.provider);

  @override
  String get feedId => (origin as FeedDetailProvider).feedId;
}

String _$feedCommentsHash() => r'b2f55ba771ffd4822b840c6ed930284641a90b27';

/// 动态评论列表 Provider
///
/// [feedId] 动态ID
///
/// Copied from [feedComments].
@ProviderFor(feedComments)
const feedCommentsProvider = FeedCommentsFamily();

/// 动态评论列表 Provider
///
/// [feedId] 动态ID
///
/// Copied from [feedComments].
class FeedCommentsFamily extends Family<List<CommentItem>> {
  /// 动态评论列表 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [feedComments].
  const FeedCommentsFamily();

  /// 动态评论列表 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [feedComments].
  FeedCommentsProvider call(String feedId) {
    return FeedCommentsProvider(feedId);
  }

  @override
  FeedCommentsProvider getProviderOverride(
    covariant FeedCommentsProvider provider,
  ) {
    return call(provider.feedId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'feedCommentsProvider';
}

/// 动态评论列表 Provider
///
/// [feedId] 动态ID
///
/// Copied from [feedComments].
class FeedCommentsProvider extends AutoDisposeProvider<List<CommentItem>> {
  /// 动态评论列表 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [feedComments].
  FeedCommentsProvider(String feedId)
    : this._internal(
        (ref) => feedComments(ref as FeedCommentsRef, feedId),
        from: feedCommentsProvider,
        name: r'feedCommentsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$feedCommentsHash,
        dependencies: FeedCommentsFamily._dependencies,
        allTransitiveDependencies:
            FeedCommentsFamily._allTransitiveDependencies,
        feedId: feedId,
      );

  FeedCommentsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feedId,
  }) : super.internal();

  final String feedId;

  @override
  Override overrideWith(
    List<CommentItem> Function(FeedCommentsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FeedCommentsProvider._internal(
        (ref) => create(ref as FeedCommentsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feedId: feedId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<CommentItem>> createElement() {
    return _FeedCommentsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedCommentsProvider && other.feedId == feedId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feedId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedCommentsRef on AutoDisposeProviderRef<List<CommentItem>> {
  /// The parameter `feedId` of this provider.
  String get feedId;
}

class _FeedCommentsProviderElement
    extends AutoDisposeProviderElement<List<CommentItem>>
    with FeedCommentsRef {
  _FeedCommentsProviderElement(super.provider);

  @override
  String get feedId => (origin as FeedCommentsProvider).feedId;
}

String _$isFeedDetailLoadingHash() =>
    r'947b08ee9a76e4d1f95bc62dcdc6641d03a42542';

/// 动态是否正在加载 Provider
///
/// [feedId] 动态ID
///
/// Copied from [isFeedDetailLoading].
@ProviderFor(isFeedDetailLoading)
const isFeedDetailLoadingProvider = IsFeedDetailLoadingFamily();

/// 动态是否正在加载 Provider
///
/// [feedId] 动态ID
///
/// Copied from [isFeedDetailLoading].
class IsFeedDetailLoadingFamily extends Family<bool> {
  /// 动态是否正在加载 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [isFeedDetailLoading].
  const IsFeedDetailLoadingFamily();

  /// 动态是否正在加载 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [isFeedDetailLoading].
  IsFeedDetailLoadingProvider call(String feedId) {
    return IsFeedDetailLoadingProvider(feedId);
  }

  @override
  IsFeedDetailLoadingProvider getProviderOverride(
    covariant IsFeedDetailLoadingProvider provider,
  ) {
    return call(provider.feedId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isFeedDetailLoadingProvider';
}

/// 动态是否正在加载 Provider
///
/// [feedId] 动态ID
///
/// Copied from [isFeedDetailLoading].
class IsFeedDetailLoadingProvider extends AutoDisposeProvider<bool> {
  /// 动态是否正在加载 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [isFeedDetailLoading].
  IsFeedDetailLoadingProvider(String feedId)
    : this._internal(
        (ref) => isFeedDetailLoading(ref as IsFeedDetailLoadingRef, feedId),
        from: isFeedDetailLoadingProvider,
        name: r'isFeedDetailLoadingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isFeedDetailLoadingHash,
        dependencies: IsFeedDetailLoadingFamily._dependencies,
        allTransitiveDependencies:
            IsFeedDetailLoadingFamily._allTransitiveDependencies,
        feedId: feedId,
      );

  IsFeedDetailLoadingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feedId,
  }) : super.internal();

  final String feedId;

  @override
  Override overrideWith(bool Function(IsFeedDetailLoadingRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsFeedDetailLoadingProvider._internal(
        (ref) => create(ref as IsFeedDetailLoadingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feedId: feedId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsFeedDetailLoadingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFeedDetailLoadingProvider && other.feedId == feedId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feedId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsFeedDetailLoadingRef on AutoDisposeProviderRef<bool> {
  /// The parameter `feedId` of this provider.
  String get feedId;
}

class _IsFeedDetailLoadingProviderElement
    extends AutoDisposeProviderElement<bool>
    with IsFeedDetailLoadingRef {
  _IsFeedDetailLoadingProviderElement(super.provider);

  @override
  String get feedId => (origin as IsFeedDetailLoadingProvider).feedId;
}

String _$isCommentsLoadingHash() => r'93b9b2ae01eb166b2be593b17281d25d6ac11730';

/// 评论是否正在加载 Provider
///
/// [feedId] 动态ID
///
/// Copied from [isCommentsLoading].
@ProviderFor(isCommentsLoading)
const isCommentsLoadingProvider = IsCommentsLoadingFamily();

/// 评论是否正在加载 Provider
///
/// [feedId] 动态ID
///
/// Copied from [isCommentsLoading].
class IsCommentsLoadingFamily extends Family<bool> {
  /// 评论是否正在加载 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [isCommentsLoading].
  const IsCommentsLoadingFamily();

  /// 评论是否正在加载 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [isCommentsLoading].
  IsCommentsLoadingProvider call(String feedId) {
    return IsCommentsLoadingProvider(feedId);
  }

  @override
  IsCommentsLoadingProvider getProviderOverride(
    covariant IsCommentsLoadingProvider provider,
  ) {
    return call(provider.feedId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isCommentsLoadingProvider';
}

/// 评论是否正在加载 Provider
///
/// [feedId] 动态ID
///
/// Copied from [isCommentsLoading].
class IsCommentsLoadingProvider extends AutoDisposeProvider<bool> {
  /// 评论是否正在加载 Provider
  ///
  /// [feedId] 动态ID
  ///
  /// Copied from [isCommentsLoading].
  IsCommentsLoadingProvider(String feedId)
    : this._internal(
        (ref) => isCommentsLoading(ref as IsCommentsLoadingRef, feedId),
        from: isCommentsLoadingProvider,
        name: r'isCommentsLoadingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isCommentsLoadingHash,
        dependencies: IsCommentsLoadingFamily._dependencies,
        allTransitiveDependencies:
            IsCommentsLoadingFamily._allTransitiveDependencies,
        feedId: feedId,
      );

  IsCommentsLoadingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feedId,
  }) : super.internal();

  final String feedId;

  @override
  Override overrideWith(bool Function(IsCommentsLoadingRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsCommentsLoadingProvider._internal(
        (ref) => create(ref as IsCommentsLoadingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feedId: feedId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsCommentsLoadingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsCommentsLoadingProvider && other.feedId == feedId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feedId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsCommentsLoadingRef on AutoDisposeProviderRef<bool> {
  /// The parameter `feedId` of this provider.
  String get feedId;
}

class _IsCommentsLoadingProviderElement extends AutoDisposeProviderElement<bool>
    with IsCommentsLoadingRef {
  _IsCommentsLoadingProviderElement(super.provider);

  @override
  String get feedId => (origin as IsCommentsLoadingProvider).feedId;
}

String _$feedDetailNotifierHash() =>
    r'5beb0e6d134a3b5dc707b590a57732d6be3575ac';

abstract class _$FeedDetailNotifier
    extends BuildlessAutoDisposeNotifier<FeedDetailState> {
  late final String feedId;

  FeedDetailState build(String feedId);
}

/// 动态详情状态 Notifier（家族 Provider）
///
/// Copied from [FeedDetailNotifier].
@ProviderFor(FeedDetailNotifier)
const feedDetailNotifierProvider = FeedDetailNotifierFamily();

/// 动态详情状态 Notifier（家族 Provider）
///
/// Copied from [FeedDetailNotifier].
class FeedDetailNotifierFamily extends Family<FeedDetailState> {
  /// 动态详情状态 Notifier（家族 Provider）
  ///
  /// Copied from [FeedDetailNotifier].
  const FeedDetailNotifierFamily();

  /// 动态详情状态 Notifier（家族 Provider）
  ///
  /// Copied from [FeedDetailNotifier].
  FeedDetailNotifierProvider call(String feedId) {
    return FeedDetailNotifierProvider(feedId);
  }

  @override
  FeedDetailNotifierProvider getProviderOverride(
    covariant FeedDetailNotifierProvider provider,
  ) {
    return call(provider.feedId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'feedDetailNotifierProvider';
}

/// 动态详情状态 Notifier（家族 Provider）
///
/// Copied from [FeedDetailNotifier].
class FeedDetailNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<FeedDetailNotifier, FeedDetailState> {
  /// 动态详情状态 Notifier（家族 Provider）
  ///
  /// Copied from [FeedDetailNotifier].
  FeedDetailNotifierProvider(String feedId)
    : this._internal(
        () => FeedDetailNotifier()..feedId = feedId,
        from: feedDetailNotifierProvider,
        name: r'feedDetailNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$feedDetailNotifierHash,
        dependencies: FeedDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            FeedDetailNotifierFamily._allTransitiveDependencies,
        feedId: feedId,
      );

  FeedDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.feedId,
  }) : super.internal();

  final String feedId;

  @override
  FeedDetailState runNotifierBuild(covariant FeedDetailNotifier notifier) {
    return notifier.build(feedId);
  }

  @override
  Override overrideWith(FeedDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: FeedDetailNotifierProvider._internal(
        () => create()..feedId = feedId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        feedId: feedId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<FeedDetailNotifier, FeedDetailState>
  createElement() {
    return _FeedDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FeedDetailNotifierProvider && other.feedId == feedId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, feedId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FeedDetailNotifierRef on AutoDisposeNotifierProviderRef<FeedDetailState> {
  /// The parameter `feedId` of this provider.
  String get feedId;
}

class _FeedDetailNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<FeedDetailNotifier, FeedDetailState>
    with FeedDetailNotifierRef {
  _FeedDetailNotifierProviderElement(super.provider);

  @override
  String get feedId => (origin as FeedDetailNotifierProvider).feedId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
