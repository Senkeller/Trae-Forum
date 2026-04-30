// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return _UserInfo.fromJson(json);
}

/// @nodoc
mixin _$UserInfo {
  @JsonKey(name: 'uid')
  String get uid => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar')
  String? get avatar => throw _privateConstructorUsedError;
  @JsonKey(name: 'level')
  int get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'bio')
  String get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'fans')
  int get fans => throw _privateConstructorUsedError;
  @JsonKey(name: 'follow')
  int get follow => throw _privateConstructorUsedError;
  @JsonKey(name: 'verify_title')
  String? get verifyTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_developer')
  bool get isDeveloper => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'location')
  String? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'website')
  String? get website => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_seen_at')
  String? get lastSeenAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_view_count')
  int get profileViewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level')
  int get trustLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'groups')
  List<String> get groups => throw _privateConstructorUsedError;
  @JsonKey(name: 'gamification_score')
  int get gamificationScore => throw _privateConstructorUsedError;

  /// Serializes this UserInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserInfoCopyWith<UserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoCopyWith<$Res> {
  factory $UserInfoCopyWith(UserInfo value, $Res Function(UserInfo) then) =
      _$UserInfoCopyWithImpl<$Res, UserInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'uid') String uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'level') int level,
    @JsonKey(name: 'bio') String bio,
    @JsonKey(name: 'fans') int fans,
    @JsonKey(name: 'follow') int follow,
    @JsonKey(name: 'verify_title') String? verifyTitle,
    @JsonKey(name: 'is_developer') bool isDeveloper,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'website') String? website,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'last_seen_at') String? lastSeenAt,
    @JsonKey(name: 'profile_view_count') int profileViewCount,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'groups') List<String> groups,
    @JsonKey(name: 'gamification_score') int gamificationScore,
  });
}

/// @nodoc
class _$UserInfoCopyWithImpl<$Res, $Val extends UserInfo>
    implements $UserInfoCopyWith<$Res> {
  _$UserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? level = null,
    Object? bio = null,
    Object? fans = null,
    Object? follow = null,
    Object? verifyTitle = freezed,
    Object? isDeveloper = null,
    Object? title = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? createdAt = freezed,
    Object? lastPostedAt = freezed,
    Object? lastSeenAt = freezed,
    Object? profileViewCount = null,
    Object? trustLevel = null,
    Object? groups = null,
    Object? gamificationScore = null,
  }) {
    return _then(
      _value.copyWith(
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
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            bio: null == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String,
            fans: null == fans
                ? _value.fans
                : fans // ignore: cast_nullable_to_non_nullable
                      as int,
            follow: null == follow
                ? _value.follow
                : follow // ignore: cast_nullable_to_non_nullable
                      as int,
            verifyTitle: freezed == verifyTitle
                ? _value.verifyTitle
                : verifyTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            isDeveloper: null == isDeveloper
                ? _value.isDeveloper
                : isDeveloper // ignore: cast_nullable_to_non_nullable
                      as bool,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            website: freezed == website
                ? _value.website
                : website // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPostedAt: freezed == lastPostedAt
                ? _value.lastPostedAt
                : lastPostedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastSeenAt: freezed == lastSeenAt
                ? _value.lastSeenAt
                : lastSeenAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileViewCount: null == profileViewCount
                ? _value.profileViewCount
                : profileViewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            trustLevel: null == trustLevel
                ? _value.trustLevel
                : trustLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            groups: null == groups
                ? _value.groups
                : groups // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            gamificationScore: null == gamificationScore
                ? _value.gamificationScore
                : gamificationScore // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserInfoImplCopyWith<$Res>
    implements $UserInfoCopyWith<$Res> {
  factory _$$UserInfoImplCopyWith(
    _$UserInfoImpl value,
    $Res Function(_$UserInfoImpl) then,
  ) = __$$UserInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'uid') String uid,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar') String? avatar,
    @JsonKey(name: 'level') int level,
    @JsonKey(name: 'bio') String bio,
    @JsonKey(name: 'fans') int fans,
    @JsonKey(name: 'follow') int follow,
    @JsonKey(name: 'verify_title') String? verifyTitle,
    @JsonKey(name: 'is_developer') bool isDeveloper,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'location') String? location,
    @JsonKey(name: 'website') String? website,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'last_seen_at') String? lastSeenAt,
    @JsonKey(name: 'profile_view_count') int profileViewCount,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'groups') List<String> groups,
    @JsonKey(name: 'gamification_score') int gamificationScore,
  });
}

