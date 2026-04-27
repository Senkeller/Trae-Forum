// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscourseTopicImpl _$$DiscourseTopicImplFromJson(Map<String, dynamic> json) =>
    _$DiscourseTopicImpl(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      fancyTitle: json['fancy_title'] as String?,
      slug: json['slug'] as String,
      categoryId: (json['category_id'] as num).toInt(),
      postsCount: (json['posts_count'] as num?)?.toInt() ?? 0,
      replyCount: (json['reply_count'] as num?)?.toInt() ?? 0,
      highestPostNumber: (json['highest_post_number'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String,
      lastPostedAt: json['last_posted_at'] as String?,
      bumped: json['bumped'] as bool? ?? false,
      bumpedAt: json['bumped_at'] as String?,
      archetype: json['archetype'] as String? ?? 'regular',
      unseen: json['unseen'] as bool? ?? false,
      pinned: json['pinned'] as bool? ?? false,
      unpinned: json['unpinned'] as bool?,
      visible: json['visible'] as bool? ?? true,
      closed: json['closed'] as bool? ?? false,
      archived: json['archived'] as bool? ?? false,
      bookmarked: json['bookmarked'] as bool? ?? false,
      liked: json['liked'] as bool? ?? false,
      views: (json['views'] as num?)?.toInt() ?? 0,
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      hasSummary: json['has_summary'] as bool? ?? false,
      lastPosterUsername: json['last_poster_username'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      tagsDescriptions: json['tags_descriptions'] as Map<String, dynamic>?,
      participants:
          (json['participants'] as List<dynamic>?)
              ?.map(
                (e) => DiscourseParticipant.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      posters:
          (json['posters'] as List<dynamic>?)
              ?.map((e) => DiscoursePoster.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      imageUrl: json['image_url'] as String?,
      excerpt: json['excerpt'] as String?,
    );

Map<String, dynamic> _$$DiscourseTopicImplToJson(
  _$DiscourseTopicImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'fancy_title': instance.fancyTitle,
  'slug': instance.slug,
  'category_id': instance.categoryId,
  'posts_count': instance.postsCount,
  'reply_count': instance.replyCount,
  'highest_post_number': instance.highestPostNumber,
  'created_at': instance.createdAt,
  'last_posted_at': instance.lastPostedAt,
  'bumped': instance.bumped,
  'bumped_at': instance.bumpedAt,
  'archetype': instance.archetype,
  'unseen': instance.unseen,
  'pinned': instance.pinned,
  'unpinned': instance.unpinned,
  'visible': instance.visible,
  'closed': instance.closed,
  'archived': instance.archived,
  'bookmarked': instance.bookmarked,
  'liked': instance.liked,
  'views': instance.views,
  'like_count': instance.likeCount,
  'has_summary': instance.hasSummary,
  'last_poster_username': instance.lastPosterUsername,
  'tags': instance.tags,
  'tags_descriptions': instance.tagsDescriptions,
  'participants': instance.participants,
  'posters': instance.posters,
  'image_url': instance.imageUrl,
  'excerpt': instance.excerpt,
};

_$DiscourseParticipantImpl _$$DiscourseParticipantImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseParticipantImpl(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
  postCount: (json['post_count'] as num?)?.toInt() ?? 0,
  primaryGroupName: json['primary_group_name'] as String?,
  flairName: json['flair_name'] as String?,
  flairUrl: json['flair_url'] as String?,
  flairBgColor: json['flair_bg_color'] as String?,
  flairColor: json['flair_color'] as String?,
  admin: json['admin'] as bool? ?? false,
  moderator: json['moderator'] as bool? ?? false,
  trustLevel: (json['trust_level'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$$DiscourseParticipantImplToJson(
  _$DiscourseParticipantImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'name': instance.name,
  'avatar_template': instance.avatarTemplate,
  'post_count': instance.postCount,
  'primary_group_name': instance.primaryGroupName,
  'flair_name': instance.flairName,
  'flair_url': instance.flairUrl,
  'flair_bg_color': instance.flairBgColor,
  'flair_color': instance.flairColor,
  'admin': instance.admin,
  'moderator': instance.moderator,
  'trust_level': instance.trustLevel,
};

_$DiscoursePosterImpl _$$DiscoursePosterImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePosterImpl(
  extras: json['extras'] as String?,
  description: json['description'] as String?,
  userId: (json['user_id'] as num).toInt(),
  primaryGroupId: (json['primary_group_id'] as num?)?.toInt(),
  primaryGroupName: json['primary_group_name'] as String?,
  flairGroupId: (json['flair_group_id'] as num?)?.toInt(),
  flairName: json['flair_name'] as String?,
  flairUrl: json['flair_url'] as String?,
  flairBgColor: json['flair_bg_color'] as String?,
  flairColor: json['flair_color'] as String?,
);

Map<String, dynamic> _$$DiscoursePosterImplToJson(
  _$DiscoursePosterImpl instance,
) => <String, dynamic>{
  'extras': instance.extras,
  'description': instance.description,
  'user_id': instance.userId,
  'primary_group_id': instance.primaryGroupId,
  'primary_group_name': instance.primaryGroupName,
  'flair_group_id': instance.flairGroupId,
  'flair_name': instance.flairName,
  'flair_url': instance.flairUrl,
  'flair_bg_color': instance.flairBgColor,
  'flair_color': instance.flairColor,
};

_$DiscourseTopicListResponseImpl _$$DiscourseTopicListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseTopicListResponseImpl(
  users:
      (json['users'] as List<dynamic>?)
          ?.map((e) => DiscourseUserBasic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  primaryGroups:
      (json['primary_groups'] as List<dynamic>?)
          ?.map(
            (e) => DiscoursePrimaryGroup.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  flairGroups:
      (json['flair_groups'] as List<dynamic>?)
          ?.map((e) => DiscourseFlairGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  topicList: json['topic_list'] == null
      ? null
      : DiscourseTopicList.fromJson(json['topic_list'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$DiscourseTopicListResponseImplToJson(
  _$DiscourseTopicListResponseImpl instance,
) => <String, dynamic>{
  'users': instance.users,
  'primary_groups': instance.primaryGroups,
  'flair_groups': instance.flairGroups,
  'topic_list': instance.topicList,
};

_$DiscourseTopicListImpl _$$DiscourseTopicListImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseTopicListImpl(
  canCreateTopic: json['can_create_topic'] as bool? ?? false,
  moreTopicsUrl: json['more_topics_url'] as String?,
  forPeriod: json['for_period'] as String?,
  perPage: (json['per_page'] as num?)?.toInt() ?? 30,
  topTags:
      (json['top_tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  topics:
      (json['topics'] as List<dynamic>?)
          ?.map((e) => DiscourseTopic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscourseTopicListImplToJson(
  _$DiscourseTopicListImpl instance,
) => <String, dynamic>{
  'can_create_topic': instance.canCreateTopic,
  'more_topics_url': instance.moreTopicsUrl,
  'for_period': instance.forPeriod,
  'per_page': instance.perPage,
  'top_tags': instance.topTags,
  'topics': instance.topics,
};

_$DiscourseUserBasicImpl _$$DiscourseUserBasicImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUserBasicImpl(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
  admin: json['admin'] as bool? ?? false,
  moderator: json['moderator'] as bool? ?? false,
  trustLevel: (json['trust_level'] as num?)?.toInt() ?? 1,
  primaryGroupName: json['primary_group_name'] as String?,
  flairName: json['flair_name'] as String?,
  flairUrl: json['flair_url'] as String?,
  flairBgColor: json['flair_bg_color'] as String?,
  flairColor: json['flair_color'] as String?,
);

Map<String, dynamic> _$$DiscourseUserBasicImplToJson(
  _$DiscourseUserBasicImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'name': instance.name,
  'avatar_template': instance.avatarTemplate,
  'admin': instance.admin,
  'moderator': instance.moderator,
  'trust_level': instance.trustLevel,
  'primary_group_name': instance.primaryGroupName,
  'flair_name': instance.flairName,
  'flair_url': instance.flairUrl,
  'flair_bg_color': instance.flairBgColor,
  'flair_color': instance.flairColor,
};

_$DiscoursePrimaryGroupImpl _$$DiscoursePrimaryGroupImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePrimaryGroupImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$$DiscoursePrimaryGroupImplToJson(
  _$DiscoursePrimaryGroupImpl instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};

_$DiscourseFlairGroupImpl _$$DiscourseFlairGroupImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseFlairGroupImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  flairUrl: json['flair_url'] as String?,
  flairBgColor: json['flair_bg_color'] as String?,
  flairColor: json['flair_color'] as String?,
);

Map<String, dynamic> _$$DiscourseFlairGroupImplToJson(
  _$DiscourseFlairGroupImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'flair_url': instance.flairUrl,
  'flair_bg_color': instance.flairBgColor,
  'flair_color': instance.flairColor,
};

_$DiscourseTopicDetailResponseImpl _$$DiscourseTopicDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseTopicDetailResponseImpl(
  postStream: json['post_stream'] == null
      ? null
      : DiscoursePostStream.fromJson(
          json['post_stream'] as Map<String, dynamic>,
        ),
  timelineLookup:
      (json['timeline_lookup'] as List<dynamic>?)
          ?.map((e) => e as List<dynamic>)
          .toList() ??
      const [],
  suggestedTopics:
      (json['suggested_topics'] as List<dynamic>?)
          ?.map((e) => DiscourseTopic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  id: (json['id'] as num?)?.toInt(),
  title: json['title'] as String?,
  fancyTitle: json['fancy_title'] as String?,
  postsCount: (json['posts_count'] as num?)?.toInt(),
  createdAt: json['created_at'] as String?,
  views: (json['views'] as num?)?.toInt(),
  replyCount: (json['reply_count'] as num?)?.toInt(),
  likeCount: (json['like_count'] as num?)?.toInt(),
  lastPostedAt: json['last_posted_at'] as String?,
  visible: json['visible'] as bool?,
  closed: json['closed'] as bool?,
  archived: json['archived'] as bool?,
  hasSummary: json['has_summary'] as bool?,
  archetype: json['archetype'] as String?,
  slug: json['slug'] as String?,
  categoryId: (json['category_id'] as num?)?.toInt(),
  wordCount: (json['word_count'] as num?)?.toInt(),
  userId: (json['user_id'] as num?)?.toInt(),
  pinnedGlobally: json['pinned_globally'] as bool?,
  pinned: json['pinned'] as bool?,
  pinnedAt: json['pinned_at'] as String?,
  details: json['details'] == null
      ? null
      : DiscourseTopicDetails.fromJson(json['details'] as Map<String, dynamic>),
  highestPostNumber: (json['highest_post_number'] as num?)?.toInt(),
  lastReadPostNumber: (json['last_read_post_number'] as num?)?.toInt(),
  deletedBy: json['deleted_by'] as Map<String, dynamic>?,
  actionsSummary:
      (json['actions_summary'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  chunkSize: (json['chunk_size'] as num?)?.toInt(),
  bookmarked: json['bookmarked'] as bool?,
  topicTimer: json['topic_timer'] as Map<String, dynamic>?,
  messageBusLastId: (json['message_bus_last_id'] as num?)?.toInt(),
  participantCount: (json['participant_count'] as num?)?.toInt(),
  showReadIndicator: json['show_read_indicator'] as bool?,
  thumbnails:
      (json['thumbnails'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  tagsDescriptions: json['tags_descriptions'] as Map<String, dynamic>?,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$$DiscourseTopicDetailResponseImplToJson(
  _$DiscourseTopicDetailResponseImpl instance,
) => <String, dynamic>{
  'post_stream': instance.postStream,
  'timeline_lookup': instance.timelineLookup,
  'suggested_topics': instance.suggestedTopics,
  'id': instance.id,
  'title': instance.title,
  'fancy_title': instance.fancyTitle,
  'posts_count': instance.postsCount,
  'created_at': instance.createdAt,
  'views': instance.views,
  'reply_count': instance.replyCount,
  'like_count': instance.likeCount,
  'last_posted_at': instance.lastPostedAt,
  'visible': instance.visible,
  'closed': instance.closed,
  'archived': instance.archived,
  'has_summary': instance.hasSummary,
  'archetype': instance.archetype,
  'slug': instance.slug,
  'category_id': instance.categoryId,
  'word_count': instance.wordCount,
  'user_id': instance.userId,
  'pinned_globally': instance.pinnedGlobally,
  'pinned': instance.pinned,
  'pinned_at': instance.pinnedAt,
  'details': instance.details,
  'highest_post_number': instance.highestPostNumber,
  'last_read_post_number': instance.lastReadPostNumber,
  'deleted_by': instance.deletedBy,
  'actions_summary': instance.actionsSummary,
  'chunk_size': instance.chunkSize,
  'bookmarked': instance.bookmarked,
  'topic_timer': instance.topicTimer,
  'message_bus_last_id': instance.messageBusLastId,
  'participant_count': instance.participantCount,
  'show_read_indicator': instance.showReadIndicator,
  'thumbnails': instance.thumbnails,
  'tags': instance.tags,
  'tags_descriptions': instance.tagsDescriptions,
  'image_url': instance.imageUrl,
};

_$DiscourseTopicDetailsImpl _$$DiscourseTopicDetailsImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseTopicDetailsImpl(
  notificationLevel: (json['notification_level'] as num?)?.toInt(),
  notificationsReasonId: (json['notifications_reason_id'] as num?)?.toInt(),
  canMovePosts: json['can_move_posts'] as bool?,
  canEdit: json['can_edit'] as bool?,
  canDelete: json['can_delete'] as bool?,
  canRemoveAllowedUsers: json['can_remove_allowed_users'] as bool?,
  canInviteTo: json['can_invite_to'] as bool?,
  canInviteViaEmail: json['can_invite_via_email'] as bool?,
  canCreatePost: json['can_create_post'] as bool?,
  canReplyAsNewTopic: json['can_reply_as_new_topic'] as bool?,
  canFlagTopic: json['can_flag_topic'] as bool?,
  canConvertTopic: json['can_convert_topic'] as bool?,
  canReviewTopic: json['can_review_topic'] as bool?,
  canCloseTopic: json['can_close_topic'] as bool?,
  canArchiveTopic: json['can_archive_topic'] as bool?,
  canSplitMergeTopic: json['can_split_merge_topic'] as bool?,
  canEditStaffNotes: json['can_edit_staff_notes'] as bool?,
  canToggleTopicVisibility: json['can_toggle_topic_visibility'] as bool?,
  canPinUnpinTopic: json['can_pin_unpin_topic'] as bool?,
  canModerateCategory: json['can_moderate_category'] as bool?,
  canRemoveSelfId: (json['can_remove_self_id'] as num?)?.toInt(),
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => DiscourseParticipant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  createdBy: json['created_by'] == null
      ? null
      : DiscourseCreatedBy.fromJson(json['created_by'] as Map<String, dynamic>),
  lastPoster: json['last_poster'] == null
      ? null
      : DiscourseCreatedBy.fromJson(
          json['last_poster'] as Map<String, dynamic>,
        ),
  allowedUsers:
      (json['allowed_users'] as List<dynamic>?)
          ?.map((e) => DiscourseUserBasic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  allowedGroups:
      (json['allowed_groups'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscourseTopicDetailsImplToJson(
  _$DiscourseTopicDetailsImpl instance,
) => <String, dynamic>{
  'notification_level': instance.notificationLevel,
  'notifications_reason_id': instance.notificationsReasonId,
  'can_move_posts': instance.canMovePosts,
  'can_edit': instance.canEdit,
  'can_delete': instance.canDelete,
  'can_remove_allowed_users': instance.canRemoveAllowedUsers,
  'can_invite_to': instance.canInviteTo,
  'can_invite_via_email': instance.canInviteViaEmail,
  'can_create_post': instance.canCreatePost,
  'can_reply_as_new_topic': instance.canReplyAsNewTopic,
  'can_flag_topic': instance.canFlagTopic,
  'can_convert_topic': instance.canConvertTopic,
  'can_review_topic': instance.canReviewTopic,
  'can_close_topic': instance.canCloseTopic,
  'can_archive_topic': instance.canArchiveTopic,
  'can_split_merge_topic': instance.canSplitMergeTopic,
  'can_edit_staff_notes': instance.canEditStaffNotes,
  'can_toggle_topic_visibility': instance.canToggleTopicVisibility,
  'can_pin_unpin_topic': instance.canPinUnpinTopic,
  'can_moderate_category': instance.canModerateCategory,
  'can_remove_self_id': instance.canRemoveSelfId,
  'participants': instance.participants,
  'created_by': instance.createdBy,
  'last_poster': instance.lastPoster,
  'allowed_users': instance.allowedUsers,
  'allowed_groups': instance.allowedGroups,
};

_$DiscourseCreatedByImpl _$$DiscourseCreatedByImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseCreatedByImpl(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
);

Map<String, dynamic> _$$DiscourseCreatedByImplToJson(
  _$DiscourseCreatedByImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'name': instance.name,
  'avatar_template': instance.avatarTemplate,
};
