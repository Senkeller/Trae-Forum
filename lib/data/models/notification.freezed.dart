// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) {
  return _NotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<NotificationData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;

  /// Serializes this NotificationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationResponseCopyWith<NotificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationResponseCopyWith<$Res> {
  factory $NotificationResponseCopyWith(
    NotificationResponse value,
    $Res Function(NotificationResponse) then,
  ) = _$NotificationResponseCopyWithImpl<$Res, NotificationResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<NotificationData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'unread_count') int unreadCount,
  });
}

/// @nodoc
class _$NotificationResponseCopyWithImpl<
  $Res,
  $Val extends NotificationResponse
>
    implements $NotificationResponseCopyWith<$Res> {
  _$NotificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? unreadCount = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<NotificationData>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationResponseImplCopyWith<$Res>
    implements $NotificationResponseCopyWith<$Res> {
  factory _$$NotificationResponseImplCopyWith(
    _$NotificationResponseImpl value,
    $Res Function(_$NotificationResponseImpl) then,
  ) = __$$NotificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<NotificationData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'unread_count') int unreadCount,
  });
}

/// @nodoc
class __$$NotificationResponseImplCopyWithImpl<$Res>
    extends _$NotificationResponseCopyWithImpl<$Res, _$NotificationResponseImpl>
    implements _$$NotificationResponseImplCopyWith<$Res> {
  __$$NotificationResponseImplCopyWithImpl(
    _$NotificationResponseImpl _value,
    $Res Function(_$NotificationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? unreadCount = null,
  }) {
    return _then(
      _$NotificationResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<NotificationData>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationResponseImpl implements _NotificationResponse {
  const _$NotificationResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<NotificationData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'page') this.page = 1,
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
  }) : _data = data;

  factory _$NotificationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<NotificationData> _data;
  @override
  @JsonKey(name: 'data')
  List<NotificationData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'total')
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;

  @override
  String toString() {
    return 'NotificationResponse(status: $status, message: $message, data: $data, total: $total, page: $page, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
    total,
    page,
    unreadCount,
  );

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationResponseImplCopyWith<_$NotificationResponseImpl>
  get copyWith =>
      __$$NotificationResponseImplCopyWithImpl<_$NotificationResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationResponseImplToJson(this);
  }
}

abstract class _NotificationResponse implements NotificationResponse {
  const factory _NotificationResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<NotificationData> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'page') final int page,
    @JsonKey(name: 'unread_count') final int unreadCount,
  }) = _$NotificationResponseImpl;

  factory _NotificationResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<NotificationData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationResponseImplCopyWith<_$NotificationResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return _NotificationData.fromJson(json);
}

/// @nodoc
mixin _$NotificationData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'uid')
  String? get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar')
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_id')
  String? get targetId => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_type')
  String? get targetType => throw _privateConstructorUsedError;
  @JsonKey(name: 'target_content')
  String? get targetContent => throw _privateConstructorUsedError;
  @JsonKey(name: 'dateline')
  String get dateline => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'extra')
  Map<String, dynamic> get extra => throw _privateConstructorUsedError;

  /// Serializes this NotificationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationDataCopyWith<NotificationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationDataCopyWith<$Res> {
  factory $NotificationDataCopyWith(
    NotificationData value,
    $Res Function(NotificationData) then,
  ) = _$NotificationDataCopyWithImpl<$Res, NotificationData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'type') String type,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'target_id') String? targetId,
    @JsonKey(name: 'target_type') String? targetType,
    @JsonKey(name: 'target_content') String? targetContent,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'extra') Map<String, dynamic> extra,
  });
}

/// @nodoc
class _$NotificationDataCopyWithImpl<$Res, $Val extends NotificationData>
    implements $NotificationDataCopyWith<$Res> {
  _$NotificationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = freezed,
    Object? username = null,
    Object? avatar = freezed,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? targetId = freezed,
    Object? targetType = freezed,
    Object? targetContent = freezed,
    Object? dateline = null,
    Object? isRead = null,
    Object? extra = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            uid: freezed == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String?,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            targetId: freezed == targetId
                ? _value.targetId
                : targetId // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetType: freezed == targetType
                ? _value.targetType
                : targetType // ignore: cast_nullable_to_non_nullable
                      as String?,
            targetContent: freezed == targetContent
                ? _value.targetContent
                : targetContent // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateline: null == dateline
                ? _value.dateline
                : dateline // ignore: cast_nullable_to_non_nullable
                      as String,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            extra: null == extra
                ? _value.extra
                : extra // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationDataImplCopyWith<$Res>
    implements $NotificationDataCopyWith<$Res> {
  factory _$$NotificationDataImplCopyWith(
    _$NotificationDataImpl value,
    $Res Function(_$NotificationDataImpl) then,
  ) = __$$NotificationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'type') String type,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'target_id') String? targetId,
    @JsonKey(name: 'target_type') String? targetType,
    @JsonKey(name: 'target_content') String? targetContent,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'extra') Map<String, dynamic> extra,
  });
}

