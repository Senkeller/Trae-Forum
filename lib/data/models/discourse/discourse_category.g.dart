// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscourseCategoryImpl _$$DiscourseCategoryImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseCategoryImpl(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  color: json['color'] as String? ?? '0088CC',
  textColor: json['text_color'] as String? ?? 'FFFFFF',
  slug: json['slug'] as String,
  topicCount: (json['topic_count'] as num?)?.toInt() ?? 0,
  postCount: (json['post_count'] as num?)?.toInt() ?? 0,
  position: (json['position'] as num?)?.toInt() ?? 0,
  description: json['description'] as String?,
  descriptionText: json['description_text'] as String?,
  descriptionExcerpt: json['description_excerpt'] as String?,
  topicUrl: json['topic_url'] as String?,
  readRestricted: json['read_restricted'] as bool? ?? false,
  permission: (json['permission'] as num?)?.toInt(),
  notificationLevel: (json['notification_level'] as num?)?.toInt() ?? 1,
  canEdit: json['can_edit'] as bool? ?? false,
  topicTemplate: json['topic_template'] as String?,
  hasChildren: json['has_children'] as bool? ?? false,
  subcategoryIds:
      (json['subcategory_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  uploadedLogo: json['uploaded_logo'] == null
      ? null
      : DiscourseUploadedImage.fromJson(
          json['uploaded_logo'] as Map<String, dynamic>,
        ),
  uploadedBackground: json['uploaded_background'] == null
      ? null
      : DiscourseUploadedImage.fromJson(
          json['uploaded_background'] as Map<String, dynamic>,
        ),
  parentCategoryId: (json['parent_category_id'] as num?)?.toInt(),
);

Map<String, dynamic> _$$DiscourseCategoryImplToJson(
  _$DiscourseCategoryImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'color': instance.color,
  'text_color': instance.textColor,
  'slug': instance.slug,
  'topic_count': instance.topicCount,
  'post_count': instance.postCount,
  'position': instance.position,
  'description': instance.description,
  'description_text': instance.descriptionText,
  'description_excerpt': instance.descriptionExcerpt,
  'topic_url': instance.topicUrl,
  'read_restricted': instance.readRestricted,
  'permission': instance.permission,
  'notification_level': instance.notificationLevel,
  'can_edit': instance.canEdit,
  'topic_template': instance.topicTemplate,
  'has_children': instance.hasChildren,
  'subcategory_ids': instance.subcategoryIds,
  'uploaded_logo': instance.uploadedLogo,
  'uploaded_background': instance.uploadedBackground,
  'parent_category_id': instance.parentCategoryId,
};

_$DiscourseUploadedImageImpl _$$DiscourseUploadedImageImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseUploadedImageImpl(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  width: (json['width'] as num?)?.toInt(),
  height: (json['height'] as num?)?.toInt(),
);

Map<String, dynamic> _$$DiscourseUploadedImageImplToJson(
  _$DiscourseUploadedImageImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'width': instance.width,
  'height': instance.height,
};

_$DiscourseCategoryListResponseImpl
_$$DiscourseCategoryListResponseImplFromJson(Map<String, dynamic> json) =>
    _$DiscourseCategoryListResponseImpl(
      categoryList: json['category_list'] == null
          ? null
          : DiscourseCategoryList.fromJson(
              json['category_list'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$$DiscourseCategoryListResponseImplToJson(
  _$DiscourseCategoryListResponseImpl instance,
) => <String, dynamic>{'category_list': instance.categoryList};

_$DiscourseCategoryListImpl _$$DiscourseCategoryListImplFromJson(
  Map<String, dynamic> json,
) => _$DiscourseCategoryListImpl(
  canCreateCategory: json['can_create_category'] as bool? ?? false,
  canCreateTopic: json['can_create_topic'] as bool? ?? false,
  draft: json['draft'] as bool?,
  draftKey: json['draft_key'] as String?,
  draftSequence: (json['draft_sequence'] as num?)?.toInt(),
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => DiscourseCategory.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$DiscourseCategoryListImplToJson(
  _$DiscourseCategoryListImpl instance,
) => <String, dynamic>{
  'can_create_category': instance.canCreateCategory,
  'can_create_topic': instance.canCreateTopic,
  'draft': instance.draft,
  'draft_key': instance.draftKey,
  'draft_sequence': instance.draftSequence,
  'categories': instance.categories,
};
