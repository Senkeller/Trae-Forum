// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TotalReplyResponse _$TotalReplyResponseFromJson(Map<String, dynamic> json) {
  return _TotalReplyResponse.fromJson(json);
}

/// @nodoc
mixin _$TotalReplyResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<ReplyData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastupdate')
  String? get lastUpdate => throw _privateConstructorUsedError;

  /// Serializes this TotalReplyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TotalReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TotalReplyResponseCopyWith<TotalReplyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TotalReplyResponseCopyWith<$Res> {
  factory $TotalReplyResponseCopyWith(
    TotalReplyResponse value,
    $Res Function(TotalReplyResponse) then,
  ) = _$TotalReplyResponseCopyWithImpl<$Res, TotalReplyResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ReplyData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'lastupdate') String? lastUpdate,
  });
}

/// @nodoc
class _$TotalReplyResponseCopyWithImpl<$Res, $Val extends TotalReplyResponse>
    implements $TotalReplyResponseCopyWith<$Res> {
  _$TotalReplyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TotalReplyResponse
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
                      as List<ReplyData>,
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
abstract class _$$TotalReplyResponseImplCopyWith<$Res>
    implements $TotalReplyResponseCopyWith<$Res> {
  factory _$$TotalReplyResponseImplCopyWith(
    _$TotalReplyResponseImpl value,
    $Res Function(_$TotalReplyResponseImpl) then,
  ) = __$$TotalReplyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ReplyData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'lastupdate') String? lastUpdate,
  });
}

/// @nodoc
class __$$TotalReplyResponseImplCopyWithImpl<$Res>
    extends _$TotalReplyResponseCopyWithImpl<$Res, _$TotalReplyResponseImpl>
    implements _$$TotalReplyResponseImplCopyWith<$Res> {
  __$$TotalReplyResponseImplCopyWithImpl(
    _$TotalReplyResponseImpl _value,
    $Res Function(_$TotalReplyResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TotalReplyResponse
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
      _$TotalReplyResponseImpl(
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
                  as List<ReplyData>,
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
class _$TotalReplyResponseImpl implements _TotalReplyResponse {
  const _$TotalReplyResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<ReplyData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'page') this.page = 1,
    @JsonKey(name: 'lastupdate') this.lastUpdate,
  }) : _data = data;

  factory _$TotalReplyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TotalReplyResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<ReplyData> _data;
  @override
  @JsonKey(name: 'data')
  List<ReplyData> get data {
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
    return 'TotalReplyResponse(status: $status, message: $message, data: $data, total: $total, page: $page, lastUpdate: $lastUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TotalReplyResponseImpl &&
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

  /// Create a copy of TotalReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TotalReplyResponseImplCopyWith<_$TotalReplyResponseImpl> get copyWith =>
      __$$TotalReplyResponseImplCopyWithImpl<_$TotalReplyResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TotalReplyResponseImplToJson(this);
  }
}

abstract class _TotalReplyResponse implements TotalReplyResponse {
  const factory _TotalReplyResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<ReplyData> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'page') final int page,
    @JsonKey(name: 'lastupdate') final String? lastUpdate,
  }) = _$TotalReplyResponseImpl;

  factory _TotalReplyResponse.fromJson(Map<String, dynamic> json) =
      _$TotalReplyResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<ReplyData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'lastupdate')
  String? get lastUpdate;

  /// Create a copy of TotalReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TotalReplyResponseImplCopyWith<_$TotalReplyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReplyData _$ReplyDataFromJson(Map<String, dynamic> json) {
  return _ReplyData.fromJson(json);
}

