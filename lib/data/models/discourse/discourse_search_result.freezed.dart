// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discourse_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DiscourseSearchResultResponse _$DiscourseSearchResultResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseSearchResultResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscourseSearchResultResponse {
  @JsonKey(name: 'posts')
  List<DiscourseSearchPost> get posts => throw _privateConstructorUsedError;
  @JsonKey(name: 'topics')
  List<DiscourseSearchTopic> get topics => throw _privateConstructorUsedError;
  @JsonKey(name: 'users')
  List<DiscourseSearchUser> get users => throw _privateConstructorUsedError;
  @JsonKey(name: 'categories')
  List<DiscourseSearchCategory> get categories =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<DiscourseSearchTag> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'groups')
  List<DiscourseSearchGroup> get groups => throw _privateConstructorUsedError;
  @JsonKey(name: 'grouped_search_result')
  DiscourseGroupedSearchResult? get groupedSearchResult =>
      throw _privateConstructorUsedError;

  /// Serializes this DiscourseSearchResultResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseSearchResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseSearchResultResponseCopyWith<DiscourseSearchResultResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseSearchResultResponseCopyWith<$Res> {
  factory $DiscourseSearchResultResponseCopyWith(
    DiscourseSearchResultResponse value,
    $Res Function(DiscourseSearchResultResponse) then,
  ) =
      _$DiscourseSearchResultResponseCopyWithImpl<
        $Res,
        DiscourseSearchResultResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'posts') List<DiscourseSearchPost> posts,
    @JsonKey(name: 'topics') List<DiscourseSearchTopic> topics,
    @JsonKey(name: 'users') List<DiscourseSearchUser> users,
    @JsonKey(name: 'categories') List<DiscourseSearchCategory> categories,
    @JsonKey(name: 'tags') List<DiscourseSearchTag> tags,
    @JsonKey(name: 'groups') List<DiscourseSearchGroup> groups,
    @JsonKey(name: 'grouped_search_result')
    DiscourseGroupedSearchResult? groupedSearchResult,
  });

  $DiscourseGroupedSearchResultCopyWith<$Res>? get groupedSearchResult;
}

/// @nodoc
class _$DiscourseSearchResultResponseCopyWithImpl<
  $Res,
  $Val extends DiscourseSearchResultResponse
>
    implements $DiscourseSearchResultResponseCopyWith<$Res> {
  _$DiscourseSearchResultResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseSearchResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? topics = null,
    Object? users = null,
    Object? categories = null,
    Object? tags = null,
    Object? groups = null,
    Object? groupedSearchResult = freezed,
  }) {
    return _then(
      _value.copyWith(
            posts: null == posts
                ? _value.posts
                : posts // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseSearchPost>,
            topics: null == topics
                ? _value.topics
                : topics // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseSearchTopic>,
            users: null == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseSearchUser>,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseSearchCategory>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseSearchTag>,
            groups: null == groups
                ? _value.groups
                : groups // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseSearchGroup>,
            groupedSearchResult: freezed == groupedSearchResult
                ? _value.groupedSearchResult
                : groupedSearchResult // ignore: cast_nullable_to_non_nullable
                      as DiscourseGroupedSearchResult?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseSearchResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseGroupedSearchResultCopyWith<$Res>? get groupedSearchResult {
    if (_value.groupedSearchResult == null) {
      return null;
    }

    return $DiscourseGroupedSearchResultCopyWith<$Res>(
      _value.groupedSearchResult!,
      (value) {
        return _then(_value.copyWith(groupedSearchResult: value) as $Val);
      },
    );
  }
}

/// @nodoc
abstract class _$$DiscourseSearchResultResponseImplCopyWith<$Res>
    implements $DiscourseSearchResultResponseCopyWith<$Res> {
  factory _$$DiscourseSearchResultResponseImplCopyWith(
    _$DiscourseSearchResultResponseImpl value,
    $Res Function(_$DiscourseSearchResultResponseImpl) then,
  ) = __$$DiscourseSearchResultResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'posts') List<DiscourseSearchPost> posts,
    @JsonKey(name: 'topics') List<DiscourseSearchTopic> topics,
    @JsonKey(name: 'users') List<DiscourseSearchUser> users,
    @JsonKey(name: 'categories') List<DiscourseSearchCategory> categories,
    @JsonKey(name: 'tags') List<DiscourseSearchTag> tags,
    @JsonKey(name: 'groups') List<DiscourseSearchGroup> groups,
    @JsonKey(name: 'grouped_search_result')
    DiscourseGroupedSearchResult? groupedSearchResult,
  });

  @override
  $DiscourseGroupedSearchResultCopyWith<$Res>? get groupedSearchResult;
}

/// @nodoc
class __$$DiscourseSearchResultResponseImplCopyWithImpl<$Res>
    extends
        _$DiscourseSearchResultResponseCopyWithImpl<
          $Res,
          _$DiscourseSearchResultResponseImpl
        >
    implements _$$DiscourseSearchResultResponseImplCopyWith<$Res> {
  __$$DiscourseSearchResultResponseImplCopyWithImpl(
    _$DiscourseSearchResultResponseImpl _value,
    $Res Function(_$DiscourseSearchResultResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseSearchResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? posts = null,
    Object? topics = null,
    Object? users = null,
    Object? categories = null,
    Object? tags = null,
    Object? groups = null,
    Object? groupedSearchResult = freezed,
  }) {
    return _then(
      _$DiscourseSearchResultResponseImpl(
        posts: null == posts
            ? _value._posts
            : posts // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseSearchPost>,
        topics: null == topics
            ? _value._topics
            : topics // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseSearchTopic>,
        users: null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseSearchUser>,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseSearchCategory>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseSearchTag>,
        groups: null == groups
            ? _value._groups
            : groups // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseSearchGroup>,
        groupedSearchResult: freezed == groupedSearchResult
            ? _value.groupedSearchResult
            : groupedSearchResult // ignore: cast_nullable_to_non_nullable
                  as DiscourseGroupedSearchResult?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseSearchResultResponseImpl
    implements _DiscourseSearchResultResponse {
  const _$DiscourseSearchResultResponseImpl({
    @JsonKey(name: 'posts') final List<DiscourseSearchPost> posts = const [],
    @JsonKey(name: 'topics') final List<DiscourseSearchTopic> topics = const [],
    @JsonKey(name: 'users') final List<DiscourseSearchUser> users = const [],
    @JsonKey(name: 'categories')
    final List<DiscourseSearchCategory> categories = const [],
    @JsonKey(name: 'tags') final List<DiscourseSearchTag> tags = const [],
    @JsonKey(name: 'groups') final List<DiscourseSearchGroup> groups = const [],
    @JsonKey(name: 'grouped_search_result') this.groupedSearchResult,
  }) : _posts = posts,
       _topics = topics,
       _users = users,
       _categories = categories,
       _tags = tags,
       _groups = groups;

  factory _$DiscourseSearchResultResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscourseSearchResultResponseImplFromJson(json);

  final List<DiscourseSearchPost> _posts;
  @override
  @JsonKey(name: 'posts')
  List<DiscourseSearchPost> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  final List<DiscourseSearchTopic> _topics;
  @override
  @JsonKey(name: 'topics')
  List<DiscourseSearchTopic> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  final List<DiscourseSearchUser> _users;
  @override
  @JsonKey(name: 'users')
  List<DiscourseSearchUser> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  final List<DiscourseSearchCategory> _categories;
  @override
  @JsonKey(name: 'categories')
  List<DiscourseSearchCategory> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<DiscourseSearchTag> _tags;
  @override
  @JsonKey(name: 'tags')
  List<DiscourseSearchTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<DiscourseSearchGroup> _groups;
  @override
  @JsonKey(name: 'groups')
  List<DiscourseSearchGroup> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  @JsonKey(name: 'grouped_search_result')
  final DiscourseGroupedSearchResult? groupedSearchResult;

  @override
  String toString() {
    return 'DiscourseSearchResultResponse(posts: $posts, topics: $topics, users: $users, categories: $categories, tags: $tags, groups: $groups, groupedSearchResult: $groupedSearchResult)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseSearchResultResponseImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality().equals(other._topics, _topics) &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(other._groups, _groups) &&
            (identical(other.groupedSearchResult, groupedSearchResult) ||
                other.groupedSearchResult == groupedSearchResult));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_posts),
    const DeepCollectionEquality().hash(_topics),
    const DeepCollectionEquality().hash(_users),
    const DeepCollectionEquality().hash(_categories),
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_groups),
    groupedSearchResult,
  );

  /// Create a copy of DiscourseSearchResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseSearchResultResponseImplCopyWith<
    _$DiscourseSearchResultResponseImpl
  >
  get copyWith =>
      __$$DiscourseSearchResultResponseImplCopyWithImpl<
        _$DiscourseSearchResultResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseSearchResultResponseImplToJson(this);
  }
}

