// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LocalFavorite _$LocalFavoriteFromJson(Map<String, dynamic> json) {
  return _LocalFavorite.fromJson(json);
}

/// @nodoc
mixin _$LocalFavorite {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get feedId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get uid => throw _privateConstructorUsedError;
  @HiveField(3)
  String get username => throw _privateConstructorUsedError;
  @HiveField(4)
  String get avatarUrl => throw _privateConstructorUsedError;
  @HiveField(5)
  String get deviceTitle => throw _privateConstructorUsedError;
  @HiveField(6)
  String get message => throw _privateConstructorUsedError;
  @HiveField(7)
  String get dateline => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this LocalFavorite to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocalFavorite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocalFavoriteCopyWith<LocalFavorite> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocalFavoriteCopyWith<$Res> {
  factory $LocalFavoriteCopyWith(
    LocalFavorite value,
    $Res Function(LocalFavorite) then,
  ) = _$LocalFavoriteCopyWithImpl<$Res, LocalFavorite>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String feedId,
    @HiveField(2) String uid,
    @HiveField(3) String username,
    @HiveField(4) String avatarUrl,
    @HiveField(5) String deviceTitle,
    @HiveField(6) String message,
    @HiveField(7) String dateline,
    @HiveField(8) DateTime createdAt,
  });
}

/// @nodoc
class _$LocalFavoriteCopyWithImpl<$Res, $Val extends LocalFavorite>
    implements $LocalFavoriteCopyWith<$Res> {
  _$LocalFavoriteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocalFavorite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? feedId = null,
    Object? uid = null,
    Object? username = null,
    Object? avatarUrl = null,
    Object? deviceTitle = null,
    Object? message = null,
    Object? dateline = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            feedId: null == feedId
                ? _value.feedId
                : feedId // ignore: cast_nullable_to_non_nullable
                      as String,
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: null == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceTitle: null == deviceTitle
                ? _value.deviceTitle
                : deviceTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            dateline: null == dateline
                ? _value.dateline
                : dateline // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LocalFavoriteImplCopyWith<$Res>
    implements $LocalFavoriteCopyWith<$Res> {
  factory _$$LocalFavoriteImplCopyWith(
    _$LocalFavoriteImpl value,
    $Res Function(_$LocalFavoriteImpl) then,
  ) = __$$LocalFavoriteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String feedId,
    @HiveField(2) String uid,
    @HiveField(3) String username,
    @HiveField(4) String avatarUrl,
    @HiveField(5) String deviceTitle,
    @HiveField(6) String message,
    @HiveField(7) String dateline,
    @HiveField(8) DateTime createdAt,
  });
}

/// @nodoc
class __$$LocalFavoriteImplCopyWithImpl<$Res>
    extends _$LocalFavoriteCopyWithImpl<$Res, _$LocalFavoriteImpl>
    implements _$$LocalFavoriteImplCopyWith<$Res> {
  __$$LocalFavoriteImplCopyWithImpl(
    _$LocalFavoriteImpl _value,
    $Res Function(_$LocalFavoriteImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LocalFavorite
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? feedId = null,
    Object? uid = null,
    Object? username = null,
    Object? avatarUrl = null,
    Object? deviceTitle = null,
    Object? message = null,
    Object? dateline = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$LocalFavoriteImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        feedId: null == feedId
            ? _value.feedId
            : feedId // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceTitle: null == deviceTitle
            ? _value.deviceTitle
            : deviceTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        dateline: null == dateline
            ? _value.dateline
            : dateline // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LocalFavoriteImpl implements _LocalFavorite {
  const _$LocalFavoriteImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.feedId,
    @HiveField(2) required this.uid,
    @HiveField(3) required this.username,
    @HiveField(4) required this.avatarUrl,
    @HiveField(5) required this.deviceTitle,
    @HiveField(6) required this.message,
    @HiveField(7) required this.dateline,
    @HiveField(8) required this.createdAt,
  });

  factory _$LocalFavoriteImpl.fromJson(Map<String, dynamic> json) =>
      _$$LocalFavoriteImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String feedId;
  @override
  @HiveField(2)
  final String uid;
  @override
  @HiveField(3)
  final String username;
  @override
  @HiveField(4)
  final String avatarUrl;
  @override
  @HiveField(5)
  final String deviceTitle;
  @override
  @HiveField(6)
  final String message;
  @override
  @HiveField(7)
  final String dateline;
  @override
  @HiveField(8)
  final DateTime createdAt;

  @override
  String toString() {
    return 'LocalFavorite(id: $id, feedId: $feedId, uid: $uid, username: $username, avatarUrl: $avatarUrl, deviceTitle: $deviceTitle, message: $message, dateline: $dateline, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocalFavoriteImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.deviceTitle, deviceTitle) ||
                other.deviceTitle == deviceTitle) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    feedId,
    uid,
    username,
    avatarUrl,
    deviceTitle,
    message,
    dateline,
    createdAt,
  );

  /// Create a copy of LocalFavorite
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocalFavoriteImplCopyWith<_$LocalFavoriteImpl> get copyWith =>
      __$$LocalFavoriteImplCopyWithImpl<_$LocalFavoriteImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocalFavoriteImplToJson(this);
  }
}

