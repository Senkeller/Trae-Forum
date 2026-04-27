// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TopicListResponse _$TopicListResponseFromJson(Map<String, dynamic> json) {
  return _TopicListResponse.fromJson(json);
}

/// @nodoc
mixin _$TopicListResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<TopicData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;

  /// Serializes this TopicListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicListResponseCopyWith<TopicListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicListResponseCopyWith<$Res> {
  factory $TopicListResponseCopyWith(
    TopicListResponse value,
    $Res Function(TopicListResponse) then,
  ) = _$TopicListResponseCopyWithImpl<$Res, TopicListResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<TopicData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
  });
}

/// @nodoc
class _$TopicListResponseCopyWithImpl<$Res, $Val extends TopicListResponse>
    implements $TopicListResponseCopyWith<$Res> {
  _$TopicListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
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
                      as List<TopicData>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TopicListResponseImplCopyWith<$Res>
    implements $TopicListResponseCopyWith<$Res> {
  factory _$$TopicListResponseImplCopyWith(
    _$TopicListResponseImpl value,
    $Res Function(_$TopicListResponseImpl) then,
  ) = __$$TopicListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<TopicData> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
  });
}

/// @nodoc
class __$$TopicListResponseImplCopyWithImpl<$Res>
    extends _$TopicListResponseCopyWithImpl<$Res, _$TopicListResponseImpl>
    implements _$$TopicListResponseImplCopyWith<$Res> {
  __$$TopicListResponseImplCopyWithImpl(
    _$TopicListResponseImpl _value,
    $Res Function(_$TopicListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
  }) {
    return _then(
      _$TopicListResponseImpl(
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
                  as List<TopicData>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicListResponseImpl implements _TopicListResponse {
  const _$TopicListResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<TopicData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'page') this.page = 1,
  }) : _data = data;

  factory _$TopicListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<TopicData> _data;
  @override
  @JsonKey(name: 'data')
  List<TopicData> get data {
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
  String toString() {
    return 'TopicListResponse(status: $status, message: $message, data: $data, total: $total, page: $page)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page));
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
  );

  /// Create a copy of TopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicListResponseImplCopyWith<_$TopicListResponseImpl> get copyWith =>
      __$$TopicListResponseImplCopyWithImpl<_$TopicListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicListResponseImplToJson(this);
  }
}

abstract class _TopicListResponse implements TopicListResponse {
  const factory _TopicListResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<TopicData> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'page') final int page,
  }) = _$TopicListResponseImpl;

  factory _TopicListResponse.fromJson(Map<String, dynamic> json) =
      _$TopicListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<TopicData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;

  /// Create a copy of TopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicListResponseImplCopyWith<_$TopicListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicData _$TopicDataFromJson(Map<String, dynamic> json) {
  return _TopicData.fromJson(json);
}

/// @nodoc
mixin _$TopicData {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover')
  String? get cover => throw _privateConstructorUsedError;
  @JsonKey(name: 'discuss_num')
  int get discussNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'follow_num')
  int get followNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_follow')
  bool get isFollow => throw _privateConstructorUsedError;
  @JsonKey(name: 'creator')
  UserInfo? get creator => throw _privateConstructorUsedError;
  @JsonKey(name: 'create_time')
  String? get createTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_time')
  String? get updateTime => throw _privateConstructorUsedError;

  /// Serializes this TopicData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicDataCopyWith<TopicData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicDataCopyWith<$Res> {
  factory $TopicDataCopyWith(TopicData value, $Res Function(TopicData) then) =
      _$TopicDataCopyWithImpl<$Res, TopicData>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'cover') String? cover,
    @JsonKey(name: 'discuss_num') int discussNum,
    @JsonKey(name: 'follow_num') int followNum,
    @JsonKey(name: 'is_follow') bool isFollow,
    @JsonKey(name: 'creator') UserInfo? creator,
    @JsonKey(name: 'create_time') String? createTime,
    @JsonKey(name: 'update_time') String? updateTime,
  });

  $UserInfoCopyWith<$Res>? get creator;
}

