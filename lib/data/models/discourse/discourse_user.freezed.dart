// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discourse_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DiscourseUser _$DiscourseUserFromJson(Map<String, dynamic> json) {
  return _DiscourseUser.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUser {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'secondary_emails')
  List<String> get secondaryEmails => throw _privateConstructorUsedError;
  @JsonKey(name: 'unconfirmed_emails')
  List<String> get unconfirmedEmails => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_seen_at')
  String? get lastSeenAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'ignored')
  bool get ignored => throw _privateConstructorUsedError;
  @JsonKey(name: 'muted')
  bool get muted => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_ignore_user')
  bool get canIgnoreUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_mute_user')
  bool get canMuteUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_send_private_messages')
  bool get canSendPrivateMessages => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_send_private_message_to_user')
  bool get canSendPrivateMessageToUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level')
  int get trustLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'moderator')
  bool get moderator => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin')
  bool get admin => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_count')
  int get badgeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_auth_tokens')
  List<dynamic> get userAuthTokens => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_notification_schedule')
  Map<String, dynamic>? get userNotificationSchedule =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'featured_topic')
  Map<String, dynamic>? get featuredTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'timezone')
  String? get timezone => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_hidden')
  bool get profileHidden => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_be_deleted')
  bool get canBeDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_delete_all_posts')
  bool get canDeleteAllPosts => throw _privateConstructorUsedError;
  @JsonKey(name: 'locale')
  String? get locale => throw _privateConstructorUsedError;
  @JsonKey(name: 'muted_category_ids')
  List<int> get mutedCategoryIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'regular_category_ids')
  List<int> get regularCategoryIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'watched_tags')
  List<String> get watchedTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'watching_first_post_tags')
  List<String> get watchingFirstPostTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracked_tags')
  List<String> get trackedTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'muted_tags')
  List<String> get mutedTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'tracked_category_ids')
  List<int> get trackedCategoryIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'watched_category_ids')
  List<int> get watchedCategoryIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'watched_first_post_category_ids')
  List<int> get watchedFirstPostCategoryIds =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'system_avatar_template')
  String? get systemAvatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'muted_usernames')
  List<String> get mutedUsernames => throw _privateConstructorUsedError;
  @JsonKey(name: 'ignored_usernames')
  List<String> get ignoredUsernames => throw _privateConstructorUsedError;
  @JsonKey(name: 'allowed_pm_usernames')
  List<String> get allowedPmUsernames => throw _privateConstructorUsedError;
  @JsonKey(name: 'mailing_list_posts_per_day')
  int? get mailingListPostsPerDay => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_change_bio')
  bool get canChangeBio => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_change_location')
  bool get canChangeLocation => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_change_website')
  bool get canChangeWebsite => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_change_tracking_preferences')
  bool get canChangeTrackingPreferences => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_api_keys')
  List<dynamic> get userApiKeys => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_status')
  Map<String, dynamic>? get userStatus => throw _privateConstructorUsedError;
  @JsonKey(name: 'sidebar_tags')
  List<dynamic> get sidebarTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'sidebar_category_ids')
  List<int> get sidebarCategoryIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_sidebar_tags')
  bool get displaySidebarTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'sidebar_list_destination')
  String? get sidebarListDestination => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserCopyWith<DiscourseUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserCopyWith<$Res> {
  factory $DiscourseUserCopyWith(
    DiscourseUser value,
    $Res Function(DiscourseUser) then,
  ) = _$DiscourseUserCopyWithImpl<$Res, DiscourseUser>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'secondary_emails') List<String> secondaryEmails,
    @JsonKey(name: 'unconfirmed_emails') List<String> unconfirmedEmails,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'last_seen_at') String? lastSeenAt,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'ignored') bool ignored,
    @JsonKey(name: 'muted') bool muted,
    @JsonKey(name: 'can_ignore_user') bool canIgnoreUser,
    @JsonKey(name: 'can_mute_user') bool canMuteUser,
    @JsonKey(name: 'can_send_private_messages') bool canSendPrivateMessages,
    @JsonKey(name: 'can_send_private_message_to_user')
    bool canSendPrivateMessageToUser,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'badge_count') int badgeCount,
    @JsonKey(name: 'user_auth_tokens') List<dynamic> userAuthTokens,
    @JsonKey(name: 'user_notification_schedule')
    Map<String, dynamic>? userNotificationSchedule,
    @JsonKey(name: 'featured_topic') Map<String, dynamic>? featuredTopic,
    @JsonKey(name: 'timezone') String? timezone,
    @JsonKey(name: 'profile_hidden') bool profileHidden,
    @JsonKey(name: 'can_be_deleted') bool canBeDeleted,
    @JsonKey(name: 'can_delete_all_posts') bool canDeleteAllPosts,
    @JsonKey(name: 'locale') String? locale,
    @JsonKey(name: 'muted_category_ids') List<int> mutedCategoryIds,
    @JsonKey(name: 'regular_category_ids') List<int> regularCategoryIds,
    @JsonKey(name: 'watched_tags') List<String> watchedTags,
    @JsonKey(name: 'watching_first_post_tags')
    List<String> watchingFirstPostTags,
    @JsonKey(name: 'tracked_tags') List<String> trackedTags,
    @JsonKey(name: 'muted_tags') List<String> mutedTags,
    @JsonKey(name: 'tracked_category_ids') List<int> trackedCategoryIds,
    @JsonKey(name: 'watched_category_ids') List<int> watchedCategoryIds,
    @JsonKey(name: 'watched_first_post_category_ids')
    List<int> watchedFirstPostCategoryIds,
    @JsonKey(name: 'system_avatar_template') String? systemAvatarTemplate,
    @JsonKey(name: 'muted_usernames') List<String> mutedUsernames,
    @JsonKey(name: 'ignored_usernames') List<String> ignoredUsernames,
    @JsonKey(name: 'allowed_pm_usernames') List<String> allowedPmUsernames,
    @JsonKey(name: 'mailing_list_posts_per_day') int? mailingListPostsPerDay,
    @JsonKey(name: 'can_change_bio') bool canChangeBio,
    @JsonKey(name: 'can_change_location') bool canChangeLocation,
    @JsonKey(name: 'can_change_website') bool canChangeWebsite,
    @JsonKey(name: 'can_change_tracking_preferences')
    bool canChangeTrackingPreferences,
    @JsonKey(name: 'user_api_keys') List<dynamic> userApiKeys,
    @JsonKey(name: 'user_status') Map<String, dynamic>? userStatus,
    @JsonKey(name: 'sidebar_tags') List<dynamic> sidebarTags,
    @JsonKey(name: 'sidebar_category_ids') List<int> sidebarCategoryIds,
    @JsonKey(name: 'display_sidebar_tags') bool displaySidebarTags,
    @JsonKey(name: 'sidebar_list_destination') String? sidebarListDestination,
  });
}

/// @nodoc
class _$DiscourseUserCopyWithImpl<$Res, $Val extends DiscourseUser>
    implements $DiscourseUserCopyWith<$Res> {
  _$DiscourseUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? email = freezed,
    Object? secondaryEmails = null,
    Object? unconfirmedEmails = null,
    Object? lastPostedAt = freezed,
    Object? lastSeenAt = freezed,
    Object? createdAt = null,
    Object? ignored = null,
    Object? muted = null,
    Object? canIgnoreUser = null,
    Object? canMuteUser = null,
    Object? canSendPrivateMessages = null,
    Object? canSendPrivateMessageToUser = null,
    Object? trustLevel = null,
    Object? moderator = null,
    Object? admin = null,
    Object? title = freezed,
    Object? badgeCount = null,
    Object? userAuthTokens = null,
    Object? userNotificationSchedule = freezed,
    Object? featuredTopic = freezed,
    Object? timezone = freezed,
    Object? profileHidden = null,
    Object? canBeDeleted = null,
    Object? canDeleteAllPosts = null,
    Object? locale = freezed,
    Object? mutedCategoryIds = null,
    Object? regularCategoryIds = null,
    Object? watchedTags = null,
    Object? watchingFirstPostTags = null,
    Object? trackedTags = null,
    Object? mutedTags = null,
    Object? trackedCategoryIds = null,
    Object? watchedCategoryIds = null,
    Object? watchedFirstPostCategoryIds = null,
    Object? systemAvatarTemplate = freezed,
    Object? mutedUsernames = null,
    Object? ignoredUsernames = null,
    Object? allowedPmUsernames = null,
    Object? mailingListPostsPerDay = freezed,
    Object? canChangeBio = null,
    Object? canChangeLocation = null,
    Object? canChangeWebsite = null,
    Object? canChangeTrackingPreferences = null,
    Object? userApiKeys = null,
    Object? userStatus = freezed,
    Object? sidebarTags = null,
    Object? sidebarCategoryIds = null,
    Object? displaySidebarTags = null,
    Object? sidebarListDestination = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarTemplate: null == avatarTemplate
                ? _value.avatarTemplate
                : avatarTemplate // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            secondaryEmails: null == secondaryEmails
                ? _value.secondaryEmails
                : secondaryEmails // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            unconfirmedEmails: null == unconfirmedEmails
                ? _value.unconfirmedEmails
                : unconfirmedEmails // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lastPostedAt: freezed == lastPostedAt
                ? _value.lastPostedAt
                : lastPostedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastSeenAt: freezed == lastSeenAt
                ? _value.lastSeenAt
                : lastSeenAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            ignored: null == ignored
                ? _value.ignored
                : ignored // ignore: cast_nullable_to_non_nullable
                      as bool,
            muted: null == muted
                ? _value.muted
                : muted // ignore: cast_nullable_to_non_nullable
                      as bool,
            canIgnoreUser: null == canIgnoreUser
                ? _value.canIgnoreUser
                : canIgnoreUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            canMuteUser: null == canMuteUser
                ? _value.canMuteUser
                : canMuteUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            canSendPrivateMessages: null == canSendPrivateMessages
                ? _value.canSendPrivateMessages
                : canSendPrivateMessages // ignore: cast_nullable_to_non_nullable
                      as bool,
            canSendPrivateMessageToUser: null == canSendPrivateMessageToUser
                ? _value.canSendPrivateMessageToUser
                : canSendPrivateMessageToUser // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustLevel: null == trustLevel
                ? _value.trustLevel
                : trustLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            moderator: null == moderator
                ? _value.moderator
                : moderator // ignore: cast_nullable_to_non_nullable
                      as bool,
            admin: null == admin
                ? _value.admin
                : admin // ignore: cast_nullable_to_non_nullable
                      as bool,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            badgeCount: null == badgeCount
                ? _value.badgeCount
                : badgeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            userAuthTokens: null == userAuthTokens
                ? _value.userAuthTokens
                : userAuthTokens // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            userNotificationSchedule: freezed == userNotificationSchedule
                ? _value.userNotificationSchedule
                : userNotificationSchedule // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            featuredTopic: freezed == featuredTopic
                ? _value.featuredTopic
                : featuredTopic // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            timezone: freezed == timezone
                ? _value.timezone
                : timezone // ignore: cast_nullable_to_non_nullable
                      as String?,
            profileHidden: null == profileHidden
                ? _value.profileHidden
                : profileHidden // ignore: cast_nullable_to_non_nullable
                      as bool,
            canBeDeleted: null == canBeDeleted
                ? _value.canBeDeleted
                : canBeDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            canDeleteAllPosts: null == canDeleteAllPosts
                ? _value.canDeleteAllPosts
                : canDeleteAllPosts // ignore: cast_nullable_to_non_nullable
                      as bool,
            locale: freezed == locale
                ? _value.locale
                : locale // ignore: cast_nullable_to_non_nullable
                      as String?,
            mutedCategoryIds: null == mutedCategoryIds
                ? _value.mutedCategoryIds
                : mutedCategoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            regularCategoryIds: null == regularCategoryIds
                ? _value.regularCategoryIds
                : regularCategoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            watchedTags: null == watchedTags
                ? _value.watchedTags
                : watchedTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            watchingFirstPostTags: null == watchingFirstPostTags
                ? _value.watchingFirstPostTags
                : watchingFirstPostTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            trackedTags: null == trackedTags
                ? _value.trackedTags
                : trackedTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mutedTags: null == mutedTags
                ? _value.mutedTags
                : mutedTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            trackedCategoryIds: null == trackedCategoryIds
                ? _value.trackedCategoryIds
                : trackedCategoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            watchedCategoryIds: null == watchedCategoryIds
                ? _value.watchedCategoryIds
                : watchedCategoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            watchedFirstPostCategoryIds: null == watchedFirstPostCategoryIds
                ? _value.watchedFirstPostCategoryIds
                : watchedFirstPostCategoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            systemAvatarTemplate: freezed == systemAvatarTemplate
                ? _value.systemAvatarTemplate
                : systemAvatarTemplate // ignore: cast_nullable_to_non_nullable
                      as String?,
            mutedUsernames: null == mutedUsernames
                ? _value.mutedUsernames
                : mutedUsernames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            ignoredUsernames: null == ignoredUsernames
                ? _value.ignoredUsernames
                : ignoredUsernames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            allowedPmUsernames: null == allowedPmUsernames
                ? _value.allowedPmUsernames
                : allowedPmUsernames // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            mailingListPostsPerDay: freezed == mailingListPostsPerDay
                ? _value.mailingListPostsPerDay
                : mailingListPostsPerDay // ignore: cast_nullable_to_non_nullable
                      as int?,
            canChangeBio: null == canChangeBio
                ? _value.canChangeBio
                : canChangeBio // ignore: cast_nullable_to_non_nullable
                      as bool,
            canChangeLocation: null == canChangeLocation
                ? _value.canChangeLocation
                : canChangeLocation // ignore: cast_nullable_to_non_nullable
                      as bool,
            canChangeWebsite: null == canChangeWebsite
                ? _value.canChangeWebsite
                : canChangeWebsite // ignore: cast_nullable_to_non_nullable
                      as bool,
            canChangeTrackingPreferences: null == canChangeTrackingPreferences
                ? _value.canChangeTrackingPreferences
                : canChangeTrackingPreferences // ignore: cast_nullable_to_non_nullable
                      as bool,
            userApiKeys: null == userApiKeys
                ? _value.userApiKeys
                : userApiKeys // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            userStatus: freezed == userStatus
                ? _value.userStatus
                : userStatus // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            sidebarTags: null == sidebarTags
                ? _value.sidebarTags
                : sidebarTags // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            sidebarCategoryIds: null == sidebarCategoryIds
                ? _value.sidebarCategoryIds
                : sidebarCategoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            displaySidebarTags: null == displaySidebarTags
                ? _value.displaySidebarTags
                : displaySidebarTags // ignore: cast_nullable_to_non_nullable
                      as bool,
            sidebarListDestination: freezed == sidebarListDestination
                ? _value.sidebarListDestination
                : sidebarListDestination // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserImplCopyWith<$Res>
    implements $DiscourseUserCopyWith<$Res> {
  factory _$$DiscourseUserImplCopyWith(
    _$DiscourseUserImpl value,
    $Res Function(_$DiscourseUserImpl) then,
  ) = __$$DiscourseUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'secondary_emails') List<String> secondaryEmails,
    @JsonKey(name: 'unconfirmed_emails') List<String> unconfirmedEmails,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'last_seen_at') String? lastSeenAt,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'ignored') bool ignored,
    @JsonKey(name: 'muted') bool muted,
    @JsonKey(name: 'can_ignore_user') bool canIgnoreUser,
    @JsonKey(name: 'can_mute_user') bool canMuteUser,
    @JsonKey(name: 'can_send_private_messages') bool canSendPrivateMessages,
    @JsonKey(name: 'can_send_private_message_to_user')
    bool canSendPrivateMessageToUser,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'badge_count') int badgeCount,
    @JsonKey(name: 'user_auth_tokens') List<dynamic> userAuthTokens,
    @JsonKey(name: 'user_notification_schedule')
    Map<String, dynamic>? userNotificationSchedule,
    @JsonKey(name: 'featured_topic') Map<String, dynamic>? featuredTopic,
    @JsonKey(name: 'timezone') String? timezone,
    @JsonKey(name: 'profile_hidden') bool profileHidden,
    @JsonKey(name: 'can_be_deleted') bool canBeDeleted,
    @JsonKey(name: 'can_delete_all_posts') bool canDeleteAllPosts,
    @JsonKey(name: 'locale') String? locale,
    @JsonKey(name: 'muted_category_ids') List<int> mutedCategoryIds,
    @JsonKey(name: 'regular_category_ids') List<int> regularCategoryIds,
    @JsonKey(name: 'watched_tags') List<String> watchedTags,
    @JsonKey(name: 'watching_first_post_tags')
    List<String> watchingFirstPostTags,
    @JsonKey(name: 'tracked_tags') List<String> trackedTags,
    @JsonKey(name: 'muted_tags') List<String> mutedTags,
    @JsonKey(name: 'tracked_category_ids') List<int> trackedCategoryIds,
    @JsonKey(name: 'watched_category_ids') List<int> watchedCategoryIds,
    @JsonKey(name: 'watched_first_post_category_ids')
    List<int> watchedFirstPostCategoryIds,
    @JsonKey(name: 'system_avatar_template') String? systemAvatarTemplate,
    @JsonKey(name: 'muted_usernames') List<String> mutedUsernames,
    @JsonKey(name: 'ignored_usernames') List<String> ignoredUsernames,
    @JsonKey(name: 'allowed_pm_usernames') List<String> allowedPmUsernames,
    @JsonKey(name: 'mailing_list_posts_per_day') int? mailingListPostsPerDay,
    @JsonKey(name: 'can_change_bio') bool canChangeBio,
    @JsonKey(name: 'can_change_location') bool canChangeLocation,
    @JsonKey(name: 'can_change_website') bool canChangeWebsite,
    @JsonKey(name: 'can_change_tracking_preferences')
    bool canChangeTrackingPreferences,
    @JsonKey(name: 'user_api_keys') List<dynamic> userApiKeys,
    @JsonKey(name: 'user_status') Map<String, dynamic>? userStatus,
    @JsonKey(name: 'sidebar_tags') List<dynamic> sidebarTags,
    @JsonKey(name: 'sidebar_category_ids') List<int> sidebarCategoryIds,
    @JsonKey(name: 'display_sidebar_tags') bool displaySidebarTags,
    @JsonKey(name: 'sidebar_list_destination') String? sidebarListDestination,
  });
}