abstract class _DiscourseSearchResultResponse
    implements DiscourseSearchResultResponse {
  const factory _DiscourseSearchResultResponse({
    @JsonKey(name: 'posts') final List<DiscourseSearchPost> posts,
    @JsonKey(name: 'topics') final List<DiscourseSearchTopic> topics,
    @JsonKey(name: 'users') final List<DiscourseSearchUser> users,
    @JsonKey(name: 'categories') final List<DiscourseSearchCategory> categories,
    @JsonKey(name: 'tags') final List<DiscourseSearchTag> tags,
    @JsonKey(name: 'groups') final List<DiscourseSearchGroup> groups,
    @JsonKey(name: 'grouped_search_result')
    final DiscourseGroupedSearchResult? groupedSearchResult,
  }) = _$DiscourseSearchResultResponseImpl;

  factory _DiscourseSearchResultResponse.fromJson(Map<String, dynamic> json) =
      _$DiscourseSearchResultResponseImpl.fromJson;

  @override
  @JsonKey(name: 'posts')
  List<DiscourseSearchPost> get posts;
  @override
  @JsonKey(name: 'topics')
  List<DiscourseSearchTopic> get topics;
  @override
  @JsonKey(name: 'users')
  List<DiscourseSearchUser> get users;
  @override
  @JsonKey(name: 'categories')
  List<DiscourseSearchCategory> get categories;
  @override
  @JsonKey(name: 'tags')
  List<DiscourseSearchTag> get tags;
  @override
  @JsonKey(name: 'groups')
  List<DiscourseSearchGroup> get groups;
  @override
  @JsonKey(name: 'grouped_search_result')
  DiscourseGroupedSearchResult? get groupedSearchResult;

  /// Create a copy of DiscourseSearchResultResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseSearchResultResponseImplCopyWith<
    _$DiscourseSearchResultResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseSearchPost _$DiscourseSearchPostFromJson(Map<String, dynamic> json) {
  return _DiscourseSearchPost.fromJson(json);
}

/// @nodoc
mixin _$DiscourseSearchPost {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_count')
  int get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'blurb')
  String? get blurb => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_number')
  int get postNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_id')
  int get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_title')
  String? get topicTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_slug')
  String? get topicSlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_slug')
  String? get categorySlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_color')
  String? get categoryColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_text_color')
  String? get categoryTextColor => throw _privateConstructorUsedError;

  /// Serializes this DiscourseSearchPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseSearchPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseSearchPostCopyWith<DiscourseSearchPost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseSearchPostCopyWith<$Res> {
  factory $DiscourseSearchPostCopyWith(
    DiscourseSearchPost value,
    $Res Function(DiscourseSearchPost) then,
  ) = _$DiscourseSearchPostCopyWithImpl<$Res, DiscourseSearchPost>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'blurb') String? blurb,
    @JsonKey(name: 'post_number') int postNumber,
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_text_color') String? categoryTextColor,
  });
}

/// @nodoc
class _$DiscourseSearchPostCopyWithImpl<$Res, $Val extends DiscourseSearchPost>
    implements $DiscourseSearchPostCopyWith<$Res> {
  _$DiscourseSearchPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseSearchPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? username = null,
    Object? avatarTemplate = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? blurb = freezed,
    Object? postNumber = null,
    Object? topicId = null,
    Object? topicTitle = freezed,
    Object? topicSlug = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? categorySlug = freezed,
    Object? categoryColor = freezed,
    Object? categoryTextColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarTemplate: null == avatarTemplate
                ? _value.avatarTemplate
                : avatarTemplate // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            blurb: freezed == blurb
                ? _value.blurb
                : blurb // ignore: cast_nullable_to_non_nullable
                      as String?,
            postNumber: null == postNumber
                ? _value.postNumber
                : postNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            topicId: null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int,
            topicTitle: freezed == topicTitle
                ? _value.topicTitle
                : topicTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            topicSlug: freezed == topicSlug
                ? _value.topicSlug
                : topicSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            categorySlug: freezed == categorySlug
                ? _value.categorySlug
                : categorySlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryColor: freezed == categoryColor
                ? _value.categoryColor
                : categoryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryTextColor: freezed == categoryTextColor
                ? _value.categoryTextColor
                : categoryTextColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseSearchPostImplCopyWith<$Res>
    implements $DiscourseSearchPostCopyWith<$Res> {
  factory _$$DiscourseSearchPostImplCopyWith(
    _$DiscourseSearchPostImpl value,
    $Res Function(_$DiscourseSearchPostImpl) then,
  ) = __$$DiscourseSearchPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'blurb') String? blurb,
    @JsonKey(name: 'post_number') int postNumber,
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'topic_title') String? topicTitle,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_text_color') String? categoryTextColor,
  });
}

/// @nodoc
class __$$DiscourseSearchPostImplCopyWithImpl<$Res>
    extends _$DiscourseSearchPostCopyWithImpl<$Res, _$DiscourseSearchPostImpl>
    implements _$$DiscourseSearchPostImplCopyWith<$Res> {
  __$$DiscourseSearchPostImplCopyWithImpl(
    _$DiscourseSearchPostImpl _value,
    $Res Function(_$DiscourseSearchPostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseSearchPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? username = null,
    Object? avatarTemplate = null,
    Object? createdAt = null,
    Object? likeCount = null,
    Object? blurb = freezed,
    Object? postNumber = null,
    Object? topicId = null,
    Object? topicTitle = freezed,
    Object? topicSlug = freezed,
    Object? categoryId = freezed,
    Object? categoryName = freezed,
    Object? categorySlug = freezed,
    Object? categoryColor = freezed,
    Object? categoryTextColor = freezed,
  }) {
    return _then(
      _$DiscourseSearchPostImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarTemplate: null == avatarTemplate
            ? _value.avatarTemplate
            : avatarTemplate // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        blurb: freezed == blurb
            ? _value.blurb
            : blurb // ignore: cast_nullable_to_non_nullable
                  as String?,
        postNumber: null == postNumber
            ? _value.postNumber
            : postNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        topicId: null == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int,
        topicTitle: freezed == topicTitle
            ? _value.topicTitle
            : topicTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        topicSlug: freezed == topicSlug
            ? _value.topicSlug
            : topicSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        categorySlug: freezed == categorySlug
            ? _value.categorySlug
            : categorySlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryColor: freezed == categoryColor
            ? _value.categoryColor
            : categoryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryTextColor: freezed == categoryTextColor
            ? _value.categoryTextColor
            : categoryTextColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseSearchPostImpl implements _DiscourseSearchPost {
  const _$DiscourseSearchPostImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'like_count') this.likeCount = 0,
    @JsonKey(name: 'blurb') this.blurb,
    @JsonKey(name: 'post_number') required this.postNumber,
    @JsonKey(name: 'topic_id') required this.topicId,
    @JsonKey(name: 'topic_title') this.topicTitle,
    @JsonKey(name: 'topic_slug') this.topicSlug,
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'category_slug') this.categorySlug,
    @JsonKey(name: 'category_color') this.categoryColor,
    @JsonKey(name: 'category_text_color') this.categoryTextColor,
  });

  factory _$DiscourseSearchPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseSearchPostImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'avatar_template')
  final String avatarTemplate;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'like_count')
  final int likeCount;
  @override
  @JsonKey(name: 'blurb')
  final String? blurb;
  @override
  @JsonKey(name: 'post_number')
  final int postNumber;
  @override
  @JsonKey(name: 'topic_id')
  final int topicId;
  @override
  @JsonKey(name: 'topic_title')
  final String? topicTitle;
  @override
  @JsonKey(name: 'topic_slug')
  final String? topicSlug;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'category_slug')
  final String? categorySlug;
  @override
  @JsonKey(name: 'category_color')
  final String? categoryColor;
  @override
  @JsonKey(name: 'category_text_color')
  final String? categoryTextColor;

  @override
  String toString() {
    return 'DiscourseSearchPost(id: $id, name: $name, username: $username, avatarTemplate: $avatarTemplate, createdAt: $createdAt, likeCount: $likeCount, blurb: $blurb, postNumber: $postNumber, topicId: $topicId, topicTitle: $topicTitle, topicSlug: $topicSlug, categoryId: $categoryId, categoryName: $categoryName, categorySlug: $categorySlug, categoryColor: $categoryColor, categoryTextColor: $categoryTextColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseSearchPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.blurb, blurb) || other.blurb == blurb) &&
            (identical(other.postNumber, postNumber) ||
                other.postNumber == postNumber) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.topicTitle, topicTitle) ||
                other.topicTitle == topicTitle) &&
            (identical(other.topicSlug, topicSlug) ||
                other.topicSlug == topicSlug) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categorySlug, categorySlug) ||
                other.categorySlug == categorySlug) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor) &&
            (identical(other.categoryTextColor, categoryTextColor) ||
                other.categoryTextColor == categoryTextColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    username,
    avatarTemplate,
    createdAt,
    likeCount,
    blurb,
    postNumber,
    topicId,
    topicTitle,
    topicSlug,
    categoryId,
    categoryName,
    categorySlug,
    categoryColor,
    categoryTextColor,
  );

  /// Create a copy of DiscourseSearchPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseSearchPostImplCopyWith<_$DiscourseSearchPostImpl> get copyWith =>
      __$$DiscourseSearchPostImplCopyWithImpl<_$DiscourseSearchPostImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseSearchPostImplToJson(this);
  }
}