/// @nodoc
class _$TopicDataCopyWithImpl<$Res, $Val extends TopicData>
    implements $TopicDataCopyWith<$Res> {
  _$TopicDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? cover = freezed,
    Object? discussNum = null,
    Object? followNum = null,
    Object? isFollow = null,
    Object? creator = freezed,
    Object? createTime = freezed,
    Object? updateTime = freezed,
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
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            cover: freezed == cover
                ? _value.cover
                : cover // ignore: cast_nullable_to_non_nullable
                      as String?,
            discussNum: null == discussNum
                ? _value.discussNum
                : discussNum // ignore: cast_nullable_to_non_nullable
                      as int,
            followNum: null == followNum
                ? _value.followNum
                : followNum // ignore: cast_nullable_to_non_nullable
                      as int,
            isFollow: null == isFollow
                ? _value.isFollow
                : isFollow // ignore: cast_nullable_to_non_nullable
                      as bool,
            creator: freezed == creator
                ? _value.creator
                : creator // ignore: cast_nullable_to_non_nullable
                      as UserInfo?,
            createTime: freezed == createTime
                ? _value.createTime
                : createTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            updateTime: freezed == updateTime
                ? _value.updateTime
                : updateTime // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of TopicData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res>? get creator {
    if (_value.creator == null) {
      return null;
    }

    return $UserInfoCopyWith<$Res>(_value.creator!, (value) {
      return _then(_value.copyWith(creator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TopicDataImplCopyWith<$Res>
    implements $TopicDataCopyWith<$Res> {
  factory _$$TopicDataImplCopyWith(
    _$TopicDataImpl value,
    $Res Function(_$TopicDataImpl) then,
  ) = __$$TopicDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'description') String description,
    @JsonKey(name: 'cover') String? cover,
    @JsonKey(name: 'discuss_num') int discussNum,
    @JsonKey(name: 'follow_num') int followNum,
    @JsonKey(name: 'is_follow') bool isFollow,
    @JsonKey(name: 'creator') UserInfo? creator,
    @JsonKey(name: 'create_time') String? createTime,
    @JsonKey(name: 'update_time') String? updateTime,
  });

  @override
  $UserInfoCopyWith<$Res>? get creator;
}

/// @nodoc
class __$$TopicDataImplCopyWithImpl<$Res>
    extends _$TopicDataCopyWithImpl<$Res, _$TopicDataImpl>
    implements _$$TopicDataImplCopyWith<$Res> {
  __$$TopicDataImplCopyWithImpl(
    _$TopicDataImpl _value,
    $Res Function(_$TopicDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopicData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? cover = freezed,
    Object? discussNum = null,
    Object? followNum = null,
    Object? isFollow = null,
    Object? creator = freezed,
    Object? createTime = freezed,
    Object? updateTime = freezed,
  }) {
    return _then(
      _$TopicDataImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        cover: freezed == cover
            ? _value.cover
            : cover // ignore: cast_nullable_to_non_nullable
                  as String?,
        discussNum: null == discussNum
            ? _value.discussNum
            : discussNum // ignore: cast_nullable_to_non_nullable
                  as int,
        followNum: null == followNum
            ? _value.followNum
            : followNum // ignore: cast_nullable_to_non_nullable
                  as int,
        isFollow: null == isFollow
            ? _value.isFollow
            : isFollow // ignore: cast_nullable_to_non_nullable
                  as bool,
        creator: freezed == creator
            ? _value.creator
            : creator // ignore: cast_nullable_to_non_nullable
                  as UserInfo?,
        createTime: freezed == createTime
            ? _value.createTime
            : createTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        updateTime: freezed == updateTime
            ? _value.updateTime
            : updateTime // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicDataImpl implements _TopicData {
  const _$TopicDataImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'description') this.description = '',
    @JsonKey(name: 'cover') this.cover,
    @JsonKey(name: 'discuss_num') this.discussNum = 0,
    @JsonKey(name: 'follow_num') this.followNum = 0,
    @JsonKey(name: 'is_follow') this.isFollow = false,
    @JsonKey(name: 'creator') this.creator,
    @JsonKey(name: 'create_time') this.createTime,
    @JsonKey(name: 'update_time') this.updateTime,
  });

  factory _$TopicDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicDataImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'description')
  final String description;
  @override
  @JsonKey(name: 'cover')
  final String? cover;
  @override
  @JsonKey(name: 'discuss_num')
  final int discussNum;
  @override
  @JsonKey(name: 'follow_num')
  final int followNum;
  @override
  @JsonKey(name: 'is_follow')
  final bool isFollow;
  @override
  @JsonKey(name: 'creator')
  final UserInfo? creator;
  @override
  @JsonKey(name: 'create_time')
  final String? createTime;
  @override
  @JsonKey(name: 'update_time')
  final String? updateTime;

  @override
  String toString() {
    return 'TopicData(id: $id, title: $title, description: $description, cover: $cover, discussNum: $discussNum, followNum: $followNum, isFollow: $isFollow, creator: $creator, createTime: $createTime, updateTime: $updateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.discussNum, discussNum) ||
                other.discussNum == discussNum) &&
            (identical(other.followNum, followNum) ||
                other.followNum == followNum) &&
            (identical(other.isFollow, isFollow) ||
                other.isFollow == isFollow) &&
            (identical(other.creator, creator) || other.creator == creator) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    description,
    cover,
    discussNum,
    followNum,
    isFollow,
    creator,
    createTime,
    updateTime,
  );

  /// Create a copy of TopicData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicDataImplCopyWith<_$TopicDataImpl> get copyWith =>
      __$$TopicDataImplCopyWithImpl<_$TopicDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicDataImplToJson(this);
  }
}

