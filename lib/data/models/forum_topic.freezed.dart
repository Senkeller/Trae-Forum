// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forum_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ForumTopic _$ForumTopicFromJson(Map<String, dynamic> json) {
  return _ForumTopic.fromJson(json);
}

/// @nodoc
mixin _$ForumTopic {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'excerpt')
  String? get excerpt => throw _privateConstructorUsedError;
  @JsonKey(name: 'author')
  ForumAuthor? get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'category')
  ForumCategory? get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<ForumTag> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_count')
  int get replyCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'view_count')
  int get viewCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_pinned')
  bool get isPinned => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_featured')
  bool get isFeatured => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_reply_at')
  String? get lastReplyAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_reply_author')
  ForumAuthor? get lastReplyAuthor => throw _privateConstructorUsedError;
  @JsonKey(name: 'cover_image')
  String? get coverImage => throw _privateConstructorUsedError;

  /// Serializes this ForumTopic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumTopicCopyWith<ForumTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumTopicCopyWith<$Res> {
  factory $ForumTopicCopyWith(
    ForumTopic value,
    $Res Function(ForumTopic) then,
  ) = _$ForumTopicCopyWithImpl<$Res, ForumTopic>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'content') String content,
    @JsonKey(name: 'excerpt') String? excerpt,
    @JsonKey(name: 'author') ForumAuthor? author,
    @JsonKey(name: 'category') ForumCategory? category,
    @JsonKey(name: 'tags') List<ForumTag> tags,
    @JsonKey(name: 'vote_count') int voteCount,
    @JsonKey(name: 'reply_count') int replyCount,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_pinned') bool isPinned,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'last_reply_at') String? lastReplyAt,
    @JsonKey(name: 'last_reply_author') ForumAuthor? lastReplyAuthor,
    @JsonKey(name: 'cover_image') String? coverImage,
  });

  $ForumAuthorCopyWith<$Res>? get author;
  $ForumCategoryCopyWith<$Res>? get category;
  $ForumAuthorCopyWith<$Res>? get lastReplyAuthor;
}

/// @nodoc
class _$ForumTopicCopyWithImpl<$Res, $Val extends ForumTopic>
    implements $ForumTopicCopyWith<$Res> {
  _$ForumTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? excerpt = freezed,
    Object? author = freezed,
    Object? category = freezed,
    Object? tags = null,
    Object? voteCount = null,
    Object? replyCount = null,
    Object? viewCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? lastReplyAt = freezed,
    Object? lastReplyAuthor = freezed,
    Object? coverImage = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            excerpt: freezed == excerpt
                ? _value.excerpt
                : excerpt // ignore: cast_nullable_to_non_nullable
                      as String?,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as ForumAuthor?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as ForumCategory?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<ForumTag>,
            voteCount: null == voteCount
                ? _value.voteCount
                : voteCount // ignore: cast_nullable_to_non_nullable
                      as int,
            replyCount: null == replyCount
                ? _value.replyCount
                : replyCount // ignore: cast_nullable_to_non_nullable
                      as int,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastReplyAt: freezed == lastReplyAt
                ? _value.lastReplyAt
                : lastReplyAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastReplyAuthor: freezed == lastReplyAuthor
                ? _value.lastReplyAuthor
                : lastReplyAuthor // ignore: cast_nullable_to_non_nullable
                      as ForumAuthor?,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForumAuthorCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $ForumAuthorCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForumCategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $ForumCategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForumAuthorCopyWith<$Res>? get lastReplyAuthor {
    if (_value.lastReplyAuthor == null) {
      return null;
    }

    return $ForumAuthorCopyWith<$Res>(_value.lastReplyAuthor!, (value) {
      return _then(_value.copyWith(lastReplyAuthor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ForumTopicImplCopyWith<$Res>
    implements $ForumTopicCopyWith<$Res> {
  factory _$$ForumTopicImplCopyWith(
    _$ForumTopicImpl value,
    $Res Function(_$ForumTopicImpl) then,
  ) = __$$ForumTopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'content') String content,
    @JsonKey(name: 'excerpt') String? excerpt,
    @JsonKey(name: 'author') ForumAuthor? author,
    @JsonKey(name: 'category') ForumCategory? category,
    @JsonKey(name: 'tags') List<ForumTag> tags,
    @JsonKey(name: 'vote_count') int voteCount,
    @JsonKey(name: 'reply_count') int replyCount,
    @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_pinned') bool isPinned,
    @JsonKey(name: 'is_featured') bool isFeatured,
    @JsonKey(name: 'last_reply_at') String? lastReplyAt,
    @JsonKey(name: 'last_reply_author') ForumAuthor? lastReplyAuthor,
    @JsonKey(name: 'cover_image') String? coverImage,
  });

  @override
  $ForumAuthorCopyWith<$Res>? get author;
  @override
  $ForumCategoryCopyWith<$Res>? get category;
  @override
  $ForumAuthorCopyWith<$Res>? get lastReplyAuthor;
}

/// @nodoc
class __$$ForumTopicImplCopyWithImpl<$Res>
    extends _$ForumTopicCopyWithImpl<$Res, _$ForumTopicImpl>
    implements _$$ForumTopicImplCopyWith<$Res> {
  __$$ForumTopicImplCopyWithImpl(
    _$ForumTopicImpl _value,
    $Res Function(_$ForumTopicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? excerpt = freezed,
    Object? author = freezed,
    Object? category = freezed,
    Object? tags = null,
    Object? voteCount = null,
    Object? replyCount = null,
    Object? viewCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isPinned = null,
    Object? isFeatured = null,
    Object? lastReplyAt = freezed,
    Object? lastReplyAuthor = freezed,
    Object? coverImage = freezed,
  }) {
    return _then(
      _$ForumTopicImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        excerpt: freezed == excerpt
            ? _value.excerpt
            : excerpt // ignore: cast_nullable_to_non_nullable
                  as String?,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as ForumAuthor?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as ForumCategory?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<ForumTag>,
        voteCount: null == voteCount
            ? _value.voteCount
            : voteCount // ignore: cast_nullable_to_non_nullable
                  as int,
        replyCount: null == replyCount
            ? _value.replyCount
            : replyCount // ignore: cast_nullable_to_non_nullable
                  as int,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastReplyAt: freezed == lastReplyAt
            ? _value.lastReplyAt
            : lastReplyAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastReplyAuthor: freezed == lastReplyAuthor
            ? _value.lastReplyAuthor
            : lastReplyAuthor // ignore: cast_nullable_to_non_nullable
                  as ForumAuthor?,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumTopicImpl implements _ForumTopic {
  const _$ForumTopicImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'content') this.content = '',
    @JsonKey(name: 'excerpt') this.excerpt,
    @JsonKey(name: 'author') this.author,
    @JsonKey(name: 'category') this.category,
    @JsonKey(name: 'tags') final List<ForumTag> tags = const [],
    @JsonKey(name: 'vote_count') this.voteCount = 0,
    @JsonKey(name: 'reply_count') this.replyCount = 0,
    @JsonKey(name: 'view_count') this.viewCount = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    @JsonKey(name: 'is_pinned') this.isPinned = false,
    @JsonKey(name: 'is_featured') this.isFeatured = false,
    @JsonKey(name: 'last_reply_at') this.lastReplyAt,
    @JsonKey(name: 'last_reply_author') this.lastReplyAuthor,
    @JsonKey(name: 'cover_image') this.coverImage,
  }) : _tags = tags;

  factory _$ForumTopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumTopicImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'content')
  final String content;
  @override
  @JsonKey(name: 'excerpt')
  final String? excerpt;
  @override
  @JsonKey(name: 'author')
  final ForumAuthor? author;
  @override
  @JsonKey(name: 'category')
  final ForumCategory? category;
  final List<ForumTag> _tags;
  @override
  @JsonKey(name: 'tags')
  List<ForumTag> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @override
  @JsonKey(name: 'reply_count')
  final int replyCount;
  @override
  @JsonKey(name: 'view_count')
  final int viewCount;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'is_pinned')
  final bool isPinned;
  @override
  @JsonKey(name: 'is_featured')
  final bool isFeatured;
  @override
  @JsonKey(name: 'last_reply_at')
  final String? lastReplyAt;
  @override
  @JsonKey(name: 'last_reply_author')
  final ForumAuthor? lastReplyAuthor;
  @override
  @JsonKey(name: 'cover_image')
  final String? coverImage;

  @override
  String toString() {
    return 'ForumTopic(id: $id, title: $title, content: $content, excerpt: $excerpt, author: $author, category: $category, tags: $tags, voteCount: $voteCount, replyCount: $replyCount, viewCount: $viewCount, createdAt: $createdAt, updatedAt: $updatedAt, isPinned: $isPinned, isFeatured: $isFeatured, lastReplyAt: $lastReplyAt, lastReplyAuthor: $lastReplyAuthor, coverImage: $coverImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumTopicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured) &&
            (identical(other.lastReplyAt, lastReplyAt) ||
                other.lastReplyAt == lastReplyAt) &&
            (identical(other.lastReplyAuthor, lastReplyAuthor) ||
                other.lastReplyAuthor == lastReplyAuthor) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    content,
    excerpt,
    author,
    category,
    const DeepCollectionEquality().hash(_tags),
    voteCount,
    replyCount,
    viewCount,
    createdAt,
    updatedAt,
    isPinned,
    isFeatured,
    lastReplyAt,
    lastReplyAuthor,
    coverImage,
  );

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumTopicImplCopyWith<_$ForumTopicImpl> get copyWith =>
      __$$ForumTopicImplCopyWithImpl<_$ForumTopicImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumTopicImplToJson(this);
  }
}

