// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discourse_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DiscourseTopic _$DiscourseTopicFromJson(Map<String, dynamic> json) {
  return _DiscourseTopic.fromJson(json);
}

/// @nodoc
mixin _$DiscourseTopic {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'fancy_title')
  String? get fancyTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int get categoryId => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'unpinned')
  bool? get unpinned => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'has_summary')
  bool get hasSummary => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_poster_username')
  String? get lastPosterUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags_descriptions')
  Map<String, dynamic>? get tagsDescriptions =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'posters')
  List<DiscoursePoster> get posters => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'excerpt')
  String? get excerpt => throw _privateConstructorUsedError;

  /// Serializes this DiscourseTopic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseTopicCopyWith<DiscourseTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseTopicCopyWith<$Res> {
  factory $DiscourseTopicCopyWith(
    DiscourseTopic value,
    $Res Function(DiscourseTopic) then,
  ) = _$DiscourseTopicCopyWithImpl<$Res, DiscourseTopic>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'category_id') int categoryId,
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
    @JsonKey(name: 'unpinned') bool? unpinned,
    @JsonKey(name: 'visible') bool visible,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
    @JsonKey(name: 'bookmarked') bool bookmarked,
    @JsonKey(name: 'liked') bool liked,
    @JsonKey(name: 'views') int views,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'has_summary') bool hasSummary,
    @JsonKey(name: 'last_poster_username') String? lastPosterUsername,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'tags_descriptions') Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'posters') List<DiscoursePoster> posters,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'excerpt') String? excerpt,
  });
}

/// @nodoc
class _$DiscourseTopicCopyWithImpl<$Res, $Val extends DiscourseTopic>
    implements $DiscourseTopicCopyWith<$Res> {
  _$DiscourseTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fancyTitle = freezed,
    Object? slug = null,
    Object? categoryId = null,
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
    Object? unpinned = freezed,
    Object? visible = null,
    Object? closed = null,
    Object? archived = null,
    Object? bookmarked = null,
    Object? liked = null,
    Object? views = null,
    Object? likeCount = null,
    Object? hasSummary = null,
    Object? lastPosterUsername = freezed,
    Object? tags = null,
    Object? tagsDescriptions = freezed,
    Object? participants = null,
    Object? posters = null,
    Object? imageUrl = freezed,
    Object? excerpt = freezed,
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
            categoryId: null == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int,
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
            unpinned: freezed == unpinned
                ? _value.unpinned
                : unpinned // ignore: cast_nullable_to_non_nullable
                      as bool?,
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
            hasSummary: null == hasSummary
                ? _value.hasSummary
                : hasSummary // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastPosterUsername: freezed == lastPosterUsername
                ? _value.lastPosterUsername
                : lastPosterUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tagsDescriptions: freezed == tagsDescriptions
                ? _value.tagsDescriptions
                : tagsDescriptions // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseParticipant>,
            posters: null == posters
                ? _value.posters
                : posters // ignore: cast_nullable_to_non_nullable
                      as List<DiscoursePoster>,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            excerpt: freezed == excerpt
                ? _value.excerpt
                : excerpt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseTopicImplCopyWith<$Res>
    implements $DiscourseTopicCopyWith<$Res> {
  factory _$$DiscourseTopicImplCopyWith(
    _$DiscourseTopicImpl value,
    $Res Function(_$DiscourseTopicImpl) then,
  ) = __$$DiscourseTopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'category_id') int categoryId,
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
    @JsonKey(name: 'unpinned') bool? unpinned,
    @JsonKey(name: 'visible') bool visible,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
    @JsonKey(name: 'bookmarked') bool bookmarked,
    @JsonKey(name: 'liked') bool liked,
    @JsonKey(name: 'views') int views,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'has_summary') bool hasSummary,
    @JsonKey(name: 'last_poster_username') String? lastPosterUsername,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'tags_descriptions') Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'posters') List<DiscoursePoster> posters,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'excerpt') String? excerpt,
  });
}

/// @nodoc
class __$$DiscourseTopicImplCopyWithImpl<$Res>
    extends _$DiscourseTopicCopyWithImpl<$Res, _$DiscourseTopicImpl>
    implements _$$DiscourseTopicImplCopyWith<$Res> {
  __$$DiscourseTopicImplCopyWithImpl(
    _$DiscourseTopicImpl _value,
    $Res Function(_$DiscourseTopicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? fancyTitle = freezed,
    Object? slug = null,
    Object? categoryId = null,
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
    Object? unpinned = freezed,
    Object? visible = null,
    Object? closed = null,
    Object? archived = null,
    Object? bookmarked = null,
    Object? liked = null,
    Object? views = null,
    Object? likeCount = null,
    Object? hasSummary = null,
    Object? lastPosterUsername = freezed,
    Object? tags = null,
    Object? tagsDescriptions = freezed,
    Object? participants = null,
    Object? posters = null,
    Object? imageUrl = freezed,
    Object? excerpt = freezed,
  }) {
    return _then(
      _$DiscourseTopicImpl(
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
        categoryId: null == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int,
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
        unpinned: freezed == unpinned
            ? _value.unpinned
            : unpinned // ignore: cast_nullable_to_non_nullable
                  as bool?,
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
        hasSummary: null == hasSummary
            ? _value.hasSummary
            : hasSummary // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastPosterUsername: freezed == lastPosterUsername
            ? _value.lastPosterUsername
            : lastPosterUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tagsDescriptions: freezed == tagsDescriptions
            ? _value._tagsDescriptions
            : tagsDescriptions // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseParticipant>,
        posters: null == posters
            ? _value._posters
            : posters // ignore: cast_nullable_to_non_nullable
                  as List<DiscoursePoster>,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        excerpt: freezed == excerpt
            ? _value.excerpt
            : excerpt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseTopicImpl implements _DiscourseTopic {
  const _$DiscourseTopicImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'fancy_title') this.fancyTitle,
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'category_id') required this.categoryId,
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
    @JsonKey(name: 'unpinned') this.unpinned,
    @JsonKey(name: 'visible') this.visible = true,
    @JsonKey(name: 'closed') this.closed = false,
    @JsonKey(name: 'archived') this.archived = false,
    @JsonKey(name: 'bookmarked') this.bookmarked = false,
    @JsonKey(name: 'liked') this.liked = false,
    @JsonKey(name: 'views') this.views = 0,
    @JsonKey(name: 'like_count') this.likeCount = 0,
    @JsonKey(name: 'has_summary') this.hasSummary = false,
    @JsonKey(name: 'last_poster_username') this.lastPosterUsername,
    @JsonKey(name: 'tags') final List<String> tags = const [],
    @JsonKey(name: 'tags_descriptions')
    final Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants = const [],
    @JsonKey(name: 'posters') final List<DiscoursePoster> posters = const [],
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'excerpt') this.excerpt,
  }) : _tags = tags,
       _tagsDescriptions = tagsDescriptions,
       _participants = participants,
       _posters = posters;

  factory _$DiscourseTopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseTopicImplFromJson(json);

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
  @JsonKey(name: 'category_id')
  final int categoryId;
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
  @JsonKey(name: 'unpinned')
  final bool? unpinned;
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
  @JsonKey(name: 'has_summary')
  final bool hasSummary;
  @override
  @JsonKey(name: 'last_poster_username')
  final String? lastPosterUsername;
  final List<String> _tags;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, dynamic>? _tagsDescriptions;
  @override
  @JsonKey(name: 'tags_descriptions')
  Map<String, dynamic>? get tagsDescriptions {
    final value = _tagsDescriptions;
    if (value == null) return null;
    if (_tagsDescriptions is EqualUnmodifiableMapView) return _tagsDescriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<DiscourseParticipant> _participants;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  final List<DiscoursePoster> _posters;
  @override
  @JsonKey(name: 'posters')
  List<DiscoursePoster> get posters {
    if (_posters is EqualUnmodifiableListView) return _posters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posters);
  }

  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'excerpt')
  final String? excerpt;

  @override
  String toString() {
    return 'DiscourseTopic(id: $id, title: $title, fancyTitle: $fancyTitle, slug: $slug, categoryId: $categoryId, postsCount: $postsCount, replyCount: $replyCount, highestPostNumber: $highestPostNumber, createdAt: $createdAt, lastPostedAt: $lastPostedAt, bumped: $bumped, bumpedAt: $bumpedAt, archetype: $archetype, unseen: $unseen, pinned: $pinned, unpinned: $unpinned, visible: $visible, closed: $closed, archived: $archived, bookmarked: $bookmarked, liked: $liked, views: $views, likeCount: $likeCount, hasSummary: $hasSummary, lastPosterUsername: $lastPosterUsername, tags: $tags, tagsDescriptions: $tagsDescriptions, participants: $participants, posters: $posters, imageUrl: $imageUrl, excerpt: $excerpt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseTopicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fancyTitle, fancyTitle) ||
                other.fancyTitle == fancyTitle) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
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
            (identical(other.unpinned, unpinned) ||
                other.unpinned == unpinned) &&
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
            (identical(other.hasSummary, hasSummary) ||
                other.hasSummary == hasSummary) &&
            (identical(other.lastPosterUsername, lastPosterUsername) ||
                other.lastPosterUsername == lastPosterUsername) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(
              other._tagsDescriptions,
              _tagsDescriptions,
            ) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            const DeepCollectionEquality().equals(other._posters, _posters) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    fancyTitle,
    slug,
    categoryId,
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
    unpinned,
    visible,
    closed,
    archived,
    bookmarked,
    liked,
    views,
    likeCount,
    hasSummary,
    lastPosterUsername,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_tagsDescriptions),
    const DeepCollectionEquality().hash(_participants),
    const DeepCollectionEquality().hash(_posters),
    imageUrl,
    excerpt,
  ]);

  /// Create a copy of DiscourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseTopicImplCopyWith<_$DiscourseTopicImpl> get copyWith =>
      __$$DiscourseTopicImplCopyWithImpl<_$DiscourseTopicImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseTopicImplToJson(this);
  }
}

abstract class _DiscourseTopic implements DiscourseTopic {
  const factory _DiscourseTopic({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'fancy_title') final String? fancyTitle,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'category_id') required final int categoryId,
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
    @JsonKey(name: 'unpinned') final bool? unpinned,
    @JsonKey(name: 'visible') final bool visible,
    @JsonKey(name: 'closed') final bool closed,
    @JsonKey(name: 'archived') final bool archived,
    @JsonKey(name: 'bookmarked') final bool bookmarked,
    @JsonKey(name: 'liked') final bool liked,
    @JsonKey(name: 'views') final int views,
    @JsonKey(name: 'like_count') final int likeCount,
    @JsonKey(name: 'has_summary') final bool hasSummary,
    @JsonKey(name: 'last_poster_username') final String? lastPosterUsername,
    @JsonKey(name: 'tags') final List<String> tags,
    @JsonKey(name: 'tags_descriptions')
    final Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants,
    @JsonKey(name: 'posters') final List<DiscoursePoster> posters,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'excerpt') final String? excerpt,
  }) = _$DiscourseTopicImpl;

  factory _DiscourseTopic.fromJson(Map<String, dynamic> json) =
      _$DiscourseTopicImpl.fromJson;

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
  @JsonKey(name: 'category_id')
  int get categoryId;
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
  @JsonKey(name: 'unpinned')
  bool? get unpinned;
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
  @JsonKey(name: 'has_summary')
  bool get hasSummary;
  @override
  @JsonKey(name: 'last_poster_username')
  String? get lastPosterUsername;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags;
  @override
  @JsonKey(name: 'tags_descriptions')
  Map<String, dynamic>? get tagsDescriptions;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants;
  @override
  @JsonKey(name: 'posters')
  List<DiscoursePoster> get posters;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'excerpt')
  String? get excerpt;

  /// Create a copy of DiscourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseTopicImplCopyWith<_$DiscourseTopicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseParticipant _$DiscourseParticipantFromJson(Map<String, dynamic> json) {
  return _DiscourseParticipant.fromJson(json);
}

/// @nodoc
mixin _$DiscourseParticipant {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_count')
  int get postCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_name')
  String? get flairName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_url')
  String? get flairUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_color')
  String? get flairColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin')
  bool get admin => throw _privateConstructorUsedError;
  @JsonKey(name: 'moderator')
  bool get moderator => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level')
  int get trustLevel => throw _privateConstructorUsedError;

  /// Serializes this DiscourseParticipant to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseParticipantCopyWith<DiscourseParticipant> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseParticipantCopyWith<$Res> {
  factory $DiscourseParticipantCopyWith(
    DiscourseParticipant value,
    $Res Function(DiscourseParticipant) then,
  ) = _$DiscourseParticipantCopyWithImpl<$Res, DiscourseParticipant>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'trust_level') int trustLevel,
  });
}

/// @nodoc
class _$DiscourseParticipantCopyWithImpl<
  $Res,
  $Val extends DiscourseParticipant
>
    implements $DiscourseParticipantCopyWith<$Res> {
  _$DiscourseParticipantCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? postCount = null,
    Object? primaryGroupName = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
    Object? admin = null,
    Object? moderator = null,
    Object? trustLevel = null,
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
            postCount: null == postCount
                ? _value.postCount
                : postCount // ignore: cast_nullable_to_non_nullable
                      as int,
            primaryGroupName: freezed == primaryGroupName
                ? _value.primaryGroupName
                : primaryGroupName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairName: freezed == flairName
                ? _value.flairName
                : flairName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairUrl: freezed == flairUrl
                ? _value.flairUrl
                : flairUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairBgColor: freezed == flairBgColor
                ? _value.flairBgColor
                : flairBgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairColor: freezed == flairColor
                ? _value.flairColor
                : flairColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            admin: null == admin
                ? _value.admin
                : admin // ignore: cast_nullable_to_non_nullable
                      as bool,
            moderator: null == moderator
                ? _value.moderator
                : moderator // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustLevel: null == trustLevel
                ? _value.trustLevel
                : trustLevel // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseParticipantImplCopyWith<$Res>
    implements $DiscourseParticipantCopyWith<$Res> {
  factory _$$DiscourseParticipantImplCopyWith(
    _$DiscourseParticipantImpl value,
    $Res Function(_$DiscourseParticipantImpl) then,
  ) = __$$DiscourseParticipantImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'post_count') int postCount,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'trust_level') int trustLevel,
  });
}

/// @nodoc
class __$$DiscourseParticipantImplCopyWithImpl<$Res>
    extends _$DiscourseParticipantCopyWithImpl<$Res, _$DiscourseParticipantImpl>
    implements _$$DiscourseParticipantImplCopyWith<$Res> {
  __$$DiscourseParticipantImplCopyWithImpl(
    _$DiscourseParticipantImpl _value,
    $Res Function(_$DiscourseParticipantImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseParticipant
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? postCount = null,
    Object? primaryGroupName = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
    Object? admin = null,
    Object? moderator = null,
    Object? trustLevel = null,
  }) {
    return _then(
      _$DiscourseParticipantImpl(
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
        postCount: null == postCount
            ? _value.postCount
            : postCount // ignore: cast_nullable_to_non_nullable
                  as int,
        primaryGroupName: freezed == primaryGroupName
            ? _value.primaryGroupName
            : primaryGroupName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairName: freezed == flairName
            ? _value.flairName
            : flairName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairUrl: freezed == flairUrl
            ? _value.flairUrl
            : flairUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairBgColor: freezed == flairBgColor
            ? _value.flairBgColor
            : flairBgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairColor: freezed == flairColor
            ? _value.flairColor
            : flairColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        admin: null == admin
            ? _value.admin
            : admin // ignore: cast_nullable_to_non_nullable
                  as bool,
        moderator: null == moderator
            ? _value.moderator
            : moderator // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustLevel: null == trustLevel
            ? _value.trustLevel
            : trustLevel // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseParticipantImpl implements _DiscourseParticipant {
  const _$DiscourseParticipantImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'post_count') this.postCount = 0,
    @JsonKey(name: 'primary_group_name') this.primaryGroupName,
    @JsonKey(name: 'flair_name') this.flairName,
    @JsonKey(name: 'flair_url') this.flairUrl,
    @JsonKey(name: 'flair_bg_color') this.flairBgColor,
    @JsonKey(name: 'flair_color') this.flairColor,
    @JsonKey(name: 'admin') this.admin = false,
    @JsonKey(name: 'moderator') this.moderator = false,
    @JsonKey(name: 'trust_level') this.trustLevel = 1,
  });

  factory _$DiscourseParticipantImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseParticipantImplFromJson(json);

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
  @JsonKey(name: 'post_count')
  final int postCount;
  @override
  @JsonKey(name: 'primary_group_name')
  final String? primaryGroupName;
  @override
  @JsonKey(name: 'flair_name')
  final String? flairName;
  @override
  @JsonKey(name: 'flair_url')
  final String? flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  final String? flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  final String? flairColor;
  @override
  @JsonKey(name: 'admin')
  final bool admin;
  @override
  @JsonKey(name: 'moderator')
  final bool moderator;
  @override
  @JsonKey(name: 'trust_level')
  final int trustLevel;

  @override
  String toString() {
    return 'DiscourseParticipant(id: $id, username: $username, name: $name, avatarTemplate: $avatarTemplate, postCount: $postCount, primaryGroupName: $primaryGroupName, flairName: $flairName, flairUrl: $flairUrl, flairBgColor: $flairBgColor, flairColor: $flairColor, admin: $admin, moderator: $moderator, trustLevel: $trustLevel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseParticipantImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.postCount, postCount) ||
                other.postCount == postCount) &&
            (identical(other.primaryGroupName, primaryGroupName) ||
                other.primaryGroupName == primaryGroupName) &&
            (identical(other.flairName, flairName) ||
                other.flairName == flairName) &&
            (identical(other.flairUrl, flairUrl) ||
                other.flairUrl == flairUrl) &&
            (identical(other.flairBgColor, flairBgColor) ||
                other.flairBgColor == flairBgColor) &&
            (identical(other.flairColor, flairColor) ||
                other.flairColor == flairColor) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    name,
    avatarTemplate,
    postCount,
    primaryGroupName,
    flairName,
    flairUrl,
    flairBgColor,
    flairColor,
    admin,
    moderator,
    trustLevel,
  );

  /// Create a copy of DiscourseParticipant
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseParticipantImplCopyWith<_$DiscourseParticipantImpl>
  get copyWith =>
      __$$DiscourseParticipantImplCopyWithImpl<_$DiscourseParticipantImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseParticipantImplToJson(this);
  }
}