abstract class _TopicData implements TopicData {
  const factory _TopicData({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'description') final String description,
    @JsonKey(name: 'cover') final String? cover,
    @JsonKey(name: 'discuss_num') final int discussNum,
    @JsonKey(name: 'follow_num') final int followNum,
    @JsonKey(name: 'is_follow') final bool isFollow,
    @JsonKey(name: 'creator') final UserInfo? creator,
    @JsonKey(name: 'create_time') final String? createTime,
    @JsonKey(name: 'update_time') final String? updateTime,
  }) = _$TopicDataImpl;

  factory _TopicData.fromJson(Map<String, dynamic> json) =
      _$TopicDataImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'description')
  String get description;
  @override
  @JsonKey(name: 'cover')
  String? get cover;
  @override
  @JsonKey(name: 'discuss_num')
  int get discussNum;
  @override
  @JsonKey(name: 'follow_num')
  int get followNum;
  @override
  @JsonKey(name: 'is_follow')
  bool get isFollow;
  @override
  @JsonKey(name: 'creator')
  UserInfo? get creator;
  @override
  @JsonKey(name: 'create_time')
  String? get createTime;
  @override
  @JsonKey(name: 'update_time')
  String? get updateTime;

  /// Create a copy of TopicData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicDataImplCopyWith<_$TopicDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicDetailResponse _$TopicDetailResponseFromJson(Map<String, dynamic> json) {
  return _TopicDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$TopicDetailResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  TopicDetailData? get data => throw _privateConstructorUsedError;

  /// Serializes this TopicDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicDetailResponseCopyWith<TopicDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicDetailResponseCopyWith<$Res> {
  factory $TopicDetailResponseCopyWith(
    TopicDetailResponse value,
    $Res Function(TopicDetailResponse) then,
  ) = _$TopicDetailResponseCopyWithImpl<$Res, TopicDetailResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') TopicDetailData? data,
  });

  $TopicDetailDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$TopicDetailResponseCopyWithImpl<$Res, $Val extends TopicDetailResponse>
    implements $TopicDetailResponseCopyWith<$Res> {
  _$TopicDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicDetailResponse
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
                      as TopicDetailData?,
          )
          as $Val,
    );
  }

  /// Create a copy of TopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TopicDetailDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $TopicDetailDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TopicDetailResponseImplCopyWith<$Res>
    implements $TopicDetailResponseCopyWith<$Res> {
  factory _$$TopicDetailResponseImplCopyWith(
    _$TopicDetailResponseImpl value,
    $Res Function(_$TopicDetailResponseImpl) then,
  ) = __$$TopicDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') TopicDetailData? data,
  });

  @override
  $TopicDetailDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$TopicDetailResponseImplCopyWithImpl<$Res>
    extends _$TopicDetailResponseCopyWithImpl<$Res, _$TopicDetailResponseImpl>
    implements _$$TopicDetailResponseImplCopyWith<$Res> {
  __$$TopicDetailResponseImplCopyWithImpl(
    _$TopicDetailResponseImpl _value,
    $Res Function(_$TopicDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$TopicDetailResponseImpl(
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
                  as TopicDetailData?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicDetailResponseImpl implements _TopicDetailResponse {
  const _$TopicDetailResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') this.data,
  });

  factory _$TopicDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicDetailResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'data')
  final TopicDetailData? data;

  @override
  String toString() {
    return 'TopicDetailResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicDetailResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of TopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicDetailResponseImplCopyWith<_$TopicDetailResponseImpl> get copyWith =>
      __$$TopicDetailResponseImplCopyWithImpl<_$TopicDetailResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicDetailResponseImplToJson(this);
  }
}

abstract class _TopicDetailResponse implements TopicDetailResponse {
  const factory _TopicDetailResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final TopicDetailData? data,
  }) = _$TopicDetailResponseImpl;

  factory _TopicDetailResponse.fromJson(Map<String, dynamic> json) =
      _$TopicDetailResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  TopicDetailData? get data;

  /// Create a copy of TopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicDetailResponseImplCopyWith<_$TopicDetailResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicDetailData _$TopicDetailDataFromJson(Map<String, dynamic> json) {
  return _TopicDetailData.fromJson(json);
}