abstract class _DiscourseSearchPost implements DiscourseSearchPost {
  const factory _DiscourseSearchPost({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'like_count') final int likeCount,
    @JsonKey(name: 'blurb') final String? blurb,
    @JsonKey(name: 'post_number') required final int postNumber,
    @JsonKey(name: 'topic_id') required final int topicId,
    @JsonKey(name: 'topic_title') final String? topicTitle,
    @JsonKey(name: 'topic_slug') final String? topicSlug,
    @JsonKey(name: 'category_id') final int? categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'category_slug') final String? categorySlug,
    @JsonKey(name: 'category_color') final String? categoryColor,
    @JsonKey(name: 'category_text_color') final String? categoryTextColor,
  }) = _$DiscourseSearchPostImpl;

  factory _DiscourseSearchPost.fromJson(Map<String, dynamic> json) =
      _$DiscourseSearchPostImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'like_count')
  int get likeCount;
  @override
  @JsonKey(name: 'blurb')
  String? get blurb;
  @override
  @JsonKey(name: 'post_number')
  int get postNumber;
  @override
  @JsonKey(name: 'topic_id')
  int get topicId;
  @override
  @JsonKey(name: 'topic_title')
  String? get topicTitle;
  @override
  @JsonKey(name: 'topic_slug')
  String? get topicSlug;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'category_slug')
  String? get categorySlug;
  @override
  @JsonKey(name: 'category_color')
  String? get categoryColor;
  @override
  @JsonKey(name: 'category_text_color')
  String? get categoryTextColor;

  /// Create a copy of DiscourseSearchPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseSearchPostImplCopyWith<_$DiscourseSearchPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseSearchTopic _$DiscourseSearchTopicFromJson(Map<String, dynamic> json) {
  return _DiscourseSearchTopic.fromJson(json);
}

/// @nodoc
mixin _$DiscourseSearchTopic {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'fancy_title')
  String? get fancyTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'posts_count')
  int get postsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_count')
  int get replyCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'highest_post_number')
  int get highestPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'bumped')
  bool get bumped => throw _privateConstructorUsedError;
  @JsonKey(name: 'bumped_at')
  String? get bumpedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'archetype')
  String get archetype => throw _privateConstructorUsedError;
  @JsonKey(name: 'unseen')
  bool get unseen => throw _privateConstructorUsedError;
  @JsonKey(name: 'pinned')
  bool get pinned => throw _privateConstructorUsedError;
  @JsonKey(name: 'visible')
  bool get visible => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed')
  bool get closed => throw _privateConstructorUsedError;
  @JsonKey(name: 'archived')
  bool get archived => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarked')
  bool get bookmarked => throw _privateConstructorUsedError;
  @JsonKey(name: 'liked')
  bool get liked => throw _privateConstructorUsedError;
  @JsonKey(name: 'views')
  int get views => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_count')
  int get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String? get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_slug')
  String? get categorySlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_color')
  String? get categoryColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_text_color')
  String? get categoryTextColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String> get tags => throw _privateConstructorUsedError;

  /// Serializes this DiscourseSearchTopic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseSearchTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseSearchTopicCopyWith<DiscourseSearchTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseSearchTopicCopyWith<$Res> {
  factory $DiscourseSearchTopicCopyWith(
    DiscourseSearchTopic value,
    $Res Function(DiscourseSearchTopic) then,
  ) = _$DiscourseSearchTopicCopyWithImpl<$Res, DiscourseSearchTopic>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'posts_count') int postsCount,
    @JsonKey(name: 'reply_count') int replyCount,
    @JsonKey(name: 'highest_post_number') int highestPostNumber,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'bumped') bool bumped,
    @JsonKey(name: 'bumped_at') String? bumpedAt,
    @JsonKey(name: 'archetype') String archetype,
    @JsonKey(name: 'unseen') bool unseen,
    @JsonKey(name: 'pinned') bool pinned,
    @JsonKey(name: 'visible') bool visible,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
    @JsonKey(name: 'bookmarked') bool bookmarked,
    @JsonKey(name: 'liked') bool liked,
    @JsonKey(name: 'views') int views,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_text_color') String? categoryTextColor,
    @JsonKey(name: 'tags') List<String> tags,
  });
}

/// @nodoc
class _$DiscourseSearchTopicCopyWithImpl<
  $Res,
  $Val extends DiscourseSearchTopic
>
    implements $DiscourseSearchTopicCopyWith<$Res> {
  _$DiscourseSearchTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseSearchTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fancyTitle = freezed,
    Object? slug = null,
    Object? postsCount = null,
    Object? replyCount = null,
    Object? highestPostNumber = null,
    Object? createdAt = null,
    Object? lastPostedAt = freezed,
    Object? bumped = null,
    Object? bumpedAt = freezed,
    Object? archetype = null,
    Object? unseen = null,
    Object? pinned = null,
    Object? visible = null,
    Object? closed = null,
    Object? archived = null,
    Object? bookmarked = null,
    Object? liked = null,
    Object? views = null,
    Object? likeCount = null,
    Object? categoryId = null,
    Object? categoryName = freezed,
    Object? categorySlug = freezed,
    Object? categoryColor = freezed,
    Object? categoryTextColor = freezed,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            fancyTitle: freezed == fancyTitle
                ? _value.fancyTitle
                : fancyTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            postsCount: null == postsCount
                ? _value.postsCount
                : postsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            replyCount: null == replyCount
                ? _value.replyCount
                : replyCount // ignore: cast_nullable_to_non_nullable
                      as int,
            highestPostNumber: null == highestPostNumber
                ? _value.highestPostNumber
                : highestPostNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            lastPostedAt: freezed == lastPostedAt
                ? _value.lastPostedAt
                : lastPostedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            bumped: null == bumped
                ? _value.bumped
                : bumped // ignore: cast_nullable_to_non_nullable
                      as bool,
            bumpedAt: freezed == bumpedAt
                ? _value.bumpedAt
                : bumpedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            archetype: null == archetype
                ? _value.archetype
                : archetype // ignore: cast_nullable_to_non_nullable
                      as String,
            unseen: null == unseen
                ? _value.unseen
                : unseen // ignore: cast_nullable_to_non_nullable
                      as bool,
            pinned: null == pinned
                ? _value.pinned
                : pinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            visible: null == visible
                ? _value.visible
                : visible // ignore: cast_nullable_to_non_nullable
                      as bool,
            closed: null == closed
                ? _value.closed
                : closed // ignore: cast_nullable_to_non_nullable
                      as bool,
            archived: null == archived
                ? _value.archived
                : archived // ignore: cast_nullable_to_non_nullable
                      as bool,
            bookmarked: null == bookmarked
                ? _value.bookmarked
                : bookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            liked: null == liked
                ? _value.liked
                : liked // ignore: cast_nullable_to_non_nullable
                      as bool,
            views: null == views
                ? _value.views
                : views // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
            categoryName: freezed == categoryName
                ? _value.categoryName
                : categoryName // ignore: cast_nullable_to_non_nullable
                      as String?,
            categorySlug: freezed == categorySlug
                ? _value.categorySlug
                : categorySlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryColor: freezed == categoryColor
                ? _value.categoryColor
                : categoryColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryTextColor: freezed == categoryTextColor
                ? _value.categoryTextColor
                : categoryTextColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseSearchTopicImplCopyWith<$Res>
    implements $DiscourseSearchTopicCopyWith<$Res> {
  factory _$$DiscourseSearchTopicImplCopyWith(
    _$DiscourseSearchTopicImpl value,
    $Res Function(_$DiscourseSearchTopicImpl) then,
  ) = __$$DiscourseSearchTopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'posts_count') int postsCount,
    @JsonKey(name: 'reply_count') int replyCount,
    @JsonKey(name: 'highest_post_number') int highestPostNumber,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'bumped') bool bumped,
    @JsonKey(name: 'bumped_at') String? bumpedAt,
    @JsonKey(name: 'archetype') String archetype,
    @JsonKey(name: 'unseen') bool unseen,
    @JsonKey(name: 'pinned') bool pinned,
    @JsonKey(name: 'visible') bool visible,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
    @JsonKey(name: 'bookmarked') bool bookmarked,
    @JsonKey(name: 'liked') bool liked,
    @JsonKey(name: 'views') int views,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'category_id') int categoryId,
    @JsonKey(name: 'category_name') String? categoryName,
    @JsonKey(name: 'category_slug') String? categorySlug,
    @JsonKey(name: 'category_color') String? categoryColor,
    @JsonKey(name: 'category_text_color') String? categoryTextColor,
    @JsonKey(name: 'tags') List<String> tags,
  });
}