/// @nodoc
class __$$DiscourseUserImplCopyWithImpl<$Res>
    extends _$DiscourseUserCopyWithImpl<$Res, _$DiscourseUserImpl>
    implements _$$DiscourseUserImplCopyWith<$Res> {
  __$$DiscourseUserImplCopyWithImpl(
    _$DiscourseUserImpl _value,
    $Res Function(_$DiscourseUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? email = freezed,
    Object? secondaryEmails = null,
    Object? unconfirmedEmails = null,
    Object? lastPostedAt = freezed,
    Object? lastSeenAt = freezed,
    Object? createdAt = null,
    Object? ignored = null,
    Object? muted = null,
    Object? canIgnoreUser = null,
    Object? canMuteUser = null,
    Object? canSendPrivateMessages = null,
    Object? canSendPrivateMessageToUser = null,
    Object? trustLevel = null,
    Object? moderator = null,
    Object? admin = null,
    Object? title = freezed,
    Object? badgeCount = null,
    Object? userAuthTokens = null,
    Object? userNotificationSchedule = freezed,
    Object? featuredTopic = freezed,
    Object? timezone = freezed,
    Object? profileHidden = null,
    Object? canBeDeleted = null,
    Object? canDeleteAllPosts = null,
    Object? locale = freezed,
    Object? mutedCategoryIds = null,
    Object? regularCategoryIds = null,
    Object? watchedTags = null,
    Object? watchingFirstPostTags = null,
    Object? trackedTags = null,
    Object? mutedTags = null,
    Object? trackedCategoryIds = null,
    Object? watchedCategoryIds = null,
    Object? watchedFirstPostCategoryIds = null,
    Object? systemAvatarTemplate = freezed,
    Object? mutedUsernames = null,
    Object? ignoredUsernames = null,
    Object? allowedPmUsernames = null,
    Object? mailingListPostsPerDay = freezed,
    Object? canChangeBio = null,
    Object? canChangeLocation = null,
    Object? canChangeWebsite = null,
    Object? canChangeTrackingPreferences = null,
    Object? userApiKeys = null,
    Object? userStatus = freezed,
    Object? sidebarTags = null,
    Object? sidebarCategoryIds = null,
    Object? displaySidebarTags = null,
    Object? sidebarListDestination = freezed,
  }) {
    return _then(
      _$DiscourseUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarTemplate: null == avatarTemplate
            ? _value.avatarTemplate
            : avatarTemplate // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        secondaryEmails: null == secondaryEmails
            ? _value._secondaryEmails
            : secondaryEmails // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        unconfirmedEmails: null == unconfirmedEmails
            ? _value._unconfirmedEmails
            : unconfirmedEmails // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lastPostedAt: freezed == lastPostedAt
            ? _value.lastPostedAt
            : lastPostedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastSeenAt: freezed == lastSeenAt
            ? _value.lastSeenAt
            : lastSeenAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        ignored: null == ignored
            ? _value.ignored
            : ignored // ignore: cast_nullable_to_non_nullable
                  as bool,
        muted: null == muted
            ? _value.muted
            : muted // ignore: cast_nullable_to_non_nullable
                  as bool,
        canIgnoreUser: null == canIgnoreUser
            ? _value.canIgnoreUser
            : canIgnoreUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        canMuteUser: null == canMuteUser
            ? _value.canMuteUser
            : canMuteUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        canSendPrivateMessages: null == canSendPrivateMessages
            ? _value.canSendPrivateMessages
            : canSendPrivateMessages // ignore: cast_nullable_to_non_nullable
                  as bool,
        canSendPrivateMessageToUser: null == canSendPrivateMessageToUser
            ? _value.canSendPrivateMessageToUser
            : canSendPrivateMessageToUser // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustLevel: null == trustLevel
            ? _value.trustLevel
            : trustLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        moderator: null == moderator
            ? _value.moderator
            : moderator // ignore: cast_nullable_to_non_nullable
                  as bool,
        admin: null == admin
            ? _value.admin
            : admin // ignore: cast_nullable_to_non_nullable
                  as bool,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        badgeCount: null == badgeCount
            ? _value.badgeCount
            : badgeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        userAuthTokens: null == userAuthTokens
            ? _value._userAuthTokens
            : userAuthTokens // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        userNotificationSchedule: freezed == userNotificationSchedule
            ? _value._userNotificationSchedule
            : userNotificationSchedule // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        featuredTopic: freezed == featuredTopic
            ? _value._featuredTopic
            : featuredTopic // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        timezone: freezed == timezone
            ? _value.timezone
            : timezone // ignore: cast_nullable_to_non_nullable
                  as String?,
        profileHidden: null == profileHidden
            ? _value.profileHidden
            : profileHidden // ignore: cast_nullable_to_non_nullable
                  as bool,
        canBeDeleted: null == canBeDeleted
            ? _value.canBeDeleted
            : canBeDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        canDeleteAllPosts: null == canDeleteAllPosts
            ? _value.canDeleteAllPosts
            : canDeleteAllPosts // ignore: cast_nullable_to_non_nullable
                  as bool,
        locale: freezed == locale
            ? _value.locale
            : locale // ignore: cast_nullable_to_non_nullable
                  as String?,
        mutedCategoryIds: null == mutedCategoryIds
            ? _value._mutedCategoryIds
            : mutedCategoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        regularCategoryIds: null == regularCategoryIds
            ? _value._regularCategoryIds
            : regularCategoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        watchedTags: null == watchedTags
            ? _value._watchedTags
            : watchedTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        watchingFirstPostTags: null == watchingFirstPostTags
            ? _value._watchingFirstPostTags
            : watchingFirstPostTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        trackedTags: null == trackedTags
            ? _value._trackedTags
            : trackedTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mutedTags: null == mutedTags
            ? _value._mutedTags
            : mutedTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        trackedCategoryIds: null == trackedCategoryIds
            ? _value._trackedCategoryIds
            : trackedCategoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        watchedCategoryIds: null == watchedCategoryIds
            ? _value._watchedCategoryIds
            : watchedCategoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        watchedFirstPostCategoryIds: null == watchedFirstPostCategoryIds
            ? _value._watchedFirstPostCategoryIds
            : watchedFirstPostCategoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        systemAvatarTemplate: freezed == systemAvatarTemplate
            ? _value.systemAvatarTemplate
            : systemAvatarTemplate // ignore: cast_nullable_to_non_nullable
                  as String?,
        mutedUsernames: null == mutedUsernames
            ? _value._mutedUsernames
            : mutedUsernames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        ignoredUsernames: null == ignoredUsernames
            ? _value._ignoredUsernames
            : ignoredUsernames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        allowedPmUsernames: null == allowedPmUsernames
            ? _value._allowedPmUsernames
            : allowedPmUsernames // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        mailingListPostsPerDay: freezed == mailingListPostsPerDay
            ? _value.mailingListPostsPerDay
            : mailingListPostsPerDay // ignore: cast_nullable_to_non_nullable
                  as int?,
        canChangeBio: null == canChangeBio
            ? _value.canChangeBio
            : canChangeBio // ignore: cast_nullable_to_non_nullable
                  as bool,
        canChangeLocation: null == canChangeLocation
            ? _value.canChangeLocation
            : canChangeLocation // ignore: cast_nullable_to_non_nullable
                  as bool,
        canChangeWebsite: null == canChangeWebsite
            ? _value.canChangeWebsite
            : canChangeWebsite // ignore: cast_nullable_to_non_nullable
                  as bool,
        canChangeTrackingPreferences: null == canChangeTrackingPreferences
            ? _value.canChangeTrackingPreferences
            : canChangeTrackingPreferences // ignore: cast_nullable_to_non_nullable
                  as bool,
        userApiKeys: null == userApiKeys
            ? _value._userApiKeys
            : userApiKeys // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        userStatus: freezed == userStatus
            ? _value._userStatus
            : userStatus // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        sidebarTags: null == sidebarTags
            ? _value._sidebarTags
            : sidebarTags // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        sidebarCategoryIds: null == sidebarCategoryIds
            ? _value._sidebarCategoryIds
            : sidebarCategoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        displaySidebarTags: null == displaySidebarTags
            ? _value.displaySidebarTags
            : displaySidebarTags // ignore: cast_nullable_to_non_nullable
                  as bool,
        sidebarListDestination: freezed == sidebarListDestination
            ? _value.sidebarListDestination
            : sidebarListDestination // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserImpl implements _DiscourseUser {
  const _$DiscourseUserImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'email') this.email,
    @JsonKey(name: 'secondary_emails')
    final List<String> secondaryEmails = const [],
    @JsonKey(name: 'unconfirmed_emails')
    final List<String> unconfirmedEmails = const [],
    @JsonKey(name: 'last_posted_at') this.lastPostedAt,
    @JsonKey(name: 'last_seen_at') this.lastSeenAt,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'ignored') this.ignored = false,
    @JsonKey(name: 'muted') this.muted = false,
    @JsonKey(name: 'can_ignore_user') this.canIgnoreUser = false,
    @JsonKey(name: 'can_mute_user') this.canMuteUser = false,
    @JsonKey(name: 'can_send_private_messages')
    this.canSendPrivateMessages = false,
    @JsonKey(name: 'can_send_private_message_to_user')
    this.canSendPrivateMessageToUser = false,
    @JsonKey(name: 'trust_level') this.trustLevel = 0,
    @JsonKey(name: 'moderator') this.moderator = false,
    @JsonKey(name: 'admin') this.admin = false,
    @JsonKey(name: 'title') this.title,
    @JsonKey(name: 'badge_count') this.badgeCount = 0,
    @JsonKey(name: 'user_auth_tokens')
    final List<dynamic> userAuthTokens = const [],
    @JsonKey(name: 'user_notification_schedule')
    final Map<String, dynamic>? userNotificationSchedule,
    @JsonKey(name: 'featured_topic') final Map<String, dynamic>? featuredTopic,
    @JsonKey(name: 'timezone') this.timezone,
    @JsonKey(name: 'profile_hidden') this.profileHidden = false,
    @JsonKey(name: 'can_be_deleted') this.canBeDeleted = false,
    @JsonKey(name: 'can_delete_all_posts') this.canDeleteAllPosts = false,
    @JsonKey(name: 'locale') this.locale,
    @JsonKey(name: 'muted_category_ids')
    final List<int> mutedCategoryIds = const [],
    @JsonKey(name: 'regular_category_ids')
    final List<int> regularCategoryIds = const [],
    @JsonKey(name: 'watched_tags') final List<String> watchedTags = const [],
    @JsonKey(name: 'watching_first_post_tags')
    final List<String> watchingFirstPostTags = const [],
    @JsonKey(name: 'tracked_tags') final List<String> trackedTags = const [],
    @JsonKey(name: 'muted_tags') final List<String> mutedTags = const [],
    @JsonKey(name: 'tracked_category_ids')
    final List<int> trackedCategoryIds = const [],
    @JsonKey(name: 'watched_category_ids')
    final List<int> watchedCategoryIds = const [],
    @JsonKey(name: 'watched_first_post_category_ids')
    final List<int> watchedFirstPostCategoryIds = const [],
    @JsonKey(name: 'system_avatar_template') this.systemAvatarTemplate,
    @JsonKey(name: 'muted_usernames')
    final List<String> mutedUsernames = const [],
    @JsonKey(name: 'ignored_usernames')
    final List<String> ignoredUsernames = const [],
    @JsonKey(name: 'allowed_pm_usernames')
    final List<String> allowedPmUsernames = const [],
    @JsonKey(name: 'mailing_list_posts_per_day') this.mailingListPostsPerDay,
    @JsonKey(name: 'can_change_bio') this.canChangeBio = false,
    @JsonKey(name: 'can_change_location') this.canChangeLocation = false,
    @JsonKey(name: 'can_change_website') this.canChangeWebsite = false,
    @JsonKey(name: 'can_change_tracking_preferences')
    this.canChangeTrackingPreferences = false,
    @JsonKey(name: 'user_api_keys') final List<dynamic> userApiKeys = const [],
    @JsonKey(name: 'user_status') final Map<String, dynamic>? userStatus,
    @JsonKey(name: 'sidebar_tags') final List<dynamic> sidebarTags = const [],
    @JsonKey(name: 'sidebar_category_ids')
    final List<int> sidebarCategoryIds = const [],
    @JsonKey(name: 'display_sidebar_tags') this.displaySidebarTags = false,
    @JsonKey(name: 'sidebar_list_destination') this.sidebarListDestination,
  }) : _secondaryEmails = secondaryEmails,
       _unconfirmedEmails = unconfirmedEmails,
       _userAuthTokens = userAuthTokens,
       _userNotificationSchedule = userNotificationSchedule,
       _featuredTopic = featuredTopic,
       _mutedCategoryIds = mutedCategoryIds,
       _regularCategoryIds = regularCategoryIds,
       _watchedTags = watchedTags,
       _watchingFirstPostTags = watchingFirstPostTags,
       _trackedTags = trackedTags,
       _mutedTags = mutedTags,
       _trackedCategoryIds = trackedCategoryIds,
       _watchedCategoryIds = watchedCategoryIds,
       _watchedFirstPostCategoryIds = watchedFirstPostCategoryIds,
       _mutedUsernames = mutedUsernames,
       _ignoredUsernames = ignoredUsernames,
       _allowedPmUsernames = allowedPmUsernames,
       _userApiKeys = userApiKeys,
       _userStatus = userStatus,
       _sidebarTags = sidebarTags,
       _sidebarCategoryIds = sidebarCategoryIds;

  factory _$DiscourseUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'avatar_template')
  final String avatarTemplate;
  @override
  @JsonKey(name: 'email')
  final String? email;
  final List<String> _secondaryEmails;
  @override
  @JsonKey(name: 'secondary_emails')
  List<String> get secondaryEmails {
    if (_secondaryEmails is EqualUnmodifiableListView) return _secondaryEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_secondaryEmails);
  }

  final List<String> _unconfirmedEmails;
  @override
  @JsonKey(name: 'unconfirmed_emails')
  List<String> get unconfirmedEmails {
    if (_unconfirmedEmails is EqualUnmodifiableListView)
      return _unconfirmedEmails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unconfirmedEmails);
  }

  @override
  @JsonKey(name: 'last_posted_at')
  final String? lastPostedAt;
  @override
  @JsonKey(name: 'last_seen_at')
  final String? lastSeenAt;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'ignored')
  final bool ignored;
  @override
  @JsonKey(name: 'muted')
  final bool muted;
  @override
  @JsonKey(name: 'can_ignore_user')
  final bool canIgnoreUser;
  @override
  @JsonKey(name: 'can_mute_user')
  final bool canMuteUser;
  @override
  @JsonKey(name: 'can_send_private_messages')
  final bool canSendPrivateMessages;
  @override
  @JsonKey(name: 'can_send_private_message_to_user')
  final bool canSendPrivateMessageToUser;
  @override
  @JsonKey(name: 'trust_level')
  final int trustLevel;
  @override
  @JsonKey(name: 'moderator')
  final bool moderator;
  @override
  @JsonKey(name: 'admin')
  final bool admin;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'badge_count')
  final int badgeCount;
  final List<dynamic> _userAuthTokens;
  @override
  @JsonKey(name: 'user_auth_tokens')
  List<dynamic> get userAuthTokens {
    if (_userAuthTokens is EqualUnmodifiableListView) return _userAuthTokens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userAuthTokens);
  }

  final Map<String, dynamic>? _userNotificationSchedule;
  @override
  @JsonKey(name: 'user_notification_schedule')
  Map<String, dynamic>? get userNotificationSchedule {
    final value = _userNotificationSchedule;
    if (value == null) return null;
    if (_userNotificationSchedule is EqualUnmodifiableMapView)
      return _userNotificationSchedule;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, dynamic>? _featuredTopic;
  @override
  @JsonKey(name: 'featured_topic')
  Map<String, dynamic>? get featuredTopic {
    final value = _featuredTopic;
    if (value == null) return null;
    if (_featuredTopic is EqualUnmodifiableMapView) return _featuredTopic;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'timezone')
  final String? timezone;
  @override
  @JsonKey(name: 'profile_hidden')
  final bool profileHidden;
  @override
  @JsonKey(name: 'can_be_deleted')
  final bool canBeDeleted;
  @override
  @JsonKey(name: 'can_delete_all_posts')
  final bool canDeleteAllPosts;
  @override
  @JsonKey(name: 'locale')
  final String? locale;
  final List<int> _mutedCategoryIds;
  @override
  @JsonKey(name: 'muted_category_ids')
  List<int> get mutedCategoryIds {
    if (_mutedCategoryIds is EqualUnmodifiableListView)
      return _mutedCategoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mutedCategoryIds);
  }

  final List<int> _regularCategoryIds;
  @override
  @JsonKey(name: 'regular_category_ids')
  List<int> get regularCategoryIds {
    if (_regularCategoryIds is EqualUnmodifiableListView)
      return _regularCategoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_regularCategoryIds);
  }

  final List<String> _watchedTags;
  @override
  @JsonKey(name: 'watched_tags')
  List<String> get watchedTags {
    if (_watchedTags is EqualUnmodifiableListView) return _watchedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_watchedTags);
  }

  final List<String> _watchingFirstPostTags;
  @override
  @JsonKey(name: 'watching_first_post_tags')
  List<String> get watchingFirstPostTags {
    if (_watchingFirstPostTags is EqualUnmodifiableListView)
      return _watchingFirstPostTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_watchingFirstPostTags);
  }

  final List<String> _trackedTags;
  @override
  @JsonKey(name: 'tracked_tags')
  List<String> get trackedTags {
    if (_trackedTags is EqualUnmodifiableListView) return _trackedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackedTags);
  }

  final List<String> _mutedTags;
  @override
  @JsonKey(name: 'muted_tags')
  List<String> get mutedTags {
    if (_mutedTags is EqualUnmodifiableListView) return _mutedTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mutedTags);
  }

  final List<int> _trackedCategoryIds;
  @override
  @JsonKey(name: 'tracked_category_ids')
  List<int> get trackedCategoryIds {
    if (_trackedCategoryIds is EqualUnmodifiableListView)
      return _trackedCategoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackedCategoryIds);
  }

  final List<int> _watchedCategoryIds;
  @override
  @JsonKey(name: 'watched_category_ids')
  List<int> get watchedCategoryIds {
    if (_watchedCategoryIds is EqualUnmodifiableListView)
      return _watchedCategoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_watchedCategoryIds);
  }

  final List<int> _watchedFirstPostCategoryIds;
  @override
  @JsonKey(name: 'watched_first_post_category_ids')
  List<int> get watchedFirstPostCategoryIds {
    if (_watchedFirstPostCategoryIds is EqualUnmodifiableListView)
      return _watchedFirstPostCategoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_watchedFirstPostCategoryIds);
  }

  @override
  @JsonKey(name: 'system_avatar_template')
  final String? systemAvatarTemplate;
  final List<String> _mutedUsernames;
  @override
  @JsonKey(name: 'muted_usernames')
  List<String> get mutedUsernames {
    if (_mutedUsernames is EqualUnmodifiableListView) return _mutedUsernames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mutedUsernames);
  }

  final List<String> _ignoredUsernames;
  @override
  @JsonKey(name: 'ignored_usernames')
  List<String> get ignoredUsernames {
    if (_ignoredUsernames is EqualUnmodifiableListView)
      return _ignoredUsernames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ignoredUsernames);
  }

  final List<String> _allowedPmUsernames;
  @override
  @JsonKey(name: 'allowed_pm_usernames')
  List<String> get allowedPmUsernames {
    if (_allowedPmUsernames is EqualUnmodifiableListView)
      return _allowedPmUsernames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedPmUsernames);
  }

  @override
  @JsonKey(name: 'mailing_list_posts_per_day')
  final int? mailingListPostsPerDay;
  @override
  @JsonKey(name: 'can_change_bio')
  final bool canChangeBio;
  @override
  @JsonKey(name: 'can_change_location')
  final bool canChangeLocation;
  @override
  @JsonKey(name: 'can_change_website')
  final bool canChangeWebsite;
  @override
  @JsonKey(name: 'can_change_tracking_preferences')
  final bool canChangeTrackingPreferences;
  final List<dynamic> _userApiKeys;
  @override
  @JsonKey(name: 'user_api_keys')
  List<dynamic> get userApiKeys {
    if (_userApiKeys is EqualUnmodifiableListView) return _userApiKeys;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userApiKeys);
  }

  final Map<String, dynamic>? _userStatus;
  @override
  @JsonKey(name: 'user_status')
  Map<String, dynamic>? get userStatus {
    final value = _userStatus;
    if (value == null) return null;
    if (_userStatus is EqualUnmodifiableMapView) return _userStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<dynamic> _sidebarTags;
  @override
  @JsonKey(name: 'sidebar_tags')
  List<dynamic> get sidebarTags {
    if (_sidebarTags is EqualUnmodifiableListView) return _sidebarTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sidebarTags);
  }

  final List<int> _sidebarCategoryIds;
  @override
  @JsonKey(name: 'sidebar_category_ids')
  List<int> get sidebarCategoryIds {
    if (_sidebarCategoryIds is EqualUnmodifiableListView)
      return _sidebarCategoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sidebarCategoryIds);
  }

  @override
  @JsonKey(name: 'display_sidebar_tags')
  final bool displaySidebarTags;
  @override
  @JsonKey(name: 'sidebar_list_destination')
  final String? sidebarListDestination;

  @override
  String toString() {
    return 'DiscourseUser(id: $id, username: $username, name: $name, avatarTemplate: $avatarTemplate, email: $email, secondaryEmails: $secondaryEmails, unconfirmedEmails: $unconfirmedEmails, lastPostedAt: $lastPostedAt, lastSeenAt: $lastSeenAt, createdAt: $createdAt, ignored: $ignored, muted: $muted, canIgnoreUser: $canIgnoreUser, canMuteUser: $canMuteUser, canSendPrivateMessages: $canSendPrivateMessages, canSendPrivateMessageToUser: $canSendPrivateMessageToUser, trustLevel: $trustLevel, moderator: $moderator, admin: $admin, title: $title, badgeCount: $badgeCount, userAuthTokens: $userAuthTokens, userNotificationSchedule: $userNotificationSchedule, featuredTopic: $featuredTopic, timezone: $timezone, profileHidden: $profileHidden, canBeDeleted: $canBeDeleted, canDeleteAllPosts: $canDeleteAllPosts, locale: $locale, mutedCategoryIds: $mutedCategoryIds, regularCategoryIds: $regularCategoryIds, watchedTags: $watchedTags, watchingFirstPostTags: $watchingFirstPostTags, trackedTags: $trackedTags, mutedTags: $mutedTags, trackedCategoryIds: $trackedCategoryIds, watchedCategoryIds: $watchedCategoryIds, watchedFirstPostCategoryIds: $watchedFirstPostCategoryIds, systemAvatarTemplate: $systemAvatarTemplate, mutedUsernames: $mutedUsernames, ignoredUsernames: $ignoredUsernames, allowedPmUsernames: $allowedPmUsernames, mailingListPostsPerDay: $mailingListPostsPerDay, canChangeBio: $canChangeBio, canChangeLocation: $canChangeLocation, canChangeWebsite: $canChangeWebsite, canChangeTrackingPreferences: $canChangeTrackingPreferences, userApiKeys: $userApiKeys, userStatus: $userStatus, sidebarTags: $sidebarTags, sidebarCategoryIds: $sidebarCategoryIds, displaySidebarTags: $displaySidebarTags, sidebarListDestination: $sidebarListDestination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.email, email) || other.email == email) &&
            const DeepCollectionEquality().equals(
              other._secondaryEmails,
              _secondaryEmails,
            ) &&
            const DeepCollectionEquality().equals(
              other._unconfirmedEmails,
              _unconfirmedEmails,
            ) &&
            (identical(other.lastPostedAt, lastPostedAt) ||
                other.lastPostedAt == lastPostedAt) &&
            (identical(other.lastSeenAt, lastSeenAt) ||
                other.lastSeenAt == lastSeenAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.ignored, ignored) || other.ignored == ignored) &&
            (identical(other.muted, muted) || other.muted == muted) &&
            (identical(other.canIgnoreUser, canIgnoreUser) ||
                other.canIgnoreUser == canIgnoreUser) &&
            (identical(other.canMuteUser, canMuteUser) ||
                other.canMuteUser == canMuteUser) &&
            (identical(other.canSendPrivateMessages, canSendPrivateMessages) ||
                other.canSendPrivateMessages == canSendPrivateMessages) &&
            (identical(
                  other.canSendPrivateMessageToUser,
                  canSendPrivateMessageToUser,
                ) ||
                other.canSendPrivateMessageToUser ==
                    canSendPrivateMessageToUser) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.badgeCount, badgeCount) ||
                other.badgeCount == badgeCount) &&
            const DeepCollectionEquality().equals(
              other._userAuthTokens,
              _userAuthTokens,
            ) &&
            const DeepCollectionEquality().equals(
              other._userNotificationSchedule,
              _userNotificationSchedule,
            ) &&
            const DeepCollectionEquality().equals(
              other._featuredTopic,
              _featuredTopic,
            ) &&
            (identical(other.timezone, timezone) ||
                other.timezone == timezone) &&
            (identical(other.profileHidden, profileHidden) ||
                other.profileHidden == profileHidden) &&
            (identical(other.canBeDeleted, canBeDeleted) ||
                other.canBeDeleted == canBeDeleted) &&
            (identical(other.canDeleteAllPosts, canDeleteAllPosts) ||
                other.canDeleteAllPosts == canDeleteAllPosts) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            const DeepCollectionEquality().equals(
              other._mutedCategoryIds,
              _mutedCategoryIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._regularCategoryIds,
              _regularCategoryIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._watchedTags,
              _watchedTags,
            ) &&
            const DeepCollectionEquality().equals(
              other._watchingFirstPostTags,
              _watchingFirstPostTags,
            ) &&
            const DeepCollectionEquality().equals(
              other._trackedTags,
              _trackedTags,
            ) &&
            const DeepCollectionEquality().equals(
              other._mutedTags,
              _mutedTags,
            ) &&
            const DeepCollectionEquality().equals(
              other._trackedCategoryIds,
              _trackedCategoryIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._watchedCategoryIds,
              _watchedCategoryIds,
            ) &&
            const DeepCollectionEquality().equals(
              other._watchedFirstPostCategoryIds,
              _watchedFirstPostCategoryIds,
            ) &&
            (identical(other.systemAvatarTemplate, systemAvatarTemplate) ||
                other.systemAvatarTemplate == systemAvatarTemplate) &&
            const DeepCollectionEquality().equals(
              other._mutedUsernames,
              _mutedUsernames,
            ) &&
            const DeepCollectionEquality().equals(
              other._ignoredUsernames,
              _ignoredUsernames,
            ) &&
            const DeepCollectionEquality().equals(
              other._allowedPmUsernames,
              _allowedPmUsernames,
            ) &&
            (identical(other.mailingListPostsPerDay, mailingListPostsPerDay) ||
                other.mailingListPostsPerDay == mailingListPostsPerDay) &&
            (identical(other.canChangeBio, canChangeBio) ||
                other.canChangeBio == canChangeBio) &&
            (identical(other.canChangeLocation, canChangeLocation) ||
                other.canChangeLocation == canChangeLocation) &&
            (identical(other.canChangeWebsite, canChangeWebsite) ||
                other.canChangeWebsite == canChangeWebsite) &&
            (identical(
                  other.canChangeTrackingPreferences,
                  canChangeTrackingPreferences,
                ) ||
                other.canChangeTrackingPreferences ==
                    canChangeTrackingPreferences) &&
            const DeepCollectionEquality().equals(
              other._userApiKeys,
              _userApiKeys,
            ) &&
            const DeepCollectionEquality().equals(
              other._userStatus,
              _userStatus,
            ) &&
            const DeepCollectionEquality().equals(
              other._sidebarTags,
              _sidebarTags,
            ) &&
            const DeepCollectionEquality().equals(
              other._sidebarCategoryIds,
              _sidebarCategoryIds,
            ) &&
            (identical(other.displaySidebarTags, displaySidebarTags) ||
                other.displaySidebarTags == displaySidebarTags) &&
            (identical(other.sidebarListDestination, sidebarListDestination) ||
                other.sidebarListDestination == sidebarListDestination));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    username,
    name,
    avatarTemplate,
    email,
    const DeepCollectionEquality().hash(_secondaryEmails),
    const DeepCollectionEquality().hash(_unconfirmedEmails),
    lastPostedAt,
    lastSeenAt,
    createdAt,
    ignored,
    muted,
    canIgnoreUser,
    canMuteUser,
    canSendPrivateMessages,
    canSendPrivateMessageToUser,
    trustLevel,
    moderator,
    admin,
    title,
    badgeCount,
    const DeepCollectionEquality().hash(_userAuthTokens),
    const DeepCollectionEquality().hash(_userNotificationSchedule),
    const DeepCollectionEquality().hash(_featuredTopic),
    timezone,
    profileHidden,
    canBeDeleted,
    canDeleteAllPosts,
    locale,
    const DeepCollectionEquality().hash(_mutedCategoryIds),
    const DeepCollectionEquality().hash(_regularCategoryIds),
    const DeepCollectionEquality().hash(_watchedTags),
    const DeepCollectionEquality().hash(_watchingFirstPostTags),
    const DeepCollectionEquality().hash(_trackedTags),
    const DeepCollectionEquality().hash(_mutedTags),
    const DeepCollectionEquality().hash(_trackedCategoryIds),
    const DeepCollectionEquality().hash(_watchedCategoryIds),
    const DeepCollectionEquality().hash(_watchedFirstPostCategoryIds),
    systemAvatarTemplate,
    const DeepCollectionEquality().hash(_mutedUsernames),
    const DeepCollectionEquality().hash(_ignoredUsernames),
    const DeepCollectionEquality().hash(_allowedPmUsernames),
    mailingListPostsPerDay,
    canChangeBio,
    canChangeLocation,
    canChangeWebsite,
    canChangeTrackingPreferences,
    const DeepCollectionEquality().hash(_userApiKeys),
    const DeepCollectionEquality().hash(_userStatus),
    const DeepCollectionEquality().hash(_sidebarTags),
    const DeepCollectionEquality().hash(_sidebarCategoryIds),
    displaySidebarTags,
    sidebarListDestination,
  ]);

  /// Create a copy of DiscourseUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserImplCopyWith<_$DiscourseUserImpl> get copyWith =>
      __$$DiscourseUserImplCopyWithImpl<_$DiscourseUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserImplToJson(this);
  }
}