/// @nodoc
mixin _$TopicDetailData {
  @JsonKey(name: 'topic')
  TopicData get topic => throw _privateConstructorUsedError;
  @JsonKey(name: 'feeds')
  List<dynamic> get feeds => throw _privateConstructorUsedError;
  @JsonKey(name: 'hot_feeds')
  List<dynamic> get hotFeeds => throw _privateConstructorUsedError;
  @JsonKey(name: 'contributors')
  List<UserInfo> get contributors => throw _privateConstructorUsedError;

  /// Serializes this TopicDetailData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicDetailData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicDetailDataCopyWith<TopicDetailData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicDetailDataCopyWith<$Res> {
  factory $TopicDetailDataCopyWith(
    TopicDetailData value,
    $Res Function(TopicDetailData) then,
  ) = _$TopicDetailDataCopyWithImpl<$Res, TopicDetailData>;
  @useResult
  $Res call({
    @JsonKey(name: 'topic') TopicData topic,
    @JsonKey(name: 'feeds') List<dynamic> feeds,
    @JsonKey(name: 'hot_feeds') List<dynamic> hotFeeds,
    @JsonKey(name: 'contributors') List<UserInfo> contributors,
  });

  $TopicDataCopyWith<$Res> get topic;
}

/// @nodoc
class _$TopicDetailDataCopyWithImpl<$Res, $Val extends TopicDetailData>
    implements $TopicDetailDataCopyWith<$Res> {
  _$TopicDetailDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicDetailData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? feeds = null,
    Object? hotFeeds = null,
    Object? contributors = null,
  }) {
    return _then(
      _value.copyWith(
            topic: null == topic
                ? _value.topic
                : topic // ignore: cast_nullable_to_non_nullable
                      as TopicData,
            feeds: null == feeds
                ? _value.feeds
                : feeds // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            hotFeeds: null == hotFeeds
                ? _value.hotFeeds
                : hotFeeds // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            contributors: null == contributors
                ? _value.contributors
                : contributors // ignore: cast_nullable_to_non_nullable
                      as List<UserInfo>,
          )
          as $Val,
    );
  }

  /// Create a copy of TopicDetailData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TopicDataCopyWith<$Res> get topic {
    return $TopicDataCopyWith<$Res>(_value.topic, (value) {
      return _then(_value.copyWith(topic: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TopicDetailDataImplCopyWith<$Res>
    implements $TopicDetailDataCopyWith<$Res> {
  factory _$$TopicDetailDataImplCopyWith(
    _$TopicDetailDataImpl value,
    $Res Function(_$TopicDetailDataImpl) then,
  ) = __$$TopicDetailDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'topic') TopicData topic,
    @JsonKey(name: 'feeds') List<dynamic> feeds,
    @JsonKey(name: 'hot_feeds') List<dynamic> hotFeeds,
    @JsonKey(name: 'contributors') List<UserInfo> contributors,
  });

  @override
  $TopicDataCopyWith<$Res> get topic;
}

/// @nodoc
class __$$TopicDetailDataImplCopyWithImpl<$Res>
    extends _$TopicDetailDataCopyWithImpl<$Res, _$TopicDetailDataImpl>
    implements _$$TopicDetailDataImplCopyWith<$Res> {
  __$$TopicDetailDataImplCopyWithImpl(
    _$TopicDetailDataImpl _value,
    $Res Function(_$TopicDetailDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopicDetailData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? feeds = null,
    Object? hotFeeds = null,
    Object? contributors = null,
  }) {
    return _then(
      _$TopicDetailDataImpl(
        topic: null == topic
            ? _value.topic
            : topic // ignore: cast_nullable_to_non_nullable
                  as TopicData,
        feeds: null == feeds
            ? _value._feeds
            : feeds // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        hotFeeds: null == hotFeeds
            ? _value._hotFeeds
            : hotFeeds // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        contributors: null == contributors
            ? _value._contributors
            : contributors // ignore: cast_nullable_to_non_nullable
                  as List<UserInfo>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicDetailDataImpl implements _TopicDetailData {
  const _$TopicDetailDataImpl({
    @JsonKey(name: 'topic') required this.topic,
    @JsonKey(name: 'feeds') final List<dynamic> feeds = const [],
    @JsonKey(name: 'hot_feeds') final List<dynamic> hotFeeds = const [],
    @JsonKey(name: 'contributors') final List<UserInfo> contributors = const [],
  }) : _feeds = feeds,
       _hotFeeds = hotFeeds,
       _contributors = contributors;

  factory _$TopicDetailDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicDetailDataImplFromJson(json);

  @override
  @JsonKey(name: 'topic')
  final TopicData topic;
  final List<dynamic> _feeds;
  @override
  @JsonKey(name: 'feeds')
  List<dynamic> get feeds {
    if (_feeds is EqualUnmodifiableListView) return _feeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feeds);
  }

  final List<dynamic> _hotFeeds;
  @override
  @JsonKey(name: 'hot_feeds')
  List<dynamic> get hotFeeds {
    if (_hotFeeds is EqualUnmodifiableListView) return _hotFeeds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hotFeeds);
  }

  final List<UserInfo> _contributors;
  @override
  @JsonKey(name: 'contributors')
  List<UserInfo> get contributors {
    if (_contributors is EqualUnmodifiableListView) return _contributors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_contributors);
  }

  @override
  String toString() {
    return 'TopicDetailData(topic: $topic, feeds: $feeds, hotFeeds: $hotFeeds, contributors: $contributors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicDetailDataImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            const DeepCollectionEquality().equals(other._feeds, _feeds) &&
            const DeepCollectionEquality().equals(other._hotFeeds, _hotFeeds) &&
            const DeepCollectionEquality().equals(
              other._contributors,
              _contributors,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    topic,
    const DeepCollectionEquality().hash(_feeds),
    const DeepCollectionEquality().hash(_hotFeeds),
    const DeepCollectionEquality().hash(_contributors),
  );

  /// Create a copy of TopicDetailData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicDetailDataImplCopyWith<_$TopicDetailDataImpl> get copyWith =>
      __$$TopicDetailDataImplCopyWithImpl<_$TopicDetailDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicDetailDataImplToJson(this);
  }
}

abstract class _TopicDetailData implements TopicDetailData {
  const factory _TopicDetailData({
    @JsonKey(name: 'topic') required final TopicData topic,
    @JsonKey(name: 'feeds') final List<dynamic> feeds,
    @JsonKey(name: 'hot_feeds') final List<dynamic> hotFeeds,
    @JsonKey(name: 'contributors') final List<UserInfo> contributors,
  }) = _$TopicDetailDataImpl;

  factory _TopicDetailData.fromJson(Map<String, dynamic> json) =
      _$TopicDetailDataImpl.fromJson;

  @override
  @JsonKey(name: 'topic')
  TopicData get topic;
  @override
  @JsonKey(name: 'feeds')
  List<dynamic> get feeds;
  @override
  @JsonKey(name: 'hot_feeds')
  List<dynamic> get hotFeeds;
  @override
  @JsonKey(name: 'contributors')
  List<UserInfo> get contributors;

  /// Create a copy of TopicDetailData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicDetailDataImplCopyWith<_$TopicDetailDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RecommendTopicResponse _$RecommendTopicResponseFromJson(
  Map<String, dynamic> json,
) {
  return _RecommendTopicResponse.fromJson(json);
}

/// @nodoc
mixin _$RecommendTopicResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<TopicData> get data => throw _privateConstructorUsedError;

  /// Serializes this RecommendTopicResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RecommendTopicResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendTopicResponseCopyWith<RecommendTopicResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendTopicResponseCopyWith<$Res> {
  factory $RecommendTopicResponseCopyWith(
    RecommendTopicResponse value,
    $Res Function(RecommendTopicResponse) then,
  ) = _$RecommendTopicResponseCopyWithImpl<$Res, RecommendTopicResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<TopicData> data,
  });
}