abstract class _DiscourseParticipant implements DiscourseParticipant {
  const factory _DiscourseParticipant({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'post_count') final int postCount,
    @JsonKey(name: 'primary_group_name') final String? primaryGroupName,
    @JsonKey(name: 'flair_name') final String? flairName,
    @JsonKey(name: 'flair_url') final String? flairUrl,
    @JsonKey(name: 'flair_bg_color') final String? flairBgColor,
    @JsonKey(name: 'flair_color') final String? flairColor,
    @JsonKey(name: 'admin') final bool admin,
    @JsonKey(name: 'moderator') final bool moderator,
    @JsonKey(name: 'trust_level') final int trustLevel,
  }) = _$DiscourseParticipantImpl;

  factory _DiscourseParticipant.fromJson(Map<String, dynamic> json) =
      _$DiscourseParticipantImpl.fromJson;

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
  @override
  @JsonKey(name: 'post_count')
  int get postCount;
  @override
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName;
  @override
  @JsonKey(name: 'flair_name')
  String? get flairName;
  @override
  @JsonKey(name: 'flair_url')
  String? get flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  String? get flairColor;
  @override
  @JsonKey(name: 'admin')
  bool get admin;
  @override
  @JsonKey(name: 'moderator')
  bool get moderator;
  @override
  @JsonKey(name: 'trust_level')
  int get trustLevel;

  /// Create a copy of DiscourseParticipant
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseParticipantImplCopyWith<_$DiscourseParticipantImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscoursePoster _$DiscoursePosterFromJson(Map<String, dynamic> json) {
  return _DiscoursePoster.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePoster {
  @JsonKey(name: 'extras')
  String? get extras => throw _privateConstructorUsedError;
  @JsonKey(name: 'description')
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_group_id')
  int? get primaryGroupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_group_id')
  int? get flairGroupId => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_name')
  String? get flairName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_url')
  String? get flairUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_color')
  String? get flairColor => throw _privateConstructorUsedError;

  /// Serializes this DiscoursePoster to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePoster
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePosterCopyWith<DiscoursePoster> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePosterCopyWith<$Res> {
  factory $DiscoursePosterCopyWith(
    DiscoursePoster value,
    $Res Function(DiscoursePoster) then,
  ) = _$DiscoursePosterCopyWithImpl<$Res, DiscoursePoster>;
  @useResult
  $Res call({
    @JsonKey(name: 'extras') String? extras,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'primary_group_id') int? primaryGroupId,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_group_id') int? flairGroupId,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  });
}

/// @nodoc
class _$DiscoursePosterCopyWithImpl<$Res, $Val extends DiscoursePoster>
    implements $DiscoursePosterCopyWith<$Res> {
  _$DiscoursePosterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePoster
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extras = freezed,
    Object? description = freezed,
    Object? userId = null,
    Object? primaryGroupId = freezed,
    Object? primaryGroupName = freezed,
    Object? flairGroupId = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
  }) {
    return _then(
      _value.copyWith(
            extras: freezed == extras
                ? _value.extras
                : extras // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int,
            primaryGroupId: freezed == primaryGroupId
                ? _value.primaryGroupId
                : primaryGroupId // ignore: cast_nullable_to_non_nullable
                      as int?,
            primaryGroupName: freezed == primaryGroupName
                ? _value.primaryGroupName
                : primaryGroupName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairGroupId: freezed == flairGroupId
                ? _value.flairGroupId
                : flairGroupId // ignore: cast_nullable_to_non_nullable
                      as int?,
            flairName: freezed == flairName
                ? _value.flairName
                : flairName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairUrl: freezed == flairUrl
                ? _value.flairUrl
                : flairUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairBgColor: freezed == flairBgColor
                ? _value.flairBgColor
                : flairBgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairColor: freezed == flairColor
                ? _value.flairColor
                : flairColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoursePosterImplCopyWith<$Res>
    implements $DiscoursePosterCopyWith<$Res> {
  factory _$$DiscoursePosterImplCopyWith(
    _$DiscoursePosterImpl value,
    $Res Function(_$DiscoursePosterImpl) then,
  ) = __$$DiscoursePosterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'extras') String? extras,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'primary_group_id') int? primaryGroupId,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_group_id') int? flairGroupId,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  });
}

/// @nodoc
class __$$DiscoursePosterImplCopyWithImpl<$Res>
    extends _$DiscoursePosterCopyWithImpl<$Res, _$DiscoursePosterImpl>
    implements _$$DiscoursePosterImplCopyWith<$Res> {
  __$$DiscoursePosterImplCopyWithImpl(
    _$DiscoursePosterImpl _value,
    $Res Function(_$DiscoursePosterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePoster
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? extras = freezed,
    Object? description = freezed,
    Object? userId = null,
    Object? primaryGroupId = freezed,
    Object? primaryGroupName = freezed,
    Object? flairGroupId = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
  }) {
    return _then(
      _$DiscoursePosterImpl(
        extras: freezed == extras
            ? _value.extras
            : extras // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int,
        primaryGroupId: freezed == primaryGroupId
            ? _value.primaryGroupId
            : primaryGroupId // ignore: cast_nullable_to_non_nullable
                  as int?,
        primaryGroupName: freezed == primaryGroupName
            ? _value.primaryGroupName
            : primaryGroupName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairGroupId: freezed == flairGroupId
            ? _value.flairGroupId
            : flairGroupId // ignore: cast_nullable_to_non_nullable
                  as int?,
        flairName: freezed == flairName
            ? _value.flairName
            : flairName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairUrl: freezed == flairUrl
            ? _value.flairUrl
            : flairUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairBgColor: freezed == flairBgColor
            ? _value.flairBgColor
            : flairBgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairColor: freezed == flairColor
            ? _value.flairColor
            : flairColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePosterImpl implements _DiscoursePoster {
  const _$DiscoursePosterImpl({
    @JsonKey(name: 'extras') this.extras,
    @JsonKey(name: 'description') this.description,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'primary_group_id') this.primaryGroupId,
    @JsonKey(name: 'primary_group_name') this.primaryGroupName,
    @JsonKey(name: 'flair_group_id') this.flairGroupId,
    @JsonKey(name: 'flair_name') this.flairName,
    @JsonKey(name: 'flair_url') this.flairUrl,
    @JsonKey(name: 'flair_bg_color') this.flairBgColor,
    @JsonKey(name: 'flair_color') this.flairColor,
  });

  factory _$DiscoursePosterImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoursePosterImplFromJson(json);

  @override
  @JsonKey(name: 'extras')
  final String? extras;
  @override
  @JsonKey(name: 'description')
  final String? description;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
  @override
  @JsonKey(name: 'primary_group_id')
  final int? primaryGroupId;
  @override
  @JsonKey(name: 'primary_group_name')
  final String? primaryGroupName;
  @override
  @JsonKey(name: 'flair_group_id')
  final int? flairGroupId;
  @override
  @JsonKey(name: 'flair_name')
  final String? flairName;
  @override
  @JsonKey(name: 'flair_url')
  final String? flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  final String? flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  final String? flairColor;

  @override
  String toString() {
    return 'DiscoursePoster(extras: $extras, description: $description, userId: $userId, primaryGroupId: $primaryGroupId, primaryGroupName: $primaryGroupName, flairGroupId: $flairGroupId, flairName: $flairName, flairUrl: $flairUrl, flairBgColor: $flairBgColor, flairColor: $flairColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePosterImpl &&
            (identical(other.extras, extras) || other.extras == extras) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.primaryGroupId, primaryGroupId) ||
                other.primaryGroupId == primaryGroupId) &&
            (identical(other.primaryGroupName, primaryGroupName) ||
                other.primaryGroupName == primaryGroupName) &&
            (identical(other.flairGroupId, flairGroupId) ||
                other.flairGroupId == flairGroupId) &&
            (identical(other.flairName, flairName) ||
                other.flairName == flairName) &&
            (identical(other.flairUrl, flairUrl) ||
                other.flairUrl == flairUrl) &&
            (identical(other.flairBgColor, flairBgColor) ||
                other.flairBgColor == flairBgColor) &&
            (identical(other.flairColor, flairColor) ||
                other.flairColor == flairColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    extras,
    description,
    userId,
    primaryGroupId,
    primaryGroupName,
    flairGroupId,
    flairName,
    flairUrl,
    flairBgColor,
    flairColor,
  );

  /// Create a copy of DiscoursePoster
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePosterImplCopyWith<_$DiscoursePosterImpl> get copyWith =>
      __$$DiscoursePosterImplCopyWithImpl<_$DiscoursePosterImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePosterImplToJson(this);
  }
}

abstract class _DiscoursePoster implements DiscoursePoster {
  const factory _DiscoursePoster({
    @JsonKey(name: 'extras') final String? extras,
    @JsonKey(name: 'description') final String? description,
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'primary_group_id') final int? primaryGroupId,
    @JsonKey(name: 'primary_group_name') final String? primaryGroupName,
    @JsonKey(name: 'flair_group_id') final int? flairGroupId,
    @JsonKey(name: 'flair_name') final String? flairName,
    @JsonKey(name: 'flair_url') final String? flairUrl,
    @JsonKey(name: 'flair_bg_color') final String? flairBgColor,
    @JsonKey(name: 'flair_color') final String? flairColor,
  }) = _$DiscoursePosterImpl;

  factory _DiscoursePoster.fromJson(Map<String, dynamic> json) =
      _$DiscoursePosterImpl.fromJson;

  @override
  @JsonKey(name: 'extras')
  String? get extras;
  @override
  @JsonKey(name: 'description')
  String? get description;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
  @override
  @JsonKey(name: 'primary_group_id')
  int? get primaryGroupId;
  @override
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName;
  @override
  @JsonKey(name: 'flair_group_id')
  int? get flairGroupId;
  @override
  @JsonKey(name: 'flair_name')
  String? get flairName;
  @override
  @JsonKey(name: 'flair_url')
  String? get flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  String? get flairColor;

  /// Create a copy of DiscoursePoster
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePosterImplCopyWith<_$DiscoursePosterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseTopicListResponse _$DiscourseTopicListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseTopicListResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscourseTopicListResponse {
  @JsonKey(name: 'users')
  List<DiscourseUserBasic> get users => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_groups')
  List<DiscoursePrimaryGroup> get primaryGroups =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_groups')
  List<DiscourseFlairGroup> get flairGroups =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_list')
  DiscourseTopicList? get topicList => throw _privateConstructorUsedError;

  /// Serializes this DiscourseTopicListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseTopicListResponseCopyWith<DiscourseTopicListResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseTopicListResponseCopyWith<$Res> {
  factory $DiscourseTopicListResponseCopyWith(
    DiscourseTopicListResponse value,
    $Res Function(DiscourseTopicListResponse) then,
  ) =
      _$DiscourseTopicListResponseCopyWithImpl<
        $Res,
        DiscourseTopicListResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'users') List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups') List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') DiscourseTopicList? topicList,
  });

  $DiscourseTopicListCopyWith<$Res>? get topicList;
}

/// @nodoc
class _$DiscourseTopicListResponseCopyWithImpl<
  $Res,
  $Val extends DiscourseTopicListResponse
>
    implements $DiscourseTopicListResponseCopyWith<$Res> {
  _$DiscourseTopicListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? primaryGroups = null,
    Object? flairGroups = null,
    Object? topicList = freezed,
  }) {
    return _then(
      _value.copyWith(
            users: null == users
                ? _value.users
                : users // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBasic>,
            primaryGroups: null == primaryGroups
                ? _value.primaryGroups
                : primaryGroups // ignore: cast_nullable_to_non_nullable
                      as List<DiscoursePrimaryGroup>,
            flairGroups: null == flairGroups
                ? _value.flairGroups
                : flairGroups // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseFlairGroup>,
            topicList: freezed == topicList
                ? _value.topicList
                : topicList // ignore: cast_nullable_to_non_nullable
                      as DiscourseTopicList?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseTopicListCopyWith<$Res>? get topicList {
    if (_value.topicList == null) {
      return null;
    }

    return $DiscourseTopicListCopyWith<$Res>(_value.topicList!, (value) {
      return _then(_value.copyWith(topicList: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseTopicListResponseImplCopyWith<$Res>
    implements $DiscourseTopicListResponseCopyWith<$Res> {
  factory _$$DiscourseTopicListResponseImplCopyWith(
    _$DiscourseTopicListResponseImpl value,
    $Res Function(_$DiscourseTopicListResponseImpl) then,
  ) = __$$DiscourseTopicListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'users') List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups') List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') DiscourseTopicList? topicList,
  });

  @override
  $DiscourseTopicListCopyWith<$Res>? get topicList;
}

/// @nodoc
class __$$DiscourseTopicListResponseImplCopyWithImpl<$Res>
    extends
        _$DiscourseTopicListResponseCopyWithImpl<
          $Res,
          _$DiscourseTopicListResponseImpl
        >
    implements _$$DiscourseTopicListResponseImplCopyWith<$Res> {
  __$$DiscourseTopicListResponseImplCopyWithImpl(
    _$DiscourseTopicListResponseImpl _value,
    $Res Function(_$DiscourseTopicListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? users = null,
    Object? primaryGroups = null,
    Object? flairGroups = null,
    Object? topicList = freezed,
  }) {
    return _then(
      _$DiscourseTopicListResponseImpl(
        users: null == users
            ? _value._users
            : users // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBasic>,
        primaryGroups: null == primaryGroups
            ? _value._primaryGroups
            : primaryGroups // ignore: cast_nullable_to_non_nullable
                  as List<DiscoursePrimaryGroup>,
        flairGroups: null == flairGroups
            ? _value._flairGroups
            : flairGroups // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseFlairGroup>,
        topicList: freezed == topicList
            ? _value.topicList
            : topicList // ignore: cast_nullable_to_non_nullable
                  as DiscourseTopicList?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseTopicListResponseImpl implements _DiscourseTopicListResponse {
  const _$DiscourseTopicListResponseImpl({
    @JsonKey(name: 'users') final List<DiscourseUserBasic> users = const [],
    @JsonKey(name: 'primary_groups')
    final List<DiscoursePrimaryGroup> primaryGroups = const [],
    @JsonKey(name: 'flair_groups')
    final List<DiscourseFlairGroup> flairGroups = const [],
    @JsonKey(name: 'topic_list') this.topicList,
  }) : _users = users,
       _primaryGroups = primaryGroups,
       _flairGroups = flairGroups;

  factory _$DiscourseTopicListResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscourseTopicListResponseImplFromJson(json);

  final List<DiscourseUserBasic> _users;
  @override
  @JsonKey(name: 'users')
  List<DiscourseUserBasic> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  final List<DiscoursePrimaryGroup> _primaryGroups;
  @override
  @JsonKey(name: 'primary_groups')
  List<DiscoursePrimaryGroup> get primaryGroups {
    if (_primaryGroups is EqualUnmodifiableListView) return _primaryGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_primaryGroups);
  }

  final List<DiscourseFlairGroup> _flairGroups;
  @override
  @JsonKey(name: 'flair_groups')
  List<DiscourseFlairGroup> get flairGroups {
    if (_flairGroups is EqualUnmodifiableListView) return _flairGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_flairGroups);
  }

  @override
  @JsonKey(name: 'topic_list')
  final DiscourseTopicList? topicList;

  @override
  String toString() {
    return 'DiscourseTopicListResponse(users: $users, primaryGroups: $primaryGroups, flairGroups: $flairGroups, topicList: $topicList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseTopicListResponseImpl &&
            const DeepCollectionEquality().equals(other._users, _users) &&
            const DeepCollectionEquality().equals(
              other._primaryGroups,
              _primaryGroups,
            ) &&
            const DeepCollectionEquality().equals(
              other._flairGroups,
              _flairGroups,
            ) &&
            (identical(other.topicList, topicList) ||
                other.topicList == topicList));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_users),
    const DeepCollectionEquality().hash(_primaryGroups),
    const DeepCollectionEquality().hash(_flairGroups),
    topicList,
  );

  /// Create a copy of DiscourseTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseTopicListResponseImplCopyWith<_$DiscourseTopicListResponseImpl>
  get copyWith =>
      __$$DiscourseTopicListResponseImplCopyWithImpl<
        _$DiscourseTopicListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseTopicListResponseImplToJson(this);
  }
}

abstract class _DiscourseTopicListResponse
    implements DiscourseTopicListResponse {
  const factory _DiscourseTopicListResponse({
    @JsonKey(name: 'users') final List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups')
    final List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') final List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') final DiscourseTopicList? topicList,
  }) = _$DiscourseTopicListResponseImpl;

  factory _DiscourseTopicListResponse.fromJson(Map<String, dynamic> json) =
      _$DiscourseTopicListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'users')
  List<DiscourseUserBasic> get users;
  @override
  @JsonKey(name: 'primary_groups')
  List<DiscoursePrimaryGroup> get primaryGroups;
  @override
  @JsonKey(name: 'flair_groups')
  List<DiscourseFlairGroup> get flairGroups;
  @override
  @JsonKey(name: 'topic_list')
  DiscourseTopicList? get topicList;

  /// Create a copy of DiscourseTopicListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseTopicListResponseImplCopyWith<_$DiscourseTopicListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseTopicList _$DiscourseTopicListFromJson(Map<String, dynamic> json) {
  return _DiscourseTopicList.fromJson(json);
}

/// @nodoc
mixin _$DiscourseTopicList {
  @JsonKey(name: 'can_create_topic')
  bool get canCreateTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_topics_url')
  String? get moreTopicsUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'for_period')
  String? get forPeriod => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'top_tags')
  List<String> get topTags => throw _privateConstructorUsedError;
  @JsonKey(name: 'topics')
  List<DiscourseTopic> get topics => throw _privateConstructorUsedError;

  /// Serializes this DiscourseTopicList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseTopicList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseTopicListCopyWith<DiscourseTopicList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseTopicListCopyWith<$Res> {
  factory $DiscourseTopicListCopyWith(
    DiscourseTopicList value,
    $Res Function(DiscourseTopicList) then,
  ) = _$DiscourseTopicListCopyWithImpl<$Res, DiscourseTopicList>;
  @useResult
  $Res call({
    @JsonKey(name: 'can_create_topic') bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') String? moreTopicsUrl,
    @JsonKey(name: 'for_period') String? forPeriod,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'top_tags') List<String> topTags,
    @JsonKey(name: 'topics') List<DiscourseTopic> topics,
  });
}

/// @nodoc
class _$DiscourseTopicListCopyWithImpl<$Res, $Val extends DiscourseTopicList>
    implements $DiscourseTopicListCopyWith<$Res> {
  _$DiscourseTopicListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseTopicList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canCreateTopic = null,
    Object? moreTopicsUrl = freezed,
    Object? forPeriod = freezed,
    Object? perPage = null,
    Object? topTags = null,
    Object? topics = null,
  }) {
    return _then(
      _value.copyWith(
            canCreateTopic: null == canCreateTopic
                ? _value.canCreateTopic
                : canCreateTopic // ignore: cast_nullable_to_non_nullable
                      as bool,
            moreTopicsUrl: freezed == moreTopicsUrl
                ? _value.moreTopicsUrl
                : moreTopicsUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            forPeriod: freezed == forPeriod
                ? _value.forPeriod
                : forPeriod // ignore: cast_nullable_to_non_nullable
                      as String?,
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
            topTags: null == topTags
                ? _value.topTags
                : topTags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            topics: null == topics
                ? _value.topics
                : topics // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseTopic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseTopicListImplCopyWith<$Res>
    implements $DiscourseTopicListCopyWith<$Res> {
  factory _$$DiscourseTopicListImplCopyWith(
    _$DiscourseTopicListImpl value,
    $Res Function(_$DiscourseTopicListImpl) then,
  ) = __$$DiscourseTopicListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'can_create_topic') bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') String? moreTopicsUrl,
    @JsonKey(name: 'for_period') String? forPeriod,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'top_tags') List<String> topTags,
    @JsonKey(name: 'topics') List<DiscourseTopic> topics,
  });
}

/// @nodoc
class __$$DiscourseTopicListImplCopyWithImpl<$Res>
    extends _$DiscourseTopicListCopyWithImpl<$Res, _$DiscourseTopicListImpl>
    implements _$$DiscourseTopicListImplCopyWith<$Res> {
  __$$DiscourseTopicListImplCopyWithImpl(
    _$DiscourseTopicListImpl _value,
    $Res Function(_$DiscourseTopicListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseTopicList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canCreateTopic = null,
    Object? moreTopicsUrl = freezed,
    Object? forPeriod = freezed,
    Object? perPage = null,
    Object? topTags = null,
    Object? topics = null,
  }) {
    return _then(
      _$DiscourseTopicListImpl(
        canCreateTopic: null == canCreateTopic
            ? _value.canCreateTopic
            : canCreateTopic // ignore: cast_nullable_to_non_nullable
                  as bool,
        moreTopicsUrl: freezed == moreTopicsUrl
            ? _value.moreTopicsUrl
            : moreTopicsUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        forPeriod: freezed == forPeriod
            ? _value.forPeriod
            : forPeriod // ignore: cast_nullable_to_non_nullable
                  as String?,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
        topTags: null == topTags
            ? _value._topTags
            : topTags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        topics: null == topics
            ? _value._topics
            : topics // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseTopic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseTopicListImpl implements _DiscourseTopicList {
  const _$DiscourseTopicListImpl({
    @JsonKey(name: 'can_create_topic') this.canCreateTopic = false,
    @JsonKey(name: 'more_topics_url') this.moreTopicsUrl,
    @JsonKey(name: 'for_period') this.forPeriod,
    @JsonKey(name: 'per_page') this.perPage = 30,
    @JsonKey(name: 'top_tags') final List<String> topTags = const [],
    @JsonKey(name: 'topics') final List<DiscourseTopic> topics = const [],
  }) : _topTags = topTags,
       _topics = topics;

  factory _$DiscourseTopicListImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseTopicListImplFromJson(json);

  @override
  @JsonKey(name: 'can_create_topic')
  final bool canCreateTopic;
  @override
  @JsonKey(name: 'more_topics_url')
  final String? moreTopicsUrl;
  @override
  @JsonKey(name: 'for_period')
  final String? forPeriod;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  final List<String> _topTags;
  @override
  @JsonKey(name: 'top_tags')
  List<String> get topTags {
    if (_topTags is EqualUnmodifiableListView) return _topTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topTags);
  }

  final List<DiscourseTopic> _topics;
  @override
  @JsonKey(name: 'topics')
  List<DiscourseTopic> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  @override
  String toString() {
    return 'DiscourseTopicList(canCreateTopic: $canCreateTopic, moreTopicsUrl: $moreTopicsUrl, forPeriod: $forPeriod, perPage: $perPage, topTags: $topTags, topics: $topics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseTopicListImpl &&
            (identical(other.canCreateTopic, canCreateTopic) ||
                other.canCreateTopic == canCreateTopic) &&
            (identical(other.moreTopicsUrl, moreTopicsUrl) ||
                other.moreTopicsUrl == moreTopicsUrl) &&
            (identical(other.forPeriod, forPeriod) ||
                other.forPeriod == forPeriod) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            const DeepCollectionEquality().equals(other._topTags, _topTags) &&
            const DeepCollectionEquality().equals(other._topics, _topics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    canCreateTopic,
    moreTopicsUrl,
    forPeriod,
    perPage,
    const DeepCollectionEquality().hash(_topTags),
    const DeepCollectionEquality().hash(_topics),
  );

  /// Create a copy of DiscourseTopicList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseTopicListImplCopyWith<_$DiscourseTopicListImpl> get copyWith =>
      __$$DiscourseTopicListImplCopyWithImpl<_$DiscourseTopicListImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseTopicListImplToJson(this);
  }
}

abstract class _DiscourseTopicList implements DiscourseTopicList {
  const factory _DiscourseTopicList({
    @JsonKey(name: 'can_create_topic') final bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') final String? moreTopicsUrl,
    @JsonKey(name: 'for_period') final String? forPeriod,
    @JsonKey(name: 'per_page') final int perPage,
    @JsonKey(name: 'top_tags') final List<String> topTags,
    @JsonKey(name: 'topics') final List<DiscourseTopic> topics,
  }) = _$DiscourseTopicListImpl;

  factory _DiscourseTopicList.fromJson(Map<String, dynamic> json) =
      _$DiscourseTopicListImpl.fromJson;

  @override
  @JsonKey(name: 'can_create_topic')
  bool get canCreateTopic;
  @override
  @JsonKey(name: 'more_topics_url')
  String? get moreTopicsUrl;
  @override
  @JsonKey(name: 'for_period')
  String? get forPeriod;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'top_tags')
  List<String> get topTags;
  @override
  @JsonKey(name: 'topics')
  List<DiscourseTopic> get topics;

  /// Create a copy of DiscourseTopicList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseTopicListImplCopyWith<_$DiscourseTopicListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseUserBasic _$DiscourseUserBasicFromJson(Map<String, dynamic> json) {
  return _DiscourseUserBasic.fromJson(json);
}

/// @nodoc
mixin _$DiscourseUserBasic {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin')
  bool get admin => throw _privateConstructorUsedError;
  @JsonKey(name: 'moderator')
  bool get moderator => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level')
  int get trustLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_name')
  String? get flairName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_url')
  String? get flairUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_color')
  String? get flairColor => throw _privateConstructorUsedError;

  /// Serializes this DiscourseUserBasic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseUserBasic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseUserBasicCopyWith<DiscourseUserBasic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseUserBasicCopyWith<$Res> {
  factory $DiscourseUserBasicCopyWith(
    DiscourseUserBasic value,
    $Res Function(DiscourseUserBasic) then,
  ) = _$DiscourseUserBasicCopyWithImpl<$Res, DiscourseUserBasic>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  });
}

