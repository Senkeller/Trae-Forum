// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscoursePostImpl _$$DiscoursePostImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePostImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  username: json['username'] as String,
  avatarTemplate: json['avatar_template'] as String,
  createdAt: json['created_at'] as String,
  cooked: json['cooked'] as String?,
  raw: json['raw'] as String?,
  postNumber: _postNumberFromJson(json['post_number']),
  postType: (json['post_type'] as num?)?.toInt() ?? 1,
  updatedAt: json['updated_at'] as String?,
  replyCount: (json['reply_count'] as num?)?.toInt() ?? 0,
  replyToPostNumber: _replyToPostNumberFromJson(json['reply_to_post_number']),
  quoteCount: (json['quote_count'] as num?)?.toInt() ?? 0,
  incomingLinkCount: (json['incoming_link_count'] as num?)?.toInt() ?? 0,
  reads: (json['reads'] as num?)?.toInt() ?? 0,
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  readersCount: (json['readers_count'] as num?)?.toInt() ?? 0,
  score: (json['score'] as num?)?.toDouble(),
  yours: json['yours'] as bool? ?? false,
  topicId: (json['topic_id'] as num).toInt(),
  topicSlug: json['topic_slug'] as String?,
  displayUsername: json['display_username'] as String?,
  primaryGroupName: json['primary_group_name'] as String?,
  flairName: json['flair_name'] as String?,
  flairUrl: json['flair_url'] as String?,
  flairBgColor: json['flair_bg_color'] as String?,
  flairColor: json['flair_color'] as String?,
  version: (json['version'] as num?)?.toInt() ?? 1,
  canEdit: json['can_edit'] as bool? ?? false,
  canDelete: json['can_delete'] as bool? ?? false,
  canRecover: json['can_recover'] as bool? ?? false,
  canSeeHiddenPost: json['can_see_hidden_post'] as bool? ?? false,
  canWiki: json['can_wiki'] as bool? ?? false,
  linkCounts:
      (json['link_counts'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  actionsSummary:
      (json['actions_summary'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  moderator: json['moderator'] as bool? ?? false,
  admin: json['admin'] as bool? ?? false,
  staff: json['staff'] as bool? ?? false,
  userId: (json['user_id'] as num?)?.toInt(),
  hidden: json['hidden'] as bool? ?? false,
  trustLevel: (json['trust_level'] as num?)?.toInt() ?? 0,
  deletedAt: json['deleted_at'] as String?,
  userDeleted: json['user_deleted'] as bool? ?? false,
  editReason: json['edit_reason'] as String?,
  canViewEditHistory: json['can_view_edit_history'] as bool? ?? false,
  wiki: json['wiki'] as bool? ?? false,
  reviewableId: (json['reviewable_id'] as num?)?.toInt(),
  reviewableScoreCount: (json['reviewable_score_count'] as num?)?.toInt(),
  reviewableScorePendingCount: (json['reviewable_score_pending_count'] as num?)
      ?.toInt(),
  mentionedUsers:
      (json['mentioned_users'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  reactions:
      (json['reactions'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  currentUserReaction: json['current_user_reaction'] as Map<String, dynamic>?,
  reactionUsersCount: (json['reaction_users_count'] as num?)?.toInt(),
  bookmarked: json['bookmarked'] as bool? ?? false,
  bookmarkedAt: json['bookmarked_at'] as String?,
);

Map<String, dynamic> _$$DiscoursePostImplToJson(_$DiscoursePostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'avatar_template': instance.avatarTemplate,
      'created_at': instance.createdAt,
      'cooked': instance.cooked,
      'raw': instance.raw,
      'post_number': instance.postNumber,
      'post_type': instance.postType,
      'updated_at': instance.updatedAt,
      'reply_count': instance.replyCount,
      'reply_to_post_number': instance.replyToPostNumber,
      'quote_count': instance.quoteCount,
      'incoming_link_count': instance.incomingLinkCount,
      'reads': instance.reads,
      'like_count': instance.likeCount,
      'readers_count': instance.readersCount,
      'score': instance.score,
      'yours': instance.yours,
      'topic_id': instance.topicId,
      'topic_slug': instance.topicSlug,
      'display_username': instance.displayUsername,
      'primary_group_name': instance.primaryGroupName,
      'flair_name': instance.flairName,
      'flair_url': instance.flairUrl,
      'flair_bg_color': instance.flairBgColor,
      'flair_color': instance.flairColor,
      'version': instance.version,
      'can_edit': instance.canEdit,
      'can_delete': instance.canDelete,
      'can_recover': instance.canRecover,
      'can_see_hidden_post': instance.canSeeHiddenPost,
      'can_wiki': instance.canWiki,
      'link_counts': instance.linkCounts,
      'actions_summary': instance.actionsSummary,
      'moderator': instance.moderator,
      'admin': instance.admin,
      'staff': instance.staff,
      'user_id': instance.userId,
      'hidden': instance.hidden,
      'trust_level': instance.trustLevel,
      'deleted_at': instance.deletedAt,
      'user_deleted': instance.userDeleted,
      'edit_reason': instance.editReason,
      'can_view_edit_history': instance.canViewEditHistory,
      'wiki': instance.wiki,
      'reviewable_id': instance.reviewableId,
      'reviewable_score_count': instance.reviewableScoreCount,
      'reviewable_score_pending_count': instance.reviewableScorePendingCount,
      'mentioned_users': instance.mentionedUsers,
      'reactions': instance.reactions,
      'current_user_reaction': instance.currentUserReaction,
      'reaction_users_count': instance.reactionUsersCount,
      'bookmarked': instance.bookmarked,
      'bookmarked_at': instance.bookmarkedAt,
    };

_$DiscoursePostStreamImpl _$$DiscoursePostStreamImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePostStreamImpl(
  posts:
      (json['posts'] as List<dynamic>?)
          ?.map((e) => DiscoursePost.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  stream:
      (json['stream'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscoursePostStreamImplToJson(
  _$DiscoursePostStreamImpl instance,
) => <String, dynamic>{'posts': instance.posts, 'stream': instance.stream};

_$DiscoursePostListResponseImpl _$$DiscoursePostListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscoursePostListResponseImpl(
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

Map<String, dynamic> _$$DiscoursePostListResponseImplToJson(
  _$DiscoursePostListResponseImpl instance,
) => <String, dynamic>{
  'post_stream': instance.postStream,
  'timeline_lookup': instance.timelineLookup,
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