/// @nodoc
class __$$UserInfoImplCopyWithImpl<$Res>
    extends _$UserInfoCopyWithImpl<$Res, _$UserInfoImpl>
    implements _$$UserInfoImplCopyWith<$Res> {
  __$$UserInfoImplCopyWithImpl(
    _$UserInfoImpl _value,
    $Res Function(_$UserInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? username = null,
    Object? avatar = freezed,
    Object? level = null,
    Object? bio = null,
    Object? fans = null,
    Object? follow = null,
    Object? verifyTitle = freezed,
    Object? isDeveloper = null,
    Object? title = freezed,
    Object? location = freezed,
    Object? website = freezed,
    Object? createdAt = freezed,
    Object? lastPostedAt = freezed,
    Object? lastSeenAt = freezed,
    Object? profileViewCount = null,
    Object? trustLevel = null,
    Object? groups = null,
    Object? gamificationScore = null,
  }) {
    return _then(
      _$UserInfoImpl(
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
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        bio: null == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String,
        fans: null == fans
            ? _value.fans
            : fans // ignore: cast_nullable_to_non_nullable
                  as int,
        follow: null == follow
            ? _value.follow
            : follow // ignore: cast_nullable_to_non_nullable
                  as int,
        verifyTitle: freezed == verifyTitle
            ? _value.verifyTitle
            : verifyTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        isDeveloper: null == isDeveloper
            ? _value.isDeveloper
            : isDeveloper // ignore: cast_nullable_to_non_nullable
                  as bool,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        website: freezed == website
            ? _value.website
            : website // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPostedAt: freezed == lastPostedAt
            ? _value.lastPostedAt
            : lastPostedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastSeenAt: freezed == lastSeenAt
            ? _value.lastSeenAt
            : lastSeenAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileViewCount: null == profileViewCount
            ? _value.profileViewCount
            : profileViewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        trustLevel: null == trustLevel
            ? _value.trustLevel
            : trustLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        groups: null == groups
            ? _value._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        gamificationScore: null == gamificationScore
            ? _value.gamificationScore
            : gamificationScore // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoImpl implements _UserInfo {
  const _$UserInfoImpl({
    @JsonKey(name: 'uid') required this.uid,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'avatar') this.avatar,
    @JsonKey(name: 'level') this.level = 0,
    @JsonKey(name: 'bio') this.bio = '',
    @JsonKey(name: 'fans') this.fans = 0,
    @JsonKey(name: 'follow') this.follow = 0,
    @JsonKey(name: 'verify_title') this.verifyTitle,
    @JsonKey(name: 'is_developer') this.isDeveloper = false,
    @JsonKey(name: 'title') this.title,
    @JsonKey(name: 'location') this.location,
    @JsonKey(name: 'website') this.website,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'last_posted_at') this.lastPostedAt,
    @JsonKey(name: 'last_seen_at') this.lastSeenAt,
    @JsonKey(name: 'profile_view_count') this.profileViewCount = 0,
    @JsonKey(name: 'trust_level') this.trustLevel = 0,
    @JsonKey(name: 'groups') final List<String> groups = const [],
    @JsonKey(name: 'gamification_score') this.gamificationScore = 0,
  }) : _groups = groups;

  factory _$UserInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoImplFromJson(json);

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
  @JsonKey(name: 'level')
  final int level;
  @override
  @JsonKey(name: 'bio')
  final String bio;
  @override
  @JsonKey(name: 'fans')
  final int fans;
  @override
  @JsonKey(name: 'follow')
  final int follow;
  @override
  @JsonKey(name: 'verify_title')
  final String? verifyTitle;
  @override
  @JsonKey(name: 'is_developer')
  final bool isDeveloper;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'location')
  final String? location;
  @override
  @JsonKey(name: 'website')
  final String? website;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'last_posted_at')
  final String? lastPostedAt;
  @override
  @JsonKey(name: 'last_seen_at')
  final String? lastSeenAt;
  @override
  @JsonKey(name: 'profile_view_count')
  final int profileViewCount;
  @override
  @JsonKey(name: 'trust_level')
  final int trustLevel;
  final List<String> _groups;
  @override
  @JsonKey(name: 'groups')
  List<String> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  @JsonKey(name: 'gamification_score')
  final int gamificationScore;

  @override
  String toString() {
    return 'UserInfo(uid: $uid, username: $username, avatar: $avatar, level: $level, bio: $bio, fans: $fans, follow: $follow, verifyTitle: $verifyTitle, isDeveloper: $isDeveloper, title: $title, location: $location, website: $website, createdAt: $createdAt, lastPostedAt: $lastPostedAt, lastSeenAt: $lastSeenAt, profileViewCount: $profileViewCount, trustLevel: $trustLevel, groups: $groups, gamificationScore: $gamificationScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.fans, fans) || other.fans == fans) &&
            (identical(other.follow, follow) || other.follow == follow) &&
            (identical(other.verifyTitle, verifyTitle) ||
                other.verifyTitle == verifyTitle) &&
            (identical(other.isDeveloper, isDeveloper) ||
                other.isDeveloper == isDeveloper) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.website, website) || other.website == website) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastPostedAt, lastPostedAt) ||
                other.lastPostedAt == lastPostedAt) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.profileViewCount, profileViewCount) ||
                other.profileViewCount == profileViewCount) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            (identical(other.gamificationScore, gamificationScore) ||
                other.gamificationScore == gamificationScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    uid,
    username,
    avatar,
    level,
    bio,
    fans,
    follow,
    verifyTitle,
    isDeveloper,
    title,
    location,
    website,
    createdAt,
    lastPostedAt,
    lastSeenAt,
    profileViewCount,
    trustLevel,
    const DeepCollectionEquality().hash(_groups),
    gamificationScore,
  ]);

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoImplCopyWith<_$UserInfoImpl> get copyWith =>
      __$$UserInfoImplCopyWithImpl<_$UserInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoImplToJson(this);
  }
}

