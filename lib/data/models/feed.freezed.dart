// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HomeFeedResponse _$HomeFeedResponseFromJson(Map<String, dynamic> json) {
  return _HomeFeedResponse.fromJson(json);
}

/// @nodoc
mixin _$HomeFeedResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<HomeFeedData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastupdate')
  String? get lastUpdate => throw _privateConstructorUsedError;

  /// Serializes this HomeFeedResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeFeedResponseCopyWith<HomeFeedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeFeedResponseCopyWith<$Res> {
  factory $HomeFeedResponseCopyWith(
    HomeFeedResponse value,
    $Res Function(HomeFeedResponse) then,
  ) = _$HomeFeedResponseCopyWithImpl<$Res, HomeFeedResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<HomeFeedData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'lastupdate') String? lastUpdate,
  });
}

/// @nodoc
class _$HomeFeedResponseCopyWithImpl<$Res, $Val extends HomeFeedResponse>
    implements $HomeFeedResponseCopyWith<$Res> {
  _$HomeFeedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? lastUpdate = freezed,
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
                      as List<HomeFeedData>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            lastUpdate: freezed == lastUpdate
                ? _value.lastUpdate
                : lastUpdate // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeFeedResponseImplCopyWith<$Res>
    implements $HomeFeedResponseCopyWith<$Res> {
  factory _$$HomeFeedResponseImplCopyWith(
    _$HomeFeedResponseImpl value,
    $Res Function(_$HomeFeedResponseImpl) then,
  ) = __$$HomeFeedResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<HomeFeedData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'lastupdate') String? lastUpdate,
  });
}

/// @nodoc
class __$$HomeFeedResponseImplCopyWithImpl<$Res>
    extends _$HomeFeedResponseCopyWithImpl<$Res, _$HomeFeedResponseImpl>
    implements _$$HomeFeedResponseImplCopyWith<$Res> {
  __$$HomeFeedResponseImplCopyWithImpl(
    _$HomeFeedResponseImpl _value,
    $Res Function(_$HomeFeedResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? lastUpdate = freezed,
  }) {
    return _then(
      _$HomeFeedResponseImpl(
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
                  as List<HomeFeedData>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        lastUpdate: freezed == lastUpdate
            ? _value.lastUpdate
            : lastUpdate // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeFeedResponseImpl implements _HomeFeedResponse {
  const _$HomeFeedResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<HomeFeedData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'page') this.page = 1,
    @JsonKey(name: 'lastupdate') this.lastUpdate,
  }) : _data = data;

  factory _$HomeFeedResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeFeedResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<HomeFeedData> _data;
  @override
  @JsonKey(name: 'data')
  List<HomeFeedData> get data {
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
  @JsonKey(name: 'lastupdate')
  final String? lastUpdate;

  @override
  String toString() {
    return 'HomeFeedResponse(status: $status, message: $message, data: $data, total: $total, page: $page, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeFeedResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.lastUpdate, lastUpdate) ||
                other.lastUpdate == lastUpdate));
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
    lastUpdate,
  );

  /// Create a copy of HomeFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeFeedResponseImplCopyWith<_$HomeFeedResponseImpl> get copyWith =>
      __$$HomeFeedResponseImplCopyWithImpl<_$HomeFeedResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeFeedResponseImplToJson(this);
  }
}

abstract class _HomeFeedResponse implements HomeFeedResponse {
  const factory _HomeFeedResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<HomeFeedData> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'page') final int page,
    @JsonKey(name: 'lastupdate') final String? lastUpdate,
  }) = _$HomeFeedResponseImpl;

  factory _HomeFeedResponse.fromJson(Map<String, dynamic> json) =
      _$HomeFeedResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<HomeFeedData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'lastupdate')
  String? get lastUpdate;

  /// Create a copy of HomeFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeFeedResponseImplCopyWith<_$HomeFeedResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HomeFeedData _$HomeFeedDataFromJson(Map<String, dynamic> json) {
  return _HomeFeedData.fromJson(json);
}

