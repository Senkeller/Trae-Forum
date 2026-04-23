// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discourse_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DiscourseCategory _$DiscourseCategoryFromJson(Map<String, dynamic> json) {
  return _DiscourseCategory.fromJson(json);
}

/// @nodoc
mixin _$DiscourseCategory {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'text_color')
  String get textColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_count')
  int get topicCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_count')
  int get postCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'position')
  int get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_text')
  String? get descriptionText => throw _privateConstructorUsedError;
  @JsonKey(name: 'description_excerpt')
  String? get descriptionExcerpt => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_url')
  String? get topicUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_restricted')
  bool get readRestricted => throw _privateConstructorUsedError;
  @JsonKey(name: 'permission')
  int? get permission => throw _privateConstructorUsedError;
  @JsonKey(name: 'notification_level')
  int get notificationLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_edit')
  bool get canEdit => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_template')
  String? get topicTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_children')
  bool get hasChildren => throw _privateConstructorUsedError;
  @JsonKey(name: 'subcategory_ids')
  List<int> get subcategoryIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_logo')
  DiscourseUploadedImage? get uploadedLogo =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'uploaded_background')
  DiscourseUploadedImage? get uploadedBackground =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_category_id')
  int? get parentCategoryId => throw _privateConstructorUsedError;

  /// Serializes this DiscourseCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseCategoryCopyWith<DiscourseCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseCategoryCopyWith<$Res> {
  factory $DiscourseCategoryCopyWith(
    DiscourseCategory value,
    $Res Function(DiscourseCategory) then,
  ) = _$DiscourseCategoryCopyWithImpl<$Res, DiscourseCategory>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'color') String color,
    @JsonKey(name: 'text_color') String textColor,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'position') int position,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'description_text') String? descriptionText,
    @JsonKey(name: 'description_excerpt') String? descriptionExcerpt,
    @JsonKey(name: 'topic_url') String? topicUrl,
    @JsonKey(name: 'read_restricted') bool readRestricted,
    @JsonKey(name: 'permission') int? permission,
    @JsonKey(name: 'notification_level') int notificationLevel,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'topic_template') String? topicTemplate,
    @JsonKey(name: 'has_children') bool hasChildren,
    @JsonKey(name: 'subcategory_ids') List<int> subcategoryIds,
    @JsonKey(name: 'uploaded_logo') DiscourseUploadedImage? uploadedLogo,
    @JsonKey(name: 'uploaded_background')
    DiscourseUploadedImage? uploadedBackground,
    @JsonKey(name: 'parent_category_id') int? parentCategoryId,
  });

  $DiscourseUploadedImageCopyWith<$Res>? get uploadedLogo;
  $DiscourseUploadedImageCopyWith<$Res>? get uploadedBackground;
}