abstract class _ForumTopic implements ForumTopic {
  const factory _ForumTopic({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'content') final String content,
    @JsonKey(name: 'excerpt') final String? excerpt,
    @JsonKey(name: 'author') final ForumAuthor? author,
    @JsonKey(name: 'category') final ForumCategory? category,
    @JsonKey(name: 'tags') final List<ForumTag> tags,
    @JsonKey(name: 'vote_count') final int voteCount,
    @JsonKey(name: 'reply_count') final int replyCount,
    @JsonKey(name: 'view_count') final int viewCount,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    @JsonKey(name: 'is_pinned') final bool isPinned,
    @JsonKey(name: 'is_featured') final bool isFeatured,
    @JsonKey(name: 'last_reply_at') final String? lastReplyAt,
    @JsonKey(name: 'last_reply_author') final ForumAuthor? lastReplyAuthor,
    @JsonKey(name: 'cover_image') final String? coverImage,
  }) = _$ForumTopicImpl;

  factory _ForumTopic.fromJson(Map<String, dynamic> json) =
      _$ForumTopicImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'content')
  String get content;
  @override
  @JsonKey(name: 'excerpt')
  String? get excerpt;
  @override
  @JsonKey(name: 'author')
  ForumAuthor? get author;
  @override
  @JsonKey(name: 'category')
  ForumCategory? get category;
  @override
  @JsonKey(name: 'tags')
  List<ForumTag> get tags;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  @JsonKey(name: 'reply_count')
  int get replyCount;
  @override
  @JsonKey(name: 'view_count')
  int get viewCount;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'is_pinned')
  bool get isPinned;
  @override
  @JsonKey(name: 'is_featured')
  bool get isFeatured;
  @override
  @JsonKey(name: 'last_reply_at')
  String? get lastReplyAt;
  @override
  @JsonKey(name: 'last_reply_author')
  ForumAuthor? get lastReplyAuthor;
  @override
  @JsonKey(name: 'cover_image')
  String? get coverImage;

  /// Create a copy of ForumTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumTopicImplCopyWith<_$ForumTopicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForumAuthor _$ForumAuthorFromJson(Map<String, dynamic> json) {
  return _ForumAuthor.fromJson(json);
}

/// @nodoc
mixin _$ForumAuthor {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'level')
  int get level => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_admin')
  bool get isAdmin => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_moderator')
  bool get isModerator => throw _privateConstructorUsedError;

  /// Serializes this ForumAuthor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumAuthorCopyWith<ForumAuthor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumAuthorCopyWith<$Res> {
  factory $ForumAuthorCopyWith(
    ForumAuthor value,
    $Res Function(ForumAuthor) then,
  ) = _$ForumAuthorCopyWithImpl<$Res, ForumAuthor>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'level') int level,
    @JsonKey(name: 'is_admin') bool isAdmin,
    @JsonKey(name: 'is_moderator') bool isModerator,
  });
}