abstract class _UserInfo implements UserInfo {
  const factory _UserInfo({
    @JsonKey(name: 'uid') required final String uid,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'avatar') final String? avatar,
    @JsonKey(name: 'level') final int level,
    @JsonKey(name: 'bio') final String bio,
    @JsonKey(name: 'fans') final int fans,
    @JsonKey(name: 'follow') final int follow,
    @JsonKey(name: 'verify_title') final String? verifyTitle,
    @JsonKey(name: 'is_developer') final bool isDeveloper,
    @JsonKey(name: 'title') final String? title,
    @JsonKey(name: 'location') final String? location,
    @JsonKey(name: 'website') final String? website,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'last_posted_at') final String? lastPostedAt,
    @JsonKey(name: 'last_seen_at') final String? lastSeenAt,
    @JsonKey(name: 'profile_view_count') final int profileViewCount,
    @JsonKey(name: 'trust_level') final int trustLevel,
    @JsonKey(name: 'groups') final List<String> groups,
    @JsonKey(name: 'gamification_score') final int gamificationScore,
  }) = _$UserInfoImpl;

  factory _UserInfo.fromJson(Map<String, dynamic> json) =
      _$UserInfoImpl.fromJson;

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
  @JsonKey(name: 'level')
  int get level;
  @override
  @JsonKey(name: 'bio')
  String get bio;
  @override
  @JsonKey(name: 'fans')
  int get fans;
  @override
  @JsonKey(name: 'follow')
  int get follow;
  @override
  @JsonKey(name: 'verify_title')
  String? get verifyTitle;
  @override
  @JsonKey(name: 'is_developer')
  bool get isDeveloper;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'location')
  String? get location;
  @override
  @JsonKey(name: 'website')
  String? get website;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt;
  @override
  @JsonKey(name: 'last_seen_at')
  String? get lastSeenAt;
  @override
  @JsonKey(name: 'profile_view_count')
  int get profileViewCount;
  @override
  @JsonKey(name: 'trust_level')
  int get trustLevel;
  @override
  @JsonKey(name: 'groups')
  List<String> get groups;
  @override
  @JsonKey(name: 'gamification_score')
  int get gamificationScore;

  /// Create a copy of UserInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserInfoImplCopyWith<_$UserInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserAction _$UserActionFromJson(Map<String, dynamic> json) {
  return _UserAction.fromJson(json);
}

