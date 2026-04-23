// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ForumTopicImpl _$$ForumTopicImplFromJson(Map<String, dynamic> json) =>
    _$ForumTopicImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String? ?? '',
      excerpt: json['excerpt'] as String?,
      author: json['author'] == null
          ? null
          : ForumAuthor.fromJson(json['author'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : ForumCategory.fromJson(json['category'] as Map<String, dynamic>),
      tags:
          (json['tags'] as List<dynamic>?)
              ?.map((e) => ForumTag.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      replyCount: (json['reply_count'] as num?)?.toInt() ?? 0,
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String?,
      isPinned: json['is_pinned'] as bool? ?? false,
      isFeatured: json['is_featured'] as bool? ?? false,
      lastReplyAt: json['last_reply_at'] as String?,
      lastReplyAuthor: json['last_reply_author'] == null
          ? null
          : ForumAuthor.fromJson(
              json['last_reply_author'] as Map<String, dynamic>,
            ),
      coverImage: json['cover_image'] as String?,
    );

Map<String, dynamic> _$$ForumTopicImplToJson(_$ForumTopicImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'excerpt': instance.excerpt,
      'author': instance.author,
      'category': instance.category,
      'tags': instance.tags,
      'vote_count': instance.voteCount,
      'reply_count': instance.replyCount,
      'view_count': instance.viewCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_pinned': instance.isPinned,
      'is_featured': instance.isFeatured,
      'last_reply_at': instance.lastReplyAt,
      'last_reply_author': instance.lastReplyAuthor,
      'cover_image': instance.coverImage,
    };

_$ForumAuthorImpl _$$ForumAuthorImplFromJson(Map<String, dynamic> json) =>
    _$ForumAuthorImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      level: (json['level'] as num?)?.toInt() ?? 1,
      isAdmin: json['is_admin'] as bool? ?? false,
      isModerator: json['is_moderator'] as bool? ?? false,
    );

Map<String, dynamic> _$$ForumAuthorImplToJson(_$ForumAuthorImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'display_name': instance.displayName,
      'avatar_url': instance.avatarUrl,
      'level': instance.level,
      'is_admin': instance.isAdmin,
      'is_moderator': instance.isModerator,
    };

_$ForumCategoryImpl _$$ForumCategoryImplFromJson(Map<String, dynamic> json) =>
    _$ForumCategoryImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      topicCount: (json['topic_count'] as num?)?.toInt() ?? 0,
      displayOrder: (json['display_order'] as num?)?.toInt() ?? 0,
      parentId: json['parent_id'] as String?,
    );

Map<String, dynamic> _$$ForumCategoryImplToJson(_$ForumCategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'description': instance.description,
      'icon': instance.icon,
      'color': instance.color,
      'topic_count': instance.topicCount,
      'display_order': instance.displayOrder,
      'parent_id': instance.parentId,
    };

_$ForumTagImpl _$$ForumTagImplFromJson(Map<String, dynamic> json) =>
    _$ForumTagImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      color: json['color'] as String?,
      topicCount: (json['topic_count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ForumTagImplToJson(_$ForumTagImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'color': instance.color,
      'topic_count': instance.topicCount,
    };

_$ForumReplyImpl _$$ForumReplyImplFromJson(Map<String, dynamic> json) =>
    _$ForumReplyImpl(
      id: json['id'] as String,
      topicId: json['topic_id'] as String,
      content: json['content'] as String,
      author: json['author'] == null
          ? null
          : ForumAuthor.fromJson(json['author'] as Map<String, dynamic>),
      parentId: json['parent_id'] as String?,
      voteCount: (json['vote_count'] as num?)?.toInt() ?? 0,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String?,
      isAccepted: json['is_accepted'] as bool? ?? false,
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => ForumReply.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ForumReplyImplToJson(_$ForumReplyImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic_id': instance.topicId,
      'content': instance.content,
      'author': instance.author,
      'parent_id': instance.parentId,
      'vote_count': instance.voteCount,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'is_accepted': instance.isAccepted,
      'replies': instance.replies,
    };

_$ForumTopicListResponseImpl _$$ForumTopicListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForumTopicListResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ForumTopic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  perPage: (json['per_page'] as num?)?.toInt() ?? 20,
  hasMore: json['has_more'] as bool? ?? false,
);

Map<String, dynamic> _$$ForumTopicListResponseImplToJson(
  _$ForumTopicListResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'page': instance.page,
  'per_page': instance.perPage,
  'has_more': instance.hasMore,
};

_$ForumTopicDetailResponseImpl _$$ForumTopicDetailResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForumTopicDetailResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data: json['data'] == null
      ? null
      : ForumTopic.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$ForumTopicDetailResponseImplToJson(
  _$ForumTopicDetailResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$ForumReplyListResponseImpl _$$ForumReplyListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForumReplyListResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ForumReply.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  total: (json['total'] as num?)?.toInt() ?? 0,
  page: (json['page'] as num?)?.toInt() ?? 1,
  hasMore: json['has_more'] as bool? ?? false,
);

Map<String, dynamic> _$$ForumReplyListResponseImplToJson(
  _$ForumReplyListResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
  'total': instance.total,
  'page': instance.page,
  'has_more': instance.hasMore,
};

_$ForumCategoryListResponseImpl _$$ForumCategoryListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForumCategoryListResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ForumCategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ForumCategoryListResponseImplToJson(
  _$ForumCategoryListResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

_$ForumTagListResponseImpl _$$ForumTagListResponseImplFromJson(
  Map<String, dynamic> json,
) => _$ForumTagListResponseImpl(
  status: (json['status'] as num).toInt(),
  message: json['message'] as String? ?? '',
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => ForumTag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$ForumTagListResponseImplToJson(
  _$ForumTagListResponseImpl instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};