/// @nodoc
class _$ForumAuthorCopyWithImpl<$Res, $Val extends ForumAuthor>
    implements $ForumAuthorCopyWith<$Res> {
  _$ForumAuthorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? level = null,
    Object? isAdmin = null,
    Object? isModerator = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: freezed == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            isAdmin: null == isAdmin
                ? _value.isAdmin
                : isAdmin // ignore: cast_nullable_to_non_nullable
                      as bool,
            isModerator: null == isModerator
                ? _value.isModerator
                : isModerator // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumAuthorImplCopyWith<$Res>
    implements $ForumAuthorCopyWith<$Res> {
  factory _$$ForumAuthorImplCopyWith(
    _$ForumAuthorImpl value,
    $Res Function(_$ForumAuthorImpl) then,
  ) = __$$ForumAuthorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'level') int level,
    @JsonKey(name: 'is_admin') bool isAdmin,
    @JsonKey(name: 'is_moderator') bool isModerator,
  });
}

/// @nodoc
class __$$ForumAuthorImplCopyWithImpl<$Res>
    extends _$ForumAuthorCopyWithImpl<$Res, _$ForumAuthorImpl>
    implements _$$ForumAuthorImplCopyWith<$Res> {
  __$$ForumAuthorImplCopyWithImpl(
    _$ForumAuthorImpl _value,
    $Res Function(_$ForumAuthorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumAuthor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? displayName = freezed,
    Object? avatarUrl = freezed,
    Object? level = null,
    Object? isAdmin = null,
    Object? isModerator = null,
  }) {
    return _then(
      _$ForumAuthorImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: freezed == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        isAdmin: null == isAdmin
            ? _value.isAdmin
            : isAdmin // ignore: cast_nullable_to_non_nullable
                  as bool,
        isModerator: null == isModerator
            ? _value.isModerator
            : isModerator // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumAuthorImpl implements _ForumAuthor {
  const _$ForumAuthorImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'display_name') this.displayName,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'level') this.level = 1,
    @JsonKey(name: 'is_admin') this.isAdmin = false,
    @JsonKey(name: 'is_moderator') this.isModerator = false,
  });

  factory _$ForumAuthorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumAuthorImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'username')
  final String username;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'level')
  final int level;
  @override
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
  @override
  @JsonKey(name: 'is_moderator')
  final bool isModerator;

  @override
  String toString() {
    return 'ForumAuthor(id: $id, username: $username, displayName: $displayName, avatarUrl: $avatarUrl, level: $level, isAdmin: $isAdmin, isModerator: $isModerator)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumAuthorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.isAdmin, isAdmin) || other.isAdmin == isAdmin) &&
            (identical(other.isModerator, isModerator) ||
                other.isModerator == isModerator));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    displayName,
    avatarUrl,
    level,
    isAdmin,
    isModerator,
  );

  /// Create a copy of ForumAuthor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumAuthorImplCopyWith<_$ForumAuthorImpl> get copyWith =>
      __$$ForumAuthorImplCopyWithImpl<_$ForumAuthorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumAuthorImplToJson(this);
  }
}

abstract class _ForumAuthor implements ForumAuthor {
  const factory _ForumAuthor({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'display_name') final String? displayName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'level') final int level,
    @JsonKey(name: 'is_admin') final bool isAdmin,
    @JsonKey(name: 'is_moderator') final bool isModerator,
  }) = _$ForumAuthorImpl;

  factory _ForumAuthor.fromJson(Map<String, dynamic> json) =
      _$ForumAuthorImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'username')
  String get username;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'level')
  int get level;
  @override
  @JsonKey(name: 'is_admin')
  bool get isAdmin;
  @override
  @JsonKey(name: 'is_moderator')
  bool get isModerator;

  /// Create a copy of ForumAuthor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumAuthorImplCopyWith<_$ForumAuthorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForumCategory _$ForumCategoryFromJson(Map<String, dynamic> json) {
  return _ForumCategory.fromJson(json);
}

/// @nodoc
mixin _$ForumCategory {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'icon')
  String? get icon => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_count')
  int get topicCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_order')
  int get displayOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;

  /// Serializes this ForumCategory to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumCategoryCopyWith<ForumCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumCategoryCopyWith<$Res> {
  factory $ForumCategoryCopyWith(
    ForumCategory value,
    $Res Function(ForumCategory) then,
  ) = _$ForumCategoryCopyWithImpl<$Res, ForumCategory>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'icon') String? icon,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'display_order') int displayOrder,
    @JsonKey(name: 'parent_id') String? parentId,
  });
}

/// @nodoc
class _$ForumCategoryCopyWithImpl<$Res, $Val extends ForumCategory>
    implements $ForumCategoryCopyWith<$Res> {
  _$ForumCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? topicCount = null,
    Object? displayOrder = null,
    Object? parentId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            topicCount: null == topicCount
                ? _value.topicCount
                : topicCount // ignore: cast_nullable_to_non_nullable
                      as int,
            displayOrder: null == displayOrder
                ? _value.displayOrder
                : displayOrder // ignore: cast_nullable_to_non_nullable
                      as int,
            parentId: freezed == parentId
                ? _value.parentId
                : parentId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumCategoryImplCopyWith<$Res>
    implements $ForumCategoryCopyWith<$Res> {
  factory _$$ForumCategoryImplCopyWith(
    _$ForumCategoryImpl value,
    $Res Function(_$ForumCategoryImpl) then,
  ) = __$$ForumCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'icon') String? icon,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'topic_count') int topicCount,
    @JsonKey(name: 'display_order') int displayOrder,
    @JsonKey(name: 'parent_id') String? parentId,
  });
}

