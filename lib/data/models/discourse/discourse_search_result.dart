import 'package:freezed_annotation/freezed_annotation.dart';


part 'discourse_search_result.freezed.dart';
part 'discourse_search_result.g.dart';

/// Discourse 搜索结果响应模型
@freezed
class DiscourseSearchResultResponse with _$DiscourseSearchResultResponse {
  const factory DiscourseSearchResultResponse({
    @JsonKey(name: 'posts') @Default([]) List<DiscourseSearchPost> posts,
    @JsonKey(name: 'topics') @Default([]) List<DiscourseSearchTopic> topics,
    @JsonKey(name: 'users') @Default([]) List<DiscourseSearchUser> users,
    @JsonKey(name: 'categories') @Default([]) List<DiscourseSearchCategory> categories,
    @JsonKey(name: 'tags') @Default([]) List<DiscourseSearchTag> tags,
    @JsonKey(name: 'groups') @Default([]) List<DiscourseSearchGroup> groups,
    @JsonKey(name: 'grouped_search_result') DiscourseGroupedSearchResult? groupedSearchResult,
  }) = _DiscourseSearchResultResponse;

  factory DiscourseSearchResultResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscourseSearchResultResponseFromJson(json);
}

/// Discourse 搜索结果帖子模型
@freezed
class DiscourseSearchPost with _$DiscourseSearchPost {
  const factory DiscourseSearchPost({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'blurb') String? blurb,
    @JsonKey(name: 'post_number') required int postNumber,
    @JsonKey(name: 'topic_id') required int topicId,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_text_color') String? categoryTextColor,
  }) = _DiscourseSearchPost;

  factory DiscourseSearchPost.fromJson(Map<String, dynamic> json) =>
      _$DiscourseSearchPostFromJson(json);
}

/// Discourse 搜索结果话题模型
@freezed
class DiscourseSearchTopic with _$DiscourseSearchTopic {
  const factory DiscourseSearchTopic({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'posts_count') @Default(0) int postsCount,
    @JsonKey(name: 'reply_count') @Default(0) int replyCount,
    @JsonKey(name: 'highest_post_number') @Default(0) int highestPostNumber,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'bumped') @Default(false) bool bumped,
    @JsonKey(name: 'bumped_at') String? bumpedAt,
    @JsonKey(name: 'archetype') @Default('regular') String archetype,
    @JsonKey(name: 'unseen') @Default(false) bool unseen,
    @JsonKey(name: 'pinned') @Default(false) bool pinned,
    @JsonKey(name: 'visible') @Default(true) bool visible,
    @JsonKey(name: 'closed') @Default(false) bool closed,
    @JsonKey(name: 'archived') @Default(false) bool archived,
    @JsonKey(name: 'bookmarked') @Default(false) bool bookmarked,
    @JsonKey(name: 'liked') @Default(false) bool liked,
    @JsonKey(name: 'views') @Default(0) int views,
    @JsonKey(name: 'like_count') @Default(0) int likeCount,
    @JsonKey(name: 'category_id') required int categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_text_color') String? categoryTextColor,
    @JsonKey(name: 'tags') @Default([]) List<String> tags,
  }) = _DiscourseSearchTopic;

  factory DiscourseSearchTopic.fromJson(Map<String, dynamic> json) =>
      _$DiscourseSearchTopicFromJson(json);
}

/// Discourse 搜索结果用户模型
@freezed
class DiscourseSearchUser with _$DiscourseSearchUser {
  const factory DiscourseSearchUser({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') required String avatarTemplate,
  }) = _DiscourseSearchUser;

  factory DiscourseSearchUser.fromJson(Map<String, dynamic> json) =>
      _$DiscourseSearchUserFromJson(json);
}

/// Discourse 搜索结果分类模型
@freezed
class DiscourseSearchCategory with _$DiscourseSearchCategory {
  const factory DiscourseSearchCategory({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'color') @Default('0088CC') String color,
    @JsonKey(name: 'text_color') @Default('FFFFFF') String textColor,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'topic_count') @Default(0) int topicCount,
    @JsonKey(name: 'post_count') @Default(0) int postCount,
    @JsonKey(name: 'description') String? description,
  }) = _DiscourseSearchCategory;

  factory DiscourseSearchCategory.fromJson(Map<String, dynamic> json) =>
      _$DiscourseSearchCategoryFromJson(json);
}

/// Discourse 搜索结果标签模型
@freezed
class DiscourseSearchTag with _$DiscourseSearchTag {
  const factory DiscourseSearchTag({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'topic_count') @Default(0) int topicCount,
    @JsonKey(name: 'pm_count') @Default(0) int pmCount,
    @JsonKey(name: 'description') String? description,
  }) = _DiscourseSearchTag;

  factory DiscourseSearchTag.fromJson(Map<String, dynamic> json) =>
      _$DiscourseSearchTagFromJson(json);
}

/// Discourse 搜索结果群组模型
@freezed
class DiscourseSearchGroup with _$DiscourseSearchGroup {
  const factory DiscourseSearchGroup({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'user_count') @Default(0) int userCount,
  }) = _DiscourseSearchGroup;

  factory DiscourseSearchGroup.fromJson(Map<String, dynamic> json) =>
      _$DiscourseSearchGroupFromJson(json);
}

/// Discourse 分组搜索结果模型
@freezed
class DiscourseGroupedSearchResult with _$DiscourseGroupedSearchResult {
  const factory DiscourseGroupedSearchResult({
    @JsonKey(name: 'more_posts') bool? morePosts,
    @JsonKey(name: 'more_users') bool? moreUsers,
    @JsonKey(name: 'more_categories') bool? moreCategories,
    @JsonKey(name: 'more_tags') bool? moreTags,
    @JsonKey(name: 'term') String? term,
    @JsonKey(name: 'search_log_id') int? searchLogId,
    @JsonKey(name: 'more_full_page_results') bool? moreFullPageResults,
    @JsonKey(name: 'can_create_topic') bool? canCreateTopic,
    @JsonKey(name: 'error') String? error,
    @JsonKey(name: 'post_ids') @Default([]) List<int> postIds,
    @JsonKey(name: 'user_ids') @Default([]) List<int> userIds,
    @JsonKey(name: 'category_ids') @Default([]) List<int> categoryIds,
    @JsonKey(name: 'tag_ids') @Default([]) List<int> tagIds,
    @JsonKey(name: 'group_ids') @Default([]) List<int> groupIds,
  }) = _DiscourseGroupedSearchResult;

  factory DiscourseGroupedSearchResult.fromJson(Map<String, dynamic> json) =>
      _$DiscourseGroupedSearchResultFromJson(json);
}