/// @nodoc
mixin _$UserAction {
  @JsonKey(name: 'is_like')
  bool get isLike => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_favorite')
  bool get isFavorite => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_follow')
  bool get isFollow => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_num')
  int get likeNum => throw _privateConstructorUsedError;
  @JsonKey(name: 'favorite_num')
  int get favoriteNum => throw _privateConstructorUsedError;

  /// Serializes this UserAction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserActionCopyWith<UserAction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserActionCopyWith<$Res> {
  factory $UserActionCopyWith(
    UserAction value,
    $Res Function(UserAction) then,
  ) = _$UserActionCopyWithImpl<$Res, UserAction>;
  @useResult
  $Res call({
    @JsonKey(name: 'is_like') bool isLike,
    @JsonKey(name: 'is_favorite') bool isFavorite,
    @JsonKey(name: 'is_follow') bool isFollow,
    @JsonKey(name: 'like_num') int likeNum,
    @JsonKey(name: 'favorite_num') int favoriteNum,
  });
}

/// @nodoc
class _$UserActionCopyWithImpl<$Res, $Val extends UserAction>
    implements $UserActionCopyWith<$Res> {
  _$UserActionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLike = null,
    Object? isFavorite = null,
    Object? isFollow = null,
    Object? likeNum = null,
    Object? favoriteNum = null,
  }) {
    return _then(
      _value.copyWith(
            isLike: null == isLike
                ? _value.isLike
                : isLike // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFavorite: null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFollow: null == isFollow
                ? _value.isFollow
                : isFollow // ignore: cast_nullable_to_non_nullable
                      as bool,
            likeNum: null == likeNum
                ? _value.likeNum
                : likeNum // ignore: cast_nullable_to_non_nullable
                      as int,
            favoriteNum: null == favoriteNum
                ? _value.favoriteNum
                : favoriteNum // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserActionImplCopyWith<$Res>
    implements $UserActionCopyWith<$Res> {
  factory _$$UserActionImplCopyWith(
    _$UserActionImpl value,
    $Res Function(_$UserActionImpl) then,
  ) = __$$UserActionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'is_like') bool isLike,
    @JsonKey(name: 'is_favorite') bool isFavorite,
    @JsonKey(name: 'is_follow') bool isFollow,
    @JsonKey(name: 'like_num') int likeNum,
    @JsonKey(name: 'favorite_num') int favoriteNum,
  });
}

/// @nodoc
class __$$UserActionImplCopyWithImpl<$Res>
    extends _$UserActionCopyWithImpl<$Res, _$UserActionImpl>
    implements _$$UserActionImplCopyWith<$Res> {
  __$$UserActionImplCopyWithImpl(
    _$UserActionImpl _value,
    $Res Function(_$UserActionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserAction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLike = null,
    Object? isFavorite = null,
    Object? isFollow = null,
    Object? likeNum = null,
    Object? favoriteNum = null,
  }) {
    return _then(
      _$UserActionImpl(
        isLike: null == isLike
            ? _value.isLike
            : isLike // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFavorite: null == isFavorite
            ? _value.isFavorite
            : isFavorite // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFollow: null == isFollow
            ? _value.isFollow
            : isFollow // ignore: cast_nullable_to_non_nullable
                  as bool,
        likeNum: null == likeNum
            ? _value.likeNum
            : likeNum // ignore: cast_nullable_to_non_nullable
                  as int,
        favoriteNum: null == favoriteNum
            ? _value.favoriteNum
            : favoriteNum // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserActionImpl implements _UserAction {
  const _$UserActionImpl({
    @JsonKey(name: 'is_like') this.isLike = false,
    @JsonKey(name: 'is_favorite') this.isFavorite = false,
    @JsonKey(name: 'is_follow') this.isFollow = false,
    @JsonKey(name: 'like_num') this.likeNum = 0,
    @JsonKey(name: 'favorite_num') this.favoriteNum = 0,
  });

  factory _$UserActionImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserActionImplFromJson(json);

  @override
  @JsonKey(name: 'is_like')
  final bool isLike;
  @override
  @JsonKey(name: 'is_favorite')
  final bool isFavorite;
  @override
  @JsonKey(name: 'is_follow')
  final bool isFollow;
  @override
  @JsonKey(name: 'like_num')
  final int likeNum;
  @override
  @JsonKey(name: 'favorite_num')
  final int favoriteNum;

  @override
  String toString() {
    return 'UserAction(isLike: $isLike, isFavorite: $isFavorite, isFollow: $isFollow, likeNum: $likeNum, favoriteNum: $favoriteNum)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserActionImpl &&
            (identical(other.isLike, isLike) || other.isLike == isLike) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite) &&
            (identical(other.isFollow, isFollow) ||
                other.isFollow == isFollow) &&
            (identical(other.likeNum, likeNum) || other.likeNum == likeNum) &&
            (identical(other.favoriteNum, favoriteNum) ||
                other.favoriteNum == favoriteNum));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLike,
    isFavorite,
    isFollow,
    likeNum,
    favoriteNum,
  );

  /// Create a copy of UserAction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserActionImplCopyWith<_$UserActionImpl> get copyWith =>
      __$$UserActionImplCopyWithImpl<_$UserActionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserActionImplToJson(this);
  }
}