/// @nodoc
class _$DiscourseCategoryCopyWithImpl<$Res, $Val extends DiscourseCategory>
    implements $DiscourseCategoryCopyWith<$Res> {
  _$DiscourseCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? textColor = null,
    Object? slug = null,
    Object? topicCount = null,
    Object? postCount = null,
    Object? position = null,
    Object? description = freezed,
    Object? descriptionText = freezed,
    Object? descriptionExcerpt = freezed,
    Object? topicUrl = freezed,
    Object? readRestricted = null,
    Object? permission = freezed,
    Object? notificationLevel = null,
    Object? canEdit = null,
    Object? topicTemplate = freezed,
    Object? hasChildren = null,
    Object? subcategoryIds = null,
    Object? uploadedLogo = freezed,
    Object? uploadedBackground = freezed,
    Object? parentCategoryId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            color: null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String,
            textColor: null == textColor
                ? _value.textColor
                : textColor // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            topicCount: null == topicCount
                ? _value.topicCount
                : topicCount // ignore: cast_nullable_to_non_nullable
                      as int,
            postCount: null == postCount
                ? _value.postCount
                : postCount // ignore: cast_nullable_to_non_nullable
                      as int,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionText: freezed == descriptionText
                ? _value.descriptionText
                : descriptionText // ignore: cast_nullable_to_non_nullable
                      as String?,
            descriptionExcerpt: freezed == descriptionExcerpt
                ? _value.descriptionExcerpt
                : descriptionExcerpt // ignore: cast_nullable_to_non_nullable
                      as String?,
            topicUrl: freezed == topicUrl
                ? _value.topicUrl
                : topicUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            readRestricted: null == readRestricted
                ? _value.readRestricted
                : readRestricted // ignore: cast_nullable_to_non_nullable
                      as bool,
            permission: freezed == permission
                ? _value.permission
                : permission // ignore: cast_nullable_to_non_nullable
                      as int?,
            notificationLevel: null == notificationLevel
                ? _value.notificationLevel
                : notificationLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            canEdit: null == canEdit
                ? _value.canEdit
                : canEdit // ignore: cast_nullable_to_non_nullable
                      as bool,
            topicTemplate: freezed == topicTemplate
                ? _value.topicTemplate
                : topicTemplate // ignore: cast_nullable_to_non_nullable
                      as String?,
            hasChildren: null == hasChildren
                ? _value.hasChildren
                : hasChildren // ignore: cast_nullable_to_non_nullable
                      as bool,
            subcategoryIds: null == subcategoryIds
                ? _value.subcategoryIds
                : subcategoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            uploadedLogo: freezed == uploadedLogo
                ? _value.uploadedLogo
                : uploadedLogo // ignore: cast_nullable_to_non_nullable
                      as DiscourseUploadedImage?,
            uploadedBackground: freezed == uploadedBackground
                ? _value.uploadedBackground
                : uploadedBackground // ignore: cast_nullable_to_non_nullable
                      as DiscourseUploadedImage?,
            parentCategoryId: freezed == parentCategoryId
                ? _value.parentCategoryId
                : parentCategoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseUploadedImageCopyWith<$Res>? get uploadedLogo {
    if (_value.uploadedLogo == null) {
      return null;
    }

    return $DiscourseUploadedImageCopyWith<$Res>(_value.uploadedLogo!, (value) {
      return _then(_value.copyWith(uploadedLogo: value) as $Val);
    });
  }

  /// Create a copy of DiscourseCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseUploadedImageCopyWith<$Res>? get uploadedBackground {
    if (_value.uploadedBackground == null) {
      return null;
    }

    return $DiscourseUploadedImageCopyWith<$Res>(_value.uploadedBackground!, (
      value,
    ) {
      return _then(_value.copyWith(uploadedBackground: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseCategoryImplCopyWith<$Res>
    implements $DiscourseCategoryCopyWith<$Res> {
  factory _$$DiscourseCategoryImplCopyWith(
    _$DiscourseCategoryImpl value,
    $Res Function(_$DiscourseCategoryImpl) then,
  ) = __$$DiscourseCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'color') String color,
    @JsonKey(name: 'text_color') String textColor,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'position') int position,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'description_text') String? descriptionText,
    @JsonKey(name: 'description_excerpt') String? descriptionExcerpt,
    @JsonKey(name: 'topic_url') String? topicUrl,
    @JsonKey(name: 'read_restricted') bool readRestricted,
    @JsonKey(name: 'permission') int? permission,
    @JsonKey(name: 'notification_level') int notificationLevel,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'topic_template') String? topicTemplate,
    @JsonKey(name: 'has_children') bool hasChildren,
    @JsonKey(name: 'subcategory_ids') List<int> subcategoryIds,
    @JsonKey(name: 'uploaded_logo') DiscourseUploadedImage? uploadedLogo,
    @JsonKey(name: 'uploaded_background')
    DiscourseUploadedImage? uploadedBackground,
    @JsonKey(name: 'parent_category_id') int? parentCategoryId,
  });

  @override
  $DiscourseUploadedImageCopyWith<$Res>? get uploadedLogo;
  @override
  $DiscourseUploadedImageCopyWith<$Res>? get uploadedBackground;
}