/// @nodoc
mixin _$HomeFeedData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'entityType')
  String get entityType => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'picArr')
  List<String> get picArr => throw _privateConstructorUsedError;
  @JsonKey(name: 'userInfo')
  UserInfo? get userInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_action')
  UserAction get action => throw _privateConstructorUsedError;
  @JsonKey(name: 'dateline')
  String get dateline => throw _privateConstructorUsedError;
  @JsonKey(name: 'replynum')
  int get replyNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'forwardnum')
  int get forwardNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'forwardid')
  String? get forwardId => throw _privateConstructorUsedError;
  @JsonKey(name: 'forwardSource')
  String? get forwardSource => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_title')
  String? get deviceTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'replyRows')
  List<dynamic> get replyRows => throw _privateConstructorUsedError;
  @JsonKey(name: 'replyRowsMore')
  bool get replyRowsMore => throw _privateConstructorUsedError;

  /// Serializes this HomeFeedData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HomeFeedData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeFeedDataCopyWith<HomeFeedData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeFeedDataCopyWith<$Res> {
  factory $HomeFeedDataCopyWith(
    HomeFeedData value,
    $Res Function(HomeFeedData) then,
  ) = _$HomeFeedDataCopyWithImpl<$Res, HomeFeedData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'entityType') String entityType,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'userInfo') UserInfo? userInfo,
    @JsonKey(name: 'user_action') UserAction action,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'replynum') int replyNum,
    @JsonKey(name: 'forwardnum') int forwardNum,
    @JsonKey(name: 'forwardid') String? forwardId,
    @JsonKey(name: 'forwardSource') String? forwardSource,
    @JsonKey(name: 'device_title') String? deviceTitle,
    @JsonKey(name: 'replyRows') List<dynamic> replyRows,
    @JsonKey(name: 'replyRowsMore') bool replyRowsMore,
  });

  $UserInfoCopyWith<$Res>? get userInfo;
  $UserActionCopyWith<$Res> get action;
}

/// @nodoc
class _$HomeFeedDataCopyWithImpl<$Res, $Val extends HomeFeedData>
    implements $HomeFeedDataCopyWith<$Res> {
  _$HomeFeedDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeFeedData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? title = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? userInfo = freezed,
    Object? action = null,
    Object? dateline = null,
    Object? replyNum = null,
    Object? forwardNum = null,
    Object? forwardId = freezed,
    Object? forwardSource = freezed,
    Object? deviceTitle = freezed,
    Object? replyRows = null,
    Object? replyRowsMore = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            entityType: null == entityType
                ? _value.entityType
                : entityType // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            picArr: null == picArr
                ? _value.picArr
                : picArr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            userInfo: freezed == userInfo
                ? _value.userInfo
                : userInfo // ignore: cast_nullable_to_non_nullable
                      as UserInfo?,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as UserAction,
            dateline: null == dateline
                ? _value.dateline
                : dateline // ignore: cast_nullable_to_non_nullable
                      as String,
            replyNum: null == replyNum
                ? _value.replyNum
                : replyNum // ignore: cast_nullable_to_non_nullable
                      as int,
            forwardNum: null == forwardNum
                ? _value.forwardNum
                : forwardNum // ignore: cast_nullable_to_non_nullable
                      as int,
            forwardId: freezed == forwardId
                ? _value.forwardId
                : forwardId // ignore: cast_nullable_to_non_nullable
                      as String?,
            forwardSource: freezed == forwardSource
                ? _value.forwardSource
                : forwardSource // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceTitle: freezed == deviceTitle
                ? _value.deviceTitle
                : deviceTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyRows: null == replyRows
                ? _value.replyRows
                : replyRows // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            replyRowsMore: null == replyRowsMore
                ? _value.replyRowsMore
                : replyRowsMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of HomeFeedData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res>? get userInfo {
    if (_value.userInfo == null) {
      return null;
    }

    return $UserInfoCopyWith<$Res>(_value.userInfo!, (value) {
      return _then(_value.copyWith(userInfo: value) as $Val);
    });
  }

  /// Create a copy of HomeFeedData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserActionCopyWith<$Res> get action {
    return $UserActionCopyWith<$Res>(_value.action, (value) {
      return _then(_value.copyWith(action: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeFeedDataImplCopyWith<$Res>
    implements $HomeFeedDataCopyWith<$Res> {
  factory _$$HomeFeedDataImplCopyWith(
    _$HomeFeedDataImpl value,
    $Res Function(_$HomeFeedDataImpl) then,
  ) = __$$HomeFeedDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'entityType') String entityType,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'userInfo') UserInfo? userInfo,
    @JsonKey(name: 'user_action') UserAction action,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'replynum') int replyNum,
    @JsonKey(name: 'forwardnum') int forwardNum,
    @JsonKey(name: 'forwardid') String? forwardId,
    @JsonKey(name: 'forwardSource') String? forwardSource,
    @JsonKey(name: 'device_title') String? deviceTitle,
    @JsonKey(name: 'replyRows') List<dynamic> replyRows,
    @JsonKey(name: 'replyRowsMore') bool replyRowsMore,
  });

  @override
  $UserInfoCopyWith<$Res>? get userInfo;
  @override
  $UserActionCopyWith<$Res> get action;
}