abstract class _UserAction implements UserAction {
  const factory _UserAction({
    @JsonKey(name: 'is_like') final bool isLike,
    @JsonKey(name: 'is_favorite') final bool isFavorite,
    @JsonKey(name: 'is_follow') final bool isFollow,
    @JsonKey(name: 'like_num') final int likeNum,
    @JsonKey(name: 'favorite_num') final int favoriteNum,
  }) = _$UserActionImpl;

  factory _UserAction.fromJson(Map<String, dynamic> json) =
      _$UserActionImpl.fromJson;

  @override
  @JsonKey(name: 'is_like')
  bool get isLike;
  @override
  @JsonKey(name: 'is_favorite')
  bool get isFavorite;
  @override
  @JsonKey(name: 'is_follow')
  bool get isFollow;
  @override
  @JsonKey(name: 'like_num')
  int get likeNum;
  @override
  @JsonKey(name: 'favorite_num')
  int get favoriteNum;

  /// Create a copy of UserAction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserActionImplCopyWith<_$UserActionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  @JsonKey(name: 'user_info')
  UserInfo get userInfo => throw _privateConstructorUsedError;
  @JsonKey(name: 'action')
  UserAction get action => throw _privateConstructorUsedError;
  @JsonKey(name: 'feed_count')
  int get feedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_count')
  int get replyCount => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
    UserProfile value,
    $Res Function(UserProfile) then,
  ) = _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_info') UserInfo userInfo,
    @JsonKey(name: 'action') UserAction action,
    @JsonKey(name: 'feed_count') int feedCount,
    @JsonKey(name: 'reply_count') int replyCount,
  });

  $UserInfoCopyWith<$Res> get userInfo;
  $UserActionCopyWith<$Res> get action;
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfo = null,
    Object? action = null,
    Object? feedCount = null,
    Object? replyCount = null,
  }) {
    return _then(
      _value.copyWith(
            userInfo: null == userInfo
                ? _value.userInfo
                : userInfo // ignore: cast_nullable_to_non_nullable
                      as UserInfo,
            action: null == action
                ? _value.action
                : action // ignore: cast_nullable_to_non_nullable
                      as UserAction,
            feedCount: null == feedCount
                ? _value.feedCount
                : feedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            replyCount: null == replyCount
                ? _value.replyCount
                : replyCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res> get userInfo {
    return $UserInfoCopyWith<$Res>(_value.userInfo, (value) {
      return _then(_value.copyWith(userInfo: value) as $Val);
    });
  }

  /// Create a copy of UserProfile
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
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
    _$UserProfileImpl value,
    $Res Function(_$UserProfileImpl) then,
  ) = __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_info') UserInfo userInfo,
    @JsonKey(name: 'action') UserAction action,
    @JsonKey(name: 'feed_count') int feedCount,
    @JsonKey(name: 'reply_count') int replyCount,
  });

  @override
  $UserInfoCopyWith<$Res> get userInfo;
  @override
  $UserActionCopyWith<$Res> get action;
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
    _$UserProfileImpl _value,
    $Res Function(_$UserProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userInfo = null,
    Object? action = null,
    Object? feedCount = null,
    Object? replyCount = null,
  }) {
    return _then(
      _$UserProfileImpl(
        userInfo: null == userInfo
            ? _value.userInfo
            : userInfo // ignore: cast_nullable_to_non_nullable
                  as UserInfo,
        action: null == action
            ? _value.action
            : action // ignore: cast_nullable_to_non_nullable
                  as UserAction,
        feedCount: null == feedCount
            ? _value.feedCount
            : feedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        replyCount: null == replyCount
            ? _value.replyCount
            : replyCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl({
    @JsonKey(name: 'user_info') required this.userInfo,
    @JsonKey(name: 'action') this.action = const UserAction(),
    @JsonKey(name: 'feed_count') this.feedCount = 0,
    @JsonKey(name: 'reply_count') this.replyCount = 0,
  });

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  @JsonKey(name: 'user_info')
  final UserInfo userInfo;
  @override
  @JsonKey(name: 'action')
  final UserAction action;
  @override
  @JsonKey(name: 'feed_count')
  final int feedCount;
  @override
  @JsonKey(name: 'reply_count')
  final int replyCount;

  @override
  String toString() {
    return 'UserProfile(userInfo: $userInfo, action: $action, feedCount: $feedCount, replyCount: $replyCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.userInfo, userInfo) ||
                other.userInfo == userInfo) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.feedCount, feedCount) ||
                other.feedCount == feedCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userInfo, action, feedCount, replyCount);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(this);
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile({
    @JsonKey(name: 'user_info') required final UserInfo userInfo,
    @JsonKey(name: 'action') final UserAction action,
    @JsonKey(name: 'feed_count') final int feedCount,
    @JsonKey(name: 'reply_count') final int replyCount,
  }) = _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  @JsonKey(name: 'user_info')
  UserInfo get userInfo;
  @override
  @JsonKey(name: 'action')
  UserAction get action;
  @override
  @JsonKey(name: 'feed_count')
  int get feedCount;
  @override
  @JsonKey(name: 'reply_count')
  int get replyCount;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return _LoginResponse.fromJson(json);
}