/// @nodoc
class __$$DiscourseCategoryImplCopyWithImpl<$Res>
    extends _$DiscourseCategoryCopyWithImpl<$Res, _$DiscourseCategoryImpl>
    implements _$$DiscourseCategoryImplCopyWith<$Res> {
  __$$DiscourseCategoryImplCopyWithImpl(
    _$DiscourseCategoryImpl _value,
    $Res Function(_$DiscourseCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? color = null,
    Object? textColor = null,
    Object? slug = null,
    Object? topicCount = null,
    Object? postCount = null,
    Object? position = null,
    Object? description = freezed,
    Object? descriptionText = freezed,
    Object? descriptionExcerpt = freezed,
    Object? topicUrl = freezed,
    Object? readRestricted = null,
    Object? permission = freezed,
    Object? notificationLevel = null,
    Object? canEdit = null,
    Object? topicTemplate = freezed,
    Object? hasChildren = null,
    Object? subcategoryIds = null,
    Object? uploadedLogo = freezed,
    Object? uploadedBackground = freezed,
    Object? parentCategoryId = freezed,
  }) {
    return _then(
      _$DiscourseCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        color: null == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String,
        textColor: null == textColor
            ? _value.textColor
            : textColor // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        topicCount: null == topicCount
            ? _value.topicCount
            : topicCount // ignore: cast_nullable_to_non_nullable
                  as int,
        postCount: null == postCount
            ? _value.postCount
            : postCount // ignore: cast_nullable_to_non_nullable
                  as int,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionText: freezed == descriptionText
            ? _value.descriptionText
            : descriptionText // ignore: cast_nullable_to_non_nullable
                  as String?,
        descriptionExcerpt: freezed == descriptionExcerpt
            ? _value.descriptionExcerpt
            : descriptionExcerpt // ignore: cast_nullable_to_non_nullable
                  as String?,
        topicUrl: freezed == topicUrl
            ? _value.topicUrl
            : topicUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        readRestricted: null == readRestricted
            ? _value.readRestricted
            : readRestricted // ignore: cast_nullable_to_non_nullable
                  as bool,
        permission: freezed == permission
            ? _value.permission
            : permission // ignore: cast_nullable_to_non_nullable
                  as int?,
        notificationLevel: null == notificationLevel
            ? _value.notificationLevel
            : notificationLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        canEdit: null == canEdit
            ? _value.canEdit
            : canEdit // ignore: cast_nullable_to_non_nullable
                  as bool,
        topicTemplate: freezed == topicTemplate
            ? _value.topicTemplate
            : topicTemplate // ignore: cast_nullable_to_non_nullable
                  as String?,
        hasChildren: null == hasChildren
            ? _value.hasChildren
            : hasChildren // ignore: cast_nullable_to_non_nullable
                  as bool,
        subcategoryIds: null == subcategoryIds
            ? _value._subcategoryIds
            : subcategoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        uploadedLogo: freezed == uploadedLogo
            ? _value.uploadedLogo
            : uploadedLogo // ignore: cast_nullable_to_non_nullable
                  as DiscourseUploadedImage?,
        uploadedBackground: freezed == uploadedBackground
            ? _value.uploadedBackground
            : uploadedBackground // ignore: cast_nullable_to_non_nullable
                  as DiscourseUploadedImage?,
        parentCategoryId: freezed == parentCategoryId
            ? _value.parentCategoryId
            : parentCategoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseCategoryImpl implements _DiscourseCategory {
  const _$DiscourseCategoryImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'color') this.color = '0088CC',
    @JsonKey(name: 'text_color') this.textColor = 'FFFFFF',
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'topic_count') this.topicCount = 0,
    @JsonKey(name: 'post_count') this.postCount = 0,
    @JsonKey(name: 'position') this.position = 0,
    @JsonKey(name: 'description') this.description,
    @JsonKey(name: 'description_text') this.descriptionText,
    @JsonKey(name: 'description_excerpt') this.descriptionExcerpt,
    @JsonKey(name: 'topic_url') this.topicUrl,
    @JsonKey(name: 'read_restricted') this.readRestricted = false,
    @JsonKey(name: 'permission') this.permission,
    @JsonKey(name: 'notification_level') this.notificationLevel = 1,
    @JsonKey(name: 'can_edit') this.canEdit = false,
    @JsonKey(name: 'topic_template') this.topicTemplate,
    @JsonKey(name: 'has_children') this.hasChildren = false,
    @JsonKey(name: 'subcategory_ids') final List<int> subcategoryIds = const [],
    @JsonKey(name: 'uploaded_logo') this.uploadedLogo,
    @JsonKey(name: 'uploaded_background') this.uploadedBackground,
    @JsonKey(name: 'parent_category_id') this.parentCategoryId,
  }) : _subcategoryIds = subcategoryIds;

  factory _$DiscourseCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'color')
  final String color;
  @override
  @JsonKey(name: 'text_color')
  final String textColor;
  @override
  @JsonKey(name: 'slug')
  final String slug;
  @override
  @JsonKey(name: 'topic_count')
  final int topicCount;
  @override
  @JsonKey(name: 'post_count')
  final int postCount;
  @override
  @JsonKey(name: 'position')
  final int position;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'description_text')
  final String? descriptionText;
  @override
  @JsonKey(name: 'description_excerpt')
  final String? descriptionExcerpt;
  @override
  @JsonKey(name: 'topic_url')
  final String? topicUrl;
  @override
  @JsonKey(name: 'read_restricted')
  final bool readRestricted;
  @override
  @JsonKey(name: 'permission')
  final int? permission;
  @override
  @JsonKey(name: 'notification_level')
  final int notificationLevel;
  @override
  @JsonKey(name: 'can_edit')
  final bool canEdit;
  @override
  @JsonKey(name: 'topic_template')
  final String? topicTemplate;
  @override
  @JsonKey(name: 'has_children')
  final bool hasChildren;
  final List<int> _subcategoryIds;
  @override
  @JsonKey(name: 'subcategory_ids')
  List<int> get subcategoryIds {
    if (_subcategoryIds is EqualUnmodifiableListView) return _subcategoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subcategoryIds);
  }

  @override
  @JsonKey(name: 'uploaded_logo')
  final DiscourseUploadedImage? uploadedLogo;
  @override
  @JsonKey(name: 'uploaded_background')
  final DiscourseUploadedImage? uploadedBackground;
  @override
  @JsonKey(name: 'parent_category_id')
  final int? parentCategoryId;

  @override
  String toString() {
    return 'DiscourseCategory(id: $id, name: $name, color: $color, textColor: $textColor, slug: $slug, topicCount: $topicCount, postCount: $postCount, position: $position, description: $description, descriptionText: $descriptionText, descriptionExcerpt: $descriptionExcerpt, topicUrl: $topicUrl, readRestricted: $readRestricted, permission: $permission, notificationLevel: $notificationLevel, canEdit: $canEdit, topicTemplate: $topicTemplate, hasChildren: $hasChildren, subcategoryIds: $subcategoryIds, uploadedLogo: $uploadedLogo, uploadedBackground: $uploadedBackground, parentCategoryId: $parentCategoryId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.topicCount, topicCount) ||
                other.topicCount == topicCount) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.descriptionText, descriptionText) ||
                other.descriptionText == descriptionText) &&
            (identical(other.descriptionExcerpt, descriptionExcerpt) ||
                other.descriptionExcerpt == descriptionExcerpt) &&
            (identical(other.topicUrl, topicUrl) ||
                other.topicUrl == topicUrl) &&
            (identical(other.readRestricted, readRestricted) ||
                other.readRestricted == readRestricted) &&
            (identical(other.permission, permission) ||
                other.permission == permission) &&
            (identical(other.notificationLevel, notificationLevel) ||
                other.notificationLevel == notificationLevel) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.topicTemplate, topicTemplate) ||
                other.topicTemplate == topicTemplate) &&
            (identical(other.hasChildren, hasChildren) ||
                other.hasChildren == hasChildren) &&
            const DeepCollectionEquality().equals(
              other._subcategoryIds,
              _subcategoryIds,
            ) &&
            (identical(other.uploadedLogo, uploadedLogo) ||
                other.uploadedLogo == uploadedLogo) &&
            (identical(other.uploadedBackground, uploadedBackground) ||
                other.uploadedBackground == uploadedBackground) &&
            (identical(other.parentCategoryId, parentCategoryId) ||
                other.parentCategoryId == parentCategoryId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    color,
    textColor,
    slug,
    topicCount,
    postCount,
    position,
    description,
    descriptionText,
    descriptionExcerpt,
    topicUrl,
    readRestricted,
    permission,
    notificationLevel,
    canEdit,
    topicTemplate,
    hasChildren,
    const DeepCollectionEquality().hash(_subcategoryIds),
    uploadedLogo,
    uploadedBackground,
    parentCategoryId,
  ]);

  /// Create a copy of DiscourseCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseCategoryImplCopyWith<_$DiscourseCategoryImpl> get copyWith =>
      __$$DiscourseCategoryImplCopyWithImpl<_$DiscourseCategoryImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseCategoryImplToJson(this);
  }
}

