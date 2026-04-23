// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MessageResponse _$MessageResponseFromJson(Map<String, dynamic> json) {
  return _MessageResponse.fromJson(json);
}

/// @nodoc
mixin _$MessageResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<MessageData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool get hasMore => throw _privateConstructorUsedError;

  /// Serializes this MessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageResponseCopyWith<MessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageResponseCopyWith<$Res> {
  factory $MessageResponseCopyWith(
    MessageResponse value,
    $Res Function(MessageResponse) then,
  ) = _$MessageResponseCopyWithImpl<$Res, MessageResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<MessageData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class _$MessageResponseCopyWithImpl<$Res, $Val extends MessageResponse>
    implements $MessageResponseCopyWith<$Res> {
  _$MessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? hasMore = null,
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
                      as List<MessageData>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageResponseImplCopyWith<$Res>
    implements $MessageResponseCopyWith<$Res> {
  factory _$$MessageResponseImplCopyWith(
    _$MessageResponseImpl value,
    $Res Function(_$MessageResponseImpl) then,
  ) = __$$MessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<MessageData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class __$$MessageResponseImplCopyWithImpl<$Res>
    extends _$MessageResponseCopyWithImpl<$Res, _$MessageResponseImpl>
    implements _$$MessageResponseImplCopyWith<$Res> {
  __$$MessageResponseImplCopyWithImpl(
    _$MessageResponseImpl _value,
    $Res Function(_$MessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$MessageResponseImpl(
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
                  as List<MessageData>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageResponseImpl implements _MessageResponse {
  const _$MessageResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<MessageData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'page') this.page = 1,
    @JsonKey(name: 'has_more') this.hasMore = false,
  }) : _data = data;

  factory _$MessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<MessageData> _data;
  @override
  @JsonKey(name: 'data')
  List<MessageData> get data {
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
  @JsonKey(name: 'has_more')
  final bool hasMore;

  @override
  String toString() {
    return 'MessageResponse(status: $status, message: $message, data: $data, total: $total, page: $page, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
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
    hasMore,
  );

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageResponseImplCopyWith<_$MessageResponseImpl> get copyWith =>
      __$$MessageResponseImplCopyWithImpl<_$MessageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageResponseImplToJson(this);
  }
}

abstract class _MessageResponse implements MessageResponse {
  const factory _MessageResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<MessageData> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'page') final int page,
    @JsonKey(name: 'has_more') final bool hasMore,
  }) = _$MessageResponseImpl;

  factory _MessageResponse.fromJson(Map<String, dynamic> json) =
      _$MessageResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<MessageData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'has_more')
  bool get hasMore;

  /// Create a copy of MessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageResponseImplCopyWith<_$MessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageData _$MessageDataFromJson(Map<String, dynamic> json) {
  return _MessageData.fromJson(json);
}

/// @nodoc
mixin _$MessageData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_uid')
  String get fromUid => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_uid')
  String get toUid => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'is_read')
  bool get isRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_type')
  String get messageType => throw _privateConstructorUsedError;

  /// Serializes this MessageData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageDataCopyWith<MessageData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageDataCopyWith<$Res> {
  factory $MessageDataCopyWith(
    MessageData value,
    $Res Function(MessageData) then,
  ) = _$MessageDataCopyWithImpl<$Res, MessageData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'from_uid') String fromUid,
    @JsonKey(name: 'to_uid') String toUid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'message_type') String messageType,
  });
}

/// @nodoc
class _$MessageDataCopyWithImpl<$Res, $Val extends MessageData>
    implements $MessageDataCopyWith<$Res> {
  _$MessageDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUid = null,
    Object? toUid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? dateline = null,
    Object? isRead = null,
    Object? messageType = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fromUid: null == fromUid
                ? _value.fromUid
                : fromUid // ignore: cast_nullable_to_non_nullable
                      as String,
            toUid: null == toUid
                ? _value.toUid
                : toUid // ignore: cast_nullable_to_non_nullable
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
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            messageType: null == messageType
                ? _value.messageType
                : messageType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MessageDataImplCopyWith<$Res>
    implements $MessageDataCopyWith<$Res> {
  factory _$$MessageDataImplCopyWith(
    _$MessageDataImpl value,
    $Res Function(_$MessageDataImpl) then,
  ) = __$$MessageDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'from_uid') String fromUid,
    @JsonKey(name: 'to_uid') String toUid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'dateline') String dateline,
    @JsonKey(name: 'is_read') bool isRead,
    @JsonKey(name: 'message_type') String messageType,
  });
}