/// @nodoc
class __$$NotificationDataImplCopyWithImpl<$Res>
    extends _$NotificationDataCopyWithImpl<$Res, _$NotificationDataImpl>
    implements _$$NotificationDataImplCopyWith<$Res> {
  __$$NotificationDataImplCopyWithImpl(
    _$NotificationDataImpl _value,
    $Res Function(_$NotificationDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = freezed,
    Object? username = null,
    Object? avatar = freezed,
    Object? type = null,
    Object? title = null,
    Object? message = null,
    Object? targetId = freezed,
    Object? targetType = freezed,
    Object? targetContent = freezed,
    Object? dateline = null,
    Object? isRead = null,
    Object? extra = null,
  }) {
    return _then(
      _$NotificationDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: freezed == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String?,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        targetId: freezed == targetId
            ? _value.targetId
            : targetId // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetType: freezed == targetType
            ? _value.targetType
            : targetType // ignore: cast_nullable_to_non_nullable
                  as String?,
        targetContent: freezed == targetContent
            ? _value.targetContent
            : targetContent // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateline: null == dateline
            ? _value.dateline
            : dateline // ignore: cast_nullable_to_non_nullable
                  as String,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        extra: null == extra
            ? _value._extra
            : extra // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationDataImpl implements _NotificationData {
  const _$NotificationDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'uid') this.uid,
    @JsonKey(name: 'username') this.username = '',
    @JsonKey(name: 'avatar') this.avatar,
    @JsonKey(name: 'type') required this.type,
    @JsonKey(name: 'title') this.title = '',
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'target_id') this.targetId,
    @JsonKey(name: 'target_type') this.targetType,
    @JsonKey(name: 'target_content') this.targetContent,
    @JsonKey(name: 'dateline') this.dateline = '',
    @JsonKey(name: 'is_read') this.isRead = false,
    @JsonKey(name: 'extra') final Map<String, dynamic> extra = const {},
  }) : _extra = extra;

  factory _$NotificationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationDataImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'uid')
  final String? uid;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'avatar')
  final String? avatar;
  @override
  @JsonKey(name: 'type')
  final String type;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'target_id')
  final String? targetId;
  @override
  @JsonKey(name: 'target_type')
  final String? targetType;
  @override
  @JsonKey(name: 'target_content')
  final String? targetContent;
  @override
  @JsonKey(name: 'dateline')
  final String dateline;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;
  final Map<String, dynamic> _extra;
  @override
  @JsonKey(name: 'extra')
  Map<String, dynamic> get extra {
    if (_extra is EqualUnmodifiableMapView) return _extra;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_extra);
  }

  @override
  String toString() {
    return 'NotificationData(id: $id, uid: $uid, username: $username, avatar: $avatar, type: $type, title: $title, message: $message, targetId: $targetId, targetType: $targetType, targetContent: $targetContent, dateline: $dateline, isRead: $isRead, extra: $extra)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.targetType, targetType) ||
                other.targetType == targetType) &&
            (identical(other.targetContent, targetContent) ||
                other.targetContent == targetContent) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            const DeepCollectionEquality().equals(other._extra, _extra));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    uid,
    username,
    avatar,
    type,
    title,
    message,
    targetId,
    targetType,
    targetContent,
    dateline,
    isRead,
    const DeepCollectionEquality().hash(_extra),
  );

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      __$$NotificationDataImplCopyWithImpl<_$NotificationDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationDataImplToJson(this);
  }
}

abstract class _NotificationData implements NotificationData {
  const factory _NotificationData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'uid') final String? uid,
    @JsonKey(name: 'username') final String username,
    @JsonKey(name: 'avatar') final String? avatar,
    @JsonKey(name: 'type') required final String type,
    @JsonKey(name: 'title') final String title,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'target_id') final String? targetId,
    @JsonKey(name: 'target_type') final String? targetType,
    @JsonKey(name: 'target_content') final String? targetContent,
    @JsonKey(name: 'dateline') final String dateline,
    @JsonKey(name: 'is_read') final bool isRead,
    @JsonKey(name: 'extra') final Map<String, dynamic> extra,
  }) = _$NotificationDataImpl;

  factory _NotificationData.fromJson(Map<String, dynamic> json) =
      _$NotificationDataImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'uid')
  String? get uid;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'avatar')
  String? get avatar;
  @override
  @JsonKey(name: 'type')
  String get type;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'target_id')
  String? get targetId;
  @override
  @JsonKey(name: 'target_type')
  String? get targetType;
  @override
  @JsonKey(name: 'target_content')
  String? get targetContent;
  @override
  @JsonKey(name: 'dateline')
  String get dateline;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'extra')
  Map<String, dynamic> get extra;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NotificationStatsResponse _$NotificationStatsResponseFromJson(
  Map<String, dynamic> json,
) {
  return _NotificationStatsResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationStatsResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_unread')
  int get totalUnread => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_count')
  int get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'comment_count')
  int get commentCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'follow_count')
  int get followCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'system_count')
  int get systemCount => throw _privateConstructorUsedError;

  /// Serializes this NotificationStatsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationStatsResponseCopyWith<NotificationStatsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationStatsResponseCopyWith<$Res> {
  factory $NotificationStatsResponseCopyWith(
    NotificationStatsResponse value,
    $Res Function(NotificationStatsResponse) then,
  ) = _$NotificationStatsResponseCopyWithImpl<$Res, NotificationStatsResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'total_unread') int totalUnread,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'comment_count') int commentCount,
    @JsonKey(name: 'follow_count') int followCount,
    @JsonKey(name: 'system_count') int systemCount,
  });
}