/// @nodoc
class __$$ForumCategoryImplCopyWithImpl<$Res>
    extends _$ForumCategoryCopyWithImpl<$Res, _$ForumCategoryImpl>
    implements _$$ForumCategoryImplCopyWith<$Res> {
  __$$ForumCategoryImplCopyWithImpl(
    _$ForumCategoryImpl _value,
    $Res Function(_$ForumCategoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumCategory
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? description = freezed,
    Object? icon = freezed,
    Object? color = freezed,
    Object? topicCount = null,
    Object? displayOrder = null,
    Object? parentId = freezed,
  }) {
    return _then(
      _$ForumCategoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        topicCount: null == topicCount
            ? _value.topicCount
            : topicCount // ignore: cast_nullable_to_non_nullable
                  as int,
        displayOrder: null == displayOrder
            ? _value.displayOrder
            : displayOrder // ignore: cast_nullable_to_non_nullable
                  as int,
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumCategoryImpl implements _ForumCategory {
  const _$ForumCategoryImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'description') this.description,
    @JsonKey(name: 'icon') this.icon,
    @JsonKey(name: 'color') this.color,
    @JsonKey(name: 'topic_count') this.topicCount = 0,
    @JsonKey(name: 'display_order') this.displayOrder = 0,
    @JsonKey(name: 'parent_id') this.parentId,
  });

  factory _$ForumCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumCategoryImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'slug')
  final String slug;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'icon')
  final String? icon;
  @override
  @JsonKey(name: 'color')
  final String? color;
  @override
  @JsonKey(name: 'topic_count')
  final int topicCount;
  @override
  @JsonKey(name: 'display_order')
  final int displayOrder;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;

  @override
  String toString() {
    return 'ForumCategory(id: $id, name: $name, slug: $slug, description: $description, icon: $icon, color: $color, topicCount: $topicCount, displayOrder: $displayOrder, parentId: $parentId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumCategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.topicCount, topicCount) ||
                other.topicCount == topicCount) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    slug,
    description,
    icon,
    color,
    topicCount,
    displayOrder,
    parentId,
  );

  /// Create a copy of ForumCategory
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumCategoryImplCopyWith<_$ForumCategoryImpl> get copyWith =>
      __$$ForumCategoryImplCopyWithImpl<_$ForumCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumCategoryImplToJson(this);
  }
}

abstract class _ForumCategory implements ForumCategory {
  const factory _ForumCategory({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'description') final String? description,
    @JsonKey(name: 'icon') final String? icon,
    @JsonKey(name: 'color') final String? color,
    @JsonKey(name: 'topic_count') final int topicCount,
    @JsonKey(name: 'display_order') final int displayOrder,
    @JsonKey(name: 'parent_id') final String? parentId,
  }) = _$ForumCategoryImpl;

  factory _ForumCategory.fromJson(Map<String, dynamic> json) =
      _$ForumCategoryImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'slug')
  String get slug;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'icon')
  String? get icon;
  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(name: 'topic_count')
  int get topicCount;
  @override
  @JsonKey(name: 'display_order')
  int get displayOrder;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;

  /// Create a copy of ForumCategory
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumCategoryImplCopyWith<_$ForumCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForumTag _$ForumTagFromJson(Map<String, dynamic> json) {
  return _ForumTag.fromJson(json);
}

/// @nodoc
mixin _$ForumTag {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'color')
  String? get color => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_count')
  int get topicCount => throw _privateConstructorUsedError;

  /// Serializes this ForumTag to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumTagCopyWith<ForumTag> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumTagCopyWith<$Res> {
  factory $ForumTagCopyWith(ForumTag value, $Res Function(ForumTag) then) =
      _$ForumTagCopyWithImpl<$Res, ForumTag>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'topic_count') int topicCount,
  });
}

/// @nodoc
class _$ForumTagCopyWithImpl<$Res, $Val extends ForumTag>
    implements $ForumTagCopyWith<$Res> {
  _$ForumTagCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? color = freezed,
    Object? topicCount = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
            topicCount: null == topicCount
                ? _value.topicCount
                : topicCount // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumTagImplCopyWith<$Res>
    implements $ForumTagCopyWith<$Res> {
  factory _$$ForumTagImplCopyWith(
    _$ForumTagImpl value,
    $Res Function(_$ForumTagImpl) then,
  ) = __$$ForumTagImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'color') String? color,
    @JsonKey(name: 'topic_count') int topicCount,
  });
}

/// @nodoc
class __$$ForumTagImplCopyWithImpl<$Res>
    extends _$ForumTagCopyWithImpl<$Res, _$ForumTagImpl>
    implements _$$ForumTagImplCopyWith<$Res> {
  __$$ForumTagImplCopyWithImpl(
    _$ForumTagImpl _value,
    $Res Function(_$ForumTagImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumTag
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? slug = null,
    Object? color = freezed,
    Object? topicCount = null,
  }) {
    return _then(
      _$ForumTagImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
        topicCount: null == topicCount
            ? _value.topicCount
            : topicCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumTagImpl implements _ForumTag {
  const _$ForumTagImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'color') this.color,
    @JsonKey(name: 'topic_count') this.topicCount = 0,
  });

  factory _$ForumTagImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumTagImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'slug')
  final String slug;
  @override
  @JsonKey(name: 'color')
  final String? color;
  @override
  @JsonKey(name: 'topic_count')
  final int topicCount;

  @override
  String toString() {
    return 'ForumTag(id: $id, name: $name, slug: $slug, color: $color, topicCount: $topicCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumTagImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.topicCount, topicCount) ||
                other.topicCount == topicCount));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, slug, color, topicCount);

  /// Create a copy of ForumTag
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumTagImplCopyWith<_$ForumTagImpl> get copyWith =>
      __$$ForumTagImplCopyWithImpl<_$ForumTagImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumTagImplToJson(this);
  }
}

abstract class _ForumTag implements ForumTag {
  const factory _ForumTag({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'color') final String? color,
    @JsonKey(name: 'topic_count') final int topicCount,
  }) = _$ForumTagImpl;

  factory _ForumTag.fromJson(Map<String, dynamic> json) =
      _$ForumTagImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'slug')
  String get slug;
  @override
  @JsonKey(name: 'color')
  String? get color;
  @override
  @JsonKey(name: 'topic_count')
  int get topicCount;

  /// Create a copy of ForumTag
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumTagImplCopyWith<_$ForumTagImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForumReply _$ForumReplyFromJson(Map<String, dynamic> json) {
  return _ForumReply.fromJson(json);
}