abstract class _DiscourseUser implements DiscourseUser {
  const factory _DiscourseUser({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'email') final String? email,
    @JsonKey(name: 'secondary_emails') final List<String> secondaryEmails,
    @JsonKey(name: 'unconfirmed_emails') final List<String> unconfirmedEmails,
    @JsonKey(name: 'last_posted_at') final String? lastPostedAt,
    @JsonKey(name: 'last_seen_at') final String? lastSeenAt,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'ignored') final bool ignored,
    @JsonKey(name: 'muted') final bool muted,
    @JsonKey(name: 'can_ignore_user') final bool canIgnoreUser,
    @JsonKey(name: 'can_mute_user') final bool canMuteUser,
    @JsonKey(name: 'can_send_private_messages')
    final bool canSendPrivateMessages,
    @JsonKey(name: 'can_send_private_message_to_user')
    final bool canSendPrivateMessageToUser,
    @JsonKey(name: 'trust_level') final int trustLevel,
    @JsonKey(name: 'moderator') final bool moderator,
    @JsonKey(name: 'admin') final bool admin,
    @JsonKey(name: 'title') final String? title,
    @JsonKey(name: 'badge_count') final int badgeCount,
    @JsonKey(name: 'user_auth_tokens') final List<dynamic> userAuthTokens,
    @JsonKey(name: 'user_notification_schedule')
    final Map<String, dynamic>? userNotificationSchedule,
    @JsonKey(name: 'featured_topic') final Map<String, dynamic>? featuredTopic,
    @JsonKey(name: 'timezone') final String? timezone,
    @JsonKey(name: 'profile_hidden') final bool profileHidden,
    @JsonKey(name: 'can_be_deleted') final bool canBeDeleted,
    @JsonKey(name: 'can_delete_all_posts') final bool canDeleteAllPosts,
    @JsonKey(name: 'locale') final String? locale,
    @JsonKey(name: 'muted_category_ids') final List<int> mutedCategoryIds,
    @JsonKey(name: 'regular_category_ids') final List<int> regularCategoryIds,
    @JsonKey(name: 'watched_tags') final List<String> watchedTags,
    @JsonKey(name: 'watching_first_post_tags')
    final List<String> watchingFirstPostTags,
    @JsonKey(name: 'tracked_tags') final List<String> trackedTags,
    @JsonKey(name: 'muted_tags') final List<String> mutedTags,
    @JsonKey(name: 'tracked_category_ids') final List<int> trackedCategoryIds,
    @JsonKey(name: 'watched_category_ids') final List<int> watchedCategoryIds,
    @JsonKey(name: 'watched_first_post_category_ids')
    final List<int> watchedFirstPostCategoryIds,
    @JsonKey(name: 'system_avatar_template') final String? systemAvatarTemplate,
    @JsonKey(name: 'muted_usernames') final List<String> mutedUsernames,
    @JsonKey(name: 'ignored_usernames') final List<String> ignoredUsernames,
    @JsonKey(name: 'allowed_pm_usernames')
    final List<String> allowedPmUsernames,
    @JsonKey(name: 'mailing_list_posts_per_day')
    final int? mailingListPostsPerDay,
    @JsonKey(name: 'can_change_bio') final bool canChangeBio,
    @JsonKey(name: 'can_change_location') final bool canChangeLocation,
    @JsonKey(name: 'can_change_website') final bool canChangeWebsite,
    @JsonKey(name: 'can_change_tracking_preferences')
    final bool canChangeTrackingPreferences,
    @JsonKey(name: 'user_api_keys') final List<dynamic> userApiKeys,
    @JsonKey(name: 'user_status') final Map<String, dynamic>? userStatus,
    @JsonKey(name: 'sidebar_tags') final List<dynamic> sidebarTags,
    @JsonKey(name: 'sidebar_category_ids') final List<int> sidebarCategoryIds,
    @JsonKey(name: 'display_sidebar_tags') final bool displaySidebarTags,
    @JsonKey(name: 'sidebar_list_destination')
    final String? sidebarListDestination,
  }) = _$DiscourseUserImpl;

  factory _DiscourseUser.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'secondary_emails')
  List<String> get secondaryEmails;
  @override
  @JsonKey(name: 'unconfirmed_emails')
  List<String> get unconfirmedEmails;
  @override
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt;
  @override
  @JsonKey(name: 'last_seen_at')
  String? get lastSeenAt;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'ignored')
  bool get ignored;
  @override
  @JsonKey(name: 'muted')
  bool get muted;
  @override
  @JsonKey(name: 'can_ignore_user')
  bool get canIgnoreUser;
  @override
  @JsonKey(name: 'can_mute_user')
  bool get canMuteUser;
  @override
  @JsonKey(name: 'can_send_private_messages')
  bool get canSendPrivateMessages;
  @override
  @JsonKey(name: 'can_send_private_message_to_user')
  bool get canSendPrivateMessageToUser;
  @override
  @JsonKey(name: 'trust_level')
  int get trustLevel;
  @override
  @JsonKey(name: 'moderator')
  bool get moderator;
  @override
  @JsonKey(name: 'admin')
  bool get admin;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'badge_count')
  int get badgeCount;
  @override
  @JsonKey(name: 'user_auth_tokens')
  List<dynamic> get userAuthTokens;
  @override
  @JsonKey(name: 'user_notification_schedule')
  Map<String, dynamic>? get userNotificationSchedule;
  @override
  @JsonKey(name: 'featured_topic')
  Map<String, dynamic>? get featuredTopic;
  @override
  @JsonKey(name: 'timezone')
  String? get timezone;
  @override
  @JsonKey(name: 'profile_hidden')
  bool get profileHidden;
  @override
  @JsonKey(name: 'can_be_deleted')
  bool get canBeDeleted;
  @override
  @JsonKey(name: 'can_delete_all_posts')
  bool get canDeleteAllPosts;
  @override
  @JsonKey(name: 'locale')
  String? get locale;
  @override
  @JsonKey(name: 'muted_category_ids')
  List<int> get mutedCategoryIds;
  @override
  @JsonKey(name: 'regular_category_ids')
  List<int> get regularCategoryIds;
  @override
  @JsonKey(name: 'watched_tags')
  List<String> get watchedTags;
  @override
  @JsonKey(name: 'watching_first_post_tags')
  List<String> get watchingFirstPostTags;
  @override
  @JsonKey(name: 'tracked_tags')
  List<String> get trackedTags;
  @override
  @JsonKey(name: 'muted_tags')
  List<String> get mutedTags;
  @override
  @JsonKey(name: 'tracked_category_ids')
  List<int> get trackedCategoryIds;
  @override
  @JsonKey(name: 'watched_category_ids')
  List<int> get watchedCategoryIds;
  @override
  @JsonKey(name: 'watched_first_post_category_ids')
  List<int> get watchedFirstPostCategoryIds;
  @override
  @JsonKey(name: 'system_avatar_template')
  String? get systemAvatarTemplate;
  @override
  @JsonKey(name: 'muted_usernames')
  List<String> get mutedUsernames;
  @override
  @JsonKey(name: 'ignored_usernames')
  List<String> get ignoredUsernames;
  @override
  @JsonKey(name: 'allowed_pm_usernames')
  List<String> get allowedPmUsernames;
  @override
  @JsonKey(name: 'mailing_list_posts_per_day')
  int? get mailingListPostsPerDay;
  @override
  @JsonKey(name: 'can_change_bio')
  bool get canChangeBio;
  @override
  @JsonKey(name: 'can_change_location')
  bool get canChangeLocation;
  @override
  @JsonKey(name: 'can_change_website')
  bool get canChangeWebsite;
  @override
  @JsonKey(name: 'can_change_tracking_preferences')
  bool get canChangeTrackingPreferences;
  @override
  @JsonKey(name: 'user_api_keys')
  List<dynamic> get userApiKeys;
  @override
  @JsonKey(name: 'user_status')
  Map<String, dynamic>? get userStatus;
  @override
  @JsonKey(name: 'sidebar_tags')
  List<dynamic> get sidebarTags;
  @override
  @JsonKey(name: 'sidebar_category_ids')
  List<int> get sidebarCategoryIds;
  @override
  @JsonKey(name: 'display_sidebar_tags')
  bool get displaySidebarTags;
  @override
  @JsonKey(name: 'sidebar_list_destination')
  String? get sidebarListDestination;

  /// Create a copy of DiscourseUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserImplCopyWith<_$DiscourseUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseUserResponse _$DiscourseUserResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseUserResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserResponse {
  @JsonKey(name: 'user_badges')
  List<dynamic> get userBadges => throw _privateConstructorUsedError;
  @JsonKey(name: 'badges')
  List<DiscourseBadge> get badges => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_types')
  List<DiscourseBadgeType> get badgeTypes => throw _privateConstructorUsedError;
  @JsonKey(name: 'users')
  List<DiscourseUserBasicInfo> get users => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  DiscourseUser? get user => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserResponseCopyWith<DiscourseUserResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserResponseCopyWith<$Res> {
  factory $DiscourseUserResponseCopyWith(
    DiscourseUserResponse value,
    $Res Function(DiscourseUserResponse) then,
  ) = _$DiscourseUserResponseCopyWithImpl<$Res, DiscourseUserResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_badges') List<dynamic> userBadges,
    @JsonKey(name: 'badges') List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') List<DiscourseUserBasicInfo> users,
    @JsonKey(name: 'user') DiscourseUser? user,
  });

  $DiscourseUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$DiscourseUserResponseCopyWithImpl<
  $Res,
  $Val extends DiscourseUserResponse