/// @nodoc
class _$DiscourseUserBasicCopyWithImpl<$Res, $Val extends DiscourseUserBasic>
    implements $DiscourseUserBasicCopyWith<$Res> {
  _$DiscourseUserBasicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseUserBasic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? admin = null,
    Object? moderator = null,
    Object? trustLevel = null,
    Object? primaryGroupName = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
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
            admin: null == admin
                ? _value.admin
                : admin // ignore: cast_nullable_to_non_nullable
                      as bool,
            moderator: null == moderator
                ? _value.moderator
                : moderator // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustLevel: null == trustLevel
                ? _value.trustLevel
                : trustLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            primaryGroupName: freezed == primaryGroupName
                ? _value.primaryGroupName
                : primaryGroupName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairName: freezed == flairName
                ? _value.flairName
                : flairName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairUrl: freezed == flairUrl
                ? _value.flairUrl
                : flairUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairBgColor: freezed == flairBgColor
                ? _value.flairBgColor
                : flairBgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairColor: freezed == flairColor
                ? _value.flairColor
                : flairColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseUserBasicImplCopyWith<$Res>
    implements $DiscourseUserBasicCopyWith<$Res> {
  factory _$$DiscourseUserBasicImplCopyWith(
    _$DiscourseUserBasicImpl value,
    $Res Function(_$DiscourseUserBasicImpl) then,
  ) = __$$DiscourseUserBasicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  });
}

/// @nodoc
class __$$DiscourseUserBasicImplCopyWithImpl<$Res>
    extends _$DiscourseUserBasicCopyWithImpl<$Res, _$DiscourseUserBasicImpl>
    implements _$$DiscourseUserBasicImplCopyWith<$Res> {
  __$$DiscourseUserBasicImplCopyWithImpl(
    _$DiscourseUserBasicImpl _value,
    $Res Function(_$DiscourseUserBasicImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseUserBasic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? admin = null,
    Object? moderator = null,
    Object? trustLevel = null,
    Object? primaryGroupName = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
  }) {
    return _then(
      _$DiscourseUserBasicImpl(
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
        admin: null == admin
            ? _value.admin
            : admin // ignore: cast_nullable_to_non_nullable
                  as bool,
        moderator: null == moderator
            ? _value.moderator
            : moderator // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustLevel: null == trustLevel
            ? _value.trustLevel
            : trustLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        primaryGroupName: freezed == primaryGroupName
            ? _value.primaryGroupName
            : primaryGroupName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairName: freezed == flairName
            ? _value.flairName
            : flairName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairUrl: freezed == flairUrl
            ? _value.flairUrl
            : flairUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairBgColor: freezed == flairBgColor
            ? _value.flairBgColor
            : flairBgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairColor: freezed == flairColor
            ? _value.flairColor
            : flairColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseUserBasicImpl implements _DiscourseUserBasic {
  const _$DiscourseUserBasicImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'admin') this.admin = false,
    @JsonKey(name: 'moderator') this.moderator = false,
    @JsonKey(name: 'trust_level') this.trustLevel = 1,
    @JsonKey(name: 'primary_group_name') this.primaryGroupName,
    @JsonKey(name: 'flair_name') this.flairName,
    @JsonKey(name: 'flair_url') this.flairUrl,
    @JsonKey(name: 'flair_bg_color') this.flairBgColor,
    @JsonKey(name: 'flair_color') this.flairColor,
  });

  factory _$DiscourseUserBasicImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseUserBasicImplFromJson(json);

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
  @JsonKey(name: 'admin')
  final bool admin;
  @override
  @JsonKey(name: 'moderator')
  final bool moderator;
  @override
  @JsonKey(name: 'trust_level')
  final int trustLevel;
  @override
  @JsonKey(name: 'primary_group_name')
  final String? primaryGroupName;
  @override
  @JsonKey(name: 'flair_name')
  final String? flairName;
  @override
  @JsonKey(name: 'flair_url')
  final String? flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  final String? flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  final String? flairColor;

  @override
  String toString() {
    return 'DiscourseUserBasic(id: $id, username: $username, name: $name, avatarTemplate: $avatarTemplate, admin: $admin, moderator: $moderator, trustLevel: $trustLevel, primaryGroupName: $primaryGroupName, flairName: $flairName, flairUrl: $flairUrl, flairBgColor: $flairBgColor, flairColor: $flairColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseUserBasicImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel) &&
            (identical(other.primaryGroupName, primaryGroupName) ||
                other.primaryGroupName == primaryGroupName) &&
            (identical(other.flairName, flairName) ||
                other.flairName == flairName) &&
            (identical(other.flairUrl, flairUrl) ||
                other.flairUrl == flairUrl) &&
            (identical(other.flairBgColor, flairBgColor) ||
                other.flairBgColor == flairBgColor) &&
            (identical(other.flairColor, flairColor) ||
                other.flairColor == flairColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    name,
    avatarTemplate,
    admin,
    moderator,
    trustLevel,
    primaryGroupName,
    flairName,
    flairUrl,
    flairBgColor,
    flairColor,
  );

  /// Create a copy of DiscourseUserBasic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseUserBasicImplCopyWith<_$DiscourseUserBasicImpl> get copyWith =>
      __$$DiscourseUserBasicImplCopyWithImpl<_$DiscourseUserBasicImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseUserBasicImplToJson(this);
  }
}

abstract class _DiscourseUserBasic implements DiscourseUserBasic {
  const factory _DiscourseUserBasic({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'admin') final bool admin,
    @JsonKey(name: 'moderator') final bool moderator,
    @JsonKey(name: 'trust_level') final int trustLevel,
    @JsonKey(name: 'primary_group_name') final String? primaryGroupName,
    @JsonKey(name: 'flair_name') final String? flairName,
    @JsonKey(name: 'flair_url') final String? flairUrl,
    @JsonKey(name: 'flair_bg_color') final String? flairBgColor,
    @JsonKey(name: 'flair_color') final String? flairColor,
  }) = _$DiscourseUserBasicImpl;

  factory _DiscourseUserBasic.fromJson(Map<String, dynamic> json) =
      _$DiscourseUserBasicImpl.fromJson;

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
  @override
  @JsonKey(name: 'admin')
  bool get admin;
  @override
  @JsonKey(name: 'moderator')
  bool get moderator;
  @override
  @JsonKey(name: 'trust_level')
  int get trustLevel;
  @override
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName;
  @override
  @JsonKey(name: 'flair_name')
  String? get flairName;
  @override
  @JsonKey(name: 'flair_url')
  String? get flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  String? get flairColor;

  /// Create a copy of DiscourseUserBasic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseUserBasicImplCopyWith<_$DiscourseUserBasicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscoursePrimaryGroup _$DiscoursePrimaryGroupFromJson(
  Map<String, dynamic> json,
) {
  return _DiscoursePrimaryGroup.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePrimaryGroup {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;

  /// Serializes this DiscoursePrimaryGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePrimaryGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePrimaryGroupCopyWith<DiscoursePrimaryGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePrimaryGroupCopyWith<$Res> {
  factory $DiscoursePrimaryGroupCopyWith(
    DiscoursePrimaryGroup value,
    $Res Function(DiscoursePrimaryGroup) then,
  ) = _$DiscoursePrimaryGroupCopyWithImpl<$Res, DiscoursePrimaryGroup>;
  @useResult
  $Res call({@JsonKey(name: 'id') int id, @JsonKey(name: 'name') String name});
}

/// @nodoc
class _$DiscoursePrimaryGroupCopyWithImpl<
  $Res,
  $Val extends DiscoursePrimaryGroup
>
    implements $DiscoursePrimaryGroupCopyWith<$Res> {
  _$DiscoursePrimaryGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePrimaryGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
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
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoursePrimaryGroupImplCopyWith<$Res>
    implements $DiscoursePrimaryGroupCopyWith<$Res> {
  factory _$$DiscoursePrimaryGroupImplCopyWith(
    _$DiscoursePrimaryGroupImpl value,
    $Res Function(_$DiscoursePrimaryGroupImpl) then,
  ) = __$$DiscoursePrimaryGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'id') int id, @JsonKey(name: 'name') String name});
}

/// @nodoc
class __$$DiscoursePrimaryGroupImplCopyWithImpl<$Res>
    extends
        _$DiscoursePrimaryGroupCopyWithImpl<$Res, _$DiscoursePrimaryGroupImpl>
    implements _$$DiscoursePrimaryGroupImplCopyWith<$Res> {
  __$$DiscoursePrimaryGroupImplCopyWithImpl(
    _$DiscoursePrimaryGroupImpl _value,
    $Res Function(_$DiscoursePrimaryGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePrimaryGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _$DiscoursePrimaryGroupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePrimaryGroupImpl implements _DiscoursePrimaryGroup {
  const _$DiscoursePrimaryGroupImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
  });

  factory _$DiscoursePrimaryGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoursePrimaryGroupImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;

  @override
  String toString() {
    return 'DiscoursePrimaryGroup(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePrimaryGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of DiscoursePrimaryGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePrimaryGroupImplCopyWith<_$DiscoursePrimaryGroupImpl>
  get copyWith =>
      __$$DiscoursePrimaryGroupImplCopyWithImpl<_$DiscoursePrimaryGroupImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePrimaryGroupImplToJson(this);
  }
}

abstract class _DiscoursePrimaryGroup implements DiscoursePrimaryGroup {
  const factory _DiscoursePrimaryGroup({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
  }) = _$DiscoursePrimaryGroupImpl;

  factory _DiscoursePrimaryGroup.fromJson(Map<String, dynamic> json) =
      _$DiscoursePrimaryGroupImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;

  /// Create a copy of DiscoursePrimaryGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePrimaryGroupImplCopyWith<_$DiscoursePrimaryGroupImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseFlairGroup _$DiscourseFlairGroupFromJson(Map<String, dynamic> json) {
  return _DiscourseFlairGroup.fromJson(json);
}

/// @nodoc
mixin _$DiscourseFlairGroup {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_url')
  String? get flairUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_color')
  String? get flairColor => throw _privateConstructorUsedError;

  /// Serializes this DiscourseFlairGroup to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseFlairGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseFlairGroupCopyWith<DiscourseFlairGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseFlairGroupCopyWith<$Res> {
  factory $DiscourseFlairGroupCopyWith(
    DiscourseFlairGroup value,
    $Res Function(DiscourseFlairGroup) then,
  ) = _$DiscourseFlairGroupCopyWithImpl<$Res, DiscourseFlairGroup>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  });
}

/// @nodoc
class _$DiscourseFlairGroupCopyWithImpl<$Res, $Val extends DiscourseFlairGroup>
    implements $DiscourseFlairGroupCopyWith<$Res> {
  _$DiscourseFlairGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseFlairGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
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
            flairUrl: freezed == flairUrl
                ? _value.flairUrl
                : flairUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairBgColor: freezed == flairBgColor
                ? _value.flairBgColor
                : flairBgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairColor: freezed == flairColor
                ? _value.flairColor
                : flairColor // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscourseFlairGroupImplCopyWith<$Res>
    implements $DiscourseFlairGroupCopyWith<$Res> {
  factory _$$DiscourseFlairGroupImplCopyWith(
    _$DiscourseFlairGroupImpl value,
    $Res Function(_$DiscourseFlairGroupImpl) then,
  ) = __$$DiscourseFlairGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String name,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
  });
}

/// @nodoc
class __$$DiscourseFlairGroupImplCopyWithImpl<$Res>
    extends _$DiscourseFlairGroupCopyWithImpl<$Res, _$DiscourseFlairGroupImpl>
    implements _$$DiscourseFlairGroupImplCopyWith<$Res> {
  __$$DiscourseFlairGroupImplCopyWithImpl(
    _$DiscourseFlairGroupImpl _value,
    $Res Function(_$DiscourseFlairGroupImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseFlairGroup
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
  }) {
    return _then(
      _$DiscourseFlairGroupImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        flairUrl: freezed == flairUrl
            ? _value.flairUrl
            : flairUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairBgColor: freezed == flairBgColor
            ? _value.flairBgColor
            : flairBgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairColor: freezed == flairColor
            ? _value.flairColor
            : flairColor // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseFlairGroupImpl implements _DiscourseFlairGroup {
  const _$DiscourseFlairGroupImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') required this.name,
    @JsonKey(name: 'flair_url') this.flairUrl,
    @JsonKey(name: 'flair_bg_color') this.flairBgColor,
    @JsonKey(name: 'flair_color') this.flairColor,
  });

  factory _$DiscourseFlairGroupImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseFlairGroupImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'flair_url')
  final String? flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  final String? flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  final String? flairColor;

  @override
  String toString() {
    return 'DiscourseFlairGroup(id: $id, name: $name, flairUrl: $flairUrl, flairBgColor: $flairBgColor, flairColor: $flairColor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseFlairGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.flairUrl, flairUrl) ||
                other.flairUrl == flairUrl) &&
            (identical(other.flairBgColor, flairBgColor) ||
                other.flairBgColor == flairBgColor) &&
            (identical(other.flairColor, flairColor) ||
                other.flairColor == flairColor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, flairUrl, flairBgColor, flairColor);

  /// Create a copy of DiscourseFlairGroup
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseFlairGroupImplCopyWith<_$DiscourseFlairGroupImpl> get copyWith =>
      __$$DiscourseFlairGroupImplCopyWithImpl<_$DiscourseFlairGroupImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseFlairGroupImplToJson(this);
  }
}

abstract class _DiscourseFlairGroup implements DiscourseFlairGroup {
  const factory _DiscourseFlairGroup({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') required final String name,
    @JsonKey(name: 'flair_url') final String? flairUrl,
    @JsonKey(name: 'flair_bg_color') final String? flairBgColor,
    @JsonKey(name: 'flair_color') final String? flairColor,
  }) = _$DiscourseFlairGroupImpl;

  factory _DiscourseFlairGroup.fromJson(Map<String, dynamic> json) =
      _$DiscourseFlairGroupImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'name')
  String get name;
  @override
  @JsonKey(name: 'flair_url')
  String? get flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  String? get flairColor;

  /// Create a copy of DiscourseFlairGroup
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseFlairGroupImplCopyWith<_$DiscourseFlairGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseTopicDetailResponse _$DiscourseTopicDetailResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseTopicDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscourseTopicDetailResponse {
  @JsonKey(name: 'post_stream')
  DiscoursePostStream? get postStream => throw _privateConstructorUsedError;
  @JsonKey(name: 'timeline_lookup')
  List<List<dynamic>> get timelineLookup => throw _privateConstructorUsedError;
  @JsonKey(name: 'suggested_topics')
  List<DiscourseTopic> get suggestedTopics =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String? get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'fancy_title')
  String? get fancyTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'posts_count')
  int? get postsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'views')
  int? get views => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_count')
  int? get replyCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_count')
  int? get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'visible')
  bool? get visible => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed')
  bool? get closed => throw _privateConstructorUsedError;
  @JsonKey(name: 'archived')
  bool? get archived => throw _privateConstructorUsedError;
  @JsonKey(name: 'has_summary')
  bool? get hasSummary => throw _privateConstructorUsedError;
  @JsonKey(name: 'archetype')
  String? get archetype => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String? get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_id')
  int? get categoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'word_count')
  int? get wordCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'pinned_globally')
  bool? get pinnedGlobally => throw _privateConstructorUsedError;
  @JsonKey(name: 'pinned')
  bool? get pinned => throw _privateConstructorUsedError;
  @JsonKey(name: 'pinned_at')
  String? get pinnedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'details')
  DiscourseTopicDetails? get details => throw _privateConstructorUsedError;
  @JsonKey(name: 'highest_post_number')
  int? get highestPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_read_post_number')
  int? get lastReadPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_by')
  Map<String, dynamic>? get deletedBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'chunk_size')
  int? get chunkSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarked')
  bool? get bookmarked => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_timer')
  Map<String, dynamic>? get topicTimer => throw _privateConstructorUsedError;
  @JsonKey(name: 'message_bus_last_id')
  int? get messageBusLastId => throw _privateConstructorUsedError;
  @JsonKey(name: 'participant_count')
  int? get participantCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'show_read_indicator')
  bool? get showReadIndicator => throw _privateConstructorUsedError;
  @JsonKey(name: 'thumbnails')
  List<Map<String, dynamic>> get thumbnails =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags_descriptions')
  Map<String, dynamic>? get tagsDescriptions =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this DiscourseTopicDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseTopicDetailResponseCopyWith<DiscourseTopicDetailResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseTopicDetailResponseCopyWith<$Res> {
  factory $DiscourseTopicDetailResponseCopyWith(
    DiscourseTopicDetailResponse value,
    $Res Function(DiscourseTopicDetailResponse) then,
  ) =
      _$DiscourseTopicDetailResponseCopyWithImpl<
        $Res,
        DiscourseTopicDetailResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') List<List<dynamic>> timelineLookup,
    @JsonKey(name: 'suggested_topics') List<DiscourseTopic> suggestedTopics,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'posts_count') int? postsCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'views') int? views,
    @JsonKey(name: 'reply_count') int? replyCount,
    @JsonKey(name: 'like_count') int? likeCount,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'visible') bool? visible,
    @JsonKey(name: 'closed') bool? closed,
    @JsonKey(name: 'archived') bool? archived,
    @JsonKey(name: 'has_summary') bool? hasSummary,
    @JsonKey(name: 'archetype') String? archetype,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'word_count') int? wordCount,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'pinned_globally') bool? pinnedGlobally,
    @JsonKey(name: 'pinned') bool? pinned,
    @JsonKey(name: 'pinned_at') String? pinnedAt,
    @JsonKey(name: 'details') DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int? lastReadPostNumber,
    @JsonKey(name: 'deleted_by') Map<String, dynamic>? deletedBy,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') int? chunkSize,
    @JsonKey(name: 'bookmarked') bool? bookmarked,
    @JsonKey(name: 'topic_timer') Map<String, dynamic>? topicTimer,
    @JsonKey(name: 'message_bus_last_id') int? messageBusLastId,
    @JsonKey(name: 'participant_count') int? participantCount,
    @JsonKey(name: 'show_read_indicator') bool? showReadIndicator,
    @JsonKey(name: 'thumbnails') List<Map<String, dynamic>> thumbnails,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'tags_descriptions') Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'image_url') String? imageUrl,
  });

  $DiscoursePostStreamCopyWith<$Res>? get postStream;
  $DiscourseTopicDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class _$DiscourseTopicDetailResponseCopyWithImpl<
  $Res,
  $Val extends DiscourseTopicDetailResponse