/// @nodoc
class __$$MessageDataImplCopyWithImpl<$Res>
    extends _$MessageDataCopyWithImpl<$Res, _$MessageDataImpl>
    implements _$$MessageDataImplCopyWith<$Res> {
  __$$MessageDataImplCopyWithImpl(
    _$MessageDataImpl _value,
    $Res Function(_$MessageDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MessageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fromUid = null,
    Object? toUid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? message = null,
    Object? picArr = null,
    Object? dateline = null,
    Object? isRead = null,
    Object? messageType = null,
  }) {
    return _then(
      _$MessageDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fromUid: null == fromUid
            ? _value.fromUid
            : fromUid // ignore: cast_nullable_to_non_nullable
                  as String,
        toUid: null == toUid
            ? _value.toUid
            : toUid // ignore: cast_nullable_to_non_nullable
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
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        messageType: null == messageType
            ? _value.messageType
            : messageType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageDataImpl implements _MessageData {
  const _$MessageDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'from_uid') required this.fromUid,
    @JsonKey(name: 'to_uid') required this.toUid,
    @JsonKey(name: 'username') this.username = '',
    @JsonKey(name: 'avatar') this.avatar,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'picArr') final List<String> picArr = const [],
    @JsonKey(name: 'dateline') this.dateline = '',
    @JsonKey(name: 'is_read') this.isRead = false,
    @JsonKey(name: 'message_type') this.messageType = 'text',
  }) : _picArr = picArr;

  factory _$MessageDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageDataImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'from_uid')
  final String fromUid;
  @override
  @JsonKey(name: 'to_uid')
  final String toUid;
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
  @JsonKey(name: 'is_read')
  final bool isRead;
  @override
  @JsonKey(name: 'message_type')
  final String messageType;

  @override
  String toString() {
    return 'MessageData(id: $id, fromUid: $fromUid, toUid: $toUid, username: $username, avatar: $avatar, message: $message, picArr: $picArr, dateline: $dateline, isRead: $isRead, messageType: $messageType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fromUid, fromUid) || other.fromUid == fromUid) &&
            (identical(other.toUid, toUid) || other.toUid == toUid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._picArr, _picArr) &&
            (identical(other.dateline, dateline) ||
                other.dateline == dateline) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fromUid,
    toUid,
    username,
    avatar,
    message,
    const DeepCollectionEquality().hash(_picArr),
    dateline,
    isRead,
    messageType,
  );

  /// Create a copy of MessageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageDataImplCopyWith<_$MessageDataImpl> get copyWith =>
      __$$MessageDataImplCopyWithImpl<_$MessageDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageDataImplToJson(this);
  }
}

abstract class _MessageData implements MessageData {
  const factory _MessageData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'from_uid') required final String fromUid,
    @JsonKey(name: 'to_uid') required final String toUid,
    @JsonKey(name: 'username') final String username,
    @JsonKey(name: 'avatar') final String? avatar,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'picArr') final List<String> picArr,
    @JsonKey(name: 'dateline') final String dateline,
    @JsonKey(name: 'is_read') final bool isRead,
    @JsonKey(name: 'message_type') final String messageType,
  }) = _$MessageDataImpl;

  factory _MessageData.fromJson(Map<String, dynamic> json) =
      _$MessageDataImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'from_uid')
  String get fromUid;
  @override
  @JsonKey(name: 'to_uid')
  String get toUid;
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
  @JsonKey(name: 'is_read')
  bool get isRead;
  @override
  @JsonKey(name: 'message_type')
  String get messageType;

  /// Create a copy of MessageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageDataImplCopyWith<_$MessageDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationResponse _$ConversationResponseFromJson(Map<String, dynamic> json) {
  return _ConversationResponse.fromJson(json);
}

/// @nodoc
mixin _$ConversationResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<ConversationData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;

  /// Serializes this ConversationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationResponseCopyWith<ConversationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationResponseCopyWith<$Res> {
  factory $ConversationResponseCopyWith(
    ConversationResponse value,
    $Res Function(ConversationResponse) then,
  ) = _$ConversationResponseCopyWithImpl<$Res, ConversationResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ConversationData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'unread_count') int unreadCount,
  });
}