>
    implements $DiscourseUserResponseCopyWith<$Res> {
  _$DiscourseUserResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBadges = null,
    Object? badges = null,
    Object? badgeTypes = null,
    Object? users = null,
    Object? user = freezed,
  }) {
    return _then(
      _value.copyWith(
            userBadges: null == userBadges
                ? _value.userBadges
                : userBadges // ignore: cast_nullable_to_non_nullable
                      as List<dynamic>,
            badges: null == badges
                ? _value.badges
                : badges // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseBadge>,
            badgeTypes: null == badgeTypes
                ? _value.badgeTypes
                : badgeTypes // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseBadgeType>,
            users: null == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBasicInfo>,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as DiscourseUser?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $DiscourseUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseUserResponseImplCopyWith<$Res>
    implements $DiscourseUserResponseCopyWith<$Res> {
  factory _$$DiscourseUserResponseImplCopyWith(
    _$DiscourseUserResponseImpl value,
    $Res Function(_$DiscourseUserResponseImpl) then,
  ) = __$$DiscourseUserResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_badges') List<dynamic> userBadges,
    @JsonKey(name: 'badges') List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') List<DiscourseUserBasicInfo> users,
    @JsonKey(name: 'user') DiscourseUser? user,
  });

  @override
  $DiscourseUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$DiscourseUserResponseImplCopyWithImpl<$Res>
    extends
        _$DiscourseUserResponseCopyWithImpl<$Res, _$DiscourseUserResponseImpl>
    implements _$$DiscourseUserResponseImplCopyWith<$Res> {
  __$$DiscourseUserResponseImplCopyWithImpl(
    _$DiscourseUserResponseImpl _value,
    $Res Function(_$DiscourseUserResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userBadges = null,
    Object? badges = null,
    Object? badgeTypes = null,
    Object? users = null,
    Object? user = freezed,
  }) {
    return _then(
      _$DiscourseUserResponseImpl(
        userBadges: null == userBadges
            ? _value._userBadges
            : userBadges // ignore: cast_nullable_to_non_nullable
                  as List<dynamic>,
        badges: null == badges
            ? _value._badges
            : badges // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseBadge>,
        badgeTypes: null == badgeTypes
            ? _value._badgeTypes
            : badgeTypes // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseBadgeType>,
        users: null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBasicInfo>,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as DiscourseUser?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserResponseImpl implements _DiscourseUserResponse {
  const _$DiscourseUserResponseImpl({
    @JsonKey(name: 'user_badges') final List<dynamic> userBadges = const [],
    @JsonKey(name: 'badges') final List<DiscourseBadge> badges = const [],
    @JsonKey(name: 'badge_types')
    final List<DiscourseBadgeType> badgeTypes = const [],
    @JsonKey(name: 'users') final List<DiscourseUserBasicInfo> users = const [],
    @JsonKey(name: 'user') this.user,
  }) : _userBadges = userBadges,
       _badges = badges,
       _badgeTypes = badgeTypes,
       _users = users;

  factory _$DiscourseUserResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserResponseImplFromJson(json);

  final List<dynamic> _userBadges;
  @override
  @JsonKey(name: 'user_badges')
  List<dynamic> get userBadges {
    if (_userBadges is EqualUnmodifiableListView) return _userBadges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userBadges);
  }

  final List<DiscourseBadge> _badges;
  @override
  @JsonKey(name: 'badges')
  List<DiscourseBadge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  final List<DiscourseBadgeType> _badgeTypes;
  @override
  @JsonKey(name: 'badge_types')
  List<DiscourseBadgeType> get badgeTypes {
    if (_badgeTypes is EqualUnmodifiableListView) return _badgeTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badgeTypes);
  }

  final List<DiscourseUserBasicInfo> _users;
  @override
  @JsonKey(name: 'users')
  List<DiscourseUserBasicInfo> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  @JsonKey(name: 'user')
  final DiscourseUser? user;

  @override
  String toString() {
    return 'DiscourseUserResponse(userBadges: $userBadges, badges: $badges, badgeTypes: $badgeTypes, users: $users, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserResponseImpl &&
            const DeepCollectionEquality().equals(
              other._userBadges,
              _userBadges,
            ) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            const DeepCollectionEquality().equals(
              other._badgeTypes,
              _badgeTypes,
            ) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_userBadges),
    const DeepCollectionEquality().hash(_badges),
    const DeepCollectionEquality().hash(_badgeTypes),
    const DeepCollectionEquality().hash(_users),
    user,
  );

  /// Create a copy of DiscourseUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserResponseImplCopyWith<_$DiscourseUserResponseImpl>
  get copyWith =>
      __$$DiscourseUserResponseImplCopyWithImpl<_$DiscourseUserResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserResponseImplToJson(this);
  }
}

abstract class _DiscourseUserResponse implements DiscourseUserResponse {
  const factory _DiscourseUserResponse({
    @JsonKey(name: 'user_badges') final List<dynamic> userBadges,
    @JsonKey(name: 'badges') final List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') final List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') final List<DiscourseUserBasicInfo> users,
    @JsonKey(name: 'user') final DiscourseUser? user,
  }) = _$DiscourseUserResponseImpl;

  factory _DiscourseUserResponse.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserResponseImpl.fromJson;

  @override
  @JsonKey(name: 'user_badges')
  List<dynamic> get userBadges;
  @override
  @JsonKey(name: 'badges')
  List<DiscourseBadge> get badges;
  @override
  @JsonKey(name: 'badge_types')
  List<DiscourseBadgeType> get badgeTypes;
  @override
  @JsonKey(name: 'users')
  List<DiscourseUserBasicInfo> get users;
  @override
  @JsonKey(name: 'user')
  DiscourseUser? get user;

  /// Create a copy of DiscourseUserResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserResponseImplCopyWith<_$DiscourseUserResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseBadge _$DiscourseBadgeFromJson(Map<String, dynamic> json) {
  return _DiscourseBadge.fromJson(json);
}

/// @nodoc
mixin _$DiscourseBadge {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'grant_count')
  int get grantCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'allow_title')
  bool get allowTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'multiple_grant')
  bool get multipleGrant => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon')
  String? get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'listable')
  bool get listable => throw _privateConstructorUsedError;
  @JsonKey(name: 'enabled')
  bool get enabled => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_grouping_id')
  int? get badgeGroupingId => throw _privateConstructorUsedError;
  @JsonKey(name: 'system')
  bool get system => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'manually_grantable')
  bool get manuallyGrantable => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_type_id')
  int? get badgeTypeId => throw _privateConstructorUsedError;

  /// Serializes this DiscourseBadge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseBadgeCopyWith<DiscourseBadge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseBadgeCopyWith<$Res> {
  factory $DiscourseBadgeCopyWith(
    DiscourseBadge value,
    $Res Function(DiscourseBadge) then,
  ) = _$DiscourseBadgeCopyWithImpl<$Res, DiscourseBadge>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'grant_count') int grantCount,
    @JsonKey(name: 'allow_title') bool allowTitle,
    @JsonKey(name: 'multiple_grant') bool multipleGrant,
    @JsonKey(name: 'icon') String? icon,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'listable') bool listable,
    @JsonKey(name: 'enabled') bool enabled,
    @JsonKey(name: 'badge_grouping_id') int? badgeGroupingId,
    @JsonKey(name: 'system') bool system,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'manually_grantable') bool manuallyGrantable,
    @JsonKey(name: 'badge_type_id') int? badgeTypeId,
  });
}

/// @nodoc
class _$DiscourseBadgeCopyWithImpl<$Res, $Val extends DiscourseBadge>
    implements $DiscourseBadgeCopyWith<$Res> {
  _$DiscourseBadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? grantCount = null,
    Object? allowTitle = null,
    Object? multipleGrant = null,
    Object? icon = freezed,
    Object? imageUrl = freezed,
    Object? listable = null,
    Object? enabled = null,
    Object? badgeGroupingId = freezed,
    Object? system = null,
    Object? slug = null,
    Object? manuallyGrantable = null,
    Object? badgeTypeId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            grantCount: null == grantCount
                ? _value.grantCount
                : grantCount // ignore: cast_nullable_to_non_nullable
                      as int,
            allowTitle: null == allowTitle
                ? _value.allowTitle
                : allowTitle // ignore: cast_nullable_to_non_nullable
                      as bool,
            multipleGrant: null == multipleGrant
                ? _value.multipleGrant
                : multipleGrant // ignore: cast_nullable_to_non_nullable
                      as bool,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            listable: null == listable
                ? _value.listable
                : listable // ignore: cast_nullable_to_non_nullable
                      as bool,
            enabled: null == enabled
                ? _value.enabled
                : enabled // ignore: cast_nullable_to_non_nullable
                      as bool,
            badgeGroupingId: freezed == badgeGroupingId
                ? _value.badgeGroupingId
                : badgeGroupingId // ignore: cast_nullable_to_non_nullable
                      as int?,
            system: null == system
                ? _value.system
                : system // ignore: cast_nullable_to_non_nullable
                      as bool,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            manuallyGrantable: null == manuallyGrantable
                ? _value.manuallyGrantable
                : manuallyGrantable // ignore: cast_nullable_to_non_nullable
                      as bool,
            badgeTypeId: freezed == badgeTypeId
                ? _value.badgeTypeId
                : badgeTypeId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseBadgeImplCopyWith<$Res>
    implements $DiscourseBadgeCopyWith<$Res> {
  factory _$$DiscourseBadgeImplCopyWith(
    _$DiscourseBadgeImpl value,
    $Res Function(_$DiscourseBadgeImpl) then,
  ) = __$$DiscourseBadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'grant_count') int grantCount,
    @JsonKey(name: 'allow_title') bool allowTitle,
    @JsonKey(name: 'multiple_grant') bool multipleGrant,
    @JsonKey(name: 'icon') String? icon,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'listable') bool listable,
    @JsonKey(name: 'enabled') bool enabled,
    @JsonKey(name: 'badge_grouping_id') int? badgeGroupingId,
    @JsonKey(name: 'system') bool system,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'manually_grantable') bool manuallyGrantable,
    @JsonKey(name: 'badge_type_id') int? badgeTypeId,
  });
}