>
    implements $DiscourseTopicDetailResponseCopyWith<$Res> {
  _$DiscourseTopicDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postStream = freezed,
    Object? timelineLookup = null,
    Object? suggestedTopics = null,
    Object? id = freezed,
    Object? title = freezed,
    Object? fancyTitle = freezed,
    Object? postsCount = freezed,
    Object? createdAt = freezed,
    Object? views = freezed,
    Object? replyCount = freezed,
    Object? likeCount = freezed,
    Object? lastPostedAt = freezed,
    Object? visible = freezed,
    Object? closed = freezed,
    Object? archived = freezed,
    Object? hasSummary = freezed,
    Object? archetype = freezed,
    Object? slug = freezed,
    Object? categoryId = freezed,
    Object? wordCount = freezed,
    Object? userId = freezed,
    Object? pinnedGlobally = freezed,
    Object? pinned = freezed,
    Object? pinnedAt = freezed,
    Object? details = freezed,
    Object? highestPostNumber = freezed,
    Object? lastReadPostNumber = freezed,
    Object? deletedBy = freezed,
    Object? actionsSummary = null,
    Object? chunkSize = freezed,
    Object? bookmarked = freezed,
    Object? topicTimer = freezed,
    Object? messageBusLastId = freezed,
    Object? participantCount = freezed,
    Object? showReadIndicator = freezed,
    Object? thumbnails = null,
    Object? tags = null,
    Object? tagsDescriptions = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            postStream: freezed == postStream
                ? _value.postStream
                : postStream // ignore: cast_nullable_to_non_nullable
                      as DiscoursePostStream?,
            timelineLookup: null == timelineLookup
                ? _value.timelineLookup
                : timelineLookup // ignore: cast_nullable_to_non_nullable
                      as List<List<dynamic>>,
            suggestedTopics: null == suggestedTopics
                ? _value.suggestedTopics
                : suggestedTopics // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseTopic>,
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            fancyTitle: freezed == fancyTitle
                ? _value.fancyTitle
                : fancyTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            postsCount: freezed == postsCount
                ? _value.postsCount
                : postsCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            views: freezed == views
                ? _value.views
                : views // ignore: cast_nullable_to_non_nullable
                      as int?,
            replyCount: freezed == replyCount
                ? _value.replyCount
                : replyCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            likeCount: freezed == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastPostedAt: freezed == lastPostedAt
                ? _value.lastPostedAt
                : lastPostedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            visible: freezed == visible
                ? _value.visible
                : visible // ignore: cast_nullable_to_non_nullable
                      as bool?,
            closed: freezed == closed
                ? _value.closed
                : closed // ignore: cast_nullable_to_non_nullable
                      as bool?,
            archived: freezed == archived
                ? _value.archived
                : archived // ignore: cast_nullable_to_non_nullable
                      as bool?,
            hasSummary: freezed == hasSummary
                ? _value.hasSummary
                : hasSummary // ignore: cast_nullable_to_non_nullable
                      as bool?,
            archetype: freezed == archetype
                ? _value.archetype
                : archetype // ignore: cast_nullable_to_non_nullable
                      as String?,
            slug: freezed == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String?,
            categoryId: freezed == categoryId
                ? _value.categoryId
                : categoryId // ignore: cast_nullable_to_non_nullable
                      as int?,
            wordCount: freezed == wordCount
                ? _value.wordCount
                : wordCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int?,
            pinnedGlobally: freezed == pinnedGlobally
                ? _value.pinnedGlobally
                : pinnedGlobally // ignore: cast_nullable_to_non_nullable
                      as bool?,
            pinned: freezed == pinned
                ? _value.pinned
                : pinned // ignore: cast_nullable_to_non_nullable
                      as bool?,
            pinnedAt: freezed == pinnedAt
                ? _value.pinnedAt
                : pinnedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            details: freezed == details
                ? _value.details
                : details // ignore: cast_nullable_to_non_nullable
                      as DiscourseTopicDetails?,
            highestPostNumber: freezed == highestPostNumber
                ? _value.highestPostNumber
                : highestPostNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            lastReadPostNumber: freezed == lastReadPostNumber
                ? _value.lastReadPostNumber
                : lastReadPostNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            deletedBy: freezed == deletedBy
                ? _value.deletedBy
                : deletedBy // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            actionsSummary: null == actionsSummary
                ? _value.actionsSummary
                : actionsSummary // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            chunkSize: freezed == chunkSize
                ? _value.chunkSize
                : chunkSize // ignore: cast_nullable_to_non_nullable
                      as int?,
            bookmarked: freezed == bookmarked
                ? _value.bookmarked
                : bookmarked // ignore: cast_nullable_to_non_nullable
                      as bool?,
            topicTimer: freezed == topicTimer
                ? _value.topicTimer
                : topicTimer // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            messageBusLastId: freezed == messageBusLastId
                ? _value.messageBusLastId
                : messageBusLastId // ignore: cast_nullable_to_non_nullable
                      as int?,
            participantCount: freezed == participantCount
                ? _value.participantCount
                : participantCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            showReadIndicator: freezed == showReadIndicator
                ? _value.showReadIndicator
                : showReadIndicator // ignore: cast_nullable_to_non_nullable
                      as bool?,
            thumbnails: null == thumbnails
                ? _value.thumbnails
                : thumbnails // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            tagsDescriptions: freezed == tagsDescriptions
                ? _value.tagsDescriptions
                : tagsDescriptions // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscoursePostStreamCopyWith<$Res>? get postStream {
    if (_value.postStream == null) {
      return null;
    }

    return $DiscoursePostStreamCopyWith<$Res>(_value.postStream!, (value) {
      return _then(_value.copyWith(postStream: value) as $Val);
    });
  }

  /// Create a copy of DiscourseTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseTopicDetailsCopyWith<$Res>? get details {
    if (_value.details == null) {
      return null;
    }

    return $DiscourseTopicDetailsCopyWith<$Res>(_value.details!, (value) {
      return _then(_value.copyWith(details: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseTopicDetailResponseImplCopyWith<$Res>
    implements $DiscourseTopicDetailResponseCopyWith<$Res> {
  factory _$$DiscourseTopicDetailResponseImplCopyWith(
    _$DiscourseTopicDetailResponseImpl value,
    $Res Function(_$DiscourseTopicDetailResponseImpl) then,
  ) = __$$DiscourseTopicDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') List<List<dynamic>> timelineLookup,
    @JsonKey(name: 'suggested_topics') List<DiscourseTopic> suggestedTopics,
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'fancy_title') String? fancyTitle,
    @JsonKey(name: 'posts_count') int? postsCount,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'views') int? views,
    @JsonKey(name: 'reply_count') int? replyCount,
    @JsonKey(name: 'like_count') int? likeCount,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'visible') bool? visible,
    @JsonKey(name: 'closed') bool? closed,
    @JsonKey(name: 'archived') bool? archived,
    @JsonKey(name: 'has_summary') bool? hasSummary,
    @JsonKey(name: 'archetype') String? archetype,
    @JsonKey(name: 'slug') String? slug,
    @JsonKey(name: 'category_id') int? categoryId,
    @JsonKey(name: 'word_count') int? wordCount,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'pinned_globally') bool? pinnedGlobally,
    @JsonKey(name: 'pinned') bool? pinned,
    @JsonKey(name: 'pinned_at') String? pinnedAt,
    @JsonKey(name: 'details') DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int? lastReadPostNumber,
    @JsonKey(name: 'deleted_by') Map<String, dynamic>? deletedBy,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') int? chunkSize,
    @JsonKey(name: 'bookmarked') bool? bookmarked,
    @JsonKey(name: 'topic_timer') Map<String, dynamic>? topicTimer,
    @JsonKey(name: 'message_bus_last_id') int? messageBusLastId,
    @JsonKey(name: 'participant_count') int? participantCount,
    @JsonKey(name: 'show_read_indicator') bool? showReadIndicator,
    @JsonKey(name: 'thumbnails') List<Map<String, dynamic>> thumbnails,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'tags_descriptions') Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'image_url') String? imageUrl,
  });

  @override
  $DiscoursePostStreamCopyWith<$Res>? get postStream;
  @override
  $DiscourseTopicDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class __$$DiscourseTopicDetailResponseImplCopyWithImpl<$Res>
    extends
        _$DiscourseTopicDetailResponseCopyWithImpl<
          $Res,
          _$DiscourseTopicDetailResponseImpl
        >
    implements _$$DiscourseTopicDetailResponseImplCopyWith<$Res> {
  __$$DiscourseTopicDetailResponseImplCopyWithImpl(
    _$DiscourseTopicDetailResponseImpl _value,
    $Res Function(_$DiscourseTopicDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postStream = freezed,
    Object? timelineLookup = null,
    Object? suggestedTopics = null,
    Object? id = freezed,
    Object? title = freezed,
    Object? fancyTitle = freezed,
    Object? postsCount = freezed,
    Object? createdAt = freezed,
    Object? views = freezed,
    Object? replyCount = freezed,
    Object? likeCount = freezed,
    Object? lastPostedAt = freezed,
    Object? visible = freezed,
    Object? closed = freezed,
    Object? archived = freezed,
    Object? hasSummary = freezed,
    Object? archetype = freezed,
    Object? slug = freezed,
    Object? categoryId = freezed,
    Object? wordCount = freezed,
    Object? userId = freezed,
    Object? pinnedGlobally = freezed,
    Object? pinned = freezed,
    Object? pinnedAt = freezed,
    Object? details = freezed,
    Object? highestPostNumber = freezed,
    Object? lastReadPostNumber = freezed,
    Object? deletedBy = freezed,
    Object? actionsSummary = null,
    Object? chunkSize = freezed,
    Object? bookmarked = freezed,
    Object? topicTimer = freezed,
    Object? messageBusLastId = freezed,
    Object? participantCount = freezed,
    Object? showReadIndicator = freezed,
    Object? thumbnails = null,
    Object? tags = null,
    Object? tagsDescriptions = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(
      _$DiscourseTopicDetailResponseImpl(
        postStream: freezed == postStream
            ? _value.postStream
            : postStream // ignore: cast_nullable_to_non_nullable
                  as DiscoursePostStream?,
        timelineLookup: null == timelineLookup
            ? _value._timelineLookup
            : timelineLookup // ignore: cast_nullable_to_non_nullable
                  as List<List<dynamic>>,
        suggestedTopics: null == suggestedTopics
            ? _value._suggestedTopics
            : suggestedTopics // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseTopic>,
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        fancyTitle: freezed == fancyTitle
            ? _value.fancyTitle
            : fancyTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        postsCount: freezed == postsCount
            ? _value.postsCount
            : postsCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        views: freezed == views
            ? _value.views
            : views // ignore: cast_nullable_to_non_nullable
                  as int?,
        replyCount: freezed == replyCount
            ? _value.replyCount
            : replyCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        likeCount: freezed == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastPostedAt: freezed == lastPostedAt
            ? _value.lastPostedAt
            : lastPostedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        visible: freezed == visible
            ? _value.visible
            : visible // ignore: cast_nullable_to_non_nullable
                  as bool?,
        closed: freezed == closed
            ? _value.closed
            : closed // ignore: cast_nullable_to_non_nullable
                  as bool?,
        archived: freezed == archived
            ? _value.archived
            : archived // ignore: cast_nullable_to_non_nullable
                  as bool?,
        hasSummary: freezed == hasSummary
            ? _value.hasSummary
            : hasSummary // ignore: cast_nullable_to_non_nullable
                  as bool?,
        archetype: freezed == archetype
            ? _value.archetype
            : archetype // ignore: cast_nullable_to_non_nullable
                  as String?,
        slug: freezed == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String?,
        categoryId: freezed == categoryId
            ? _value.categoryId
            : categoryId // ignore: cast_nullable_to_non_nullable
                  as int?,
        wordCount: freezed == wordCount
            ? _value.wordCount
            : wordCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int?,
        pinnedGlobally: freezed == pinnedGlobally
            ? _value.pinnedGlobally
            : pinnedGlobally // ignore: cast_nullable_to_non_nullable
                  as bool?,
        pinned: freezed == pinned
            ? _value.pinned
            : pinned // ignore: cast_nullable_to_non_nullable
                  as bool?,
        pinnedAt: freezed == pinnedAt
            ? _value.pinnedAt
            : pinnedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        details: freezed == details
            ? _value.details
            : details // ignore: cast_nullable_to_non_nullable
                  as DiscourseTopicDetails?,
        highestPostNumber: freezed == highestPostNumber
            ? _value.highestPostNumber
            : highestPostNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        lastReadPostNumber: freezed == lastReadPostNumber
            ? _value.lastReadPostNumber
            : lastReadPostNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        deletedBy: freezed == deletedBy
            ? _value._deletedBy
            : deletedBy // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        actionsSummary: null == actionsSummary
            ? _value._actionsSummary
            : actionsSummary // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        chunkSize: freezed == chunkSize
            ? _value.chunkSize
            : chunkSize // ignore: cast_nullable_to_non_nullable
                  as int?,
        bookmarked: freezed == bookmarked
            ? _value.bookmarked
            : bookmarked // ignore: cast_nullable_to_non_nullable
                  as bool?,
        topicTimer: freezed == topicTimer
            ? _value._topicTimer
            : topicTimer // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        messageBusLastId: freezed == messageBusLastId
            ? _value.messageBusLastId
            : messageBusLastId // ignore: cast_nullable_to_non_nullable
                  as int?,
        participantCount: freezed == participantCount
            ? _value.participantCount
            : participantCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        showReadIndicator: freezed == showReadIndicator
            ? _value.showReadIndicator
            : showReadIndicator // ignore: cast_nullable_to_non_nullable
                  as bool?,
        thumbnails: null == thumbnails
            ? _value._thumbnails
            : thumbnails // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        tagsDescriptions: freezed == tagsDescriptions
            ? _value._tagsDescriptions
            : tagsDescriptions // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseTopicDetailResponseImpl
    implements _DiscourseTopicDetailResponse {
  const _$DiscourseTopicDetailResponseImpl({
    @JsonKey(name: 'post_stream') this.postStream,
    @JsonKey(name: 'timeline_lookup')
    final List<List<dynamic>> timelineLookup = const [],
    @JsonKey(name: 'suggested_topics')
    final List<DiscourseTopic> suggestedTopics = const [],
    @JsonKey(name: 'id') this.id,
    @JsonKey(name: 'title') this.title,
    @JsonKey(name: 'fancy_title') this.fancyTitle,
    @JsonKey(name: 'posts_count') this.postsCount,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'views') this.views,
    @JsonKey(name: 'reply_count') this.replyCount,
    @JsonKey(name: 'like_count') this.likeCount,
    @JsonKey(name: 'last_posted_at') this.lastPostedAt,
    @JsonKey(name: 'visible') this.visible,
    @JsonKey(name: 'closed') this.closed,
    @JsonKey(name: 'archived') this.archived,
    @JsonKey(name: 'has_summary') this.hasSummary,
    @JsonKey(name: 'archetype') this.archetype,
    @JsonKey(name: 'slug') this.slug,
    @JsonKey(name: 'category_id') this.categoryId,
    @JsonKey(name: 'word_count') this.wordCount,
    @JsonKey(name: 'user_id') this.userId,
    @JsonKey(name: 'pinned_globally') this.pinnedGlobally,
    @JsonKey(name: 'pinned') this.pinned,
    @JsonKey(name: 'pinned_at') this.pinnedAt,
    @JsonKey(name: 'details') this.details,
    @JsonKey(name: 'highest_post_number') this.highestPostNumber,
    @JsonKey(name: 'last_read_post_number') this.lastReadPostNumber,
    @JsonKey(name: 'deleted_by') final Map<String, dynamic>? deletedBy,
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary = const [],
    @JsonKey(name: 'chunk_size') this.chunkSize,
    @JsonKey(name: 'bookmarked') this.bookmarked,
    @JsonKey(name: 'topic_timer') final Map<String, dynamic>? topicTimer,
    @JsonKey(name: 'message_bus_last_id') this.messageBusLastId,
    @JsonKey(name: 'participant_count') this.participantCount,
    @JsonKey(name: 'show_read_indicator') this.showReadIndicator,
    @JsonKey(name: 'thumbnails')
    final List<Map<String, dynamic>> thumbnails = const [],
    @JsonKey(name: 'tags') final List<String> tags = const [],
    @JsonKey(name: 'tags_descriptions')
    final Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'image_url') this.imageUrl,
  }) : _timelineLookup = timelineLookup,
       _suggestedTopics = suggestedTopics,
       _deletedBy = deletedBy,
       _actionsSummary = actionsSummary,
       _topicTimer = topicTimer,
       _thumbnails = thumbnails,
       _tags = tags,
       _tagsDescriptions = tagsDescriptions;

  factory _$DiscourseTopicDetailResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscourseTopicDetailResponseImplFromJson(json);

  @override
  @JsonKey(name: 'post_stream')
  final DiscoursePostStream? postStream;
  final List<List<dynamic>> _timelineLookup;
  @override
  @JsonKey(name: 'timeline_lookup')
  List<List<dynamic>> get timelineLookup {
    if (_timelineLookup is EqualUnmodifiableListView) return _timelineLookup;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timelineLookup);
  }

  final List<DiscourseTopic> _suggestedTopics;
  @override
  @JsonKey(name: 'suggested_topics')
  List<DiscourseTopic> get suggestedTopics {
    if (_suggestedTopics is EqualUnmodifiableListView) return _suggestedTopics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedTopics);
  }

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'title')
  final String? title;
  @override
  @JsonKey(name: 'fancy_title')
  final String? fancyTitle;
  @override
  @JsonKey(name: 'posts_count')
  final int? postsCount;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'views')
  final int? views;
  @override
  @JsonKey(name: 'reply_count')
  final int? replyCount;
  @override
  @JsonKey(name: 'like_count')
  final int? likeCount;
  @override
  @JsonKey(name: 'last_posted_at')
  final String? lastPostedAt;
  @override
  @JsonKey(name: 'visible')
  final bool? visible;
  @override
  @JsonKey(name: 'closed')
  final bool? closed;
  @override
  @JsonKey(name: 'archived')
  final bool? archived;
  @override
  @JsonKey(name: 'has_summary')
  final bool? hasSummary;
  @override
  @JsonKey(name: 'archetype')
  final String? archetype;
  @override
  @JsonKey(name: 'slug')
  final String? slug;
  @override
  @JsonKey(name: 'category_id')
  final int? categoryId;
  @override
  @JsonKey(name: 'word_count')
  final int? wordCount;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(name: 'pinned_globally')
  final bool? pinnedGlobally;
  @override
  @JsonKey(name: 'pinned')
  final bool? pinned;
  @override
  @JsonKey(name: 'pinned_at')
  final String? pinnedAt;
  @override
  @JsonKey(name: 'details')
  final DiscourseTopicDetails? details;
  @override
  @JsonKey(name: 'highest_post_number')
  final int? highestPostNumber;
  @override
  @JsonKey(name: 'last_read_post_number')
  final int? lastReadPostNumber;
  final Map<String, dynamic>? _deletedBy;
  @override
  @JsonKey(name: 'deleted_by')
  Map<String, dynamic>? get deletedBy {
    final value = _deletedBy;
    if (value == null) return null;
    if (_deletedBy is EqualUnmodifiableMapView) return _deletedBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<Map<String, dynamic>> _actionsSummary;
  @override
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary {
    if (_actionsSummary is EqualUnmodifiableListView) return _actionsSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actionsSummary);
  }

  @override
  @JsonKey(name: 'chunk_size')
  final int? chunkSize;
  @override
  @JsonKey(name: 'bookmarked')
  final bool? bookmarked;
  final Map<String, dynamic>? _topicTimer;
  @override
  @JsonKey(name: 'topic_timer')
  Map<String, dynamic>? get topicTimer {
    final value = _topicTimer;
    if (value == null) return null;
    if (_topicTimer is EqualUnmodifiableMapView) return _topicTimer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'message_bus_last_id')
  final int? messageBusLastId;
  @override
  @JsonKey(name: 'participant_count')
  final int? participantCount;
  @override
  @JsonKey(name: 'show_read_indicator')
  final bool? showReadIndicator;
  final List<Map<String, dynamic>> _thumbnails;
  @override
  @JsonKey(name: 'thumbnails')
  List<Map<String, dynamic>> get thumbnails {
    if (_thumbnails is EqualUnmodifiableListView) return _thumbnails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_thumbnails);
  }

  final List<String> _tags;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, dynamic>? _tagsDescriptions;
  @override
  @JsonKey(name: 'tags_descriptions')
  Map<String, dynamic>? get tagsDescriptions {
    final value = _tagsDescriptions;
    if (value == null) return null;
    if (_tagsDescriptions is EqualUnmodifiableMapView) return _tagsDescriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'DiscourseTopicDetailResponse(postStream: $postStream, timelineLookup: $timelineLookup, suggestedTopics: $suggestedTopics, id: $id, title: $title, fancyTitle: $fancyTitle, postsCount: $postsCount, createdAt: $createdAt, views: $views, replyCount: $replyCount, likeCount: $likeCount, lastPostedAt: $lastPostedAt, visible: $visible, closed: $closed, archived: $archived, hasSummary: $hasSummary, archetype: $archetype, slug: $slug, categoryId: $categoryId, wordCount: $wordCount, userId: $userId, pinnedGlobally: $pinnedGlobally, pinned: $pinned, pinnedAt: $pinnedAt, details: $details, highestPostNumber: $highestPostNumber, lastReadPostNumber: $lastReadPostNumber, deletedBy: $deletedBy, actionsSummary: $actionsSummary, chunkSize: $chunkSize, bookmarked: $bookmarked, topicTimer: $topicTimer, messageBusLastId: $messageBusLastId, participantCount: $participantCount, showReadIndicator: $showReadIndicator, thumbnails: $thumbnails, tags: $tags, tagsDescriptions: $tagsDescriptions, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseTopicDetailResponseImpl &&
            (identical(other.postStream, postStream) ||
                other.postStream == postStream) &&
            const DeepCollectionEquality().equals(
              other._timelineLookup,
              _timelineLookup,
            ) &&
            const DeepCollectionEquality().equals(
              other._suggestedTopics,
              _suggestedTopics,
            ) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.fancyTitle, fancyTitle) ||
                other.fancyTitle == fancyTitle) &&
            (identical(other.postsCount, postsCount) ||
                other.postsCount == postsCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.lastPostedAt, lastPostedAt) ||
                other.lastPostedAt == lastPostedAt) &&
            (identical(other.visible, visible) || other.visible == visible) &&
            (identical(other.closed, closed) || other.closed == closed) &&
            (identical(other.archived, archived) ||
                other.archived == archived) &&
            (identical(other.hasSummary, hasSummary) ||
                other.hasSummary == hasSummary) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.wordCount, wordCount) ||
                other.wordCount == wordCount) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.pinnedGlobally, pinnedGlobally) ||
                other.pinnedGlobally == pinnedGlobally) &&
            (identical(other.pinned, pinned) || other.pinned == pinned) &&
            (identical(other.pinnedAt, pinnedAt) ||
                other.pinnedAt == pinnedAt) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.highestPostNumber, highestPostNumber) ||
                other.highestPostNumber == highestPostNumber) &&
            (identical(other.lastReadPostNumber, lastReadPostNumber) ||
                other.lastReadPostNumber == lastReadPostNumber) &&
            const DeepCollectionEquality().equals(
              other._deletedBy,
              _deletedBy,
            ) &&
            const DeepCollectionEquality().equals(
              other._actionsSummary,
              _actionsSummary,
            ) &&
            (identical(other.chunkSize, chunkSize) ||
                other.chunkSize == chunkSize) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked) &&
            const DeepCollectionEquality().equals(
              other._topicTimer,
              _topicTimer,
            ) &&
            (identical(other.messageBusLastId, messageBusLastId) ||
                other.messageBusLastId == messageBusLastId) &&
            (identical(other.participantCount, participantCount) ||
                other.participantCount == participantCount) &&
            (identical(other.showReadIndicator, showReadIndicator) ||
                other.showReadIndicator == showReadIndicator) &&
            const DeepCollectionEquality().equals(
              other._thumbnails,
              _thumbnails,
            ) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(
              other._tagsDescriptions,
              _tagsDescriptions,
            ) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    postStream,
    const DeepCollectionEquality().hash(_timelineLookup),
    const DeepCollectionEquality().hash(_suggestedTopics),
    id,
    title,
    fancyTitle,
    postsCount,
    createdAt,
    views,
    replyCount,
    likeCount,
    lastPostedAt,
    visible,
    closed,
    archived,
    hasSummary,
    archetype,
    slug,
    categoryId,
    wordCount,
    userId,
    pinnedGlobally,
    pinned,
    pinnedAt,
    details,
    highestPostNumber,
    lastReadPostNumber,
    const DeepCollectionEquality().hash(_deletedBy),
    const DeepCollectionEquality().hash(_actionsSummary),
    chunkSize,
    bookmarked,
    const DeepCollectionEquality().hash(_topicTimer),
    messageBusLastId,
    participantCount,
    showReadIndicator,
    const DeepCollectionEquality().hash(_thumbnails),
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_tagsDescriptions),
    imageUrl,
  ]);

  /// Create a copy of DiscourseTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseTopicDetailResponseImplCopyWith<
    _$DiscourseTopicDetailResponseImpl
  >
  get copyWith =>
      __$$DiscourseTopicDetailResponseImplCopyWithImpl<
        _$DiscourseTopicDetailResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseTopicDetailResponseImplToJson(this);
  }
}