/// @nodoc
mixin _$ReplyData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'uid')
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar')
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'picArr')
  List<String> get picArr => throw _privateConstructorUsedError;
  @JsonKey(name: 'dateline')
  String get dateline => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_num')
  int get likeNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_like')
  bool get isLike => throw _privateConstructorUsedError;
  @JsonKey(name: 'replynum')
  int get replyNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'replyRows')
  List<ReplyData> get replyRows => throw _privateConstructorUsedError;
  @JsonKey(name: 'replyRowsMore')
  bool get replyRowsMore => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to')
  String? get replyTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_uid')
  String? get replyUid => throw _privateConstructorUsedError;

  /// Serializes this ReplyData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReplyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReplyDataCopyWith<ReplyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyDataCopyWith<$Res> {
  factory $ReplyDataCopyWith(ReplyData value, $Res Function(ReplyData) then) =
      _$ReplyDataCopyWithImpl<$Res, ReplyData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'uid') String uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'like_num') int likeNum,
    @JsonKey(name: 'is_like') bool isLike,
    @JsonKey(name: 'replynum') int replyNum,
    @JsonKey(name: 'replyRows') List<ReplyData> replyRows,
    @JsonKey(name: 'replyRowsMore') bool replyRowsMore,
    @JsonKey(name: 'reply_to') String? replyTo,
    @JsonKey(name: 'reply_uid') String? replyUid,
  });
}

/// @nodoc
class _$ReplyDataCopyWithImpl<$Res, $Val extends ReplyData>
    implements $ReplyDataCopyWith<$Res> {
  _$ReplyDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReplyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? dateline = null,
    Object? likeNum = null,
    Object? isLike = null,
    Object? replyNum = null,
    Object? replyRows = null,
    Object? replyRowsMore = null,
    Object? replyTo = freezed,
    Object? replyUid = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            uid: null == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            avatar: freezed == avatar
                ? _value.avatar
                : avatar // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            picArr: null == picArr
                ? _value.picArr
                : picArr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            dateline: null == dateline
                ? _value.dateline
                : dateline // ignore: cast_nullable_to_non_nullable
                      as String,
            likeNum: null == likeNum
                ? _value.likeNum
                : likeNum // ignore: cast_nullable_to_non_nullable
                      as int,
            isLike: null == isLike
                ? _value.isLike
                : isLike // ignore: cast_nullable_to_non_nullable
                      as bool,
            replyNum: null == replyNum
                ? _value.replyNum
                : replyNum // ignore: cast_nullable_to_non_nullable
                      as int,
            replyRows: null == replyRows
                ? _value.replyRows
                : replyRows // ignore: cast_nullable_to_non_nullable
                      as List<ReplyData>,
            replyRowsMore: null == replyRowsMore
                ? _value.replyRowsMore
                : replyRowsMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            replyTo: freezed == replyTo
                ? _value.replyTo
                : replyTo // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyUid: freezed == replyUid
                ? _value.replyUid
                : replyUid // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReplyDataImplCopyWith<$Res>
    implements $ReplyDataCopyWith<$Res> {
  factory _$$ReplyDataImplCopyWith(
    _$ReplyDataImpl value,
    $Res Function(_$ReplyDataImpl) then,
  ) = __$$ReplyDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'uid') String uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'like_num') int likeNum,
    @JsonKey(name: 'is_like') bool isLike,
    @JsonKey(name: 'replynum') int replyNum,
    @JsonKey(name: 'replyRows') List<ReplyData> replyRows,
    @JsonKey(name: 'replyRowsMore') bool replyRowsMore,
    @JsonKey(name: 'reply_to') String? replyTo,
    @JsonKey(name: 'reply_uid') String? replyUid,
  });
}