abstract class _DiscourseCategory implements DiscourseCategory {
  const factory _DiscourseCategory({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'color') final String color,
    @JsonKey(name: 'text_color') final String textColor,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'topic_count') final int topicCount,
    @JsonKey(name: 'post_count') final int postCount,
    @JsonKey(name: 'position') final int position,
    @JsonKey(name: 'description') final String? description,
    @JsonKey(name: 'description_text') final String? descriptionText,
    @JsonKey(name: 'description_excerpt') final String? descriptionExcerpt,
    @JsonKey(name: 'topic_url') final String? topicUrl,
    @JsonKey(name: 'read_restricted') final bool readRestricted,
    @JsonKey(name: 'permission') final int? permission,
    @JsonKey(name: 'notification_level') final int notificationLevel,
    @JsonKey(name: 'can_edit') final bool canEdit,
    @JsonKey(name: 'topic_template') final String? topicTemplate,
    @JsonKey(name: 'has_children') final bool hasChildren,
    @JsonKey(name: 'subcategory_ids') final List<int> subcategoryIds,
    @JsonKey(name: 'uploaded_logo') final DiscourseUploadedImage? uploadedLogo,
    @JsonKey(name: 'uploaded_background')
    final DiscourseUploadedImage? uploadedBackground,
    @JsonKey(name: 'parent_category_id') final int? parentCategoryId,
  }) = _$DiscourseCategoryImpl;

  factory _DiscourseCategory.fromJson(Map<String, dynamic> json) =
      _$DiscourseCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'color')
  String get color;
  @override
  @JsonKey(name: 'text_color')
  String get textColor;
  @override
  @JsonKey(name: 'slug')
  String get slug;
  @override
  @JsonKey(name: 'topic_count')
  int get topicCount;
  @override
  @JsonKey(name: 'post_count')
  int get postCount;
  @override
  @JsonKey(name: 'position')
  int get position;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'description_text')
  String? get descriptionText;
  @override
  @JsonKey(name: 'description_excerpt')
  String? get descriptionExcerpt;
  @override
  @JsonKey(name: 'topic_url')
  String? get topicUrl;
  @override
  @JsonKey(name: 'read_restricted')
  bool get readRestricted;
  @override
  @JsonKey(name: 'permission')
  int? get permission;
  @override
  @JsonKey(name: 'notification_level')
  int get notificationLevel;
  @override
  @JsonKey(name: 'can_edit')
  bool get canEdit;
  @override
  @JsonKey(name: 'topic_template')
  String? get topicTemplate;
  @override
  @JsonKey(name: 'has_children')
  bool get hasChildren;
  @override
  @JsonKey(name: 'subcategory_ids')
  List<int> get subcategoryIds;
  @override
  @JsonKey(name: 'uploaded_logo')
  DiscourseUploadedImage? get uploadedLogo;
  @override
  @JsonKey(name: 'uploaded_background')
  DiscourseUploadedImage? get uploadedBackground;
  @override
  @JsonKey(name: 'parent_category_id')
  int? get parentCategoryId;

  /// Create a copy of DiscourseCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseCategoryImplCopyWith<_$DiscourseCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseUploadedImage _$DiscourseUploadedImageFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseUploadedImage.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUploadedImage {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'width')
  int? get width => throw _privateConstructorUsedError;
  @JsonKey(name: 'height')
  int? get height => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUploadedImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUploadedImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUploadedImageCopyWith<DiscourseUploadedImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUploadedImageCopyWith<$Res> {
  factory $DiscourseUploadedImageCopyWith(
    DiscourseUploadedImage value,
    $Res Function(DiscourseUploadedImage) then,
  ) = _$DiscourseUploadedImageCopyWithImpl<$Res, DiscourseUploadedImage>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'url') String url,
    @JsonKey(name: 'width') int? width,
    @JsonKey(name: 'height') int? height,
  });
}