abstract class _DiscourseTopicDetailResponse
    implements DiscourseTopicDetailResponse {
  const factory _DiscourseTopicDetailResponse({
    @JsonKey(name: 'post_stream') final DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') final List<List<dynamic>> timelineLookup,
    @JsonKey(name: 'suggested_topics')
    final List<DiscourseTopic> suggestedTopics,
    @JsonKey(name: 'id') final int? id,
    @JsonKey(name: 'title') final String? title,
    @JsonKey(name: 'fancy_title') final String? fancyTitle,
    @JsonKey(name: 'posts_count') final int? postsCount,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'views') final int? views,
    @JsonKey(name: 'reply_count') final int? replyCount,
    @JsonKey(name: 'like_count') final int? likeCount,
    @JsonKey(name: 'last_posted_at') final String? lastPostedAt,
    @JsonKey(name: 'visible') final bool? visible,
    @JsonKey(name: 'closed') final bool? closed,
    @JsonKey(name: 'archived') final bool? archived,
    @JsonKey(name: 'has_summary') final bool? hasSummary,
    @JsonKey(name: 'archetype') final String? archetype,
    @JsonKey(name: 'slug') final String? slug,
    @JsonKey(name: 'category_id') final int? categoryId,
    @JsonKey(name: 'word_count') final int? wordCount,
    @JsonKey(name: 'user_id') final int? userId,
    @JsonKey(name: 'pinned_globally') final bool? pinnedGlobally,
    @JsonKey(name: 'pinned') final bool? pinned,
    @JsonKey(name: 'pinned_at') final String? pinnedAt,
    @JsonKey(name: 'details') final DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') final int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') final int? lastReadPostNumber,
    @JsonKey(name: 'deleted_by') final Map<String, dynamic>? deletedBy,
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') final int? chunkSize,
    @JsonKey(name: 'bookmarked') final bool? bookmarked,
    @JsonKey(name: 'topic_timer') final Map<String, dynamic>? topicTimer,
    @JsonKey(name: 'message_bus_last_id') final int? messageBusLastId,
    @JsonKey(name: 'participant_count') final int? participantCount,
    @JsonKey(name: 'show_read_indicator') final bool? showReadIndicator,
    @JsonKey(name: 'thumbnails') final List<Map<String, dynamic>> thumbnails,
    @JsonKey(name: 'tags') final List<String> tags,
    @JsonKey(name: 'tags_descriptions')
    final Map<String, dynamic>? tagsDescriptions,
    @JsonKey(name: 'image_url') final String? imageUrl,
  }) = _$DiscourseTopicDetailResponseImpl;

  factory _DiscourseTopicDetailResponse.fromJson(Map<String, dynamic> json) =
      _$DiscourseTopicDetailResponseImpl.fromJson;

  @override
  @JsonKey(name: 'post_stream')
  DiscoursePostStream? get postStream;
  @override
  @JsonKey(name: 'timeline_lookup')
  List<List<dynamic>> get timelineLookup;
  @override
  @JsonKey(name: 'suggested_topics')
  List<DiscourseTopic> get suggestedTopics;
  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'title')
  String? get title;
  @override
  @JsonKey(name: 'fancy_title')
  String? get fancyTitle;
  @override
  @JsonKey(name: 'posts_count')
  int? get postsCount;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'views')
  int? get views;
  @override
  @JsonKey(name: 'reply_count')
  int? get replyCount;
  @override
  @JsonKey(name: 'like_count')
  int? get likeCount;
  @override
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt;
  @override
  @JsonKey(name: 'visible')
  bool? get visible;
  @override
  @JsonKey(name: 'closed')
  bool? get closed;
  @override
  @JsonKey(name: 'archived')
  bool? get archived;
  @override
  @JsonKey(name: 'has_summary')
  bool? get hasSummary;
  @override
  @JsonKey(name: 'archetype')
  String? get archetype;
  @override
  @JsonKey(name: 'slug')
  String? get slug;
  @override
  @JsonKey(name: 'category_id')
  int? get categoryId;
  @override
  @JsonKey(name: 'word_count')
  int? get wordCount;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  @JsonKey(name: 'pinned_globally')
  bool? get pinnedGlobally;
  @override
  @JsonKey(name: 'pinned')
  bool? get pinned;
  @override
  @JsonKey(name: 'pinned_at')
  String? get pinnedAt;
  @override
  @JsonKey(name: 'details')
  DiscourseTopicDetails? get details;
  @override
  @JsonKey(name: 'highest_post_number')
  int? get highestPostNumber;
  @override
  @JsonKey(name: 'last_read_post_number')
  int? get lastReadPostNumber;
  @override
  @JsonKey(name: 'deleted_by')
  Map<String, dynamic>? get deletedBy;
  @override
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary;
  @override
  @JsonKey(name: 'chunk_size')
  int? get chunkSize;
  @override
  @JsonKey(name: 'bookmarked')
  bool? get bookmarked;
  @override
  @JsonKey(name: 'topic_timer')
  Map<String, dynamic>? get topicTimer;
  @override
  @JsonKey(name: 'message_bus_last_id')
  int? get messageBusLastId;
  @override
  @JsonKey(name: 'participant_count')
  int? get participantCount;
  @override
  @JsonKey(name: 'show_read_indicator')
  bool? get showReadIndicator;
  @override
  @JsonKey(name: 'thumbnails')
  List<Map<String, dynamic>> get thumbnails;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags;
  @override
  @JsonKey(name: 'tags_descriptions')
  Map<String, dynamic>? get tagsDescriptions;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;

  /// Create a copy of DiscourseTopicDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseTopicDetailResponseImplCopyWith<
    _$DiscourseTopicDetailResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DiscoursePostStream _$DiscoursePostStreamFromJson(Map<String, dynamic> json) {
  return _DiscoursePostStream.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePostStream {
  @JsonKey(name: 'posts')
  List<DiscoursePost> get posts => throw _privateConstructorUsedError;
  @JsonKey(name: 'stream')
  List<int> get stream => throw _privateConstructorUsedError;

  /// Serializes this DiscoursePostStream to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePostStream
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePostStreamCopyWith<DiscoursePostStream> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePostStreamCopyWith<$Res> {
  factory $DiscoursePostStreamCopyWith(
    DiscoursePostStream value,
    $Res Function(DiscoursePostStream) then,
  ) = _$DiscoursePostStreamCopyWithImpl<$Res, DiscoursePostStream>;
  @useResult
  $Res call({
    @JsonKey(name: 'posts') List<DiscoursePost> posts,
    @JsonKey(name: 'stream') List<int> stream,
  });
}

/// @nodoc
class _$DiscoursePostStreamCopyWithImpl<$Res, $Val extends DiscoursePostStream>
    implements $DiscoursePostStreamCopyWith<$Res> {
  _$DiscoursePostStreamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePostStream
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? posts = null, Object? stream = null}) {
    return _then(
      _value.copyWith(
            posts: null == posts
                ? _value.posts
                : posts // ignore: cast_nullable_to_non_nullable
                      as List<DiscoursePost>,
            stream: null == stream
                ? _value.stream
                : stream // ignore: cast_nullable_to_non_nullable
                      as List<int>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoursePostStreamImplCopyWith<$Res>
    implements $DiscoursePostStreamCopyWith<$Res> {
  factory _$$DiscoursePostStreamImplCopyWith(
    _$DiscoursePostStreamImpl value,
    $Res Function(_$DiscoursePostStreamImpl) then,
  ) = __$$DiscoursePostStreamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'posts') List<DiscoursePost> posts,
    @JsonKey(name: 'stream') List<int> stream,
  });
}

/// @nodoc
class __$$DiscoursePostStreamImplCopyWithImpl<$Res>
    extends _$DiscoursePostStreamCopyWithImpl<$Res, _$DiscoursePostStreamImpl>
    implements _$$DiscoursePostStreamImplCopyWith<$Res> {
  __$$DiscoursePostStreamImplCopyWithImpl(
    _$DiscoursePostStreamImpl _value,
    $Res Function(_$DiscoursePostStreamImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePostStream
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? posts = null, Object? stream = null}) {
    return _then(
      _$DiscoursePostStreamImpl(
        posts: null == posts
            ? _value._posts
            : posts // ignore: cast_nullable_to_non_nullable
                  as List<DiscoursePost>,
        stream: null == stream
            ? _value._stream
            : stream // ignore: cast_nullable_to_non_nullable
                  as List<int>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePostStreamImpl implements _DiscoursePostStream {
  const _$DiscoursePostStreamImpl({
    @JsonKey(name: 'posts') final List<DiscoursePost> posts = const [],
    @JsonKey(name: 'stream') final List<int> stream = const [],
  }) : _posts = posts,
       _stream = stream;

  factory _$DiscoursePostStreamImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoursePostStreamImplFromJson(json);

  final List<DiscoursePost> _posts;
  @override
  @JsonKey(name: 'posts')
  List<DiscoursePost> get posts {
    if (_posts is EqualUnmodifiableListView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_posts);
  }

  final List<int> _stream;
  @override
  @JsonKey(name: 'stream')
  List<int> get stream {
    if (_stream is EqualUnmodifiableListView) return _stream;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stream);
  }

  @override
  String toString() {
    return 'DiscoursePostStream(posts: $posts, stream: $stream)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePostStreamImpl &&
            const DeepCollectionEquality().equals(other._posts, _posts) &&
            const DeepCollectionEquality().equals(other._stream, _stream));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_posts),
    const DeepCollectionEquality().hash(_stream),
  );

  /// Create a copy of DiscoursePostStream
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePostStreamImplCopyWith<_$DiscoursePostStreamImpl> get copyWith =>
      __$$DiscoursePostStreamImplCopyWithImpl<_$DiscoursePostStreamImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePostStreamImplToJson(this);
  }
}

abstract class _DiscoursePostStream implements DiscoursePostStream {
  const factory _DiscoursePostStream({
    @JsonKey(name: 'posts') final List<DiscoursePost> posts,
    @JsonKey(name: 'stream') final List<int> stream,
  }) = _$DiscoursePostStreamImpl;

  factory _DiscoursePostStream.fromJson(Map<String, dynamic> json) =
      _$DiscoursePostStreamImpl.fromJson;

  @override
  @JsonKey(name: 'posts')
  List<DiscoursePost> get posts;
  @override
  @JsonKey(name: 'stream')
  List<int> get stream;

  /// Create a copy of DiscoursePostStream
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePostStreamImplCopyWith<_$DiscoursePostStreamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscoursePost _$DiscoursePostFromJson(Map<String, dynamic> json) {
  return _DiscoursePost.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePost {
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
  @JsonKey(name: 'cooked')
  String? get cooked => throw _privateConstructorUsedError;
  @JsonKey(name: 'raw')
  String? get raw => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_number')
  int get postNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_type')
  int get postType => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_count')
  int get replyCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to_post_number')
  int? get replyToPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'quote_count')
  int get quoteCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'incoming_link_count')
  int get incomingLinkCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reads')
  int get reads => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_count')
  int get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'readers_count')
  int get readersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'score')
  double? get score => throw _privateConstructorUsedError;
  @JsonKey(name: 'yours')
  bool get yours => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_id')
  int get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_slug')
  String? get topicSlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_username')
  String? get displayUsername => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_name')
  String? get flairName => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_url')
  String? get flairUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_color')
  String? get flairColor => throw _privateConstructorUsedError;
  @JsonKey(name: 'version')
  int get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_edit')
  bool get canEdit => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_delete')
  bool get canDelete => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_recover')
  bool get canRecover => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_see_hidden_post')
  bool get canSeeHiddenPost => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_wiki')
  bool get canWiki => throw _privateConstructorUsedError;
  @JsonKey(name: 'link_counts')
  List<Map<String, dynamic>> get linkCounts =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'moderator')
  bool get moderator => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin')
  bool get admin => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff')
  bool get staff => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'hidden')
  bool get hidden => throw _privateConstructorUsedError;
  @JsonKey(name: 'trust_level')
  int get trustLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted_at')
  String? get deletedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_deleted')
  bool get userDeleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'edit_reason')
  String? get editReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_view_edit_history')
  bool get canViewEditHistory => throw _privateConstructorUsedError;
  @JsonKey(name: 'wiki')
  bool get wiki => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewable_id')
  int? get reviewableId => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewable_score_count')
  int? get reviewableScoreCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reviewable_score_pending_count')
  int? get reviewableScorePendingCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'mentioned_users')
  List<Map<String, dynamic>> get mentionedUsers =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'reactions')
  List<Map<String, dynamic>> get reactions =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'current_user_reaction')
  Map<String, dynamic>? get currentUserReaction =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'reaction_users_count')
  int? get reactionUsersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarked')
  bool get bookmarked => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarked_at')
  String? get bookmarkedAt => throw _privateConstructorUsedError;

  /// Serializes this DiscoursePost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePostCopyWith<DiscoursePost> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePostCopyWith<$Res> {
  factory $DiscoursePostCopyWith(
    DiscoursePost value,
    $Res Function(DiscoursePost) then,
  ) = _$DiscoursePostCopyWithImpl<$Res, DiscoursePost>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'cooked') String? cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'post_number') int postNumber,
    @JsonKey(name: 'post_type') int postType,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'reply_count') int replyCount,
    @JsonKey(name: 'reply_to_post_number') int? replyToPostNumber,
    @JsonKey(name: 'quote_count') int quoteCount,
    @JsonKey(name: 'incoming_link_count') int incomingLinkCount,
    @JsonKey(name: 'reads') int reads,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'readers_count') int readersCount,
    @JsonKey(name: 'score') double? score,
    @JsonKey(name: 'yours') bool yours,
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
    @JsonKey(name: 'version') int version,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'can_delete') bool canDelete,
    @JsonKey(name: 'can_recover') bool canRecover,
    @JsonKey(name: 'can_see_hidden_post') bool canSeeHiddenPost,
    @JsonKey(name: 'can_wiki') bool canWiki,
    @JsonKey(name: 'link_counts') List<Map<String, dynamic>> linkCounts,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'staff') bool staff,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'hidden') bool hidden,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @JsonKey(name: 'user_deleted') bool userDeleted,
    @JsonKey(name: 'edit_reason') String? editReason,
    @JsonKey(name: 'can_view_edit_history') bool canViewEditHistory,
    @JsonKey(name: 'wiki') bool wiki,
    @JsonKey(name: 'reviewable_id') int? reviewableId,
    @JsonKey(name: 'reviewable_score_count') int? reviewableScoreCount,
    @JsonKey(name: 'reviewable_score_pending_count')
    int? reviewableScorePendingCount,
    @JsonKey(name: 'mentioned_users') List<Map<String, dynamic>> mentionedUsers,
    @JsonKey(name: 'reactions') List<Map<String, dynamic>> reactions,
    @JsonKey(name: 'current_user_reaction')
    Map<String, dynamic>? currentUserReaction,
    @JsonKey(name: 'reaction_users_count') int? reactionUsersCount,
    @JsonKey(name: 'bookmarked') bool bookmarked,
    @JsonKey(name: 'bookmarked_at') String? bookmarkedAt,
  });
}

/// @nodoc
class _$DiscoursePostCopyWithImpl<$Res, $Val extends DiscoursePost>
    implements $DiscoursePostCopyWith<$Res> {
  _$DiscoursePostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? username = null,
    Object? avatarTemplate = null,
    Object? createdAt = null,
    Object? cooked = freezed,
    Object? raw = freezed,
    Object? postNumber = null,
    Object? postType = null,
    Object? updatedAt = freezed,
    Object? replyCount = null,
    Object? replyToPostNumber = freezed,
    Object? quoteCount = null,
    Object? incomingLinkCount = null,
    Object? reads = null,
    Object? likeCount = null,
    Object? readersCount = null,
    Object? score = freezed,
    Object? yours = null,
    Object? topicId = null,
    Object? topicSlug = freezed,
    Object? displayUsername = freezed,
    Object? primaryGroupName = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
    Object? version = null,
    Object? canEdit = null,
    Object? canDelete = null,
    Object? canRecover = null,
    Object? canSeeHiddenPost = null,
    Object? canWiki = null,
    Object? linkCounts = null,
    Object? actionsSummary = null,
    Object? moderator = null,
    Object? admin = null,
    Object? staff = null,
    Object? userId = freezed,
    Object? hidden = null,
    Object? trustLevel = null,
    Object? deletedAt = freezed,
    Object? userDeleted = null,
    Object? editReason = freezed,
    Object? canViewEditHistory = null,
    Object? wiki = null,
    Object? reviewableId = freezed,
    Object? reviewableScoreCount = freezed,
    Object? reviewableScorePendingCount = freezed,
    Object? mentionedUsers = null,
    Object? reactions = null,
    Object? currentUserReaction = freezed,
    Object? reactionUsersCount = freezed,
    Object? bookmarked = null,
    Object? bookmarkedAt = freezed,
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
            cooked: freezed == cooked
                ? _value.cooked
                : cooked // ignore: cast_nullable_to_non_nullable
                      as String?,
            raw: freezed == raw
                ? _value.raw
                : raw // ignore: cast_nullable_to_non_nullable
                      as String?,
            postNumber: null == postNumber
                ? _value.postNumber
                : postNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            postType: null == postType
                ? _value.postType
                : postType // ignore: cast_nullable_to_non_nullable
                      as int,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            replyCount: null == replyCount
                ? _value.replyCount
                : replyCount // ignore: cast_nullable_to_non_nullable
                      as int,
            replyToPostNumber: freezed == replyToPostNumber
                ? _value.replyToPostNumber
                : replyToPostNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            quoteCount: null == quoteCount
                ? _value.quoteCount
                : quoteCount // ignore: cast_nullable_to_non_nullable
                      as int,
            incomingLinkCount: null == incomingLinkCount
                ? _value.incomingLinkCount
                : incomingLinkCount // ignore: cast_nullable_to_non_nullable
                      as int,
            reads: null == reads
                ? _value.reads
                : reads // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            readersCount: null == readersCount
                ? _value.readersCount
                : readersCount // ignore: cast_nullable_to_non_nullable
                      as int,
            score: freezed == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as double?,
            yours: null == yours
                ? _value.yours
                : yours // ignore: cast_nullable_to_non_nullable
                      as bool,
            topicId: null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int,
            topicSlug: freezed == topicSlug
                ? _value.topicSlug
                : topicSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            displayUsername: freezed == displayUsername
                ? _value.displayUsername
                : displayUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
            primaryGroupName: freezed == primaryGroupName
                ? _value.primaryGroupName
                : primaryGroupName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairName: freezed == flairName
                ? _value.flairName
                : flairName // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairUrl: freezed == flairUrl
                ? _value.flairUrl
                : flairUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairBgColor: freezed == flairBgColor
                ? _value.flairBgColor
                : flairBgColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            flairColor: freezed == flairColor
                ? _value.flairColor
                : flairColor // ignore: cast_nullable_to_non_nullable
                      as String?,
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
            canEdit: null == canEdit
                ? _value.canEdit
                : canEdit // ignore: cast_nullable_to_non_nullable
                      as bool,
            canDelete: null == canDelete
                ? _value.canDelete
                : canDelete // ignore: cast_nullable_to_non_nullable
                      as bool,
            canRecover: null == canRecover
                ? _value.canRecover
                : canRecover // ignore: cast_nullable_to_non_nullable
                      as bool,
            canSeeHiddenPost: null == canSeeHiddenPost
                ? _value.canSeeHiddenPost
                : canSeeHiddenPost // ignore: cast_nullable_to_non_nullable
                      as bool,
            canWiki: null == canWiki
                ? _value.canWiki
                : canWiki // ignore: cast_nullable_to_non_nullable
                      as bool,
            linkCounts: null == linkCounts
                ? _value.linkCounts
                : linkCounts // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            actionsSummary: null == actionsSummary
                ? _value.actionsSummary
                : actionsSummary // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            moderator: null == moderator
                ? _value.moderator
                : moderator // ignore: cast_nullable_to_non_nullable
                      as bool,
            admin: null == admin
                ? _value.admin
                : admin // ignore: cast_nullable_to_non_nullable
                      as bool,
            staff: null == staff
                ? _value.staff
                : staff // ignore: cast_nullable_to_non_nullable
                      as bool,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as int?,
            hidden: null == hidden
                ? _value.hidden
                : hidden // ignore: cast_nullable_to_non_nullable
                      as bool,
            trustLevel: null == trustLevel
                ? _value.trustLevel
                : trustLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            deletedAt: freezed == deletedAt
                ? _value.deletedAt
                : deletedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            userDeleted: null == userDeleted
                ? _value.userDeleted
                : userDeleted // ignore: cast_nullable_to_non_nullable
                      as bool,
            editReason: freezed == editReason
                ? _value.editReason
                : editReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            canViewEditHistory: null == canViewEditHistory
                ? _value.canViewEditHistory
                : canViewEditHistory // ignore: cast_nullable_to_non_nullable
                      as bool,
            wiki: null == wiki
                ? _value.wiki
                : wiki // ignore: cast_nullable_to_non_nullable
                      as bool,
            reviewableId: freezed == reviewableId
                ? _value.reviewableId
                : reviewableId // ignore: cast_nullable_to_non_nullable
                      as int?,
            reviewableScoreCount: freezed == reviewableScoreCount
                ? _value.reviewableScoreCount
                : reviewableScoreCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            reviewableScorePendingCount: freezed == reviewableScorePendingCount
                ? _value.reviewableScorePendingCount
                : reviewableScorePendingCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            mentionedUsers: null == mentionedUsers
                ? _value.mentionedUsers
                : mentionedUsers // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            reactions: null == reactions
                ? _value.reactions
                : reactions // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
            currentUserReaction: freezed == currentUserReaction
                ? _value.currentUserReaction
                : currentUserReaction // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            reactionUsersCount: freezed == reactionUsersCount
                ? _value.reactionUsersCount
                : reactionUsersCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            bookmarked: null == bookmarked
                ? _value.bookmarked
                : bookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            bookmarkedAt: freezed == bookmarkedAt
                ? _value.bookmarkedAt
                : bookmarkedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoursePostImplCopyWith<$Res>
    implements $DiscoursePostCopyWith<$Res> {
  factory _$$DiscoursePostImplCopyWith(
    _$DiscoursePostImpl value,
    $Res Function(_$DiscoursePostImpl) then,
  ) = __$$DiscoursePostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'cooked') String? cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'post_number') int postNumber,
    @JsonKey(name: 'post_type') int postType,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'reply_count') int replyCount,
    @JsonKey(name: 'reply_to_post_number') int? replyToPostNumber,
    @JsonKey(name: 'quote_count') int quoteCount,
    @JsonKey(name: 'incoming_link_count') int incomingLinkCount,
    @JsonKey(name: 'reads') int reads,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'readers_count') int readersCount,
    @JsonKey(name: 'score') double? score,
    @JsonKey(name: 'yours') bool yours,
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'display_username') String? displayUsername,
    @JsonKey(name: 'primary_group_name') String? primaryGroupName,
    @JsonKey(name: 'flair_name') String? flairName,
    @JsonKey(name: 'flair_url') String? flairUrl,
    @JsonKey(name: 'flair_bg_color') String? flairBgColor,
    @JsonKey(name: 'flair_color') String? flairColor,
    @JsonKey(name: 'version') int version,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'can_delete') bool canDelete,
    @JsonKey(name: 'can_recover') bool canRecover,
    @JsonKey(name: 'can_see_hidden_post') bool canSeeHiddenPost,
    @JsonKey(name: 'can_wiki') bool canWiki,
    @JsonKey(name: 'link_counts') List<Map<String, dynamic>> linkCounts,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'staff') bool staff,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'hidden') bool hidden,
    @JsonKey(name: 'trust_level') int trustLevel,
    @JsonKey(name: 'deleted_at') String? deletedAt,
    @JsonKey(name: 'user_deleted') bool userDeleted,
    @JsonKey(name: 'edit_reason') String? editReason,
    @JsonKey(name: 'can_view_edit_history') bool canViewEditHistory,
    @JsonKey(name: 'wiki') bool wiki,
    @JsonKey(name: 'reviewable_id') int? reviewableId,
    @JsonKey(name: 'reviewable_score_count') int? reviewableScoreCount,
    @JsonKey(name: 'reviewable_score_pending_count')
    int? reviewableScorePendingCount,
    @JsonKey(name: 'mentioned_users') List<Map<String, dynamic>> mentionedUsers,
    @JsonKey(name: 'reactions') List<Map<String, dynamic>> reactions,
    @JsonKey(name: 'current_user_reaction')
    Map<String, dynamic>? currentUserReaction,
    @JsonKey(name: 'reaction_users_count') int? reactionUsersCount,
    @JsonKey(name: 'bookmarked') bool bookmarked,
    @JsonKey(name: 'bookmarked_at') String? bookmarkedAt,
  });
}