/// @nodoc
class __$$HomeFeedDataImplCopyWithImpl<$Res>
    extends _$HomeFeedDataCopyWithImpl<$Res, _$HomeFeedDataImpl>
    implements _$$HomeFeedDataImplCopyWith<$Res> {
  __$$HomeFeedDataImplCopyWithImpl(
    _$HomeFeedDataImpl _value,
    $Res Function(_$HomeFeedDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeFeedData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? title = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? userInfo = freezed,
    Object? action = null,
    Object? dateline = null,
    Object? replyNum = null,
    Object? forwardNum = null,
    Object? forwardId = freezed,
    Object? forwardSource = freezed,
    Object? deviceTitle = freezed,
    Object? replyRows = null,
    Object? replyRowsMore = null,
  }) {
    return _then(
      _$HomeFeedDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        entityType: null == entityType
            ? _value.entityType
            : entityType // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        picArr: null == picArr
            ? _value._picArr
            : picArr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        userInfo: freezed == userInfo
            ? _value.userInfo
            : userInfo // ignore: cast_nullable_to_non_nullable
                  as UserInfo?,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as UserAction,
        dateline: null == dateline
            ? _value.dateline
            : dateline // ignore: cast_nullable_to_non_nullable
                  as String,
        replyNum: null == replyNum
            ? _value.replyNum
            : replyNum // ignore: cast_nullable_to_non_nullable
                  as int,
        forwardNum: null == forwardNum
            ? _value.forwardNum
            : forwardNum // ignore: cast_nullable_to_non_nullable
                  as int,
        forwardId: freezed == forwardId
            ? _value.forwardId
            : forwardId // ignore: cast_nullable_to_non_nullable
                  as String?,
        forwardSource: freezed == forwardSource
            ? _value.forwardSource
            : forwardSource // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceTitle: freezed == deviceTitle
            ? _value.deviceTitle
            : deviceTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyRows: null == replyRows
            ? _value._replyRows
            : replyRows // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        replyRowsMore: null == replyRowsMore
            ? _value.replyRowsMore
            : replyRowsMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HomeFeedDataImpl implements _HomeFeedData {
  const _$HomeFeedDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'entityType') required this.entityType,
    @JsonKey(name: 'title') this.title,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'picArr') final List<String> picArr = const [],
    @JsonKey(name: 'userInfo') this.userInfo,
    @JsonKey(name: 'user_action') this.action = const UserAction(),
    @JsonKey(name: 'dateline') this.dateline = '',
    @JsonKey(name: 'replynum') this.replyNum = 0,
    @JsonKey(name: 'forwardnum') this.forwardNum = 0,
    @JsonKey(name: 'forwardid') this.forwardId,
    @JsonKey(name: 'forwardSource') this.forwardSource,
    @JsonKey(name: 'device_title') this.deviceTitle,
    @JsonKey(name: 'replyRows') final List<dynamic> replyRows = const [],
    @JsonKey(name: 'replyRowsMore') this.replyRowsMore = false,
  }) : _picArr = picArr,
       _replyRows = replyRows;

  factory _$HomeFeedDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$HomeFeedDataImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'entityType')
  final String entityType;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<String> _picArr;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr {
    if (_picArr is EqualUnmodifiableListView) return _picArr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_picArr);
  }

  @override
  @JsonKey(name: 'userInfo')
  final UserInfo? userInfo;
  @override
  @JsonKey(name: 'user_action')
  final UserAction action;
  @override
  @JsonKey(name: 'dateline')
  final String dateline;
  @override
  @JsonKey(name: 'replynum')
  final int replyNum;
  @override
  @JsonKey(name: 'forwardnum')
  final int forwardNum;
  @override
  @JsonKey(name: 'forwardid')
  final String? forwardId;
  @override
  @JsonKey(name: 'forwardSource')
  final String? forwardSource;
  @override
  @JsonKey(name: 'device_title')
  final String? deviceTitle;
  final List<dynamic> _replyRows;
  @override
  @JsonKey(name: 'replyRows')
  List<dynamic> get replyRows {
    if (_replyRows is EqualUnmodifiableListView) return _replyRows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replyRows);
  }

  @override
  @JsonKey(name: 'replyRowsMore')
  final bool replyRowsMore;

  @override
  String toString() {
    return 'HomeFeedData(id: $id, entityType: $entityType, title: $title, message: $message, picArr: $picArr, userInfo: $userInfo, action: $action, dateline: $dateline, replyNum: $replyNum, forwardNum: $forwardNum, forwardId: $forwardId, forwardSource: $forwardSource, deviceTitle: $deviceTitle, replyRows: $replyRows, replyRowsMore: $replyRowsMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeFeedDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._picArr, _picArr) &&
            (identical(other.userInfo, userInfo) ||
                other.userInfo == userInfo) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.replyNum, replyNum) ||
                other.replyNum == replyNum) &&
            (identical(other.forwardNum, forwardNum) ||
                other.forwardNum == forwardNum) &&
            (identical(other.forwardId, forwardId) ||
                other.forwardId == forwardId) &&
            (identical(other.forwardSource, forwardSource) ||
                other.forwardSource == forwardSource) &&
            (identical(other.deviceTitle, deviceTitle) ||
                other.deviceTitle == deviceTitle) &&
            const DeepCollectionEquality().equals(
              other._replyRows,
              _replyRows,
            ) &&
            (identical(other.replyRowsMore, replyRowsMore) ||
                other.replyRowsMore == replyRowsMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    entityType,
    title,
    message,
    const DeepCollectionEquality().hash(_picArr),
    userInfo,
    action,
    dateline,
    replyNum,
    forwardNum,
    forwardId,
    forwardSource,
    deviceTitle,
    const DeepCollectionEquality().hash(_replyRows),
    replyRowsMore,
  );

  /// Create a copy of HomeFeedData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeFeedDataImplCopyWith<_$HomeFeedDataImpl> get copyWith =>
      __$$HomeFeedDataImplCopyWithImpl<_$HomeFeedDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HomeFeedDataImplToJson(this);
  }
}