/// @nodoc
class __$$DiscourseBadgeImplCopyWithImpl<$Res>
    extends _$DiscourseBadgeCopyWithImpl<$Res, _$DiscourseBadgeImpl>
    implements _$$DiscourseBadgeImplCopyWith<$Res> {
  __$$DiscourseBadgeImplCopyWithImpl(
    _$DiscourseBadgeImpl _value,
    $Res Function(_$DiscourseBadgeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? grantCount = null,
    Object? allowTitle = null,
    Object? multipleGrant = null,
    Object? icon = freezed,
    Object? imageUrl = freezed,
    Object? listable = null,
    Object? enabled = null,
    Object? badgeGroupingId = freezed,
    Object? system = null,
    Object? slug = null,
    Object? manuallyGrantable = null,
    Object? badgeTypeId = freezed,
  }) {
    return _then(
      _$DiscourseBadgeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        grantCount: null == grantCount
            ? _value.grantCount
            : grantCount // ignore: cast_nullable_to_non_nullable
                  as int,
        allowTitle: null == allowTitle
            ? _value.allowTitle
            : allowTitle // ignore: cast_nullable_to_non_nullable
                  as bool,
        multipleGrant: null == multipleGrant
            ? _value.multipleGrant
            : multipleGrant // ignore: cast_nullable_to_non_nullable
                  as bool,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        listable: null == listable
            ? _value.listable
            : listable // ignore: cast_nullable_to_non_nullable
                  as bool,
        enabled: null == enabled
            ? _value.enabled
            : enabled // ignore: cast_nullable_to_non_nullable
                  as bool,
        badgeGroupingId: freezed == badgeGroupingId
            ? _value.badgeGroupingId
            : badgeGroupingId // ignore: cast_nullable_to_non_nullable
                  as int?,
        system: null == system
            ? _value.system
            : system // ignore: cast_nullable_to_non_nullable
                  as bool,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        manuallyGrantable: null == manuallyGrantable
            ? _value.manuallyGrantable
            : manuallyGrantable // ignore: cast_nullable_to_non_nullable
                  as bool,
        badgeTypeId: freezed == badgeTypeId
            ? _value.badgeTypeId
            : badgeTypeId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseBadgeImpl implements _DiscourseBadge {
  const _$DiscourseBadgeImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'description') this.description,
    @JsonKey(name: 'grant_count') this.grantCount = 0,
    @JsonKey(name: 'allow_title') this.allowTitle = false,
    @JsonKey(name: 'multiple_grant') this.multipleGrant = false,
    @JsonKey(name: 'icon') this.icon,
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'listable') this.listable = true,
    @JsonKey(name: 'enabled') this.enabled = true,
    @JsonKey(name: 'badge_grouping_id') this.badgeGroupingId,
    @JsonKey(name: 'system') this.system = false,
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'manually_grantable') this.manuallyGrantable = false,
    @JsonKey(name: 'badge_type_id') this.badgeTypeId,
  });

  factory _$DiscourseBadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseBadgeImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'grant_count')
  final int grantCount;
  @override
  @JsonKey(name: 'allow_title')
  final bool allowTitle;
  @override
  @JsonKey(name: 'multiple_grant')
  final bool multipleGrant;
  @override
  @JsonKey(name: 'icon')
  final String? icon;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'listable')
  final bool listable;
  @override
  @JsonKey(name: 'enabled')
  final bool enabled;
  @override
  @JsonKey(name: 'badge_grouping_id')
  final int? badgeGroupingId;
  @override
  @JsonKey(name: 'system')
  final bool system;
  @override
  @JsonKey(name: 'slug')
  final String slug;
  @override
  @JsonKey(name: 'manually_grantable')
  final bool manuallyGrantable;
  @override
  @JsonKey(name: 'badge_type_id')
  final int? badgeTypeId;

  @override
  String toString() {
    return 'DiscourseBadge(id: $id, name: $name, description: $description, grantCount: $grantCount, allowTitle: $allowTitle, multipleGrant: $multipleGrant, icon: $icon, imageUrl: $imageUrl, listable: $listable, enabled: $enabled, badgeGroupingId: $badgeGroupingId, system: $system, slug: $slug, manuallyGrantable: $manuallyGrantable, badgeTypeId: $badgeTypeId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseBadgeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.grantCount, grantCount) ||
                other.grantCount == grantCount) &&
            (identical(other.allowTitle, allowTitle) ||
                other.allowTitle == allowTitle) &&
            (identical(other.multipleGrant, multipleGrant) ||
                other.multipleGrant == multipleGrant) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.listable, listable) ||
                other.listable == listable) &&
            (identical(other.enabled, enabled) || other.enabled == enabled) &&
            (identical(other.badgeGroupingId, badgeGroupingId) ||
                other.badgeGroupingId == badgeGroupingId) &&
            (identical(other.system, system) || other.system == system) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.manuallyGrantable, manuallyGrantable) ||
                other.manuallyGrantable == manuallyGrantable) &&
            (identical(other.badgeTypeId, badgeTypeId) ||
                other.badgeTypeId == badgeTypeId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    grantCount,
    allowTitle,
    multipleGrant,
    icon,
    imageUrl,
    listable,
    enabled,
    badgeGroupingId,
    system,
    slug,
    manuallyGrantable,
    badgeTypeId,
  );

  /// Create a copy of DiscourseBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseBadgeImplCopyWith<_$DiscourseBadgeImpl> get copyWith =>
      __$$DiscourseBadgeImplCopyWithImpl<_$DiscourseBadgeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseBadgeImplToJson(this);
  }
}

abstract class _DiscourseBadge implements DiscourseBadge {
  const factory _DiscourseBadge({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'description') final String? description,
    @JsonKey(name: 'grant_count') final int grantCount,
    @JsonKey(name: 'allow_title') final bool allowTitle,
    @JsonKey(name: 'multiple_grant') final bool multipleGrant,
    @JsonKey(name: 'icon') final String? icon,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'listable') final bool listable,
    @JsonKey(name: 'enabled') final bool enabled,
    @JsonKey(name: 'badge_grouping_id') final int? badgeGroupingId,
    @JsonKey(name: 'system') final bool system,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'manually_grantable') final bool manuallyGrantable,
    @JsonKey(name: 'badge_type_id') final int? badgeTypeId,
  }) = _$DiscourseBadgeImpl;

  factory _DiscourseBadge.fromJson(Map<String, dynamic> json) =
      _$DiscourseBadgeImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'grant_count')
  int get grantCount;
  @override
  @JsonKey(name: 'allow_title')
  bool get allowTitle;
  @override
  @JsonKey(name: 'multiple_grant')
  bool get multipleGrant;
  @override
  @JsonKey(name: 'icon')
  String? get icon;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'listable')
  bool get listable;
  @override
  @JsonKey(name: 'enabled')
  bool get enabled;
  @override
  @JsonKey(name: 'badge_grouping_id')
  int? get badgeGroupingId;
  @override
  @JsonKey(name: 'system')
  bool get system;
  @override
  @JsonKey(name: 'slug')
  String get slug;
  @override
  @JsonKey(name: 'manually_grantable')
  bool get manuallyGrantable;
  @override
  @JsonKey(name: 'badge_type_id')
  int? get badgeTypeId;

  /// Create a copy of DiscourseBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseBadgeImplCopyWith<_$DiscourseBadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseBadgeType _$DiscourseBadgeTypeFromJson(Map<String, dynamic> json) {
  return _DiscourseBadgeType.fromJson(json);
}

/// @nodoc
mixin _$DiscourseBadgeType {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'sort_order')
  int get sortOrder => throw _privateConstructorUsedError;

  /// Serializes this DiscourseBadgeType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseBadgeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseBadgeTypeCopyWith<DiscourseBadgeType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseBadgeTypeCopyWith<$Res> {
  factory $DiscourseBadgeTypeCopyWith(
    DiscourseBadgeType value,
    $Res Function(DiscourseBadgeType) then,
  ) = _$DiscourseBadgeTypeCopyWithImpl<$Res, DiscourseBadgeType>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class _$DiscourseBadgeTypeCopyWithImpl<$Res, $Val extends DiscourseBadgeType>
    implements $DiscourseBadgeTypeCopyWith<$Res> {
  _$DiscourseBadgeTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseBadgeType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            sortOrder: null == sortOrder
                ? _value.sortOrder
                : sortOrder // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseBadgeTypeImplCopyWith<$Res>
    implements $DiscourseBadgeTypeCopyWith<$Res> {
  factory _$$DiscourseBadgeTypeImplCopyWith(
    _$DiscourseBadgeTypeImpl value,
    $Res Function(_$DiscourseBadgeTypeImpl) then,
  ) = __$$DiscourseBadgeTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'sort_order') int sortOrder,
  });
}

/// @nodoc
class __$$DiscourseBadgeTypeImplCopyWithImpl<$Res>
    extends _$DiscourseBadgeTypeCopyWithImpl<$Res, _$DiscourseBadgeTypeImpl>
    implements _$$DiscourseBadgeTypeImplCopyWith<$Res> {
  __$$DiscourseBadgeTypeImplCopyWithImpl(
    _$DiscourseBadgeTypeImpl _value,
    $Res Function(_$DiscourseBadgeTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseBadgeType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? sortOrder = null,
  }) {
    return _then(
      _$DiscourseBadgeTypeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        sortOrder: null == sortOrder
            ? _value.sortOrder
            : sortOrder // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseBadgeTypeImpl implements _DiscourseBadgeType {
  const _$DiscourseBadgeTypeImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'sort_order') this.sortOrder = 0,
  });

  factory _$DiscourseBadgeTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseBadgeTypeImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'sort_order')
  final int sortOrder;

  @override
  String toString() {
    return 'DiscourseBadgeType(id: $id, name: $name, sortOrder: $sortOrder)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseBadgeTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.sortOrder, sortOrder) ||
                other.sortOrder == sortOrder));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, sortOrder);

  /// Create a copy of DiscourseBadgeType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseBadgeTypeImplCopyWith<_$DiscourseBadgeTypeImpl> get copyWith =>
      __$$DiscourseBadgeTypeImplCopyWithImpl<_$DiscourseBadgeTypeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseBadgeTypeImplToJson(this);
  }
}

abstract class _DiscourseBadgeType implements DiscourseBadgeType {
  const factory _DiscourseBadgeType({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'sort_order') final int sortOrder,
  }) = _$DiscourseBadgeTypeImpl;

  factory _DiscourseBadgeType.fromJson(Map<String, dynamic> json) =
      _$DiscourseBadgeTypeImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'sort_order')
  int get sortOrder;

  /// Create a copy of DiscourseBadgeType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseBadgeTypeImplCopyWith<_$DiscourseBadgeTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseUserBasicInfo _$DiscourseUserBasicInfoFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseUserBasicInfo.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserBasicInfo {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin')
  bool get admin => throw _privateConstructorUsedError;
  @JsonKey(name: 'moderator')
  bool get moderator => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level')
  int get trustLevel => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserBasicInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserBasicInfoCopyWith<DiscourseUserBasicInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserBasicInfoCopyWith<$Res> {
  factory $DiscourseUserBasicInfoCopyWith(
    DiscourseUserBasicInfo value,
    $Res Function(DiscourseUserBasicInfo) then,
  ) = _$DiscourseUserBasicInfoCopyWithImpl<$Res, DiscourseUserBasicInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'trust_level') int trustLevel,
  });
}

/// @nodoc
class _$DiscourseUserBasicInfoCopyWithImpl<
  $Res,
  $Val extends DiscourseUserBasicInfo
>
    implements $DiscourseUserBasicInfoCopyWith<$Res> {
  _$DiscourseUserBasicInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? admin = null,
    Object? moderator = null,
    Object? trustLevel = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarTemplate: null == avatarTemplate
                ? _value.avatarTemplate
                : avatarTemplate // ignore: cast_nullable_to_non_nullable
                      as String,
            admin: null == admin
                ? _value.admin
                : admin // ignore: cast_nullable_to_non_nullable
                      as bool,
            moderator: null == moderator
                ? _value.moderator
                : moderator // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustLevel: null == trustLevel
                ? _value.trustLevel
                : trustLevel // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserBasicInfoImplCopyWith<$Res>
    implements $DiscourseUserBasicInfoCopyWith<$Res> {
  factory _$$DiscourseUserBasicInfoImplCopyWith(
    _$DiscourseUserBasicInfoImpl value,
    $Res Function(_$DiscourseUserBasicInfoImpl) then,
  ) = __$$DiscourseUserBasicInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'trust_level') int trustLevel,
  });
}

/// @nodoc
class __$$DiscourseUserBasicInfoImplCopyWithImpl<$Res>
    extends
        _$DiscourseUserBasicInfoCopyWithImpl<$Res, _$DiscourseUserBasicInfoImpl>
    implements _$$DiscourseUserBasicInfoImplCopyWith<$Res> {
  __$$DiscourseUserBasicInfoImplCopyWithImpl(
    _$DiscourseUserBasicInfoImpl _value,
    $Res Function(_$DiscourseUserBasicInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? admin = null,
    Object? moderator = null,
    Object? trustLevel = null,
  }) {
    return _then(
      _$DiscourseUserBasicInfoImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarTemplate: null == avatarTemplate
            ? _value.avatarTemplate
            : avatarTemplate // ignore: cast_nullable_to_non_nullable
                  as String,
        admin: null == admin
            ? _value.admin
            : admin // ignore: cast_nullable_to_non_nullable
                  as bool,
        moderator: null == moderator
            ? _value.moderator
            : moderator // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustLevel: null == trustLevel
            ? _value.trustLevel
            : trustLevel // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserBasicInfoImpl implements _DiscourseUserBasicInfo {
  const _$DiscourseUserBasicInfoImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'admin') this.admin = false,
    @JsonKey(name: 'moderator') this.moderator = false,
    @JsonKey(name: 'trust_level') this.trustLevel = 1,
  });

  factory _$DiscourseUserBasicInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserBasicInfoImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'avatar_template')
  final String avatarTemplate;
  @override
  @JsonKey(name: 'admin')
  final bool admin;
  @override
  @JsonKey(name: 'moderator')
  final bool moderator;
  @override
  @JsonKey(name: 'trust_level')
  final int trustLevel;

  @override
  String toString() {
    return 'DiscourseUserBasicInfo(id: $id, username: $username, name: $name, avatarTemplate: $avatarTemplate, admin: $admin, moderator: $moderator, trustLevel: $trustLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserBasicInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    name,
    avatarTemplate,
    admin,
    moderator,
    trustLevel,
  );

  /// Create a copy of DiscourseUserBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserBasicInfoImplCopyWith<_$DiscourseUserBasicInfoImpl>
  get copyWith =>
      __$$DiscourseUserBasicInfoImplCopyWithImpl<_$DiscourseUserBasicInfoImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserBasicInfoImplToJson(this);
  }
}

abstract class _DiscourseUserBasicInfo implements DiscourseUserBasicInfo {
  const factory _DiscourseUserBasicInfo({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'admin') final bool admin,
    @JsonKey(name: 'moderator') final bool moderator,
    @JsonKey(name: 'trust_level') final int trustLevel,
  }) = _$DiscourseUserBasicInfoImpl;

  factory _DiscourseUserBasicInfo.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserBasicInfoImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate;
  @override
  @JsonKey(name: 'admin')
  bool get admin;
  @override
  @JsonKey(name: 'moderator')
  bool get moderator;
  @override
  @JsonKey(name: 'trust_level')
  int get trustLevel;

  /// Create a copy of DiscourseUserBasicInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserBasicInfoImplCopyWith<_$DiscourseUserBasicInfoImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseUserSummaryResponse _$DiscourseUserSummaryResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseUserSummaryResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserSummaryResponse {
  @JsonKey(name: 'user_summary')
  DiscourseUserSummary? get userSummary => throw _privateConstructorUsedError;
  @JsonKey(name: 'badges')
  List<DiscourseBadge> get badges => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_types')
  List<DiscourseBadgeType> get badgeTypes => throw _privateConstructorUsedError;
  @JsonKey(name: 'users')
  List<DiscourseUserBasicInfo> get users => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserSummaryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserSummaryResponseCopyWith<DiscourseUserSummaryResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserSummaryResponseCopyWith<$Res> {
  factory $DiscourseUserSummaryResponseCopyWith(
    DiscourseUserSummaryResponse value,
    $Res Function(DiscourseUserSummaryResponse) then,
  ) =
      _$DiscourseUserSummaryResponseCopyWithImpl<
        $Res,
        DiscourseUserSummaryResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'user_summary') DiscourseUserSummary? userSummary,
    @JsonKey(name: 'badges') List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') List<DiscourseUserBasicInfo> users,
  });

  $DiscourseUserSummaryCopyWith<$Res>? get userSummary;
}

