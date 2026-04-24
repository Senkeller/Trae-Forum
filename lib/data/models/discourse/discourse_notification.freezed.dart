// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discourse_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DiscourseNotificationResponse _$DiscourseNotificationResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseNotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscourseNotificationResponse {
  @JsonKey(name: 'notifications')
  List<DiscourseNotification> get notifications =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'seen_notification_id')
  int get seenNotificationId => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_rows_notifications')
  int get totalRows => throw _privateConstructorUsedError;

  /// Serializes this DiscourseNotificationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseNotificationResponseCopyWith<DiscourseNotificationResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseNotificationResponseCopyWith<$Res> {
  factory $DiscourseNotificationResponseCopyWith(
    DiscourseNotificationResponse value,
    $Res Function(DiscourseNotificationResponse) then,
  ) =
      _$DiscourseNotificationResponseCopyWithImpl<
        $Res,
        DiscourseNotificationResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'notifications') List<DiscourseNotification> notifications,
    @JsonKey(name: 'seen_notification_id') int seenNotificationId,
    @JsonKey(name: 'total_rows_notifications') int totalRows,
  });
}

/// @nodoc
class _$DiscourseNotificationResponseCopyWithImpl<
  $Res,
  $Val extends DiscourseNotificationResponse
>
    implements $DiscourseNotificationResponseCopyWith<$Res> {
  _$DiscourseNotificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? seenNotificationId = null,
    Object? totalRows = null,
  }) {
    return _then(
      _value.copyWith(
            notifications: null == notifications
                ? _value.notifications
                : notifications // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseNotification>,
            seenNotificationId: null == seenNotificationId
                ? _value.seenNotificationId
                : seenNotificationId // ignore: cast_nullable_to_non_nullable
                      as int,
            totalRows: null == totalRows
                ? _value.totalRows
                : totalRows // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseNotificationResponseImplCopyWith<$Res>
    implements $DiscourseNotificationResponseCopyWith<$Res> {
  factory _$$DiscourseNotificationResponseImplCopyWith(
    _$DiscourseNotificationResponseImpl value,
    $Res Function(_$DiscourseNotificationResponseImpl) then,
  ) = __$$DiscourseNotificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'notifications') List<DiscourseNotification> notifications,
    @JsonKey(name: 'seen_notification_id') int seenNotificationId,
    @JsonKey(name: 'total_rows_notifications') int totalRows,
  });
}

/// @nodoc
class __$$DiscourseNotificationResponseImplCopyWithImpl<$Res>
    extends
        _$DiscourseNotificationResponseCopyWithImpl<
          $Res,
          _$DiscourseNotificationResponseImpl
        >
    implements _$$DiscourseNotificationResponseImplCopyWith<$Res> {
  __$$DiscourseNotificationResponseImplCopyWithImpl(
    _$DiscourseNotificationResponseImpl _value,
    $Res Function(_$DiscourseNotificationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
    Object? seenNotificationId = null,
    Object? totalRows = null,
  }) {
    return _then(
      _$DiscourseNotificationResponseImpl(
        notifications: null == notifications
            ? _value._notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseNotification>,
        seenNotificationId: null == seenNotificationId
            ? _value.seenNotificationId
            : seenNotificationId // ignore: cast_nullable_to_non_nullable
                  as int,
        totalRows: null == totalRows
            ? _value.totalRows
            : totalRows // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseNotificationResponseImpl
    implements _DiscourseNotificationResponse {
  const _$DiscourseNotificationResponseImpl({
    @JsonKey(name: 'notifications')
    final List<DiscourseNotification> notifications = const [],
    @JsonKey(name: 'seen_notification_id') this.seenNotificationId = 0,
    @JsonKey(name: 'total_rows_notifications') this.totalRows = 0,
  }) : _notifications = notifications;

  factory _$DiscourseNotificationResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscourseNotificationResponseImplFromJson(json);

  final List<DiscourseNotification> _notifications;
  @override
  @JsonKey(name: 'notifications')
  List<DiscourseNotification> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  @JsonKey(name: 'seen_notification_id')
  final int seenNotificationId;
  @override
  @JsonKey(name: 'total_rows_notifications')
  final int totalRows;

  @override
  String toString() {
    return 'DiscourseNotificationResponse(notifications: $notifications, seenNotificationId: $seenNotificationId, totalRows: $totalRows)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseNotificationResponseImpl &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(other.seenNotificationId, seenNotificationId) ||
                other.seenNotificationId == seenNotificationId) &&
            (identical(other.totalRows, totalRows) ||
                other.totalRows == totalRows));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_notifications),
    seenNotificationId,
    totalRows,
  );

  /// Create a copy of DiscourseNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseNotificationResponseImplCopyWith<
    _$DiscourseNotificationResponseImpl
  >
  get copyWith =>
      __$$DiscourseNotificationResponseImplCopyWithImpl<
        _$DiscourseNotificationResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseNotificationResponseImplToJson(this);
  }
}