/// @nodoc
class _$NotificationStatsResponseCopyWithImpl<
  $Res,
  $Val extends NotificationStatsResponse
>
    implements $NotificationStatsResponseCopyWith<$Res> {
  _$NotificationStatsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? totalUnread = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? followCount = null,
    Object? systemCount = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            totalUnread: null == totalUnread
                ? _value.totalUnread
                : totalUnread // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            followCount: null == followCount
                ? _value.followCount
                : followCount // ignore: cast_nullable_to_non_nullable
                      as int,
            systemCount: null == systemCount
                ? _value.systemCount
                : systemCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NotificationStatsResponseImplCopyWith<$Res>
    implements $NotificationStatsResponseCopyWith<$Res> {
  factory _$$NotificationStatsResponseImplCopyWith(
    _$NotificationStatsResponseImpl value,
    $Res Function(_$NotificationStatsResponseImpl) then,
  ) = __$$NotificationStatsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'total_unread') int totalUnread,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'comment_count') int commentCount,
    @JsonKey(name: 'follow_count') int followCount,
    @JsonKey(name: 'system_count') int systemCount,
  });
}

/// @nodoc
class __$$NotificationStatsResponseImplCopyWithImpl<$Res>
    extends
        _$NotificationStatsResponseCopyWithImpl<
          $Res,
          _$NotificationStatsResponseImpl
        >
    implements _$$NotificationStatsResponseImplCopyWith<$Res> {
  __$$NotificationStatsResponseImplCopyWithImpl(
    _$NotificationStatsResponseImpl _value,
    $Res Function(_$NotificationStatsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? totalUnread = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? followCount = null,
    Object? systemCount = null,
  }) {
    return _then(
      _$NotificationStatsResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        totalUnread: null == totalUnread
            ? _value.totalUnread
            : totalUnread // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        followCount: null == followCount
            ? _value.followCount
            : followCount // ignore: cast_nullable_to_non_nullable
                  as int,
        systemCount: null == systemCount
            ? _value.systemCount
            : systemCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationStatsResponseImpl implements _NotificationStatsResponse {
  const _$NotificationStatsResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'total_unread') this.totalUnread = 0,
    @JsonKey(name: 'like_count') this.likeCount = 0,
    @JsonKey(name: 'comment_count') this.commentCount = 0,
    @JsonKey(name: 'follow_count') this.followCount = 0,
    @JsonKey(name: 'system_count') this.systemCount = 0,
  });

  factory _$NotificationStatsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationStatsResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'total_unread')
  final int totalUnread;
  @override
  @JsonKey(name: 'like_count')
  final int likeCount;
  @override
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @override
  @JsonKey(name: 'follow_count')
  final int followCount;
  @override
  @JsonKey(name: 'system_count')
  final int systemCount;

  @override
  String toString() {
    return 'NotificationStatsResponse(status: $status, message: $message, totalUnread: $totalUnread, likeCount: $likeCount, commentCount: $commentCount, followCount: $followCount, systemCount: $systemCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationStatsResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.totalUnread, totalUnread) ||
                other.totalUnread == totalUnread) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.followCount, followCount) ||
                other.followCount == followCount) &&
            (identical(other.systemCount, systemCount) ||
                other.systemCount == systemCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    totalUnread,
    likeCount,
    commentCount,
    followCount,
    systemCount,
  );

  /// Create a copy of NotificationStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationStatsResponseImplCopyWith<_$NotificationStatsResponseImpl>
  get copyWith =>
      __$$NotificationStatsResponseImplCopyWithImpl<
        _$NotificationStatsResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationStatsResponseImplToJson(this);
  }
}