/// @nodoc
class _$ConversationResponseCopyWithImpl<
  $Res,
  $Val extends ConversationResponse
>
    implements $ConversationResponseCopyWith<$Res> {
  _$ConversationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
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
                      as List<ConversationData>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ConversationResponseImplCopyWith<$Res>
    implements $ConversationResponseCopyWith<$Res> {
  factory _$$ConversationResponseImplCopyWith(
    _$ConversationResponseImpl value,
    $Res Function(_$ConversationResponseImpl) then,
  ) = __$$ConversationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ConversationData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'unread_count') int unreadCount,
  });
}

/// @nodoc
class __$$ConversationResponseImplCopyWithImpl<$Res>
    extends _$ConversationResponseCopyWithImpl<$Res, _$ConversationResponseImpl>
    implements _$$ConversationResponseImplCopyWith<$Res> {
  __$$ConversationResponseImplCopyWithImpl(
    _$ConversationResponseImpl _value,
    $Res Function(_$ConversationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? unreadCount = null,
  }) {
    return _then(
      _$ConversationResponseImpl(
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
                  as List<ConversationData>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
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
class _$ConversationResponseImpl implements _ConversationResponse {
  const _$ConversationResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<ConversationData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
  }) : _data = data;

  factory _$ConversationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<ConversationData> _data;
  @override
  @JsonKey(name: 'data')
  List<ConversationData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'total')
  final int total;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;

  @override
  String toString() {
    return 'ConversationResponse(status: $status, message: $message, data: $data, total: $total, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
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
    unreadCount,
  );

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationResponseImplCopyWith<_$ConversationResponseImpl>
  get copyWith =>
      __$$ConversationResponseImplCopyWithImpl<_$ConversationResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationResponseImplToJson(this);
  }
}

abstract class _ConversationResponse implements ConversationResponse {
  const factory _ConversationResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<ConversationData> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'unread_count') final int unreadCount,
  }) = _$ConversationResponseImpl;

  factory _ConversationResponse.fromJson(Map<String, dynamic> json) =
      _$ConversationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<ConversationData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;

  /// Create a copy of ConversationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationResponseImplCopyWith<_$ConversationResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ConversationData _$ConversationDataFromJson(Map<String, dynamic> json) {
  return _ConversationData.fromJson(json);
}

/// @nodoc
mixin _$ConversationData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'uid')
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar')
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  String get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_dateline')
  String get lastDateline => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_top')
  bool get isTop => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_mute')
  bool get isMute => throw _privateConstructorUsedError;

  /// Serializes this ConversationData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationDataCopyWith<ConversationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationDataCopyWith<$Res> {
  factory $ConversationDataCopyWith(
    ConversationData value,
    $Res Function(ConversationData) then,
  ) = _$ConversationDataCopyWithImpl<$Res, ConversationData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'uid') String uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'last_message') String lastMessage,
    @JsonKey(name: 'last_dateline') String lastDateline,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'is_top') bool isTop,
    @JsonKey(name: 'is_mute') bool isMute,
  });
}

/// @nodoc
class _$ConversationDataCopyWithImpl<$Res, $Val extends ConversationData>
    implements $ConversationDataCopyWith<$Res> {
  _$ConversationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? lastMessage = null,
    Object? lastDateline = null,
    Object? unreadCount = null,
    Object? isTop = null,
    Object? isMute = null,
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
            lastMessage: null == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            lastDateline: null == lastDateline
                ? _value.lastDateline
                : lastDateline // ignore: cast_nullable_to_non_nullable
                      as String,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isTop: null == isTop
                ? _value.isTop
                : isTop // ignore: cast_nullable_to_non_nullable
                      as bool,
            isMute: null == isMute
                ? _value.isMute
                : isMute // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConversationDataImplCopyWith<$Res>
    implements $ConversationDataCopyWith<$Res> {
  factory _$$ConversationDataImplCopyWith(
    _$ConversationDataImpl value,
    $Res Function(_$ConversationDataImpl) then,
  ) = __$$ConversationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'uid') String uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'last_message') String lastMessage,
    @JsonKey(name: 'last_dateline') String lastDateline,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'is_top') bool isTop,
    @JsonKey(name: 'is_mute') bool isMute,
  });
}