abstract class _DiscourseNotificationResponse
    implements DiscourseNotificationResponse {
  const factory _DiscourseNotificationResponse({
    @JsonKey(name: 'notifications')
    final List<DiscourseNotification> notifications,
    @JsonKey(name: 'seen_notification_id') final int seenNotificationId,
    @JsonKey(name: 'total_rows_notifications') final int totalRows,
  }) = _$DiscourseNotificationResponseImpl;

  factory _DiscourseNotificationResponse.fromJson(Map<String, dynamic> json) =
      _$DiscourseNotificationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'notifications')
  List<DiscourseNotification> get notifications;
  @override
  @JsonKey(name: 'seen_notification_id')
  int get seenNotificationId;
  @override
  @JsonKey(name: 'total_rows_notifications')
  int get totalRows;

  /// Create a copy of DiscourseNotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseNotificationResponseImplCopyWith<
    _$DiscourseNotificationResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseNotification _$DiscourseNotificationFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseNotification.fromJson(json);
}

/// @nodoc
mixin _$DiscourseNotification {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'notification_type')
  int get notificationType => throw _privateConstructorUsedError;
  @JsonKey(name: 'read')
  bool get read => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_number')
  int? get postNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_id')
  int? get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  NotificationData? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'fancy_title')
  String? get fancyTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_title')
  String? get topicTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_username')
  String? get displayUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'acting_user_id')
  int? get actingUserId => throw _privateConstructorUsedError;
  @JsonKey(name: 'acting_user_avatar_template')
  String? get actingUserAvatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'acting_user_name')
  String? get actingUserName => throw _privateConstructorUsedError;

  /// Serializes this DiscourseNotification to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseNotificationCopyWith<DiscourseNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseNotificationCopyWith<$Res> {
  factory $DiscourseNotificationCopyWith(
    DiscourseNotification value,
    $Res Function(DiscourseNotification) then,
  ) = _$DiscourseNotificationCopyWithImpl<$Res, DiscourseNotification>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'notification_type') int notificationType,
    @JsonKey(name: 'read') bool read,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'post_number') int? postNumber,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'data') NotificationData? data,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'acting_user_id') int? actingUserId,
    @JsonKey(name: 'acting_user_avatar_template')
    String? actingUserAvatarTemplate,
    @JsonKey(name: 'acting_user_name') String? actingUserName,
  });

  $NotificationDataCopyWith<$Res>? get data;
}

/// @nodoc
class _$DiscourseNotificationCopyWithImpl<
  $Res,
  $Val extends DiscourseNotification
