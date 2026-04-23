import 'package:freezed_annotation/freezed_annotation.dart';

part 'discourse_category.freezed.dart';
part 'discourse_category.g.dart';

/// Discourse 分类模型
///
/// 用于接收 Discourse API 返回的分类数据
@freezed
class DiscourseCategory with _$DiscourseCategory {
  /// 构造函数
  ///
  /// [id] 分类ID
  /// [name] 分类名称
  /// [color] 分类颜色（十六进制）
  /// [textColor] 文字颜色
  /// [slug] URL别名
  /// [topicCount] 话题数量
  /// [postCount] 帖子数量
  /// [position] 显示位置
  /// [description] 分类描述
  /// [descriptionText] 纯文本描述
  /// [descriptionExcerpt] 描述摘要
  /// [topicUrl] 最新话题URL
  /// [readRestricted] 是否阅读受限
  /// [permission] 权限级别
  /// [notificationLevel] 通知级别
  /// [canEdit] 是否可编辑
  /// [topicTemplate] 话题模板
  /// [hasChildren] 是否有子分类
  /// [subcategoryIds] 子分类ID列表
  /// [uploadedLogo] 上传的Logo
  /// [uploadedBackground] 上传的背景图
  const factory DiscourseCategory({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'color') @Default('0088CC') String color,
    @JsonKey(name: 'text_color') @Default('FFFFFF') String textColor,
    @JsonKey(name: 'slug') required String slug,
    @JsonKey(name: 'topic_count') @Default(0) int topicCount,
    @JsonKey(name: 'post_count') @Default(0) int postCount,
    @JsonKey(name: 'position') @Default(0) int position,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'description_text') String? descriptionText,
    @JsonKey(name: 'description_excerpt') String? descriptionExcerpt,
    @JsonKey(name: 'topic_url') String? topicUrl,
    @JsonKey(name: 'read_restricted') @Default(false) bool readRestricted,
    @JsonKey(name: 'permission') int? permission,
    @JsonKey(name: 'notification_level') @Default(1) int notificationLevel,
    @JsonKey(name: 'can_edit') @Default(false) bool canEdit,
    @JsonKey(name: 'topic_template') String? topicTemplate,
    @JsonKey(name: 'has_children') @Default(false) bool hasChildren,
    @JsonKey(name: 'subcategory_ids') @Default([]) List<int> subcategoryIds,
    @JsonKey(name: 'uploaded_logo') DiscourseUploadedImage? uploadedLogo,
    @JsonKey(name: 'uploaded_background') DiscourseUploadedImage? uploadedBackground,
    @JsonKey(name: 'parent_category_id') int? parentCategoryId,
  }) = _DiscourseCategory;

  /// 从JSON解析分类对象
  ///
  /// [json] JSON数据
  /// @return DiscourseCategory实例
  factory DiscourseCategory.fromJson(Map<String, dynamic> json) =>
      _$DiscourseCategoryFromJson(json);
}

/// Discourse 上传图片模型
@freezed
class DiscourseUploadedImage with _$DiscourseUploadedImage {
  const factory DiscourseUploadedImage({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'url') required String url,
    @JsonKey(name: 'width') int? width,
    @JsonKey(name: 'height') int? height,
  }) = _DiscourseUploadedImage;

  factory DiscourseUploadedImage.fromJson(Map<String, dynamic> json) =>
      _$DiscourseUploadedImageFromJson(json);
}

/// Discourse 分类列表响应模型
@freezed
class DiscourseCategoryListResponse with _$DiscourseCategoryListResponse {
  const factory DiscourseCategoryListResponse({
    @JsonKey(name: 'category_list') DiscourseCategoryList? categoryList,
  }) = _DiscourseCategoryListResponse;

  factory DiscourseCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscourseCategoryListResponseFromJson(json);
}

/// Discourse 分类列表模型
@freezed
class DiscourseCategoryList with _$DiscourseCategoryList {
  const factory DiscourseCategoryList({
    @JsonKey(name: 'can_create_category') @Default(false) bool canCreateCategory,
    @JsonKey(name: 'can_create_topic') @Default(false) bool canCreateTopic,
    @JsonKey(name: 'draft') bool? draft,
    @JsonKey(name: 'draft_key') String? draftKey,
    @JsonKey(name: 'draft_sequence') int? draftSequence,
    @JsonKey(name: 'categories') @Default([]) List<DiscourseCategory> categories,
  }) = _DiscourseCategoryList;

  factory DiscourseCategoryList.fromJson(Map<String, dynamic> json) =>
      _$DiscourseCategoryListFromJson(json);
}