/// @nodoc
class __$$DiscoursePostImplCopyWithImpl<$Res>
    extends _$DiscoursePostCopyWithImpl<$Res, _$DiscoursePostImpl>
    implements _$$DiscoursePostImplCopyWith<$Res> {
  __$$DiscoursePostImplCopyWithImpl(
    _$DiscoursePostImpl _value,
    $Res Function(_$DiscoursePostImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? username = null,
    Object? avatarTemplate = null,
    Object? createdAt = null,
    Object? cooked = freezed,
    Object? raw = freezed,
    Object? postNumber = null,
    Object? postType = null,
    Object? updatedAt = freezed,
    Object? replyCount = null,
    Object? replyToPostNumber = freezed,
    Object? quoteCount = null,
    Object? incomingLinkCount = null,
    Object? reads = null,
    Object? likeCount = null,
    Object? readersCount = null,
    Object? score = freezed,
    Object? yours = null,
    Object? topicId = null,
    Object? topicSlug = freezed,
    Object? displayUsername = freezed,
    Object? primaryGroupName = freezed,
    Object? flairName = freezed,
    Object? flairUrl = freezed,
    Object? flairBgColor = freezed,
    Object? flairColor = freezed,
    Object? version = null,
    Object? canEdit = null,
    Object? canDelete = null,
    Object? canRecover = null,
    Object? canSeeHiddenPost = null,
    Object? canWiki = null,
    Object? linkCounts = null,
    Object? actionsSummary = null,
    Object? moderator = null,
    Object? admin = null,
    Object? staff = null,
    Object? userId = freezed,
    Object? hidden = null,
    Object? trustLevel = null,
    Object? deletedAt = freezed,
    Object? userDeleted = null,
    Object? editReason = freezed,
    Object? canViewEditHistory = null,
    Object? wiki = null,
    Object? reviewableId = freezed,
    Object? reviewableScoreCount = freezed,
    Object? reviewableScorePendingCount = freezed,
    Object? mentionedUsers = null,
    Object? reactions = null,
    Object? currentUserReaction = freezed,
    Object? reactionUsersCount = freezed,
    Object? bookmarked = null,
    Object? bookmarkedAt = freezed,
  }) {
    return _then(
      _$DiscoursePostImpl(
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
        cooked: freezed == cooked
            ? _value.cooked
            : cooked // ignore: cast_nullable_to_non_nullable
                  as String?,
        raw: freezed == raw
            ? _value.raw
            : raw // ignore: cast_nullable_to_non_nullable
                  as String?,
        postNumber: null == postNumber
            ? _value.postNumber
            : postNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        postType: null == postType
            ? _value.postType
            : postType // ignore: cast_nullable_to_non_nullable
                  as int,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        replyCount: null == replyCount
            ? _value.replyCount
            : replyCount // ignore: cast_nullable_to_non_nullable
                  as int,
        replyToPostNumber: freezed == replyToPostNumber
            ? _value.replyToPostNumber
            : replyToPostNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        quoteCount: null == quoteCount
            ? _value.quoteCount
            : quoteCount // ignore: cast_nullable_to_non_nullable
                  as int,
        incomingLinkCount: null == incomingLinkCount
            ? _value.incomingLinkCount
            : incomingLinkCount // ignore: cast_nullable_to_non_nullable
                  as int,
        reads: null == reads
            ? _value.reads
            : reads // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        readersCount: null == readersCount
            ? _value.readersCount
            : readersCount // ignore: cast_nullable_to_non_nullable
                  as int,
        score: freezed == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as double?,
        yours: null == yours
            ? _value.yours
            : yours // ignore: cast_nullable_to_non_nullable
                  as bool,
        topicId: null == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int,
        topicSlug: freezed == topicSlug
            ? _value.topicSlug
            : topicSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        displayUsername: freezed == displayUsername
            ? _value.displayUsername
            : displayUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
        primaryGroupName: freezed == primaryGroupName
            ? _value.primaryGroupName
            : primaryGroupName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairName: freezed == flairName
            ? _value.flairName
            : flairName // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairUrl: freezed == flairUrl
            ? _value.flairUrl
            : flairUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairBgColor: freezed == flairBgColor
            ? _value.flairBgColor
            : flairBgColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        flairColor: freezed == flairColor
            ? _value.flairColor
            : flairColor // ignore: cast_nullable_to_non_nullable
                  as String?,
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        canEdit: null == canEdit
            ? _value.canEdit
            : canEdit // ignore: cast_nullable_to_non_nullable
                  as bool,
        canDelete: null == canDelete
            ? _value.canDelete
            : canDelete // ignore: cast_nullable_to_non_nullable
                  as bool,
        canRecover: null == canRecover
            ? _value.canRecover
            : canRecover // ignore: cast_nullable_to_non_nullable
                  as bool,
        canSeeHiddenPost: null == canSeeHiddenPost
            ? _value.canSeeHiddenPost
            : canSeeHiddenPost // ignore: cast_nullable_to_non_nullable
                  as bool,
        canWiki: null == canWiki
            ? _value.canWiki
            : canWiki // ignore: cast_nullable_to_non_nullable
                  as bool,
        linkCounts: null == linkCounts
            ? _value._linkCounts
            : linkCounts // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        actionsSummary: null == actionsSummary
            ? _value._actionsSummary
            : actionsSummary // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        moderator: null == moderator
            ? _value.moderator
            : moderator // ignore: cast_nullable_to_non_nullable
                  as bool,
        admin: null == admin
            ? _value.admin
            : admin // ignore: cast_nullable_to_non_nullable
                  as bool,
        staff: null == staff
            ? _value.staff
            : staff // ignore: cast_nullable_to_non_nullable
                  as bool,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as int?,
        hidden: null == hidden
            ? _value.hidden
            : hidden // ignore: cast_nullable_to_non_nullable
                  as bool,
        trustLevel: null == trustLevel
            ? _value.trustLevel
            : trustLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        deletedAt: freezed == deletedAt
            ? _value.deletedAt
            : deletedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        userDeleted: null == userDeleted
            ? _value.userDeleted
            : userDeleted // ignore: cast_nullable_to_non_nullable
                  as bool,
        editReason: freezed == editReason
            ? _value.editReason
            : editReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        canViewEditHistory: null == canViewEditHistory
            ? _value.canViewEditHistory
            : canViewEditHistory // ignore: cast_nullable_to_non_nullable
                  as bool,
        wiki: null == wiki
            ? _value.wiki
            : wiki // ignore: cast_nullable_to_non_nullable
                  as bool,
        reviewableId: freezed == reviewableId
            ? _value.reviewableId
            : reviewableId // ignore: cast_nullable_to_non_nullable
                  as int?,
        reviewableScoreCount: freezed == reviewableScoreCount
            ? _value.reviewableScoreCount
            : reviewableScoreCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        reviewableScorePendingCount: freezed == reviewableScorePendingCount
            ? _value.reviewableScorePendingCount
            : reviewableScorePendingCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        mentionedUsers: null == mentionedUsers
            ? _value._mentionedUsers
            : mentionedUsers // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        reactions: null == reactions
            ? _value._reactions
            : reactions // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
        currentUserReaction: freezed == currentUserReaction
            ? _value._currentUserReaction
            : currentUserReaction // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        reactionUsersCount: freezed == reactionUsersCount
            ? _value.reactionUsersCount
            : reactionUsersCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        bookmarked: null == bookmarked
            ? _value.bookmarked
            : bookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
        bookmarkedAt: freezed == bookmarkedAt
            ? _value.bookmarkedAt
            : bookmarkedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePostImpl implements _DiscoursePost {
  const _$DiscoursePostImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'cooked') this.cooked,
    @JsonKey(name: 'raw') this.raw,
    @JsonKey(name: 'post_number') required this.postNumber,
    @JsonKey(name: 'post_type') this.postType = 1,
    @JsonKey(name: 'updated_at') this.updatedAt,
    @JsonKey(name: 'reply_count') this.replyCount = 0,
    @JsonKey(name: 'reply_to_post_number') this.replyToPostNumber,
    @JsonKey(name: 'quote_count') this.quoteCount = 0,
    @JsonKey(name: 'incoming_link_count') this.incomingLinkCount = 0,
    @JsonKey(name: 'reads') this.reads = 0,
    @JsonKey(name: 'like_count') this.likeCount = 0,
    @JsonKey(name: 'readers_count') this.readersCount = 0,
    @JsonKey(name: 'score') this.score,
    @JsonKey(name: 'yours') this.yours = false,
    @JsonKey(name: 'topic_id') required this.topicId,
    @JsonKey(name: 'topic_slug') this.topicSlug,
    @JsonKey(name: 'display_username') this.displayUsername,
    @JsonKey(name: 'primary_group_name') this.primaryGroupName,
    @JsonKey(name: 'flair_name') this.flairName,
    @JsonKey(name: 'flair_url') this.flairUrl,
    @JsonKey(name: 'flair_bg_color') this.flairBgColor,
    @JsonKey(name: 'flair_color') this.flairColor,
    @JsonKey(name: 'version') this.version = 1,
    @JsonKey(name: 'can_edit') this.canEdit = false,
    @JsonKey(name: 'can_delete') this.canDelete = false,
    @JsonKey(name: 'can_recover') this.canRecover = false,
    @JsonKey(name: 'can_see_hidden_post') this.canSeeHiddenPost = false,
    @JsonKey(name: 'can_wiki') this.canWiki = false,
    @JsonKey(name: 'link_counts')
    final List<Map<String, dynamic>> linkCounts = const [],
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary = const [],
    @JsonKey(name: 'moderator') this.moderator = false,
    @JsonKey(name: 'admin') this.admin = false,
    @JsonKey(name: 'staff') this.staff = false,
    @JsonKey(name: 'user_id') this.userId,
    @JsonKey(name: 'hidden') this.hidden = false,
    @JsonKey(name: 'trust_level') this.trustLevel = 0,
    @JsonKey(name: 'deleted_at') this.deletedAt,
    @JsonKey(name: 'user_deleted') this.userDeleted = false,
    @JsonKey(name: 'edit_reason') this.editReason,
    @JsonKey(name: 'can_view_edit_history') this.canViewEditHistory = false,
    @JsonKey(name: 'wiki') this.wiki = false,
    @JsonKey(name: 'reviewable_id') this.reviewableId,
    @JsonKey(name: 'reviewable_score_count') this.reviewableScoreCount,
    @JsonKey(name: 'reviewable_score_pending_count')
    this.reviewableScorePendingCount,
    @JsonKey(name: 'mentioned_users')
    final List<Map<String, dynamic>> mentionedUsers = const [],
    @JsonKey(name: 'reactions')
    final List<Map<String, dynamic>> reactions = const [],
    @JsonKey(name: 'current_user_reaction')
    final Map<String, dynamic>? currentUserReaction,
    @JsonKey(name: 'reaction_users_count') this.reactionUsersCount,
    @JsonKey(name: 'bookmarked') this.bookmarked = false,
    @JsonKey(name: 'bookmarked_at') this.bookmarkedAt,
  }) : _linkCounts = linkCounts,
       _actionsSummary = actionsSummary,
       _mentionedUsers = mentionedUsers,
       _reactions = reactions,
       _currentUserReaction = currentUserReaction;

  factory _$DiscoursePostImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoursePostImplFromJson(json);

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
  @JsonKey(name: 'cooked')
  final String? cooked;
  @override
  @JsonKey(name: 'raw')
  final String? raw;
  @override
  @JsonKey(name: 'post_number')
  final int postNumber;
  @override
  @JsonKey(name: 'post_type')
  final int postType;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'reply_count')
  final int replyCount;
  @override
  @JsonKey(name: 'reply_to_post_number')
  final int? replyToPostNumber;
  @override
  @JsonKey(name: 'quote_count')
  final int quoteCount;
  @override
  @JsonKey(name: 'incoming_link_count')
  final int incomingLinkCount;
  @override
  @JsonKey(name: 'reads')
  final int reads;
  @override
  @JsonKey(name: 'like_count')
  final int likeCount;
  @override
  @JsonKey(name: 'readers_count')
  final int readersCount;
  @override
  @JsonKey(name: 'score')
  final double? score;
  @override
  @JsonKey(name: 'yours')
  final bool yours;
  @override
  @JsonKey(name: 'topic_id')
  final int topicId;
  @override
  @JsonKey(name: 'topic_slug')
  final String? topicSlug;
  @override
  @JsonKey(name: 'display_username')
  final String? displayUsername;
  @override
  @JsonKey(name: 'primary_group_name')
  final String? primaryGroupName;
  @override
  @JsonKey(name: 'flair_name')
  final String? flairName;
  @override
  @JsonKey(name: 'flair_url')
  final String? flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  final String? flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  final String? flairColor;
  @override
  @JsonKey(name: 'version')
  final int version;
  @override
  @JsonKey(name: 'can_edit')
  final bool canEdit;
  @override
  @JsonKey(name: 'can_delete')
  final bool canDelete;
  @override
  @JsonKey(name: 'can_recover')
  final bool canRecover;
  @override
  @JsonKey(name: 'can_see_hidden_post')
  final bool canSeeHiddenPost;
  @override
  @JsonKey(name: 'can_wiki')
  final bool canWiki;
  final List<Map<String, dynamic>> _linkCounts;
  @override
  @JsonKey(name: 'link_counts')
  List<Map<String, dynamic>> get linkCounts {
    if (_linkCounts is EqualUnmodifiableListView) return _linkCounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_linkCounts);
  }

  final List<Map<String, dynamic>> _actionsSummary;
  @override
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary {
    if (_actionsSummary is EqualUnmodifiableListView) return _actionsSummary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_actionsSummary);
  }

  @override
  @JsonKey(name: 'moderator')
  final bool moderator;
  @override
  @JsonKey(name: 'admin')
  final bool admin;
  @override
  @JsonKey(name: 'staff')
  final bool staff;
  @override
  @JsonKey(name: 'user_id')
  final int? userId;
  @override
  @JsonKey(name: 'hidden')
  final bool hidden;
  @override
  @JsonKey(name: 'trust_level')
  final int trustLevel;
  @override
  @JsonKey(name: 'deleted_at')
  final String? deletedAt;
  @override
  @JsonKey(name: 'user_deleted')
  final bool userDeleted;
  @override
  @JsonKey(name: 'edit_reason')
  final String? editReason;
  @override
  @JsonKey(name: 'can_view_edit_history')
  final bool canViewEditHistory;
  @override
  @JsonKey(name: 'wiki')
  final bool wiki;
  @override
  @JsonKey(name: 'reviewable_id')
  final int? reviewableId;
  @override
  @JsonKey(name: 'reviewable_score_count')
  final int? reviewableScoreCount;
  @override
  @JsonKey(name: 'reviewable_score_pending_count')
  final int? reviewableScorePendingCount;
  final List<Map<String, dynamic>> _mentionedUsers;
  @override
  @JsonKey(name: 'mentioned_users')
  List<Map<String, dynamic>> get mentionedUsers {
    if (_mentionedUsers is EqualUnmodifiableListView) return _mentionedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mentionedUsers);
  }

  final List<Map<String, dynamic>> _reactions;
  @override
  @JsonKey(name: 'reactions')
  List<Map<String, dynamic>> get reactions {
    if (_reactions is EqualUnmodifiableListView) return _reactions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_reactions);
  }

  final Map<String, dynamic>? _currentUserReaction;
  @override
  @JsonKey(name: 'current_user_reaction')
  Map<String, dynamic>? get currentUserReaction {
    final value = _currentUserReaction;
    if (value == null) return null;
    if (_currentUserReaction is EqualUnmodifiableMapView)
      return _currentUserReaction;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'reaction_users_count')
  final int? reactionUsersCount;
  @override
  @JsonKey(name: 'bookmarked')
  final bool bookmarked;
  @override
  @JsonKey(name: 'bookmarked_at')
  final String? bookmarkedAt;

  @override
  String toString() {
    return 'DiscoursePost(id: $id, name: $name, username: $username, avatarTemplate: $avatarTemplate, createdAt: $createdAt, cooked: $cooked, raw: $raw, postNumber: $postNumber, postType: $postType, updatedAt: $updatedAt, replyCount: $replyCount, replyToPostNumber: $replyToPostNumber, quoteCount: $quoteCount, incomingLinkCount: $incomingLinkCount, reads: $reads, likeCount: $likeCount, readersCount: $readersCount, score: $score, yours: $yours, topicId: $topicId, topicSlug: $topicSlug, displayUsername: $displayUsername, primaryGroupName: $primaryGroupName, flairName: $flairName, flairUrl: $flairUrl, flairBgColor: $flairBgColor, flairColor: $flairColor, version: $version, canEdit: $canEdit, canDelete: $canDelete, canRecover: $canRecover, canSeeHiddenPost: $canSeeHiddenPost, canWiki: $canWiki, linkCounts: $linkCounts, actionsSummary: $actionsSummary, moderator: $moderator, admin: $admin, staff: $staff, userId: $userId, hidden: $hidden, trustLevel: $trustLevel, deletedAt: $deletedAt, userDeleted: $userDeleted, editReason: $editReason, canViewEditHistory: $canViewEditHistory, wiki: $wiki, reviewableId: $reviewableId, reviewableScoreCount: $reviewableScoreCount, reviewableScorePendingCount: $reviewableScorePendingCount, mentionedUsers: $mentionedUsers, reactions: $reactions, currentUserReaction: $currentUserReaction, reactionUsersCount: $reactionUsersCount, bookmarked: $bookmarked, bookmarkedAt: $bookmarkedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.cooked, cooked) || other.cooked == cooked) &&
            (identical(other.raw, raw) || other.raw == raw) &&
            (identical(other.postNumber, postNumber) ||
                other.postNumber == postNumber) &&
            (identical(other.postType, postType) ||
                other.postType == postType) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.replyCount, replyCount) ||
                other.replyCount == replyCount) &&
            (identical(other.replyToPostNumber, replyToPostNumber) ||
                other.replyToPostNumber == replyToPostNumber) &&
            (identical(other.quoteCount, quoteCount) ||
                other.quoteCount == quoteCount) &&
            (identical(other.incomingLinkCount, incomingLinkCount) ||
                other.incomingLinkCount == incomingLinkCount) &&
            (identical(other.reads, reads) || other.reads == reads) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.readersCount, readersCount) ||
                other.readersCount == readersCount) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.yours, yours) || other.yours == yours) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.topicSlug, topicSlug) ||
                other.topicSlug == topicSlug) &&
            (identical(other.displayUsername, displayUsername) ||
                other.displayUsername == displayUsername) &&
            (identical(other.primaryGroupName, primaryGroupName) ||
                other.primaryGroupName == primaryGroupName) &&
            (identical(other.flairName, flairName) ||
                other.flairName == flairName) &&
            (identical(other.flairUrl, flairUrl) ||
                other.flairUrl == flairUrl) &&
            (identical(other.flairBgColor, flairBgColor) ||
                other.flairBgColor == flairBgColor) &&
            (identical(other.flairColor, flairColor) ||
                other.flairColor == flairColor) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.canDelete, canDelete) ||
                other.canDelete == canDelete) &&
            (identical(other.canRecover, canRecover) ||
                other.canRecover == canRecover) &&
            (identical(other.canSeeHiddenPost, canSeeHiddenPost) ||
                other.canSeeHiddenPost == canSeeHiddenPost) &&
            (identical(other.canWiki, canWiki) || other.canWiki == canWiki) &&
            const DeepCollectionEquality().equals(
              other._linkCounts,
              _linkCounts,
            ) &&
            const DeepCollectionEquality().equals(
              other._actionsSummary,
              _actionsSummary,
            ) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.staff, staff) || other.staff == staff) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.hidden, hidden) || other.hidden == hidden) &&
            (identical(other.trustLevel, trustLevel) ||
                other.trustLevel == trustLevel) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.userDeleted, userDeleted) ||
                other.userDeleted == userDeleted) &&
            (identical(other.editReason, editReason) ||
                other.editReason == editReason) &&
            (identical(other.canViewEditHistory, canViewEditHistory) ||
                other.canViewEditHistory == canViewEditHistory) &&
            (identical(other.wiki, wiki) || other.wiki == wiki) &&
            (identical(other.reviewableId, reviewableId) ||
                other.reviewableId == reviewableId) &&
            (identical(other.reviewableScoreCount, reviewableScoreCount) ||
                other.reviewableScoreCount == reviewableScoreCount) &&
            (identical(
                  other.reviewableScorePendingCount,
                  reviewableScorePendingCount,
                ) ||
                other.reviewableScorePendingCount ==
                    reviewableScorePendingCount) &&
            const DeepCollectionEquality().equals(
              other._mentionedUsers,
              _mentionedUsers,
            ) &&
            const DeepCollectionEquality().equals(
              other._reactions,
              _reactions,
            ) &&
            const DeepCollectionEquality().equals(
              other._currentUserReaction,
              _currentUserReaction,
            ) &&
            (identical(other.reactionUsersCount, reactionUsersCount) ||
                other.reactionUsersCount == reactionUsersCount) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked) &&
            (identical(other.bookmarkedAt, bookmarkedAt) ||
                other.bookmarkedAt == bookmarkedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    username,
    avatarTemplate,
    createdAt,
    cooked,
    raw,
    postNumber,
    postType,
    updatedAt,
    replyCount,
    replyToPostNumber,
    quoteCount,
    incomingLinkCount,
    reads,
    likeCount,
    readersCount,
    score,
    yours,
    topicId,
    topicSlug,
    displayUsername,
    primaryGroupName,
    flairName,
    flairUrl,
    flairBgColor,
    flairColor,
    version,
    canEdit,
    canDelete,
    canRecover,
    canSeeHiddenPost,
    canWiki,
    const DeepCollectionEquality().hash(_linkCounts),
    const DeepCollectionEquality().hash(_actionsSummary),
    moderator,
    admin,
    staff,
    userId,
    hidden,
    trustLevel,
    deletedAt,
    userDeleted,
    editReason,
    canViewEditHistory,
    wiki,
    reviewableId,
    reviewableScoreCount,
    reviewableScorePendingCount,
    const DeepCollectionEquality().hash(_mentionedUsers),
    const DeepCollectionEquality().hash(_reactions),
    const DeepCollectionEquality().hash(_currentUserReaction),
    reactionUsersCount,
    bookmarked,
    bookmarkedAt,
  ]);

  /// Create a copy of DiscoursePost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePostImplCopyWith<_$DiscoursePostImpl> get copyWith =>
      __$$DiscoursePostImplCopyWithImpl<_$DiscoursePostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePostImplToJson(this);
  }
}