abstract class _LocalFavorite implements LocalFavorite {
  const factory _LocalFavorite({
    @HiveField(0) required final String id,
    @HiveField(1) required final String feedId,
    @HiveField(2) required final String uid,
    @HiveField(3) required final String username,
    @HiveField(4) required final String avatarUrl,
    @HiveField(5) required final String deviceTitle,
    @HiveField(6) required final String message,
    @HiveField(7) required final String dateline,
    @HiveField(8) required final DateTime createdAt,
  }) = _$LocalFavoriteImpl;

  factory _LocalFavorite.fromJson(Map<String, dynamic> json) =
      _$LocalFavoriteImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get feedId;
  @override
  @HiveField(2)
  String get uid;
  @override
  @HiveField(3)
  String get username;
  @override
  @HiveField(4)
  String get avatarUrl;
  @override
  @HiveField(5)
  String get deviceTitle;
  @override
  @HiveField(6)
  String get message;
  @override
  @HiveField(7)
  String get dateline;
  @override
  @HiveField(8)
  DateTime get createdAt;

  /// Create a copy of LocalFavorite
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocalFavoriteImplCopyWith<_$LocalFavoriteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BrowseHistory _$BrowseHistoryFromJson(Map<String, dynamic> json) {
  return _BrowseHistory.fromJson(json);
}

/// @nodoc
mixin _$BrowseHistory {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get feedId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get uid => throw _privateConstructorUsedError;
  @HiveField(3)
  String get username => throw _privateConstructorUsedError;
  @HiveField(4)
  String get avatarUrl => throw _privateConstructorUsedError;
  @HiveField(5)
  String get deviceTitle => throw _privateConstructorUsedError;
  @HiveField(6)
  String get message => throw _privateConstructorUsedError;
  @HiveField(7)
  String get dateline => throw _privateConstructorUsedError;
  @HiveField(8)
  DateTime get viewedAt => throw _privateConstructorUsedError;

  /// Serializes this BrowseHistory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BrowseHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BrowseHistoryCopyWith<BrowseHistory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BrowseHistoryCopyWith<$Res> {
  factory $BrowseHistoryCopyWith(
    BrowseHistory value,
    $Res Function(BrowseHistory) then,
  ) = _$BrowseHistoryCopyWithImpl<$Res, BrowseHistory>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String feedId,
    @HiveField(2) String uid,
    @HiveField(3) String username,
    @HiveField(4) String avatarUrl,
    @HiveField(5) String deviceTitle,
    @HiveField(6) String message,
    @HiveField(7) String dateline,
    @HiveField(8) DateTime viewedAt,
  });
}