/// @nodoc
mixin _$ForumReply {
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_id')
  String get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'content')
  String get content => throw _privateConstructorUsedError;
  @JsonKey(name: 'author')
  ForumAuthor? get author => throw _privateConstructorUsedError;
  @JsonKey(name: 'parent_id')
  String? get parentId => throw _privateConstructorUsedError;
  @JsonKey(name: 'vote_count')
  int get voteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_accepted')
  bool get isAccepted => throw _privateConstructorUsedError;
  @JsonKey(name: 'replies')
  List<ForumReply> get replies => throw _privateConstructorUsedError;

  /// Serializes this ForumReply to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumReplyCopyWith<ForumReply> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumReplyCopyWith<$Res> {
  factory $ForumReplyCopyWith(
    ForumReply value,
    $Res Function(ForumReply) then,
  ) = _$ForumReplyCopyWithImpl<$Res, ForumReply>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'topic_id') String topicId,
    @JsonKey(name: 'content') String content,
    @JsonKey(name: 'author') ForumAuthor? author,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'vote_count') int voteCount,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_accepted') bool isAccepted,
    @JsonKey(name: 'replies') List<ForumReply> replies,
  });

  $ForumAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class _$ForumReplyCopyWithImpl<$Res, $Val extends ForumReply>
    implements $ForumReplyCopyWith<$Res> {
  _$ForumReplyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = null,
    Object? content = null,
    Object? author = freezed,
    Object? parentId = freezed,
    Object? voteCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isAccepted = null,
    Object? replies = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            topicId: null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as ForumAuthor?,
            parentId: freezed == parentId
                ? _value.parentId
                : parentId // ignore: cast_nullable_to_non_nullable
                      as String?,
            voteCount: null == voteCount
                ? _value.voteCount
                : voteCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            isAccepted: null == isAccepted
                ? _value.isAccepted
                : isAccepted // ignore: cast_nullable_to_non_nullable
                      as bool,
            replies: null == replies
                ? _value.replies
                : replies // ignore: cast_nullable_to_non_nullable
                      as List<ForumReply>,
          )
          as $Val,
    );
  }

  /// Create a copy of ForumReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForumAuthorCopyWith<$Res>? get author {
    if (_value.author == null) {
      return null;
    }

    return $ForumAuthorCopyWith<$Res>(_value.author!, (value) {
      return _then(_value.copyWith(author: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ForumReplyImplCopyWith<$Res>
    implements $ForumReplyCopyWith<$Res> {
  factory _$$ForumReplyImplCopyWith(
    _$ForumReplyImpl value,
    $Res Function(_$ForumReplyImpl) then,
  ) = __$$ForumReplyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') String id,
    @JsonKey(name: 'topic_id') String topicId,
    @JsonKey(name: 'content') String content,
    @JsonKey(name: 'author') ForumAuthor? author,
    @JsonKey(name: 'parent_id') String? parentId,
    @JsonKey(name: 'vote_count') int voteCount,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'is_accepted') bool isAccepted,
    @JsonKey(name: 'replies') List<ForumReply> replies,
  });

  @override
  $ForumAuthorCopyWith<$Res>? get author;
}

/// @nodoc
class __$$ForumReplyImplCopyWithImpl<$Res>
    extends _$ForumReplyCopyWithImpl<$Res, _$ForumReplyImpl>
    implements _$$ForumReplyImplCopyWith<$Res> {
  __$$ForumReplyImplCopyWithImpl(
    _$ForumReplyImpl _value,
    $Res Function(_$ForumReplyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumReply
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = null,
    Object? content = null,
    Object? author = freezed,
    Object? parentId = freezed,
    Object? voteCount = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? isAccepted = null,
    Object? replies = null,
  }) {
    return _then(
      _$ForumReplyImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        topicId: null == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as ForumAuthor?,
        parentId: freezed == parentId
            ? _value.parentId
            : parentId // ignore: cast_nullable_to_non_nullable
                  as String?,
        voteCount: null == voteCount
            ? _value.voteCount
            : voteCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        isAccepted: null == isAccepted
            ? _value.isAccepted
            : isAccepted // ignore: cast_nullable_to_non_nullable
                  as bool,
        replies: null == replies
            ? _value._replies
            : replies // ignore: cast_nullable_to_non_nullable
                  as List<ForumReply>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumReplyImpl implements _ForumReply {
  const _$ForumReplyImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'topic_id') required this.topicId,
    @JsonKey(name: 'content') required this.content,
    @JsonKey(name: 'author') this.author,
    @JsonKey(name: 'parent_id') this.parentId,
    @JsonKey(name: 'vote_count') this.voteCount = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    @JsonKey(name: 'is_accepted') this.isAccepted = false,
    @JsonKey(name: 'replies') final List<ForumReply> replies = const [],
  }) : _replies = replies;

  factory _$ForumReplyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumReplyImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final String id;
  @override
  @JsonKey(name: 'topic_id')
  final String topicId;
  @override
  @JsonKey(name: 'content')
  final String content;
  @override
  @JsonKey(name: 'author')
  final ForumAuthor? author;
  @override
  @JsonKey(name: 'parent_id')
  final String? parentId;
  @override
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'is_accepted')
  final bool isAccepted;
  final List<ForumReply> _replies;
  @override
  @JsonKey(name: 'replies')
  List<ForumReply> get replies {
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_replies);
  }

  @override
  String toString() {
    return 'ForumReply(id: $id, topicId: $topicId, content: $content, author: $author, parentId: $parentId, voteCount: $voteCount, createdAt: $createdAt, updatedAt: $updatedAt, isAccepted: $isAccepted, replies: $replies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumReplyImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.isAccepted, isAccepted) ||
                other.isAccepted == isAccepted) &&
            const DeepCollectionEquality().equals(other._replies, _replies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    topicId,
    content,
    author,
    parentId,
    voteCount,
    createdAt,
    updatedAt,
    isAccepted,
    const DeepCollectionEquality().hash(_replies),
  );

  /// Create a copy of ForumReply
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumReplyImplCopyWith<_$ForumReplyImpl> get copyWith =>
      __$$ForumReplyImplCopyWithImpl<_$ForumReplyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumReplyImplToJson(this);
  }
}

abstract class _ForumReply implements ForumReply {
  const factory _ForumReply({
    @JsonKey(name: 'id') required final String id,
    @JsonKey(name: 'topic_id') required final String topicId,
    @JsonKey(name: 'content') required final String content,
    @JsonKey(name: 'author') final ForumAuthor? author,
    @JsonKey(name: 'parent_id') final String? parentId,
    @JsonKey(name: 'vote_count') final int voteCount,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    @JsonKey(name: 'is_accepted') final bool isAccepted,
    @JsonKey(name: 'replies') final List<ForumReply> replies,
  }) = _$ForumReplyImpl;

