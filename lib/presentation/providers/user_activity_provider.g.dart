// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isFavoriteHash() => r'a51cced68c5d334d7ab01aca9155ca0f7e459003';

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

/// 检查是否已收藏 Provider
///
/// Copied from [isFavorite].
@ProviderFor(isFavorite)
const isFavoriteProvider = IsFavoriteFamily();

/// 检查是否已收藏 Provider
///
/// Copied from [isFavorite].
class IsFavoriteFamily extends Family<AsyncValue<bool>> {
  /// 检查是否已收藏 Provider
  ///
  /// Copied from [isFavorite].
  const IsFavoriteFamily();

  /// 检查是否已收藏 Provider
  ///
  /// Copied from [isFavorite].
  IsFavoriteProvider call(String feedId) {
    return IsFavoriteProvider(feedId);
  }

  @override
  IsFavoriteProvider getProviderOverride(
    covariant IsFavoriteProvider provider,
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
  String? get name => r'isFavoriteProvider';
}

/// 检查是否已收藏 Provider
///
/// Copied from [isFavorite].
class IsFavoriteProvider extends AutoDisposeFutureProvider<bool> {
  /// 检查是否已收藏 Provider
  ///
  /// Copied from [isFavorite].
  IsFavoriteProvider(String feedId)
    : this._internal(
        (ref) => isFavorite(ref as IsFavoriteRef, feedId),
        from: isFavoriteProvider,
        name: r'isFavoriteProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$isFavoriteHash,
        dependencies: IsFavoriteFamily._dependencies,
        allTransitiveDependencies: IsFavoriteFamily._allTransitiveDependencies,
        feedId: feedId,
      );

  IsFavoriteProvider._internal(
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
    FutureOr<bool> Function(IsFavoriteRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsFavoriteProvider._internal(
        (ref) => create(ref as IsFavoriteRef),
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
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _IsFavoriteProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsFavoriteProvider && other.feedId == feedId;
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
mixin IsFavoriteRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `feedId` of this provider.
  String get feedId;
}

class _IsFavoriteProviderElement extends AutoDisposeFutureProviderElement<bool>
    with IsFavoriteRef {
  _IsFavoriteProviderElement(super.provider);

  @override
  String get feedId => (origin as IsFavoriteProvider).feedId;
}

String _$localFavoritesHash() => r'e86dcf3e3f710a004ef162af7f486e26a2823931';

/// 本地收藏列表 Provider
///
/// Copied from [LocalFavorites].
@ProviderFor(LocalFavorites)
final localFavoritesProvider =
    AutoDisposeAsyncNotifierProvider<
      LocalFavorites,
      List<LocalFavorite>
    >.internal(
      LocalFavorites.new,
      name: r'localFavoritesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$localFavoritesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$LocalFavorites = AutoDisposeAsyncNotifier<List<LocalFavorite>>;
String _$browseHistoriesHash() => r'1233eacf3776e62154489c851648a62457fc1e35';

/// 浏览历史列表 Provider
///
/// Copied from [BrowseHistories].
@ProviderFor(BrowseHistories)
final browseHistoriesProvider =
    AutoDisposeAsyncNotifierProvider<
      BrowseHistories,
      List<BrowseHistory>
    >.internal(
      BrowseHistories.new,
      name: r'browseHistoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$browseHistoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BrowseHistories = AutoDisposeAsyncNotifier<List<BrowseHistory>>;
String _$frequentlyVisitedListHash() =>
    r'9af466d4eef33f60a83ff4c82ce8c766c64b4c1d';

/// 我常去列表 Provider
///
/// Copied from [FrequentlyVisitedList].
@ProviderFor(FrequentlyVisitedList)
final frequentlyVisitedListProvider =
    AutoDisposeAsyncNotifierProvider<
      FrequentlyVisitedList,
      List<FrequentlyVisited>
    >.internal(
      FrequentlyVisitedList.new,
      name: r'frequentlyVisitedListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$frequentlyVisitedListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FrequentlyVisitedList =
    AutoDisposeAsyncNotifier<List<FrequentlyVisited>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