/// @nodoc
mixin _$LoginResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  UserInfo? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'token')
  String? get token => throw _privateConstructorUsedError;

  /// Serializes this LoginResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginResponseCopyWith<LoginResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginResponseCopyWith<$Res> {
  factory $LoginResponseCopyWith(
    LoginResponse value,
    $Res Function(LoginResponse) then,
  ) = _$LoginResponseCopyWithImpl<$Res, LoginResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') UserInfo? data,
    @JsonKey(name: 'token') String? token,
  });

  $UserInfoCopyWith<$Res>? get data;
}

/// @nodoc
class _$LoginResponseCopyWithImpl<$Res, $Val extends LoginResponse>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
    Object? token = freezed,
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
                      as UserInfo?,
            token: freezed == token
                ? _value.token
                : token // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserInfoCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $UserInfoCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LoginResponseImplCopyWith<$Res>
    implements $LoginResponseCopyWith<$Res> {
  factory _$$LoginResponseImplCopyWith(
    _$LoginResponseImpl value,
    $Res Function(_$LoginResponseImpl) then,
  ) = __$$LoginResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') UserInfo? data,
    @JsonKey(name: 'token') String? token,
  });

  @override
  $UserInfoCopyWith<$Res>? get data;
}

/// @nodoc
class __$$LoginResponseImplCopyWithImpl<$Res>
    extends _$LoginResponseCopyWithImpl<$Res, _$LoginResponseImpl>
    implements _$$LoginResponseImplCopyWith<$Res> {
  __$$LoginResponseImplCopyWithImpl(
    _$LoginResponseImpl _value,
    $Res Function(_$LoginResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
    Object? token = freezed,
  }) {
    return _then(
      _$LoginResponseImpl(
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
                  as UserInfo?,
        token: freezed == token
            ? _value.token
            : token // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LoginResponseImpl implements _LoginResponse {
  const _$LoginResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') this.data,
    @JsonKey(name: 'token') this.token,
  });

  factory _$LoginResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'data')
  final UserInfo? data;
  @override
  @JsonKey(name: 'token')
  final String? token;

  @override
  String toString() {
    return 'LoginResponse(status: $status, message: $message, data: $data, token: $token)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.token, token) || other.token == token));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data, token);

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      __$$LoginResponseImplCopyWithImpl<_$LoginResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginResponseImplToJson(this);
  }
}

abstract class _LoginResponse implements LoginResponse {
  const factory _LoginResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final UserInfo? data,
    @JsonKey(name: 'token') final String? token,
  }) = _$LoginResponseImpl;

  factory _LoginResponse.fromJson(Map<String, dynamic> json) =
      _$LoginResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  UserInfo? get data;
  @override
  @JsonKey(name: 'token')
  String? get token;

  /// Create a copy of LoginResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginResponseImplCopyWith<_$LoginResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