  factory _ForumReply.fromJson(Map<String, dynamic> json) =
      _$ForumReplyImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  String get id;
  @override
  @JsonKey(name: 'topic_id')
  String get topicId;
  @override
  @JsonKey(name: 'content')
  String get content;
  @override
  @JsonKey(name: 'author')
  ForumAuthor? get author;
  @override
  @JsonKey(name: 'parent_id')
  String? get parentId;
  @override
  @JsonKey(name: 'vote_count')
  int get voteCount;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'is_accepted')
  bool get isAccepted;
  @override
  @JsonKey(name: 'replies')
  List<ForumReply> get replies;

  /// Create a copy of ForumReply
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumReplyImplCopyWith<_$ForumReplyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ForumTopicListResponse _$ForumTopicListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ForumTopicListResponse.fromJson(json);
}

/// @nodoc
mixin _$ForumTopicListResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<ForumTopic> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool get hasMore => throw _privateConstructorUsedError;

  /// Serializes this ForumTopicListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumTopicListResponseCopyWith<ForumTopicListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumTopicListResponseCopyWith<$Res> {
  factory $ForumTopicListResponseCopyWith(
    ForumTopicListResponse value,
    $Res Function(ForumTopicListResponse) then,
  ) = _$ForumTopicListResponseCopyWithImpl<$Res, ForumTopicListResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumTopic> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class _$ForumTopicListResponseCopyWithImpl<
  $Res,
  $Val extends ForumTopicListResponse
>
    implements $ForumTopicListResponseCopyWith<$Res> {
  _$ForumTopicListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? perPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<ForumTopic>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumTopicListResponseImplCopyWith<$Res>
    implements $ForumTopicListResponseCopyWith<$Res> {
  factory _$$ForumTopicListResponseImplCopyWith(
    _$ForumTopicListResponseImpl value,
    $Res Function(_$ForumTopicListResponseImpl) then,
  ) = __$$ForumTopicListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumTopic> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class __$$ForumTopicListResponseImplCopyWithImpl<$Res>
    extends
        _$ForumTopicListResponseCopyWithImpl<$Res, _$ForumTopicListResponseImpl>
    implements _$$ForumTopicListResponseImplCopyWith<$Res> {
  __$$ForumTopicListResponseImplCopyWithImpl(
    _$ForumTopicListResponseImpl _value,
    $Res Function(_$ForumTopicListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? perPage = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$ForumTopicListResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<ForumTopic>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumTopicListResponseImpl implements _ForumTopicListResponse {
  const _$ForumTopicListResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<ForumTopic> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'page') this.page = 1,
    @JsonKey(name: 'per_page') this.perPage = 20,
    @JsonKey(name: 'has_more') this.hasMore = false,
  }) : _data = data;

  factory _$ForumTopicListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumTopicListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<ForumTopic> _data;
  @override
  @JsonKey(name: 'data')
  List<ForumTopic> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'total')
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  @override
  @JsonKey(name: 'has_more')
  final bool hasMore;

  @override
  String toString() {
    return 'ForumTopicListResponse(status: $status, message: $message, data: $data, total: $total, page: $page, perPage: $perPage, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumTopicListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
    total,
    page,
    perPage,
    hasMore,
  );

  /// Create a copy of ForumTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumTopicListResponseImplCopyWith<_$ForumTopicListResponseImpl>
  get copyWith =>
      __$$ForumTopicListResponseImplCopyWithImpl<_$ForumTopicListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumTopicListResponseImplToJson(this);
  }
}

abstract class _ForumTopicListResponse implements ForumTopicListResponse {
  const factory _ForumTopicListResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<ForumTopic> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'page') final int page,
    @JsonKey(name: 'per_page') final int perPage,
    @JsonKey(name: 'has_more') final bool hasMore,
  }) = _$ForumTopicListResponseImpl;

  factory _ForumTopicListResponse.fromJson(Map<String, dynamic> json) =
      _$ForumTopicListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<ForumTopic> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'has_more')
  bool get hasMore;

  /// Create a copy of ForumTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumTopicListResponseImplCopyWith<_$ForumTopicListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ForumTopicDetailResponse _$ForumTopicDetailResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ForumTopicDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$ForumTopicDetailResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  ForumTopic? get data => throw _privateConstructorUsedError;

  /// Serializes this ForumTopicDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumTopicDetailResponseCopyWith<ForumTopicDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumTopicDetailResponseCopyWith<$Res> {
  factory $ForumTopicDetailResponseCopyWith(
    ForumTopicDetailResponse value,
    $Res Function(ForumTopicDetailResponse) then,
  ) = _$ForumTopicDetailResponseCopyWithImpl<$Res, ForumTopicDetailResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') ForumTopic? data,
  });

  $ForumTopicCopyWith<$Res>? get data;
}

/// @nodoc
class _$ForumTopicDetailResponseCopyWithImpl<
  $Res,
  $Val extends ForumTopicDetailResponse
>
    implements $ForumTopicDetailResponseCopyWith<$Res> {
  _$ForumTopicDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: freezed == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as ForumTopic?,
          )
          as $Val,
    );
  }

  /// Create a copy of ForumTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ForumTopicCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $ForumTopicCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ForumTopicDetailResponseImplCopyWith<$Res>
    implements $ForumTopicDetailResponseCopyWith<$Res> {
  factory _$$ForumTopicDetailResponseImplCopyWith(
    _$ForumTopicDetailResponseImpl value,
    $Res Function(_$ForumTopicDetailResponseImpl) then,
  ) = __$$ForumTopicDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') ForumTopic? data,
  });

  @override
  $ForumTopicCopyWith<$Res>? get data;
}