/// @nodoc
class __$$DiscourseSearchTopicImplCopyWithImpl<$Res>
    extends _$DiscourseSearchTopicCopyWithImpl<$Res, _$DiscourseSearchTopicImpl>
    implements _$$DiscourseSearchTopicImplCopyWith<$Res> {
  __$$DiscourseSearchTopicImplCopyWithImpl(
    _$DiscourseSearchTopicImpl _value,
    $Res Function(_$DiscourseSearchTopicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseSearchTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fancyTitle = freezed,
    Object? slug = null,
    Object? postsCount = null,
    Object? replyCount = null,
    Object? highestPostNumber = null,
    Object? createdAt = null,
    Object? lastPostedAt = freezed,
    Object? bumped = null,
    Object? bumpedAt = freezed,
    Object? archetype = null,
    Object? unseen = null,
    Object? pinned = null,
    Object? visible = null,
    Object? closed = null,
    Object? archived = null,
    Object? bookmarked = null,
    Object? liked = null,
    Object? views = null,
    Object? likeCount = null,
    Object? categoryId = null,
    Object? categoryName = freezed,
    Object? categorySlug = freezed,
    Object? categoryColor = freezed,
    Object? categoryTextColor = freezed,
    Object? tags = null,
  }) {
    return _then(
      _$DiscourseSearchTopicImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        fancyTitle: freezed == fancyTitle
            ? _value.fancyTitle
            : fancyTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        postsCount: null == postsCount
            ? _value.postsCount
            : postsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        replyCount: null == replyCount
            ? _value.replyCount
            : replyCount // ignore: cast_nullable_to_non_nullable
                  as int,
        highestPostNumber: null == highestPostNumber
            ? _value.highestPostNumber
            : highestPostNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        lastPostedAt: freezed == lastPostedAt
            ? _value.lastPostedAt
            : lastPostedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        bumped: null == bumped
            ? _value.bumped
            : bumped // ignore: cast_nullable_to_non_nullable
                  as bool,
        bumpedAt: freezed == bumpedAt
            ? _value.bumpedAt
            : bumpedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        archetype: null == archetype
            ? _value.archetype
            : archetype // ignore: cast_nullable_to_non_nullable
                  as String,
        unseen: null == unseen
            ? _value.unseen
            : unseen // ignore: cast_nullable_to_non_nullable
                  as bool,
        pinned: null == pinned
            ? _value.pinned
            : pinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        visible: null == visible
            ? _value.visible
            : visible // ignore: cast_nullable_to_non_nullable
                  as bool,
        closed: null == closed
            ? _value.closed
            : closed // ignore: cast_nullable_to_non_nullable
                  as bool,
        archived: null == archived
            ? _value.archived
            : archived // ignore: cast_nullable_to_non_nullable
                  as bool,
        bookmarked: null == bookmarked
            ? _value.bookmarked
            : bookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
        liked: null == liked
            ? _value.liked
            : liked // ignore: cast_nullable_to_non_nullable
                  as bool,
        views: null == views
            ? _value.views
            : views // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
        categoryName: freezed == categoryName
            ? _value.categoryName
            : categoryName // ignore: cast_nullable_to_non_nullable
                  as String?,
        categorySlug: freezed == categorySlug
            ? _value.categorySlug
            : categorySlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryColor: freezed == categoryColor
            ? _value.categoryColor
            : categoryColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryTextColor: freezed == categoryTextColor
            ? _value.categoryTextColor
            : categoryTextColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseSearchTopicImpl implements _DiscourseSearchTopic {
  const _$DiscourseSearchTopicImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'fancy_title') this.fancyTitle,
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'posts_count') this.postsCount = 0,
    @JsonKey(name: 'reply_count') this.replyCount = 0,
    @JsonKey(name: 'highest_post_number') this.highestPostNumber = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'last_posted_at') this.lastPostedAt,
    @JsonKey(name: 'bumped') this.bumped = false,
    @JsonKey(name: 'bumped_at') this.bumpedAt,
    @JsonKey(name: 'archetype') this.archetype = 'regular',
    @JsonKey(name: 'unseen') this.unseen = false,
    @JsonKey(name: 'pinned') this.pinned = false,
    @JsonKey(name: 'visible') this.visible = true,
    @JsonKey(name: 'closed') this.closed = false,
    @JsonKey(name: 'archived') this.archived = false,
    @JsonKey(name: 'bookmarked') this.bookmarked = false,
    @JsonKey(name: 'liked') this.liked = false,
    @JsonKey(name: 'views') this.views = 0,
    @JsonKey(name: 'like_count') this.likeCount = 0,
    @JsonKey(name: 'category_id') required this.categoryId,
    @JsonKey(name: 'category_name') this.categoryName,
    @JsonKey(name: 'category_slug') this.categorySlug,
    @JsonKey(name: 'category_color') this.categoryColor,
    @JsonKey(name: 'category_text_color') this.categoryTextColor,
    @JsonKey(name: 'tags') final List<String> tags = const [],
  }) : _tags = tags;

  factory _$DiscourseSearchTopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseSearchTopicImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'fancy_title')
  final String? fancyTitle;
  @override
  @JsonKey(name: 'slug')
  final String slug;
  @override
  @JsonKey(name: 'posts_count')
  final int postsCount;
  @override
  @JsonKey(name: 'reply_count')
  final int replyCount;
  @override
  @JsonKey(name: 'highest_post_number')
  final int highestPostNumber;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'last_posted_at')
  final String? lastPostedAt;
  @override
  @JsonKey(name: 'bumped')
  final bool bumped;
  @override
  @JsonKey(name: 'bumped_at')
  final String? bumpedAt;
  @override
  @JsonKey(name: 'archetype')
  final String archetype;
  @override
  @JsonKey(name: 'unseen')
  final bool unseen;
  @override
  @JsonKey(name: 'pinned')
  final bool pinned;
  @override
  @JsonKey(name: 'visible')
  final bool visible;
  @override
  @JsonKey(name: 'closed')
  final bool closed;
  @override
  @JsonKey(name: 'archived')
  final bool archived;
  @override
  @JsonKey(name: 'bookmarked')
  final bool bookmarked;
  @override
  @JsonKey(name: 'liked')
  final bool liked;
  @override
  @JsonKey(name: 'views')
  final int views;
  @override
  @JsonKey(name: 'like_count')
  final int likeCount;
  @override
  @JsonKey(name: 'category_id')
  final int categoryId;
  @override
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @override
  @JsonKey(name: 'category_slug')
  final String? categorySlug;
  @override
  @JsonKey(name: 'category_color')
  final String? categoryColor;
  @override
  @JsonKey(name: 'category_text_color')
  final String? categoryTextColor;
  final List<String> _tags;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  String toString() {
    return 'DiscourseSearchTopic(id: $id, title: $title, fancyTitle: $fancyTitle, slug: $slug, postsCount: $postsCount, replyCount: $replyCount, highestPostNumber: $highestPostNumber, createdAt: $createdAt, lastPostedAt: $lastPostedAt, bumped: $bumped, bumpedAt: $bumpedAt, archetype: $archetype, unseen: $unseen, pinned: $pinned, visible: $visible, closed: $closed, archived: $archived, bookmarked: $bookmarked, liked: $liked, views: $views, likeCount: $likeCount, categoryId: $categoryId, categoryName: $categoryName, categorySlug: $categorySlug, categoryColor: $categoryColor, categoryTextColor: $categoryTextColor, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseSearchTopicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fancyTitle, fancyTitle) ||
                other.fancyTitle == fancyTitle) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.highestPostNumber, highestPostNumber) ||
                other.highestPostNumber == highestPostNumber) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lastPostedAt, lastPostedAt) ||
                other.lastPostedAt == lastPostedAt) &&
            (identical(other.bumped, bumped) || other.bumped == bumped) &&
            (identical(other.bumpedAt, bumpedAt) ||
                other.bumpedAt == bumpedAt) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.unseen, unseen) || other.unseen == unseen) &&
            (identical(other.pinned, pinned) || other.pinned == pinned) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.closed, closed) || other.closed == closed) &&
            (identical(other.archived, archived) ||
                other.archived == archived) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked) &&
            (identical(other.liked, liked) || other.liked == liked) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.categorySlug, categorySlug) ||
                other.categorySlug == categorySlug) &&
            (identical(other.categoryColor, categoryColor) ||
                other.categoryColor == categoryColor) &&
            (identical(other.categoryTextColor, categoryTextColor) ||
                other.categoryTextColor == categoryTextColor) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    fancyTitle,
    slug,
    postsCount,
    replyCount,
    highestPostNumber,
    createdAt,
    lastPostedAt,
    bumped,
    bumpedAt,
    archetype,
    unseen,
    pinned,
    visible,
    closed,
    archived,
    bookmarked,
    liked,
    views,
    likeCount,
    categoryId,
    categoryName,
    categorySlug,
    categoryColor,
    categoryTextColor,
    const DeepCollectionEquality().hash(_tags),
  ]);

  /// Create a copy of DiscourseSearchTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseSearchTopicImplCopyWith<_$DiscourseSearchTopicImpl>
  get copyWith =>
      __$$DiscourseSearchTopicImplCopyWithImpl<_$DiscourseSearchTopicImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseSearchTopicImplToJson(this);
  }
}