/// @nodoc
class __$$ConversationDataImplCopyWithImpl<$Res>
    extends _$ConversationDataCopyWithImpl<$Res, _$ConversationDataImpl>
    implements _$$ConversationDataImplCopyWith<$Res> {
  __$$ConversationDataImplCopyWithImpl(
    _$ConversationDataImpl _value,
    $Res Function(_$ConversationDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? lastMessage = null,
    Object? lastDateline = null,
    Object? unreadCount = null,
    Object? isTop = null,
    Object? isMute = null,
  }) {
    return _then(
      _$ConversationDataImpl(
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
        lastMessage: null == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        lastDateline: null == lastDateline
            ? _value.lastDateline
            : lastDateline // ignore: cast_nullable_to_non_nullable
                  as String,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isTop: null == isTop
            ? _value.isTop
            : isTop // ignore: cast_nullable_to_non_nullable
                  as bool,
        isMute: null == isMute
            ? _value.isMute
            : isMute // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationDataImpl implements _ConversationData {
  const _$ConversationDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'uid') required this.uid,
    @JsonKey(name: 'username') this.username = '',
    @JsonKey(name: 'avatar') this.avatar,
    @JsonKey(name: 'last_message') this.lastMessage = '',
    @JsonKey(name: 'last_dateline') this.lastDateline = '',
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    @JsonKey(name: 'is_top') this.isTop = false,
    @JsonKey(name: 'is_mute') this.isMute = false,
  });

  factory _$ConversationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationDataImplFromJson(json);

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
  @JsonKey(name: 'last_message')
  final String lastMessage;
  @override
  @JsonKey(name: 'last_dateline')
  final String lastDateline;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey(name: 'is_top')
  final bool isTop;
  @override
  @JsonKey(name: 'is_mute')
  final bool isMute;

  @override
  String toString() {
    return 'ConversationData(id: $id, uid: $uid, username: $username, avatar: $avatar, lastMessage: $lastMessage, lastDateline: $lastDateline, unreadCount: $unreadCount, isTop: $isTop, isMute: $isMute)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastDateline, lastDateline) ||
                other.lastDateline == lastDateline) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isTop, isTop) || other.isTop == isTop) &&
            (identical(other.isMute, isMute) || other.isMute == isMute));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    uid,
    username,
    avatar,
    lastMessage,
    lastDateline,
    unreadCount,
    isTop,
    isMute,
  );

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationDataImplCopyWith<_$ConversationDataImpl> get copyWith =>
      __$$ConversationDataImplCopyWithImpl<_$ConversationDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationDataImplToJson(this);
  }
}

abstract class _ConversationData implements ConversationData {
  const factory _ConversationData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'uid') required final String uid,
    @JsonKey(name: 'username') final String username,
    @JsonKey(name: 'avatar') final String? avatar,
    @JsonKey(name: 'last_message') final String lastMessage,
    @JsonKey(name: 'last_dateline') final String lastDateline,
    @JsonKey(name: 'unread_count') final int unreadCount,
    @JsonKey(name: 'is_top') final bool isTop,
    @JsonKey(name: 'is_mute') final bool isMute,
  }) = _$ConversationDataImpl;

  factory _ConversationData.fromJson(Map<String, dynamic> json) =
      _$ConversationDataImpl.fromJson;

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
  @JsonKey(name: 'last_message')
  String get lastMessage;
  @override
  @JsonKey(name: 'last_dateline')
  String get lastDateline;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  @JsonKey(name: 'is_top')
  bool get isTop;
  @override
  @JsonKey(name: 'is_mute')
  bool get isMute;

  /// Create a copy of ConversationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationDataImplCopyWith<_$ConversationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) {
  return _SendMessageRequest.fromJson(json);
}

/// @nodoc
mixin _$SendMessageRequest {
  @JsonKey(name: 'to_uid')
  String get toUid => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'picArr')
  List<String> get picArr => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_type')
  String get messageType => throw _privateConstructorUsedError;

  /// Serializes this SendMessageRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMessageRequestCopyWith<SendMessageRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageRequestCopyWith<$Res> {
  factory $SendMessageRequestCopyWith(
    SendMessageRequest value,
    $Res Function(SendMessageRequest) then,
  ) = _$SendMessageRequestCopyWithImpl<$Res, SendMessageRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'to_uid') String toUid,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'message_type') String messageType,
  });
}