/// @nodoc
class __$$ForumTopicDetailResponseImplCopyWithImpl<$Res>
    extends
        _$ForumTopicDetailResponseCopyWithImpl<
          $Res,
          _$ForumTopicDetailResponseImpl
        >
    implements _$$ForumTopicDetailResponseImplCopyWith<$Res> {
  __$$ForumTopicDetailResponseImplCopyWithImpl(
    _$ForumTopicDetailResponseImpl _value,
    $Res Function(_$ForumTopicDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(
      _$ForumTopicDetailResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: freezed == data
            ? _value.data
            : data // ignore: cast_nullable_to_non_nullable
                  as ForumTopic?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumTopicDetailResponseImpl implements _ForumTopicDetailResponse {
  const _$ForumTopicDetailResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') this.data,
  });

  factory _$ForumTopicDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumTopicDetailResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  @override
  @JsonKey(name: 'data')
  final ForumTopic? data;

  @override
  String toString() {
    return 'ForumTopicDetailResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumTopicDetailResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message, data);

  /// Create a copy of ForumTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumTopicDetailResponseImplCopyWith<_$ForumTopicDetailResponseImpl>
  get copyWith =>
      __$$ForumTopicDetailResponseImplCopyWithImpl<
        _$ForumTopicDetailResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumTopicDetailResponseImplToJson(this);
  }
}

abstract class _ForumTopicDetailResponse implements ForumTopicDetailResponse {
  const factory _ForumTopicDetailResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final ForumTopic? data,
  }) = _$ForumTopicDetailResponseImpl;

  factory _ForumTopicDetailResponse.fromJson(Map<String, dynamic> json) =
      _$ForumTopicDetailResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  ForumTopic? get data;

  /// Create a copy of ForumTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumTopicDetailResponseImplCopyWith<_$ForumTopicDetailResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ForumReplyListResponse _$ForumReplyListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ForumReplyListResponse.fromJson(json);
}

/// @nodoc
mixin _$ForumReplyListResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<ForumReply> get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'total')
  int get total => throw _privateConstructorUsedError;
  @JsonKey(name: 'page')
  int get page => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_more')
  bool get hasMore => throw _privateConstructorUsedError;

  /// Serializes this ForumReplyListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumReplyListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumReplyListResponseCopyWith<ForumReplyListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumReplyListResponseCopyWith<$Res> {
  factory $ForumReplyListResponseCopyWith(
    ForumReplyListResponse value,
    $Res Function(ForumReplyListResponse) then,
  ) = _$ForumReplyListResponseCopyWithImpl<$Res, ForumReplyListResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumReply> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class _$ForumReplyListResponseCopyWithImpl<
  $Res,
  $Val extends ForumReplyListResponse
>
    implements $ForumReplyListResponseCopyWith<$Res> {
  _$ForumReplyListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumReplyListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? hasMore = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<ForumReply>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
            page: null == page
                ? _value.page
                : page // ignore: cast_nullable_to_non_nullable
                      as int,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumReplyListResponseImplCopyWith<$Res>
    implements $ForumReplyListResponseCopyWith<$Res> {
  factory _$$ForumReplyListResponseImplCopyWith(
    _$ForumReplyListResponseImpl value,
    $Res Function(_$ForumReplyListResponseImpl) then,
  ) = __$$ForumReplyListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumReply> data,
    @JsonKey(name: 'total') int total,
    @JsonKey(name: 'page') int page,
    @JsonKey(name: 'has_more') bool hasMore,
  });
}

/// @nodoc
class __$$ForumReplyListResponseImplCopyWithImpl<$Res>
    extends
        _$ForumReplyListResponseCopyWithImpl<$Res, _$ForumReplyListResponseImpl>
    implements _$$ForumReplyListResponseImplCopyWith<$Res> {
  __$$ForumReplyListResponseImplCopyWithImpl(
    _$ForumReplyListResponseImpl _value,
    $Res Function(_$ForumReplyListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumReplyListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
    Object? total = null,
    Object? page = null,
    Object? hasMore = null,
  }) {
    return _then(
      _$ForumReplyListResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<ForumReply>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
        page: null == page
            ? _value.page
            : page // ignore: cast_nullable_to_non_nullable
                  as int,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumReplyListResponseImpl implements _ForumReplyListResponse {
  const _$ForumReplyListResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<ForumReply> data = const [],
    @JsonKey(name: 'total') this.total = 0,
    @JsonKey(name: 'page') this.page = 1,
    @JsonKey(name: 'has_more') this.hasMore = false,
  }) : _data = data;

  factory _$ForumReplyListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumReplyListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<ForumReply> _data;
  @override
  @JsonKey(name: 'data')
  List<ForumReply> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  @JsonKey(name: 'total')
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'has_more')
  final bool hasMore;

  @override
  String toString() {
    return 'ForumReplyListResponse(status: $status, message: $message, data: $data, total: $total, page: $page, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumReplyListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
    total,
    page,
    hasMore,
  );

  /// Create a copy of ForumReplyListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumReplyListResponseImplCopyWith<_$ForumReplyListResponseImpl>
  get copyWith =>
      __$$ForumReplyListResponseImplCopyWithImpl<_$ForumReplyListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumReplyListResponseImplToJson(this);
  }
}

abstract class _ForumReplyListResponse implements ForumReplyListResponse {
  const factory _ForumReplyListResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<ForumReply> data,
    @JsonKey(name: 'total') final int total,
    @JsonKey(name: 'page') final int page,
    @JsonKey(name: 'has_more') final bool hasMore,
  }) = _$ForumReplyListResponseImpl;

  factory _ForumReplyListResponse.fromJson(Map<String, dynamic> json) =
      _$ForumReplyListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<ForumReply> get data;
  @override
  @JsonKey(name: 'total')
  int get total;
  @override
  @JsonKey(name: 'page')
  int get page;
  @override
  @JsonKey(name: 'has_more')
  bool get hasMore;

  /// Create a copy of ForumReplyListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumReplyListResponseImplCopyWith<_$ForumReplyListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ForumCategoryListResponse _$ForumCategoryListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _ForumCategoryListResponse.fromJson(json);
}

/// @nodoc
mixin _$ForumCategoryListResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<ForumCategory> get data => throw _privateConstructorUsedError;

  /// Serializes this ForumCategoryListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumCategoryListResponseCopyWith<ForumCategoryListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumCategoryListResponseCopyWith<$Res> {
  factory $ForumCategoryListResponseCopyWith(
    ForumCategoryListResponse value,
    $Res Function(ForumCategoryListResponse) then,
  ) = _$ForumCategoryListResponseCopyWithImpl<$Res, ForumCategoryListResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumCategory> data,
  });
}