>
    implements $DiscourseNotificationCopyWith<$Res> {
  _$DiscourseNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? notificationType = null,
    Object? read = null,
    Object? createdAt = freezed,
    Object? postNumber = freezed,
    Object? topicId = freezed,
    Object? slug = freezed,
    Object? data = freezed,
    Object? fancyTitle = freezed,
    Object? topicTitle = freezed,
    Object? displayUsername = freezed,
    Object? actingUserId = freezed,
    Object? actingUserAvatarTemplate = freezed,
    Object? actingUserName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            notificationType: null == notificationType
                ? _value.notificationType
                : notificationType // ignore: cast_nullable_to_non_nullable
                      as int,
            read: null == read
                ? _value.read
                : read // ignore: cast_nullable_to_non_nullable
                      as bool,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            postNumber: freezed == postNumber
                ? _value.postNumber
                : postNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            topicId: freezed == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int?,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as NotificationData?,
            fancyTitle: freezed == fancyTitle
                ? _value.fancyTitle
                : fancyTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            topicTitle: freezed == topicTitle
                ? _value.topicTitle
                : topicTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayUsername: freezed == displayUsername
                ? _value.displayUsername
                : displayUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
            actingUserId: freezed == actingUserId
                ? _value.actingUserId
                : actingUserId // ignore: cast_nullable_to_non_nullable
                      as int?,
            actingUserAvatarTemplate: freezed == actingUserAvatarTemplate
                ? _value.actingUserAvatarTemplate
                : actingUserAvatarTemplate // ignore: cast_nullable_to_non_nullable
                      as String?,
            actingUserName: freezed == actingUserName
                ? _value.actingUserName
                : actingUserName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NotificationDataCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $NotificationDataCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseNotificationImplCopyWith<$Res>
    implements $DiscourseNotificationCopyWith<$Res> {
  factory _$$DiscourseNotificationImplCopyWith(
    _$DiscourseNotificationImpl value,
    $Res Function(_$DiscourseNotificationImpl) then,
  ) = __$$DiscourseNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'notification_type') int notificationType,
    @JsonKey(name: 'read') bool read,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'post_number') int? postNumber,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'data') NotificationData? data,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'acting_user_id') int? actingUserId,
    @JsonKey(name: 'acting_user_avatar_template')
    String? actingUserAvatarTemplate,
    @JsonKey(name: 'acting_user_name') String? actingUserName,
  });

  @override
  $NotificationDataCopyWith<$Res>? get data;
}