/// @nodoc
class _$DiscourseUploadedImageCopyWithImpl<
  $Res,
  $Val extends DiscourseUploadedImage
>
    implements $DiscourseUploadedImageCopyWith<$Res> {
  _$DiscourseUploadedImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUploadedImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            width: freezed == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                      as int?,
            height: freezed == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUploadedImageImplCopyWith<$Res>
    implements $DiscourseUploadedImageCopyWith<$Res> {
  factory _$$DiscourseUploadedImageImplCopyWith(
    _$DiscourseUploadedImageImpl value,
    $Res Function(_$DiscourseUploadedImageImpl) then,
  ) = __$$DiscourseUploadedImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'url') String url,
    @JsonKey(name: 'width') int? width,
    @JsonKey(name: 'height') int? height,
  });
}

/// @nodoc
class __$$DiscourseUploadedImageImplCopyWithImpl<$Res>
    extends
        _$DiscourseUploadedImageCopyWithImpl<$Res, _$DiscourseUploadedImageImpl>
    implements _$$DiscourseUploadedImageImplCopyWith<$Res> {
  __$$DiscourseUploadedImageImplCopyWithImpl(
    _$DiscourseUploadedImageImpl _value,
    $Res Function(_$DiscourseUploadedImageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUploadedImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? width = freezed,
    Object? height = freezed,
  }) {
    return _then(
      _$DiscourseUploadedImageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        width: freezed == width
            ? _value.width
            : width // ignore: cast_nullable_to_non_nullable
                  as int?,
        height: freezed == height
            ? _value.height
            : height // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUploadedImageImpl implements _DiscourseUploadedImage {
  const _$DiscourseUploadedImageImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'url') required this.url,
    @JsonKey(name: 'width') this.width,
    @JsonKey(name: 'height') this.height,
  });

  factory _$DiscourseUploadedImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUploadedImageImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'url')
  final String url;
  @override
  @JsonKey(name: 'width')
  final int? width;
  @override
  @JsonKey(name: 'height')
  final int? height;

  @override
  String toString() {
    return 'DiscourseUploadedImage(id: $id, url: $url, width: $width, height: $height)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUploadedImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, url, width, height);

  /// Create a copy of DiscourseUploadedImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUploadedImageImplCopyWith<_$DiscourseUploadedImageImpl>
  get copyWith =>
      __$$DiscourseUploadedImageImplCopyWithImpl<_$DiscourseUploadedImageImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUploadedImageImplToJson(this);
  }
}