abstract class _DiscoursePost implements DiscoursePost {
  const factory _DiscoursePost({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'cooked') final String? cooked,
    @JsonKey(name: 'raw') final String? raw,
    @JsonKey(name: 'post_number') required final int postNumber,
    @JsonKey(name: 'post_type') final int postType,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    @JsonKey(name: 'reply_count') final int replyCount,
    @JsonKey(name: 'reply_to_post_number') final int? replyToPostNumber,
    @JsonKey(name: 'quote_count') final int quoteCount,
    @JsonKey(name: 'incoming_link_count') final int incomingLinkCount,
    @JsonKey(name: 'reads') final int reads,
    @JsonKey(name: 'like_count') final int likeCount,
    @JsonKey(name: 'readers_count') final int readersCount,
    @JsonKey(name: 'score') final double? score,
    @JsonKey(name: 'yours') final bool yours,
    @JsonKey(name: 'topic_id') required final int topicId,
    @JsonKey(name: 'topic_slug') final String? topicSlug,
    @JsonKey(name: 'display_username') final String? displayUsername,
    @JsonKey(name: 'primary_group_name') final String? primaryGroupName,
    @JsonKey(name: 'flair_name') final String? flairName,
    @JsonKey(name: 'flair_url') final String? flairUrl,
    @JsonKey(name: 'flair_bg_color') final String? flairBgColor,
    @JsonKey(name: 'flair_color') final String? flairColor,
    @JsonKey(name: 'version') final int version,
    @JsonKey(name: 'can_edit') final bool canEdit,
    @JsonKey(name: 'can_delete') final bool canDelete,
    @JsonKey(name: 'can_recover') final bool canRecover,
    @JsonKey(name: 'can_see_hidden_post') final bool canSeeHiddenPost,
    @JsonKey(name: 'can_wiki') final bool canWiki,
    @JsonKey(name: 'link_counts') final List<Map<String, dynamic>> linkCounts,
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') final bool moderator,
    @JsonKey(name: 'admin') final bool admin,
    @JsonKey(name: 'staff') final bool staff,
    @JsonKey(name: 'user_id') final int? userId,
    @JsonKey(name: 'hidden') final bool hidden,
    @JsonKey(name: 'trust_level') final int trustLevel,
    @JsonKey(name: 'deleted_at') final String? deletedAt,
    @JsonKey(name: 'user_deleted') final bool userDeleted,
    @JsonKey(name: 'edit_reason') final String? editReason,
    @JsonKey(name: 'can_view_edit_history') final bool canViewEditHistory,
    @JsonKey(name: 'wiki') final bool wiki,
    @JsonKey(name: 'reviewable_id') final int? reviewableId,
    @JsonKey(name: 'reviewable_score_count') final int? reviewableScoreCount,
    @JsonKey(name: 'reviewable_score_pending_count')
    final int? reviewableScorePendingCount,
    @JsonKey(name: 'mentioned_users')
    final List<Map<String, dynamic>> mentionedUsers,
    @JsonKey(name: 'reactions') final List<Map<String, dynamic>> reactions,
    @JsonKey(name: 'current_user_reaction')
    final Map<String, dynamic>? currentUserReaction,
    @JsonKey(name: 'reaction_users_count') final int? reactionUsersCount,
    @JsonKey(name: 'bookmarked') final bool bookmarked,
    @JsonKey(name: 'bookmarked_at') final String? bookmarkedAt,
  }) = _$DiscoursePostImpl;

  factory _DiscoursePost.fromJson(Map<String, dynamic> json) =
      _$DiscoursePostImpl.fromJson;

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
  @JsonKey(name: 'cooked')
  String? get cooked;
  @override
  @JsonKey(name: 'raw')
  String? get raw;
  @override
  @JsonKey(name: 'post_number')
  int get postNumber;
  @override
  @JsonKey(name: 'post_type')
  int get postType;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'reply_count')
  int get replyCount;
  @override
  @JsonKey(name: 'reply_to_post_number')
  int? get replyToPostNumber;
  @override
  @JsonKey(name: 'quote_count')
  int get quoteCount;
  @override
  @JsonKey(name: 'incoming_link_count')
  int get incomingLinkCount;
  @override
  @JsonKey(name: 'reads')
  int get reads;
  @override
  @JsonKey(name: 'like_count')
  int get likeCount;
  @override
  @JsonKey(name: 'readers_count')
  int get readersCount;
  @override
  @JsonKey(name: 'score')
  double? get score;
  @override
  @JsonKey(name: 'yours')
  bool get yours;
  @override
  @JsonKey(name: 'topic_id')
  int get topicId;
  @override
  @JsonKey(name: 'topic_slug')
  String? get topicSlug;
  @override
  @JsonKey(name: 'display_username')
  String? get displayUsername;
  @override
  @JsonKey(name: 'primary_group_name')
  String? get primaryGroupName;
  @override
  @JsonKey(name: 'flair_name')
  String? get flairName;
  @override
  @JsonKey(name: 'flair_url')
  String? get flairUrl;
  @override
  @JsonKey(name: 'flair_bg_color')
  String? get flairBgColor;
  @override
  @JsonKey(name: 'flair_color')
  String? get flairColor;
  @override
  @JsonKey(name: 'version')
  int get version;
  @override
  @JsonKey(name: 'can_edit')
  bool get canEdit;
  @override
  @JsonKey(name: 'can_delete')
  bool get canDelete;
  @override
  @JsonKey(name: 'can_recover')
  bool get canRecover;
  @override
  @JsonKey(name: 'can_see_hidden_post')
  bool get canSeeHiddenPost;
  @override
  @JsonKey(name: 'can_wiki')
  bool get canWiki;
  @override
  @JsonKey(name: 'link_counts')
  List<Map<String, dynamic>> get linkCounts;
  @override
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary;
  @override
  @JsonKey(name: 'moderator')
  bool get moderator;
  @override
  @JsonKey(name: 'admin')
  bool get admin;
  @override
  @JsonKey(name: 'staff')
  bool get staff;
  @override
  @JsonKey(name: 'user_id')
  int? get userId;
  @override
  @JsonKey(name: 'hidden')
  bool get hidden;
  @override
  @JsonKey(name: 'trust_level')
  int get trustLevel;
  @override
  @JsonKey(name: 'deleted_at')
  String? get deletedAt;
  @override
  @JsonKey(name: 'user_deleted')
  bool get userDeleted;
  @override
  @JsonKey(name: 'edit_reason')
  String? get editReason;
  @override
  @JsonKey(name: 'can_view_edit_history')
  bool get canViewEditHistory;
  @override
  @JsonKey(name: 'wiki')
  bool get wiki;
  @override
  @JsonKey(name: 'reviewable_id')
  int? get reviewableId;
  @override
  @JsonKey(name: 'reviewable_score_count')
  int? get reviewableScoreCount;
  @override
  @JsonKey(name: 'reviewable_score_pending_count')
  int? get reviewableScorePendingCount;
  @override
  @JsonKey(name: 'mentioned_users')
  List<Map<String, dynamic>> get mentionedUsers;
  @override
  @JsonKey(name: 'reactions')
  List<Map<String, dynamic>> get reactions;
  @override
  @JsonKey(name: 'current_user_reaction')
  Map<String, dynamic>? get currentUserReaction;
  @override
  @JsonKey(name: 'reaction_users_count')
  int? get reactionUsersCount;
  @override
  @JsonKey(name: 'bookmarked')
  bool get bookmarked;
  @override
  @JsonKey(name: 'bookmarked_at')
  String? get bookmarkedAt;

  /// Create a copy of DiscoursePost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePostImplCopyWith<_$DiscoursePostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DiscourseTopicDetails _$DiscourseTopicDetailsFromJson(
  Map<String, dynamic> json,
) {
  return _DiscourseTopicDetails.fromJson(json);
}

/// @nodoc
mixin _$DiscourseTopicDetails {
  @JsonKey(name: 'notification_level')
  int? get notificationLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'notifications_reason_id')
  int? get notificationsReasonId => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_move_posts')
  bool? get canMovePosts => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_edit')
  bool? get canEdit => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_delete')
  bool? get canDelete => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_remove_allowed_users')
  bool? get canRemoveAllowedUsers => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_invite_to')
  bool? get canInviteTo => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_invite_via_email')
  bool? get canInviteViaEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_create_post')
  bool? get canCreatePost => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_reply_as_new_topic')
  bool? get canReplyAsNewTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_flag_topic')
  bool? get canFlagTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_convert_topic')
  bool? get canConvertTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_review_topic')
  bool? get canReviewTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_close_topic')
  bool? get canCloseTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_archive_topic')
  bool? get canArchiveTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_split_merge_topic')
  bool? get canSplitMergeTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_edit_staff_notes')
  bool? get canEditStaffNotes => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_toggle_topic_visibility')
  bool? get canToggleTopicVisibility => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_pin_unpin_topic')
  bool? get canPinUnpinTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_moderate_category')
  bool? get canModerateCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_remove_self_id')
  int? get canRemoveSelfId => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'created_by')
  DiscourseCreatedBy? get createdBy => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_poster')
  DiscourseCreatedBy? get lastPoster => throw _privateConstructorUsedError;
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'allowed_groups')
  List<Map<String, dynamic>> get allowedGroups =>
      throw _privateConstructorUsedError;

  /// Serializes this DiscourseTopicDetails to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseTopicDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseTopicDetailsCopyWith<DiscourseTopicDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseTopicDetailsCopyWith<$Res> {
  factory $DiscourseTopicDetailsCopyWith(
    DiscourseTopicDetails value,
    $Res Function(DiscourseTopicDetails) then,
  ) = _$DiscourseTopicDetailsCopyWithImpl<$Res, DiscourseTopicDetails>;
  @useResult
  $Res call({
    @JsonKey(name: 'notification_level') int? notificationLevel,
    @JsonKey(name: 'notifications_reason_id') int? notificationsReasonId,
    @JsonKey(name: 'can_move_posts') bool? canMovePosts,
    @JsonKey(name: 'can_edit') bool? canEdit,
    @JsonKey(name: 'can_delete') bool? canDelete,
    @JsonKey(name: 'can_remove_allowed_users') bool? canRemoveAllowedUsers,
    @JsonKey(name: 'can_invite_to') bool? canInviteTo,
    @JsonKey(name: 'can_invite_via_email') bool? canInviteViaEmail,
    @JsonKey(name: 'can_create_post') bool? canCreatePost,
    @JsonKey(name: 'can_reply_as_new_topic') bool? canReplyAsNewTopic,
    @JsonKey(name: 'can_flag_topic') bool? canFlagTopic,
    @JsonKey(name: 'can_convert_topic') bool? canConvertTopic,
    @JsonKey(name: 'can_review_topic') bool? canReviewTopic,
    @JsonKey(name: 'can_close_topic') bool? canCloseTopic,
    @JsonKey(name: 'can_archive_topic') bool? canArchiveTopic,
    @JsonKey(name: 'can_split_merge_topic') bool? canSplitMergeTopic,
    @JsonKey(name: 'can_edit_staff_notes') bool? canEditStaffNotes,
    @JsonKey(name: 'can_toggle_topic_visibility')
    bool? canToggleTopicVisibility,
    @JsonKey(name: 'can_pin_unpin_topic') bool? canPinUnpinTopic,
    @JsonKey(name: 'can_moderate_category') bool? canModerateCategory,
    @JsonKey(name: 'can_remove_self_id') int? canRemoveSelfId,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'created_by') DiscourseCreatedBy? createdBy,
    @JsonKey(name: 'last_poster') DiscourseCreatedBy? lastPoster,
    @JsonKey(name: 'allowed_users') List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'allowed_groups') List<Map<String, dynamic>> allowedGroups,
  });

  $DiscourseCreatedByCopyWith<$Res>? get createdBy;
  $DiscourseCreatedByCopyWith<$Res>? get lastPoster;
}

/// @nodoc
class _$DiscourseTopicDetailsCopyWithImpl<
  $Res,
  $Val extends DiscourseTopicDetails