abstract class _NotificationStatsResponse implements NotificationStatsResponse {
  const factory _NotificationStatsResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'total_unread') final int totalUnread,
    @JsonKey(name: 'like_count') final int likeCount,
    @JsonKey(name: 'comment_count') final int commentCount,
    @JsonKey(name: 'follow_count') final int followCount,
    @JsonKey(name: 'system_count') final int systemCount,
  }) = _$NotificationStatsResponseImpl;

  factory _NotificationStatsResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationStatsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'total_unread')
  int get totalUnread;
  @override
  @JsonKey(name: 'like_count')
  int get likeCount;
  @override
  @JsonKey(name: 'comment_count')
  int get commentCount;
  @override
  @JsonKey(name: 'follow_count')
  int get followCount;
  @override
  @JsonKey(name: 'system_count')
  int get systemCount;

  /// Create a copy of NotificationStatsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationStatsResponseImplCopyWith<_$NotificationStatsResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MarkNotificationReadRequest _$MarkNotificationReadRequestFromJson(
  Map<String, dynamic> json,
) {
  return _MarkNotificationReadRequest.fromJson(json);
}

/// @nodoc
mixin _$MarkNotificationReadRequest {
  @JsonKey(name: 'notification_ids')
  List<String> get notificationIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;

  /// Serializes this MarkNotificationReadRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkNotificationReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkNotificationReadRequestCopyWith<MarkNotificationReadRequest>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkNotificationReadRequestCopyWith<$Res> {
  factory $MarkNotificationReadRequestCopyWith(
    MarkNotificationReadRequest value,
    $Res Function(MarkNotificationReadRequest) then,
  ) =
      _$MarkNotificationReadRequestCopyWithImpl<
        $Res,
        MarkNotificationReadRequest
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'notification_ids') List<String> notificationIds,
    @JsonKey(name: 'type') String? type,
  });
}

/// @nodoc
class _$MarkNotificationReadRequestCopyWithImpl<
  $Res,
  $Val extends MarkNotificationReadRequest
>
    implements $MarkNotificationReadRequestCopyWith<$Res> {
  _$MarkNotificationReadRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkNotificationReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notificationIds = null, Object? type = freezed}) {
    return _then(
      _value.copyWith(
            notificationIds: null == notificationIds
                ? _value.notificationIds
                : notificationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            type: freezed == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarkNotificationReadRequestImplCopyWith<$Res>
    implements $MarkNotificationReadRequestCopyWith<$Res> {
  factory _$$MarkNotificationReadRequestImplCopyWith(
    _$MarkNotificationReadRequestImpl value,
    $Res Function(_$MarkNotificationReadRequestImpl) then,
  ) = __$$MarkNotificationReadRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'notification_ids') List<String> notificationIds,
    @JsonKey(name: 'type') String? type,
  });
}

/// @nodoc
class __$$MarkNotificationReadRequestImplCopyWithImpl<$Res>
    extends
        _$MarkNotificationReadRequestCopyWithImpl<
          $Res,
          _$MarkNotificationReadRequestImpl
        >
    implements _$$MarkNotificationReadRequestImplCopyWith<$Res> {
  __$$MarkNotificationReadRequestImplCopyWithImpl(
    _$MarkNotificationReadRequestImpl _value,
    $Res Function(_$MarkNotificationReadRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkNotificationReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notificationIds = null, Object? type = freezed}) {
    return _then(
      _$MarkNotificationReadRequestImpl(
        notificationIds: null == notificationIds
            ? _value._notificationIds
            : notificationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        type: freezed == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkNotificationReadRequestImpl
    implements _MarkNotificationReadRequest {
  const _$MarkNotificationReadRequestImpl({
    @JsonKey(name: 'notification_ids')
    final List<String> notificationIds = const [],
    @JsonKey(name: 'type') this.type,
  }) : _notificationIds = notificationIds;

  factory _$MarkNotificationReadRequestImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MarkNotificationReadRequestImplFromJson(json);

  final List<String> _notificationIds;
  @override
  @JsonKey(name: 'notification_ids')
  List<String> get notificationIds {
    if (_notificationIds is EqualUnmodifiableListView) return _notificationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationIds);
  }

  @override
  @JsonKey(name: 'type')
  final String? type;

  @override
  String toString() {
    return 'MarkNotificationReadRequest(notificationIds: $notificationIds, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkNotificationReadRequestImpl &&
            const DeepCollectionEquality().equals(
              other._notificationIds,
              _notificationIds,
            ) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_notificationIds),
    type,
  );

  /// Create a copy of MarkNotificationReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkNotificationReadRequestImplCopyWith<_$MarkNotificationReadRequestImpl>
  get copyWith =>
      __$$MarkNotificationReadRequestImplCopyWithImpl<
        _$MarkNotificationReadRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkNotificationReadRequestImplToJson(this);
  }
}

abstract class _MarkNotificationReadRequest
    implements MarkNotificationReadRequest {
  const factory _MarkNotificationReadRequest({
    @JsonKey(name: 'notification_ids') final List<String> notificationIds,
    @JsonKey(name: 'type') final String? type,
  }) = _$MarkNotificationReadRequestImpl;

  factory _MarkNotificationReadRequest.fromJson(Map<String, dynamic> json) =
      _$MarkNotificationReadRequestImpl.fromJson;

  @override
  @JsonKey(name: 'notification_ids')
  List<String> get notificationIds;
  @override
  @JsonKey(name: 'type')
  String? get type;

  /// Create a copy of MarkNotificationReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkNotificationReadRequestImplCopyWith<_$MarkNotificationReadRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MarkNotificationReadResponse _$MarkNotificationReadResponseFromJson(
  Map<String, dynamic> json,
) {
  return _MarkNotificationReadResponse.fromJson(json);
}

/// @nodoc
mixin _$MarkNotificationReadResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_count')
  int get updatedCount => throw _privateConstructorUsedError;

  /// Serializes this MarkNotificationReadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkNotificationReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkNotificationReadResponseCopyWith<MarkNotificationReadResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkNotificationReadResponseCopyWith<$Res> {
  factory $MarkNotificationReadResponseCopyWith(
    MarkNotificationReadResponse value,
    $Res Function(MarkNotificationReadResponse) then,
  ) =
      _$MarkNotificationReadResponseCopyWithImpl<
        $Res,
        MarkNotificationReadResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'updated_count') int updatedCount,
  });
}