abstract class _HomeFeedData implements HomeFeedData {
  const factory _HomeFeedData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'entityType') required final String entityType,
    @JsonKey(name: 'title') final String? title,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'picArr') final List<String> picArr,
    @JsonKey(name: 'userInfo') final UserInfo? userInfo,
    @JsonKey(name: 'user_action') final UserAction action,
    @JsonKey(name: 'dateline') final String dateline,
    @JsonKey(name: 'replynum') final int replyNum,
    @JsonKey(name: 'forwardnum') final int forwardNum,
    @JsonKey(name: 'forwardid') final String? forwardId,
    @JsonKey(name: 'forwardSource') final String? forwardSource,
    @JsonKey(name: 'device_title') final String? deviceTitle,
    @JsonKey(name: 'replyRows') final List<dynamic> replyRows,
    @JsonKey(name: 'replyRowsMore') final bool replyRowsMore,
  }) = _$HomeFeedDataImpl;

  factory _HomeFeedData.fromJson(Map<String, dynamic> json) =
      _$HomeFeedDataImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'entityType')
  String get entityType;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr;
  @override
  @JsonKey(name: 'userInfo')
  UserInfo? get userInfo;
  @override
  @JsonKey(name: 'user_action')
  UserAction get action;
  @override
  @JsonKey(name: 'dateline')
  String get dateline;
  @override
  @JsonKey(name: 'replynum')
  int get replyNum;
  @override
  @JsonKey(name: 'forwardnum')
  int get forwardNum;
  @override
  @JsonKey(name: 'forwardid')
  String? get forwardId;
  @override
  @JsonKey(name: 'forwardSource')
  String? get forwardSource;
  @override
  @JsonKey(name: 'device_title')
  String? get deviceTitle;
  @override
  @JsonKey(name: 'replyRows')
  List<dynamic> get replyRows;
  @override
  @JsonKey(name: 'replyRowsMore')
  bool get replyRowsMore;

  /// Create a copy of HomeFeedData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeFeedDataImplCopyWith<_$HomeFeedDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedContentResponse _$FeedContentResponseFromJson(Map<String, dynamic> json) {
  return _FeedContentResponse.fromJson(json);
}

/// @nodoc
mixin _$FeedContentResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  FeedContentData? get data => throw _privateConstructorUsedError;

  /// Serializes this FeedContentResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedContentResponseCopyWith<FeedContentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedContentResponseCopyWith<$Res> {
  factory $FeedContentResponseCopyWith(
    FeedContentResponse value,
    $Res Function(FeedContentResponse) then,
  ) = _$FeedContentResponseCopyWithImpl<$Res, FeedContentResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') FeedContentData? data,
  });

  $FeedContentDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$FeedContentResponseCopyWithImpl<$Res, $Val extends FeedContentResponse>
    implements $FeedContentResponseCopyWith<$Res> {
  _$FeedContentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
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
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as FeedContentData?,
          )
          as $Val,
    );
  }

  /// Create a copy of FeedContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedContentDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $FeedContentDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeedContentResponseImplCopyWith<$Res>
    implements $FeedContentResponseCopyWith<$Res> {
  factory _$$FeedContentResponseImplCopyWith(
    _$FeedContentResponseImpl value,
    $Res Function(_$FeedContentResponseImpl) then,
  ) = __$$FeedContentResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') FeedContentData? data,
  });

  @override
  $FeedContentDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$FeedContentResponseImplCopyWithImpl<$Res>
    extends _$FeedContentResponseCopyWithImpl<$Res, _$FeedContentResponseImpl>
    implements _$$FeedContentResponseImplCopyWith<$Res> {
  __$$FeedContentResponseImplCopyWithImpl(
    _$FeedContentResponseImpl _value,
    $Res Function(_$FeedContentResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$FeedContentResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as FeedContentData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedContentResponseImpl implements _FeedContentResponse {
  const _$FeedContentResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') this.data,
  });

  factory _$FeedContentResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedContentResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'data')
  final FeedContentData? data;

  @override
  String toString() {
    return 'FeedContentResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedContentResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of FeedContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedContentResponseImplCopyWith<_$FeedContentResponseImpl> get copyWith =>
      __$$FeedContentResponseImplCopyWithImpl<_$FeedContentResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedContentResponseImplToJson(this);
  }
}