/// @nodoc
class _$RecommendTopicResponseCopyWithImpl<
  $Res,
  $Val extends RecommendTopicResponse
>
    implements $RecommendTopicResponseCopyWith<$Res> {
  _$RecommendTopicResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendTopicResponse
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
                      as List<TopicData>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RecommendTopicResponseImplCopyWith<$Res>
    implements $RecommendTopicResponseCopyWith<$Res> {
  factory _$$RecommendTopicResponseImplCopyWith(
    _$RecommendTopicResponseImpl value,
    $Res Function(_$RecommendTopicResponseImpl) then,
  ) = __$$RecommendTopicResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<TopicData> data,
  });
}

/// @nodoc
class __$$RecommendTopicResponseImplCopyWithImpl<$Res>
    extends
        _$RecommendTopicResponseCopyWithImpl<$Res, _$RecommendTopicResponseImpl>
    implements _$$RecommendTopicResponseImplCopyWith<$Res> {
  __$$RecommendTopicResponseImplCopyWithImpl(
    _$RecommendTopicResponseImpl _value,
    $Res Function(_$RecommendTopicResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RecommendTopicResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$RecommendTopicResponseImpl(
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
                  as List<TopicData>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RecommendTopicResponseImpl implements _RecommendTopicResponse {
  const _$RecommendTopicResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<TopicData> data = const [],
  }) : _data = data;

  factory _$RecommendTopicResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecommendTopicResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<TopicData> _data;
  @override
  @JsonKey(name: 'data')
  List<TopicData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'RecommendTopicResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendTopicResponseImpl &&
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

  /// Create a copy of RecommendTopicResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendTopicResponseImplCopyWith<_$RecommendTopicResponseImpl>
  get copyWith =>
      __$$RecommendTopicResponseImplCopyWithImpl<_$RecommendTopicResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RecommendTopicResponseImplToJson(this);
  }
}

abstract class _RecommendTopicResponse implements RecommendTopicResponse {
  const factory _RecommendTopicResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<TopicData> data,
  }) = _$RecommendTopicResponseImpl;

  factory _RecommendTopicResponse.fromJson(Map<String, dynamic> json) =
      _$RecommendTopicResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<TopicData> get data;

  /// Create a copy of RecommendTopicResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendTopicResponseImplCopyWith<_$RecommendTopicResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