abstract class _DiscourseSearchTopic implements DiscourseSearchTopic {
  const factory _DiscourseSearchTopic({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'fancy_title') final String? fancyTitle,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'posts_count') final int postsCount,
    @JsonKey(name: 'reply_count') final int replyCount,
    @JsonKey(name: 'highest_post_number') final int highestPostNumber,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'last_posted_at') final String? lastPostedAt,
    @JsonKey(name: 'bumped') final bool bumped,
    @JsonKey(name: 'bumped_at') final String? bumpedAt,
    @JsonKey(name: 'archetype') final String archetype,
    @JsonKey(name: 'unseen') final bool unseen,
    @JsonKey(name: 'pinned') final bool pinned,
    @JsonKey(name: 'visible') final bool visible,
    @JsonKey(name: 'closed') final bool closed,
    @JsonKey(name: 'archived') final bool archived,
    @JsonKey(name: 'bookmarked') final bool bookmarked,
    @JsonKey(name: 'liked') final bool liked,
    @JsonKey(name: 'views') final int views,
    @JsonKey(name: 'like_count') final int likeCount,
    @JsonKey(name: 'category_id') required final int categoryId,
    @JsonKey(name: 'category_name') final String? categoryName,
    @JsonKey(name: 'category_slug') final String? categorySlug,
    @JsonKey(name: 'category_color') final String? categoryColor,
    @JsonKey(name: 'category_text_color') final String? categoryTextColor,
    @JsonKey(name: 'tags') final List<String> tags,
  }) = _$DiscourseSearchTopicImpl;

  factory _DiscourseSearchTopic.fromJson(Map<String, dynamic> json) =
      _$DiscourseSearchTopicImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'fancy_title')
  String? get fancyTitle;
  @override
  @JsonKey(name: 'slug')
  String get slug;
  @override
  @JsonKey(name: 'posts_count')
  int get postsCount;
  @override
  @JsonKey(name: 'reply_count')
  int get replyCount;
  @override
  @JsonKey(name: 'highest_post_number')
  int get highestPostNumber;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt;
  @override
  @JsonKey(name: 'bumped')
  bool get bumped;
  @override
  @JsonKey(name: 'bumped_at')
  String? get bumpedAt;
  @override
  @JsonKey(name: 'archetype')
  String get archetype;
  @override
  @JsonKey(name: 'unseen')
  bool get unseen;
  @override
  @JsonKey(name: 'pinned')
  bool get pinned;
  @override
  @JsonKey(name: 'visible')
  bool get visible;
  @override
  @JsonKey(name: 'closed')
  bool get closed;
  @override
  @JsonKey(name: 'archived')
  bool get archived;
  @override
  @JsonKey(name: 'bookmarked')
  bool get bookmarked;
  @override
  @JsonKey(name: 'liked')
  bool get liked;
  @override
  @JsonKey(name: 'views')
  int get views;
  @override
  @JsonKey(name: 'like_count')
  int get likeCount;
  @override
  @JsonKey(name: 'category_id')
  int get categoryId;
  @override
  @JsonKey(name: 'category_name')
  String? get categoryName;
  @override
  @JsonKey(name: 'category_slug')
  String? get categorySlug;
  @override
  @JsonKey(name: 'category_color')
  String? get categoryColor;
  @override
  @JsonKey(name: 'category_text_color')
  String? get categoryTextColor;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags;

  /// Create a copy of DiscourseSearchTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseSearchTopicImplCopyWith<_$DiscourseSearchTopicImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseSearchUser _$DiscourseSearchUserFromJson(Map<String, dynamic> json) {
  return _DiscourseSearchUser.fromJson(json);
}

/// @nodoc
mixin _$DiscourseSearchUser {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;

  /// Serializes this DiscourseSearchUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseSearchUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseSearchUserCopyWith<DiscourseSearchUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseSearchUserCopyWith<$Res> {
  factory $DiscourseSearchUserCopyWith(
    DiscourseSearchUser value,
    $Res Function(DiscourseSearchUser) then,
  ) = _$DiscourseSearchUserCopyWithImpl<$Res, DiscourseSearchUser>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
  });
}

/// @nodoc
class _$DiscourseSearchUserCopyWithImpl<$Res, $Val extends DiscourseSearchUser>
    implements $DiscourseSearchUserCopyWith<$Res> {
  _$DiscourseSearchUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseSearchUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarTemplate: null == avatarTemplate
                ? _value.avatarTemplate
                : avatarTemplate // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseSearchUserImplCopyWith<$Res>
    implements $DiscourseSearchUserCopyWith<$Res> {
  factory _$$DiscourseSearchUserImplCopyWith(
    _$DiscourseSearchUserImpl value,
    $Res Function(_$DiscourseSearchUserImpl) then,
  ) = __$$DiscourseSearchUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
  });
}

/// @nodoc
class __$$DiscourseSearchUserImplCopyWithImpl<$Res>
    extends _$DiscourseSearchUserCopyWithImpl<$Res, _$DiscourseSearchUserImpl>
    implements _$$DiscourseSearchUserImplCopyWith<$Res> {
  __$$DiscourseSearchUserImplCopyWithImpl(
    _$DiscourseSearchUserImpl _value,
    $Res Function(_$DiscourseSearchUserImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseSearchUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
  }) {
    return _then(
      _$DiscourseSearchUserImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarTemplate: null == avatarTemplate
            ? _value.avatarTemplate
            : avatarTemplate // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseSearchUserImpl implements _DiscourseSearchUser {
  const _$DiscourseSearchUserImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
  });

  factory _$DiscourseSearchUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseSearchUserImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'avatar_template')
  final String avatarTemplate;

  @override
  String toString() {
    return 'DiscourseSearchUser(id: $id, username: $username, name: $name, avatarTemplate: $avatarTemplate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseSearchUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, username, name, avatarTemplate);

  /// Create a copy of DiscourseSearchUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseSearchUserImplCopyWith<_$DiscourseSearchUserImpl> get copyWith =>
      __$$DiscourseSearchUserImplCopyWithImpl<_$DiscourseSearchUserImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseSearchUserImplToJson(this);
  }
}

abstract class _DiscourseSearchUser implements DiscourseSearchUser {
  const factory _DiscourseSearchUser({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
  }) = _$DiscourseSearchUserImpl;

  factory _DiscourseSearchUser.fromJson(Map<String, dynamic> json) =
      _$DiscourseSearchUserImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate;

  /// Create a copy of DiscourseSearchUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseSearchUserImplCopyWith<_$DiscourseSearchUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseSearchCategory _$DiscourseSearchCategoryFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseSearchCategory.fromJson(json);
}

/// @nodoc
mixin _$DiscourseSearchCategory {
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
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this DiscourseSearchCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseSearchCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseSearchCategoryCopyWith<DiscourseSearchCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseSearchCategoryCopyWith<$Res> {
  factory $DiscourseSearchCategoryCopyWith(
    DiscourseSearchCategory value,
    $Res Function(DiscourseSearchCategory) then,
  ) = _$DiscourseSearchCategoryCopyWithImpl<$Res, DiscourseSearchCategory>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'color') String color,
    @JsonKey(name: 'text_color') String textColor,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'description') String? description,
  });
}

/// @nodoc
class _$DiscourseSearchCategoryCopyWithImpl<
  $Res,
  $Val extends DiscourseSearchCategory
>
    implements $DiscourseSearchCategoryCopyWith<$Res> {
  _$DiscourseSearchCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseSearchCategory
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
    Object? description = freezed,
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
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseSearchCategoryImplCopyWith<$Res>
    implements $DiscourseSearchCategoryCopyWith<$Res> {
  factory _$$DiscourseSearchCategoryImplCopyWith(
    _$DiscourseSearchCategoryImpl value,
    $Res Function(_$DiscourseSearchCategoryImpl) then,
  ) = __$$DiscourseSearchCategoryImplCopyWithImpl<$Res>;
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
    @JsonKey(name: 'description') String? description,
  });
}