/// @nodoc
class __$$ReplyDataImplCopyWithImpl<$Res>
    extends _$ReplyDataCopyWithImpl<$Res, _$ReplyDataImpl>
    implements _$$ReplyDataImplCopyWith<$Res> {
  __$$ReplyDataImplCopyWithImpl(
    _$ReplyDataImpl _value,
    $Res Function(_$ReplyDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReplyData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? dateline = null,
    Object? likeNum = null,
    Object? isLike = null,
    Object? replyNum = null,
    Object? replyRows = null,
    Object? replyRowsMore = null,
    Object? replyTo = freezed,
    Object? replyUid = freezed,
  }) {
    return _then(
      _$ReplyDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        uid: null == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        avatar: freezed == avatar
            ? _value.avatar
            : avatar // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        picArr: null == picArr
            ? _value._picArr
            : picArr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        dateline: null == dateline
            ? _value.dateline
            : dateline // ignore: cast_nullable_to_non_nullable
                  as String,
        likeNum: null == likeNum
            ? _value.likeNum
            : likeNum // ignore: cast_nullable_to_non_nullable
                  as int,
        isLike: null == isLike
            ? _value.isLike
            : isLike // ignore: cast_nullable_to_non_nullable
                  as bool,
        replyNum: null == replyNum
            ? _value.replyNum
            : replyNum // ignore: cast_nullable_to_non_nullable
                  as int,
        replyRows: null == replyRows
            ? _value._replyRows
            : replyRows // ignore: cast_nullable_to_non_nullable
                  as List<ReplyData>,
        replyRowsMore: null == replyRowsMore
            ? _value.replyRowsMore
            : replyRowsMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        replyTo: freezed == replyTo
            ? _value.replyTo
            : replyTo // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyUid: freezed == replyUid
            ? _value.replyUid
            : replyUid // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplyDataImpl implements _ReplyData {
  const _$ReplyDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'uid') required this.uid,
    @JsonKey(name: 'username') this.username = '',
    @JsonKey(name: 'avatar') this.avatar,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'picArr') final List<String> picArr = const [],
    @JsonKey(name: 'dateline') this.dateline = '',
    @JsonKey(name: 'like_num') this.likeNum = 0,
    @JsonKey(name: 'is_like') this.isLike = false,
    @JsonKey(name: 'replynum') this.replyNum = 0,
    @JsonKey(name: 'replyRows') final List<ReplyData> replyRows = const [],
    @JsonKey(name: 'replyRowsMore') this.replyRowsMore = false,
    @JsonKey(name: 'reply_to') this.replyTo,
    @JsonKey(name: 'reply_uid') this.replyUid,
  }) : _picArr = picArr,
       _replyRows = replyRows;

  factory _$ReplyDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplyDataImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'uid')
  final String uid;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'avatar')
  final String? avatar;
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
  @JsonKey(name: 'dateline')
  final String dateline;
  @override
  @JsonKey(name: 'like_num')
  final int likeNum;
  @override
  @JsonKey(name: 'is_like')
  final bool isLike;
  @override
  @JsonKey(name: 'replynum')
  final int replyNum;
  final List<ReplyData> _replyRows;
  @override
  @JsonKey(name: 'replyRows')
  List<ReplyData> get replyRows {
    if (_replyRows is EqualUnmodifiableListView) return _replyRows;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replyRows);
  }

  @override
  @JsonKey(name: 'replyRowsMore')
  final bool replyRowsMore;
  @override
  @JsonKey(name: 'reply_to')
  final String? replyTo;
  @override
  @JsonKey(name: 'reply_uid')
  final String? replyUid;

  @override
  String toString() {
    return 'ReplyData(id: $id, uid: $uid, username: $username, avatar: $avatar, message: $message, picArr: $picArr, dateline: $dateline, likeNum: $likeNum, isLike: $isLike, replyNum: $replyNum, replyRows: $replyRows, replyRowsMore: $replyRowsMore, replyTo: $replyTo, replyUid: $replyUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._picArr, _picArr) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.likeNum, likeNum) || other.likeNum == likeNum) &&
            (identical(other.isLike, isLike) || other.isLike == isLike) &&
            (identical(other.replyNum, replyNum) ||
                other.replyNum == replyNum) &&
            const DeepCollectionEquality().equals(
              other._replyRows,
              _replyRows,
            ) &&
            (identical(other.replyRowsMore, replyRowsMore) ||
                other.replyRowsMore == replyRowsMore) &&
            (identical(other.replyTo, replyTo) || other.replyTo == replyTo) &&
            (identical(other.replyUid, replyUid) ||
                other.replyUid == replyUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    uid,
    username,
    avatar,
    message,
    const DeepCollectionEquality().hash(_picArr),
    dateline,
    likeNum,
    isLike,
    replyNum,
    const DeepCollectionEquality().hash(_replyRows),
    replyRowsMore,
    replyTo,
    replyUid,
  );

  /// Create a copy of ReplyData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyDataImplCopyWith<_$ReplyDataImpl> get copyWith =>
      __$$ReplyDataImplCopyWithImpl<_$ReplyDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplyDataImplToJson(this);
  }
}