/// @nodoc
class __$$DiscourseNotificationImplCopyWithImpl<$Res>
    extends
        _$DiscourseNotificationCopyWithImpl<$Res, _$DiscourseNotificationImpl>
    implements _$$DiscourseNotificationImplCopyWith<$Res> {
  __$$DiscourseNotificationImplCopyWithImpl(
    _$DiscourseNotificationImpl _value,
    $Res Function(_$DiscourseNotificationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseNotification
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? notificationType = null,
    Object? read = null,
    Object? createdAt = freezed,
    Object? postNumber = freezed,
    Object? topicId = freezed,
    Object? slug = freezed,
    Object? data = freezed,
    Object? fancyTitle = freezed,
    Object? topicTitle = freezed,
    Object? displayUsername = freezed,
    Object? actingUserId = freezed,
    Object? actingUserAvatarTemplate = freezed,
    Object? actingUserName = freezed,
  }) {
    return _then(
      _$DiscourseNotificationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        notificationType: null == notificationType
            ? _value.notificationType
            : notificationType // ignore: cast_nullable_to_non_nullable
                  as int,
        read: null == read
            ? _value.read
            : read // ignore: cast_nullable_to_non_nullable
                  as bool,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        postNumber: freezed == postNumber
            ? _value.postNumber
            : postNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        topicId: freezed == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int?,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as NotificationData?,
        fancyTitle: freezed == fancyTitle
            ? _value.fancyTitle
            : fancyTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        topicTitle: freezed == topicTitle
            ? _value.topicTitle
            : topicTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayUsername: freezed == displayUsername
            ? _value.displayUsername
            : displayUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
        actingUserId: freezed == actingUserId
            ? _value.actingUserId
            : actingUserId // ignore: cast_nullable_to_non_nullable
                  as int?,
        actingUserAvatarTemplate: freezed == actingUserAvatarTemplate
            ? _value.actingUserAvatarTemplate
            : actingUserAvatarTemplate // ignore: cast_nullable_to_non_nullable
                  as String?,
        actingUserName: freezed == actingUserName
            ? _value.actingUserName
            : actingUserName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseNotificationImpl implements _DiscourseNotification {
  const _$DiscourseNotificationImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'notification_type') required this.notificationType,
    @JsonKey(name: 'read') this.read = false,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'post_number') this.postNumber,
    @JsonKey(name: 'topic_id') this.topicId,
    @JsonKey(name: 'slug') this.slug,
    @JsonKey(name: 'data') this.data,
    @JsonKey(name: 'fancy_title') this.fancyTitle,
    @JsonKey(name: 'topic_title') this.topicTitle,
    @JsonKey(name: 'display_username') this.displayUsername,
    @JsonKey(name: 'acting_user_id') this.actingUserId,
    @JsonKey(name: 'acting_user_avatar_template') this.actingUserAvatarTemplate,
    @JsonKey(name: 'acting_user_name') this.actingUserName,
  });

  factory _$DiscourseNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseNotificationImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'notification_type')
  final int notificationType;
  @override
  @JsonKey(name: 'read')
  final bool read;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'post_number')
  final int? postNumber;
  @override
  @JsonKey(name: 'topic_id')
  final int? topicId;
  @override
  @JsonKey(name: 'slug')
  final String? slug;
  @override
  @JsonKey(name: 'data')
  final NotificationData? data;
  @override
  @JsonKey(name: 'fancy_title')
  final String? fancyTitle;
  @override
  @JsonKey(name: 'topic_title')
  final String? topicTitle;
  @override
  @JsonKey(name: 'display_username')
  final String? displayUsername;
  @override
  @JsonKey(name: 'acting_user_id')
  final int? actingUserId;
  @override
  @JsonKey(name: 'acting_user_avatar_template')
  final String? actingUserAvatarTemplate;
  @override
  @JsonKey(name: 'acting_user_name')
  final String? actingUserName;

  @override
  String toString() {
    return 'DiscourseNotification(id: $id, notificationType: $notificationType, read: $read, createdAt: $createdAt, postNumber: $postNumber, topicId: $topicId, slug: $slug, data: $data, fancyTitle: $fancyTitle, topicTitle: $topicTitle, displayUsername: $displayUsername, actingUserId: $actingUserId, actingUserAvatarTemplate: $actingUserAvatarTemplate, actingUserName: $actingUserName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.read, read) || other.read == read) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.postNumber, postNumber) ||
                other.postNumber == postNumber) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.fancyTitle, fancyTitle) ||
                other.fancyTitle == fancyTitle) &&
            (identical(other.topicTitle, topicTitle) ||
                other.topicTitle == topicTitle) &&
            (identical(other.displayUsername, displayUsername) ||
                other.displayUsername == displayUsername) &&
            (identical(other.actingUserId, actingUserId) ||
                other.actingUserId == actingUserId) &&
            (identical(
                  other.actingUserAvatarTemplate,
                  actingUserAvatarTemplate,
                ) ||
                other.actingUserAvatarTemplate == actingUserAvatarTemplate) &&
            (identical(other.actingUserName, actingUserName) ||
                other.actingUserName == actingUserName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    notificationType,
    read,
    createdAt,
    postNumber,
    topicId,
    slug,
    data,
    fancyTitle,
    topicTitle,
    displayUsername,
    actingUserId,
    actingUserAvatarTemplate,
    actingUserName,
  );

  /// Create a copy of DiscourseNotification
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseNotificationImplCopyWith<_$DiscourseNotificationImpl>
  get copyWith =>
      __$$DiscourseNotificationImplCopyWithImpl<_$DiscourseNotificationImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseNotificationImplToJson(this);
  }
}

abstract class _DiscourseNotification implements DiscourseNotification {
  const factory _DiscourseNotification({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'notification_type') required final int notificationType,
    @JsonKey(name: 'read') final bool read,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'post_number') final int? postNumber,
    @JsonKey(name: 'topic_id') final int? topicId,
    @JsonKey(name: 'slug') final String? slug,
    @JsonKey(name: 'data') final NotificationData? data,
    @JsonKey(name: 'fancy_title') final String? fancyTitle,
    @JsonKey(name: 'topic_title') final String? topicTitle,
    @JsonKey(name: 'display_username') final String? displayUsername,
    @JsonKey(name: 'acting_user_id') final int? actingUserId,
    @JsonKey(name: 'acting_user_avatar_template')
    final String? actingUserAvatarTemplate,
    @JsonKey(name: 'acting_user_name') final String? actingUserName,
  }) = _$DiscourseNotificationImpl;

  factory _DiscourseNotification.fromJson(Map<String, dynamic> json) =
      _$DiscourseNotificationImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'notification_type')
  int get notificationType;
  @override
  @JsonKey(name: 'read')
  bool get read;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'post_number')
  int? get postNumber;
  @override
  @JsonKey(name: 'topic_id')
  int? get topicId;
  @override
  @JsonKey(name: 'slug')
  String? get slug;
  @override
  @JsonKey(name: 'data')
  NotificationData? get data;
  @override
  @JsonKey(name: 'fancy_title')
  String? get fancyTitle;
  @override
  @JsonKey(name: 'topic_title')
  String? get topicTitle;
  @override
  @JsonKey(name: 'display_username')
  String? get displayUsername;
  @override
  @JsonKey(name: 'acting_user_id')
  int? get actingUserId;
  @override
  @JsonKey(name: 'acting_user_avatar_template')
  String? get actingUserAvatarTemplate;
  @override
  @JsonKey(name: 'acting_user_name')
  String? get actingUserName;

  /// Create a copy of DiscourseNotification
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseNotificationImplCopyWith<_$DiscourseNotificationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) {
  return _NotificationData.fromJson(json);
}