/// @nodoc
class __$$DiscourseSearchCategoryImplCopyWithImpl<$Res>
    extends
        _$DiscourseSearchCategoryCopyWithImpl<
          $Res,
          _$DiscourseSearchCategoryImpl
        >
    implements _$$DiscourseSearchCategoryImplCopyWith<$Res> {
  __$$DiscourseSearchCategoryImplCopyWithImpl(
    _$DiscourseSearchCategoryImpl _value,
    $Res Function(_$DiscourseSearchCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseSearchCategory
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
    Object? description = freezed,
  }) {
    return _then(
      _$DiscourseSearchCategoryImpl(
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
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseSearchCategoryImpl implements _DiscourseSearchCategory {
  const _$DiscourseSearchCategoryImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'color') this.color = '0088CC',
    @JsonKey(name: 'text_color') this.textColor = 'FFFFFF',
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'topic_count') this.topicCount = 0,
    @JsonKey(name: 'post_count') this.postCount = 0,
    @JsonKey(name: 'description') this.description,
  });

  factory _$DiscourseSearchCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseSearchCategoryImplFromJson(json);

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
  @JsonKey(name: 'description')
  final String? description;

  @override
  String toString() {
    return 'DiscourseSearchCategory(id: $id, name: $name, color: $color, textColor: $textColor, slug: $slug, topicCount: $topicCount, postCount: $postCount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseSearchCategoryImpl &&
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
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    color,
    textColor,
    slug,
    topicCount,
    postCount,
    description,
  );

  /// Create a copy of DiscourseSearchCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseSearchCategoryImplCopyWith<_$DiscourseSearchCategoryImpl>
  get copyWith =>
      __$$DiscourseSearchCategoryImplCopyWithImpl<
        _$DiscourseSearchCategoryImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseSearchCategoryImplToJson(this);
  }
}

abstract class _DiscourseSearchCategory implements DiscourseSearchCategory {
  const factory _DiscourseSearchCategory({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'color') final String color,
    @JsonKey(name: 'text_color') final String textColor,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'topic_count') final int topicCount,
    @JsonKey(name: 'post_count') final int postCount,
    @JsonKey(name: 'description') final String? description,
  }) = _$DiscourseSearchCategoryImpl;

  factory _DiscourseSearchCategory.fromJson(Map<String, dynamic> json) =
      _$DiscourseSearchCategoryImpl.fromJson;

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
  @JsonKey(name: 'description')
  String? get description;

  /// Create a copy of DiscourseSearchCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseSearchCategoryImplCopyWith<_$DiscourseSearchCategoryImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseSearchTag _$DiscourseSearchTagFromJson(Map<String, dynamic> json) {
  return _DiscourseSearchTag.fromJson(json);
}

/// @nodoc
mixin _$DiscourseSearchTag {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_count')
  int get topicCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'pm_count')
  int get pmCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;

  /// Serializes this DiscourseSearchTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseSearchTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseSearchTagCopyWith<DiscourseSearchTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseSearchTagCopyWith<$Res> {
  factory $DiscourseSearchTagCopyWith(
    DiscourseSearchTag value,
    $Res Function(DiscourseSearchTag) then,
  ) = _$DiscourseSearchTagCopyWithImpl<$Res, DiscourseSearchTag>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'pm_count') int pmCount,
    @JsonKey(name: 'description') String? description,
  });
}

/// @nodoc
class _$DiscourseSearchTagCopyWithImpl<$Res, $Val extends DiscourseSearchTag>
    implements $DiscourseSearchTagCopyWith<$Res> {
  _$DiscourseSearchTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseSearchTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? topicCount = null,
    Object? pmCount = null,
    Object? description = freezed,
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
            topicCount: null == topicCount
                ? _value.topicCount
                : topicCount // ignore: cast_nullable_to_non_nullable
                      as int,
            pmCount: null == pmCount
                ? _value.pmCount
                : pmCount // ignore: cast_nullable_to_non_nullable
                      as int,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseSearchTagImplCopyWith<$Res>
    implements $DiscourseSearchTagCopyWith<$Res> {
  factory _$$DiscourseSearchTagImplCopyWith(
    _$DiscourseSearchTagImpl value,
    $Res Function(_$DiscourseSearchTagImpl) then,
  ) = __$$DiscourseSearchTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'pm_count') int pmCount,
    @JsonKey(name: 'description') String? description,
  });
}

/// @nodoc
class __$$DiscourseSearchTagImplCopyWithImpl<$Res>
    extends _$DiscourseSearchTagCopyWithImpl<$Res, _$DiscourseSearchTagImpl>
    implements _$$DiscourseSearchTagImplCopyWith<$Res> {
  __$$DiscourseSearchTagImplCopyWithImpl(
    _$DiscourseSearchTagImpl _value,
    $Res Function(_$DiscourseSearchTagImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseSearchTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? topicCount = null,
    Object? pmCount = null,
    Object? description = freezed,
  }) {
    return _then(
      _$DiscourseSearchTagImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        topicCount: null == topicCount
            ? _value.topicCount
            : topicCount // ignore: cast_nullable_to_non_nullable
                  as int,
        pmCount: null == pmCount
            ? _value.pmCount
            : pmCount // ignore: cast_nullable_to_non_nullable
                  as int,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseSearchTagImpl implements _DiscourseSearchTag {
  const _$DiscourseSearchTagImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'topic_count') this.topicCount = 0,
    @JsonKey(name: 'pm_count') this.pmCount = 0,
    @JsonKey(name: 'description') this.description,
  });

  factory _$DiscourseSearchTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseSearchTagImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'topic_count')
  final int topicCount;
  @override
  @JsonKey(name: 'pm_count')
  final int pmCount;
  @override
  @JsonKey(name: 'description')
  final String? description;

  @override
  String toString() {
    return 'DiscourseSearchTag(id: $id, name: $name, topicCount: $topicCount, pmCount: $pmCount, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseSearchTagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.topicCount, topicCount) ||
                other.topicCount == topicCount) &&
            (identical(other.pmCount, pmCount) || other.pmCount == pmCount) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, topicCount, pmCount, description);

  /// Create a copy of DiscourseSearchTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseSearchTagImplCopyWith<_$DiscourseSearchTagImpl> get copyWith =>
      __$$DiscourseSearchTagImplCopyWithImpl<_$DiscourseSearchTagImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseSearchTagImplToJson(this);
  }
}

abstract class _DiscourseSearchTag implements DiscourseSearchTag {
  const factory _DiscourseSearchTag({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'topic_count') final int topicCount,
    @JsonKey(name: 'pm_count') final int pmCount,
    @JsonKey(name: 'description') final String? description,
  }) = _$DiscourseSearchTagImpl;

  factory _DiscourseSearchTag.fromJson(Map<String, dynamic> json) =
      _$DiscourseSearchTagImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'topic_count')
  int get topicCount;
  @override
  @JsonKey(name: 'pm_count')
  int get pmCount;
  @override
  @JsonKey(name: 'description')
  String? get description;

  /// Create a copy of DiscourseSearchTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseSearchTagImplCopyWith<_$DiscourseSearchTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseSearchGroup _$DiscourseSearchGroupFromJson(Map<String, dynamic> json) {
  return _DiscourseSearchGroup.fromJson(json);
}

/// @nodoc
mixin _$DiscourseSearchGroup {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'full_name')
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_count')
  int get userCount => throw _privateConstructorUsedError;

  /// Serializes this DiscourseSearchGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseSearchGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseSearchGroupCopyWith<DiscourseSearchGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseSearchGroupCopyWith<$Res> {
  factory $DiscourseSearchGroupCopyWith(
    DiscourseSearchGroup value,
    $Res Function(DiscourseSearchGroup) then,
  ) = _$DiscourseSearchGroupCopyWithImpl<$Res, DiscourseSearchGroup>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'user_count') int userCount,
  });
}

/// @nodoc
class _$DiscourseSearchGroupCopyWithImpl<
  $Res,
  $Val extends DiscourseSearchGroup
>
    implements $DiscourseSearchGroupCopyWith<$Res> {
  _$DiscourseSearchGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseSearchGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = freezed,
    Object? userCount = null,
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
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userCount: null == userCount
                ? _value.userCount
                : userCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseSearchGroupImplCopyWith<$Res>
    implements $DiscourseSearchGroupCopyWith<$Res> {
  factory _$$DiscourseSearchGroupImplCopyWith(
    _$DiscourseSearchGroupImpl value,
    $Res Function(_$DiscourseSearchGroupImpl) then,
  ) = __$$DiscourseSearchGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'user_count') int userCount,
  });
}

/// @nodoc
class __$$DiscourseSearchGroupImplCopyWithImpl<$Res>
    extends _$DiscourseSearchGroupCopyWithImpl<$Res, _$DiscourseSearchGroupImpl>
    implements _$$DiscourseSearchGroupImplCopyWith<$Res> {
  __$$DiscourseSearchGroupImplCopyWithImpl(
    _$DiscourseSearchGroupImpl _value,
    $Res Function(_$DiscourseSearchGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseSearchGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? fullName = freezed,
    Object? userCount = null,
  }) {
    return _then(
      _$DiscourseSearchGroupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userCount: null == userCount
            ? _value.userCount
            : userCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseSearchGroupImpl implements _DiscourseSearchGroup {
  const _$DiscourseSearchGroupImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'full_name') this.fullName,
    @JsonKey(name: 'user_count') this.userCount = 0,
  });

  factory _$DiscourseSearchGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseSearchGroupImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'full_name')
  final String? fullName;
  @override
  @JsonKey(name: 'user_count')
  final int userCount;

  @override
  String toString() {
    return 'DiscourseSearchGroup(id: $id, name: $name, fullName: $fullName, userCount: $userCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseSearchGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.userCount, userCount) ||
                other.userCount == userCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, fullName, userCount);

  /// Create a copy of DiscourseSearchGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseSearchGroupImplCopyWith<_$DiscourseSearchGroupImpl>
  get copyWith =>
      __$$DiscourseSearchGroupImplCopyWithImpl<_$DiscourseSearchGroupImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseSearchGroupImplToJson(this);
  }
}