/// @nodoc
class _$MarkNotificationReadResponseCopyWithImpl<
  $Res,
  $Val extends MarkNotificationReadResponse
>
    implements $MarkNotificationReadResponseCopyWith<$Res> {
  _$MarkNotificationReadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkNotificationReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? updatedCount = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedCount: null == updatedCount
                ? _value.updatedCount
                : updatedCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarkNotificationReadResponseImplCopyWith<$Res>
    implements $MarkNotificationReadResponseCopyWith<$Res> {
  factory _$$MarkNotificationReadResponseImplCopyWith(
    _$MarkNotificationReadResponseImpl value,
    $Res Function(_$MarkNotificationReadResponseImpl) then,
  ) = __$$MarkNotificationReadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'updated_count') int updatedCount,
  });
}

/// @nodoc
class __$$MarkNotificationReadResponseImplCopyWithImpl<$Res>
    extends
        _$MarkNotificationReadResponseCopyWithImpl<
          $Res,
          _$MarkNotificationReadResponseImpl
        >
    implements _$$MarkNotificationReadResponseImplCopyWith<$Res> {
  __$$MarkNotificationReadResponseImplCopyWithImpl(
    _$MarkNotificationReadResponseImpl _value,
    $Res Function(_$MarkNotificationReadResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkNotificationReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? updatedCount = null,
  }) {
    return _then(
      _$MarkNotificationReadResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedCount: null == updatedCount
            ? _value.updatedCount
            : updatedCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkNotificationReadResponseImpl
    implements _MarkNotificationReadResponse {
  const _$MarkNotificationReadResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'updated_count') this.updatedCount = 0,
  });

  factory _$MarkNotificationReadResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$MarkNotificationReadResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'updated_count')
  final int updatedCount;

  @override
  String toString() {
    return 'MarkNotificationReadResponse(status: $status, message: $message, updatedCount: $updatedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkNotificationReadResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.updatedCount, updatedCount) ||
                other.updatedCount == updatedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, updatedCount);

  /// Create a copy of MarkNotificationReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkNotificationReadResponseImplCopyWith<
    _$MarkNotificationReadResponseImpl
  >
  get copyWith =>
      __$$MarkNotificationReadResponseImplCopyWithImpl<
        _$MarkNotificationReadResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkNotificationReadResponseImplToJson(this);
  }
}

abstract class _MarkNotificationReadResponse
    implements MarkNotificationReadResponse {
  const factory _MarkNotificationReadResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'updated_count') final int updatedCount,
  }) = _$MarkNotificationReadResponseImpl;

  factory _MarkNotificationReadResponse.fromJson(Map<String, dynamic> json) =
      _$MarkNotificationReadResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'updated_count')
  int get updatedCount;

  /// Create a copy of MarkNotificationReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkNotificationReadResponseImplCopyWith<
    _$MarkNotificationReadResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DeleteNotificationRequest _$DeleteNotificationRequestFromJson(
  Map<String, dynamic> json,
) {
  return _DeleteNotificationRequest.fromJson(json);
}