/// @nodoc
mixin _$NotificationData {
  @JsonKey(name: 'topic_title')
  String? get topicTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_post_id')
  int? get originalPostId => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_post_type')
  int? get originalPostType => throw _privateConstructorUsedError;
  @JsonKey(name: 'original_username')
  String? get originalUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'revision_number')
  int? get revisionNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_username')
  String? get displayUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'count')
  int? get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_id')
  int? get badgeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_name')
  String? get badgeName => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_slug')
  String? get badgeSlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_title')
  String? get badgeTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_channel_id')
  int? get chatChannelId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_message_id')
  int? get chatMessageId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_thread_id')
  int? get chatThreadId => throw _privateConstructorUsedError;
  @JsonKey(name: 'chat_thread_title')
  String? get chatThreadTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'mentioned_by_username')
  String? get mentionedByUsername => throw _privateConstructorUsedError;

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
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'original_post_id') int? originalPostId,
    @JsonKey(name: 'original_post_type') int? originalPostType,
    @JsonKey(name: 'original_username') String? originalUsername,
    @JsonKey(name: 'revision_number') int? revisionNumber,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'count') int? count,
    @JsonKey(name: 'badge_id') int? badgeId,
    @JsonKey(name: 'badge_name') String? badgeName,
    @JsonKey(name: 'badge_slug') String? badgeSlug,
    @JsonKey(name: 'badge_title') String? badgeTitle,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'chat_channel_id') int? chatChannelId,
    @JsonKey(name: 'chat_message_id') int? chatMessageId,
    @JsonKey(name: 'chat_thread_id') int? chatThreadId,
    @JsonKey(name: 'chat_thread_title') String? chatThreadTitle,
    @JsonKey(name: 'mentioned_by_username') String? mentionedByUsername,
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
    Object? topicTitle = freezed,
    Object? originalPostId = freezed,
    Object? originalPostType = freezed,
    Object? originalUsername = freezed,
    Object? revisionNumber = freezed,
    Object? displayUsername = freezed,
    Object? count = freezed,
    Object? badgeId = freezed,
    Object? badgeName = freezed,
    Object? badgeSlug = freezed,
    Object? badgeTitle = freezed,
    Object? message = freezed,
    Object? chatChannelId = freezed,
    Object? chatMessageId = freezed,
    Object? chatThreadId = freezed,
    Object? chatThreadTitle = freezed,
    Object? mentionedByUsername = freezed,
  }) {
    return _then(
      _value.copyWith(
            topicTitle: freezed == topicTitle
                ? _value.topicTitle
                : topicTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            originalPostId: freezed == originalPostId
                ? _value.originalPostId
                : originalPostId // ignore: cast_nullable_to_non_nullable
                      as int?,
            originalPostType: freezed == originalPostType
                ? _value.originalPostType
                : originalPostType // ignore: cast_nullable_to_non_nullable
                      as int?,
            originalUsername: freezed == originalUsername
                ? _value.originalUsername
                : originalUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
            revisionNumber: freezed == revisionNumber
                ? _value.revisionNumber
                : revisionNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            displayUsername: freezed == displayUsername
                ? _value.displayUsername
                : displayUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
            count: freezed == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int?,
            badgeId: freezed == badgeId
                ? _value.badgeId
                : badgeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            badgeName: freezed == badgeName
                ? _value.badgeName
                : badgeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            badgeSlug: freezed == badgeSlug
                ? _value.badgeSlug
                : badgeSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            badgeTitle: freezed == badgeTitle
                ? _value.badgeTitle
                : badgeTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            chatChannelId: freezed == chatChannelId
                ? _value.chatChannelId
                : chatChannelId // ignore: cast_nullable_to_non_nullable
                      as int?,
            chatMessageId: freezed == chatMessageId
                ? _value.chatMessageId
                : chatMessageId // ignore: cast_nullable_to_non_nullable
                      as int?,
            chatThreadId: freezed == chatThreadId
                ? _value.chatThreadId
                : chatThreadId // ignore: cast_nullable_to_non_nullable
                      as int?,
            chatThreadTitle: freezed == chatThreadTitle
                ? _value.chatThreadTitle
                : chatThreadTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            mentionedByUsername: freezed == mentionedByUsername
                ? _value.mentionedByUsername
                : mentionedByUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
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
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'original_post_id') int? originalPostId,
    @JsonKey(name: 'original_post_type') int? originalPostType,
    @JsonKey(name: 'original_username') String? originalUsername,
    @JsonKey(name: 'revision_number') int? revisionNumber,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'count') int? count,
    @JsonKey(name: 'badge_id') int? badgeId,
    @JsonKey(name: 'badge_name') String? badgeName,
    @JsonKey(name: 'badge_slug') String? badgeSlug,
    @JsonKey(name: 'badge_title') String? badgeTitle,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'chat_channel_id') int? chatChannelId,
    @JsonKey(name: 'chat_message_id') int? chatMessageId,
    @JsonKey(name: 'chat_thread_id') int? chatThreadId,
    @JsonKey(name: 'chat_thread_title') String? chatThreadTitle,
    @JsonKey(name: 'mentioned_by_username') String? mentionedByUsername,
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
    Object? topicTitle = freezed,
    Object? originalPostId = freezed,
    Object? originalPostType = freezed,
    Object? originalUsername = freezed,
    Object? revisionNumber = freezed,
    Object? displayUsername = freezed,
    Object? count = freezed,
    Object? badgeId = freezed,
    Object? badgeName = freezed,
    Object? badgeSlug = freezed,
    Object? badgeTitle = freezed,
    Object? message = freezed,
    Object? chatChannelId = freezed,
    Object? chatMessageId = freezed,
    Object? chatThreadId = freezed,
    Object? chatThreadTitle = freezed,
    Object? mentionedByUsername = freezed,
  }) {
    return _then(
      _$NotificationDataImpl(
        topicTitle: freezed == topicTitle
            ? _value.topicTitle
            : topicTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        originalPostId: freezed == originalPostId
            ? _value.originalPostId
            : originalPostId // ignore: cast_nullable_to_non_nullable
                  as int?,
        originalPostType: freezed == originalPostType
            ? _value.originalPostType
            : originalPostType // ignore: cast_nullable_to_non_nullable
                  as int?,
        originalUsername: freezed == originalUsername
            ? _value.originalUsername
            : originalUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
        revisionNumber: freezed == revisionNumber
            ? _value.revisionNumber
            : revisionNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        displayUsername: freezed == displayUsername
            ? _value.displayUsername
            : displayUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
        count: freezed == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int?,
        badgeId: freezed == badgeId
            ? _value.badgeId
            : badgeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        badgeName: freezed == badgeName
            ? _value.badgeName
            : badgeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        badgeSlug: freezed == badgeSlug
            ? _value.badgeSlug
            : badgeSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        badgeTitle: freezed == badgeTitle
            ? _value.badgeTitle
            : badgeTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        chatChannelId: freezed == chatChannelId
            ? _value.chatChannelId
            : chatChannelId // ignore: cast_nullable_to_non_nullable
                  as int?,
        chatMessageId: freezed == chatMessageId
            ? _value.chatMessageId
            : chatMessageId // ignore: cast_nullable_to_non_nullable
                  as int?,
        chatThreadId: freezed == chatThreadId
            ? _value.chatThreadId
            : chatThreadId // ignore: cast_nullable_to_non_nullable
                  as int?,
        chatThreadTitle: freezed == chatThreadTitle
            ? _value.chatThreadTitle
            : chatThreadTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        mentionedByUsername: freezed == mentionedByUsername
            ? _value.mentionedByUsername
            : mentionedByUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationDataImpl implements _NotificationData {
  const _$NotificationDataImpl({
    @JsonKey(name: 'topic_title') this.topicTitle,
    @JsonKey(name: 'original_post_id') this.originalPostId,
    @JsonKey(name: 'original_post_type') this.originalPostType,
    @JsonKey(name: 'original_username') this.originalUsername,
    @JsonKey(name: 'revision_number') this.revisionNumber,
    @JsonKey(name: 'display_username') this.displayUsername,
    @JsonKey(name: 'count') this.count,
    @JsonKey(name: 'badge_id') this.badgeId,
    @JsonKey(name: 'badge_name') this.badgeName,
    @JsonKey(name: 'badge_slug') this.badgeSlug,
    @JsonKey(name: 'badge_title') this.badgeTitle,
    @JsonKey(name: 'message') this.message,
    @JsonKey(name: 'chat_channel_id') this.chatChannelId,
    @JsonKey(name: 'chat_message_id') this.chatMessageId,
    @JsonKey(name: 'chat_thread_id') this.chatThreadId,
    @JsonKey(name: 'chat_thread_title') this.chatThreadTitle,
    @JsonKey(name: 'mentioned_by_username') this.mentionedByUsername,
  });

  factory _$NotificationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationDataImplFromJson(json);

  @override
  @JsonKey(name: 'topic_title')
  final String? topicTitle;
  @override
  @JsonKey(name: 'original_post_id')
  final int? originalPostId;
  @override
  @JsonKey(name: 'original_post_type')
  final int? originalPostType;
  @override
  @JsonKey(name: 'original_username')
  final String? originalUsername;
  @override
  @JsonKey(name: 'revision_number')
  final int? revisionNumber;
  @override
  @JsonKey(name: 'display_username')
  final String? displayUsername;
  @override
  @JsonKey(name: 'count')
  final int? count;
  @override
  @JsonKey(name: 'badge_id')
  final int? badgeId;
  @override
  @JsonKey(name: 'badge_name')
  final String? badgeName;
  @override
  @JsonKey(name: 'badge_slug')
  final String? badgeSlug;
  @override
  @JsonKey(name: 'badge_title')
  final String? badgeTitle;
  @override
  @JsonKey(name: 'message')
  final String? message;
  @override
  @JsonKey(name: 'chat_channel_id')
  final int? chatChannelId;
  @override
  @JsonKey(name: 'chat_message_id')
  final int? chatMessageId;
  @override
  @JsonKey(name: 'chat_thread_id')
  final int? chatThreadId;
  @override
  @JsonKey(name: 'chat_thread_title')
  final String? chatThreadTitle;
  @override
  @JsonKey(name: 'mentioned_by_username')
  final String? mentionedByUsername;

  @override
  String toString() {
    return 'NotificationData(topicTitle: $topicTitle, originalPostId: $originalPostId, originalPostType: $originalPostType, originalUsername: $originalUsername, revisionNumber: $revisionNumber, displayUsername: $displayUsername, count: $count, badgeId: $badgeId, badgeName: $badgeName, badgeSlug: $badgeSlug, badgeTitle: $badgeTitle, message: $message, chatChannelId: $chatChannelId, chatMessageId: $chatMessageId, chatThreadId: $chatThreadId, chatThreadTitle: $chatThreadTitle, mentionedByUsername: $mentionedByUsername)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationDataImpl &&
            (identical(other.topicTitle, topicTitle) ||
                other.topicTitle == topicTitle) &&
            (identical(other.originalPostId, originalPostId) ||
                other.originalPostId == originalPostId) &&
            (identical(other.originalPostType, originalPostType) ||
                other.originalPostType == originalPostType) &&
            (identical(other.originalUsername, originalUsername) ||
                other.originalUsername == originalUsername) &&
            (identical(other.revisionNumber, revisionNumber) ||
                other.revisionNumber == revisionNumber) &&
            (identical(other.displayUsername, displayUsername) ||
                other.displayUsername == displayUsername) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.badgeName, badgeName) ||
                other.badgeName == badgeName) &&
            (identical(other.badgeSlug, badgeSlug) ||
                other.badgeSlug == badgeSlug) &&
            (identical(other.badgeTitle, badgeTitle) ||
                other.badgeTitle == badgeTitle) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.chatChannelId, chatChannelId) ||
                other.chatChannelId == chatChannelId) &&
            (identical(other.chatMessageId, chatMessageId) ||
                other.chatMessageId == chatMessageId) &&
            (identical(other.chatThreadId, chatThreadId) ||
                other.chatThreadId == chatThreadId) &&
            (identical(other.chatThreadTitle, chatThreadTitle) ||
                other.chatThreadTitle == chatThreadTitle) &&
            (identical(other.mentionedByUsername, mentionedByUsername) ||
                other.mentionedByUsername == mentionedByUsername));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    topicTitle,
    originalPostId,
    originalPostType,
    originalUsername,
    revisionNumber,
    displayUsername,
    count,
    badgeId,
    badgeName,
    badgeSlug,
    badgeTitle,
    message,
    chatChannelId,
    chatMessageId,
    chatThreadId,
    chatThreadTitle,
    mentionedByUsername,
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
    @JsonKey(name: 'topic_title') final String? topicTitle,
    @JsonKey(name: 'original_post_id') final int? originalPostId,
    @JsonKey(name: 'original_post_type') final int? originalPostType,
    @JsonKey(name: 'original_username') final String? originalUsername,
    @JsonKey(name: 'revision_number') final int? revisionNumber,
    @JsonKey(name: 'display_username') final String? displayUsername,
    @JsonKey(name: 'count') final int? count,
    @JsonKey(name: 'badge_id') final int? badgeId,
    @JsonKey(name: 'badge_name') final String? badgeName,
    @JsonKey(name: 'badge_slug') final String? badgeSlug,
    @JsonKey(name: 'badge_title') final String? badgeTitle,
    @JsonKey(name: 'message') final String? message,
    @JsonKey(name: 'chat_channel_id') final int? chatChannelId,
    @JsonKey(name: 'chat_message_id') final int? chatMessageId,
    @JsonKey(name: 'chat_thread_id') final int? chatThreadId,
    @JsonKey(name: 'chat_thread_title') final String? chatThreadTitle,
    @JsonKey(name: 'mentioned_by_username') final String? mentionedByUsername,
  }) = _$NotificationDataImpl;

  factory _NotificationData.fromJson(Map<String, dynamic> json) =
      _$NotificationDataImpl.fromJson;

  @override
  @JsonKey(name: 'topic_title')
  String? get topicTitle;
  @override
  @JsonKey(name: 'original_post_id')
  int? get originalPostId;
  @override
  @JsonKey(name: 'original_post_type')
  int? get originalPostType;
  @override
  @JsonKey(name: 'original_username')
  String? get originalUsername;
  @override
  @JsonKey(name: 'revision_number')
  int? get revisionNumber;
  @override
  @JsonKey(name: 'display_username')
  String? get displayUsername;
  @override
  @JsonKey(name: 'count')
  int? get count;
  @override
  @JsonKey(name: 'badge_id')
  int? get badgeId;
  @override
  @JsonKey(name: 'badge_name')
  String? get badgeName;
  @override
  @JsonKey(name: 'badge_slug')
  String? get badgeSlug;
  @override
  @JsonKey(name: 'badge_title')
  String? get badgeTitle;
  @override
  @JsonKey(name: 'message')
  String? get message;
  @override
  @JsonKey(name: 'chat_channel_id')
  int? get chatChannelId;
  @override
  @JsonKey(name: 'chat_message_id')
  int? get chatMessageId;
  @override
  @JsonKey(name: 'chat_thread_id')
  int? get chatThreadId;
  @override
  @JsonKey(name: 'chat_thread_title')
  String? get chatThreadTitle;
  @override
  @JsonKey(name: 'mentioned_by_username')
  String? get mentionedByUsername;

  /// Create a copy of NotificationData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationDataImplCopyWith<_$NotificationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