abstract class _FeedContentResponse implements FeedContentResponse {
  const factory _FeedContentResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final FeedContentData? data,
  }) = _$FeedContentResponseImpl;

  factory _FeedContentResponse.fromJson(Map<String, dynamic> json) =
      _$FeedContentResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  FeedContentData? get data;

  /// Create a copy of FeedContentResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedContentResponseImplCopyWith<_$FeedContentResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedContentData _$FeedContentDataFromJson(Map<String, dynamic> json) {
  return _FeedContentData.fromJson(json);
}

/// @nodoc
mixin _$FeedContentData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'entityType')
  String get entityType => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'picArr')
  List<String> get picArr => throw _privateConstructorUsedError;
  @JsonKey(name: 'userInfo')
  UserInfo? get userInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_action')
  UserAction get action => throw _privateConstructorUsedError;
  @JsonKey(name: 'dateline')
  String get dateline => throw _privateConstructorUsedError;
  @JsonKey(name: 'replynum')
  int get replyNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'forwardnum')
  int get forwardNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_title')
  String? get deviceTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'replyRows')
  List<dynamic> get replyRows => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_top')
  bool get isTop => throw _privateConstructorUsedError;

  /// Serializes this FeedContentData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedContentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedContentDataCopyWith<FeedContentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedContentDataCopyWith<$Res> {
  factory $FeedContentDataCopyWith(
    FeedContentData value,
    $Res Function(FeedContentData) then,
  ) = _$FeedContentDataCopyWithImpl<$Res, FeedContentData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'entityType') String entityType,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'userInfo') UserInfo? userInfo,
    @JsonKey(name: 'user_action') UserAction action,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'replynum') int replyNum,
    @JsonKey(name: 'forwardnum') int forwardNum,
    @JsonKey(name: 'device_title') String? deviceTitle,
    @JsonKey(name: 'replyRows') List<dynamic> replyRows,
    @JsonKey(name: 'is_top') bool isTop,
  });

  $UserInfoCopyWith<$Res>? get userInfo;
  $UserActionCopyWith<$Res> get action;
}

/// @nodoc
class _$FeedContentDataCopyWithImpl<$Res, $Val extends FeedContentData>
    implements $FeedContentDataCopyWith<$Res> {
  _$FeedContentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedContentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? title = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? userInfo = freezed,
    Object? action = null,
    Object? dateline = null,
    Object? replyNum = null,
    Object? forwardNum = null,
    Object? deviceTitle = freezed,
    Object? replyRows = null,
    Object? isTop = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            entityType: null == entityType
                ? _value.entityType
                : entityType // ignore: cast_nullable_to_non_nullable
                      as String,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            picArr: null == picArr
                ? _value.picArr
                : picArr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            userInfo: freezed == userInfo
                ? _value.userInfo
                : userInfo // ignore: cast_nullable_to_non_nullable
                      as UserInfo?,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as UserAction,
            dateline: null == dateline
                ? _value.dateline
                : dateline // ignore: cast_nullable_to_non_nullable
                      as String,
            replyNum: null == replyNum
                ? _value.replyNum
                : replyNum // ignore: cast_nullable_to_non_nullable
                      as int,
            forwardNum: null == forwardNum
                ? _value.forwardNum
                : forwardNum // ignore: cast_nullable_to_non_nullable
                      as int,
            deviceTitle: freezed == deviceTitle
                ? _value.deviceTitle
                : deviceTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyRows: null == replyRows
                ? _value.replyRows
                : replyRows // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            isTop: null == isTop
                ? _value.isTop
                : isTop // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of FeedContentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res>? get userInfo {
    if (_value.userInfo == null) {
      return null;
    }

    return $UserInfoCopyWith<$Res>(_value.userInfo!, (value) {
      return _then(_value.copyWith(userInfo: value) as $Val);
    });
  }

  /// Create a copy of FeedContentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserActionCopyWith<$Res> get action {
    return $UserActionCopyWith<$Res>(_value.action, (value) {
      return _then(_value.copyWith(action: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeedContentDataImplCopyWith<$Res>
    implements $FeedContentDataCopyWith<$Res> {
  factory _$$FeedContentDataImplCopyWith(
    _$FeedContentDataImpl value,
    $Res Function(_$FeedContentDataImpl) then,
  ) = __$$FeedContentDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'entityType') String entityType,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'userInfo') UserInfo? userInfo,
    @JsonKey(name: 'user_action') UserAction action,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'replynum') int replyNum,
    @JsonKey(name: 'forwardnum') int forwardNum,
    @JsonKey(name: 'device_title') String? deviceTitle,
    @JsonKey(name: 'replyRows') List<dynamic> replyRows,
    @JsonKey(name: 'is_top') bool isTop,
  });

  @override
  $UserInfoCopyWith<$Res>? get userInfo;
  @override
  $UserActionCopyWith<$Res> get action;
}

