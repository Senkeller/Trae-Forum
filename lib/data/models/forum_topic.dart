import 'package:freezed_annotation/freezed_annotation.dart';

part 'forum_topic.freezed.dart';
part 'forum_topic.g.dart';

/// 论坛话题/帖子模型
/// 
/// 用于表示论坛中的一个话题或帖子
@freezed
class ForumTopic with _$ForumTopic {
  /// 构造函数
  /// 
  /// [id] 话题ID
  /// [title] 话题标题
  /// [content] 话题内容（摘要或完整内容）
  /// [author] 作者信息
  /// [category] 所属分类
  /// [tags] 标签列表
  /// [voteCount] 投票数/点赞数
  /// [replyCount] 回复数
  /// [viewCount] 浏览量
  /// [createdAt] 创建时间
  /// [updatedAt] 更新时间
  /// [isPinned] 是否置顶
  /// [isFeatured] 是否精华/推荐
  /// [lastReplyAt] 最后回复时间
  /// [lastReplyAuthor] 最后回复者
  const factory ForumTopic({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'content') @Default('') String content,
    @JsonKey(name: 'excerpt') String? excerpt,
    @JsonKey(name: 'author') ForumAuthor? author,
    @JsonKey(name: 'category') ForumCategory? category,
    @JsonKey(name: 'tags') @Default([]) List<ForumTag> tags,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @JsonKey(name: 'reply_count') @Default(0) int replyCount,
    @JsonKey(name: 'view_count') @Default(0) int viewCount,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_pinned') @Default(false) bool isPinned,
    @JsonKey(name: 'is_featured') @Default(false) bool isFeatured,
    @JsonKey(name: 'last_reply_at') String? lastReplyAt,
    @JsonKey(name: 'last_reply_author') ForumAuthor? lastReplyAuthor,
    @JsonKey(name: 'cover_image') String? coverImage,
  }) = _ForumTopic;

  /// 从JSON解析话题对象
  /// 
  /// [json] JSON数据
  /// @return ForumTopic实例
  factory ForumTopic.fromJson(Map<String, dynamic> json) =>
      _$ForumTopicFromJson(json);
}

/// 论坛作者模型
/// 
/// 用于表示话题或回复的作者信息
@freezed
class ForumAuthor with _$ForumAuthor {
  /// 构造函数
  /// 
  /// [id] 用户ID
  /// [username] 用户名
  /// [displayName] 显示名称
  /// [avatarUrl] 头像URL
  /// [level] 用户等级
  /// [isAdmin] 是否管理员
  /// [isModerator] 是否版主
  const factory ForumAuthor({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'username') required String username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'level') @Default(1) int level,
    @JsonKey(name: 'is_admin') @Default(false) bool isAdmin,
    @JsonKey(name: 'is_moderator') @Default(false) bool isModerator,
  }) = _ForumAuthor;

  /// 从JSON解析作者对象
  /// 
  /// [json] JSON数据
  /// @return ForumAuthor实例
  factory ForumAuthor.fromJson(Map<String, dynamic> json) =>
      _$ForumAuthorFromJson(json);
}

/// 论坛分类模型
/// 
/// 用于表示论坛的分类/板块
@freezed
class ForumCategory with _$ForumCategory {
  /// 构造函数
  /// 
  /// [id] 分类ID
  /// [name] 分类名称
  /// [slug] 分类别名（URL用）
  /// [description] 分类描述
  /// [icon] 分类图标
  /// [color] 分类颜色
  /// [topicCount] 话题数量
  /// [displayOrder] 显示顺序
  /// [parentId] 父分类ID
  const factory ForumCategory({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'icon') String? icon,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'topic_count') @Default(0) int topicCount,
    @JsonKey(name: 'display_order') @Default(0) int displayOrder,
    @JsonKey(name: 'parent_id') String? parentId,
  }) = _ForumCategory;

  /// 从JSON解析分类对象
  /// 
  /// [json] JSON数据
  /// @return ForumCategory实例
  factory ForumCategory.fromJson(Map<String, dynamic> json) =>
      _$ForumCategoryFromJson(json);
}