/// @nodoc
mixin _$DeleteNotificationRequest {
  @JsonKey(name: 'notification_ids')
  List<String> get notificationIds => throw _privateConstructorUsedError;

  /// Serializes this DeleteNotificationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteNotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteNotificationRequestCopyWith<DeleteNotificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteNotificationRequestCopyWith<$Res> {
  factory $DeleteNotificationRequestCopyWith(
    DeleteNotificationRequest value,
    $Res Function(DeleteNotificationRequest) then,
  ) = _$DeleteNotificationRequestCopyWithImpl<$Res, DeleteNotificationRequest>;
  @useResult
  $Res call({@JsonKey(name: 'notification_ids') List<String> notificationIds});
}

/// @nodoc
class _$DeleteNotificationRequestCopyWithImpl<
  $Res,
  $Val extends DeleteNotificationRequest
>
    implements $DeleteNotificationRequestCopyWith<$Res> {
  _$DeleteNotificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteNotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notificationIds = null}) {
    return _then(
      _value.copyWith(
            notificationIds: null == notificationIds
                ? _value.notificationIds
                : notificationIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeleteNotificationRequestImplCopyWith<$Res>
    implements $DeleteNotificationRequestCopyWith<$Res> {
  factory _$$DeleteNotificationRequestImplCopyWith(
    _$DeleteNotificationRequestImpl value,
    $Res Function(_$DeleteNotificationRequestImpl) then,
  ) = __$$DeleteNotificationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'notification_ids') List<String> notificationIds});
}

/// @nodoc
class __$$DeleteNotificationRequestImplCopyWithImpl<$Res>
    extends
        _$DeleteNotificationRequestCopyWithImpl<
          $Res,
          _$DeleteNotificationRequestImpl
        >
    implements _$$DeleteNotificationRequestImplCopyWith<$Res> {
  __$$DeleteNotificationRequestImplCopyWithImpl(
    _$DeleteNotificationRequestImpl _value,
    $Res Function(_$DeleteNotificationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeleteNotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notificationIds = null}) {
    return _then(
      _$DeleteNotificationRequestImpl(
        notificationIds: null == notificationIds
            ? _value._notificationIds
            : notificationIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteNotificationRequestImpl implements _DeleteNotificationRequest {
  const _$DeleteNotificationRequestImpl({
    @JsonKey(name: 'notification_ids')
    required final List<String> notificationIds,
  }) : _notificationIds = notificationIds;

  factory _$DeleteNotificationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeleteNotificationRequestImplFromJson(json);

  final List<String> _notificationIds;
  @override
  @JsonKey(name: 'notification_ids')
  List<String> get notificationIds {
    if (_notificationIds is EqualUnmodifiableListView) return _notificationIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notificationIds);
  }

  @override
  String toString() {
    return 'DeleteNotificationRequest(notificationIds: $notificationIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteNotificationRequestImpl &&
            const DeepCollectionEquality().equals(
              other._notificationIds,
              _notificationIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_notificationIds),
  );

  /// Create a copy of DeleteNotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteNotificationRequestImplCopyWith<_$DeleteNotificationRequestImpl>
  get copyWith =>
      __$$DeleteNotificationRequestImplCopyWithImpl<
        _$DeleteNotificationRequestImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteNotificationRequestImplToJson(this);
  }
}

abstract class _DeleteNotificationRequest implements DeleteNotificationRequest {
  const factory _DeleteNotificationRequest({
    @JsonKey(name: 'notification_ids')
    required final List<String> notificationIds,
  }) = _$DeleteNotificationRequestImpl;

  factory _DeleteNotificationRequest.fromJson(Map<String, dynamic> json) =
      _$DeleteNotificationRequestImpl.fromJson;

  @override
  @JsonKey(name: 'notification_ids')
  List<String> get notificationIds;

  /// Create a copy of DeleteNotificationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteNotificationRequestImplCopyWith<_$DeleteNotificationRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DeleteNotificationResponse _$DeleteNotificationResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DeleteNotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$DeleteNotificationResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_count')
  int get deletedCount => throw _privateConstructorUsedError;

  /// Serializes this DeleteNotificationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeleteNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeleteNotificationResponseCopyWith<DeleteNotificationResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeleteNotificationResponseCopyWith<$Res> {
  factory $DeleteNotificationResponseCopyWith(
    DeleteNotificationResponse value,
    $Res Function(DeleteNotificationResponse) then,
  ) =
      _$DeleteNotificationResponseCopyWithImpl<
        $Res,
        DeleteNotificationResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'deleted_count') int deletedCount,
  });
}

/// @nodoc
class _$DeleteNotificationResponseCopyWithImpl<
  $Res,
  $Val extends DeleteNotificationResponse
