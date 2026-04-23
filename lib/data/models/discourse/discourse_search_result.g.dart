// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscourseSearchResultResponseImpl
_$$DiscourseSearchResultResponseImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseSearchResultResponseImpl(
  posts:
      (json['posts'] as List<dynamic>?)
          ?.map((e) => DiscourseSearchPost.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  topics:
      (json['topics'] as List<dynamic>?)
          ?.map((e) => DiscourseSearchTopic.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  users:
      (json['users'] as List<dynamic>?)
          ?.map((e) => DiscourseSearchUser.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map(
            (e) => DiscourseSearchCategory.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)
          ?.map((e) => DiscourseSearchTag.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  groups:
      (json['groups'] as List<dynamic>?)
          ?.map((e) => DiscourseSearchGroup.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  groupedSearchResult: json['grouped_search_result'] == null
      ? null
      : DiscourseGroupedSearchResult.fromJson(
          json['grouped_search_result'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$DiscourseSearchResultResponseImplToJson(
  _$DiscourseSearchResultResponseImpl instance,
) => <String, dynamic>{
  'posts': instance.posts,
  'topics': instance.topics,
  'users': instance.users,
  'categories': instance.categories,
  'tags': instance.tags,
  'groups': instance.groups,
  'grouped_search_result': instance.groupedSearchResult,
};

_$DiscourseSearchPostImpl _$$DiscourseSearchPostImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseSearchPostImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String?,
  username: json['username'] as String,
  avatarTemplate: json['avatar_template'] as String,
  createdAt: json['created_at'] as String,
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  blurb: json['blurb'] as String?,
  postNumber: (json['post_number'] as num).toInt(),
  topicId: (json['topic_id'] as num).toInt(),
  topicTitle: json['topic_title'] as String?,
  topicSlug: json['topic_slug'] as String?,
  categoryId: (json['category_id'] as num?)?.toInt(),
  categoryName: json['category_name'] as String?,
  categorySlug: json['category_slug'] as String?,
  categoryColor: json['category_color'] as String?,
  categoryTextColor: json['category_text_color'] as String?,
);

Map<String, dynamic> _$$DiscourseSearchPostImplToJson(
  _$DiscourseSearchPostImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'username': instance.username,
  'avatar_template': instance.avatarTemplate,
  'created_at': instance.createdAt,
  'like_count': instance.likeCount,
  'blurb': instance.blurb,
  'post_number': instance.postNumber,
  'topic_id': instance.topicId,
  'topic_title': instance.topicTitle,
  'topic_slug': instance.topicSlug,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'category_slug': instance.categorySlug,
  'category_color': instance.categoryColor,
  'category_text_color': instance.categoryTextColor,
};

_$DiscourseSearchTopicImpl _$$DiscourseSearchTopicImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseSearchTopicImpl(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  fancyTitle: json['fancy_title'] as String?,
  slug: json['slug'] as String,
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
  visible: json['visible'] as bool? ?? true,
  closed: json['closed'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
  bookmarked: json['bookmarked'] as bool? ?? false,
  liked: json['liked'] as bool? ?? false,
  views: (json['views'] as num?)?.toInt() ?? 0,
  likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
  categoryId: (json['category_id'] as num).toInt(),
  categoryName: json['category_name'] as String?,
  categorySlug: json['category_slug'] as String?,
  categoryColor: json['category_color'] as String?,
  categoryTextColor: json['category_text_color'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$$DiscourseSearchTopicImplToJson(
  _$DiscourseSearchTopicImpl instance,
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
  'bumped': instance.bumped,
  'bumped_at': instance.bumpedAt,
  'archetype': instance.archetype,
  'unseen': instance.unseen,
  'pinned': instance.pinned,
  'visible': instance.visible,
  'closed': instance.closed,
  'archived': instance.archived,
  'bookmarked': instance.bookmarked,
  'liked': instance.liked,
  'views': instance.views,
  'like_count': instance.likeCount,
  'category_id': instance.categoryId,
  'category_name': instance.categoryName,
  'category_slug': instance.categorySlug,
  'category_color': instance.categoryColor,
  'category_text_color': instance.categoryTextColor,
  'tags': instance.tags,
};

_$DiscourseSearchUserImpl _$$DiscourseSearchUserImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseSearchUserImpl(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  name: json['name'] as String?,
  avatarTemplate: json['avatar_template'] as String,
);

Map<String, dynamic> _$$DiscourseSearchUserImplToJson(
  _$DiscourseSearchUserImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'name': instance.name,
  'avatar_template': instance.avatarTemplate,
};

_$DiscourseSearchCategoryImpl _$$DiscourseSearchCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseSearchCategoryImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  color: json['color'] as String? ?? '0088CC',
  textColor: json['text_color'] as String? ?? 'FFFFFF',
  slug: json['slug'] as String,
  topicCount: (json['topic_count'] as num?)?.toInt() ?? 0,
  postCount: (json['post_count'] as num?)?.toInt() ?? 0,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$DiscourseSearchCategoryImplToJson(
  _$DiscourseSearchCategoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'text_color': instance.textColor,
  'slug': instance.slug,
  'topic_count': instance.topicCount,
  'post_count': instance.postCount,
  'description': instance.description,
};

_$DiscourseSearchTagImpl _$$DiscourseSearchTagImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseSearchTagImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  topicCount: (json['topic_count'] as num?)?.toInt() ?? 0,
  pmCount: (json['pm_count'] as num?)?.toInt() ?? 0,
  description: json['description'] as String?,
);

Map<String, dynamic> _$$DiscourseSearchTagImplToJson(
  _$DiscourseSearchTagImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'topic_count': instance.topicCount,
  'pm_count': instance.pmCount,
  'description': instance.description,
};

_$DiscourseSearchGroupImpl _$$DiscourseSearchGroupImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseSearchGroupImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  fullName: json['full_name'] as String?,
  userCount: (json['user_count'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$DiscourseSearchGroupImplToJson(
  _$DiscourseSearchGroupImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'full_name': instance.fullName,
  'user_count': instance.userCount,
};

_$DiscourseGroupedSearchResultImpl _$$DiscourseGroupedSearchResultImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseGroupedSearchResultImpl(
  morePosts: json['more_posts'] as bool?,
  moreUsers: json['more_users'] as bool?,
  moreCategories: json['more_categories'] as bool?,
  moreTags: json['more_tags'] as bool?,
  term: json['term'] as String?,
  searchLogId: (json['search_log_id'] as num?)?.toInt(),
  moreFullPageResults: json['more_full_page_results'] as bool?,
  canCreateTopic: json['can_create_topic'] as bool?,
  error: json['error'] as String?,
  postIds:
      (json['post_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  userIds:
      (json['user_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  categoryIds:
      (json['category_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  tagIds:
      (json['tag_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  groupIds:
      (json['group_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscourseGroupedSearchResultImplToJson(
  _$DiscourseGroupedSearchResultImpl instance,
) => <String, dynamic>{
  'more_posts': instance.morePosts,
  'more_users': instance.moreUsers,
  'more_categories': instance.moreCategories,
  'more_tags': instance.moreTags,
  'term': instance.term,
  'search_log_id': instance.searchLogId,
  'more_full_page_results': instance.moreFullPageResults,
  'can_create_topic': instance.canCreateTopic,
  'error': instance.error,
  'post_ids': instance.postIds,
  'user_ids': instance.userIds,
  'category_ids': instance.categoryIds,
  'tag_ids': instance.tagIds,
  'group_ids': instance.groupIds,
};