/// @nodoc
class _$DiscourseUserSummaryResponseCopyWithImpl<
  $Res,
  $Val extends DiscourseUserSummaryResponse
>
    implements $DiscourseUserSummaryResponseCopyWith<$Res> {
  _$DiscourseUserSummaryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userSummary = freezed,
    Object? badges = null,
    Object? badgeTypes = null,
    Object? users = null,
  }) {
    return _then(
      _value.copyWith(
            userSummary: freezed == userSummary
                ? _value.userSummary
                : userSummary // ignore: cast_nullable_to_non_nullable
                      as DiscourseUserSummary?,
            badges: null == badges
                ? _value.badges
                : badges // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseBadge>,
            badgeTypes: null == badgeTypes
                ? _value.badgeTypes
                : badgeTypes // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseBadgeType>,
            users: null == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBasicInfo>,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseUserSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseUserSummaryCopyWith<$Res>? get userSummary {
    if (_value.userSummary == null) {
      return null;
    }

    return $DiscourseUserSummaryCopyWith<$Res>(_value.userSummary!, (value) {
      return _then(_value.copyWith(userSummary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseUserSummaryResponseImplCopyWith<$Res>
    implements $DiscourseUserSummaryResponseCopyWith<$Res> {
  factory _$$DiscourseUserSummaryResponseImplCopyWith(
    _$DiscourseUserSummaryResponseImpl value,
    $Res Function(_$DiscourseUserSummaryResponseImpl) then,
  ) = __$$DiscourseUserSummaryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_summary') DiscourseUserSummary? userSummary,
    @JsonKey(name: 'badges') List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') List<DiscourseUserBasicInfo> users,
  });

  @override
  $DiscourseUserSummaryCopyWith<$Res>? get userSummary;
}

/// @nodoc
class __$$DiscourseUserSummaryResponseImplCopyWithImpl<$Res>
    extends
        _$DiscourseUserSummaryResponseCopyWithImpl<
          $Res,
          _$DiscourseUserSummaryResponseImpl
        >
    implements _$$DiscourseUserSummaryResponseImplCopyWith<$Res> {
  __$$DiscourseUserSummaryResponseImplCopyWithImpl(
    _$DiscourseUserSummaryResponseImpl _value,
    $Res Function(_$DiscourseUserSummaryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userSummary = freezed,
    Object? badges = null,
    Object? badgeTypes = null,
    Object? users = null,
  }) {
    return _then(
      _$DiscourseUserSummaryResponseImpl(
        userSummary: freezed == userSummary
            ? _value.userSummary
            : userSummary // ignore: cast_nullable_to_non_nullable
                  as DiscourseUserSummary?,
        badges: null == badges
            ? _value._badges
            : badges // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseBadge>,
        badgeTypes: null == badgeTypes
            ? _value._badgeTypes
            : badgeTypes // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseBadgeType>,
        users: null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBasicInfo>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserSummaryResponseImpl
    implements _DiscourseUserSummaryResponse {
  const _$DiscourseUserSummaryResponseImpl({
    @JsonKey(name: 'user_summary') this.userSummary,
    @JsonKey(name: 'badges') final List<DiscourseBadge> badges = const [],
    @JsonKey(name: 'badge_types')
    final List<DiscourseBadgeType> badgeTypes = const [],
    @JsonKey(name: 'users') final List<DiscourseUserBasicInfo> users = const [],
  }) : _badges = badges,
       _badgeTypes = badgeTypes,
       _users = users;

  factory _$DiscourseUserSummaryResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscourseUserSummaryResponseImplFromJson(json);

  @override
  @JsonKey(name: 'user_summary')
  final DiscourseUserSummary? userSummary;
  final List<DiscourseBadge> _badges;
  @override
  @JsonKey(name: 'badges')
  List<DiscourseBadge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  final List<DiscourseBadgeType> _badgeTypes;
  @override
  @JsonKey(name: 'badge_types')
  List<DiscourseBadgeType> get badgeTypes {
    if (_badgeTypes is EqualUnmodifiableListView) return _badgeTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badgeTypes);
  }

  final List<DiscourseUserBasicInfo> _users;
  @override
  @JsonKey(name: 'users')
  List<DiscourseUserBasicInfo> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'DiscourseUserSummaryResponse(userSummary: $userSummary, badges: $badges, badgeTypes: $badgeTypes, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserSummaryResponseImpl &&
            (identical(other.userSummary, userSummary) ||
                other.userSummary == userSummary) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            const DeepCollectionEquality().equals(
              other._badgeTypes,
              _badgeTypes,
            ) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userSummary,
    const DeepCollectionEquality().hash(_badges),
    const DeepCollectionEquality().hash(_badgeTypes),
    const DeepCollectionEquality().hash(_users),
  );

  /// Create a copy of DiscourseUserSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserSummaryResponseImplCopyWith<
    _$DiscourseUserSummaryResponseImpl
  >
  get copyWith =>
      __$$DiscourseUserSummaryResponseImplCopyWithImpl<
        _$DiscourseUserSummaryResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserSummaryResponseImplToJson(this);
  }
}

abstract class _DiscourseUserSummaryResponse
    implements DiscourseUserSummaryResponse {
  const factory _DiscourseUserSummaryResponse({
    @JsonKey(name: 'user_summary') final DiscourseUserSummary? userSummary,
    @JsonKey(name: 'badges') final List<DiscourseBadge> badges,
    @JsonKey(name: 'badge_types') final List<DiscourseBadgeType> badgeTypes,
    @JsonKey(name: 'users') final List<DiscourseUserBasicInfo> users,
  }) = _$DiscourseUserSummaryResponseImpl;

  factory _DiscourseUserSummaryResponse.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserSummaryResponseImpl.fromJson;

  @override
  @JsonKey(name: 'user_summary')
  DiscourseUserSummary? get userSummary;
  @override
  @JsonKey(name: 'badges')
  List<DiscourseBadge> get badges;
  @override
  @JsonKey(name: 'badge_types')
  List<DiscourseBadgeType> get badgeTypes;
  @override
  @JsonKey(name: 'users')
  List<DiscourseUserBasicInfo> get users;

  /// Create a copy of DiscourseUserSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserSummaryResponseImplCopyWith<
    _$DiscourseUserSummaryResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseUserSummary _$DiscourseUserSummaryFromJson(Map<String, dynamic> json) {
  return _DiscourseUserSummary.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserSummary {
  @JsonKey(name: 'likes_given')
  int get likesGiven => throw _privateConstructorUsedError;
  @JsonKey(name: 'likes_received')
  int get likesReceived => throw _privateConstructorUsedError;
  @JsonKey(name: 'topics_entered')
  int get topicsEntered => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_count')
  int get topicCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_count')
  int get postCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'posts_read_count')
  int get postsReadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'days_visited')
  int get daysVisited => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_read')
  int get timeRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'recent_time_read')
  int get recentTimeRead => throw _privateConstructorUsedError;
  @JsonKey(name: 'solved_count')
  int get solvedCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_ids')
  List<int> get topicIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'replies')
  List<DiscourseUserSummaryItem> get replies =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'links')
  List<DiscourseUserSummaryItem> get links =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'most_replied_to_users')
  List<DiscourseUserSummaryUser> get mostRepliedToUsers =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'most_liked_by_users')
  List<DiscourseUserSummaryUser> get mostLikedByUsers =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'most_liked_users')
  List<DiscourseUserSummaryUser> get mostLikedUsers =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'badges')
  List<DiscourseUserBadge> get badges => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_categories')
  List<DiscourseUserCategory> get topCategories =>
      throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserSummary to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserSummaryCopyWith<DiscourseUserSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserSummaryCopyWith<$Res> {
  factory $DiscourseUserSummaryCopyWith(
    DiscourseUserSummary value,
    $Res Function(DiscourseUserSummary) then,
  ) = _$DiscourseUserSummaryCopyWithImpl<$Res, DiscourseUserSummary>;
  @useResult
  $Res call({
    @JsonKey(name: 'likes_given') int likesGiven,
    @JsonKey(name: 'likes_received') int likesReceived,
    @JsonKey(name: 'topics_entered') int topicsEntered,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'posts_read_count') int postsReadCount,
    @JsonKey(name: 'days_visited') int daysVisited,
    @JsonKey(name: 'time_read') int timeRead,
    @JsonKey(name: 'recent_time_read') int recentTimeRead,
    @JsonKey(name: 'solved_count') int solvedCount,
    @JsonKey(name: 'topic_ids') List<int> topicIds,
    @JsonKey(name: 'replies') List<DiscourseUserSummaryItem> replies,
    @JsonKey(name: 'links') List<DiscourseUserSummaryItem> links,
    @JsonKey(name: 'most_replied_to_users')
    List<DiscourseUserSummaryUser> mostRepliedToUsers,
    @JsonKey(name: 'most_liked_by_users')
    List<DiscourseUserSummaryUser> mostLikedByUsers,
    @JsonKey(name: 'most_liked_users')
    List<DiscourseUserSummaryUser> mostLikedUsers,
    @JsonKey(name: 'badges') List<DiscourseUserBadge> badges,
    @JsonKey(name: 'top_categories') List<DiscourseUserCategory> topCategories,
  });
}

/// @nodoc
class _$DiscourseUserSummaryCopyWithImpl<
  $Res,
  $Val extends DiscourseUserSummary
>
    implements $DiscourseUserSummaryCopyWith<$Res> {
  _$DiscourseUserSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likesGiven = null,
    Object? likesReceived = null,
    Object? topicsEntered = null,
    Object? topicCount = null,
    Object? postCount = null,
    Object? postsReadCount = null,
    Object? daysVisited = null,
    Object? timeRead = null,
    Object? recentTimeRead = null,
    Object? solvedCount = null,
    Object? topicIds = null,
    Object? replies = null,
    Object? links = null,
    Object? mostRepliedToUsers = null,
    Object? mostLikedByUsers = null,
    Object? mostLikedUsers = null,
    Object? badges = null,
    Object? topCategories = null,
  }) {
    return _then(
      _value.copyWith(
            likesGiven: null == likesGiven
                ? _value.likesGiven
                : likesGiven // ignore: cast_nullable_to_non_nullable
                      as int,
            likesReceived: null == likesReceived
                ? _value.likesReceived
                : likesReceived // ignore: cast_nullable_to_non_nullable
                      as int,
            topicsEntered: null == topicsEntered
                ? _value.topicsEntered
                : topicsEntered // ignore: cast_nullable_to_non_nullable
                      as int,
            topicCount: null == topicCount
                ? _value.topicCount
                : topicCount // ignore: cast_nullable_to_non_nullable
                      as int,
            postCount: null == postCount
                ? _value.postCount
                : postCount // ignore: cast_nullable_to_non_nullable
                      as int,
            postsReadCount: null == postsReadCount
                ? _value.postsReadCount
                : postsReadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            daysVisited: null == daysVisited
                ? _value.daysVisited
                : daysVisited // ignore: cast_nullable_to_non_nullable
                      as int,
            timeRead: null == timeRead
                ? _value.timeRead
                : timeRead // ignore: cast_nullable_to_non_nullable
                      as int,
            recentTimeRead: null == recentTimeRead
                ? _value.recentTimeRead
                : recentTimeRead // ignore: cast_nullable_to_non_nullable
                      as int,
            solvedCount: null == solvedCount
                ? _value.solvedCount
                : solvedCount // ignore: cast_nullable_to_non_nullable
                      as int,
            topicIds: null == topicIds
                ? _value.topicIds
                : topicIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            replies: null == replies
                ? _value.replies
                : replies // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserSummaryItem>,
            links: null == links
                ? _value.links
                : links // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserSummaryItem>,
            mostRepliedToUsers: null == mostRepliedToUsers
                ? _value.mostRepliedToUsers
                : mostRepliedToUsers // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserSummaryUser>,
            mostLikedByUsers: null == mostLikedByUsers
                ? _value.mostLikedByUsers
                : mostLikedByUsers // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserSummaryUser>,
            mostLikedUsers: null == mostLikedUsers
                ? _value.mostLikedUsers
                : mostLikedUsers // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserSummaryUser>,
            badges: null == badges
                ? _value.badges
                : badges // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBadge>,
            topCategories: null == topCategories
                ? _value.topCategories
                : topCategories // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserCategory>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserSummaryImplCopyWith<$Res>
    implements $DiscourseUserSummaryCopyWith<$Res> {
  factory _$$DiscourseUserSummaryImplCopyWith(
    _$DiscourseUserSummaryImpl value,
    $Res Function(_$DiscourseUserSummaryImpl) then,
  ) = __$$DiscourseUserSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'likes_given') int likesGiven,
    @JsonKey(name: 'likes_received') int likesReceived,
    @JsonKey(name: 'topics_entered') int topicsEntered,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'posts_read_count') int postsReadCount,
    @JsonKey(name: 'days_visited') int daysVisited,
    @JsonKey(name: 'time_read') int timeRead,
    @JsonKey(name: 'recent_time_read') int recentTimeRead,
    @JsonKey(name: 'solved_count') int solvedCount,
    @JsonKey(name: 'topic_ids') List<int> topicIds,
    @JsonKey(name: 'replies') List<DiscourseUserSummaryItem> replies,
    @JsonKey(name: 'links') List<DiscourseUserSummaryItem> links,
    @JsonKey(name: 'most_replied_to_users')
    List<DiscourseUserSummaryUser> mostRepliedToUsers,
    @JsonKey(name: 'most_liked_by_users')
    List<DiscourseUserSummaryUser> mostLikedByUsers,
    @JsonKey(name: 'most_liked_users')
    List<DiscourseUserSummaryUser> mostLikedUsers,
    @JsonKey(name: 'badges') List<DiscourseUserBadge> badges,
    @JsonKey(name: 'top_categories') List<DiscourseUserCategory> topCategories,
  });
}