>
    implements $DeleteNotificationResponseCopyWith<$Res> {
  _$DeleteNotificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeleteNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? deletedCount = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            deletedCount: null == deletedCount
                ? _value.deletedCount
                : deletedCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeleteNotificationResponseImplCopyWith<$Res>
    implements $DeleteNotificationResponseCopyWith<$Res> {
  factory _$$DeleteNotificationResponseImplCopyWith(
    _$DeleteNotificationResponseImpl value,
    $Res Function(_$DeleteNotificationResponseImpl) then,
  ) = __$$DeleteNotificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'deleted_count') int deletedCount,
  });
}

/// @nodoc
class __$$DeleteNotificationResponseImplCopyWithImpl<$Res>
    extends
        _$DeleteNotificationResponseCopyWithImpl<
          $Res,
          _$DeleteNotificationResponseImpl
        >
    implements _$$DeleteNotificationResponseImplCopyWith<$Res> {
  __$$DeleteNotificationResponseImplCopyWithImpl(
    _$DeleteNotificationResponseImpl _value,
    $Res Function(_$DeleteNotificationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeleteNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? deletedCount = null,
  }) {
    return _then(
      _$DeleteNotificationResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        deletedCount: null == deletedCount
            ? _value.deletedCount
            : deletedCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeleteNotificationResponseImpl implements _DeleteNotificationResponse {
  const _$DeleteNotificationResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'deleted_count') this.deletedCount = 0,
  });

  factory _$DeleteNotificationResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DeleteNotificationResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'deleted_count')
  final int deletedCount;

  @override
  String toString() {
    return 'DeleteNotificationResponse(status: $status, message: $message, deletedCount: $deletedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeleteNotificationResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.deletedCount, deletedCount) ||
                other.deletedCount == deletedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, deletedCount);

  /// Create a copy of DeleteNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeleteNotificationResponseImplCopyWith<_$DeleteNotificationResponseImpl>
  get copyWith =>
      __$$DeleteNotificationResponseImplCopyWithImpl<
        _$DeleteNotificationResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeleteNotificationResponseImplToJson(this);
  }
}

abstract class _DeleteNotificationResponse
    implements DeleteNotificationResponse {
  const factory _DeleteNotificationResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'deleted_count') final int deletedCount,
  }) = _$DeleteNotificationResponseImpl;

  factory _DeleteNotificationResponse.fromJson(Map<String, dynamic> json) =
      _$DeleteNotificationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'deleted_count')
  int get deletedCount;

  /// Create a copy of DeleteNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeleteNotificationResponseImplCopyWith<_$DeleteNotificationResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AnnouncementResponse _$AnnouncementResponseFromJson(Map<String, dynamic> json) {
  return _AnnouncementResponse.fromJson(json);
}

/// @nodoc
mixin _$AnnouncementResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<AnnouncementData> get data => throw _privateConstructorUsedError;

  /// Serializes this AnnouncementResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnnouncementResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnouncementResponseCopyWith<AnnouncementResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnouncementResponseCopyWith<$Res> {
  factory $AnnouncementResponseCopyWith(
    AnnouncementResponse value,
    $Res Function(AnnouncementResponse) then,
  ) = _$AnnouncementResponseCopyWithImpl<$Res, AnnouncementResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<AnnouncementData> data,
  });
}

/// @nodoc
class _$AnnouncementResponseCopyWithImpl<
  $Res,
  $Val extends AnnouncementResponse
>
    implements $AnnouncementResponseCopyWith<$Res> {
  _$AnnouncementResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnnouncementResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<AnnouncementData>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnnouncementResponseImplCopyWith<$Res>
    implements $AnnouncementResponseCopyWith<$Res> {
  factory _$$AnnouncementResponseImplCopyWith(
    _$AnnouncementResponseImpl value,
    $Res Function(_$AnnouncementResponseImpl) then,
  ) = __$$AnnouncementResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<AnnouncementData> data,
  });
}

/// @nodoc
class __$$AnnouncementResponseImplCopyWithImpl<$Res>
    extends _$AnnouncementResponseCopyWithImpl<$Res, _$AnnouncementResponseImpl>
    implements _$$AnnouncementResponseImplCopyWith<$Res> {
  __$$AnnouncementResponseImplCopyWithImpl(
    _$AnnouncementResponseImpl _value,
    $Res Function(_$AnnouncementResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnnouncementResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$AnnouncementResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<AnnouncementData>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnouncementResponseImpl implements _AnnouncementResponse {
  const _$AnnouncementResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<AnnouncementData> data = const [],
  }) : _data = data;

  factory _$AnnouncementResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnouncementResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<AnnouncementData> _data;
  @override
  @JsonKey(name: 'data')
  List<AnnouncementData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'AnnouncementResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnouncementResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of AnnouncementResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnouncementResponseImplCopyWith<_$AnnouncementResponseImpl>
  get copyWith =>
      __$$AnnouncementResponseImplCopyWithImpl<_$AnnouncementResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnouncementResponseImplToJson(this);
  }
}

