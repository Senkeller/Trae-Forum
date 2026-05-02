// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_private_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscoursePrivateMessageImpl _$$DiscoursePrivateMessageImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePrivateMessageImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  fancyTitle: json['fancy_title'] as String?,
  slug: json['slug'] as String,
  postsCount: (json['posts_count'] as num?)?.toInt() ?? 0,
  replyCount: (json['reply_count'] as num?)?.toInt() ?? 0,
  highestPostNumber: (json['highest_post_number'] as num?)?.toInt() ?? 0,
  createdAt: json['created_at'] as String,
  lastPostedAt: json['last_posted_at'] as String?,
  bumpedAt: json['bumped_at'] as String?,
  unseen: json['unseen'] as bool? ?? false,
  unreadPosts: (json['unread_posts'] as num?)?.toInt() ?? 0,
  lastReadPostNumber: (json['last_read_post_number'] as num?)?.toInt() ?? 0,
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => DiscourseParticipant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  allowedUsers:
      (json['allowed_users'] as List<dynamic>?)
          ?.map((e) => DiscourseUserBasic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  imageUrl: json['image_url'] as String?,
  excerpt: json['excerpt'] as String?,
  closed: json['closed'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
);

Map<String, dynamic> _$$DiscoursePrivateMessageImplToJson(
  _$DiscoursePrivateMessageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'fancy_title': instance.fancyTitle,
  'slug': instance.slug,
  'posts_count': instance.postsCount,
  'reply_count': instance.replyCount,
  'highest_post_number': instance.highestPostNumber,
  'created_at': instance.createdAt,
  'last_posted_at': instance.lastPostedAt,
  'bumped_at': instance.bumpedAt,
  'unseen': instance.unseen,
  'unread_posts': instance.unreadPosts,
  'last_read_post_number': instance.lastReadPostNumber,
  'participants': instance.participants,
  'allowed_users': instance.allowedUsers,
  'image_url': instance.imageUrl,
  'excerpt': instance.excerpt,
  'closed': instance.closed,
  'archived': instance.archived,
};

_$DiscoursePrivateMessageListResponseImpl
_$$DiscoursePrivateMessageListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePrivateMessageListResponseImpl(
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
      : DiscoursePrivateMessageList.fromJson(
          json['topic_list'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$DiscoursePrivateMessageListResponseImplToJson(
  _$DiscoursePrivateMessageListResponseImpl instance,
) => <String, dynamic>{
  'users': instance.users,
  'primary_groups': instance.primaryGroups,
  'flair_groups': instance.flairGroups,
  'topic_list': instance.topicList,
};

_$DiscoursePrivateMessageListImpl _$$DiscoursePrivateMessageListImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePrivateMessageListImpl(
  canCreateTopic: json['can_create_topic'] as bool? ?? false,
  moreTopicsUrl: json['more_topics_url'] as String?,
  perPage: (json['per_page'] as num?)?.toInt() ?? 30,
  topics:
      (json['topics'] as List<dynamic>?)
          ?.map(
            (e) => DiscoursePrivateMessage.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscoursePrivateMessageListImplToJson(
  _$DiscoursePrivateMessageListImpl instance,
) => <String, dynamic>{
  'can_create_topic': instance.canCreateTopic,
  'more_topics_url': instance.moreTopicsUrl,
  'per_page': instance.perPage,
  'topics': instance.topics,
};

_$DiscoursePrivateMessageDetailResponseImpl
_$$DiscoursePrivateMessageDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePrivateMessageDetailResponseImpl(
  postStream: json['post_stream'] == null
      ? null
      : DiscoursePostStream.fromJson(
          json['post_stream'] as Map<String, dynamic>,
        ),
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
  details: json['details'] == null
      ? null
      : DiscourseTopicDetails.fromJson(json['details'] as Map<String, dynamic>),
  highestPostNumber: (json['highest_post_number'] as num?)?.toInt(),
  lastReadPostNumber: (json['last_read_post_number'] as num?)?.toInt(),
  unreadPosts: (json['unread_posts'] as num?)?.toInt(),
  actionsSummary:
      (json['actions_summary'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  chunkSize: (json['chunk_size'] as num?)?.toInt(),
  bookmarked: json['bookmarked'] as bool?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => DiscourseParticipant.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  allowedUsers:
      (json['allowed_users'] as List<dynamic>?)
          ?.map((e) => DiscourseUserBasic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscoursePrivateMessageDetailResponseImplToJson(
  _$DiscoursePrivateMessageDetailResponseImpl instance,
) => <String, dynamic>{
  'post_stream': instance.postStream,
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
  'details': instance.details,
  'highest_post_number': instance.highestPostNumber,
  'last_read_post_number': instance.lastReadPostNumber,
  'unread_posts': instance.unreadPosts,
  'actions_summary': instance.actionsSummary,
  'chunk_size': instance.chunkSize,
  'bookmarked': instance.bookmarked,
  'tags': instance.tags,
  'participants': instance.participants,
  'allowed_users': instance.allowedUsers,
};

_$DiscoursePrivateMessageItemImpl _$$DiscoursePrivateMessageItemImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePrivateMessageItemImpl(
  id: (json['id'] as num).toInt(),
  topicId: (json['topic_id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
  cooked: json['cooked'] as String,
  raw: json['raw'] as String?,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String?,
  postNumber: (json['post_number'] as num).toInt(),
  replyToPostNumber: (json['reply_to_post_number'] as num?)?.toInt(),
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  reads: (json['reads'] as num?)?.toInt() ?? 0,
  readersCount: (json['readers_count'] as num?)?.toInt() ?? 0,
  version: (json['version'] as num?)?.toInt() ?? 1,
  canEdit: json['can_edit'] as bool? ?? false,
  canDelete: json['can_delete'] as bool? ?? false,
  canRecover: json['can_recover'] as bool? ?? false,
  canWiki: json['can_wiki'] as bool? ?? false,
  userTitle: json['user_title'] as String?,
  titleIsGroup: json['title_is_group'] as bool? ?? false,
  replyToUser: json['reply_to_user'] as Map<String, dynamic>?,
  actionsSummary:
      (json['actions_summary'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  moderator: json['moderator'] as bool? ?? false,
  admin: json['admin'] as bool? ?? false,
  staff: json['staff'] as bool? ?? false,
  userTrustLevel: (json['user_trust_level'] as num?)?.toInt() ?? 1,
  bookmarked: json['bookmarked'] as bool? ?? false,
);

Map<String, dynamic> _$$DiscoursePrivateMessageItemImplToJson(
  _$DiscoursePrivateMessageItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'topic_id': instance.topicId,
  'user_id': instance.userId,
  'username': instance.username,
  'name': instance.name,
  'avatar_template': instance.avatarTemplate,
  'cooked': instance.cooked,
  'raw': instance.raw,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'post_number': instance.postNumber,
  'reply_to_post_number': instance.replyToPostNumber,
  'like_count': instance.likeCount,
  'reads': instance.reads,
  'readers_count': instance.readersCount,
  'version': instance.version,
  'can_edit': instance.canEdit,
  'can_delete': instance.canDelete,
  'can_recover': instance.canRecover,
  'can_wiki': instance.canWiki,
  'user_title': instance.userTitle,
  'title_is_group': instance.titleIsGroup,
  'reply_to_user': instance.replyToUser,
  'actions_summary': instance.actionsSummary,
  'moderator': instance.moderator,
  'admin': instance.admin,
  'staff': instance.staff,
  'user_trust_level': instance.userTrustLevel,
  'bookmarked': instance.bookmarked,
};

_$PrivateMessageConversationImpl _$$PrivateMessageConversationImplFromJson(
  Map<String, dynamic> json,
) => _$PrivateMessageConversationImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  slug: json['slug'] as String,
  lastMessage: json['last_message'] as String?,
  lastPostedAt: json['last_posted_at'] as String?,
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  totalMessages: (json['total_messages'] as num?)?.toInt() ?? 0,
  participants:
      (json['participants'] as List<dynamic>?)
          ?.map((e) => DiscourseUserBasic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  otherParticipant: json['other_participant'] == null
      ? null
      : DiscourseUserBasic.fromJson(
          json['other_participant'] as Map<String, dynamic>,
        ),
  createdAt: json['created_at'] as String?,
  closed: json['closed'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
);

Map<String, dynamic> _$$PrivateMessageConversationImplToJson(
  _$PrivateMessageConversationImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'slug': instance.slug,
  'last_message': instance.lastMessage,
  'last_posted_at': instance.lastPostedAt,
  'unread_count': instance.unreadCount,
  'total_messages': instance.totalMessages,
  'participants': instance.participants,
  'other_participant': instance.otherParticipant,
  'created_at': instance.createdAt,
  'closed': instance.closed,
  'archived': instance.archived,
};

_$SendPrivateMessageResponseImpl _$$SendPrivateMessageResponseImplFromJson(
  Map<String, dynamic> json,
) => _$SendPrivateMessageResponseImpl(
  id: (json['id'] as num?)?.toInt(),
  topicId: (json['topic_id'] as num?)?.toInt(),
  topicSlug: json['topic_slug'] as String?,
  postNumber: (json['post_number'] as num?)?.toInt(),
  username: json['username'] as String?,
  cooked: json['cooked'] as String?,
  raw: json['raw'] as String?,
  createdAt: json['created_at'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
  errorType: json['error_type'] as String?,
  message: json['message'] as String?,
  success: json['success'] as bool?,
);

Map<String, dynamic> _$$SendPrivateMessageResponseImplToJson(
  _$SendPrivateMessageResponseImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'topic_id': instance.topicId,
  'topic_slug': instance.topicSlug,
  'post_number': instance.postNumber,
  'username': instance.username,
  'cooked': instance.cooked,
  'raw': instance.raw,
  'created_at': instance.createdAt,
  'errors': instance.errors,
  'error_type': instance.errorType,
  'message': instance.message,
  'success': instance.success,
};

_$PrivateMessageUnreadCountImpl _$$PrivateMessageUnreadCountImplFromJson(
  Map<String, dynamic> json,
) => _$PrivateMessageUnreadCountImpl(
  topicId: (json['topic_id'] as num).toInt(),
  unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
  highestPostNumber: (json['highest_post_number'] as num?)?.toInt() ?? 0,
  lastReadPostNumber: (json['last_read_post_number'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PrivateMessageUnreadCountImplToJson(
  _$PrivateMessageUnreadCountImpl instance,
) => <String, dynamic>{
  'topic_id': instance.topicId,
  'unread_count': instance.unreadCount,
  'highest_post_number': instance.highestPostNumber,
  'last_read_post_number': instance.lastReadPostNumber,
};

_$PrivateMessageTrackingStateResponseImpl
_$$PrivateMessageTrackingStateResponseImplFromJson(Map<String, dynamic> json) =>
    _$PrivateMessageTrackingStateResponseImpl(
      trackingStates:
          (json['private_message_topic_tracking_state'] as List<dynamic>?)
              ?.map(
                (e) => PrivateMessageUnreadCount.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PrivateMessageTrackingStateResponseImplToJson(
  _$PrivateMessageTrackingStateResponseImpl instance,
) => <String, dynamic>{
  'private_message_topic_tracking_state': instance.trackingStates,
};