/// @nodoc
class __$$DiscourseUserSummaryImplCopyWithImpl<$Res>
    extends _$DiscourseUserSummaryCopyWithImpl<$Res, _$DiscourseUserSummaryImpl>
    implements _$$DiscourseUserSummaryImplCopyWith<$Res> {
  __$$DiscourseUserSummaryImplCopyWithImpl(
    _$DiscourseUserSummaryImpl _value,
    $Res Function(_$DiscourseUserSummaryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? likesGiven = null,
    Object? likesReceived = null,
    Object? topicsEntered = null,
    Object? topicCount = null,
    Object? postCount = null,
    Object? postsReadCount = null,
    Object? daysVisited = null,
    Object? timeRead = null,
    Object? recentTimeRead = null,
    Object? solvedCount = null,
    Object? topicIds = null,
    Object? replies = null,
    Object? links = null,
    Object? mostRepliedToUsers = null,
    Object? mostLikedByUsers = null,
    Object? mostLikedUsers = null,
    Object? badges = null,
    Object? topCategories = null,
  }) {
    return _then(
      _$DiscourseUserSummaryImpl(
        likesGiven: null == likesGiven
            ? _value.likesGiven
            : likesGiven // ignore: cast_nullable_to_non_nullable
                  as int,
        likesReceived: null == likesReceived
            ? _value.likesReceived
            : likesReceived // ignore: cast_nullable_to_non_nullable
                  as int,
        topicsEntered: null == topicsEntered
            ? _value.topicsEntered
            : topicsEntered // ignore: cast_nullable_to_non_nullable
                  as int,
        topicCount: null == topicCount
            ? _value.topicCount
            : topicCount // ignore: cast_nullable_to_non_nullable
                  as int,
        postCount: null == postCount
            ? _value.postCount
            : postCount // ignore: cast_nullable_to_non_nullable
                  as int,
        postsReadCount: null == postsReadCount
            ? _value.postsReadCount
            : postsReadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        daysVisited: null == daysVisited
            ? _value.daysVisited
            : daysVisited // ignore: cast_nullable_to_non_nullable
                  as int,
        timeRead: null == timeRead
            ? _value.timeRead
            : timeRead // ignore: cast_nullable_to_non_nullable
                  as int,
        recentTimeRead: null == recentTimeRead
            ? _value.recentTimeRead
            : recentTimeRead // ignore: cast_nullable_to_non_nullable
                  as int,
        solvedCount: null == solvedCount
            ? _value.solvedCount
            : solvedCount // ignore: cast_nullable_to_non_nullable
                  as int,
        topicIds: null == topicIds
            ? _value._topicIds
            : topicIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        replies: null == replies
            ? _value._replies
            : replies // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserSummaryItem>,
        links: null == links
            ? _value._links
            : links // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserSummaryItem>,
        mostRepliedToUsers: null == mostRepliedToUsers
            ? _value._mostRepliedToUsers
            : mostRepliedToUsers // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserSummaryUser>,
        mostLikedByUsers: null == mostLikedByUsers
            ? _value._mostLikedByUsers
            : mostLikedByUsers // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserSummaryUser>,
        mostLikedUsers: null == mostLikedUsers
            ? _value._mostLikedUsers
            : mostLikedUsers // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserSummaryUser>,
        badges: null == badges
            ? _value._badges
            : badges // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBadge>,
        topCategories: null == topCategories
            ? _value._topCategories
            : topCategories // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserCategory>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserSummaryImpl implements _DiscourseUserSummary {
  const _$DiscourseUserSummaryImpl({
    @JsonKey(name: 'likes_given') this.likesGiven = 0,
    @JsonKey(name: 'likes_received') this.likesReceived = 0,
    @JsonKey(name: 'topics_entered') this.topicsEntered = 0,
    @JsonKey(name: 'topic_count') this.topicCount = 0,
    @JsonKey(name: 'post_count') this.postCount = 0,
    @JsonKey(name: 'posts_read_count') this.postsReadCount = 0,
    @JsonKey(name: 'days_visited') this.daysVisited = 0,
    @JsonKey(name: 'time_read') this.timeRead = 0,
    @JsonKey(name: 'recent_time_read') this.recentTimeRead = 0,
    @JsonKey(name: 'solved_count') this.solvedCount = 0,
    @JsonKey(name: 'topic_ids') final List<int> topicIds = const [],
    @JsonKey(name: 'replies')
    final List<DiscourseUserSummaryItem> replies = const [],
    @JsonKey(name: 'links')
    final List<DiscourseUserSummaryItem> links = const [],
    @JsonKey(name: 'most_replied_to_users')
    final List<DiscourseUserSummaryUser> mostRepliedToUsers = const [],
    @JsonKey(name: 'most_liked_by_users')
    final List<DiscourseUserSummaryUser> mostLikedByUsers = const [],
    @JsonKey(name: 'most_liked_users')
    final List<DiscourseUserSummaryUser> mostLikedUsers = const [],
    @JsonKey(name: 'badges') final List<DiscourseUserBadge> badges = const [],
    @JsonKey(name: 'top_categories')
    final List<DiscourseUserCategory> topCategories = const [],
  }) : _topicIds = topicIds,
       _replies = replies,
       _links = links,
       _mostRepliedToUsers = mostRepliedToUsers,
       _mostLikedByUsers = mostLikedByUsers,
       _mostLikedUsers = mostLikedUsers,
       _badges = badges,
       _topCategories = topCategories;

  factory _$DiscourseUserSummaryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserSummaryImplFromJson(json);

  @override
  @JsonKey(name: 'likes_given')
  final int likesGiven;
  @override
  @JsonKey(name: 'likes_received')
  final int likesReceived;
  @override
  @JsonKey(name: 'topics_entered')
  final int topicsEntered;
  @override
  @JsonKey(name: 'topic_count')
  final int topicCount;
  @override
  @JsonKey(name: 'post_count')
  final int postCount;
  @override
  @JsonKey(name: 'posts_read_count')
  final int postsReadCount;
  @override
  @JsonKey(name: 'days_visited')
  final int daysVisited;
  @override
  @JsonKey(name: 'time_read')
  final int timeRead;
  @override
  @JsonKey(name: 'recent_time_read')
  final int recentTimeRead;
  @override
  @JsonKey(name: 'solved_count')
  final int solvedCount;
  final List<int> _topicIds;
  @override
  @JsonKey(name: 'topic_ids')
  List<int> get topicIds {
    if (_topicIds is EqualUnmodifiableListView) return _topicIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topicIds);
  }

  final List<DiscourseUserSummaryItem> _replies;
  @override
  @JsonKey(name: 'replies')
  List<DiscourseUserSummaryItem> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  final List<DiscourseUserSummaryItem> _links;
  @override
  @JsonKey(name: 'links')
  List<DiscourseUserSummaryItem> get links {
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_links);
  }

  final List<DiscourseUserSummaryUser> _mostRepliedToUsers;
  @override
  @JsonKey(name: 'most_replied_to_users')
  List<DiscourseUserSummaryUser> get mostRepliedToUsers {
    if (_mostRepliedToUsers is EqualUnmodifiableListView)
      return _mostRepliedToUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostRepliedToUsers);
  }

  final List<DiscourseUserSummaryUser> _mostLikedByUsers;
  @override
  @JsonKey(name: 'most_liked_by_users')
  List<DiscourseUserSummaryUser> get mostLikedByUsers {
    if (_mostLikedByUsers is EqualUnmodifiableListView)
      return _mostLikedByUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostLikedByUsers);
  }

  final List<DiscourseUserSummaryUser> _mostLikedUsers;
  @override
  @JsonKey(name: 'most_liked_users')
  List<DiscourseUserSummaryUser> get mostLikedUsers {
    if (_mostLikedUsers is EqualUnmodifiableListView) return _mostLikedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mostLikedUsers);
  }

  final List<DiscourseUserBadge> _badges;
  @override
  @JsonKey(name: 'badges')
  List<DiscourseUserBadge> get badges {
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_badges);
  }

  final List<DiscourseUserCategory> _topCategories;
  @override
  @JsonKey(name: 'top_categories')
  List<DiscourseUserCategory> get topCategories {
    if (_topCategories is EqualUnmodifiableListView) return _topCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topCategories);
  }

  @override
  String toString() {
    return 'DiscourseUserSummary(likesGiven: $likesGiven, likesReceived: $likesReceived, topicsEntered: $topicsEntered, topicCount: $topicCount, postCount: $postCount, postsReadCount: $postsReadCount, daysVisited: $daysVisited, timeRead: $timeRead, recentTimeRead: $recentTimeRead, solvedCount: $solvedCount, topicIds: $topicIds, replies: $replies, links: $links, mostRepliedToUsers: $mostRepliedToUsers, mostLikedByUsers: $mostLikedByUsers, mostLikedUsers: $mostLikedUsers, badges: $badges, topCategories: $topCategories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserSummaryImpl &&
            (identical(other.likesGiven, likesGiven) ||
                other.likesGiven == likesGiven) &&
            (identical(other.likesReceived, likesReceived) ||
                other.likesReceived == likesReceived) &&
            (identical(other.topicsEntered, topicsEntered) ||
                other.topicsEntered == topicsEntered) &&
            (identical(other.topicCount, topicCount) ||
                other.topicCount == topicCount) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.postsReadCount, postsReadCount) ||
                other.postsReadCount == postsReadCount) &&
            (identical(other.daysVisited, daysVisited) ||
                other.daysVisited == daysVisited) &&
            (identical(other.timeRead, timeRead) ||
                other.timeRead == timeRead) &&
            (identical(other.recentTimeRead, recentTimeRead) ||
                other.recentTimeRead == recentTimeRead) &&
            (identical(other.solvedCount, solvedCount) ||
                other.solvedCount == solvedCount) &&
            const DeepCollectionEquality().equals(other._topicIds, _topicIds) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            const DeepCollectionEquality().equals(
              other._mostRepliedToUsers,
              _mostRepliedToUsers,
            ) &&
            const DeepCollectionEquality().equals(
              other._mostLikedByUsers,
              _mostLikedByUsers,
            ) &&
            const DeepCollectionEquality().equals(
              other._mostLikedUsers,
              _mostLikedUsers,
            ) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            const DeepCollectionEquality().equals(
              other._topCategories,
              _topCategories,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    likesGiven,
    likesReceived,
    topicsEntered,
    topicCount,
    postCount,
    postsReadCount,
    daysVisited,
    timeRead,
    recentTimeRead,
    solvedCount,
    const DeepCollectionEquality().hash(_topicIds),
    const DeepCollectionEquality().hash(_replies),
    const DeepCollectionEquality().hash(_links),
    const DeepCollectionEquality().hash(_mostRepliedToUsers),
    const DeepCollectionEquality().hash(_mostLikedByUsers),
    const DeepCollectionEquality().hash(_mostLikedUsers),
    const DeepCollectionEquality().hash(_badges),
    const DeepCollectionEquality().hash(_topCategories),
  );

  /// Create a copy of DiscourseUserSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserSummaryImplCopyWith<_$DiscourseUserSummaryImpl>
  get copyWith =>
      __$$DiscourseUserSummaryImplCopyWithImpl<_$DiscourseUserSummaryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserSummaryImplToJson(this);
  }
}

abstract class _DiscourseUserSummary implements DiscourseUserSummary {
  const factory _DiscourseUserSummary({
    @JsonKey(name: 'likes_given') final int likesGiven,
    @JsonKey(name: 'likes_received') final int likesReceived,
    @JsonKey(name: 'topics_entered') final int topicsEntered,
    @JsonKey(name: 'topic_count') final int topicCount,
    @JsonKey(name: 'post_count') final int postCount,
    @JsonKey(name: 'posts_read_count') final int postsReadCount,
    @JsonKey(name: 'days_visited') final int daysVisited,
    @JsonKey(name: 'time_read') final int timeRead,
    @JsonKey(name: 'recent_time_read') final int recentTimeRead,
    @JsonKey(name: 'solved_count') final int solvedCount,
    @JsonKey(name: 'topic_ids') final List<int> topicIds,
    @JsonKey(name: 'replies') final List<DiscourseUserSummaryItem> replies,
    @JsonKey(name: 'links') final List<DiscourseUserSummaryItem> links,
    @JsonKey(name: 'most_replied_to_users')
    final List<DiscourseUserSummaryUser> mostRepliedToUsers,
    @JsonKey(name: 'most_liked_by_users')
    final List<DiscourseUserSummaryUser> mostLikedByUsers,
    @JsonKey(name: 'most_liked_users')
    final List<DiscourseUserSummaryUser> mostLikedUsers,
    @JsonKey(name: 'badges') final List<DiscourseUserBadge> badges,
    @JsonKey(name: 'top_categories')
    final List<DiscourseUserCategory> topCategories,
  }) = _$DiscourseUserSummaryImpl;

  factory _DiscourseUserSummary.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserSummaryImpl.fromJson;

  @override
  @JsonKey(name: 'likes_given')
  int get likesGiven;
  @override
  @JsonKey(name: 'likes_received')
  int get likesReceived;
  @override
  @JsonKey(name: 'topics_entered')
  int get topicsEntered;
  @override
  @JsonKey(name: 'topic_count')
  int get topicCount;
  @override
  @JsonKey(name: 'post_count')
  int get postCount;
  @override
  @JsonKey(name: 'posts_read_count')
  int get postsReadCount;
  @override
  @JsonKey(name: 'days_visited')
  int get daysVisited;
  @override
  @JsonKey(name: 'time_read')
  int get timeRead;
  @override
  @JsonKey(name: 'recent_time_read')
  int get recentTimeRead;
  @override
  @JsonKey(name: 'solved_count')
  int get solvedCount;
  @override
  @JsonKey(name: 'topic_ids')
  List<int> get topicIds;
  @override
  @JsonKey(name: 'replies')
  List<DiscourseUserSummaryItem> get replies;
  @override
  @JsonKey(name: 'links')
  List<DiscourseUserSummaryItem> get links;
  @override
  @JsonKey(name: 'most_replied_to_users')
  List<DiscourseUserSummaryUser> get mostRepliedToUsers;
  @override
  @JsonKey(name: 'most_liked_by_users')
  List<DiscourseUserSummaryUser> get mostLikedByUsers;
  @override
  @JsonKey(name: 'most_liked_users')
  List<DiscourseUserSummaryUser> get mostLikedUsers;
  @override
  @JsonKey(name: 'badges')
  List<DiscourseUserBadge> get badges;
  @override
  @JsonKey(name: 'top_categories')
  List<DiscourseUserCategory> get topCategories;

  /// Create a copy of DiscourseUserSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserSummaryImplCopyWith<_$DiscourseUserSummaryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseUserSummaryItem _$DiscourseUserSummaryItemFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseUserSummaryItem.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserSummaryItem {
  @JsonKey(name: 'post_id')
  int? get postId => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_id')
  int? get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_title')
  String? get topicTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_slug')
  String? get topicSlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserSummaryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserSummaryItemCopyWith<DiscourseUserSummaryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserSummaryItemCopyWith<$Res> {
  factory $DiscourseUserSummaryItemCopyWith(
    DiscourseUserSummaryItem value,
    $Res Function(DiscourseUserSummaryItem) then,
  ) = _$DiscourseUserSummaryItemCopyWithImpl<$Res, DiscourseUserSummaryItem>;
  @useResult
  $Res call({
    @JsonKey(name: 'post_id') int? postId,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'title') String? title,
  });
}

/// @nodoc
class _$DiscourseUserSummaryItemCopyWithImpl<
  $Res,
  $Val extends DiscourseUserSummaryItem
>
    implements $DiscourseUserSummaryItemCopyWith<$Res> {
  _$DiscourseUserSummaryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? topicId = freezed,
    Object? topicTitle = freezed,
    Object? topicSlug = freezed,
    Object? createdAt = freezed,
    Object? url = freezed,
    Object? title = freezed,
  }) {
    return _then(
      _value.copyWith(
            postId: freezed == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as int?,
            topicId: freezed == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int?,
            topicTitle: freezed == topicTitle
                ? _value.topicTitle
                : topicTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            topicSlug: freezed == topicSlug
                ? _value.topicSlug
                : topicSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserSummaryItemImplCopyWith<$Res>
    implements $DiscourseUserSummaryItemCopyWith<$Res> {
  factory _$$DiscourseUserSummaryItemImplCopyWith(
    _$DiscourseUserSummaryItemImpl value,
    $Res Function(_$DiscourseUserSummaryItemImpl) then,
  ) = __$$DiscourseUserSummaryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'post_id') int? postId,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'title') String? title,
  });
}

/// @nodoc
class __$$DiscourseUserSummaryItemImplCopyWithImpl<$Res>
    extends
        _$DiscourseUserSummaryItemCopyWithImpl<
          $Res,
          _$DiscourseUserSummaryItemImpl
        >
    implements _$$DiscourseUserSummaryItemImplCopyWith<$Res> {
  __$$DiscourseUserSummaryItemImplCopyWithImpl(
    _$DiscourseUserSummaryItemImpl _value,
    $Res Function(_$DiscourseUserSummaryItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postId = freezed,
    Object? topicId = freezed,
    Object? topicTitle = freezed,
    Object? topicSlug = freezed,
    Object? createdAt = freezed,
    Object? url = freezed,
    Object? title = freezed,
  }) {
    return _then(
      _$DiscourseUserSummaryItemImpl(
        postId: freezed == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as int?,
        topicId: freezed == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int?,
        topicTitle: freezed == topicTitle
            ? _value.topicTitle
            : topicTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        topicSlug: freezed == topicSlug
            ? _value.topicSlug
            : topicSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserSummaryItemImpl implements _DiscourseUserSummaryItem {
  const _$DiscourseUserSummaryItemImpl({
    @JsonKey(name: 'post_id') this.postId,
    @JsonKey(name: 'topic_id') this.topicId,
    @JsonKey(name: 'topic_title') this.topicTitle,
    @JsonKey(name: 'topic_slug') this.topicSlug,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'url') this.url,
    @JsonKey(name: 'title') this.title,
  });

  factory _$DiscourseUserSummaryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserSummaryItemImplFromJson(json);

  @override
  @JsonKey(name: 'post_id')
  final int? postId;
  @override
  @JsonKey(name: 'topic_id')
  final int? topicId;
  @override
  @JsonKey(name: 'topic_title')
  final String? topicTitle;
  @override
  @JsonKey(name: 'topic_slug')
  final String? topicSlug;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'title')
  final String? title;

  @override
  String toString() {
    return 'DiscourseUserSummaryItem(postId: $postId, topicId: $topicId, topicTitle: $topicTitle, topicSlug: $topicSlug, createdAt: $createdAt, url: $url, title: $title)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserSummaryItemImpl &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.topicTitle, topicTitle) ||
                other.topicTitle == topicTitle) &&
            (identical(other.topicSlug, topicSlug) ||
                other.topicSlug == topicSlug) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    postId,
    topicId,
    topicTitle,
    topicSlug,
    createdAt,
    url,
    title,
  );

  /// Create a copy of DiscourseUserSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserSummaryItemImplCopyWith<_$DiscourseUserSummaryItemImpl>
  get copyWith =>
      __$$DiscourseUserSummaryItemImplCopyWithImpl<
        _$DiscourseUserSummaryItemImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserSummaryItemImplToJson(this);
  }
}