abstract class _AnnouncementResponse implements AnnouncementResponse {
  const factory _AnnouncementResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<AnnouncementData> data,
  }) = _$AnnouncementResponseImpl;

  factory _AnnouncementResponse.fromJson(Map<String, dynamic> json) =
      _$AnnouncementResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<AnnouncementData> get data;

  /// Create a copy of AnnouncementResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnouncementResponseImplCopyWith<_$AnnouncementResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

AnnouncementData _$AnnouncementDataFromJson(Map<String, dynamic> json) {
  return _AnnouncementData.fromJson(json);
}

/// @nodoc
mixin _$AnnouncementData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover')
  String? get cover => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'dateline')
  String get dateline => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;

  /// Serializes this AnnouncementData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnnouncementDataCopyWith<AnnouncementData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnouncementDataCopyWith<$Res> {
  factory $AnnouncementDataCopyWith(
    AnnouncementData value,
    $Res Function(AnnouncementData) then,
  ) = _$AnnouncementDataCopyWithImpl<$Res, AnnouncementData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'content') String content,
    @JsonKey(name: 'cover') String? cover,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'is_read') bool isRead,
  });
}

/// @nodoc
class _$AnnouncementDataCopyWithImpl<$Res, $Val extends AnnouncementData>
    implements $AnnouncementDataCopyWith<$Res> {
  _$AnnouncementDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? cover = freezed,
    Object? url = freezed,
    Object? dateline = null,
    Object? isRead = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            cover: freezed == cover
                ? _value.cover
                : cover // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateline: null == dateline
                ? _value.dateline
                : dateline // ignore: cast_nullable_to_non_nullable
                      as String,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AnnouncementDataImplCopyWith<$Res>
    implements $AnnouncementDataCopyWith<$Res> {
  factory _$$AnnouncementDataImplCopyWith(
    _$AnnouncementDataImpl value,
    $Res Function(_$AnnouncementDataImpl) then,
  ) = __$$AnnouncementDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'content') String content,
    @JsonKey(name: 'cover') String? cover,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'is_read') bool isRead,
  });
}

/// @nodoc
class __$$AnnouncementDataImplCopyWithImpl<$Res>
    extends _$AnnouncementDataCopyWithImpl<$Res, _$AnnouncementDataImpl>
    implements _$$AnnouncementDataImplCopyWith<$Res> {
  __$$AnnouncementDataImplCopyWithImpl(
    _$AnnouncementDataImpl _value,
    $Res Function(_$AnnouncementDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? cover = freezed,
    Object? url = freezed,
    Object? dateline = null,
    Object? isRead = null,
  }) {
    return _then(
      _$AnnouncementDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        cover: freezed == cover
            ? _value.cover
            : cover // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateline: null == dateline
            ? _value.dateline
            : dateline // ignore: cast_nullable_to_non_nullable
                  as String,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AnnouncementDataImpl implements _AnnouncementData {
  const _$AnnouncementDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'content') this.content = '',
    @JsonKey(name: 'cover') this.cover,
    @JsonKey(name: 'url') this.url,
    @JsonKey(name: 'dateline') this.dateline = '',
    @JsonKey(name: 'is_read') this.isRead = false,
  });

  factory _$AnnouncementDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$AnnouncementDataImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'content')
  final String content;
  @override
  @JsonKey(name: 'cover')
  final String? cover;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'dateline')
  final String dateline;
  @override
  @JsonKey(name: 'is_read')
  final bool isRead;

  @override
  String toString() {
    return 'AnnouncementData(id: $id, title: $title, content: $content, cover: $cover, url: $url, dateline: $dateline, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnnouncementDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    content,
    cover,
    url,
    dateline,
    isRead,
  );

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnnouncementDataImplCopyWith<_$AnnouncementDataImpl> get copyWith =>
      __$$AnnouncementDataImplCopyWithImpl<_$AnnouncementDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AnnouncementDataImplToJson(this);
  }
}

abstract class _AnnouncementData implements AnnouncementData {
  const factory _AnnouncementData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'content') final String content,
    @JsonKey(name: 'cover') final String? cover,
    @JsonKey(name: 'url') final String? url,
    @JsonKey(name: 'dateline') final String dateline,
    @JsonKey(name: 'is_read') final bool isRead,
  }) = _$AnnouncementDataImpl;

  factory _AnnouncementData.fromJson(Map<String, dynamic> json) =
      _$AnnouncementDataImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'content')
  String get content;
  @override
  @JsonKey(name: 'cover')
  String? get cover;
  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'dateline')
  String get dateline;
  @override
  @JsonKey(name: 'is_read')
  bool get isRead;

  /// Create a copy of AnnouncementData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnnouncementDataImplCopyWith<_$AnnouncementDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