/// @nodoc
class __$$FeedContentDataImplCopyWithImpl<$Res>
    extends _$FeedContentDataCopyWithImpl<$Res, _$FeedContentDataImpl>
    implements _$$FeedContentDataImplCopyWith<$Res> {
  __$$FeedContentDataImplCopyWithImpl(
    _$FeedContentDataImpl _value,
    $Res Function(_$FeedContentDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedContentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? entityType = null,
    Object? title = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? userInfo = freezed,
    Object? action = null,
    Object? dateline = null,
    Object? replyNum = null,
    Object? forwardNum = null,
    Object? deviceTitle = freezed,
    Object? replyRows = null,
    Object? isTop = null,
  }) {
    return _then(
      _$FeedContentDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        entityType: null == entityType
            ? _value.entityType
            : entityType // ignore: cast_nullable_to_non_nullable
                  as String,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        picArr: null == picArr
            ? _value._picArr
            : picArr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        userInfo: freezed == userInfo
            ? _value.userInfo
            : userInfo // ignore: cast_nullable_to_non_nullable
                  as UserInfo?,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as UserAction,
        dateline: null == dateline
            ? _value.dateline
            : dateline // ignore: cast_nullable_to_non_nullable
                  as String,
        replyNum: null == replyNum
            ? _value.replyNum
            : replyNum // ignore: cast_nullable_to_non_nullable
                  as int,
        forwardNum: null == forwardNum
            ? _value.forwardNum
            : forwardNum // ignore: cast_nullable_to_non_nullable
                  as int,
        deviceTitle: freezed == deviceTitle
            ? _value.deviceTitle
            : deviceTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyRows: null == replyRows
            ? _value._replyRows
            : replyRows // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        isTop: null == isTop
            ? _value.isTop
            : isTop // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedContentDataImpl implements _FeedContentData {
  const _$FeedContentDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'entityType') required this.entityType,
    @JsonKey(name: 'title') this.title,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'picArr') final List<String> picArr = const [],
    @JsonKey(name: 'userInfo') this.userInfo,
    @JsonKey(name: 'user_action') this.action = const UserAction(),
    @JsonKey(name: 'dateline') this.dateline = '',
    @JsonKey(name: 'replynum') this.replyNum = 0,
    @JsonKey(name: 'forwardnum') this.forwardNum = 0,
    @JsonKey(name: 'device_title') this.deviceTitle,
    @JsonKey(name: 'replyRows') final List<dynamic> replyRows = const [],
    @JsonKey(name: 'is_top') this.isTop = false,
  }) : _picArr = picArr,
       _replyRows = replyRows;

  factory _$FeedContentDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedContentDataImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'entityType')
  final String entityType;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<String> _picArr;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr {
    if (_picArr is EqualUnmodifiableListView) return _picArr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_picArr);
  }

  @override
  @JsonKey(name: 'userInfo')
  final UserInfo? userInfo;
  @override
  @JsonKey(name: 'user_action')
  final UserAction action;
  @override
  @JsonKey(name: 'dateline')
  final String dateline;
  @override
  @JsonKey(name: 'replynum')
  final int replyNum;
  @override
  @JsonKey(name: 'forwardnum')
  final int forwardNum;
  @override
  @JsonKey(name: 'device_title')
  final String? deviceTitle;
  final List<dynamic> _replyRows;
  @override
  @JsonKey(name: 'replyRows')
  List<dynamic> get replyRows {
    if (_replyRows is EqualUnmodifiableListView) return _replyRows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replyRows);
  }

  @override
  @JsonKey(name: 'is_top')
  final bool isTop;

  @override
  String toString() {
    return 'FeedContentData(id: $id, entityType: $entityType, title: $title, message: $message, picArr: $picArr, userInfo: $userInfo, action: $action, dateline: $dateline, replyNum: $replyNum, forwardNum: $forwardNum, deviceTitle: $deviceTitle, replyRows: $replyRows, isTop: $isTop)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedContentDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._picArr, _picArr) &&
            (identical(other.userInfo, userInfo) ||
                other.userInfo == userInfo) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.replyNum, replyNum) ||
                other.replyNum == replyNum) &&
            (identical(other.forwardNum, forwardNum) ||
                other.forwardNum == forwardNum) &&
            (identical(other.deviceTitle, deviceTitle) ||
                other.deviceTitle == deviceTitle) &&
            const DeepCollectionEquality().equals(
              other._replyRows,
              _replyRows,
            ) &&
            (identical(other.isTop, isTop) || other.isTop == isTop));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    entityType,
    title,
    message,
    const DeepCollectionEquality().hash(_picArr),
    userInfo,
    action,
    dateline,
    replyNum,
    forwardNum,
    deviceTitle,
    const DeepCollectionEquality().hash(_replyRows),
    isTop,
  );

  /// Create a copy of FeedContentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedContentDataImplCopyWith<_$FeedContentDataImpl> get copyWith =>
      __$$FeedContentDataImplCopyWithImpl<_$FeedContentDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedContentDataImplToJson(this);
  }
}