abstract class _DiscourseUploadedImage implements DiscourseUploadedImage {
  const factory _DiscourseUploadedImage({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'url') required final String url,
    @JsonKey(name: 'width') final int? width,
    @JsonKey(name: 'height') final int? height,
  }) = _$DiscourseUploadedImageImpl;

  factory _DiscourseUploadedImage.fromJson(Map<String, dynamic> json) =
      _$DiscourseUploadedImageImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'url')
  String get url;
  @override
  @JsonKey(name: 'width')
  int? get width;
  @override
  @JsonKey(name: 'height')
  int? get height;

  /// Create a copy of DiscourseUploadedImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUploadedImageImplCopyWith<_$DiscourseUploadedImageImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseCategoryListResponse _$DiscourseCategoryListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseCategoryListResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscourseCategoryListResponse {
  @JsonKey(name: 'category_list')
  DiscourseCategoryList? get categoryList => throw _privateConstructorUsedError;

  /// Serializes this DiscourseCategoryListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseCategoryListResponseCopyWith<DiscourseCategoryListResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseCategoryListResponseCopyWith<$Res> {
  factory $DiscourseCategoryListResponseCopyWith(
    DiscourseCategoryListResponse value,
    $Res Function(DiscourseCategoryListResponse) then,
  ) =
      _$DiscourseCategoryListResponseCopyWithImpl<
        $Res,
        DiscourseCategoryListResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'category_list') DiscourseCategoryList? categoryList,
  });

  $DiscourseCategoryListCopyWith<$Res>? get categoryList;
}

/// @nodoc
class _$DiscourseCategoryListResponseCopyWithImpl<
  $Res,
  $Val extends DiscourseCategoryListResponse