/// 论坛标签模型
/// 
/// 用于表示话题的标签
@freezed
class ForumTag with _$ForumTag {
  /// 构造函数
  /// 
  /// [id] 标签ID
  /// [name] 标签名称
  /// [slug] 标签别名
  /// [color] 标签颜色
  /// [topicCount] 话题数量
  const factory ForumTag({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'topic_count') @Default(0) int topicCount,
  }) = _ForumTag;

  /// 从JSON解析标签对象
  /// 
  /// [json] JSON数据
  /// @return ForumTag实例
  factory ForumTag.fromJson(Map<String, dynamic> json) =>
      _$ForumTagFromJson(json);
}

/// 论坛回复模型
/// 
/// 用于表示话题的回复/评论
@freezed
class ForumReply with _$ForumReply {
  /// 构造函数
  /// 
  /// [id] 回复ID
  /// [topicId] 所属话题ID
  /// [content] 回复内容
  /// [author] 作者信息
  /// [parentId] 父回复ID（楼中楼）
  /// [voteCount] 点赞数
  /// [createdAt] 创建时间
  /// [updatedAt] 更新时间
  /// [isAccepted] 是否被采纳为最佳答案
  const factory ForumReply({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'topic_id') required String topicId,
    @JsonKey(name: 'content') required String content,
    @JsonKey(name: 'author') ForumAuthor? author,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'vote_count') @Default(0) int voteCount,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_accepted') @Default(false) bool isAccepted,
    @JsonKey(name: 'replies') @Default([]) List<ForumReply> replies,
  }) = _ForumReply;

  /// 从JSON解析回复对象
  /// 
  /// [json] JSON数据
  /// @return ForumReply实例
  factory ForumReply.fromJson(Map<String, dynamic> json) =>
      _$ForumReplyFromJson(json);
}

/// 话题列表响应模型
@freezed
class ForumTopicListResponse with _$ForumTopicListResponse {
  const factory ForumTopicListResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<ForumTopic> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'page') @Default(1) int page,
    @JsonKey(name: 'per_page') @Default(20) int perPage,
    @JsonKey(name: 'has_more') @Default(false) bool hasMore,
  }) = _ForumTopicListResponse;

  factory ForumTopicListResponse.fromJson(Map<String, dynamic> json) =>
      _$ForumTopicListResponseFromJson(json);
}

/// 话题详情响应模型
@freezed
class ForumTopicDetailResponse with _$ForumTopicDetailResponse {
  const factory ForumTopicDetailResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') ForumTopic? data,
  }) = _ForumTopicDetailResponse;

  factory ForumTopicDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$ForumTopicDetailResponseFromJson(json);
}

/// 回复列表响应模型
@freezed
class ForumReplyListResponse with _$ForumReplyListResponse {
  const factory ForumReplyListResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<ForumReply> data,
    @JsonKey(name: 'total') @Default(0) int total,
    @JsonKey(name: 'page') @Default(1) int page,
    @JsonKey(name: 'has_more') @Default(false) bool hasMore,
  }) = _ForumReplyListResponse;

  factory ForumReplyListResponse.fromJson(Map<String, dynamic> json) =>
      _$ForumReplyListResponseFromJson(json);
}

/// 分类列表响应模型
@freezed
class ForumCategoryListResponse with _$ForumCategoryListResponse {
  const factory ForumCategoryListResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<ForumCategory> data,
  }) = _ForumCategoryListResponse;

  factory ForumCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$ForumCategoryListResponseFromJson(json);
}

/// 标签列表响应模型
@freezed
class ForumTagListResponse with _$ForumTagListResponse {
  const factory ForumTagListResponse({
    @JsonKey(name: 'status') required int status,
    @JsonKey(name: 'message') @Default('') String message,
    @JsonKey(name: 'data') @Default([]) List<ForumTag> data,
  }) = _ForumTagListResponse;

  factory ForumTagListResponse.fromJson(Map<String, dynamic> json) =>
      _$ForumTagListResponseFromJson(json);
}