>
    implements $DiscourseTopicDetailsCopyWith<$Res> {
  _$DiscourseTopicDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseTopicDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationLevel = freezed,
    Object? notificationsReasonId = freezed,
    Object? canMovePosts = freezed,
    Object? canEdit = freezed,
    Object? canDelete = freezed,
    Object? canRemoveAllowedUsers = freezed,
    Object? canInviteTo = freezed,
    Object? canInviteViaEmail = freezed,
    Object? canCreatePost = freezed,
    Object? canReplyAsNewTopic = freezed,
    Object? canFlagTopic = freezed,
    Object? canConvertTopic = freezed,
    Object? canReviewTopic = freezed,
    Object? canCloseTopic = freezed,
    Object? canArchiveTopic = freezed,
    Object? canSplitMergeTopic = freezed,
    Object? canEditStaffNotes = freezed,
    Object? canToggleTopicVisibility = freezed,
    Object? canPinUnpinTopic = freezed,
    Object? canModerateCategory = freezed,
    Object? canRemoveSelfId = freezed,
    Object? participants = null,
    Object? createdBy = freezed,
    Object? lastPoster = freezed,
    Object? allowedUsers = null,
    Object? allowedGroups = null,
  }) {
    return _then(
      _value.copyWith(
            notificationLevel: freezed == notificationLevel
                ? _value.notificationLevel
                : notificationLevel // ignore: cast_nullable_to_non_nullable
                      as int?,
            notificationsReasonId: freezed == notificationsReasonId
                ? _value.notificationsReasonId
                : notificationsReasonId // ignore: cast_nullable_to_non_nullable
                      as int?,
            canMovePosts: freezed == canMovePosts
                ? _value.canMovePosts
                : canMovePosts // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canEdit: freezed == canEdit
                ? _value.canEdit
                : canEdit // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canDelete: freezed == canDelete
                ? _value.canDelete
                : canDelete // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canRemoveAllowedUsers: freezed == canRemoveAllowedUsers
                ? _value.canRemoveAllowedUsers
                : canRemoveAllowedUsers // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canInviteTo: freezed == canInviteTo
                ? _value.canInviteTo
                : canInviteTo // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canInviteViaEmail: freezed == canInviteViaEmail
                ? _value.canInviteViaEmail
                : canInviteViaEmail // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canCreatePost: freezed == canCreatePost
                ? _value.canCreatePost
                : canCreatePost // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canReplyAsNewTopic: freezed == canReplyAsNewTopic
                ? _value.canReplyAsNewTopic
                : canReplyAsNewTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canFlagTopic: freezed == canFlagTopic
                ? _value.canFlagTopic
                : canFlagTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canConvertTopic: freezed == canConvertTopic
                ? _value.canConvertTopic
                : canConvertTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canReviewTopic: freezed == canReviewTopic
                ? _value.canReviewTopic
                : canReviewTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canCloseTopic: freezed == canCloseTopic
                ? _value.canCloseTopic
                : canCloseTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canArchiveTopic: freezed == canArchiveTopic
                ? _value.canArchiveTopic
                : canArchiveTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canSplitMergeTopic: freezed == canSplitMergeTopic
                ? _value.canSplitMergeTopic
                : canSplitMergeTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canEditStaffNotes: freezed == canEditStaffNotes
                ? _value.canEditStaffNotes
                : canEditStaffNotes // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canToggleTopicVisibility: freezed == canToggleTopicVisibility
                ? _value.canToggleTopicVisibility
                : canToggleTopicVisibility // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canPinUnpinTopic: freezed == canPinUnpinTopic
                ? _value.canPinUnpinTopic
                : canPinUnpinTopic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canModerateCategory: freezed == canModerateCategory
                ? _value.canModerateCategory
                : canModerateCategory // ignore: cast_nullable_to_non_nullable
                      as bool?,
            canRemoveSelfId: freezed == canRemoveSelfId
                ? _value.canRemoveSelfId
                : canRemoveSelfId // ignore: cast_nullable_to_non_nullable
                      as int?,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseParticipant>,
            createdBy: freezed == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as DiscourseCreatedBy?,
            lastPoster: freezed == lastPoster
                ? _value.lastPoster
                : lastPoster // ignore: cast_nullable_to_non_nullable
                      as DiscourseCreatedBy?,
            allowedUsers: null == allowedUsers
                ? _value.allowedUsers
                : allowedUsers // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBasic>,
            allowedGroups: null == allowedGroups
                ? _value.allowedGroups
                : allowedGroups // ignore: cast_nullable_to_non_nullable
                      as List<Map<String, dynamic>>,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscourseTopicDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseCreatedByCopyWith<$Res>? get createdBy {
    if (_value.createdBy == null) {
      return null;
    }

    return $DiscourseCreatedByCopyWith<$Res>(_value.createdBy!, (value) {
      return _then(_value.copyWith(createdBy: value) as $Val);
    });
  }

  /// Create a copy of DiscourseTopicDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseCreatedByCopyWith<$Res>? get lastPoster {
    if (_value.lastPoster == null) {
      return null;
    }

    return $DiscourseCreatedByCopyWith<$Res>(_value.lastPoster!, (value) {
      return _then(_value.copyWith(lastPoster: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscourseTopicDetailsImplCopyWith<$Res>
    implements $DiscourseTopicDetailsCopyWith<$Res> {
  factory _$$DiscourseTopicDetailsImplCopyWith(
    _$DiscourseTopicDetailsImpl value,
    $Res Function(_$DiscourseTopicDetailsImpl) then,
  ) = __$$DiscourseTopicDetailsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'notification_level') int? notificationLevel,
    @JsonKey(name: 'notifications_reason_id') int? notificationsReasonId,
    @JsonKey(name: 'can_move_posts') bool? canMovePosts,
    @JsonKey(name: 'can_edit') bool? canEdit,
    @JsonKey(name: 'can_delete') bool? canDelete,
    @JsonKey(name: 'can_remove_allowed_users') bool? canRemoveAllowedUsers,
    @JsonKey(name: 'can_invite_to') bool? canInviteTo,
    @JsonKey(name: 'can_invite_via_email') bool? canInviteViaEmail,
    @JsonKey(name: 'can_create_post') bool? canCreatePost,
    @JsonKey(name: 'can_reply_as_new_topic') bool? canReplyAsNewTopic,
    @JsonKey(name: 'can_flag_topic') bool? canFlagTopic,
    @JsonKey(name: 'can_convert_topic') bool? canConvertTopic,
    @JsonKey(name: 'can_review_topic') bool? canReviewTopic,
    @JsonKey(name: 'can_close_topic') bool? canCloseTopic,
    @JsonKey(name: 'can_archive_topic') bool? canArchiveTopic,
    @JsonKey(name: 'can_split_merge_topic') bool? canSplitMergeTopic,
    @JsonKey(name: 'can_edit_staff_notes') bool? canEditStaffNotes,
    @JsonKey(name: 'can_toggle_topic_visibility')
    bool? canToggleTopicVisibility,
    @JsonKey(name: 'can_pin_unpin_topic') bool? canPinUnpinTopic,
    @JsonKey(name: 'can_moderate_category') bool? canModerateCategory,
    @JsonKey(name: 'can_remove_self_id') int? canRemoveSelfId,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'created_by') DiscourseCreatedBy? createdBy,
    @JsonKey(name: 'last_poster') DiscourseCreatedBy? lastPoster,
    @JsonKey(name: 'allowed_users') List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'allowed_groups') List<Map<String, dynamic>> allowedGroups,
  });

  @override
  $DiscourseCreatedByCopyWith<$Res>? get createdBy;
  @override
  $DiscourseCreatedByCopyWith<$Res>? get lastPoster;
}

/// @nodoc
class __$$DiscourseTopicDetailsImplCopyWithImpl<$Res>
    extends
        _$DiscourseTopicDetailsCopyWithImpl<$Res, _$DiscourseTopicDetailsImpl>
    implements _$$DiscourseTopicDetailsImplCopyWith<$Res> {
  __$$DiscourseTopicDetailsImplCopyWithImpl(
    _$DiscourseTopicDetailsImpl _value,
    $Res Function(_$DiscourseTopicDetailsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseTopicDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationLevel = freezed,
    Object? notificationsReasonId = freezed,
    Object? canMovePosts = freezed,
    Object? canEdit = freezed,
    Object? canDelete = freezed,
    Object? canRemoveAllowedUsers = freezed,
    Object? canInviteTo = freezed,
    Object? canInviteViaEmail = freezed,
    Object? canCreatePost = freezed,
    Object? canReplyAsNewTopic = freezed,
    Object? canFlagTopic = freezed,
    Object? canConvertTopic = freezed,
    Object? canReviewTopic = freezed,
    Object? canCloseTopic = freezed,
    Object? canArchiveTopic = freezed,
    Object? canSplitMergeTopic = freezed,
    Object? canEditStaffNotes = freezed,
    Object? canToggleTopicVisibility = freezed,
    Object? canPinUnpinTopic = freezed,
    Object? canModerateCategory = freezed,
    Object? canRemoveSelfId = freezed,
    Object? participants = null,
    Object? createdBy = freezed,
    Object? lastPoster = freezed,
    Object? allowedUsers = null,
    Object? allowedGroups = null,
  }) {
    return _then(
      _$DiscourseTopicDetailsImpl(
        notificationLevel: freezed == notificationLevel
            ? _value.notificationLevel
            : notificationLevel // ignore: cast_nullable_to_non_nullable
                  as int?,
        notificationsReasonId: freezed == notificationsReasonId
            ? _value.notificationsReasonId
            : notificationsReasonId // ignore: cast_nullable_to_non_nullable
                  as int?,
        canMovePosts: freezed == canMovePosts
            ? _value.canMovePosts
            : canMovePosts // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canEdit: freezed == canEdit
            ? _value.canEdit
            : canEdit // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canDelete: freezed == canDelete
            ? _value.canDelete
            : canDelete // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canRemoveAllowedUsers: freezed == canRemoveAllowedUsers
            ? _value.canRemoveAllowedUsers
            : canRemoveAllowedUsers // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canInviteTo: freezed == canInviteTo
            ? _value.canInviteTo
            : canInviteTo // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canInviteViaEmail: freezed == canInviteViaEmail
            ? _value.canInviteViaEmail
            : canInviteViaEmail // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canCreatePost: freezed == canCreatePost
            ? _value.canCreatePost
            : canCreatePost // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canReplyAsNewTopic: freezed == canReplyAsNewTopic
            ? _value.canReplyAsNewTopic
            : canReplyAsNewTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canFlagTopic: freezed == canFlagTopic
            ? _value.canFlagTopic
            : canFlagTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canConvertTopic: freezed == canConvertTopic
            ? _value.canConvertTopic
            : canConvertTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canReviewTopic: freezed == canReviewTopic
            ? _value.canReviewTopic
            : canReviewTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canCloseTopic: freezed == canCloseTopic
            ? _value.canCloseTopic
            : canCloseTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canArchiveTopic: freezed == canArchiveTopic
            ? _value.canArchiveTopic
            : canArchiveTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canSplitMergeTopic: freezed == canSplitMergeTopic
            ? _value.canSplitMergeTopic
            : canSplitMergeTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canEditStaffNotes: freezed == canEditStaffNotes
            ? _value.canEditStaffNotes
            : canEditStaffNotes // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canToggleTopicVisibility: freezed == canToggleTopicVisibility
            ? _value.canToggleTopicVisibility
            : canToggleTopicVisibility // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canPinUnpinTopic: freezed == canPinUnpinTopic
            ? _value.canPinUnpinTopic
            : canPinUnpinTopic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canModerateCategory: freezed == canModerateCategory
            ? _value.canModerateCategory
            : canModerateCategory // ignore: cast_nullable_to_non_nullable
                  as bool?,
        canRemoveSelfId: freezed == canRemoveSelfId
            ? _value.canRemoveSelfId
            : canRemoveSelfId // ignore: cast_nullable_to_non_nullable
                  as int?,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseParticipant>,
        createdBy: freezed == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as DiscourseCreatedBy?,
        lastPoster: freezed == lastPoster
            ? _value.lastPoster
            : lastPoster // ignore: cast_nullable_to_non_nullable
                  as DiscourseCreatedBy?,
        allowedUsers: null == allowedUsers
            ? _value._allowedUsers
            : allowedUsers // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBasic>,
        allowedGroups: null == allowedGroups
            ? _value._allowedGroups
            : allowedGroups // ignore: cast_nullable_to_non_nullable
                  as List<Map<String, dynamic>>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscourseTopicDetailsImpl implements _DiscourseTopicDetails {
  const _$DiscourseTopicDetailsImpl({
    @JsonKey(name: 'notification_level') this.notificationLevel,
    @JsonKey(name: 'notifications_reason_id') this.notificationsReasonId,
    @JsonKey(name: 'can_move_posts') this.canMovePosts,
    @JsonKey(name: 'can_edit') this.canEdit,
    @JsonKey(name: 'can_delete') this.canDelete,
    @JsonKey(name: 'can_remove_allowed_users') this.canRemoveAllowedUsers,
    @JsonKey(name: 'can_invite_to') this.canInviteTo,
    @JsonKey(name: 'can_invite_via_email') this.canInviteViaEmail,
    @JsonKey(name: 'can_create_post') this.canCreatePost,
    @JsonKey(name: 'can_reply_as_new_topic') this.canReplyAsNewTopic,
    @JsonKey(name: 'can_flag_topic') this.canFlagTopic,
    @JsonKey(name: 'can_convert_topic') this.canConvertTopic,
    @JsonKey(name: 'can_review_topic') this.canReviewTopic,
    @JsonKey(name: 'can_close_topic') this.canCloseTopic,
    @JsonKey(name: 'can_archive_topic') this.canArchiveTopic,
    @JsonKey(name: 'can_split_merge_topic') this.canSplitMergeTopic,
    @JsonKey(name: 'can_edit_staff_notes') this.canEditStaffNotes,
    @JsonKey(name: 'can_toggle_topic_visibility') this.canToggleTopicVisibility,
    @JsonKey(name: 'can_pin_unpin_topic') this.canPinUnpinTopic,
    @JsonKey(name: 'can_moderate_category') this.canModerateCategory,
    @JsonKey(name: 'can_remove_self_id') this.canRemoveSelfId,
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants = const [],
    @JsonKey(name: 'created_by') this.createdBy,
    @JsonKey(name: 'last_poster') this.lastPoster,
    @JsonKey(name: 'allowed_users')
    final List<DiscourseUserBasic> allowedUsers = const [],
    @JsonKey(name: 'allowed_groups')
    final List<Map<String, dynamic>> allowedGroups = const [],
  }) : _participants = participants,
       _allowedUsers = allowedUsers,
       _allowedGroups = allowedGroups;

  factory _$DiscourseTopicDetailsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseTopicDetailsImplFromJson(json);

  @override
  @JsonKey(name: 'notification_level')
  final int? notificationLevel;
  @override
  @JsonKey(name: 'notifications_reason_id')
  final int? notificationsReasonId;
  @override
  @JsonKey(name: 'can_move_posts')
  final bool? canMovePosts;
  @override
  @JsonKey(name: 'can_edit')
  final bool? canEdit;
  @override
  @JsonKey(name: 'can_delete')
  final bool? canDelete;
  @override
  @JsonKey(name: 'can_remove_allowed_users')
  final bool? canRemoveAllowedUsers;
  @override
  @JsonKey(name: 'can_invite_to')
  final bool? canInviteTo;
  @override
  @JsonKey(name: 'can_invite_via_email')
  final bool? canInviteViaEmail;
  @override
  @JsonKey(name: 'can_create_post')
  final bool? canCreatePost;
  @override
  @JsonKey(name: 'can_reply_as_new_topic')
  final bool? canReplyAsNewTopic;
  @override
  @JsonKey(name: 'can_flag_topic')
  final bool? canFlagTopic;
  @override
  @JsonKey(name: 'can_convert_topic')
  final bool? canConvertTopic;
  @override
  @JsonKey(name: 'can_review_topic')
  final bool? canReviewTopic;
  @override
  @JsonKey(name: 'can_close_topic')
  final bool? canCloseTopic;
  @override
  @JsonKey(name: 'can_archive_topic')
  final bool? canArchiveTopic;
  @override
  @JsonKey(name: 'can_split_merge_topic')
  final bool? canSplitMergeTopic;
  @override
  @JsonKey(name: 'can_edit_staff_notes')
  final bool? canEditStaffNotes;
  @override
  @JsonKey(name: 'can_toggle_topic_visibility')
  final bool? canToggleTopicVisibility;
  @override
  @JsonKey(name: 'can_pin_unpin_topic')
  final bool? canPinUnpinTopic;
  @override
  @JsonKey(name: 'can_moderate_category')
  final bool? canModerateCategory;
  @override
  @JsonKey(name: 'can_remove_self_id')
  final int? canRemoveSelfId;
  final List<DiscourseParticipant> _participants;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  @JsonKey(name: 'created_by')
  final DiscourseCreatedBy? createdBy;
  @override
  @JsonKey(name: 'last_poster')
  final DiscourseCreatedBy? lastPoster;
  final List<DiscourseUserBasic> _allowedUsers;
  @override
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers {
    if (_allowedUsers is EqualUnmodifiableListView) return _allowedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedUsers);
  }

  final List<Map<String, dynamic>> _allowedGroups;
  @override
  @JsonKey(name: 'allowed_groups')
  List<Map<String, dynamic>> get allowedGroups {
    if (_allowedGroups is EqualUnmodifiableListView) return _allowedGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedGroups);
  }

  @override
  String toString() {
    return 'DiscourseTopicDetails(notificationLevel: $notificationLevel, notificationsReasonId: $notificationsReasonId, canMovePosts: $canMovePosts, canEdit: $canEdit, canDelete: $canDelete, canRemoveAllowedUsers: $canRemoveAllowedUsers, canInviteTo: $canInviteTo, canInviteViaEmail: $canInviteViaEmail, canCreatePost: $canCreatePost, canReplyAsNewTopic: $canReplyAsNewTopic, canFlagTopic: $canFlagTopic, canConvertTopic: $canConvertTopic, canReviewTopic: $canReviewTopic, canCloseTopic: $canCloseTopic, canArchiveTopic: $canArchiveTopic, canSplitMergeTopic: $canSplitMergeTopic, canEditStaffNotes: $canEditStaffNotes, canToggleTopicVisibility: $canToggleTopicVisibility, canPinUnpinTopic: $canPinUnpinTopic, canModerateCategory: $canModerateCategory, canRemoveSelfId: $canRemoveSelfId, participants: $participants, createdBy: $createdBy, lastPoster: $lastPoster, allowedUsers: $allowedUsers, allowedGroups: $allowedGroups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseTopicDetailsImpl &&
            (identical(other.notificationLevel, notificationLevel) ||
                other.notificationLevel == notificationLevel) &&
            (identical(other.notificationsReasonId, notificationsReasonId) ||
                other.notificationsReasonId == notificationsReasonId) &&
            (identical(other.canMovePosts, canMovePosts) ||
                other.canMovePosts == canMovePosts) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.canDelete, canDelete) ||
                other.canDelete == canDelete) &&
            (identical(other.canRemoveAllowedUsers, canRemoveAllowedUsers) ||
                other.canRemoveAllowedUsers == canRemoveAllowedUsers) &&
            (identical(other.canInviteTo, canInviteTo) ||
                other.canInviteTo == canInviteTo) &&
            (identical(other.canInviteViaEmail, canInviteViaEmail) ||
                other.canInviteViaEmail == canInviteViaEmail) &&
            (identical(other.canCreatePost, canCreatePost) ||
                other.canCreatePost == canCreatePost) &&
            (identical(other.canReplyAsNewTopic, canReplyAsNewTopic) ||
                other.canReplyAsNewTopic == canReplyAsNewTopic) &&
            (identical(other.canFlagTopic, canFlagTopic) ||
                other.canFlagTopic == canFlagTopic) &&
            (identical(other.canConvertTopic, canConvertTopic) ||
                other.canConvertTopic == canConvertTopic) &&
            (identical(other.canReviewTopic, canReviewTopic) ||
                other.canReviewTopic == canReviewTopic) &&
            (identical(other.canCloseTopic, canCloseTopic) ||
                other.canCloseTopic == canCloseTopic) &&
            (identical(other.canArchiveTopic, canArchiveTopic) ||
                other.canArchiveTopic == canArchiveTopic) &&
            (identical(other.canSplitMergeTopic, canSplitMergeTopic) ||
                other.canSplitMergeTopic == canSplitMergeTopic) &&
            (identical(other.canEditStaffNotes, canEditStaffNotes) ||
                other.canEditStaffNotes == canEditStaffNotes) &&
            (identical(
                  other.canToggleTopicVisibility,
                  canToggleTopicVisibility,
                ) ||
                other.canToggleTopicVisibility == canToggleTopicVisibility) &&
            (identical(other.canPinUnpinTopic, canPinUnpinTopic) ||
                other.canPinUnpinTopic == canPinUnpinTopic) &&
            (identical(other.canModerateCategory, canModerateCategory) ||
                other.canModerateCategory == canModerateCategory) &&
            (identical(other.canRemoveSelfId, canRemoveSelfId) ||
                other.canRemoveSelfId == canRemoveSelfId) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.lastPoster, lastPoster) ||
                other.lastPoster == lastPoster) &&
            const DeepCollectionEquality().equals(
              other._allowedUsers,
              _allowedUsers,
            ) &&
            const DeepCollectionEquality().equals(
              other._allowedGroups,
              _allowedGroups,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    notificationLevel,
    notificationsReasonId,
    canMovePosts,
    canEdit,
    canDelete,
    canRemoveAllowedUsers,
    canInviteTo,
    canInviteViaEmail,
    canCreatePost,
    canReplyAsNewTopic,
    canFlagTopic,
    canConvertTopic,
    canReviewTopic,
    canCloseTopic,
    canArchiveTopic,
    canSplitMergeTopic,
    canEditStaffNotes,
    canToggleTopicVisibility,
    canPinUnpinTopic,
    canModerateCategory,
    canRemoveSelfId,
    const DeepCollectionEquality().hash(_participants),
    createdBy,
    lastPoster,
    const DeepCollectionEquality().hash(_allowedUsers),
    const DeepCollectionEquality().hash(_allowedGroups),
  ]);

  /// Create a copy of DiscourseTopicDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseTopicDetailsImplCopyWith<_$DiscourseTopicDetailsImpl>
  get copyWith =>
      __$$DiscourseTopicDetailsImplCopyWithImpl<_$DiscourseTopicDetailsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseTopicDetailsImplToJson(this);
  }
}

abstract class _DiscourseTopicDetails implements DiscourseTopicDetails {
  const factory _DiscourseTopicDetails({
    @JsonKey(name: 'notification_level') final int? notificationLevel,
    @JsonKey(name: 'notifications_reason_id') final int? notificationsReasonId,
    @JsonKey(name: 'can_move_posts') final bool? canMovePosts,
    @JsonKey(name: 'can_edit') final bool? canEdit,
    @JsonKey(name: 'can_delete') final bool? canDelete,
    @JsonKey(name: 'can_remove_allowed_users')
    final bool? canRemoveAllowedUsers,
    @JsonKey(name: 'can_invite_to') final bool? canInviteTo,
    @JsonKey(name: 'can_invite_via_email') final bool? canInviteViaEmail,
    @JsonKey(name: 'can_create_post') final bool? canCreatePost,
    @JsonKey(name: 'can_reply_as_new_topic') final bool? canReplyAsNewTopic,
    @JsonKey(name: 'can_flag_topic') final bool? canFlagTopic,
    @JsonKey(name: 'can_convert_topic') final bool? canConvertTopic,
    @JsonKey(name: 'can_review_topic') final bool? canReviewTopic,
    @JsonKey(name: 'can_close_topic') final bool? canCloseTopic,
    @JsonKey(name: 'can_archive_topic') final bool? canArchiveTopic,
    @JsonKey(name: 'can_split_merge_topic') final bool? canSplitMergeTopic,
    @JsonKey(name: 'can_edit_staff_notes') final bool? canEditStaffNotes,
    @JsonKey(name: 'can_toggle_topic_visibility')
    final bool? canToggleTopicVisibility,
    @JsonKey(name: 'can_pin_unpin_topic') final bool? canPinUnpinTopic,
    @JsonKey(name: 'can_moderate_category') final bool? canModerateCategory,
    @JsonKey(name: 'can_remove_self_id') final int? canRemoveSelfId,
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants,
    @JsonKey(name: 'created_by') final DiscourseCreatedBy? createdBy,
    @JsonKey(name: 'last_poster') final DiscourseCreatedBy? lastPoster,
    @JsonKey(name: 'allowed_users') final List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'allowed_groups')
    final List<Map<String, dynamic>> allowedGroups,
  }) = _$DiscourseTopicDetailsImpl;

  factory _DiscourseTopicDetails.fromJson(Map<String, dynamic> json) =
      _$DiscourseTopicDetailsImpl.fromJson;

  @override
  @JsonKey(name: 'notification_level')
  int? get notificationLevel;
  @override
  @JsonKey(name: 'notifications_reason_id')
  int? get notificationsReasonId;
  @override
  @JsonKey(name: 'can_move_posts')
  bool? get canMovePosts;
  @override
  @JsonKey(name: 'can_edit')
  bool? get canEdit;
  @override
  @JsonKey(name: 'can_delete')
  bool? get canDelete;
  @override
  @JsonKey(name: 'can_remove_allowed_users')
  bool? get canRemoveAllowedUsers;
  @override
  @JsonKey(name: 'can_invite_to')
  bool? get canInviteTo;
  @override
  @JsonKey(name: 'can_invite_via_email')
  bool? get canInviteViaEmail;
  @override
  @JsonKey(name: 'can_create_post')
  bool? get canCreatePost;
  @override
  @JsonKey(name: 'can_reply_as_new_topic')
  bool? get canReplyAsNewTopic;
  @override
  @JsonKey(name: 'can_flag_topic')
  bool? get canFlagTopic;
  @override
  @JsonKey(name: 'can_convert_topic')
  bool? get canConvertTopic;
  @override
  @JsonKey(name: 'can_review_topic')
  bool? get canReviewTopic;
  @override
  @JsonKey(name: 'can_close_topic')
  bool? get canCloseTopic;
  @override
  @JsonKey(name: 'can_archive_topic')
  bool? get canArchiveTopic;
  @override
  @JsonKey(name: 'can_split_merge_topic')
  bool? get canSplitMergeTopic;
  @override
  @JsonKey(name: 'can_edit_staff_notes')
  bool? get canEditStaffNotes;
  @override
  @JsonKey(name: 'can_toggle_topic_visibility')
  bool? get canToggleTopicVisibility;
  @override
  @JsonKey(name: 'can_pin_unpin_topic')
  bool? get canPinUnpinTopic;
  @override
  @JsonKey(name: 'can_moderate_category')
  bool? get canModerateCategory;
  @override
  @JsonKey(name: 'can_remove_self_id')
  int? get canRemoveSelfId;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants;
  @override
  @JsonKey(name: 'created_by')
  DiscourseCreatedBy? get createdBy;
  @override
  @JsonKey(name: 'last_poster')
  DiscourseCreatedBy? get lastPoster;
  @override
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers;
  @override
  @JsonKey(name: 'allowed_groups')
  List<Map<String, dynamic>> get allowedGroups;

  /// Create a copy of DiscourseTopicDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseTopicDetailsImplCopyWith<_$DiscourseTopicDetailsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscourseCreatedBy _$DiscourseCreatedByFromJson(Map<String, dynamic> json) {
  return _DiscourseCreatedBy.fromJson(json);
}

/// @nodoc
mixin _$DiscourseCreatedBy {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;

  /// Serializes this DiscourseCreatedBy to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscourseCreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscourseCreatedByCopyWith<DiscourseCreatedBy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscourseCreatedByCopyWith<$Res> {
  factory $DiscourseCreatedByCopyWith(
    DiscourseCreatedBy value,
    $Res Function(DiscourseCreatedBy) then,
  ) = _$DiscourseCreatedByCopyWithImpl<$Res, DiscourseCreatedBy>;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
  });
}

/// @nodoc
class _$DiscourseCreatedByCopyWithImpl<$Res, $Val extends DiscourseCreatedBy>
    implements $DiscourseCreatedByCopyWith<$Res> {
  _$DiscourseCreatedByCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscourseCreatedBy
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
abstract class _$$DiscourseCreatedByImplCopyWith<$Res>
    implements $DiscourseCreatedByCopyWith<$Res> {
  factory _$$DiscourseCreatedByImplCopyWith(
    _$DiscourseCreatedByImpl value,
    $Res Function(_$DiscourseCreatedByImpl) then,
  ) = __$$DiscourseCreatedByImplCopyWithImpl<$Res>;
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
class __$$DiscourseCreatedByImplCopyWithImpl<$Res>
    extends _$DiscourseCreatedByCopyWithImpl<$Res, _$DiscourseCreatedByImpl>
    implements _$$DiscourseCreatedByImplCopyWith<$Res> {
  __$$DiscourseCreatedByImplCopyWithImpl(
    _$DiscourseCreatedByImpl _value,
    $Res Function(_$DiscourseCreatedByImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscourseCreatedBy
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
      _$DiscourseCreatedByImpl(
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
class _$DiscourseCreatedByImpl implements _DiscourseCreatedBy {
  const _$DiscourseCreatedByImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
  });

  factory _$DiscourseCreatedByImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscourseCreatedByImplFromJson(json);

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
    return 'DiscourseCreatedBy(id: $id, username: $username, name: $name, avatarTemplate: $avatarTemplate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscourseCreatedByImpl &&
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

  /// Create a copy of DiscourseCreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscourseCreatedByImplCopyWith<_$DiscourseCreatedByImpl> get copyWith =>
      __$$DiscourseCreatedByImplCopyWithImpl<_$DiscourseCreatedByImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscourseCreatedByImplToJson(this);
  }
}

abstract class _DiscourseCreatedBy implements DiscourseCreatedBy {
  const factory _DiscourseCreatedBy({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
  }) = _$DiscourseCreatedByImpl;

  factory _DiscourseCreatedBy.fromJson(Map<String, dynamic> json) =
      _$DiscourseCreatedByImpl.fromJson;

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

  /// Create a copy of DiscourseCreatedBy
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscourseCreatedByImplCopyWith<_$DiscourseCreatedByImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