/// @nodoc
class _$ForumCategoryListResponseCopyWithImpl<
  $Res,
  $Val extends ForumCategoryListResponse
>
    implements $ForumCategoryListResponseCopyWith<$Res> {
  _$ForumCategoryListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<ForumCategory>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumCategoryListResponseImplCopyWith<$Res>
    implements $ForumCategoryListResponseCopyWith<$Res> {
  factory _$$ForumCategoryListResponseImplCopyWith(
    _$ForumCategoryListResponseImpl value,
    $Res Function(_$ForumCategoryListResponseImpl) then,
  ) = __$$ForumCategoryListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumCategory> data,
  });
}

/// @nodoc
class __$$ForumCategoryListResponseImplCopyWithImpl<$Res>
    extends
        _$ForumCategoryListResponseCopyWithImpl<
          $Res,
          _$ForumCategoryListResponseImpl
        >
    implements _$$ForumCategoryListResponseImplCopyWith<$Res> {
  __$$ForumCategoryListResponseImplCopyWithImpl(
    _$ForumCategoryListResponseImpl _value,
    $Res Function(_$ForumCategoryListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$ForumCategoryListResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<ForumCategory>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumCategoryListResponseImpl implements _ForumCategoryListResponse {
  const _$ForumCategoryListResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<ForumCategory> data = const [],
  }) : _data = data;

  factory _$ForumCategoryListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumCategoryListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<ForumCategory> _data;
  @override
  @JsonKey(name: 'data')
  List<ForumCategory> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ForumCategoryListResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumCategoryListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of ForumCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumCategoryListResponseImplCopyWith<_$ForumCategoryListResponseImpl>
  get copyWith =>
      __$$ForumCategoryListResponseImplCopyWithImpl<
        _$ForumCategoryListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumCategoryListResponseImplToJson(this);
  }
}

abstract class _ForumCategoryListResponse implements ForumCategoryListResponse {
  const factory _ForumCategoryListResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<ForumCategory> data,
  }) = _$ForumCategoryListResponseImpl;

  factory _ForumCategoryListResponse.fromJson(Map<String, dynamic> json) =
      _$ForumCategoryListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<ForumCategory> get data;

  /// Create a copy of ForumCategoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumCategoryListResponseImplCopyWith<_$ForumCategoryListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ForumTagListResponse _$ForumTagListResponseFromJson(Map<String, dynamic> json) {
  return _ForumTagListResponse.fromJson(json);
}

/// @nodoc
mixin _$ForumTagListResponse {
  @JsonKey(name: 'status')
  int get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  List<ForumTag> get data => throw _privateConstructorUsedError;

  /// Serializes this ForumTagListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ForumTagListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ForumTagListResponseCopyWith<ForumTagListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ForumTagListResponseCopyWith<$Res> {
  factory $ForumTagListResponseCopyWith(
    ForumTagListResponse value,
    $Res Function(ForumTagListResponse) then,
  ) = _$ForumTagListResponseCopyWithImpl<$Res, ForumTagListResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumTag> data,
  });
}

/// @nodoc
class _$ForumTagListResponseCopyWithImpl<
  $Res,
  $Val extends ForumTagListResponse
>
    implements $ForumTagListResponseCopyWith<$Res> {
  _$ForumTagListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ForumTagListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _value.copyWith(
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as int,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            data: null == data
                ? _value.data
                : data // ignore: cast_nullable_to_non_nullable
                      as List<ForumTag>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ForumTagListResponseImplCopyWith<$Res>
    implements $ForumTagListResponseCopyWith<$Res> {
  factory _$$ForumTagListResponseImplCopyWith(
    _$ForumTagListResponseImpl value,
    $Res Function(_$ForumTagListResponseImpl) then,
  ) = __$$ForumTagListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'status') int status,
    @JsonKey(name: 'message') String message,
    @JsonKey(name: 'data') List<ForumTag> data,
  });
}

/// @nodoc
class __$$ForumTagListResponseImplCopyWithImpl<$Res>
    extends _$ForumTagListResponseCopyWithImpl<$Res, _$ForumTagListResponseImpl>
    implements _$$ForumTagListResponseImplCopyWith<$Res> {
  __$$ForumTagListResponseImplCopyWithImpl(
    _$ForumTagListResponseImpl _value,
    $Res Function(_$ForumTagListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ForumTagListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(
      _$ForumTagListResponseImpl(
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as int,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        data: null == data
            ? _value._data
            : data // ignore: cast_nullable_to_non_nullable
                  as List<ForumTag>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ForumTagListResponseImpl implements _ForumTagListResponse {
  const _$ForumTagListResponseImpl({
    @JsonKey(name: 'status') required this.status,
    @JsonKey(name: 'message') this.message = '',
    @JsonKey(name: 'data') final List<ForumTag> data = const [],
  }) : _data = data;

  factory _$ForumTagListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ForumTagListResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final int status;
  @override
  @JsonKey(name: 'message')
  final String message;
  final List<ForumTag> _data;
  @override
  @JsonKey(name: 'data')
  List<ForumTag> get data {
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_data);
  }

  @override
  String toString() {
    return 'ForumTagListResponse(status: $status, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ForumTagListResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    message,
    const DeepCollectionEquality().hash(_data),
  );

  /// Create a copy of ForumTagListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ForumTagListResponseImplCopyWith<_$ForumTagListResponseImpl>
  get copyWith =>
      __$$ForumTagListResponseImplCopyWithImpl<_$ForumTagListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ForumTagListResponseImplToJson(this);
  }
}

abstract class _ForumTagListResponse implements ForumTagListResponse {
  const factory _ForumTagListResponse({
    @JsonKey(name: 'status') required final int status,
    @JsonKey(name: 'message') final String message,
    @JsonKey(name: 'data') final List<ForumTag> data,
  }) = _$ForumTagListResponseImpl;

  factory _ForumTagListResponse.fromJson(Map<String, dynamic> json) =
      _$ForumTagListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  int get status;
  @override
  @JsonKey(name: 'message')
  String get message;
  @override
  @JsonKey(name: 'data')
  List<ForumTag> get data;

  /// Create a copy of ForumTagListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ForumTagListResponseImplCopyWith<_$ForumTagListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