abstract class _DiscourseSearchGroup implements DiscourseSearchGroup {
  const factory _DiscourseSearchGroup({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'full_name') final String? fullName,
    @JsonKey(name: 'user_count') final int userCount,
  }) = _$DiscourseSearchGroupImpl;

  factory _DiscourseSearchGroup.fromJson(Map<String, dynamic> json) =
      _$DiscourseSearchGroupImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'full_name')
  String? get fullName;
  @override
  @JsonKey(name: 'user_count')
  int get userCount;

  /// Create a copy of DiscourseSearchGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseSearchGroupImplCopyWith<_$DiscourseSearchGroupImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseGroupedSearchResult _$DiscourseGroupedSearchResultFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseGroupedSearchResult.fromJson(json);
}

/// @nodoc
mixin _$DiscourseGroupedSearchResult {
  @JsonKey(name: 'more_posts')
  bool? get morePosts => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_users')
  bool? get moreUsers => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_categories')
  bool? get moreCategories => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_tags')
  bool? get moreTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'term')
  String? get term => throw _privateConstructorUsedError;
  @JsonKey(name: 'search_log_id')
  int? get searchLogId => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_full_page_results')
  bool? get moreFullPageResults => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_create_topic')
  bool? get canCreateTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'error')
  String? get error => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_ids')
  List<int> get postIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_ids')
  List<int> get userIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_ids')
  List<int> get categoryIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'tag_ids')
  List<int> get tagIds => throw _privateConstructorUsedError;
  @JsonKey(name: 'group_ids')
  List<int> get groupIds => throw _privateConstructorUsedError;

  /// Serializes this DiscourseGroupedSearchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseGroupedSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseGroupedSearchResultCopyWith<DiscourseGroupedSearchResult>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseGroupedSearchResultCopyWith<$Res> {
  factory $DiscourseGroupedSearchResultCopyWith(
    DiscourseGroupedSearchResult value,
    $Res Function(DiscourseGroupedSearchResult) then,
  ) =
      _$DiscourseGroupedSearchResultCopyWithImpl<
        $Res,
        DiscourseGroupedSearchResult
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'more_posts') bool? morePosts,
    @JsonKey(name: 'more_users') bool? moreUsers,
    @JsonKey(name: 'more_categories') bool? moreCategories,
    @JsonKey(name: 'more_tags') bool? moreTags,
    @JsonKey(name: 'term') String? term,
    @JsonKey(name: 'search_log_id') int? searchLogId,
    @JsonKey(name: 'more_full_page_results') bool? moreFullPageResults,
    @JsonKey(name: 'can_create_topic') bool? canCreateTopic,
    @JsonKey(name: 'error') String? error,
    @JsonKey(name: 'post_ids') List<int> postIds,
    @JsonKey(name: 'user_ids') List<int> userIds,
    @JsonKey(name: 'category_ids') List<int> categoryIds,
    @JsonKey(name: 'tag_ids') List<int> tagIds,
    @JsonKey(name: 'group_ids') List<int> groupIds,
  });
}

/// @nodoc
class _$DiscourseGroupedSearchResultCopyWithImpl<
  $Res,
  $Val extends DiscourseGroupedSearchResult
>
    implements $DiscourseGroupedSearchResultCopyWith<$Res> {
  _$DiscourseGroupedSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseGroupedSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? morePosts = freezed,
    Object? moreUsers = freezed,
    Object? moreCategories = freezed,
    Object? moreTags = freezed,
    Object? term = freezed,
    Object? searchLogId = freezed,
    Object? moreFullPageResults = freezed,
    Object? canCreateTopic = freezed,
    Object? error = freezed,
    Object? postIds = null,
    Object? userIds = null,
    Object? categoryIds = null,
    Object? tagIds = null,
    Object? groupIds = null,
  }) {
    return _then(
      _value.copyWith(
            morePosts: freezed == morePosts
                ? _value.morePosts
                : morePosts // ignore: cast_nullable_to_non_nullable
                      as bool?,
            moreUsers: freezed == moreUsers
                ? _value.moreUsers
                : moreUsers // ignore: cast_nullable_to_non_nullable
                      as bool?,
            moreCategories: freezed == moreCategories
                ? _value.moreCategories
                : moreCategories // ignore: cast_nullable_to_non_nullable
                      as bool?,
            moreTags: freezed == moreTags
                ? _value.moreTags
                : moreTags // ignore: cast_nullable_to_non_nullable
                      as bool?,
            term: freezed == term
                ? _value.term
                : term // ignore: cast_nullable_to_non_nullable
                      as String?,
            searchLogId: freezed == searchLogId
                ? _value.searchLogId
                : searchLogId // ignore: cast_nullable_to_non_nullable
                      as int?,
            moreFullPageResults: freezed == moreFullPageResults
                ? _value.moreFullPageResults
                : moreFullPageResults // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canCreateTopic: freezed == canCreateTopic
                ? _value.canCreateTopic
                : canCreateTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            postIds: null == postIds
                ? _value.postIds
                : postIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            userIds: null == userIds
                ? _value.userIds
                : userIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            categoryIds: null == categoryIds
                ? _value.categoryIds
                : categoryIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            tagIds: null == tagIds
                ? _value.tagIds
                : tagIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
            groupIds: null == groupIds
                ? _value.groupIds
                : groupIds // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseGroupedSearchResultImplCopyWith<$Res>
    implements $DiscourseGroupedSearchResultCopyWith<$Res> {
  factory _$$DiscourseGroupedSearchResultImplCopyWith(
    _$DiscourseGroupedSearchResultImpl value,
    $Res Function(_$DiscourseGroupedSearchResultImpl) then,
  ) = __$$DiscourseGroupedSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'more_posts') bool? morePosts,
    @JsonKey(name: 'more_users') bool? moreUsers,
    @JsonKey(name: 'more_categories') bool? moreCategories,
    @JsonKey(name: 'more_tags') bool? moreTags,
    @JsonKey(name: 'term') String? term,
    @JsonKey(name: 'search_log_id') int? searchLogId,
    @JsonKey(name: 'more_full_page_results') bool? moreFullPageResults,
    @JsonKey(name: 'can_create_topic') bool? canCreateTopic,
    @JsonKey(name: 'error') String? error,
    @JsonKey(name: 'post_ids') List<int> postIds,
    @JsonKey(name: 'user_ids') List<int> userIds,
    @JsonKey(name: 'category_ids') List<int> categoryIds,
    @JsonKey(name: 'tag_ids') List<int> tagIds,
    @JsonKey(name: 'group_ids') List<int> groupIds,
  });
}