/// @nodoc
class _$BrowseHistoryCopyWithImpl<$Res, $Val extends BrowseHistory>
    implements $BrowseHistoryCopyWith<$Res> {
  _$BrowseHistoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BrowseHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? feedId = null,
    Object? uid = null,
    Object? username = null,
    Object? avatarUrl = null,
    Object? deviceTitle = null,
    Object? message = null,
    Object? dateline = null,
    Object? viewedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            feedId: null == feedId
                ? _value.feedId
                : feedId // ignore: cast_nullable_to_non_nullable
                      as String,
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: null == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceTitle: null == deviceTitle
                ? _value.deviceTitle
                : deviceTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            dateline: null == dateline
                ? _value.dateline
                : dateline // ignore: cast_nullable_to_non_nullable
                      as String,
            viewedAt: null == viewedAt
                ? _value.viewedAt
                : viewedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BrowseHistoryImplCopyWith<$Res>
    implements $BrowseHistoryCopyWith<$Res> {
  factory _$$BrowseHistoryImplCopyWith(
    _$BrowseHistoryImpl value,
    $Res Function(_$BrowseHistoryImpl) then,
  ) = __$$BrowseHistoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String feedId,
    @HiveField(2) String uid,
    @HiveField(3) String username,
    @HiveField(4) String avatarUrl,
    @HiveField(5) String deviceTitle,
    @HiveField(6) String message,
    @HiveField(7) String dateline,
    @HiveField(8) DateTime viewedAt,
  });
}

/// @nodoc
class __$$BrowseHistoryImplCopyWithImpl<$Res>
    extends _$BrowseHistoryCopyWithImpl<$Res, _$BrowseHistoryImpl>
    implements _$$BrowseHistoryImplCopyWith<$Res> {
  __$$BrowseHistoryImplCopyWithImpl(
    _$BrowseHistoryImpl _value,
    $Res Function(_$BrowseHistoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BrowseHistory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? feedId = null,
    Object? uid = null,
    Object? username = null,
    Object? avatarUrl = null,
    Object? deviceTitle = null,
    Object? message = null,
    Object? dateline = null,
    Object? viewedAt = null,
  }) {
    return _then(
      _$BrowseHistoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        feedId: null == feedId
            ? _value.feedId
            : feedId // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: null == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceTitle: null == deviceTitle
            ? _value.deviceTitle
            : deviceTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        dateline: null == dateline
            ? _value.dateline
            : dateline // ignore: cast_nullable_to_non_nullable
                  as String,
        viewedAt: null == viewedAt
            ? _value.viewedAt
            : viewedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BrowseHistoryImpl implements _BrowseHistory {
  const _$BrowseHistoryImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.feedId,
    @HiveField(2) required this.uid,
    @HiveField(3) required this.username,
    @HiveField(4) required this.avatarUrl,
    @HiveField(5) required this.deviceTitle,
    @HiveField(6) required this.message,
    @HiveField(7) required this.dateline,
    @HiveField(8) required this.viewedAt,
  });

  factory _$BrowseHistoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$BrowseHistoryImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String feedId;
  @override
  @HiveField(2)
  final String uid;
  @override
  @HiveField(3)
  final String username;
  @override
  @HiveField(4)
  final String avatarUrl;
  @override
  @HiveField(5)
  final String deviceTitle;
  @override
  @HiveField(6)
  final String message;
  @override
  @HiveField(7)
  final String dateline;
  @override
  @HiveField(8)
  final DateTime viewedAt;

  @override
  String toString() {
    return 'BrowseHistory(id: $id, feedId: $feedId, uid: $uid, username: $username, avatarUrl: $avatarUrl, deviceTitle: $deviceTitle, message: $message, dateline: $dateline, viewedAt: $viewedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BrowseHistoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.feedId, feedId) || other.feedId == feedId) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.deviceTitle, deviceTitle) ||
                other.deviceTitle == deviceTitle) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.viewedAt, viewedAt) ||
                other.viewedAt == viewedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    feedId,
    uid,
    username,
    avatarUrl,
    deviceTitle,
    message,
    dateline,
    viewedAt,
  );

  /// Create a copy of BrowseHistory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BrowseHistoryImplCopyWith<_$BrowseHistoryImpl> get copyWith =>
      __$$BrowseHistoryImplCopyWithImpl<_$BrowseHistoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BrowseHistoryImplToJson(this);
  }
}

abstract class _BrowseHistory implements BrowseHistory {
  const factory _BrowseHistory({
    @HiveField(0) required final String id,
    @HiveField(1) required final String feedId,
    @HiveField(2) required final String uid,
    @HiveField(3) required final String username,
    @HiveField(4) required final String avatarUrl,
    @HiveField(5) required final String deviceTitle,
    @HiveField(6) required final String message,
    @HiveField(7) required final String dateline,
    @HiveField(8) required final DateTime viewedAt,
  }) = _$BrowseHistoryImpl;