TopicSearchResponse _$TopicSearchResponseFromJson(Map<String, dynamic> json) {
  return _TopicSearchResponse.fromJson(json);
}

/// @nodoc
mixin _$TopicSearchResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<TopicData> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;

  /// Serializes this TopicSearchResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicSearchResponseCopyWith<TopicSearchResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicSearchResponseCopyWith<$Res> {
  factory $TopicSearchResponseCopyWith(
    TopicSearchResponse value,
    $Res Function(TopicSearchResponse) then,
  ) = _$TopicSearchResponseCopyWithImpl<$Res, TopicSearchResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<TopicData> data,
    @JsonKey(name: 'total') int total,
  });
}

/// @nodoc
class _$TopicSearchResponseCopyWithImpl<$Res, $Val extends TopicSearchResponse>
    implements $TopicSearchResponseCopyWith<$Res> {
  _$TopicSearchResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicSearchResponse
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
                      as List<TopicData>,
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
abstract class _$$TopicSearchResponseImplCopyWith<$Res>
    implements $TopicSearchResponseCopyWith<$Res> {
  factory _$$TopicSearchResponseImplCopyWith(
    _$TopicSearchResponseImpl value,
    $Res Function(_$TopicSearchResponseImpl) then,
  ) = __$$TopicSearchResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<TopicData> data,
    @JsonKey(name: 'total') int total,
  });
}

