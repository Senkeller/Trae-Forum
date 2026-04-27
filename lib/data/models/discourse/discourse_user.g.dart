// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscourseUserImpl _$$DiscourseUserImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserImpl(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
  email: json['email'] as String?,
  secondaryEmails:
      (json['secondary_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  unconfirmedEmails:
      (json['unconfirmed_emails'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  lastPostedAt: json['last_posted_at'] as String?,
  lastSeenAt: json['last_seen_at'] as String?,
  createdAt: json['created_at'] as String,
  ignored: json['ignored'] as bool? ?? false,
  muted: json['muted'] as bool? ?? false,
  canIgnoreUser: json['can_ignore_user'] as bool? ?? false,
  canMuteUser: json['can_mute_user'] as bool? ?? false,
  canSendPrivateMessages: json['can_send_private_messages'] as bool? ?? false,
  canSendPrivateMessageToUser:
      json['can_send_private_message_to_user'] as bool? ?? false,
  trustLevel: (json['trust_level'] as num?)?.toInt() ?? 0,
  moderator: json['moderator'] as bool? ?? false,
  admin: json['admin'] as bool? ?? false,
  title: json['title'] as String?,
  badgeCount: (json['badge_count'] as num?)?.toInt() ?? 0,
  userAuthTokens: json['user_auth_tokens'] as List<dynamic>? ?? const [],
  userNotificationSchedule:
      json['user_notification_schedule'] as Map<String, dynamic>?,
  featuredTopic: json['featured_topic'] as Map<String, dynamic>?,
  timezone: json['timezone'] as String?,
  profileHidden: json['profile_hidden'] as bool? ?? false,
  canBeDeleted: json['can_be_deleted'] as bool? ?? false,
  canDeleteAllPosts: json['can_delete_all_posts'] as bool? ?? false,
  locale: json['locale'] as String?,
  mutedCategoryIds:
      (json['muted_category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  regularCategoryIds:
      (json['regular_category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  watchedTags:
      (json['watched_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  watchingFirstPostTags:
      (json['watching_first_post_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  trackedTags:
      (json['tracked_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  mutedTags:
      (json['muted_tags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  trackedCategoryIds:
      (json['tracked_category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  watchedCategoryIds:
      (json['watched_category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  watchedFirstPostCategoryIds:
      (json['watched_first_post_category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  systemAvatarTemplate: json['system_avatar_template'] as String?,
  mutedUsernames:
      (json['muted_usernames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  ignoredUsernames:
      (json['ignored_usernames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  allowedPmUsernames:
      (json['allowed_pm_usernames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  mailingListPostsPerDay: (json['mailing_list_posts_per_day'] as num?)?.toInt(),
  canChangeBio: json['can_change_bio'] as bool? ?? false,
  canChangeLocation: json['can_change_location'] as bool? ?? false,
  canChangeWebsite: json['can_change_website'] as bool? ?? false,
  canChangeTrackingPreferences:
      json['can_change_tracking_preferences'] as bool? ?? false,
  userApiKeys: json['user_api_keys'] as List<dynamic>? ?? const [],
  userStatus: json['user_status'] as Map<String, dynamic>?,
  sidebarTags: json['sidebar_tags'] as List<dynamic>? ?? const [],
  sidebarCategoryIds:
      (json['sidebar_category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  displaySidebarTags: json['display_sidebar_tags'] as bool? ?? false,
  sidebarListDestination: json['sidebar_list_destination'] as String?,
);

Map<String, dynamic> _$$DiscourseUserImplToJson(_$DiscourseUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'avatar_template': instance.avatarTemplate,
      'email': instance.email,
      'secondary_emails': instance.secondaryEmails,
      'unconfirmed_emails': instance.unconfirmedEmails,
      'last_posted_at': instance.lastPostedAt,
      'last_seen_at': instance.lastSeenAt,
      'created_at': instance.createdAt,
      'ignored': instance.ignored,
      'muted': instance.muted,
      'can_ignore_user': instance.canIgnoreUser,
      'can_mute_user': instance.canMuteUser,
      'can_send_private_messages': instance.canSendPrivateMessages,
      'can_send_private_message_to_user': instance.canSendPrivateMessageToUser,
      'trust_level': instance.trustLevel,
      'moderator': instance.moderator,
      'admin': instance.admin,
      'title': instance.title,
      'badge_count': instance.badgeCount,
      'user_auth_tokens': instance.userAuthTokens,
      'user_notification_schedule': instance.userNotificationSchedule,
      'featured_topic': instance.featuredTopic,
      'timezone': instance.timezone,
      'profile_hidden': instance.profileHidden,
      'can_be_deleted': instance.canBeDeleted,
      'can_delete_all_posts': instance.canDeleteAllPosts,
      'locale': instance.locale,
      'muted_category_ids': instance.mutedCategoryIds,
      'regular_category_ids': instance.regularCategoryIds,
      'watched_tags': instance.watchedTags,
      'watching_first_post_tags': instance.watchingFirstPostTags,
      'tracked_tags': instance.trackedTags,
      'muted_tags': instance.mutedTags,
      'tracked_category_ids': instance.trackedCategoryIds,
      'watched_category_ids': instance.watchedCategoryIds,
      'watched_first_post_category_ids': instance.watchedFirstPostCategoryIds,
      'system_avatar_template': instance.systemAvatarTemplate,
      'muted_usernames': instance.mutedUsernames,
      'ignored_usernames': instance.ignoredUsernames,
      'allowed_pm_usernames': instance.allowedPmUsernames,
      'mailing_list_posts_per_day': instance.mailingListPostsPerDay,
      'can_change_bio': instance.canChangeBio,
      'can_change_location': instance.canChangeLocation,
      'can_change_website': instance.canChangeWebsite,
      'can_change_tracking_preferences': instance.canChangeTrackingPreferences,
      'user_api_keys': instance.userApiKeys,
      'user_status': instance.userStatus,
      'sidebar_tags': instance.sidebarTags,
      'sidebar_category_ids': instance.sidebarCategoryIds,
      'display_sidebar_tags': instance.displaySidebarTags,
      'sidebar_list_destination': instance.sidebarListDestination,
    };

_$DiscourseUserResponseImpl _$$DiscourseUserResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserResponseImpl(
  userBadges: json['user_badges'] as List<dynamic>? ?? const [],
  badges:
      (json['badges'] as List<dynamic>?)
          ?.map((e) => DiscourseBadge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  badgeTypes:
      (json['badge_types'] as List<dynamic>?)
          ?.map((e) => DiscourseBadgeType.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  users:
      (json['users'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserBasicInfo.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  user: json['user'] == null
      ? null
      : DiscourseUser.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DiscourseUserResponseImplToJson(
  _$DiscourseUserResponseImpl instance,
) => <String, dynamic>{
  'user_badges': instance.userBadges,
  'badges': instance.badges,
  'badge_types': instance.badgeTypes,
  'users': instance.users,
  'user': instance.user,
};

_$DiscourseBadgeImpl _$$DiscourseBadgeImplFromJson(Map<String, dynamic> json) =>
    _$DiscourseBadgeImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String?,
      grantCount: (json['grant_count'] as num?)?.toInt() ?? 0,
      allowTitle: json['allow_title'] as bool? ?? false,
      multipleGrant: json['multiple_grant'] as bool? ?? false,
      icon: json['icon'] as String?,
      imageUrl: json['image_url'] as String?,
      listable: json['listable'] as bool? ?? true,
      enabled: json['enabled'] as bool? ?? true,
      badgeGroupingId: (json['badge_grouping_id'] as num?)?.toInt(),
      system: json['system'] as bool? ?? false,
      slug: json['slug'] as String,
      manuallyGrantable: json['manually_grantable'] as bool? ?? false,
      badgeTypeId: (json['badge_type_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$DiscourseBadgeImplToJson(
  _$DiscourseBadgeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'grant_count': instance.grantCount,
  'allow_title': instance.allowTitle,
  'multiple_grant': instance.multipleGrant,
  'icon': instance.icon,
  'image_url': instance.imageUrl,
  'listable': instance.listable,
  'enabled': instance.enabled,
  'badge_grouping_id': instance.badgeGroupingId,
  'system': instance.system,
  'slug': instance.slug,
  'manually_grantable': instance.manuallyGrantable,
  'badge_type_id': instance.badgeTypeId,
};

_$DiscourseBadgeTypeImpl _$$DiscourseBadgeTypeImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseBadgeTypeImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  sortOrder: (json['sort_order'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DiscourseBadgeTypeImplToJson(
  _$DiscourseBadgeTypeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'sort_order': instance.sortOrder,
};

_$DiscourseUserBasicInfoImpl _$$DiscourseUserBasicInfoImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserBasicInfoImpl(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
  admin: json['admin'] as bool? ?? false,
  moderator: json['moderator'] as bool? ?? false,
  trustLevel: (json['trust_level'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$DiscourseUserBasicInfoImplToJson(
  _$DiscourseUserBasicInfoImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'name': instance.name,
  'avatar_template': instance.avatarTemplate,
  'admin': instance.admin,
  'moderator': instance.moderator,
  'trust_level': instance.trustLevel,
};

_$DiscourseUserSummaryResponseImpl _$$DiscourseUserSummaryResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserSummaryResponseImpl(
  userSummary: json['user_summary'] == null
      ? null
      : DiscourseUserSummary.fromJson(
          json['user_summary'] as Map<String, dynamic>,
        ),
  badges:
      (json['badges'] as List<dynamic>?)
          ?.map((e) => DiscourseBadge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  badgeTypes:
      (json['badge_types'] as List<dynamic>?)
          ?.map((e) => DiscourseBadgeType.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  users:
      (json['users'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserBasicInfo.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscourseUserSummaryResponseImplToJson(
  _$DiscourseUserSummaryResponseImpl instance,
) => <String, dynamic>{
  'user_summary': instance.userSummary,
  'badges': instance.badges,
  'badge_types': instance.badgeTypes,
  'users': instance.users,
};

_$DiscourseUserSummaryImpl _$$DiscourseUserSummaryImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserSummaryImpl(
  likesGiven: (json['likes_given'] as num?)?.toInt() ?? 0,
  likesReceived: (json['likes_received'] as num?)?.toInt() ?? 0,
  topicsEntered: (json['topics_entered'] as num?)?.toInt() ?? 0,
  topicCount: (json['topic_count'] as num?)?.toInt() ?? 0,
  postCount: (json['post_count'] as num?)?.toInt() ?? 0,
  postsReadCount: (json['posts_read_count'] as num?)?.toInt() ?? 0,
  daysVisited: (json['days_visited'] as num?)?.toInt() ?? 0,
  solvedCount: (json['solved_count'] as num?)?.toInt() ?? 0,
  topicIds:
      (json['topic_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserSummaryItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  links:
      (json['links'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserSummaryItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  mostRepliedToUsers:
      (json['most_replied_to_users'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserSummaryUser.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  mostLikedByUsers:
      (json['most_liked_by_users'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserSummaryUser.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  mostLikedUsers:
      (json['most_liked_users'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserSummaryUser.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  badges:
      (json['badges'] as List<dynamic>?)
          ?.map((e) => DiscourseUserBadge.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  topCategories:
      (json['top_categories'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseUserCategory.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscourseUserSummaryImplToJson(
  _$DiscourseUserSummaryImpl instance,
) => <String, dynamic>{
  'likes_given': instance.likesGiven,
  'likes_received': instance.likesReceived,
  'topics_entered': instance.topicsEntered,
  'topic_count': instance.topicCount,
  'post_count': instance.postCount,
  'posts_read_count': instance.postsReadCount,
  'days_visited': instance.daysVisited,
  'solved_count': instance.solvedCount,
  'topic_ids': instance.topicIds,
  'replies': instance.replies,
  'links': instance.links,
  'most_replied_to_users': instance.mostRepliedToUsers,
  'most_liked_by_users': instance.mostLikedByUsers,
  'most_liked_users': instance.mostLikedUsers,
  'badges': instance.badges,
  'top_categories': instance.topCategories,
};

_$DiscourseUserSummaryItemImpl _$$DiscourseUserSummaryItemImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserSummaryItemImpl(
  postId: (json['post_id'] as num?)?.toInt(),
  topicId: (json['topic_id'] as num?)?.toInt(),
  topicTitle: json['topic_title'] as String?,
  topicSlug: json['topic_slug'] as String?,
  createdAt: json['created_at'] as String?,
  url: json['url'] as String?,
  title: json['title'] as String?,
);

Map<String, dynamic> _$$DiscourseUserSummaryItemImplToJson(
  _$DiscourseUserSummaryItemImpl instance,
) => <String, dynamic>{
  'post_id': instance.postId,
  'topic_id': instance.topicId,
  'topic_title': instance.topicTitle,
  'topic_slug': instance.topicSlug,
  'created_at': instance.createdAt,
  'url': instance.url,
  'title': instance.title,
};

_$DiscourseUserSummaryUserImpl _$$DiscourseUserSummaryUserImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserSummaryUserImpl(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
  count: (json['count'] as num?)?.toInt() ?? 0,
  postNumber: (json['post_number'] as num?)?.toInt(),
);

Map<String, dynamic> _$$DiscourseUserSummaryUserImplToJson(
  _$DiscourseUserSummaryUserImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'name': instance.name,
  'avatar_template': instance.avatarTemplate,
  'count': instance.count,
  'post_number': instance.postNumber,
};

_$DiscourseUserBadgeImpl _$$DiscourseUserBadgeImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserBadgeImpl(
  id: (json['id'] as num).toInt(),
  grantedAt: json['granted_at'] as String,
  createdAt: json['created_at'] as String?,
  count: (json['count'] as num?)?.toInt() ?? 0,
  badgeId: (json['badge_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  grantedById: (json['granted_by_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$$DiscourseUserBadgeImplToJson(
  _$DiscourseUserBadgeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'granted_at': instance.grantedAt,
  'created_at': instance.createdAt,
  'count': instance.count,
  'badge_id': instance.badgeId,
  'user_id': instance.userId,
  'granted_by_id': instance.grantedById,
};

_$DiscourseUserCategoryImpl _$$DiscourseUserCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserCategoryImpl(
  topicId: (json['topic_id'] as num?)?.toInt(),
  topicCount: (json['topic_count'] as num?)?.toInt() ?? 0,
  postCount: (json['post_count'] as num?)?.toInt() ?? 0,
  categoryId: (json['category_id'] as num).toInt(),
  categoryName: json['category_name'] as String,
  categorySlug: json['category_slug'] as String,
  categoryColor: json['category_color'] as String,
  categoryTextColor: json['category_text_color'] as String,
);

Map<String, dynamic> _$$DiscourseUserCategoryImplToJson(
  _$DiscourseUserCategoryImpl instance,
) => <String, dynamic>{
  'topic_id': instance.topicId,
  'topic_count': instance.topicCount,
  'post_count': instance.postCount,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'category_slug': instance.categorySlug,
  'category_color': instance.categoryColor,
  'category_text_color': instance.categoryTextColor,
};