  factory _BrowseHistory.fromJson(Map<String, dynamic> json) =
      _$BrowseHistoryImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get feedId;
  @override
  @HiveField(2)
  String get uid;
  @override
  @HiveField(3)
  String get username;
  @override
  @HiveField(4)
  String get avatarUrl;
  @override
  @HiveField(5)
  String get deviceTitle;
  @override
  @HiveField(6)
  String get message;
  @override
  @HiveField(7)
  String get dateline;
  @override
  @HiveField(8)
  DateTime get viewedAt;

  /// Create a copy of BrowseHistory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BrowseHistoryImplCopyWith<_$BrowseHistoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FrequentlyVisited _$FrequentlyVisitedFromJson(Map<String, dynamic> json) {
  return _FrequentlyVisited.fromJson(json);
}

/// @nodoc
mixin _$FrequentlyVisited {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  String get topicId => throw _privateConstructorUsedError;
  @HiveField(2)
  String get topicName => throw _privateConstructorUsedError;
  @HiveField(3)
  String? get topicTag => throw _privateConstructorUsedError;
  @HiveField(4)
  int get visitCount => throw _privateConstructorUsedError;
  @HiveField(5)
  DateTime get lastVisitedAt => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get coverUrl => throw _privateConstructorUsedError;

  /// Serializes this FrequentlyVisited to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FrequentlyVisited
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FrequentlyVisitedCopyWith<FrequentlyVisited> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrequentlyVisitedCopyWith<$Res> {
  factory $FrequentlyVisitedCopyWith(
    FrequentlyVisited value,
    $Res Function(FrequentlyVisited) then,
  ) = _$FrequentlyVisitedCopyWithImpl<$Res, FrequentlyVisited>;
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String topicId,
    @HiveField(2) String topicName,
    @HiveField(3) String? topicTag,
    @HiveField(4) int visitCount,
    @HiveField(5) DateTime lastVisitedAt,
    @HiveField(6) String? coverUrl,
  });
}

/// @nodoc
class _$FrequentlyVisitedCopyWithImpl<$Res, $Val extends FrequentlyVisited>
    implements $FrequentlyVisitedCopyWith<$Res> {
  _$FrequentlyVisitedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FrequentlyVisited
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = null,
    Object? topicName = null,
    Object? topicTag = freezed,
    Object? visitCount = null,
    Object? lastVisitedAt = null,
    Object? coverUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            topicId: null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as String,
            topicName: null == topicName
                ? _value.topicName
                : topicName // ignore: cast_nullable_to_non_nullable
                      as String,
            topicTag: freezed == topicTag
                ? _value.topicTag
                : topicTag // ignore: cast_nullable_to_non_nullable
                      as String?,
            visitCount: null == visitCount
                ? _value.visitCount
                : visitCount // ignore: cast_nullable_to_non_nullable
                      as int,
            lastVisitedAt: null == lastVisitedAt
                ? _value.lastVisitedAt
                : lastVisitedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            coverUrl: freezed == coverUrl
                ? _value.coverUrl
                : coverUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FrequentlyVisitedImplCopyWith<$Res>
    implements $FrequentlyVisitedCopyWith<$Res> {
  factory _$$FrequentlyVisitedImplCopyWith(
    _$FrequentlyVisitedImpl value,
    $Res Function(_$FrequentlyVisitedImpl) then,
  ) = __$$FrequentlyVisitedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @HiveField(0) String id,
    @HiveField(1) String topicId,
    @HiveField(2) String topicName,
    @HiveField(3) String? topicTag,
    @HiveField(4) int visitCount,
    @HiveField(5) DateTime lastVisitedAt,
    @HiveField(6) String? coverUrl,
  });
}