/// @nodoc
class _$SendMessageRequestCopyWithImpl<$Res, $Val extends SendMessageRequest>
    implements $SendMessageRequestCopyWith<$Res> {
  _$SendMessageRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toUid = null,
    Object? message = null,
    Object? picArr = null,
    Object? messageType = null,
  }) {
    return _then(
      _value.copyWith(
            toUid: null == toUid
                ? _value.toUid
                : toUid // ignore: cast_nullable_to_non_nullable
                      as String,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            picArr: null == picArr
                ? _value.picArr
                : picArr // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            messageType: null == messageType
                ? _value.messageType
                : messageType // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SendMessageRequestImplCopyWith<$Res>
    implements $SendMessageRequestCopyWith<$Res> {
  factory _$$SendMessageRequestImplCopyWith(
    _$SendMessageRequestImpl value,
    $Res Function(_$SendMessageRequestImpl) then,
  ) = __$$SendMessageRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'to_uid') String toUid,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'picArr') List<String> picArr,
    @JsonKey(name: 'message_type') String messageType,
  });
}

/// @nodoc
class __$$SendMessageRequestImplCopyWithImpl<$Res>
    extends _$SendMessageRequestCopyWithImpl<$Res, _$SendMessageRequestImpl>
    implements _$$SendMessageRequestImplCopyWith<$Res> {
  __$$SendMessageRequestImplCopyWithImpl(
    _$SendMessageRequestImpl _value,
    $Res Function(_$SendMessageRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toUid = null,
    Object? message = null,
    Object? picArr = null,
    Object? messageType = null,
  }) {
    return _then(
      _$SendMessageRequestImpl(
        toUid: null == toUid
            ? _value.toUid
            : toUid // ignore: cast_nullable_to_non_nullable
                  as String,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        picArr: null == picArr
            ? _value._picArr
            : picArr // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        messageType: null == messageType
            ? _value.messageType
            : messageType // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMessageRequestImpl implements _SendMessageRequest {
  const _$SendMessageRequestImpl({
    @JsonKey(name: 'to_uid') required this.toUid,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'picArr') final List<String> picArr = const [],
    @JsonKey(name: 'message_type') this.messageType = 'text',
  }) : _picArr = picArr;

  factory _$SendMessageRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMessageRequestImplFromJson(json);

  @override
  @JsonKey(name: 'to_uid')
  final String toUid;
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
  @JsonKey(name: 'message_type')
  final String messageType;

  @override
  String toString() {
    return 'SendMessageRequest(toUid: $toUid, message: $message, picArr: $picArr, messageType: $messageType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageRequestImpl &&
            (identical(other.toUid, toUid) || other.toUid == toUid) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._picArr, _picArr) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    toUid,
    message,
    const DeepCollectionEquality().hash(_picArr),
    messageType,
  );

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageRequestImplCopyWith<_$SendMessageRequestImpl> get copyWith =>
      __$$SendMessageRequestImplCopyWithImpl<_$SendMessageRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMessageRequestImplToJson(this);
  }
}