abstract class _ReplyData implements ReplyData {
  const factory _ReplyData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'uid') required final String uid,
    @JsonKey(name: 'username') final String username,
    @JsonKey(name: 'avatar') final String? avatar,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'picArr') final List<String> picArr,
    @JsonKey(name: 'dateline') final String dateline,
    @JsonKey(name: 'like_num') final int likeNum,
    @JsonKey(name: 'is_like') final bool isLike,
    @JsonKey(name: 'replynum') final int replyNum,
    @JsonKey(name: 'replyRows') final List<ReplyData> replyRows,
    @JsonKey(name: 'replyRowsMore') final bool replyRowsMore,
    @JsonKey(name: 'reply_to') final String? replyTo,
    @JsonKey(name: 'reply_uid') final String? replyUid,
  }) = _$ReplyDataImpl;

  factory _ReplyData.fromJson(Map<String, dynamic> json) =
      _$ReplyDataImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'uid')
  String get uid;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'avatar')
  String? get avatar;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr;
  @override
  @JsonKey(name: 'dateline')
  String get dateline;
  @override
  @JsonKey(name: 'like_num')
  int get likeNum;
  @override
  @JsonKey(name: 'is_like')
  bool get isLike;
  @override
  @JsonKey(name: 'replynum')
  int get replyNum;
  @override
  @JsonKey(name: 'replyRows')
  List<ReplyData> get replyRows;
  @override
  @JsonKey(name: 'replyRowsMore')
  bool get replyRowsMore;
  @override
  @JsonKey(name: 'reply_to')
  String? get replyTo;
  @override
  @JsonKey(name: 'reply_uid')
  String? get replyUid;

  /// Create a copy of ReplyData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplyDataImplCopyWith<_$ReplyDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateReplyRequest _$CreateReplyRequestFromJson(Map<String, dynamic> json) {
  return _CreateReplyRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateReplyRequest {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'picArr')
  List<String> get picArr => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_id')
  String? get replyId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_uid')
  String? get replyUid => throw _privateConstructorUsedError;

  /// Serializes this CreateReplyRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateReplyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateReplyRequestCopyWith<CreateReplyRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReplyRequestCopyWith<$Res> {
  factory $CreateReplyRequestCopyWith(
    CreateReplyRequest value,
    $Res Function(CreateReplyRequest) then,
  ) = _$CreateReplyRequestCopyWithImpl<$Res, CreateReplyRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'reply_id') String? replyId,
    @JsonKey(name: 'reply_uid') String? replyUid,
  });
}

/// @nodoc
class _$CreateReplyRequestCopyWithImpl<$Res, $Val extends CreateReplyRequest>
    implements $CreateReplyRequestCopyWith<$Res> {
  _$CreateReplyRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateReplyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? message = null,
    Object? picArr = null,
    Object? replyId = freezed,
    Object? replyUid = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            picArr: null == picArr
                ? _value.picArr
                : picArr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            replyId: freezed == replyId
                ? _value.replyId
                : replyId // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyUid: freezed == replyUid
                ? _value.replyUid
                : replyUid // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CreateReplyRequestImplCopyWith<$Res>
    implements $CreateReplyRequestCopyWith<$Res> {
  factory _$$CreateReplyRequestImplCopyWith(
    _$CreateReplyRequestImpl value,
    $Res Function(_$CreateReplyRequestImpl) then,
  ) = __$$CreateReplyRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'reply_id') String? replyId,
    @JsonKey(name: 'reply_uid') String? replyUid,
  });
}