/// @nodoc
class __$$TopicSearchResponseImplCopyWithImpl<$Res>
    extends _$TopicSearchResponseCopyWithImpl<$Res, _$TopicSearchResponseImpl>
    implements _$$TopicSearchResponseImplCopyWith<$Res> {
  __$$TopicSearchResponseImplCopyWithImpl(
    _$TopicSearchResponseImpl _value,
    $Res Function(_$TopicSearchResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopicSearchResponse
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
      _$TopicSearchResponseImpl(
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
                  as List<TopicData>,
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
class _$TopicSearchResponseImpl implements _TopicSearchResponse {
  const _$TopicSearchResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<TopicData> data = const [],
    @JsonKey(name: 'total') this.total = 0,
  }) : _data = data;

  factory _$TopicSearchResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicSearchResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<TopicData> _data;
  @override
  @JsonKey(name: 'data')
  List<TopicData> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'total')
  final int total;

  @override
  String toString() {
    return 'TopicSearchResponse(status: $status, message: $message, data: $data, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicSearchResponseImpl &&
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

  /// Create a copy of TopicSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicSearchResponseImplCopyWith<_$TopicSearchResponseImpl> get copyWith =>
      __$$TopicSearchResponseImplCopyWithImpl<_$TopicSearchResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicSearchResponseImplToJson(this);
  }
}

abstract class _TopicSearchResponse implements TopicSearchResponse {
  const factory _TopicSearchResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<TopicData> data,
    @JsonKey(name: 'total') final int total,
  }) = _$TopicSearchResponseImpl;

  factory _TopicSearchResponse.fromJson(Map<String, dynamic> json) =
      _$TopicSearchResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<TopicData> get data;
  @override
  @JsonKey(name: 'total')
  int get total;

  /// Create a copy of TopicSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicSearchResponseImplCopyWith<_$TopicSearchResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TopicFollowResponse _$TopicFollowResponseFromJson(Map<String, dynamic> json) {
  return _TopicFollowResponse.fromJson(json);
}