abstract class _SendMessageRequest implements SendMessageRequest {
  const factory _SendMessageRequest({
    @JsonKey(name: 'to_uid') required final String toUid,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'picArr') final List<String> picArr,
    @JsonKey(name: 'message_type') final String messageType,
  }) = _$SendMessageRequestImpl;

  factory _SendMessageRequest.fromJson(Map<String, dynamic> json) =
      _$SendMessageRequestImpl.fromJson;

  @override
  @JsonKey(name: 'to_uid')
  String get toUid;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'picArr')
  List<String> get picArr;
  @override
  @JsonKey(name: 'message_type')
  String get messageType;

  /// Create a copy of SendMessageRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageRequestImplCopyWith<_$SendMessageRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SendMessageResponse _$SendMessageResponseFromJson(Map<String, dynamic> json) {
  return _SendMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$SendMessageResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  MessageData? get data => throw _privateConstructorUsedError;

  /// Serializes this SendMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendMessageResponseCopyWith<SendMessageResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendMessageResponseCopyWith<$Res> {
  factory $SendMessageResponseCopyWith(
    SendMessageResponse value,
    $Res Function(SendMessageResponse) then,
  ) = _$SendMessageResponseCopyWithImpl<$Res, SendMessageResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') MessageData? data,
  });

  $MessageDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$SendMessageResponseCopyWithImpl<$Res, $Val extends SendMessageResponse>
    implements $SendMessageResponseCopyWith<$Res> {
  _$SendMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendMessageResponse
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
                      as MessageData?,
          )
          as $Val,
    );
  }

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $MessageDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SendMessageResponseImplCopyWith<$Res>
    implements $SendMessageResponseCopyWith<$Res> {
  factory _$$SendMessageResponseImplCopyWith(
    _$SendMessageResponseImpl value,
    $Res Function(_$SendMessageResponseImpl) then,
  ) = __$$SendMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') MessageData? data,
  });

  @override
  $MessageDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$SendMessageResponseImplCopyWithImpl<$Res>
    extends _$SendMessageResponseCopyWithImpl<$Res, _$SendMessageResponseImpl>
    implements _$$SendMessageResponseImplCopyWith<$Res> {
  __$$SendMessageResponseImplCopyWithImpl(
    _$SendMessageResponseImpl _value,
    $Res Function(_$SendMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$SendMessageResponseImpl(
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
                  as MessageData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SendMessageResponseImpl implements _SendMessageResponse {
  const _$SendMessageResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') this.data,
  });

  factory _$SendMessageResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$SendMessageResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'data')
  final MessageData? data;

  @override
  String toString() {
    return 'SendMessageResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendMessageResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendMessageResponseImplCopyWith<_$SendMessageResponseImpl> get copyWith =>
      __$$SendMessageResponseImplCopyWithImpl<_$SendMessageResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$SendMessageResponseImplToJson(this);
  }
}

abstract class _SendMessageResponse implements SendMessageResponse {
  const factory _SendMessageResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final MessageData? data,
  }) = _$SendMessageResponseImpl;

  factory _SendMessageResponse.fromJson(Map<String, dynamic> json) =
      _$SendMessageResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  MessageData? get data;

  /// Create a copy of SendMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendMessageResponseImplCopyWith<_$SendMessageResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarkReadRequest _$MarkReadRequestFromJson(Map<String, dynamic> json) {
  return _MarkReadRequest.fromJson(json);
}

/// @nodoc
mixin _$MarkReadRequest {
  @JsonKey(name: 'uid')
  String? get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_ids')
  List<String> get messageIds => throw _privateConstructorUsedError;

  /// Serializes this MarkReadRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkReadRequestCopyWith<MarkReadRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkReadRequestCopyWith<$Res> {
  factory $MarkReadRequestCopyWith(
    MarkReadRequest value,
    $Res Function(MarkReadRequest) then,
  ) = _$MarkReadRequestCopyWithImpl<$Res, MarkReadRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'message_ids') List<String> messageIds,
  });
}

/// @nodoc
class _$MarkReadRequestCopyWithImpl<$Res, $Val extends MarkReadRequest>
    implements $MarkReadRequestCopyWith<$Res> {
  _$MarkReadRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uid = freezed, Object? messageIds = null}) {
    return _then(
      _value.copyWith(
            uid: freezed == uid
                ? _value.uid
                : uid // ignore: cast_nullable_to_non_nullable
                      as String?,
            messageIds: null == messageIds
                ? _value.messageIds
                : messageIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MarkReadRequestImplCopyWith<$Res>
    implements $MarkReadRequestCopyWith<$Res> {
  factory _$$MarkReadRequestImplCopyWith(
    _$MarkReadRequestImpl value,
    $Res Function(_$MarkReadRequestImpl) then,
  ) = __$$MarkReadRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'uid') String? uid,
    @JsonKey(name: 'message_ids') List<String> messageIds,
  });
}