abstract class _DiscourseUserSummaryItem implements DiscourseUserSummaryItem {
  const factory _DiscourseUserSummaryItem({
    @JsonKey(name: 'post_id') final int? postId,
    @JsonKey(name: 'topic_id') final int? topicId,
    @JsonKey(name: 'topic_title') final String? topicTitle,
    @JsonKey(name: 'topic_slug') final String? topicSlug,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'url') final String? url,
    @JsonKey(name: 'title') final String? title,
  }) = _$DiscourseUserSummaryItemImpl;

  factory _DiscourseUserSummaryItem.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserSummaryItemImpl.fromJson;

  @override
  @JsonKey(name: 'post_id')
  int? get postId;
  @override
  @JsonKey(name: 'topic_id')
  int? get topicId;
  @override
  @JsonKey(name: 'topic_title')
  String? get topicTitle;
  @override
  @JsonKey(name: 'topic_slug')
  String? get topicSlug;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'title')
  String? get title;

  /// Create a copy of DiscourseUserSummaryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserSummaryItemImplCopyWith<_$DiscourseUserSummaryItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseUserSummaryUser _$DiscourseUserSummaryUserFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseUserSummaryUser.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserSummaryUser {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'count')
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_number')
  int? get postNumber => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserSummaryUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserSummaryUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserSummaryUserCopyWith<DiscourseUserSummaryUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserSummaryUserCopyWith<$Res> {
  factory $DiscourseUserSummaryUserCopyWith(
    DiscourseUserSummaryUser value,
    $Res Function(DiscourseUserSummaryUser) then,
  ) = _$DiscourseUserSummaryUserCopyWithImpl<$Res, DiscourseUserSummaryUser>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'count') int count,
    @JsonKey(name: 'post_number') int? postNumber,
  });
}

/// @nodoc
class _$DiscourseUserSummaryUserCopyWithImpl<
  $Res,
  $Val extends DiscourseUserSummaryUser
>
    implements $DiscourseUserSummaryUserCopyWith<$Res> {
  _$DiscourseUserSummaryUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserSummaryUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? count = null,
    Object? postNumber = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarTemplate: null == avatarTemplate
                ? _value.avatarTemplate
                : avatarTemplate // ignore: cast_nullable_to_non_nullable
                      as String,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            postNumber: freezed == postNumber
                ? _value.postNumber
                : postNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserSummaryUserImplCopyWith<$Res>
    implements $DiscourseUserSummaryUserCopyWith<$Res> {
  factory _$$DiscourseUserSummaryUserImplCopyWith(
    _$DiscourseUserSummaryUserImpl value,
    $Res Function(_$DiscourseUserSummaryUserImpl) then,
  ) = __$$DiscourseUserSummaryUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'count') int count,
    @JsonKey(name: 'post_number') int? postNumber,
  });
}

/// @nodoc
class __$$DiscourseUserSummaryUserImplCopyWithImpl<$Res>
    extends
        _$DiscourseUserSummaryUserCopyWithImpl<
          $Res,
          _$DiscourseUserSummaryUserImpl
        >
    implements _$$DiscourseUserSummaryUserImplCopyWith<$Res> {
  __$$DiscourseUserSummaryUserImplCopyWithImpl(
    _$DiscourseUserSummaryUserImpl _value,
    $Res Function(_$DiscourseUserSummaryUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserSummaryUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? count = null,
    Object? postNumber = freezed,
  }) {
    return _then(
      _$DiscourseUserSummaryUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarTemplate: null == avatarTemplate
            ? _value.avatarTemplate
            : avatarTemplate // ignore: cast_nullable_to_non_nullable
                  as String,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        postNumber: freezed == postNumber
            ? _value.postNumber
            : postNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserSummaryUserImpl implements _DiscourseUserSummaryUser {
  const _$DiscourseUserSummaryUserImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'count') this.count = 0,
    @JsonKey(name: 'post_number') this.postNumber,
  });

  factory _$DiscourseUserSummaryUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserSummaryUserImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'avatar_template')
  final String avatarTemplate;
  @override
  @JsonKey(name: 'count')
  final int count;
  @override
  @JsonKey(name: 'post_number')
  final int? postNumber;

  @override
  String toString() {
    return 'DiscourseUserSummaryUser(id: $id, username: $username, name: $name, avatarTemplate: $avatarTemplate, count: $count, postNumber: $postNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserSummaryUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.postNumber, postNumber) ||
                other.postNumber == postNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    name,
    avatarTemplate,
    count,
    postNumber,
  );

  /// Create a copy of DiscourseUserSummaryUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserSummaryUserImplCopyWith<_$DiscourseUserSummaryUserImpl>
  get copyWith =>
      __$$DiscourseUserSummaryUserImplCopyWithImpl<
        _$DiscourseUserSummaryUserImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserSummaryUserImplToJson(this);
  }
}

abstract class _DiscourseUserSummaryUser implements DiscourseUserSummaryUser {
  const factory _DiscourseUserSummaryUser({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'count') final int count,
    @JsonKey(name: 'post_number') final int? postNumber,
  }) = _$DiscourseUserSummaryUserImpl;

  factory _DiscourseUserSummaryUser.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserSummaryUserImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate;
  @override
  @JsonKey(name: 'count')
  int get count;
  @override
  @JsonKey(name: 'post_number')
  int? get postNumber;

  /// Create a copy of DiscourseUserSummaryUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserSummaryUserImplCopyWith<_$DiscourseUserSummaryUserImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseUserBadge _$DiscourseUserBadgeFromJson(Map<String, dynamic> json) {
  return _DiscourseUserBadge.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserBadge {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'granted_at')
  String get grantedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'count')
  int get count => throw _privateConstructorUsedError;
  @JsonKey(name: 'badge_id')
  int get badgeId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'granted_by_id')
  int? get grantedById => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserBadge to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserBadgeCopyWith<DiscourseUserBadge> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserBadgeCopyWith<$Res> {
  factory $DiscourseUserBadgeCopyWith(
    DiscourseUserBadge value,
    $Res Function(DiscourseUserBadge) then,
  ) = _$DiscourseUserBadgeCopyWithImpl<$Res, DiscourseUserBadge>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'granted_at') String grantedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'count') int count,
    @JsonKey(name: 'badge_id') int badgeId,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'granted_by_id') int? grantedById,
  });
}

/// @nodoc
class _$DiscourseUserBadgeCopyWithImpl<$Res, $Val extends DiscourseUserBadge>
    implements $DiscourseUserBadgeCopyWith<$Res> {
  _$DiscourseUserBadgeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? grantedAt = null,
    Object? createdAt = freezed,
    Object? count = null,
    Object? badgeId = null,
    Object? userId = null,
    Object? grantedById = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            grantedAt: null == grantedAt
                ? _value.grantedAt
                : grantedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            count: null == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int,
            badgeId: null == badgeId
                ? _value.badgeId
                : badgeId // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            grantedById: freezed == grantedById
                ? _value.grantedById
                : grantedById // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserBadgeImplCopyWith<$Res>
    implements $DiscourseUserBadgeCopyWith<$Res> {
  factory _$$DiscourseUserBadgeImplCopyWith(
    _$DiscourseUserBadgeImpl value,
    $Res Function(_$DiscourseUserBadgeImpl) then,
  ) = __$$DiscourseUserBadgeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'granted_at') String grantedAt,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'count') int count,
    @JsonKey(name: 'badge_id') int badgeId,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'granted_by_id') int? grantedById,
  });
}

/// @nodoc
class __$$DiscourseUserBadgeImplCopyWithImpl<$Res>
    extends _$DiscourseUserBadgeCopyWithImpl<$Res, _$DiscourseUserBadgeImpl>
    implements _$$DiscourseUserBadgeImplCopyWith<$Res> {
  __$$DiscourseUserBadgeImplCopyWithImpl(
    _$DiscourseUserBadgeImpl _value,
    $Res Function(_$DiscourseUserBadgeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserBadge
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? grantedAt = null,
    Object? createdAt = freezed,
    Object? count = null,
    Object? badgeId = null,
    Object? userId = null,
    Object? grantedById = freezed,
  }) {
    return _then(
      _$DiscourseUserBadgeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        grantedAt: null == grantedAt
            ? _value.grantedAt
            : grantedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        count: null == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int,
        badgeId: null == badgeId
            ? _value.badgeId
            : badgeId // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        grantedById: freezed == grantedById
            ? _value.grantedById
            : grantedById // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserBadgeImpl implements _DiscourseUserBadge {
  const _$DiscourseUserBadgeImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'granted_at') required this.grantedAt,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'count') this.count = 0,
    @JsonKey(name: 'badge_id') required this.badgeId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'granted_by_id') this.grantedById,
  });

  factory _$DiscourseUserBadgeImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserBadgeImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'granted_at')
  final String grantedAt;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'count')
  final int count;
  @override
  @JsonKey(name: 'badge_id')
  final int badgeId;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'granted_by_id')
  final int? grantedById;

  @override
  String toString() {
    return 'DiscourseUserBadge(id: $id, grantedAt: $grantedAt, createdAt: $createdAt, count: $count, badgeId: $badgeId, userId: $userId, grantedById: $grantedById)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserBadgeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.grantedAt, grantedAt) ||
                other.grantedAt == grantedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.badgeId, badgeId) || other.badgeId == badgeId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.grantedById, grantedById) ||
                other.grantedById == grantedById));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    grantedAt,
    createdAt,
    count,
    badgeId,
    userId,
    grantedById,
  );

  /// Create a copy of DiscourseUserBadge
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserBadgeImplCopyWith<_$DiscourseUserBadgeImpl> get copyWith =>
      __$$DiscourseUserBadgeImplCopyWithImpl<_$DiscourseUserBadgeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserBadgeImplToJson(this);
  }
}

abstract class _DiscourseUserBadge implements DiscourseUserBadge {
  const factory _DiscourseUserBadge({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'granted_at') required final String grantedAt,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'count') final int count,
    @JsonKey(name: 'badge_id') required final int badgeId,
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'granted_by_id') final int? grantedById,
  }) = _$DiscourseUserBadgeImpl;

  factory _DiscourseUserBadge.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserBadgeImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'granted_at')
  String get grantedAt;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'count')
  int get count;
  @override
  @JsonKey(name: 'badge_id')
  int get badgeId;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'granted_by_id')
  int? get grantedById;

  /// Create a copy of DiscourseUserBadge
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserBadgeImplCopyWith<_$DiscourseUserBadgeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseUserCategory _$DiscourseUserCategoryFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseUserCategory.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserCategory {
  @JsonKey(name: 'topic_id')
  int? get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_count')
  int get topicCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_count')
  int get postCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_slug')
  String get categorySlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_color')
  String get categoryColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_text_color')
  String get categoryTextColor => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserCategoryCopyWith<DiscourseUserCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserCategoryCopyWith<$Res> {
  factory $DiscourseUserCategoryCopyWith(
    DiscourseUserCategory value,
    $Res Function(DiscourseUserCategory) then,
  ) = _$DiscourseUserCategoryCopyWithImpl<$Res, DiscourseUserCategory>;
  @useResult
  $Res call({
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'category_slug') String categorySlug,
    @JsonKey(name: 'category_color') String categoryColor,
    @JsonKey(name: 'category_text_color') String categoryTextColor,
  });
}

/// @nodoc
class _$DiscourseUserCategoryCopyWithImpl<
  $Res,
  $Val extends DiscourseUserCategory
>
    implements $DiscourseUserCategoryCopyWith<$Res> {
  _$DiscourseUserCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = freezed,
    Object? topicCount = null,
    Object? postCount = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categorySlug = null,
    Object? categoryColor = null,
    Object? categoryTextColor = null,
  }) {
    return _then(
      _value.copyWith(
            topicId: freezed == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int?,
            topicCount: null == topicCount
                ? _value.topicCount
                : topicCount // ignore: cast_nullable_to_non_nullable
                      as int,
            postCount: null == postCount
                ? _value.postCount
                : postCount // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: null == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String,
            categorySlug: null == categorySlug
                ? _value.categorySlug
                : categorySlug // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryColor: null == categoryColor
                ? _value.categoryColor
                : categoryColor // ignore: cast_nullable_to_non_nullable
                      as String,
            categoryTextColor: null == categoryTextColor
                ? _value.categoryTextColor
                : categoryTextColor // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserCategoryImplCopyWith<$Res>
    implements $DiscourseUserCategoryCopyWith<$Res> {
  factory _$$DiscourseUserCategoryImplCopyWith(
    _$DiscourseUserCategoryImpl value,
    $Res Function(_$DiscourseUserCategoryImpl) then,
  ) = __$$DiscourseUserCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String categoryName,
    @JsonKey(name: 'category_slug') String categorySlug,
    @JsonKey(name: 'category_color') String categoryColor,
    @JsonKey(name: 'category_text_color') String categoryTextColor,
  });
}

/// @nodoc
class __$$DiscourseUserCategoryImplCopyWithImpl<$Res>
    extends
        _$DiscourseUserCategoryCopyWithImpl<$Res, _$DiscourseUserCategoryImpl>
    implements _$$DiscourseUserCategoryImplCopyWith<$Res> {
  __$$DiscourseUserCategoryImplCopyWithImpl(
    _$DiscourseUserCategoryImpl _value,
    $Res Function(_$DiscourseUserCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = freezed,
    Object? topicCount = null,
    Object? postCount = null,
    Object? categoryId = null,
    Object? categoryName = null,
    Object? categorySlug = null,
    Object? categoryColor = null,
    Object? categoryTextColor = null,
  }) {
    return _then(
      _$DiscourseUserCategoryImpl(
        topicId: freezed == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int?,
        topicCount: null == topicCount
            ? _value.topicCount
            : topicCount // ignore: cast_nullable_to_non_nullable
                  as int,
        postCount: null == postCount
            ? _value.postCount
            : postCount // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: null == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String,
        categorySlug: null == categorySlug
            ? _value.categorySlug
            : categorySlug // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryColor: null == categoryColor
            ? _value.categoryColor
            : categoryColor // ignore: cast_nullable_to_non_nullable
                  as String,
        categoryTextColor: null == categoryTextColor
            ? _value.categoryTextColor
            : categoryTextColor // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserCategoryImpl implements _DiscourseUserCategory {
  const _$DiscourseUserCategoryImpl({
    @JsonKey(name: 'topic_id') this.topicId,
    @JsonKey(name: 'topic_count') this.topicCount = 0,
    @JsonKey(name: 'post_count') this.postCount = 0,
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') required this.categoryName,
    @JsonKey(name: 'category_slug') required this.categorySlug,
    @JsonKey(name: 'category_color') required this.categoryColor,
    @JsonKey(name: 'category_text_color') required this.categoryTextColor,
  });

  factory _$DiscourseUserCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'topic_id')
  final int? topicId;
  @override
  @JsonKey(name: 'topic_count')
  final int topicCount;
  @override
  @JsonKey(name: 'post_count')
  final int postCount;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  @JsonKey(name: 'category_slug')
  final String categorySlug;
  @override
  @JsonKey(name: 'category_color')
  final String categoryColor;
  @override
  @JsonKey(name: 'category_text_color')
  final String categoryTextColor;

  @override
  String toString() {
    return 'DiscourseUserCategory(topicId: $topicId, topicCount: $topicCount, postCount: $postCount, categoryId: $categoryId, categoryName: $categoryName, categorySlug: $categorySlug, categoryColor: $categoryColor, categoryTextColor: $categoryTextColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserCategoryImpl &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.topicCount, topicCount) ||
                other.topicCount == topicCount) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categorySlug, categorySlug) ||
                other.categorySlug == categorySlug) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor) &&
            (identical(other.categoryTextColor, categoryTextColor) ||
                other.categoryTextColor == categoryTextColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    topicId,
    topicCount,
    postCount,
    categoryId,
    categoryName,
    categorySlug,
    categoryColor,
    categoryTextColor,
  );

  /// Create a copy of DiscourseUserCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserCategoryImplCopyWith<_$DiscourseUserCategoryImpl>
  get copyWith =>
      __$$DiscourseUserCategoryImplCopyWithImpl<_$DiscourseUserCategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserCategoryImplToJson(this);
  }
}

abstract class _DiscourseUserCategory implements DiscourseUserCategory {
  const factory _DiscourseUserCategory({
    @JsonKey(name: 'topic_id') final int? topicId,
    @JsonKey(name: 'topic_count') final int topicCount,
    @JsonKey(name: 'post_count') final int postCount,
    @JsonKey(name: 'category_id') required final int categoryId,
    @JsonKey(name: 'category_name') required final String categoryName,
    @JsonKey(name: 'category_slug') required final String categorySlug,
    @JsonKey(name: 'category_color') required final String categoryColor,
    @JsonKey(name: 'category_text_color')
    required final String categoryTextColor,
  }) = _$DiscourseUserCategoryImpl;

  factory _DiscourseUserCategory.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'topic_id')
  int? get topicId;
  @override
  @JsonKey(name: 'topic_count')
  int get topicCount;
  @override
  @JsonKey(name: 'post_count')
  int get postCount;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(name: 'category_slug')
  String get categorySlug;
  @override
  @JsonKey(name: 'category_color')
  String get categoryColor;
  @override
  @JsonKey(name: 'category_text_color')
  String get categoryTextColor;

  /// Create a copy of DiscourseUserCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserCategoryImplCopyWith<_$DiscourseUserCategoryImpl>
  get copyWith => throw _privateConstructorUsedError;
}