/// @nodoc
mixin _$TopicFollowResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_follow')
  bool get isFollow => throw _privateConstructorUsedError;
  @JsonKey(name: 'follow_num')
  int get followNum => throw _privateConstructorUsedError;

  /// Serializes this TopicFollowResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TopicFollowResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TopicFollowResponseCopyWith<TopicFollowResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TopicFollowResponseCopyWith<$Res> {
  factory $TopicFollowResponseCopyWith(
    TopicFollowResponse value,
    $Res Function(TopicFollowResponse) then,
  ) = _$TopicFollowResponseCopyWithImpl<$Res, TopicFollowResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'is_follow') bool isFollow,
    @JsonKey(name: 'follow_num') int followNum,
  });
}

/// @nodoc
class _$TopicFollowResponseCopyWithImpl<$Res, $Val extends TopicFollowResponse>
    implements $TopicFollowResponseCopyWith<$Res> {
  _$TopicFollowResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TopicFollowResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? isFollow = null,
    Object? followNum = null,
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
            isFollow: null == isFollow
                ? _value.isFollow
                : isFollow // ignore: cast_nullable_to_non_nullable
                      as bool,
            followNum: null == followNum
                ? _value.followNum
                : followNum // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TopicFollowResponseImplCopyWith<$Res>
    implements $TopicFollowResponseCopyWith<$Res> {
  factory _$$TopicFollowResponseImplCopyWith(
    _$TopicFollowResponseImpl value,
    $Res Function(_$TopicFollowResponseImpl) then,
  ) = __$$TopicFollowResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'is_follow') bool isFollow,
    @JsonKey(name: 'follow_num') int followNum,
  });
}

/// @nodoc
class __$$TopicFollowResponseImplCopyWithImpl<$Res>
    extends _$TopicFollowResponseCopyWithImpl<$Res, _$TopicFollowResponseImpl>
    implements _$$TopicFollowResponseImplCopyWith<$Res> {
  __$$TopicFollowResponseImplCopyWithImpl(
    _$TopicFollowResponseImpl _value,
    $Res Function(_$TopicFollowResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TopicFollowResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? isFollow = null,
    Object? followNum = null,
  }) {
    return _then(
      _$TopicFollowResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        isFollow: null == isFollow
            ? _value.isFollow
            : isFollow // ignore: cast_nullable_to_non_nullable
                  as bool,
        followNum: null == followNum
            ? _value.followNum
            : followNum // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TopicFollowResponseImpl implements _TopicFollowResponse {
  const _$TopicFollowResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'is_follow') this.isFollow = false,
    @JsonKey(name: 'follow_num') this.followNum = 0,
  });

  factory _$TopicFollowResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$TopicFollowResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'is_follow')
  final bool isFollow;
  @override
  @JsonKey(name: 'follow_num')
  final int followNum;

  @override
  String toString() {
    return 'TopicFollowResponse(status: $status, message: $message, isFollow: $isFollow, followNum: $followNum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TopicFollowResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isFollow, isFollow) ||
                other.isFollow == isFollow) &&
            (identical(other.followNum, followNum) ||
                other.followNum == followNum));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, status, message, isFollow, followNum);

  /// Create a copy of TopicFollowResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TopicFollowResponseImplCopyWith<_$TopicFollowResponseImpl> get copyWith =>
      __$$TopicFollowResponseImplCopyWithImpl<_$TopicFollowResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TopicFollowResponseImplToJson(this);
  }
}

abstract class _TopicFollowResponse implements TopicFollowResponse {
  const factory _TopicFollowResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'is_follow') final bool isFollow,
    @JsonKey(name: 'follow_num') final int followNum,
  }) = _$TopicFollowResponseImpl;

  factory _TopicFollowResponse.fromJson(Map<String, dynamic> json) =
      _$TopicFollowResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'is_follow')
  bool get isFollow;
  @override
  @JsonKey(name: 'follow_num')
  int get followNum;

  /// Create a copy of TopicFollowResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TopicFollowResponseImplCopyWith<_$TopicFollowResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