/// @nodoc
class __$$DiscourseGroupedSearchResultImplCopyWithImpl<$Res>
    extends
        _$DiscourseGroupedSearchResultCopyWithImpl<
          $Res,
          _$DiscourseGroupedSearchResultImpl
        >
    implements _$$DiscourseGroupedSearchResultImplCopyWith<$Res> {
  __$$DiscourseGroupedSearchResultImplCopyWithImpl(
    _$DiscourseGroupedSearchResultImpl _value,
    $Res Function(_$DiscourseGroupedSearchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseGroupedSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? morePosts = freezed,
    Object? moreUsers = freezed,
    Object? moreCategories = freezed,
    Object? moreTags = freezed,
    Object? term = freezed,
    Object? searchLogId = freezed,
    Object? moreFullPageResults = freezed,
    Object? canCreateTopic = freezed,
    Object? error = freezed,
    Object? postIds = null,
    Object? userIds = null,
    Object? categoryIds = null,
    Object? tagIds = null,
    Object? groupIds = null,
  }) {
    return _then(
      _$DiscourseGroupedSearchResultImpl(
        morePosts: freezed == morePosts
            ? _value.morePosts
            : morePosts // ignore: cast_nullable_to_non_nullable
                  as bool?,
        moreUsers: freezed == moreUsers
            ? _value.moreUsers
            : moreUsers // ignore: cast_nullable_to_non_nullable
                  as bool?,
        moreCategories: freezed == moreCategories
            ? _value.moreCategories
            : moreCategories // ignore: cast_nullable_to_non_nullable
                  as bool?,
        moreTags: freezed == moreTags
            ? _value.moreTags
            : moreTags // ignore: cast_nullable_to_non_nullable
                  as bool?,
        term: freezed == term
            ? _value.term
            : term // ignore: cast_nullable_to_non_nullable
                  as String?,
        searchLogId: freezed == searchLogId
            ? _value.searchLogId
            : searchLogId // ignore: cast_nullable_to_non_nullable
                  as int?,
        moreFullPageResults: freezed == moreFullPageResults
            ? _value.moreFullPageResults
            : moreFullPageResults // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canCreateTopic: freezed == canCreateTopic
            ? _value.canCreateTopic
            : canCreateTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        postIds: null == postIds
            ? _value._postIds
            : postIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        userIds: null == userIds
            ? _value._userIds
            : userIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        categoryIds: null == categoryIds
            ? _value._categoryIds
            : categoryIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        tagIds: null == tagIds
            ? _value._tagIds
            : tagIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
        groupIds: null == groupIds
            ? _value._groupIds
            : groupIds // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseGroupedSearchResultImpl
    implements _DiscourseGroupedSearchResult {
  const _$DiscourseGroupedSearchResultImpl({
    @JsonKey(name: 'more_posts') this.morePosts,
    @JsonKey(name: 'more_users') this.moreUsers,
    @JsonKey(name: 'more_categories') this.moreCategories,
    @JsonKey(name: 'more_tags') this.moreTags,
    @JsonKey(name: 'term') this.term,
    @JsonKey(name: 'search_log_id') this.searchLogId,
    @JsonKey(name: 'more_full_page_results') this.moreFullPageResults,
    @JsonKey(name: 'can_create_topic') this.canCreateTopic,
    @JsonKey(name: 'error') this.error,
    @JsonKey(name: 'post_ids') final List<int> postIds = const [],
    @JsonKey(name: 'user_ids') final List<int> userIds = const [],
    @JsonKey(name: 'category_ids') final List<int> categoryIds = const [],
    @JsonKey(name: 'tag_ids') final List<int> tagIds = const [],
    @JsonKey(name: 'group_ids') final List<int> groupIds = const [],
  }) : _postIds = postIds,
       _userIds = userIds,
       _categoryIds = categoryIds,
       _tagIds = tagIds,
       _groupIds = groupIds;

  factory _$DiscourseGroupedSearchResultImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscourseGroupedSearchResultImplFromJson(json);

  @override
  @JsonKey(name: 'more_posts')
  final bool? morePosts;
  @override
  @JsonKey(name: 'more_users')
  final bool? moreUsers;
  @override
  @JsonKey(name: 'more_categories')
  final bool? moreCategories;
  @override
  @JsonKey(name: 'more_tags')
  final bool? moreTags;
  @override
  @JsonKey(name: 'term')
  final String? term;
  @override
  @JsonKey(name: 'search_log_id')
  final int? searchLogId;
  @override
  @JsonKey(name: 'more_full_page_results')
  final bool? moreFullPageResults;
  @override
  @JsonKey(name: 'can_create_topic')
  final bool? canCreateTopic;
  @override
  @JsonKey(name: 'error')
  final String? error;
  final List<int> _postIds;
  @override
  @JsonKey(name: 'post_ids')
  List<int> get postIds {
    if (_postIds is EqualUnmodifiableListView) return _postIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_postIds);
  }

  final List<int> _userIds;
  @override
  @JsonKey(name: 'user_ids')
  List<int> get userIds {
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIds);
  }

  final List<int> _categoryIds;
  @override
  @JsonKey(name: 'category_ids')
  List<int> get categoryIds {
    if (_categoryIds is EqualUnmodifiableListView) return _categoryIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categoryIds);
  }

  final List<int> _tagIds;
  @override
  @JsonKey(name: 'tag_ids')
  List<int> get tagIds {
    if (_tagIds is EqualUnmodifiableListView) return _tagIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tagIds);
  }

  final List<int> _groupIds;
  @override
  @JsonKey(name: 'group_ids')
  List<int> get groupIds {
    if (_groupIds is EqualUnmodifiableListView) return _groupIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groupIds);
  }

  @override
  String toString() {
    return 'DiscourseGroupedSearchResult(morePosts: $morePosts, moreUsers: $moreUsers, moreCategories: $moreCategories, moreTags: $moreTags, term: $term, searchLogId: $searchLogId, moreFullPageResults: $moreFullPageResults, canCreateTopic: $canCreateTopic, error: $error, postIds: $postIds, userIds: $userIds, categoryIds: $categoryIds, tagIds: $tagIds, groupIds: $groupIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseGroupedSearchResultImpl &&
            (identical(other.morePosts, morePosts) ||
                other.morePosts == morePosts) &&
            (identical(other.moreUsers, moreUsers) ||
                other.moreUsers == moreUsers) &&
            (identical(other.moreCategories, moreCategories) ||
                other.moreCategories == moreCategories) &&
            (identical(other.moreTags, moreTags) ||
                other.moreTags == moreTags) &&
            (identical(other.term, term) || other.term == term) &&
            (identical(other.searchLogId, searchLogId) ||
                other.searchLogId == searchLogId) &&
            (identical(other.moreFullPageResults, moreFullPageResults) ||
                other.moreFullPageResults == moreFullPageResults) &&
            (identical(other.canCreateTopic, canCreateTopic) ||
                other.canCreateTopic == canCreateTopic) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other._postIds, _postIds) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            const DeepCollectionEquality().equals(
              other._categoryIds,
              _categoryIds,
            ) &&
            const DeepCollectionEquality().equals(other._tagIds, _tagIds) &&
            const DeepCollectionEquality().equals(other._groupIds, _groupIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    morePosts,
    moreUsers,
    moreCategories,
    moreTags,
    term,
    searchLogId,
    moreFullPageResults,
    canCreateTopic,
    error,
    const DeepCollectionEquality().hash(_postIds),
    const DeepCollectionEquality().hash(_userIds),
    const DeepCollectionEquality().hash(_categoryIds),
    const DeepCollectionEquality().hash(_tagIds),
    const DeepCollectionEquality().hash(_groupIds),
  );

  /// Create a copy of DiscourseGroupedSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseGroupedSearchResultImplCopyWith<
    _$DiscourseGroupedSearchResultImpl
  >
  get copyWith =>
      __$$DiscourseGroupedSearchResultImplCopyWithImpl<
        _$DiscourseGroupedSearchResultImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseGroupedSearchResultImplToJson(this);
  }
}

abstract class _DiscourseGroupedSearchResult
    implements DiscourseGroupedSearchResult {
  const factory _DiscourseGroupedSearchResult({
    @JsonKey(name: 'more_posts') final bool? morePosts,
    @JsonKey(name: 'more_users') final bool? moreUsers,
    @JsonKey(name: 'more_categories') final bool? moreCategories,
    @JsonKey(name: 'more_tags') final bool? moreTags,
    @JsonKey(name: 'term') final String? term,
    @JsonKey(name: 'search_log_id') final int? searchLogId,
    @JsonKey(name: 'more_full_page_results') final bool? moreFullPageResults,
    @JsonKey(name: 'can_create_topic') final bool? canCreateTopic,
    @JsonKey(name: 'error') final String? error,
    @JsonKey(name: 'post_ids') final List<int> postIds,
    @JsonKey(name: 'user_ids') final List<int> userIds,
    @JsonKey(name: 'category_ids') final List<int> categoryIds,
    @JsonKey(name: 'tag_ids') final List<int> tagIds,
    @JsonKey(name: 'group_ids') final List<int> groupIds,
  }) = _$DiscourseGroupedSearchResultImpl;

  factory _DiscourseGroupedSearchResult.fromJson(Map<String, dynamic> json) =
      _$DiscourseGroupedSearchResultImpl.fromJson;

  @override
  @JsonKey(name: 'more_posts')
  bool? get morePosts;
  @override
  @JsonKey(name: 'more_users')
  bool? get moreUsers;
  @override
  @JsonKey(name: 'more_categories')
  bool? get moreCategories;
  @override
  @JsonKey(name: 'more_tags')
  bool? get moreTags;
  @override
  @JsonKey(name: 'term')
  String? get term;
  @override
  @JsonKey(name: 'search_log_id')
  int? get searchLogId;
  @override
  @JsonKey(name: 'more_full_page_results')
  bool? get moreFullPageResults;
  @override
  @JsonKey(name: 'can_create_topic')
  bool? get canCreateTopic;
  @override
  @JsonKey(name: 'error')
  String? get error;
  @override
  @JsonKey(name: 'post_ids')
  List<int> get postIds;
  @override
  @JsonKey(name: 'user_ids')
  List<int> get userIds;
  @override
  @JsonKey(name: 'category_ids')
  List<int> get categoryIds;
  @override
  @JsonKey(name: 'tag_ids')
  List<int> get tagIds;
  @override
  @JsonKey(name: 'group_ids')
  List<int> get groupIds;

  /// Create a copy of DiscourseGroupedSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseGroupedSearchResultImplCopyWith<
    _$DiscourseGroupedSearchResultImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