/// @nodoc
class __$$CreateReplyRequestImplCopyWithImpl<$Res>
    extends _$CreateReplyRequestCopyWithImpl<$Res, _$CreateReplyRequestImpl>
    implements _$$CreateReplyRequestImplCopyWith<$Res> {
  __$$CreateReplyRequestImplCopyWithImpl(
    _$CreateReplyRequestImpl _value,
    $Res Function(_$CreateReplyRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateReplyRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? message = null,
    Object? picArr = null,
    Object? replyId = freezed,
    Object? replyUid = freezed,
  }) {
    return _then(
      _$CreateReplyRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        picArr: null == picArr
            ? _value._picArr
            : picArr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        replyId: freezed == replyId
            ? _value.replyId
            : replyId // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyUid: freezed == replyUid
            ? _value.replyUid
            : replyUid // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReplyRequestImpl implements _CreateReplyRequest {
  const _$CreateReplyRequestImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'message') required this.message,
    @JsonKey(name: 'picArr') final List<String> picArr = const [],
    @JsonKey(name: 'reply_id') this.replyId,
    @JsonKey(name: 'reply_uid') this.replyUid,
  }) : _picArr = picArr;

  factory _$CreateReplyRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateReplyRequestImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
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
  @JsonKey(name: 'reply_id')
  final String? replyId;
  @override
  @JsonKey(name: 'reply_uid')
  final String? replyUid;

  @override
  String toString() {
    return 'CreateReplyRequest(id: $id, message: $message, picArr: $picArr, replyId: $replyId, replyUid: $replyUid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReplyRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._picArr, _picArr) &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.replyUid, replyUid) ||
                other.replyUid == replyUid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    message,
    const DeepCollectionEquality().hash(_picArr),
    replyId,
    replyUid,
  );

  /// Create a copy of CreateReplyRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReplyRequestImplCopyWith<_$CreateReplyRequestImpl> get copyWith =>
      __$$CreateReplyRequestImplCopyWithImpl<_$CreateReplyRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReplyRequestImplToJson(this);
  }
}

abstract class _CreateReplyRequest implements CreateReplyRequest {
  const factory _CreateReplyRequest({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'message') required final String message,
    @JsonKey(name: 'picArr') final List<String> picArr,
    @JsonKey(name: 'reply_id') final String? replyId,
    @JsonKey(name: 'reply_uid') final String? replyUid,
  }) = _$CreateReplyRequestImpl;

  factory _CreateReplyRequest.fromJson(Map<String, dynamic> json) =
      _$CreateReplyRequestImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr;
  @override
  @JsonKey(name: 'reply_id')
  String? get replyId;
  @override
  @JsonKey(name: 'reply_uid')
  String? get replyUid;

  /// Create a copy of CreateReplyRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateReplyRequestImplCopyWith<_$CreateReplyRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateReplyResponse _$CreateReplyResponseFromJson(Map<String, dynamic> json) {
  return _CreateReplyResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateReplyResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  ReplyData? get data => throw _privateConstructorUsedError;

  /// Serializes this CreateReplyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateReplyResponseCopyWith<CreateReplyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateReplyResponseCopyWith<$Res> {
  factory $CreateReplyResponseCopyWith(
    CreateReplyResponse value,
    $Res Function(CreateReplyResponse) then,
  ) = _$CreateReplyResponseCopyWithImpl<$Res, CreateReplyResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') ReplyData? data,
  });

  $ReplyDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$CreateReplyResponseCopyWithImpl<$Res, $Val extends CreateReplyResponse>
    implements $CreateReplyResponseCopyWith<$Res> {
  _$CreateReplyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateReplyResponse
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
                      as ReplyData?,
          )
          as $Val,
    );
  }

  /// Create a copy of CreateReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ReplyDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ReplyDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateReplyResponseImplCopyWith<$Res>
    implements $CreateReplyResponseCopyWith<$Res> {
  factory _$$CreateReplyResponseImplCopyWith(
    _$CreateReplyResponseImpl value,
    $Res Function(_$CreateReplyResponseImpl) then,
  ) = __$$CreateReplyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') ReplyData? data,
  });

  @override
  $ReplyDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$CreateReplyResponseImplCopyWithImpl<$Res>
    extends _$CreateReplyResponseCopyWithImpl<$Res, _$CreateReplyResponseImpl>
    implements _$$CreateReplyResponseImplCopyWith<$Res> {
  __$$CreateReplyResponseImplCopyWithImpl(
    _$CreateReplyResponseImpl _value,
    $Res Function(_$CreateReplyResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CreateReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$CreateReplyResponseImpl(
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
                  as ReplyData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateReplyResponseImpl implements _CreateReplyResponse {
  const _$CreateReplyResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') this.data,
  });

  factory _$CreateReplyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateReplyResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'data')
  final ReplyData? data;

  @override
  String toString() {
    return 'CreateReplyResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateReplyResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of CreateReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateReplyResponseImplCopyWith<_$CreateReplyResponseImpl> get copyWith =>
      __$$CreateReplyResponseImplCopyWithImpl<_$CreateReplyResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateReplyResponseImplToJson(this);
  }
}

abstract class _CreateReplyResponse implements CreateReplyResponse {
  const factory _CreateReplyResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final ReplyData? data,
  }) = _$CreateReplyResponseImpl;

  factory _CreateReplyResponse.fromJson(Map<String, dynamic> json) =
      _$CreateReplyResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  ReplyData? get data;

  /// Create a copy of CreateReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateReplyResponseImplCopyWith<_$CreateReplyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SubReplyResponse _$SubReplyResponseFromJson(Map<String, dynamic> json) {
  return _SubReplyResponse.fromJson(json);
}