>
    implements $DiscourseCategoryListResponseCopyWith<$Res> {
  _$DiscourseCategoryListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryList = freezed}) {
    return _then(
      _value.copyWith(
            categoryList: freezed == categoryList
                ? _value.categoryList
                : categoryList // ignore: cast_nullable_to_non_nullable
                      as DiscourseCategoryList?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseCategoryListCopyWith<$Res>? get categoryList {
    if (_value.categoryList == null) {
      return null;
    }

    return $DiscourseCategoryListCopyWith<$Res>(_value.categoryList!, (value) {
      return _then(_value.copyWith(categoryList: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseCategoryListResponseImplCopyWith<$Res>
    implements $DiscourseCategoryListResponseCopyWith<$Res> {
  factory _$$DiscourseCategoryListResponseImplCopyWith(
    _$DiscourseCategoryListResponseImpl value,
    $Res Function(_$DiscourseCategoryListResponseImpl) then,
  ) = __$$DiscourseCategoryListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'category_list') DiscourseCategoryList? categoryList,
  });

  @override
  $DiscourseCategoryListCopyWith<$Res>? get categoryList;
}

/// @nodoc
class __$$DiscourseCategoryListResponseImplCopyWithImpl<$Res>
    extends
        _$DiscourseCategoryListResponseCopyWithImpl<
          $Res,
          _$DiscourseCategoryListResponseImpl
        >
    implements _$$DiscourseCategoryListResponseImplCopyWith<$Res> {
  __$$DiscourseCategoryListResponseImplCopyWithImpl(
    _$DiscourseCategoryListResponseImpl _value,
    $Res Function(_$DiscourseCategoryListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? categoryList = freezed}) {
    return _then(
      _$DiscourseCategoryListResponseImpl(
        categoryList: freezed == categoryList
            ? _value.categoryList
            : categoryList // ignore: cast_nullable_to_non_nullable
                  as DiscourseCategoryList?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseCategoryListResponseImpl
    implements _DiscourseCategoryListResponse {
  const _$DiscourseCategoryListResponseImpl({
    @JsonKey(name: 'category_list') this.categoryList,
  });

  factory _$DiscourseCategoryListResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscourseCategoryListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'category_list')
  final DiscourseCategoryList? categoryList;

  @override
  String toString() {
    return 'DiscourseCategoryListResponse(categoryList: $categoryList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseCategoryListResponseImpl &&
            (identical(other.categoryList, categoryList) ||
                other.categoryList == categoryList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, categoryList);

  /// Create a copy of DiscourseCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseCategoryListResponseImplCopyWith<
    _$DiscourseCategoryListResponseImpl
  >
  get copyWith =>
      __$$DiscourseCategoryListResponseImplCopyWithImpl<
        _$DiscourseCategoryListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseCategoryListResponseImplToJson(this);
  }
}

abstract class _DiscourseCategoryListResponse
    implements DiscourseCategoryListResponse {
  const factory _DiscourseCategoryListResponse({
    @JsonKey(name: 'category_list') final DiscourseCategoryList? categoryList,
  }) = _$DiscourseCategoryListResponseImpl;

  factory _DiscourseCategoryListResponse.fromJson(Map<String, dynamic> json) =
      _$DiscourseCategoryListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'category_list')
  DiscourseCategoryList? get categoryList;

  /// Create a copy of DiscourseCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseCategoryListResponseImplCopyWith<
    _$DiscourseCategoryListResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseCategoryList _$DiscourseCategoryListFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseCategoryList.fromJson(json);
}

/// @nodoc
mixin _$DiscourseCategoryList {
  @JsonKey(name: 'can_create_category')
  bool get canCreateCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_create_topic')
  bool get canCreateTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'draft')
  bool? get draft => throw _privateConstructorUsedError;
  @JsonKey(name: 'draft_key')
  String? get draftKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'draft_sequence')
  int? get draftSequence => throw _privateConstructorUsedError;
  @JsonKey(name: 'categories')
  List<DiscourseCategory> get categories => throw _privateConstructorUsedError;

  /// Serializes this DiscourseCategoryList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseCategoryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseCategoryListCopyWith<DiscourseCategoryList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseCategoryListCopyWith<$Res> {
  factory $DiscourseCategoryListCopyWith(
    DiscourseCategoryList value,
    $Res Function(DiscourseCategoryList) then,
  ) = _$DiscourseCategoryListCopyWithImpl<$Res, DiscourseCategoryList>;
  @useResult
  $Res call({
    @JsonKey(name: 'can_create_category') bool canCreateCategory,
    @JsonKey(name: 'can_create_topic') bool canCreateTopic,
    @JsonKey(name: 'draft') bool? draft,
    @JsonKey(name: 'draft_key') String? draftKey,
    @JsonKey(name: 'draft_sequence') int? draftSequence,
    @JsonKey(name: 'categories') List<DiscourseCategory> categories,
  });
}

/// @nodoc
class _$DiscourseCategoryListCopyWithImpl<
  $Res,
  $Val extends DiscourseCategoryList
>
    implements $DiscourseCategoryListCopyWith<$Res> {
  _$DiscourseCategoryListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseCategoryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canCreateCategory = null,
    Object? canCreateTopic = null,
    Object? draft = freezed,
    Object? draftKey = freezed,
    Object? draftSequence = freezed,
    Object? categories = null,
  }) {
    return _then(
      _value.copyWith(
            canCreateCategory: null == canCreateCategory
                ? _value.canCreateCategory
                : canCreateCategory // ignore: cast_nullable_to_non_nullable
                      as bool,
            canCreateTopic: null == canCreateTopic
                ? _value.canCreateTopic
                : canCreateTopic // ignore: cast_nullable_to_non_nullable
                      as bool,
            draft: freezed == draft
                ? _value.draft
                : draft // ignore: cast_nullable_to_non_nullable
                      as bool?,
            draftKey: freezed == draftKey
                ? _value.draftKey
                : draftKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            draftSequence: freezed == draftSequence
                ? _value.draftSequence
                : draftSequence // ignore: cast_nullable_to_non_nullable
                      as int?,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseCategory>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseCategoryListImplCopyWith<$Res>
    implements $DiscourseCategoryListCopyWith<$Res> {
  factory _$$DiscourseCategoryListImplCopyWith(
    _$DiscourseCategoryListImpl value,
    $Res Function(_$DiscourseCategoryListImpl) then,
  ) = __$$DiscourseCategoryListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'can_create_category') bool canCreateCategory,
    @JsonKey(name: 'can_create_topic') bool canCreateTopic,
    @JsonKey(name: 'draft') bool? draft,
    @JsonKey(name: 'draft_key') String? draftKey,
    @JsonKey(name: 'draft_sequence') int? draftSequence,
    @JsonKey(name: 'categories') List<DiscourseCategory> categories,
  });
}

/// @nodoc
class __$$DiscourseCategoryListImplCopyWithImpl<$Res>
    extends
        _$DiscourseCategoryListCopyWithImpl<$Res, _$DiscourseCategoryListImpl>
    implements _$$DiscourseCategoryListImplCopyWith<$Res> {
  __$$DiscourseCategoryListImplCopyWithImpl(
    _$DiscourseCategoryListImpl _value,
    $Res Function(_$DiscourseCategoryListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseCategoryList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canCreateCategory = null,
    Object? canCreateTopic = null,
    Object? draft = freezed,
    Object? draftKey = freezed,
    Object? draftSequence = freezed,
    Object? categories = null,
  }) {
    return _then(
      _$DiscourseCategoryListImpl(
        canCreateCategory: null == canCreateCategory
            ? _value.canCreateCategory
            : canCreateCategory // ignore: cast_nullable_to_non_nullable
                  as bool,
        canCreateTopic: null == canCreateTopic
            ? _value.canCreateTopic
            : canCreateTopic // ignore: cast_nullable_to_non_nullable
                  as bool,
        draft: freezed == draft
            ? _value.draft
            : draft // ignore: cast_nullable_to_non_nullable
                  as bool?,
        draftKey: freezed == draftKey
            ? _value.draftKey
            : draftKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        draftSequence: freezed == draftSequence
            ? _value.draftSequence
            : draftSequence // ignore: cast_nullable_to_non_nullable
                  as int?,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseCategory>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseCategoryListImpl implements _DiscourseCategoryList {
  const _$DiscourseCategoryListImpl({
    @JsonKey(name: 'can_create_category') this.canCreateCategory = false,
    @JsonKey(name: 'can_create_topic') this.canCreateTopic = false,
    @JsonKey(name: 'draft') this.draft,
    @JsonKey(name: 'draft_key') this.draftKey,
    @JsonKey(name: 'draft_sequence') this.draftSequence,
    @JsonKey(name: 'categories')
    final List<DiscourseCategory> categories = const [],
  }) : _categories = categories;

  factory _$DiscourseCategoryListImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseCategoryListImplFromJson(json);

  @override
  @JsonKey(name: 'can_create_category')
  final bool canCreateCategory;
  @override
  @JsonKey(name: 'can_create_topic')
  final bool canCreateTopic;
  @override
  @JsonKey(name: 'draft')
  final bool? draft;
  @override
  @JsonKey(name: 'draft_key')
  final String? draftKey;
  @override
  @JsonKey(name: 'draft_sequence')
  final int? draftSequence;
  final List<DiscourseCategory> _categories;
  @override
  @JsonKey(name: 'categories')
  List<DiscourseCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'DiscourseCategoryList(canCreateCategory: $canCreateCategory, canCreateTopic: $canCreateTopic, draft: $draft, draftKey: $draftKey, draftSequence: $draftSequence, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseCategoryListImpl &&
            (identical(other.canCreateCategory, canCreateCategory) ||
                other.canCreateCategory == canCreateCategory) &&
            (identical(other.canCreateTopic, canCreateTopic) ||
                other.canCreateTopic == canCreateTopic) &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.draftKey, draftKey) ||
                other.draftKey == draftKey) &&
            (identical(other.draftSequence, draftSequence) ||
                other.draftSequence == draftSequence) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    canCreateCategory,
    canCreateTopic,
    draft,
    draftKey,
    draftSequence,
    const DeepCollectionEquality().hash(_categories),
  );

  /// Create a copy of DiscourseCategoryList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseCategoryListImplCopyWith<_$DiscourseCategoryListImpl>
  get copyWith =>
      __$$DiscourseCategoryListImplCopyWithImpl<_$DiscourseCategoryListImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseCategoryListImplToJson(this);
  }
}

abstract class _DiscourseCategoryList implements DiscourseCategoryList {
  const factory _DiscourseCategoryList({
    @JsonKey(name: 'can_create_category') final bool canCreateCategory,
    @JsonKey(name: 'can_create_topic') final bool canCreateTopic,
    @JsonKey(name: 'draft') final bool? draft,
    @JsonKey(name: 'draft_key') final String? draftKey,
    @JsonKey(name: 'draft_sequence') final int? draftSequence,
    @JsonKey(name: 'categories') final List<DiscourseCategory> categories,
  }) = _$DiscourseCategoryListImpl;

  factory _DiscourseCategoryList.fromJson(Map<String, dynamic> json) =
      _$DiscourseCategoryListImpl.fromJson;

  @override
  @JsonKey(name: 'can_create_category')
  bool get canCreateCategory;
  @override
  @JsonKey(name: 'can_create_topic')
  bool get canCreateTopic;
  @override
  @JsonKey(name: 'draft')
  bool? get draft;
  @override
  @JsonKey(name: 'draft_key')
  String? get draftKey;
  @override
  @JsonKey(name: 'draft_sequence')
  int? get draftSequence;
  @override
  @JsonKey(name: 'categories')
  List<DiscourseCategory> get categories;

  /// Create a copy of DiscourseCategoryList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseCategoryListImplCopyWith<_$DiscourseCategoryListImpl>
  get copyWith => throw _privateConstructorUsedError;
}