abstract class _FeedContentData implements FeedContentData {
  const factory _FeedContentData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'entityType') required final String entityType,
    @JsonKey(name: 'title') final String? title,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'picArr') final List<String> picArr,
    @JsonKey(name: 'userInfo') final UserInfo? userInfo,
    @JsonKey(name: 'user_action') final UserAction action,
    @JsonKey(name: 'dateline') final String dateline,
    @JsonKey(name: 'replynum') final int replyNum,
    @JsonKey(name: 'forwardnum') final int forwardNum,
    @JsonKey(name: 'device_title') final String? deviceTitle,
    @JsonKey(name: 'replyRows') final List<dynamic> replyRows,
    @JsonKey(name: 'is_top') final bool isTop,
  }) = _$FeedContentDataImpl;

  factory _FeedContentData.fromJson(Map<String, dynamic> json) =
      _$FeedContentDataImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'entityType')
  String get entityType;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr;
  @override
  @JsonKey(name: 'userInfo')
  UserInfo? get userInfo;
  @override
  @JsonKey(name: 'user_action')
  UserAction get action;
  @override
  @JsonKey(name: 'dateline')
  String get dateline;
  @override
  @JsonKey(name: 'replynum')
  int get replyNum;
  @override
  @JsonKey(name: 'forwardnum')
  int get forwardNum;
  @override
  @JsonKey(name: 'device_title')
  String? get deviceTitle;
  @override
  @JsonKey(name: 'replyRows')
  List<dynamic> get replyRows;
  @override
  @JsonKey(name: 'is_top')
  bool get isTop;

  /// Create a copy of FeedContentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedContentDataImplCopyWith<_$FeedContentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateFeedRequest _$CreateFeedRequestFromJson(Map<String, dynamic> json) {
  return _CreateFeedRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateFeedRequest {
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'picArr')
  List<String> get picArr => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'device_title')
  String? get deviceTitle => throw _privateConstructorUsedError;

  /// Serializes this CreateFeedRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateFeedRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateFeedRequestCopyWith<CreateFeedRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateFeedRequestCopyWith<$Res> {
  factory $CreateFeedRequestCopyWith(
    CreateFeedRequest value,
    $Res Function(CreateFeedRequest) then,
  ) = _$CreateFeedRequestCopyWithImpl<$Res, CreateFeedRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'type') String type,
    @JsonKey(name: 'device_title') String? deviceTitle,
  });
}

/// @nodoc
class _$CreateFeedRequestCopyWithImpl<$Res, $Val extends CreateFeedRequest>
    implements $CreateFeedRequestCopyWith<$Res> {
  _$CreateFeedRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateFeedRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? picArr = null,
    Object? type = null,
    Object? deviceTitle = freezed,
  }) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            picArr: null == picArr
                ? _value.picArr
                : picArr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            deviceTitle: freezed == deviceTitle
                ? _value.deviceTitle
                : deviceTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateFeedRequestImplCopyWith<$Res>
    implements $CreateFeedRequestCopyWith<$Res> {
  factory _$$CreateFeedRequestImplCopyWith(
    _$CreateFeedRequestImpl value,
    $Res Function(_$CreateFeedRequestImpl) then,
  ) = __$$CreateFeedRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'type') String type,
    @JsonKey(name: 'device_title') String? deviceTitle,
  });
}