/// @nodoc
mixin _$SubReplyResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<ReplyData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  /// Serializes this SubReplyResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubReplyResponseCopyWith<SubReplyResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubReplyResponseCopyWith<$Res> {
  factory $SubReplyResponseCopyWith(
    SubReplyResponse value,
    $Res Function(SubReplyResponse) then,
  ) = _$SubReplyResponseCopyWithImpl<$Res, SubReplyResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ReplyData> data,
    @JsonKey(name: 'total') int total,
  });
}

/// @nodoc
class _$SubReplyResponseCopyWithImpl<$Res, $Val extends SubReplyResponse>
    implements $SubReplyResponseCopyWith<$Res> {
  _$SubReplyResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
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
                      as List<ReplyData>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SubReplyResponseImplCopyWith<$Res>
    implements $SubReplyResponseCopyWith<$Res> {
  factory _$$SubReplyResponseImplCopyWith(
    _$SubReplyResponseImpl value,
    $Res Function(_$SubReplyResponseImpl) then,
  ) = __$$SubReplyResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ReplyData> data,
    @JsonKey(name: 'total') int total,
  });
}

/// @nodoc
class __$$SubReplyResponseImplCopyWithImpl<$Res>
    extends _$SubReplyResponseCopyWithImpl<$Res, _$SubReplyResponseImpl>
    implements _$$SubReplyResponseImplCopyWith<$Res> {
  __$$SubReplyResponseImplCopyWithImpl(
    _$SubReplyResponseImpl _value,
    $Res Function(_$SubReplyResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SubReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
  }) {
    return _then(
      _$SubReplyResponseImpl(
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
                  as List<ReplyData>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SubReplyResponseImpl implements _SubReplyResponse {
  const _$SubReplyResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<ReplyData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
  }) : _data = data;

  factory _$SubReplyResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubReplyResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<ReplyData> _data;
  @override
  @JsonKey(name: 'data')
  List<ReplyData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'SubReplyResponse(status: $status, message: $message, data: $data, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubReplyResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
    total,
  );

  /// Create a copy of SubReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubReplyResponseImplCopyWith<_$SubReplyResponseImpl> get copyWith =>
      __$$SubReplyResponseImplCopyWithImpl<_$SubReplyResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SubReplyResponseImplToJson(this);
  }
}

abstract class _SubReplyResponse implements SubReplyResponse {
  const factory _SubReplyResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<ReplyData> data,
    @JsonKey(name: 'total') final int total,
  }) = _$SubReplyResponseImpl;

  factory _SubReplyResponse.fromJson(Map<String, dynamic> json) =
      _$SubReplyResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<ReplyData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;

  /// Create a copy of SubReplyResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubReplyResponseImplCopyWith<_$SubReplyResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