/// @nodoc
class __$$FrequentlyVisitedImplCopyWithImpl<$Res>
    extends _$FrequentlyVisitedCopyWithImpl<$Res, _$FrequentlyVisitedImpl>
    implements _$$FrequentlyVisitedImplCopyWith<$Res> {
  __$$FrequentlyVisitedImplCopyWithImpl(
    _$FrequentlyVisitedImpl _value,
    $Res Function(_$FrequentlyVisitedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FrequentlyVisited
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = null,
    Object? topicName = null,
    Object? topicTag = freezed,
    Object? visitCount = null,
    Object? lastVisitedAt = null,
    Object? coverUrl = freezed,
  }) {
    return _then(
      _$FrequentlyVisitedImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        topicId: null == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as String,
        topicName: null == topicName
            ? _value.topicName
            : topicName // ignore: cast_nullable_to_non_nullable
                  as String,
        topicTag: freezed == topicTag
            ? _value.topicTag
            : topicTag // ignore: cast_nullable_to_non_nullable
                  as String?,
        visitCount: null == visitCount
            ? _value.visitCount
            : visitCount // ignore: cast_nullable_to_non_nullable
                  as int,
        lastVisitedAt: null == lastVisitedAt
            ? _value.lastVisitedAt
            : lastVisitedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        coverUrl: freezed == coverUrl
            ? _value.coverUrl
            : coverUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FrequentlyVisitedImpl implements _FrequentlyVisited {
  const _$FrequentlyVisitedImpl({
    @HiveField(0) required this.id,
    @HiveField(1) required this.topicId,
    @HiveField(2) required this.topicName,
    @HiveField(3) this.topicTag,
    @HiveField(4) required this.visitCount,
    @HiveField(5) required this.lastVisitedAt,
    @HiveField(6) this.coverUrl,
  });

  factory _$FrequentlyVisitedImpl.fromJson(Map<String, dynamic> json) =>
      _$$FrequentlyVisitedImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String topicId;
  @override
  @HiveField(2)
  final String topicName;
  @override
  @HiveField(3)
  final String? topicTag;
  @override
  @HiveField(4)
  final int visitCount;
  @override
  @HiveField(5)
  final DateTime lastVisitedAt;
  @override
  @HiveField(6)
  final String? coverUrl;

  @override
  String toString() {
    return 'FrequentlyVisited(id: $id, topicId: $topicId, topicName: $topicName, topicTag: $topicTag, visitCount: $visitCount, lastVisitedAt: $lastVisitedAt, coverUrl: $coverUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FrequentlyVisitedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.topicName, topicName) ||
                other.topicName == topicName) &&
            (identical(other.topicTag, topicTag) ||
                other.topicTag == topicTag) &&
            (identical(other.visitCount, visitCount) ||
                other.visitCount == visitCount) &&
            (identical(other.lastVisitedAt, lastVisitedAt) ||
                other.lastVisitedAt == lastVisitedAt) &&
            (identical(other.coverUrl, coverUrl) ||
                other.coverUrl == coverUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    topicId,
    topicName,
    topicTag,
    visitCount,
    lastVisitedAt,
    coverUrl,
  );

  /// Create a copy of FrequentlyVisited
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FrequentlyVisitedImplCopyWith<_$FrequentlyVisitedImpl> get copyWith =>
      __$$FrequentlyVisitedImplCopyWithImpl<_$FrequentlyVisitedImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FrequentlyVisitedImplToJson(this);
  }
}

abstract class _FrequentlyVisited implements FrequentlyVisited {
  const factory _FrequentlyVisited({
    @HiveField(0) required final String id,
    @HiveField(1) required final String topicId,
    @HiveField(2) required final String topicName,
    @HiveField(3) final String? topicTag,
    @HiveField(4) required final int visitCount,
    @HiveField(5) required final DateTime lastVisitedAt,
    @HiveField(6) final String? coverUrl,
  }) = _$FrequentlyVisitedImpl;

  factory _FrequentlyVisited.fromJson(Map<String, dynamic> json) =
      _$FrequentlyVisitedImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  String get topicId;
  @override
  @HiveField(2)
  String get topicName;
  @override
  @HiveField(3)
  String? get topicTag;
  @override
  @HiveField(4)
  int get visitCount;
  @override
  @HiveField(5)
  DateTime get lastVisitedAt;
  @override
  @HiveField(6)
  String? get coverUrl;

  /// Create a copy of FrequentlyVisited
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FrequentlyVisitedImplCopyWith<_$FrequentlyVisitedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
