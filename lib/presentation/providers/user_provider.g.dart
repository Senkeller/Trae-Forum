// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userProfileHash() => r'd780f80eb79edc32b2b6c43d65a15c44e7c35dab';

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

/// 用户资料 Provider（带参数）
///
/// [uid] 用户ID
///
/// Copied from [userProfile].
@ProviderFor(userProfile)
const userProfileProvider = UserProfileFamily();

/// 用户资料 Provider（带参数）
///
/// [uid] 用户ID
///
/// Copied from [userProfile].
class UserProfileFamily extends Family<UserProfile?> {
  /// 用户资料 Provider（带参数）
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [userProfile].
  const UserProfileFamily();

  /// 用户资料 Provider（带参数）
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [userProfile].
  UserProfileProvider call(String uid) {
    return UserProfileProvider(uid);
  }

  @override
  UserProfileProvider getProviderOverride(
    covariant UserProfileProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProfileProvider';
}

/// 用户资料 Provider（带参数）
///
/// [uid] 用户ID
///
/// Copied from [userProfile].
class UserProfileProvider extends AutoDisposeProvider<UserProfile?> {
  /// 用户资料 Provider（带参数）
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [userProfile].
  UserProfileProvider(String uid)
    : this._internal(
        (ref) => userProfile(ref as UserProfileRef, uid),
        from: userProfileProvider,
        name: r'userProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userProfileHash,
        dependencies: UserProfileFamily._dependencies,
        allTransitiveDependencies: UserProfileFamily._allTransitiveDependencies,
        uid: uid,
      );

  UserProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(UserProfile? Function(UserProfileRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: UserProfileProvider._internal(
        (ref) => create(ref as UserProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<UserProfile?> createElement() {
    return _UserProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserProfileRef on AutoDisposeProviderRef<UserProfile?> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserProfileProviderElement
    extends AutoDisposeProviderElement<UserProfile?>
    with UserProfileRef {
  _UserProfileProviderElement(super.provider);

  @override
  String get uid => (origin as UserProfileProvider).uid;
}

String _$userFeedsHash() => r'd008bc5da6670520c880a3d9d0de78b3bbe8d841';

/// 用户动态列表 Provider
///
/// [uid] 用户ID
///
/// Copied from [userFeeds].
@ProviderFor(userFeeds)
const userFeedsProvider = UserFeedsFamily();

/// 用户动态列表 Provider
///
/// [uid] 用户ID
///
/// Copied from [userFeeds].
class UserFeedsFamily extends Family<List<FeedItem>> {
  /// 用户动态列表 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [userFeeds].
  const UserFeedsFamily();

  /// 用户动态列表 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [userFeeds].
  UserFeedsProvider call(String uid) {
    return UserFeedsProvider(uid);
  }

  @override
  UserFeedsProvider getProviderOverride(covariant UserFeedsProvider provider) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userFeedsProvider';
}

/// 用户动态列表 Provider
///
/// [uid] 用户ID
///
/// Copied from [userFeeds].
class UserFeedsProvider extends AutoDisposeProvider<List<FeedItem>> {
  /// 用户动态列表 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [userFeeds].
  UserFeedsProvider(String uid)
    : this._internal(
        (ref) => userFeeds(ref as UserFeedsRef, uid),
        from: userFeedsProvider,
        name: r'userFeedsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userFeedsHash,
        dependencies: UserFeedsFamily._dependencies,
        allTransitiveDependencies: UserFeedsFamily._allTransitiveDependencies,
        uid: uid,
      );

  UserFeedsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(List<FeedItem> Function(UserFeedsRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: UserFeedsProvider._internal(
        (ref) => create(ref as UserFeedsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<FeedItem>> createElement() {
    return _UserFeedsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserFeedsProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserFeedsRef on AutoDisposeProviderRef<List<FeedItem>> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserFeedsProviderElement
    extends AutoDisposeProviderElement<List<FeedItem>>
    with UserFeedsRef {
  _UserFeedsProviderElement(super.provider);

  @override
  String get uid => (origin as UserFeedsProvider).uid;
}

String _$isUserProfileLoadingHash() =>
    r'e5172cd83eed9e31c15f7f498ba5a8f57f13a3b5';

/// 用户是否正在加载资料 Provider
///
/// [uid] 用户ID
///
/// Copied from [isUserProfileLoading].
@ProviderFor(isUserProfileLoading)
const isUserProfileLoadingProvider = IsUserProfileLoadingFamily();

/// 用户是否正在加载资料 Provider
///
/// [uid] 用户ID
///
/// Copied from [isUserProfileLoading].
class IsUserProfileLoadingFamily extends Family<bool> {
  /// 用户是否正在加载资料 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isUserProfileLoading].
  const IsUserProfileLoadingFamily();

  /// 用户是否正在加载资料 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isUserProfileLoading].
  IsUserProfileLoadingProvider call(String uid) {
    return IsUserProfileLoadingProvider(uid);
  }

  @override
  IsUserProfileLoadingProvider getProviderOverride(
    covariant IsUserProfileLoadingProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isUserProfileLoadingProvider';
}

/// 用户是否正在加载资料 Provider
///
/// [uid] 用户ID
///
/// Copied from [isUserProfileLoading].
class IsUserProfileLoadingProvider extends AutoDisposeProvider<bool> {
  /// 用户是否正在加载资料 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isUserProfileLoading].
  IsUserProfileLoadingProvider(String uid)
    : this._internal(
        (ref) => isUserProfileLoading(ref as IsUserProfileLoadingRef, uid),
        from: isUserProfileLoadingProvider,
        name: r'isUserProfileLoadingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isUserProfileLoadingHash,
        dependencies: IsUserProfileLoadingFamily._dependencies,
        allTransitiveDependencies:
            IsUserProfileLoadingFamily._allTransitiveDependencies,
        uid: uid,
      );

  IsUserProfileLoadingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(
    bool Function(IsUserProfileLoadingRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsUserProfileLoadingProvider._internal(
        (ref) => create(ref as IsUserProfileLoadingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsUserProfileLoadingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsUserProfileLoadingProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsUserProfileLoadingRef on AutoDisposeProviderRef<bool> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _IsUserProfileLoadingProviderElement
    extends AutoDisposeProviderElement<bool>
    with IsUserProfileLoadingRef {
  _IsUserProfileLoadingProviderElement(super.provider);

  @override
  String get uid => (origin as IsUserProfileLoadingProvider).uid;
}

String _$isUserFeedsLoadingHash() =>
    r'2f46e600d593c961e253affa7a3b4b1dce0ae1e4';

/// 用户是否正在加载动态 Provider
///
/// [uid] 用户ID
///
/// Copied from [isUserFeedsLoading].
@ProviderFor(isUserFeedsLoading)
const isUserFeedsLoadingProvider = IsUserFeedsLoadingFamily();

/// 用户是否正在加载动态 Provider
///
/// [uid] 用户ID
///
/// Copied from [isUserFeedsLoading].
class IsUserFeedsLoadingFamily extends Family<bool> {
  /// 用户是否正在加载动态 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isUserFeedsLoading].
  const IsUserFeedsLoadingFamily();

  /// 用户是否正在加载动态 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isUserFeedsLoading].
  IsUserFeedsLoadingProvider call(String uid) {
    return IsUserFeedsLoadingProvider(uid);
  }

  @override
  IsUserFeedsLoadingProvider getProviderOverride(
    covariant IsUserFeedsLoadingProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isUserFeedsLoadingProvider';
}

/// 用户是否正在加载动态 Provider
///
/// [uid] 用户ID
///
/// Copied from [isUserFeedsLoading].
class IsUserFeedsLoadingProvider extends AutoDisposeProvider<bool> {
  /// 用户是否正在加载动态 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isUserFeedsLoading].
  IsUserFeedsLoadingProvider(String uid)
    : this._internal(
        (ref) => isUserFeedsLoading(ref as IsUserFeedsLoadingRef, uid),
        from: isUserFeedsLoadingProvider,
        name: r'isUserFeedsLoadingProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isUserFeedsLoadingHash,
        dependencies: IsUserFeedsLoadingFamily._dependencies,
        allTransitiveDependencies:
            IsUserFeedsLoadingFamily._allTransitiveDependencies,
        uid: uid,
      );

  IsUserFeedsLoadingProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(bool Function(IsUserFeedsLoadingRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsUserFeedsLoadingProvider._internal(
        (ref) => create(ref as IsUserFeedsLoadingRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsUserFeedsLoadingProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsUserFeedsLoadingProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsUserFeedsLoadingRef on AutoDisposeProviderRef<bool> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _IsUserFeedsLoadingProviderElement
    extends AutoDisposeProviderElement<bool>
    with IsUserFeedsLoadingRef {
  _IsUserFeedsLoadingProviderElement(super.provider);

  @override
  String get uid => (origin as IsUserFeedsLoadingProvider).uid;
}

String _$isFollowingUserHash() => r'33b3d4b7a3e4500aff71e7831d59ab21bda3ee2f';

/// 用户关注状态 Provider
///
/// [uid] 用户ID
///
/// Copied from [isFollowingUser].
@ProviderFor(isFollowingUser)
const isFollowingUserProvider = IsFollowingUserFamily();

/// 用户关注状态 Provider
///
/// [uid] 用户ID
///
/// Copied from [isFollowingUser].
class IsFollowingUserFamily extends Family<bool> {
  /// 用户关注状态 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isFollowingUser].
  const IsFollowingUserFamily();

  /// 用户关注状态 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isFollowingUser].
  IsFollowingUserProvider call(String uid) {
    return IsFollowingUserProvider(uid);
  }

  @override
  IsFollowingUserProvider getProviderOverride(
    covariant IsFollowingUserProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isFollowingUserProvider';
}

/// 用户关注状态 Provider
///
/// [uid] 用户ID
///
/// Copied from [isFollowingUser].
class IsFollowingUserProvider extends AutoDisposeProvider<bool> {
  /// 用户关注状态 Provider
  ///
  /// [uid] 用户ID
  ///
  /// Copied from [isFollowingUser].
  IsFollowingUserProvider(String uid)
    : this._internal(
        (ref) => isFollowingUser(ref as IsFollowingUserRef, uid),
        from: isFollowingUserProvider,
        name: r'isFollowingUserProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isFollowingUserHash,
        dependencies: IsFollowingUserFamily._dependencies,
        allTransitiveDependencies:
            IsFollowingUserFamily._allTransitiveDependencies,
        uid: uid,
      );

  IsFollowingUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  Override overrideWith(bool Function(IsFollowingUserRef provider) create) {
    return ProviderOverride(
      origin: this,
      override: IsFollowingUserProvider._internal(
        (ref) => create(ref as IsFollowingUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsFollowingUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFollowingUserProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsFollowingUserRef on AutoDisposeProviderRef<bool> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _IsFollowingUserProviderElement extends AutoDisposeProviderElement<bool>
    with IsFollowingUserRef {
  _IsFollowingUserProviderElement(super.provider);

  @override
  String get uid => (origin as IsFollowingUserProvider).uid;
}

String _$userSpaceNotifierHash() => r'bb05e5a2a42827085e023a2d02be4105283e7354';

abstract class _$UserSpaceNotifier
    extends BuildlessAutoDisposeNotifier<UserSpaceState> {
  late final String uid;

  UserSpaceState build(String uid);
}

/// 用户空间状态 Notifier（家族 Provider）
///
/// Copied from [UserSpaceNotifier].
@ProviderFor(UserSpaceNotifier)
const userSpaceNotifierProvider = UserSpaceNotifierFamily();

/// 用户空间状态 Notifier（家族 Provider）
///
/// Copied from [UserSpaceNotifier].
class UserSpaceNotifierFamily extends Family<UserSpaceState> {
  /// 用户空间状态 Notifier（家族 Provider）
  ///
  /// Copied from [UserSpaceNotifier].
  const UserSpaceNotifierFamily();

  /// 用户空间状态 Notifier（家族 Provider）
  ///
  /// Copied from [UserSpaceNotifier].
  UserSpaceNotifierProvider call(String uid) {
    return UserSpaceNotifierProvider(uid);
  }

  @override
  UserSpaceNotifierProvider getProviderOverride(
    covariant UserSpaceNotifierProvider provider,
  ) {
    return call(provider.uid);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userSpaceNotifierProvider';
}

/// 用户空间状态 Notifier（家族 Provider）
///
/// Copied from [UserSpaceNotifier].
class UserSpaceNotifierProvider
    extends AutoDisposeNotifierProviderImpl<UserSpaceNotifier, UserSpaceState> {
  /// 用户空间状态 Notifier（家族 Provider）
  ///
  /// Copied from [UserSpaceNotifier].
  UserSpaceNotifierProvider(String uid)
    : this._internal(
        () => UserSpaceNotifier()..uid = uid,
        from: userSpaceNotifierProvider,
        name: r'userSpaceNotifierProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userSpaceNotifierHash,
        dependencies: UserSpaceNotifierFamily._dependencies,
        allTransitiveDependencies:
            UserSpaceNotifierFamily._allTransitiveDependencies,
        uid: uid,
      );

  UserSpaceNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.uid,
  }) : super.internal();

  final String uid;

  @override
  UserSpaceState runNotifierBuild(covariant UserSpaceNotifier notifier) {
    return notifier.build(uid);
  }

  @override
  Override overrideWith(UserSpaceNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserSpaceNotifierProvider._internal(
        () => create()..uid = uid,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        uid: uid,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<UserSpaceNotifier, UserSpaceState>
  createElement() {
    return _UserSpaceNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSpaceNotifierProvider && other.uid == uid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, uid.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserSpaceNotifierRef on AutoDisposeNotifierProviderRef<UserSpaceState> {
  /// The parameter `uid` of this provider.
  String get uid;
}

class _UserSpaceNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<UserSpaceNotifier, UserSpaceState>
    with UserSpaceNotifierRef {
  _UserSpaceNotifierProviderElement(super.provider);

  @override
  String get uid => (origin as UserSpaceNotifierProvider).uid;
}

String _$userFollowStatusHash() => r'11cb4cb63a98750b6395bfc084f6b5e7128e7c96';

abstract class _$UserFollowStatus
    extends BuildlessAutoDisposeAsyncNotifier<FollowStatus> {
  late final String username;

  FutureOr<FollowStatus> build(String username);
}

/// See also [UserFollowStatus].
@ProviderFor(UserFollowStatus)
const userFollowStatusProvider = UserFollowStatusFamily();

/// See also [UserFollowStatus].
class UserFollowStatusFamily extends Family<AsyncValue<FollowStatus>> {
  /// See also [UserFollowStatus].
  const UserFollowStatusFamily();

  /// See also [UserFollowStatus].
  UserFollowStatusProvider call(String username) {
    return UserFollowStatusProvider(username);
  }

  @override
  UserFollowStatusProvider getProviderOverride(
    covariant UserFollowStatusProvider provider,
  ) {
    return call(provider.username);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userFollowStatusProvider';
}

/// See also [UserFollowStatus].
class UserFollowStatusProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<UserFollowStatus, FollowStatus> {
  /// See also [UserFollowStatus].
  UserFollowStatusProvider(String username)
    : this._internal(
        () => UserFollowStatus()..username = username,
        from: userFollowStatusProvider,
        name: r'userFollowStatusProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userFollowStatusHash,
        dependencies: UserFollowStatusFamily._dependencies,
        allTransitiveDependencies:
            UserFollowStatusFamily._allTransitiveDependencies,
        username: username,
      );

  UserFollowStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
  }) : super.internal();

  final String username;

  @override
  FutureOr<FollowStatus> runNotifierBuild(covariant UserFollowStatus notifier) {
    return notifier.build(username);
  }

  @override
  Override overrideWith(UserFollowStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserFollowStatusProvider._internal(
        () => create()..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserFollowStatus, FollowStatus>
  createElement() {
    return _UserFollowStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserFollowStatusProvider && other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserFollowStatusRef on AutoDisposeAsyncNotifierProviderRef<FollowStatus> {
  /// The parameter `username` of this provider.
  String get username;
}

class _UserFollowStatusProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<UserFollowStatus, FollowStatus>
    with UserFollowStatusRef {
  _UserFollowStatusProviderElement(super.provider);

  @override
  String get username => (origin as UserFollowStatusProvider).username;
}

String _$discourseFollowListHash() =>
    r'a07a0d20c872d121184810e31eae0eea2d9891e4';

abstract class _$DiscourseFollowList
    extends BuildlessAutoDisposeAsyncNotifier<List<UserBasic>> {
  late final String username;
  late final FollowType type;

  FutureOr<List<UserBasic>> build(String username, FollowType type);
}

/// See also [DiscourseFollowList].
@ProviderFor(DiscourseFollowList)
const discourseFollowListProvider = DiscourseFollowListFamily();

/// See also [DiscourseFollowList].
class DiscourseFollowListFamily extends Family<AsyncValue<List<UserBasic>>> {
  /// See also [DiscourseFollowList].
  const DiscourseFollowListFamily();

  /// See also [DiscourseFollowList].
  DiscourseFollowListProvider call(String username, FollowType type) {
    return DiscourseFollowListProvider(username, type);
  }

  @override
  DiscourseFollowListProvider getProviderOverride(
    covariant DiscourseFollowListProvider provider,
  ) {
    return call(provider.username, provider.type);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'discourseFollowListProvider';
}

/// See also [DiscourseFollowList].
class DiscourseFollowListProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          DiscourseFollowList,
          List<UserBasic>
        > {
  /// See also [DiscourseFollowList].
  DiscourseFollowListProvider(String username, FollowType type)
    : this._internal(
        () => DiscourseFollowList()
          ..username = username
          ..type = type,
        from: discourseFollowListProvider,
        name: r'discourseFollowListProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$discourseFollowListHash,
        dependencies: DiscourseFollowListFamily._dependencies,
        allTransitiveDependencies:
            DiscourseFollowListFamily._allTransitiveDependencies,
        username: username,
        type: type,
      );

  DiscourseFollowListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
    required this.type,
  }) : super.internal();

  final String username;
  final FollowType type;

  @override
  FutureOr<List<UserBasic>> runNotifierBuild(
    covariant DiscourseFollowList notifier,
  ) {
    return notifier.build(username, type);
  }

  @override
  Override overrideWith(DiscourseFollowList Function() create) {
    return ProviderOverride(
      origin: this,
      override: DiscourseFollowListProvider._internal(
        () => create()
          ..username = username
          ..type = type,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
        type: type,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DiscourseFollowList, List<UserBasic>>
  createElement() {
    return _DiscourseFollowListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DiscourseFollowListProvider &&
        other.username == username &&
        other.type == type;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DiscourseFollowListRef
    on AutoDisposeAsyncNotifierProviderRef<List<UserBasic>> {
  /// The parameter `username` of this provider.
  String get username;

  /// The parameter `type` of this provider.
  FollowType get type;
}

class _DiscourseFollowListProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          DiscourseFollowList,
          List<UserBasic>
        >
    with DiscourseFollowListRef {
  _DiscourseFollowListProviderElement(super.provider);

  @override
  String get username => (origin as DiscourseFollowListProvider).username;
  @override
  FollowType get type => (origin as DiscourseFollowListProvider).type;
}

String _$discourseUserProfileHash() =>
    r'cc66ac3359753a0947c897f0cc3e086ce6421daa';

abstract class _$DiscourseUserProfile
    extends BuildlessAutoDisposeAsyncNotifier<Map<String, dynamic>?> {
  late final String username;

  FutureOr<Map<String, dynamic>?> build(String username);
}

/// See also [DiscourseUserProfile].
@ProviderFor(DiscourseUserProfile)
const discourseUserProfileProvider = DiscourseUserProfileFamily();

/// See also [DiscourseUserProfile].
class DiscourseUserProfileFamily
    extends Family<AsyncValue<Map<String, dynamic>?>> {
  /// See also [DiscourseUserProfile].
  const DiscourseUserProfileFamily();

  /// See also [DiscourseUserProfile].
  DiscourseUserProfileProvider call(String username) {
    return DiscourseUserProfileProvider(username);
  }

  @override
  DiscourseUserProfileProvider getProviderOverride(
    covariant DiscourseUserProfileProvider provider,
  ) {
    return call(provider.username);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'discourseUserProfileProvider';
}

/// See also [DiscourseUserProfile].
class DiscourseUserProfileProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          DiscourseUserProfile,
          Map<String, dynamic>?
        > {
  /// See also [DiscourseUserProfile].
  DiscourseUserProfileProvider(String username)
    : this._internal(
        () => DiscourseUserProfile()..username = username,
        from: discourseUserProfileProvider,
        name: r'discourseUserProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$discourseUserProfileHash,
        dependencies: DiscourseUserProfileFamily._dependencies,
        allTransitiveDependencies:
            DiscourseUserProfileFamily._allTransitiveDependencies,
        username: username,
      );

  DiscourseUserProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.username,
  }) : super.internal();

  final String username;

  @override
  FutureOr<Map<String, dynamic>?> runNotifierBuild(
    covariant DiscourseUserProfile notifier,
  ) {
    return notifier.build(username);
  }

  @override
  Override overrideWith(DiscourseUserProfile Function() create) {
    return ProviderOverride(
      origin: this,
      override: DiscourseUserProfileProvider._internal(
        () => create()..username = username,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        username: username,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    DiscourseUserProfile,
    Map<String, dynamic>?
  >
  createElement() {
    return _DiscourseUserProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DiscourseUserProfileProvider && other.username == username;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, username.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DiscourseUserProfileRef
    on AutoDisposeAsyncNotifierProviderRef<Map<String, dynamic>?> {
  /// The parameter `username` of this provider.
  String get username;
}

class _DiscourseUserProfileProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          DiscourseUserProfile,
          Map<String, dynamic>?
        >
    with DiscourseUserProfileRef {
  _DiscourseUserProfileProviderElement(super.provider);

  @override
  String get username => (origin as DiscourseUserProfileProvider).username;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