/// @nodoc
class __$$CreateFeedRequestImplCopyWithImpl<$Res>
    extends _$CreateFeedRequestCopyWithImpl<$Res, _$CreateFeedRequestImpl>
    implements _$$CreateFeedRequestImplCopyWith<$Res> {
  __$$CreateFeedRequestImplCopyWithImpl(
    _$CreateFeedRequestImpl _value,
    $Res Function(_$CreateFeedRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateFeedRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? picArr = null,
    Object? type = null,
    Object? deviceTitle = freezed,
  }) {
    return _then(
      _$CreateFeedRequestImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        picArr: null == picArr
            ? _value._picArr
            : picArr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        deviceTitle: freezed == deviceTitle
            ? _value.deviceTitle
            : deviceTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateFeedRequestImpl implements _CreateFeedRequest {
  const _$CreateFeedRequestImpl({
    @JsonKey(name: 'message') required this.message,
    @JsonKey(name: 'picArr') final List<String> picArr = const [],
    @JsonKey(name: 'type') this.type = 'feed',
    @JsonKey(name: 'device_title') this.deviceTitle,
  }) : _picArr = picArr;

  factory _$CreateFeedRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateFeedRequestImplFromJson(json);

  @override
  @JsonKey(name: 'message')
  final String message;
  final List<String> _picArr;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr {
    if (_picArr is EqualUnmodifiableListView) return _picArr;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_picArr);
  }

  @override
  @JsonKey(name: 'type')
  final String type;
  @override
  @JsonKey(name: 'device_title')
  final String? deviceTitle;

  @override
  String toString() {
    return 'CreateFeedRequest(message: $message, picArr: $picArr, type: $type, deviceTitle: $deviceTitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateFeedRequestImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._picArr, _picArr) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.deviceTitle, deviceTitle) ||
                other.deviceTitle == deviceTitle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_picArr),
    type,
    deviceTitle,
  );

  /// Create a copy of CreateFeedRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateFeedRequestImplCopyWith<_$CreateFeedRequestImpl> get copyWith =>
      __$$CreateFeedRequestImplCopyWithImpl<_$CreateFeedRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateFeedRequestImplToJson(this);
  }
}

abstract class _CreateFeedRequest implements CreateFeedRequest {
  const factory _CreateFeedRequest({
    @JsonKey(name: 'message') required final String message,
    @JsonKey(name: 'picArr') final List<String> picArr,
    @JsonKey(name: 'type') final String type,
    @JsonKey(name: 'device_title') final String? deviceTitle,
  }) = _$CreateFeedRequestImpl;

  factory _CreateFeedRequest.fromJson(Map<String, dynamic> json) =
      _$CreateFeedRequestImpl.fromJson;

  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr;
  @override
  @JsonKey(name: 'type')
  String get type;
  @override
  @JsonKey(name: 'device_title')
  String? get deviceTitle;

  /// Create a copy of CreateFeedRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateFeedRequestImplCopyWith<_$CreateFeedRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateFeedResponse _$CreateFeedResponseFromJson(Map<String, dynamic> json) {
  return _CreateFeedResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateFeedResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  HomeFeedData? get data => throw _privateConstructorUsedError;

  /// Serializes this CreateFeedResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateFeedResponseCopyWith<CreateFeedResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateFeedResponseCopyWith<$Res> {
  factory $CreateFeedResponseCopyWith(
    CreateFeedResponse value,
    $Res Function(CreateFeedResponse) then,
  ) = _$CreateFeedResponseCopyWithImpl<$Res, CreateFeedResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') HomeFeedData? data,
  });

  $HomeFeedDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$CreateFeedResponseCopyWithImpl<$Res, $Val extends CreateFeedResponse>
    implements $CreateFeedResponseCopyWith<$Res> {
  _$CreateFeedResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
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
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as HomeFeedData?,
          )
          as $Val,
    );
  }

  /// Create a copy of CreateFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HomeFeedDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $HomeFeedDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateFeedResponseImplCopyWith<$Res>
    implements $CreateFeedResponseCopyWith<$Res> {
  factory _$$CreateFeedResponseImplCopyWith(
    _$CreateFeedResponseImpl value,
    $Res Function(_$CreateFeedResponseImpl) then,
  ) = __$$CreateFeedResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') HomeFeedData? data,
  });

  @override
  $HomeFeedDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$CreateFeedResponseImplCopyWithImpl<$Res>
    extends _$CreateFeedResponseCopyWithImpl<$Res, _$CreateFeedResponseImpl>
    implements _$$CreateFeedResponseImplCopyWith<$Res> {
  __$$CreateFeedResponseImplCopyWithImpl(
    _$CreateFeedResponseImpl _value,
    $Res Function(_$CreateFeedResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$CreateFeedResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as HomeFeedData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateFeedResponseImpl implements _CreateFeedResponse {
  const _$CreateFeedResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') this.data,
  });

  factory _$CreateFeedResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateFeedResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'data')
  final HomeFeedData? data;

  @override
  String toString() {
    return 'CreateFeedResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateFeedResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of CreateFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateFeedResponseImplCopyWith<_$CreateFeedResponseImpl> get copyWith =>
      __$$CreateFeedResponseImplCopyWithImpl<_$CreateFeedResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateFeedResponseImplToJson(this);
  }
}

abstract class _CreateFeedResponse implements CreateFeedResponse {
  const factory _CreateFeedResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final HomeFeedData? data,
  }) = _$CreateFeedResponseImpl;

  factory _CreateFeedResponse.fromJson(Map<String, dynamic> json) =
      _$CreateFeedResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  HomeFeedData? get data;

  /// Create a copy of CreateFeedResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateFeedResponseImplCopyWith<_$CreateFeedResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