/// @nodoc
class __$$MarkReadRequestImplCopyWithImpl<$Res>
    extends _$MarkReadRequestCopyWithImpl<$Res, _$MarkReadRequestImpl>
    implements _$$MarkReadRequestImplCopyWith<$Res> {
  __$$MarkReadRequestImplCopyWithImpl(
    _$MarkReadRequestImpl _value,
    $Res Function(_$MarkReadRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? uid = freezed, Object? messageIds = null}) {
    return _then(
      _$MarkReadRequestImpl(
        uid: freezed == uid
            ? _value.uid
            : uid // ignore: cast_nullable_to_non_nullable
                  as String?,
        messageIds: null == messageIds
            ? _value._messageIds
            : messageIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MarkReadRequestImpl implements _MarkReadRequest {
  const _$MarkReadRequestImpl({
    @JsonKey(name: 'uid') this.uid,
    @JsonKey(name: 'message_ids') final List<String> messageIds = const [],
  }) : _messageIds = messageIds;

  factory _$MarkReadRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkReadRequestImplFromJson(json);

  @override
  @JsonKey(name: 'uid')
  final String? uid;
  final List<String> _messageIds;
  @override
  @JsonKey(name: 'message_ids')
  List<String> get messageIds {
    if (_messageIds is EqualUnmodifiableListView) return _messageIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messageIds);
  }

  @override
  String toString() {
    return 'MarkReadRequest(uid: $uid, messageIds: $messageIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkReadRequestImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            const DeepCollectionEquality().equals(
              other._messageIds,
              _messageIds,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    uid,
    const DeepCollectionEquality().hash(_messageIds),
  );

  /// Create a copy of MarkReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkReadRequestImplCopyWith<_$MarkReadRequestImpl> get copyWith =>
      __$$MarkReadRequestImplCopyWithImpl<_$MarkReadRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkReadRequestImplToJson(this);
  }
}

abstract class _MarkReadRequest implements MarkReadRequest {
  const factory _MarkReadRequest({
    @JsonKey(name: 'uid') final String? uid,
    @JsonKey(name: 'message_ids') final List<String> messageIds,
  }) = _$MarkReadRequestImpl;

  factory _MarkReadRequest.fromJson(Map<String, dynamic> json) =
      _$MarkReadRequestImpl.fromJson;

  @override
  @JsonKey(name: 'uid')
  String? get uid;
  @override
  @JsonKey(name: 'message_ids')
  List<String> get messageIds;

  /// Create a copy of MarkReadRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkReadRequestImplCopyWith<_$MarkReadRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MarkReadResponse _$MarkReadResponseFromJson(Map<String, dynamic> json) {
  return _MarkReadResponse.fromJson(json);
}

/// @nodoc
mixin _$MarkReadResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_count')
  int get updatedCount => throw _privateConstructorUsedError;

  /// Serializes this MarkReadResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MarkReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MarkReadResponseCopyWith<MarkReadResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MarkReadResponseCopyWith<$Res> {
  factory $MarkReadResponseCopyWith(
    MarkReadResponse value,
    $Res Function(MarkReadResponse) then,
  ) = _$MarkReadResponseCopyWithImpl<$Res, MarkReadResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'updated_count') int updatedCount,
  });
}

/// @nodoc
class _$MarkReadResponseCopyWithImpl<$Res, $Val extends MarkReadResponse>
    implements $MarkReadResponseCopyWith<$Res> {
  _$MarkReadResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MarkReadResponse
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
abstract class _$$MarkReadResponseImplCopyWith<$Res>
    implements $MarkReadResponseCopyWith<$Res> {
  factory _$$MarkReadResponseImplCopyWith(
    _$MarkReadResponseImpl value,
    $Res Function(_$MarkReadResponseImpl) then,
  ) = __$$MarkReadResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'updated_count') int updatedCount,
  });
}

/// @nodoc
class __$$MarkReadResponseImplCopyWithImpl<$Res>
    extends _$MarkReadResponseCopyWithImpl<$Res, _$MarkReadResponseImpl>
    implements _$$MarkReadResponseImplCopyWith<$Res> {
  __$$MarkReadResponseImplCopyWithImpl(
    _$MarkReadResponseImpl _value,
    $Res Function(_$MarkReadResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MarkReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? updatedCount = null,
  }) {
    return _then(
      _$MarkReadResponseImpl(
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
class _$MarkReadResponseImpl implements _MarkReadResponse {
  const _$MarkReadResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'updated_count') this.updatedCount = 0,
  });

  factory _$MarkReadResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$MarkReadResponseImplFromJson(json);

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
    return 'MarkReadResponse(status: $status, message: $message, updatedCount: $updatedCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MarkReadResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.updatedCount, updatedCount) ||
                other.updatedCount == updatedCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, updatedCount);

  /// Create a copy of MarkReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MarkReadResponseImplCopyWith<_$MarkReadResponseImpl> get copyWith =>
      __$$MarkReadResponseImplCopyWithImpl<_$MarkReadResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MarkReadResponseImplToJson(this);
  }
}

abstract class _MarkReadResponse implements MarkReadResponse {
  const factory _MarkReadResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'updated_count') final int updatedCount,
  }) = _$MarkReadResponseImpl;

  factory _MarkReadResponse.fromJson(Map<String, dynamic> json) =
      _$MarkReadResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'updated_count')
  int get updatedCount;

  /// Create a copy of MarkReadResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MarkReadResponseImplCopyWith<_$MarkReadResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
