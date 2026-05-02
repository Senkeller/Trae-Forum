// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discourse_private_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DiscoursePrivateMessage _$DiscoursePrivateMessageFromJson(
  Map<String, dynamic> json,
) {
  return _DiscoursePrivateMessage.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePrivateMessage {
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
  @JsonKey(name: 'bumped_at')
  String? get bumpedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'unseen')
  bool get unseen => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_posts')
  int get unreadPosts => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_read_post_number')
  int get lastReadPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'excerpt')
  String? get excerpt => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed')
  bool get closed => throw _privateConstructorUsedError;
  @JsonKey(name: 'archived')
  bool get archived => throw _privateConstructorUsedError;

  /// Serializes this DiscoursePrivateMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePrivateMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePrivateMessageCopyWith<DiscoursePrivateMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePrivateMessageCopyWith<$Res> {
  factory $DiscoursePrivateMessageCopyWith(
    DiscoursePrivateMessage value,
    $Res Function(DiscoursePrivateMessage) then,
  ) = _$DiscoursePrivateMessageCopyWithImpl<$Res, DiscoursePrivateMessage>;
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
    @JsonKey(name: 'bumped_at') String? bumpedAt,
    @JsonKey(name: 'unseen') bool unseen,
    @JsonKey(name: 'unread_posts') int unreadPosts,
    @JsonKey(name: 'last_read_post_number') int lastReadPostNumber,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'excerpt') String? excerpt,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
  });
}

/// @nodoc
class _$DiscoursePrivateMessageCopyWithImpl<
  $Res,
  $Val extends DiscoursePrivateMessage
>
    implements $DiscoursePrivateMessageCopyWith<$Res> {
  _$DiscoursePrivateMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePrivateMessage
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
    Object? bumpedAt = freezed,
    Object? unseen = null,
    Object? unreadPosts = null,
    Object? lastReadPostNumber = null,
    Object? participants = null,
    Object? allowedUsers = null,
    Object? imageUrl = freezed,
    Object? excerpt = freezed,
    Object? closed = null,
    Object? archived = null,
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
            bumpedAt: freezed == bumpedAt
                ? _value.bumpedAt
                : bumpedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            unseen: null == unseen
                ? _value.unseen
                : unseen // ignore: cast_nullable_to_non_nullable
                      as bool,
            unreadPosts: null == unreadPosts
                ? _value.unreadPosts
                : unreadPosts // ignore: cast_nullable_to_non_nullable
                      as int,
            lastReadPostNumber: null == lastReadPostNumber
                ? _value.lastReadPostNumber
                : lastReadPostNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseParticipant>,
            allowedUsers: null == allowedUsers
                ? _value.allowedUsers
                : allowedUsers // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBasic>,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            excerpt: freezed == excerpt
                ? _value.excerpt
                : excerpt // ignore: cast_nullable_to_non_nullable
                      as String?,
            closed: null == closed
                ? _value.closed
                : closed // ignore: cast_nullable_to_non_nullable
                      as bool,
            archived: null == archived
                ? _value.archived
                : archived // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoursePrivateMessageImplCopyWith<$Res>
    implements $DiscoursePrivateMessageCopyWith<$Res> {
  factory _$$DiscoursePrivateMessageImplCopyWith(
    _$DiscoursePrivateMessageImpl value,
    $Res Function(_$DiscoursePrivateMessageImpl) then,
  ) = __$$DiscoursePrivateMessageImplCopyWithImpl<$Res>;
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
    @JsonKey(name: 'bumped_at') String? bumpedAt,
    @JsonKey(name: 'unseen') bool unseen,
    @JsonKey(name: 'unread_posts') int unreadPosts,
    @JsonKey(name: 'last_read_post_number') int lastReadPostNumber,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'excerpt') String? excerpt,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
  });
}

/// @nodoc
class __$$DiscoursePrivateMessageImplCopyWithImpl<$Res>
    extends
        _$DiscoursePrivateMessageCopyWithImpl<
          $Res,
          _$DiscoursePrivateMessageImpl
        >
    implements _$$DiscoursePrivateMessageImplCopyWith<$Res> {
  __$$DiscoursePrivateMessageImplCopyWithImpl(
    _$DiscoursePrivateMessageImpl _value,
    $Res Function(_$DiscoursePrivateMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePrivateMessage
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
    Object? bumpedAt = freezed,
    Object? unseen = null,
    Object? unreadPosts = null,
    Object? lastReadPostNumber = null,
    Object? participants = null,
    Object? allowedUsers = null,
    Object? imageUrl = freezed,
    Object? excerpt = freezed,
    Object? closed = null,
    Object? archived = null,
  }) {
    return _then(
      _$DiscoursePrivateMessageImpl(
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
        bumpedAt: freezed == bumpedAt
            ? _value.bumpedAt
            : bumpedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        unseen: null == unseen
            ? _value.unseen
            : unseen // ignore: cast_nullable_to_non_nullable
                  as bool,
        unreadPosts: null == unreadPosts
            ? _value.unreadPosts
            : unreadPosts // ignore: cast_nullable_to_non_nullable
                  as int,
        lastReadPostNumber: null == lastReadPostNumber
            ? _value.lastReadPostNumber
            : lastReadPostNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseParticipant>,
        allowedUsers: null == allowedUsers
            ? _value._allowedUsers
            : allowedUsers // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBasic>,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        excerpt: freezed == excerpt
            ? _value.excerpt
            : excerpt // ignore: cast_nullable_to_non_nullable
                  as String?,
        closed: null == closed
            ? _value.closed
            : closed // ignore: cast_nullable_to_non_nullable
                  as bool,
        archived: null == archived
            ? _value.archived
            : archived // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePrivateMessageImpl implements _DiscoursePrivateMessage {
  const _$DiscoursePrivateMessageImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'fancy_title') this.fancyTitle,
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'posts_count') this.postsCount = 0,
    @JsonKey(name: 'reply_count') this.replyCount = 0,
    @JsonKey(name: 'highest_post_number') this.highestPostNumber = 0,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'last_posted_at') this.lastPostedAt,
    @JsonKey(name: 'bumped_at') this.bumpedAt,
    @JsonKey(name: 'unseen') this.unseen = false,
    @JsonKey(name: 'unread_posts') this.unreadPosts = 0,
    @JsonKey(name: 'last_read_post_number') this.lastReadPostNumber = 0,
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants = const [],
    @JsonKey(name: 'allowed_users')
    final List<DiscourseUserBasic> allowedUsers = const [],
    @JsonKey(name: 'image_url') this.imageUrl,
    @JsonKey(name: 'excerpt') this.excerpt,
    @JsonKey(name: 'closed') this.closed = false,
    @JsonKey(name: 'archived') this.archived = false,
  }) : _participants = participants,
       _allowedUsers = allowedUsers;

  factory _$DiscoursePrivateMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoursePrivateMessageImplFromJson(json);

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
  @JsonKey(name: 'bumped_at')
  final String? bumpedAt;
  @override
  @JsonKey(name: 'unseen')
  final bool unseen;
  @override
  @JsonKey(name: 'unread_posts')
  final int unreadPosts;
  @override
  @JsonKey(name: 'last_read_post_number')
  final int lastReadPostNumber;
  final List<DiscourseParticipant> _participants;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  final List<DiscourseUserBasic> _allowedUsers;
  @override
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers {
    if (_allowedUsers is EqualUnmodifiableListView) return _allowedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedUsers);
  }

  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @override
  @JsonKey(name: 'excerpt')
  final String? excerpt;
  @override
  @JsonKey(name: 'closed')
  final bool closed;
  @override
  @JsonKey(name: 'archived')
  final bool archived;

  @override
  String toString() {
    return 'DiscoursePrivateMessage(id: $id, title: $title, fancyTitle: $fancyTitle, slug: $slug, postsCount: $postsCount, replyCount: $replyCount, highestPostNumber: $highestPostNumber, createdAt: $createdAt, lastPostedAt: $lastPostedAt, bumpedAt: $bumpedAt, unseen: $unseen, unreadPosts: $unreadPosts, lastReadPostNumber: $lastReadPostNumber, participants: $participants, allowedUsers: $allowedUsers, imageUrl: $imageUrl, excerpt: $excerpt, closed: $closed, archived: $archived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePrivateMessageImpl &&
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
            (identical(other.bumpedAt, bumpedAt) ||
                other.bumpedAt == bumpedAt) &&
            (identical(other.unseen, unseen) || other.unseen == unseen) &&
            (identical(other.unreadPosts, unreadPosts) ||
                other.unreadPosts == unreadPosts) &&
            (identical(other.lastReadPostNumber, lastReadPostNumber) ||
                other.lastReadPostNumber == lastReadPostNumber) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            const DeepCollectionEquality().equals(
              other._allowedUsers,
              _allowedUsers,
            ) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt) &&
            (identical(other.closed, closed) || other.closed == closed) &&
            (identical(other.archived, archived) ||
                other.archived == archived));
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
    bumpedAt,
    unseen,
    unreadPosts,
    lastReadPostNumber,
    const DeepCollectionEquality().hash(_participants),
    const DeepCollectionEquality().hash(_allowedUsers),
    imageUrl,
    excerpt,
    closed,
    archived,
  ]);

  /// Create a copy of DiscoursePrivateMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePrivateMessageImplCopyWith<_$DiscoursePrivateMessageImpl>
  get copyWith =>
      __$$DiscoursePrivateMessageImplCopyWithImpl<
        _$DiscoursePrivateMessageImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePrivateMessageImplToJson(this);
  }
}

abstract class _DiscoursePrivateMessage implements DiscoursePrivateMessage {
  const factory _DiscoursePrivateMessage({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'fancy_title') final String? fancyTitle,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'posts_count') final int postsCount,
    @JsonKey(name: 'reply_count') final int replyCount,
    @JsonKey(name: 'highest_post_number') final int highestPostNumber,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'last_posted_at') final String? lastPostedAt,
    @JsonKey(name: 'bumped_at') final String? bumpedAt,
    @JsonKey(name: 'unseen') final bool unseen,
    @JsonKey(name: 'unread_posts') final int unreadPosts,
    @JsonKey(name: 'last_read_post_number') final int lastReadPostNumber,
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') final List<DiscourseUserBasic> allowedUsers,
    @JsonKey(name: 'image_url') final String? imageUrl,
    @JsonKey(name: 'excerpt') final String? excerpt,
    @JsonKey(name: 'closed') final bool closed,
    @JsonKey(name: 'archived') final bool archived,
  }) = _$DiscoursePrivateMessageImpl;

  factory _DiscoursePrivateMessage.fromJson(Map<String, dynamic> json) =
      _$DiscoursePrivateMessageImpl.fromJson;

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
  @JsonKey(name: 'bumped_at')
  String? get bumpedAt;
  @override
  @JsonKey(name: 'unseen')
  bool get unseen;
  @override
  @JsonKey(name: 'unread_posts')
  int get unreadPosts;
  @override
  @JsonKey(name: 'last_read_post_number')
  int get lastReadPostNumber;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants;
  @override
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(name: 'excerpt')
  String? get excerpt;
  @override
  @JsonKey(name: 'closed')
  bool get closed;
  @override
  @JsonKey(name: 'archived')
  bool get archived;

  /// Create a copy of DiscoursePrivateMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePrivateMessageImplCopyWith<_$DiscoursePrivateMessageImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscoursePrivateMessageListResponse
_$DiscoursePrivateMessageListResponseFromJson(Map<String, dynamic> json) {
  return _DiscoursePrivateMessageListResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePrivateMessageListResponse {
  @JsonKey(name: 'users')
  List<DiscourseUserBasic> get users => throw _privateConstructorUsedError;
  @JsonKey(name: 'primary_groups')
  List<DiscoursePrimaryGroup> get primaryGroups =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'flair_groups')
  List<DiscourseFlairGroup> get flairGroups =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_list')
  DiscoursePrivateMessageList? get topicList =>
      throw _privateConstructorUsedError;

  /// Serializes this DiscoursePrivateMessageListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePrivateMessageListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePrivateMessageListResponseCopyWith<
    DiscoursePrivateMessageListResponse
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePrivateMessageListResponseCopyWith<$Res> {
  factory $DiscoursePrivateMessageListResponseCopyWith(
    DiscoursePrivateMessageListResponse value,
    $Res Function(DiscoursePrivateMessageListResponse) then,
  ) =
      _$DiscoursePrivateMessageListResponseCopyWithImpl<
        $Res,
        DiscoursePrivateMessageListResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'users') List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups') List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') DiscoursePrivateMessageList? topicList,
  });

  $DiscoursePrivateMessageListCopyWith<$Res>? get topicList;
}

/// @nodoc
class _$DiscoursePrivateMessageListResponseCopyWithImpl<
  $Res,
  $Val extends DiscoursePrivateMessageListResponse
>
    implements $DiscoursePrivateMessageListResponseCopyWith<$Res> {
  _$DiscoursePrivateMessageListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePrivateMessageListResponse
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
                      as DiscoursePrivateMessageList?,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscoursePrivateMessageListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscoursePrivateMessageListCopyWith<$Res>? get topicList {
    if (_value.topicList == null) {
      return null;
    }

    return $DiscoursePrivateMessageListCopyWith<$Res>(_value.topicList!, (
      value,
    ) {
      return _then(_value.copyWith(topicList: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DiscoursePrivateMessageListResponseImplCopyWith<$Res>
    implements $DiscoursePrivateMessageListResponseCopyWith<$Res> {
  factory _$$DiscoursePrivateMessageListResponseImplCopyWith(
    _$DiscoursePrivateMessageListResponseImpl value,
    $Res Function(_$DiscoursePrivateMessageListResponseImpl) then,
  ) = __$$DiscoursePrivateMessageListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'users') List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups') List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') DiscoursePrivateMessageList? topicList,
  });

  @override
  $DiscoursePrivateMessageListCopyWith<$Res>? get topicList;
}

/// @nodoc
class __$$DiscoursePrivateMessageListResponseImplCopyWithImpl<$Res>
    extends
        _$DiscoursePrivateMessageListResponseCopyWithImpl<
          $Res,
          _$DiscoursePrivateMessageListResponseImpl
        >
    implements _$$DiscoursePrivateMessageListResponseImplCopyWith<$Res> {
  __$$DiscoursePrivateMessageListResponseImplCopyWithImpl(
    _$DiscoursePrivateMessageListResponseImpl _value,
    $Res Function(_$DiscoursePrivateMessageListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePrivateMessageListResponse
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
      _$DiscoursePrivateMessageListResponseImpl(
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
                  as DiscoursePrivateMessageList?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePrivateMessageListResponseImpl
    implements _DiscoursePrivateMessageListResponse {
  const _$DiscoursePrivateMessageListResponseImpl({
    @JsonKey(name: 'users') final List<DiscourseUserBasic> users = const [],
    @JsonKey(name: 'primary_groups')
    final List<DiscoursePrimaryGroup> primaryGroups = const [],
    @JsonKey(name: 'flair_groups')
    final List<DiscourseFlairGroup> flairGroups = const [],
    @JsonKey(name: 'topic_list') this.topicList,
  }) : _users = users,
       _primaryGroups = primaryGroups,
       _flairGroups = flairGroups;

  factory _$DiscoursePrivateMessageListResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscoursePrivateMessageListResponseImplFromJson(json);

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
  final DiscoursePrivateMessageList? topicList;

  @override
  String toString() {
    return 'DiscoursePrivateMessageListResponse(users: $users, primaryGroups: $primaryGroups, flairGroups: $flairGroups, topicList: $topicList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePrivateMessageListResponseImpl &&
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

  /// Create a copy of DiscoursePrivateMessageListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePrivateMessageListResponseImplCopyWith<
    _$DiscoursePrivateMessageListResponseImpl
  >
  get copyWith =>
      __$$DiscoursePrivateMessageListResponseImplCopyWithImpl<
        _$DiscoursePrivateMessageListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePrivateMessageListResponseImplToJson(this);
  }
}

abstract class _DiscoursePrivateMessageListResponse
    implements DiscoursePrivateMessageListResponse {
  const factory _DiscoursePrivateMessageListResponse({
    @JsonKey(name: 'users') final List<DiscourseUserBasic> users,
    @JsonKey(name: 'primary_groups')
    final List<DiscoursePrimaryGroup> primaryGroups,
    @JsonKey(name: 'flair_groups') final List<DiscourseFlairGroup> flairGroups,
    @JsonKey(name: 'topic_list') final DiscoursePrivateMessageList? topicList,
  }) = _$DiscoursePrivateMessageListResponseImpl;

  factory _DiscoursePrivateMessageListResponse.fromJson(
    Map<String, dynamic> json,
  ) = _$DiscoursePrivateMessageListResponseImpl.fromJson;

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
  DiscoursePrivateMessageList? get topicList;

  /// Create a copy of DiscoursePrivateMessageListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePrivateMessageListResponseImplCopyWith<
    _$DiscoursePrivateMessageListResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DiscoursePrivateMessageList _$DiscoursePrivateMessageListFromJson(
  Map<String, dynamic> json,
) {
  return _DiscoursePrivateMessageList.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePrivateMessageList {
  @JsonKey(name: 'can_create_topic')
  bool get canCreateTopic => throw _privateConstructorUsedError;
  @JsonKey(name: 'more_topics_url')
  String? get moreTopicsUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'per_page')
  int get perPage => throw _privateConstructorUsedError;
  @JsonKey(name: 'topics')
  List<DiscoursePrivateMessage> get topics =>
      throw _privateConstructorUsedError;

  /// Serializes this DiscoursePrivateMessageList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePrivateMessageList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePrivateMessageListCopyWith<DiscoursePrivateMessageList>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePrivateMessageListCopyWith<$Res> {
  factory $DiscoursePrivateMessageListCopyWith(
    DiscoursePrivateMessageList value,
    $Res Function(DiscoursePrivateMessageList) then,
  ) =
      _$DiscoursePrivateMessageListCopyWithImpl<
        $Res,
        DiscoursePrivateMessageList
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'can_create_topic') bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') String? moreTopicsUrl,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'topics') List<DiscoursePrivateMessage> topics,
  });
}

/// @nodoc
class _$DiscoursePrivateMessageListCopyWithImpl<
  $Res,
  $Val extends DiscoursePrivateMessageList
>
    implements $DiscoursePrivateMessageListCopyWith<$Res> {
  _$DiscoursePrivateMessageListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePrivateMessageList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canCreateTopic = null,
    Object? moreTopicsUrl = freezed,
    Object? perPage = null,
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
            perPage: null == perPage
                ? _value.perPage
                : perPage // ignore: cast_nullable_to_non_nullable
                      as int,
            topics: null == topics
                ? _value.topics
                : topics // ignore: cast_nullable_to_non_nullable
                      as List<DiscoursePrivateMessage>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoursePrivateMessageListImplCopyWith<$Res>
    implements $DiscoursePrivateMessageListCopyWith<$Res> {
  factory _$$DiscoursePrivateMessageListImplCopyWith(
    _$DiscoursePrivateMessageListImpl value,
    $Res Function(_$DiscoursePrivateMessageListImpl) then,
  ) = __$$DiscoursePrivateMessageListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'can_create_topic') bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') String? moreTopicsUrl,
    @JsonKey(name: 'per_page') int perPage,
    @JsonKey(name: 'topics') List<DiscoursePrivateMessage> topics,
  });
}

/// @nodoc
class __$$DiscoursePrivateMessageListImplCopyWithImpl<$Res>
    extends
        _$DiscoursePrivateMessageListCopyWithImpl<
          $Res,
          _$DiscoursePrivateMessageListImpl
        >
    implements _$$DiscoursePrivateMessageListImplCopyWith<$Res> {
  __$$DiscoursePrivateMessageListImplCopyWithImpl(
    _$DiscoursePrivateMessageListImpl _value,
    $Res Function(_$DiscoursePrivateMessageListImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePrivateMessageList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? canCreateTopic = null,
    Object? moreTopicsUrl = freezed,
    Object? perPage = null,
    Object? topics = null,
  }) {
    return _then(
      _$DiscoursePrivateMessageListImpl(
        canCreateTopic: null == canCreateTopic
            ? _value.canCreateTopic
            : canCreateTopic // ignore: cast_nullable_to_non_nullable
                  as bool,
        moreTopicsUrl: freezed == moreTopicsUrl
            ? _value.moreTopicsUrl
            : moreTopicsUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        perPage: null == perPage
            ? _value.perPage
            : perPage // ignore: cast_nullable_to_non_nullable
                  as int,
        topics: null == topics
            ? _value._topics
            : topics // ignore: cast_nullable_to_non_nullable
                  as List<DiscoursePrivateMessage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePrivateMessageListImpl
    implements _DiscoursePrivateMessageList {
  const _$DiscoursePrivateMessageListImpl({
    @JsonKey(name: 'can_create_topic') this.canCreateTopic = false,
    @JsonKey(name: 'more_topics_url') this.moreTopicsUrl,
    @JsonKey(name: 'per_page') this.perPage = 30,
    @JsonKey(name: 'topics')
    final List<DiscoursePrivateMessage> topics = const [],
  }) : _topics = topics;

  factory _$DiscoursePrivateMessageListImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscoursePrivateMessageListImplFromJson(json);

  @override
  @JsonKey(name: 'can_create_topic')
  final bool canCreateTopic;
  @override
  @JsonKey(name: 'more_topics_url')
  final String? moreTopicsUrl;
  @override
  @JsonKey(name: 'per_page')
  final int perPage;
  final List<DiscoursePrivateMessage> _topics;
  @override
  @JsonKey(name: 'topics')
  List<DiscoursePrivateMessage> get topics {
    if (_topics is EqualUnmodifiableListView) return _topics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topics);
  }

  @override
  String toString() {
    return 'DiscoursePrivateMessageList(canCreateTopic: $canCreateTopic, moreTopicsUrl: $moreTopicsUrl, perPage: $perPage, topics: $topics)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePrivateMessageListImpl &&
            (identical(other.canCreateTopic, canCreateTopic) ||
                other.canCreateTopic == canCreateTopic) &&
            (identical(other.moreTopicsUrl, moreTopicsUrl) ||
                other.moreTopicsUrl == moreTopicsUrl) &&
            (identical(other.perPage, perPage) || other.perPage == perPage) &&
            const DeepCollectionEquality().equals(other._topics, _topics));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    canCreateTopic,
    moreTopicsUrl,
    perPage,
    const DeepCollectionEquality().hash(_topics),
  );

  /// Create a copy of DiscoursePrivateMessageList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePrivateMessageListImplCopyWith<_$DiscoursePrivateMessageListImpl>
  get copyWith =>
      __$$DiscoursePrivateMessageListImplCopyWithImpl<
        _$DiscoursePrivateMessageListImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePrivateMessageListImplToJson(this);
  }
}

abstract class _DiscoursePrivateMessageList
    implements DiscoursePrivateMessageList {
  const factory _DiscoursePrivateMessageList({
    @JsonKey(name: 'can_create_topic') final bool canCreateTopic,
    @JsonKey(name: 'more_topics_url') final String? moreTopicsUrl,
    @JsonKey(name: 'per_page') final int perPage,
    @JsonKey(name: 'topics') final List<DiscoursePrivateMessage> topics,
  }) = _$DiscoursePrivateMessageListImpl;

  factory _DiscoursePrivateMessageList.fromJson(Map<String, dynamic> json) =
      _$DiscoursePrivateMessageListImpl.fromJson;

  @override
  @JsonKey(name: 'can_create_topic')
  bool get canCreateTopic;
  @override
  @JsonKey(name: 'more_topics_url')
  String? get moreTopicsUrl;
  @override
  @JsonKey(name: 'per_page')
  int get perPage;
  @override
  @JsonKey(name: 'topics')
  List<DiscoursePrivateMessage> get topics;

  /// Create a copy of DiscoursePrivateMessageList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePrivateMessageListImplCopyWith<_$DiscoursePrivateMessageListImpl>
  get copyWith => throw _privateConstructorUsedError;
}

DiscoursePrivateMessageDetailResponse
_$DiscoursePrivateMessageDetailResponseFromJson(Map<String, dynamic> json) {
  return _DiscoursePrivateMessageDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePrivateMessageDetailResponse {
  @JsonKey(name: 'post_stream')
  DiscoursePostStream? get postStream => throw _privateConstructorUsedError;
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
  @JsonKey(name: 'details')
  DiscourseTopicDetails? get details => throw _privateConstructorUsedError;
  @JsonKey(name: 'highest_post_number')
  int? get highestPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_read_post_number')
  int? get lastReadPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_posts')
  int? get unreadPosts => throw _privateConstructorUsedError;
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'chunk_size')
  int? get chunkSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarked')
  bool? get bookmarked => throw _privateConstructorUsedError;
  @JsonKey(name: 'tags')
  List<String> get tags => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers =>
      throw _privateConstructorUsedError;

  /// Serializes this DiscoursePrivateMessageDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePrivateMessageDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePrivateMessageDetailResponseCopyWith<
    DiscoursePrivateMessageDetailResponse
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePrivateMessageDetailResponseCopyWith<$Res> {
  factory $DiscoursePrivateMessageDetailResponseCopyWith(
    DiscoursePrivateMessageDetailResponse value,
    $Res Function(DiscoursePrivateMessageDetailResponse) then,
  ) =
      _$DiscoursePrivateMessageDetailResponseCopyWithImpl<
        $Res,
        DiscoursePrivateMessageDetailResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
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
    @JsonKey(name: 'details') DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int? lastReadPostNumber,
    @JsonKey(name: 'unread_posts') int? unreadPosts,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') int? chunkSize,
    @JsonKey(name: 'bookmarked') bool? bookmarked,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') List<DiscourseUserBasic> allowedUsers,
  });

  $DiscoursePostStreamCopyWith<$Res>? get postStream;
  $DiscourseTopicDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class _$DiscoursePrivateMessageDetailResponseCopyWithImpl<
  $Res,
  $Val extends DiscoursePrivateMessageDetailResponse
>
    implements $DiscoursePrivateMessageDetailResponseCopyWith<$Res> {
  _$DiscoursePrivateMessageDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePrivateMessageDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postStream = freezed,
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
    Object? details = freezed,
    Object? highestPostNumber = freezed,
    Object? lastReadPostNumber = freezed,
    Object? unreadPosts = freezed,
    Object? actionsSummary = null,
    Object? chunkSize = freezed,
    Object? bookmarked = freezed,
    Object? tags = null,
    Object? participants = null,
    Object? allowedUsers = null,
  }) {
    return _then(
      _value.copyWith(
            postStream: freezed == postStream
                ? _value.postStream
                : postStream // ignore: cast_nullable_to_non_nullable
                      as DiscoursePostStream?,
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
            unreadPosts: freezed == unreadPosts
                ? _value.unreadPosts
                : unreadPosts // ignore: cast_nullable_to_non_nullable
                      as int?,
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
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseParticipant>,
            allowedUsers: null == allowedUsers
                ? _value.allowedUsers
                : allowedUsers // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBasic>,
          )
          as $Val,
    );
  }

  /// Create a copy of DiscoursePrivateMessageDetailResponse
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

  /// Create a copy of DiscoursePrivateMessageDetailResponse
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
abstract class _$$DiscoursePrivateMessageDetailResponseImplCopyWith<$Res>
    implements $DiscoursePrivateMessageDetailResponseCopyWith<$Res> {
  factory _$$DiscoursePrivateMessageDetailResponseImplCopyWith(
    _$DiscoursePrivateMessageDetailResponseImpl value,
    $Res Function(_$DiscoursePrivateMessageDetailResponseImpl) then,
  ) = __$$DiscoursePrivateMessageDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
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
    @JsonKey(name: 'details') DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int? lastReadPostNumber,
    @JsonKey(name: 'unread_posts') int? unreadPosts,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') int? chunkSize,
    @JsonKey(name: 'bookmarked') bool? bookmarked,
    @JsonKey(name: 'tags') List<String> tags,
    @JsonKey(name: 'participants') List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') List<DiscourseUserBasic> allowedUsers,
  });

  @override
  $DiscoursePostStreamCopyWith<$Res>? get postStream;
  @override
  $DiscourseTopicDetailsCopyWith<$Res>? get details;
}

/// @nodoc
class __$$DiscoursePrivateMessageDetailResponseImplCopyWithImpl<$Res>
    extends
        _$DiscoursePrivateMessageDetailResponseCopyWithImpl<
          $Res,
          _$DiscoursePrivateMessageDetailResponseImpl
        >
    implements _$$DiscoursePrivateMessageDetailResponseImplCopyWith<$Res> {
  __$$DiscoursePrivateMessageDetailResponseImplCopyWithImpl(
    _$DiscoursePrivateMessageDetailResponseImpl _value,
    $Res Function(_$DiscoursePrivateMessageDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePrivateMessageDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postStream = freezed,
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
    Object? details = freezed,
    Object? highestPostNumber = freezed,
    Object? lastReadPostNumber = freezed,
    Object? unreadPosts = freezed,
    Object? actionsSummary = null,
    Object? chunkSize = freezed,
    Object? bookmarked = freezed,
    Object? tags = null,
    Object? participants = null,
    Object? allowedUsers = null,
  }) {
    return _then(
      _$DiscoursePrivateMessageDetailResponseImpl(
        postStream: freezed == postStream
            ? _value.postStream
            : postStream // ignore: cast_nullable_to_non_nullable
                  as DiscoursePostStream?,
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
        unreadPosts: freezed == unreadPosts
            ? _value.unreadPosts
            : unreadPosts // ignore: cast_nullable_to_non_nullable
                  as int?,
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
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseParticipant>,
        allowedUsers: null == allowedUsers
            ? _value._allowedUsers
            : allowedUsers // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBasic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePrivateMessageDetailResponseImpl
    implements _DiscoursePrivateMessageDetailResponse {
  const _$DiscoursePrivateMessageDetailResponseImpl({
    @JsonKey(name: 'post_stream') this.postStream,
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
    @JsonKey(name: 'details') this.details,
    @JsonKey(name: 'highest_post_number') this.highestPostNumber,
    @JsonKey(name: 'last_read_post_number') this.lastReadPostNumber,
    @JsonKey(name: 'unread_posts') this.unreadPosts,
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary = const [],
    @JsonKey(name: 'chunk_size') this.chunkSize,
    @JsonKey(name: 'bookmarked') this.bookmarked,
    @JsonKey(name: 'tags') final List<String> tags = const [],
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants = const [],
    @JsonKey(name: 'allowed_users')
    final List<DiscourseUserBasic> allowedUsers = const [],
  }) : _actionsSummary = actionsSummary,
       _tags = tags,
       _participants = participants,
       _allowedUsers = allowedUsers;

  factory _$DiscoursePrivateMessageDetailResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscoursePrivateMessageDetailResponseImplFromJson(json);

  @override
  @JsonKey(name: 'post_stream')
  final DiscoursePostStream? postStream;
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
  @JsonKey(name: 'details')
  final DiscourseTopicDetails? details;
  @override
  @JsonKey(name: 'highest_post_number')
  final int? highestPostNumber;
  @override
  @JsonKey(name: 'last_read_post_number')
  final int? lastReadPostNumber;
  @override
  @JsonKey(name: 'unread_posts')
  final int? unreadPosts;
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
  final List<String> _tags;
  @override
  @JsonKey(name: 'tags')
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final List<DiscourseParticipant> _participants;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  final List<DiscourseUserBasic> _allowedUsers;
  @override
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers {
    if (_allowedUsers is EqualUnmodifiableListView) return _allowedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allowedUsers);
  }

  @override
  String toString() {
    return 'DiscoursePrivateMessageDetailResponse(postStream: $postStream, id: $id, title: $title, fancyTitle: $fancyTitle, postsCount: $postsCount, createdAt: $createdAt, views: $views, replyCount: $replyCount, likeCount: $likeCount, lastPostedAt: $lastPostedAt, visible: $visible, closed: $closed, archived: $archived, hasSummary: $hasSummary, archetype: $archetype, slug: $slug, categoryId: $categoryId, wordCount: $wordCount, userId: $userId, pinnedGlobally: $pinnedGlobally, pinned: $pinned, details: $details, highestPostNumber: $highestPostNumber, lastReadPostNumber: $lastReadPostNumber, unreadPosts: $unreadPosts, actionsSummary: $actionsSummary, chunkSize: $chunkSize, bookmarked: $bookmarked, tags: $tags, participants: $participants, allowedUsers: $allowedUsers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePrivateMessageDetailResponseImpl &&
            (identical(other.postStream, postStream) ||
                other.postStream == postStream) &&
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
            (identical(other.details, details) || other.details == details) &&
            (identical(other.highestPostNumber, highestPostNumber) ||
                other.highestPostNumber == highestPostNumber) &&
            (identical(other.lastReadPostNumber, lastReadPostNumber) ||
                other.lastReadPostNumber == lastReadPostNumber) &&
            (identical(other.unreadPosts, unreadPosts) ||
                other.unreadPosts == unreadPosts) &&
            const DeepCollectionEquality().equals(
              other._actionsSummary,
              _actionsSummary,
            ) &&
            (identical(other.chunkSize, chunkSize) ||
                other.chunkSize == chunkSize) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            const DeepCollectionEquality().equals(
              other._allowedUsers,
              _allowedUsers,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    postStream,
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
    details,
    highestPostNumber,
    lastReadPostNumber,
    unreadPosts,
    const DeepCollectionEquality().hash(_actionsSummary),
    chunkSize,
    bookmarked,
    const DeepCollectionEquality().hash(_tags),
    const DeepCollectionEquality().hash(_participants),
    const DeepCollectionEquality().hash(_allowedUsers),
  ]);

  /// Create a copy of DiscoursePrivateMessageDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePrivateMessageDetailResponseImplCopyWith<
    _$DiscoursePrivateMessageDetailResponseImpl
  >
  get copyWith =>
      __$$DiscoursePrivateMessageDetailResponseImplCopyWithImpl<
        _$DiscoursePrivateMessageDetailResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePrivateMessageDetailResponseImplToJson(this);
  }
}

abstract class _DiscoursePrivateMessageDetailResponse
    implements DiscoursePrivateMessageDetailResponse {
  const factory _DiscoursePrivateMessageDetailResponse({
    @JsonKey(name: 'post_stream') final DiscoursePostStream? postStream,
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
    @JsonKey(name: 'details') final DiscourseTopicDetails? details,
    @JsonKey(name: 'highest_post_number') final int? highestPostNumber,
    @JsonKey(name: 'last_read_post_number') final int? lastReadPostNumber,
    @JsonKey(name: 'unread_posts') final int? unreadPosts,
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'chunk_size') final int? chunkSize,
    @JsonKey(name: 'bookmarked') final bool? bookmarked,
    @JsonKey(name: 'tags') final List<String> tags,
    @JsonKey(name: 'participants')
    final List<DiscourseParticipant> participants,
    @JsonKey(name: 'allowed_users') final List<DiscourseUserBasic> allowedUsers,
  }) = _$DiscoursePrivateMessageDetailResponseImpl;

  factory _DiscoursePrivateMessageDetailResponse.fromJson(
    Map<String, dynamic> json,
  ) = _$DiscoursePrivateMessageDetailResponseImpl.fromJson;

  @override
  @JsonKey(name: 'post_stream')
  DiscoursePostStream? get postStream;
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
  @JsonKey(name: 'details')
  DiscourseTopicDetails? get details;
  @override
  @JsonKey(name: 'highest_post_number')
  int? get highestPostNumber;
  @override
  @JsonKey(name: 'last_read_post_number')
  int? get lastReadPostNumber;
  @override
  @JsonKey(name: 'unread_posts')
  int? get unreadPosts;
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
  @JsonKey(name: 'tags')
  List<String> get tags;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseParticipant> get participants;
  @override
  @JsonKey(name: 'allowed_users')
  List<DiscourseUserBasic> get allowedUsers;

  /// Create a copy of DiscoursePrivateMessageDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePrivateMessageDetailResponseImplCopyWith<
    _$DiscoursePrivateMessageDetailResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

DiscoursePrivateMessageItem _$DiscoursePrivateMessageItemFromJson(
  Map<String, dynamic> json,
) {
  return _DiscoursePrivateMessageItem.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePrivateMessageItem {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_id')
  int get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  int get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_template')
  String get avatarTemplate => throw _privateConstructorUsedError;
  @JsonKey(name: 'cooked')
  String get cooked => throw _privateConstructorUsedError;
  @JsonKey(name: 'raw')
  String? get raw => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String? get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_number')
  int get postNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to_post_number')
  int? get replyToPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'like_count')
  int get likeCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'reads')
  int get reads => throw _privateConstructorUsedError;
  @JsonKey(name: 'readers_count')
  int get readersCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'version')
  int get version => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_edit')
  bool get canEdit => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_delete')
  bool get canDelete => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_recover')
  bool get canRecover => throw _privateConstructorUsedError;
  @JsonKey(name: 'can_wiki')
  bool get canWiki => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_title')
  String? get userTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'title_is_group')
  bool get titleIsGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'reply_to_user')
  Map<String, dynamic>? get replyToUser => throw _privateConstructorUsedError;
  @JsonKey(name: 'actions_summary')
  List<Map<String, dynamic>> get actionsSummary =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'moderator')
  bool get moderator => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin')
  bool get admin => throw _privateConstructorUsedError;
  @JsonKey(name: 'staff')
  bool get staff => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_trust_level')
  int get userTrustLevel => throw _privateConstructorUsedError;
  @JsonKey(name: 'bookmarked')
  bool get bookmarked => throw _privateConstructorUsedError;

  /// Serializes this DiscoursePrivateMessageItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePrivateMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePrivateMessageItemCopyWith<DiscoursePrivateMessageItem>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePrivateMessageItemCopyWith<$Res> {
  factory $DiscoursePrivateMessageItemCopyWith(
    DiscoursePrivateMessageItem value,
    $Res Function(DiscoursePrivateMessageItem) then,
  ) =
      _$DiscoursePrivateMessageItemCopyWithImpl<
        $Res,
        DiscoursePrivateMessageItem
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'cooked') String cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'post_number') int postNumber,
    @JsonKey(name: 'reply_to_post_number') int? replyToPostNumber,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'reads') int reads,
    @JsonKey(name: 'readers_count') int readersCount,
    @JsonKey(name: 'version') int version,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'can_delete') bool canDelete,
    @JsonKey(name: 'can_recover') bool canRecover,
    @JsonKey(name: 'can_wiki') bool canWiki,
    @JsonKey(name: 'user_title') String? userTitle,
    @JsonKey(name: 'title_is_group') bool titleIsGroup,
    @JsonKey(name: 'reply_to_user') Map<String, dynamic>? replyToUser,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'staff') bool staff,
    @JsonKey(name: 'user_trust_level') int userTrustLevel,
    @JsonKey(name: 'bookmarked') bool bookmarked,
  });
}

/// @nodoc
class _$DiscoursePrivateMessageItemCopyWithImpl<
  $Res,
  $Val extends DiscoursePrivateMessageItem
>
    implements $DiscoursePrivateMessageItemCopyWith<$Res> {
  _$DiscoursePrivateMessageItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePrivateMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = null,
    Object? userId = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? cooked = null,
    Object? raw = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? postNumber = null,
    Object? replyToPostNumber = freezed,
    Object? likeCount = null,
    Object? reads = null,
    Object? readersCount = null,
    Object? version = null,
    Object? canEdit = null,
    Object? canDelete = null,
    Object? canRecover = null,
    Object? canWiki = null,
    Object? userTitle = freezed,
    Object? titleIsGroup = null,
    Object? replyToUser = freezed,
    Object? actionsSummary = null,
    Object? moderator = null,
    Object? admin = null,
    Object? staff = null,
    Object? userTrustLevel = null,
    Object? bookmarked = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            topicId: null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
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
            cooked: null == cooked
                ? _value.cooked
                : cooked // ignore: cast_nullable_to_non_nullable
                      as String,
            raw: freezed == raw
                ? _value.raw
                : raw // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            postNumber: null == postNumber
                ? _value.postNumber
                : postNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            replyToPostNumber: freezed == replyToPostNumber
                ? _value.replyToPostNumber
                : replyToPostNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            reads: null == reads
                ? _value.reads
                : reads // ignore: cast_nullable_to_non_nullable
                      as int,
            readersCount: null == readersCount
                ? _value.readersCount
                : readersCount // ignore: cast_nullable_to_non_nullable
                      as int,
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
            canWiki: null == canWiki
                ? _value.canWiki
                : canWiki // ignore: cast_nullable_to_non_nullable
                      as bool,
            userTitle: freezed == userTitle
                ? _value.userTitle
                : userTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            titleIsGroup: null == titleIsGroup
                ? _value.titleIsGroup
                : titleIsGroup // ignore: cast_nullable_to_non_nullable
                      as bool,
            replyToUser: freezed == replyToUser
                ? _value.replyToUser
                : replyToUser // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
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
            userTrustLevel: null == userTrustLevel
                ? _value.userTrustLevel
                : userTrustLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            bookmarked: null == bookmarked
                ? _value.bookmarked
                : bookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DiscoursePrivateMessageItemImplCopyWith<$Res>
    implements $DiscoursePrivateMessageItemCopyWith<$Res> {
  factory _$$DiscoursePrivateMessageItemImplCopyWith(
    _$DiscoursePrivateMessageItemImpl value,
    $Res Function(_$DiscoursePrivateMessageItemImpl) then,
  ) = __$$DiscoursePrivateMessageItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'user_id') int userId,
    @JsonKey(name: 'username') String username,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'avatar_template') String avatarTemplate,
    @JsonKey(name: 'cooked') String cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'created_at') String createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
    @JsonKey(name: 'post_number') int postNumber,
    @JsonKey(name: 'reply_to_post_number') int? replyToPostNumber,
    @JsonKey(name: 'like_count') int likeCount,
    @JsonKey(name: 'reads') int reads,
    @JsonKey(name: 'readers_count') int readersCount,
    @JsonKey(name: 'version') int version,
    @JsonKey(name: 'can_edit') bool canEdit,
    @JsonKey(name: 'can_delete') bool canDelete,
    @JsonKey(name: 'can_recover') bool canRecover,
    @JsonKey(name: 'can_wiki') bool canWiki,
    @JsonKey(name: 'user_title') String? userTitle,
    @JsonKey(name: 'title_is_group') bool titleIsGroup,
    @JsonKey(name: 'reply_to_user') Map<String, dynamic>? replyToUser,
    @JsonKey(name: 'actions_summary') List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') bool moderator,
    @JsonKey(name: 'admin') bool admin,
    @JsonKey(name: 'staff') bool staff,
    @JsonKey(name: 'user_trust_level') int userTrustLevel,
    @JsonKey(name: 'bookmarked') bool bookmarked,
  });
}

/// @nodoc
class __$$DiscoursePrivateMessageItemImplCopyWithImpl<$Res>
    extends
        _$DiscoursePrivateMessageItemCopyWithImpl<
          $Res,
          _$DiscoursePrivateMessageItemImpl
        >
    implements _$$DiscoursePrivateMessageItemImplCopyWith<$Res> {
  __$$DiscoursePrivateMessageItemImplCopyWithImpl(
    _$DiscoursePrivateMessageItemImpl _value,
    $Res Function(_$DiscoursePrivateMessageItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePrivateMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topicId = null,
    Object? userId = null,
    Object? username = null,
    Object? name = freezed,
    Object? avatarTemplate = null,
    Object? cooked = null,
    Object? raw = freezed,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? postNumber = null,
    Object? replyToPostNumber = freezed,
    Object? likeCount = null,
    Object? reads = null,
    Object? readersCount = null,
    Object? version = null,
    Object? canEdit = null,
    Object? canDelete = null,
    Object? canRecover = null,
    Object? canWiki = null,
    Object? userTitle = freezed,
    Object? titleIsGroup = null,
    Object? replyToUser = freezed,
    Object? actionsSummary = null,
    Object? moderator = null,
    Object? admin = null,
    Object? staff = null,
    Object? userTrustLevel = null,
    Object? bookmarked = null,
  }) {
    return _then(
      _$DiscoursePrivateMessageItemImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        topicId: null == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
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
        cooked: null == cooked
            ? _value.cooked
            : cooked // ignore: cast_nullable_to_non_nullable
                  as String,
        raw: freezed == raw
            ? _value.raw
            : raw // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        postNumber: null == postNumber
            ? _value.postNumber
            : postNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        replyToPostNumber: freezed == replyToPostNumber
            ? _value.replyToPostNumber
            : replyToPostNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        reads: null == reads
            ? _value.reads
            : reads // ignore: cast_nullable_to_non_nullable
                  as int,
        readersCount: null == readersCount
            ? _value.readersCount
            : readersCount // ignore: cast_nullable_to_non_nullable
                  as int,
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
        canWiki: null == canWiki
            ? _value.canWiki
            : canWiki // ignore: cast_nullable_to_non_nullable
                  as bool,
        userTitle: freezed == userTitle
            ? _value.userTitle
            : userTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        titleIsGroup: null == titleIsGroup
            ? _value.titleIsGroup
            : titleIsGroup // ignore: cast_nullable_to_non_nullable
                  as bool,
        replyToUser: freezed == replyToUser
            ? _value._replyToUser
            : replyToUser // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
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
        userTrustLevel: null == userTrustLevel
            ? _value.userTrustLevel
            : userTrustLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        bookmarked: null == bookmarked
            ? _value.bookmarked
            : bookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscoursePrivateMessageItemImpl
    implements _DiscoursePrivateMessageItem {
  const _$DiscoursePrivateMessageItemImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'topic_id') required this.topicId,
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'username') required this.username,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'avatar_template') required this.avatarTemplate,
    @JsonKey(name: 'cooked') required this.cooked,
    @JsonKey(name: 'raw') this.raw,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') this.updatedAt,
    @JsonKey(name: 'post_number') required this.postNumber,
    @JsonKey(name: 'reply_to_post_number') this.replyToPostNumber,
    @JsonKey(name: 'like_count') this.likeCount = 0,
    @JsonKey(name: 'reads') this.reads = 0,
    @JsonKey(name: 'readers_count') this.readersCount = 0,
    @JsonKey(name: 'version') this.version = 1,
    @JsonKey(name: 'can_edit') this.canEdit = false,
    @JsonKey(name: 'can_delete') this.canDelete = false,
    @JsonKey(name: 'can_recover') this.canRecover = false,
    @JsonKey(name: 'can_wiki') this.canWiki = false,
    @JsonKey(name: 'user_title') this.userTitle,
    @JsonKey(name: 'title_is_group') this.titleIsGroup = false,
    @JsonKey(name: 'reply_to_user') final Map<String, dynamic>? replyToUser,
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary = const [],
    @JsonKey(name: 'moderator') this.moderator = false,
    @JsonKey(name: 'admin') this.admin = false,
    @JsonKey(name: 'staff') this.staff = false,
    @JsonKey(name: 'user_trust_level') this.userTrustLevel = 1,
    @JsonKey(name: 'bookmarked') this.bookmarked = false,
  }) : _replyToUser = replyToUser,
       _actionsSummary = actionsSummary;

  factory _$DiscoursePrivateMessageItemImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$DiscoursePrivateMessageItemImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'topic_id')
  final int topicId;
  @override
  @JsonKey(name: 'user_id')
  final int userId;
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
  @JsonKey(name: 'cooked')
  final String cooked;
  @override
  @JsonKey(name: 'raw')
  final String? raw;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @override
  @JsonKey(name: 'post_number')
  final int postNumber;
  @override
  @JsonKey(name: 'reply_to_post_number')
  final int? replyToPostNumber;
  @override
  @JsonKey(name: 'like_count')
  final int likeCount;
  @override
  @JsonKey(name: 'reads')
  final int reads;
  @override
  @JsonKey(name: 'readers_count')
  final int readersCount;
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
  @JsonKey(name: 'can_wiki')
  final bool canWiki;
  @override
  @JsonKey(name: 'user_title')
  final String? userTitle;
  @override
  @JsonKey(name: 'title_is_group')
  final bool titleIsGroup;
  final Map<String, dynamic>? _replyToUser;
  @override
  @JsonKey(name: 'reply_to_user')
  Map<String, dynamic>? get replyToUser {
    final value = _replyToUser;
    if (value == null) return null;
    if (_replyToUser is EqualUnmodifiableMapView) return _replyToUser;
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
  @JsonKey(name: 'moderator')
  final bool moderator;
  @override
  @JsonKey(name: 'admin')
  final bool admin;
  @override
  @JsonKey(name: 'staff')
  final bool staff;
  @override
  @JsonKey(name: 'user_trust_level')
  final int userTrustLevel;
  @override
  @JsonKey(name: 'bookmarked')
  final bool bookmarked;

  @override
  String toString() {
    return 'DiscoursePrivateMessageItem(id: $id, topicId: $topicId, userId: $userId, username: $username, name: $name, avatarTemplate: $avatarTemplate, cooked: $cooked, raw: $raw, createdAt: $createdAt, updatedAt: $updatedAt, postNumber: $postNumber, replyToPostNumber: $replyToPostNumber, likeCount: $likeCount, reads: $reads, readersCount: $readersCount, version: $version, canEdit: $canEdit, canDelete: $canDelete, canRecover: $canRecover, canWiki: $canWiki, userTitle: $userTitle, titleIsGroup: $titleIsGroup, replyToUser: $replyToUser, actionsSummary: $actionsSummary, moderator: $moderator, admin: $admin, staff: $staff, userTrustLevel: $userTrustLevel, bookmarked: $bookmarked)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePrivateMessageItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatarTemplate, avatarTemplate) ||
                other.avatarTemplate == avatarTemplate) &&
            (identical(other.cooked, cooked) || other.cooked == cooked) &&
            (identical(other.raw, raw) || other.raw == raw) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.postNumber, postNumber) ||
                other.postNumber == postNumber) &&
            (identical(other.replyToPostNumber, replyToPostNumber) ||
                other.replyToPostNumber == replyToPostNumber) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.reads, reads) || other.reads == reads) &&
            (identical(other.readersCount, readersCount) ||
                other.readersCount == readersCount) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.canEdit, canEdit) || other.canEdit == canEdit) &&
            (identical(other.canDelete, canDelete) ||
                other.canDelete == canDelete) &&
            (identical(other.canRecover, canRecover) ||
                other.canRecover == canRecover) &&
            (identical(other.canWiki, canWiki) || other.canWiki == canWiki) &&
            (identical(other.userTitle, userTitle) ||
                other.userTitle == userTitle) &&
            (identical(other.titleIsGroup, titleIsGroup) ||
                other.titleIsGroup == titleIsGroup) &&
            const DeepCollectionEquality().equals(
              other._replyToUser,
              _replyToUser,
            ) &&
            const DeepCollectionEquality().equals(
              other._actionsSummary,
              _actionsSummary,
            ) &&
            (identical(other.moderator, moderator) ||
                other.moderator == moderator) &&
            (identical(other.admin, admin) || other.admin == admin) &&
            (identical(other.staff, staff) || other.staff == staff) &&
            (identical(other.userTrustLevel, userTrustLevel) ||
                other.userTrustLevel == userTrustLevel) &&
            (identical(other.bookmarked, bookmarked) ||
                other.bookmarked == bookmarked));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    topicId,
    userId,
    username,
    name,
    avatarTemplate,
    cooked,
    raw,
    createdAt,
    updatedAt,
    postNumber,
    replyToPostNumber,
    likeCount,
    reads,
    readersCount,
    version,
    canEdit,
    canDelete,
    canRecover,
    canWiki,
    userTitle,
    titleIsGroup,
    const DeepCollectionEquality().hash(_replyToUser),
    const DeepCollectionEquality().hash(_actionsSummary),
    moderator,
    admin,
    staff,
    userTrustLevel,
    bookmarked,
  ]);

  /// Create a copy of DiscoursePrivateMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePrivateMessageItemImplCopyWith<_$DiscoursePrivateMessageItemImpl>
  get copyWith =>
      __$$DiscoursePrivateMessageItemImplCopyWithImpl<
        _$DiscoursePrivateMessageItemImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePrivateMessageItemImplToJson(this);
  }
}

abstract class _DiscoursePrivateMessageItem
    implements DiscoursePrivateMessageItem {
  const factory _DiscoursePrivateMessageItem({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'topic_id') required final int topicId,
    @JsonKey(name: 'user_id') required final int userId,
    @JsonKey(name: 'username') required final String username,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'avatar_template') required final String avatarTemplate,
    @JsonKey(name: 'cooked') required final String cooked,
    @JsonKey(name: 'raw') final String? raw,
    @JsonKey(name: 'created_at') required final String createdAt,
    @JsonKey(name: 'updated_at') final String? updatedAt,
    @JsonKey(name: 'post_number') required final int postNumber,
    @JsonKey(name: 'reply_to_post_number') final int? replyToPostNumber,
    @JsonKey(name: 'like_count') final int likeCount,
    @JsonKey(name: 'reads') final int reads,
    @JsonKey(name: 'readers_count') final int readersCount,
    @JsonKey(name: 'version') final int version,
    @JsonKey(name: 'can_edit') final bool canEdit,
    @JsonKey(name: 'can_delete') final bool canDelete,
    @JsonKey(name: 'can_recover') final bool canRecover,
    @JsonKey(name: 'can_wiki') final bool canWiki,
    @JsonKey(name: 'user_title') final String? userTitle,
    @JsonKey(name: 'title_is_group') final bool titleIsGroup,
    @JsonKey(name: 'reply_to_user') final Map<String, dynamic>? replyToUser,
    @JsonKey(name: 'actions_summary')
    final List<Map<String, dynamic>> actionsSummary,
    @JsonKey(name: 'moderator') final bool moderator,
    @JsonKey(name: 'admin') final bool admin,
    @JsonKey(name: 'staff') final bool staff,
    @JsonKey(name: 'user_trust_level') final int userTrustLevel,
    @JsonKey(name: 'bookmarked') final bool bookmarked,
  }) = _$DiscoursePrivateMessageItemImpl;

  factory _DiscoursePrivateMessageItem.fromJson(Map<String, dynamic> json) =
      _$DiscoursePrivateMessageItemImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'topic_id')
  int get topicId;
  @override
  @JsonKey(name: 'user_id')
  int get userId;
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
  @JsonKey(name: 'cooked')
  String get cooked;
  @override
  @JsonKey(name: 'raw')
  String? get raw;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String? get updatedAt;
  @override
  @JsonKey(name: 'post_number')
  int get postNumber;
  @override
  @JsonKey(name: 'reply_to_post_number')
  int? get replyToPostNumber;
  @override
  @JsonKey(name: 'like_count')
  int get likeCount;
  @override
  @JsonKey(name: 'reads')
  int get reads;
  @override
  @JsonKey(name: 'readers_count')
  int get readersCount;
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
  @JsonKey(name: 'can_wiki')
  bool get canWiki;
  @override
  @JsonKey(name: 'user_title')
  String? get userTitle;
  @override
  @JsonKey(name: 'title_is_group')
  bool get titleIsGroup;
  @override
  @JsonKey(name: 'reply_to_user')
  Map<String, dynamic>? get replyToUser;
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
  @JsonKey(name: 'user_trust_level')
  int get userTrustLevel;
  @override
  @JsonKey(name: 'bookmarked')
  bool get bookmarked;

  /// Create a copy of DiscoursePrivateMessageItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePrivateMessageItemImplCopyWith<_$DiscoursePrivateMessageItemImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PrivateMessageConversation _$PrivateMessageConversationFromJson(
  Map<String, dynamic> json,
) {
  return _PrivateMessageConversation.fromJson(json);
}

/// @nodoc
mixin _$PrivateMessageConversation {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'slug')
  String get slug => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_message')
  String? get lastMessage => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_messages')
  int get totalMessages => throw _privateConstructorUsedError;
  @JsonKey(name: 'participants')
  List<DiscourseUserBasic> get participants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'other_participant')
  DiscourseUserBasic? get otherParticipant =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'closed')
  bool get closed => throw _privateConstructorUsedError;
  @JsonKey(name: 'archived')
  bool get archived => throw _privateConstructorUsedError;

  /// Serializes this PrivateMessageConversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrivateMessageConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrivateMessageConversationCopyWith<PrivateMessageConversation>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivateMessageConversationCopyWith<$Res> {
  factory $PrivateMessageConversationCopyWith(
    PrivateMessageConversation value,
    $Res Function(PrivateMessageConversation) then,
  ) =
      _$PrivateMessageConversationCopyWithImpl<
        $Res,
        PrivateMessageConversation
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'total_messages') int totalMessages,
    @JsonKey(name: 'participants') List<DiscourseUserBasic> participants,
    @JsonKey(name: 'other_participant') DiscourseUserBasic? otherParticipant,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
  });

  $DiscourseUserBasicCopyWith<$Res>? get otherParticipant;
}

/// @nodoc
class _$PrivateMessageConversationCopyWithImpl<
  $Res,
  $Val extends PrivateMessageConversation
>
    implements $PrivateMessageConversationCopyWith<$Res> {
  _$PrivateMessageConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrivateMessageConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = null,
    Object? lastMessage = freezed,
    Object? lastPostedAt = freezed,
    Object? unreadCount = null,
    Object? totalMessages = null,
    Object? participants = null,
    Object? otherParticipant = freezed,
    Object? createdAt = freezed,
    Object? closed = null,
    Object? archived = null,
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
            slug: null == slug
                ? _value.slug
                : slug // ignore: cast_nullable_to_non_nullable
                      as String,
            lastMessage: freezed == lastMessage
                ? _value.lastMessage
                : lastMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastPostedAt: freezed == lastPostedAt
                ? _value.lastPostedAt
                : lastPostedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            totalMessages: null == totalMessages
                ? _value.totalMessages
                : totalMessages // ignore: cast_nullable_to_non_nullable
                      as int,
            participants: null == participants
                ? _value.participants
                : participants // ignore: cast_nullable_to_non_nullable
                      as List<DiscourseUserBasic>,
            otherParticipant: freezed == otherParticipant
                ? _value.otherParticipant
                : otherParticipant // ignore: cast_nullable_to_non_nullable
                      as DiscourseUserBasic?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            closed: null == closed
                ? _value.closed
                : closed // ignore: cast_nullable_to_non_nullable
                      as bool,
            archived: null == archived
                ? _value.archived
                : archived // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of PrivateMessageConversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DiscourseUserBasicCopyWith<$Res>? get otherParticipant {
    if (_value.otherParticipant == null) {
      return null;
    }

    return $DiscourseUserBasicCopyWith<$Res>(_value.otherParticipant!, (value) {
      return _then(_value.copyWith(otherParticipant: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PrivateMessageConversationImplCopyWith<$Res>
    implements $PrivateMessageConversationCopyWith<$Res> {
  factory _$$PrivateMessageConversationImplCopyWith(
    _$PrivateMessageConversationImpl value,
    $Res Function(_$PrivateMessageConversationImpl) then,
  ) = __$$PrivateMessageConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int id,
    @JsonKey(name: 'title') String title,
    @JsonKey(name: 'slug') String slug,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_posted_at') String? lastPostedAt,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'total_messages') int totalMessages,
    @JsonKey(name: 'participants') List<DiscourseUserBasic> participants,
    @JsonKey(name: 'other_participant') DiscourseUserBasic? otherParticipant,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'closed') bool closed,
    @JsonKey(name: 'archived') bool archived,
  });

  @override
  $DiscourseUserBasicCopyWith<$Res>? get otherParticipant;
}

/// @nodoc
class __$$PrivateMessageConversationImplCopyWithImpl<$Res>
    extends
        _$PrivateMessageConversationCopyWithImpl<
          $Res,
          _$PrivateMessageConversationImpl
        >
    implements _$$PrivateMessageConversationImplCopyWith<$Res> {
  __$$PrivateMessageConversationImplCopyWithImpl(
    _$PrivateMessageConversationImpl _value,
    $Res Function(_$PrivateMessageConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrivateMessageConversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? slug = null,
    Object? lastMessage = freezed,
    Object? lastPostedAt = freezed,
    Object? unreadCount = null,
    Object? totalMessages = null,
    Object? participants = null,
    Object? otherParticipant = freezed,
    Object? createdAt = freezed,
    Object? closed = null,
    Object? archived = null,
  }) {
    return _then(
      _$PrivateMessageConversationImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        slug: null == slug
            ? _value.slug
            : slug // ignore: cast_nullable_to_non_nullable
                  as String,
        lastMessage: freezed == lastMessage
            ? _value.lastMessage
            : lastMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastPostedAt: freezed == lastPostedAt
            ? _value.lastPostedAt
            : lastPostedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        totalMessages: null == totalMessages
            ? _value.totalMessages
            : totalMessages // ignore: cast_nullable_to_non_nullable
                  as int,
        participants: null == participants
            ? _value._participants
            : participants // ignore: cast_nullable_to_non_nullable
                  as List<DiscourseUserBasic>,
        otherParticipant: freezed == otherParticipant
            ? _value.otherParticipant
            : otherParticipant // ignore: cast_nullable_to_non_nullable
                  as DiscourseUserBasic?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        closed: null == closed
            ? _value.closed
            : closed // ignore: cast_nullable_to_non_nullable
                  as bool,
        archived: null == archived
            ? _value.archived
            : archived // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivateMessageConversationImpl implements _PrivateMessageConversation {
  const _$PrivateMessageConversationImpl({
    @JsonKey(name: 'id') required this.id,
    @JsonKey(name: 'title') required this.title,
    @JsonKey(name: 'slug') required this.slug,
    @JsonKey(name: 'last_message') this.lastMessage,
    @JsonKey(name: 'last_posted_at') this.lastPostedAt,
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    @JsonKey(name: 'total_messages') this.totalMessages = 0,
    @JsonKey(name: 'participants')
    final List<DiscourseUserBasic> participants = const [],
    @JsonKey(name: 'other_participant') this.otherParticipant,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'closed') this.closed = false,
    @JsonKey(name: 'archived') this.archived = false,
  }) : _participants = participants;

  factory _$PrivateMessageConversationImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PrivateMessageConversationImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'slug')
  final String slug;
  @override
  @JsonKey(name: 'last_message')
  final String? lastMessage;
  @override
  @JsonKey(name: 'last_posted_at')
  final String? lastPostedAt;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey(name: 'total_messages')
  final int totalMessages;
  final List<DiscourseUserBasic> _participants;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseUserBasic> get participants {
    if (_participants is EqualUnmodifiableListView) return _participants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  @JsonKey(name: 'other_participant')
  final DiscourseUserBasic? otherParticipant;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @override
  @JsonKey(name: 'closed')
  final bool closed;
  @override
  @JsonKey(name: 'archived')
  final bool archived;

  @override
  String toString() {
    return 'PrivateMessageConversation(id: $id, title: $title, slug: $slug, lastMessage: $lastMessage, lastPostedAt: $lastPostedAt, unreadCount: $unreadCount, totalMessages: $totalMessages, participants: $participants, otherParticipant: $otherParticipant, createdAt: $createdAt, closed: $closed, archived: $archived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivateMessageConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastPostedAt, lastPostedAt) ||
                other.lastPostedAt == lastPostedAt) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.totalMessages, totalMessages) ||
                other.totalMessages == totalMessages) &&
            const DeepCollectionEquality().equals(
              other._participants,
              _participants,
            ) &&
            (identical(other.otherParticipant, otherParticipant) ||
                other.otherParticipant == otherParticipant) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.closed, closed) || other.closed == closed) &&
            (identical(other.archived, archived) ||
                other.archived == archived));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    slug,
    lastMessage,
    lastPostedAt,
    unreadCount,
    totalMessages,
    const DeepCollectionEquality().hash(_participants),
    otherParticipant,
    createdAt,
    closed,
    archived,
  );

  /// Create a copy of PrivateMessageConversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivateMessageConversationImplCopyWith<_$PrivateMessageConversationImpl>
  get copyWith =>
      __$$PrivateMessageConversationImplCopyWithImpl<
        _$PrivateMessageConversationImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivateMessageConversationImplToJson(this);
  }
}

abstract class _PrivateMessageConversation
    implements PrivateMessageConversation {
  const factory _PrivateMessageConversation({
    @JsonKey(name: 'id') required final int id,
    @JsonKey(name: 'title') required final String title,
    @JsonKey(name: 'slug') required final String slug,
    @JsonKey(name: 'last_message') final String? lastMessage,
    @JsonKey(name: 'last_posted_at') final String? lastPostedAt,
    @JsonKey(name: 'unread_count') final int unreadCount,
    @JsonKey(name: 'total_messages') final int totalMessages,
    @JsonKey(name: 'participants') final List<DiscourseUserBasic> participants,
    @JsonKey(name: 'other_participant')
    final DiscourseUserBasic? otherParticipant,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'closed') final bool closed,
    @JsonKey(name: 'archived') final bool archived,
  }) = _$PrivateMessageConversationImpl;

  factory _PrivateMessageConversation.fromJson(Map<String, dynamic> json) =
      _$PrivateMessageConversationImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'slug')
  String get slug;
  @override
  @JsonKey(name: 'last_message')
  String? get lastMessage;
  @override
  @JsonKey(name: 'last_posted_at')
  String? get lastPostedAt;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  @JsonKey(name: 'total_messages')
  int get totalMessages;
  @override
  @JsonKey(name: 'participants')
  List<DiscourseUserBasic> get participants;
  @override
  @JsonKey(name: 'other_participant')
  DiscourseUserBasic? get otherParticipant;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'closed')
  bool get closed;
  @override
  @JsonKey(name: 'archived')
  bool get archived;

  /// Create a copy of PrivateMessageConversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrivateMessageConversationImplCopyWith<_$PrivateMessageConversationImpl>
  get copyWith => throw _privateConstructorUsedError;
}

SendPrivateMessageResponse _$SendPrivateMessageResponseFromJson(
  Map<String, dynamic> json,
) {
  return _SendPrivateMessageResponse.fromJson(json);
}

/// @nodoc
mixin _$SendPrivateMessageResponse {
  @JsonKey(name: 'id')
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_id')
  int? get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'topic_slug')
  String? get topicSlug => throw _privateConstructorUsedError;
  @JsonKey(name: 'post_number')
  int? get postNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'cooked')
  String? get cooked => throw _privateConstructorUsedError;
  @JsonKey(name: 'raw')
  String? get raw => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'errors')
  List<String>? get errors => throw _privateConstructorUsedError;
  @JsonKey(name: 'error_type')
  String? get errorType => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String? get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'success')
  bool? get success => throw _privateConstructorUsedError;

  /// Serializes this SendPrivateMessageResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SendPrivateMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendPrivateMessageResponseCopyWith<SendPrivateMessageResponse>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendPrivateMessageResponseCopyWith<$Res> {
  factory $SendPrivateMessageResponseCopyWith(
    SendPrivateMessageResponse value,
    $Res Function(SendPrivateMessageResponse) then,
  ) =
      _$SendPrivateMessageResponseCopyWithImpl<
        $Res,
        SendPrivateMessageResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'post_number') int? postNumber,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'cooked') String? cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'errors') List<String>? errors,
    @JsonKey(name: 'error_type') String? errorType,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'success') bool? success,
  });
}

/// @nodoc
class _$SendPrivateMessageResponseCopyWithImpl<
  $Res,
  $Val extends SendPrivateMessageResponse
>
    implements $SendPrivateMessageResponseCopyWith<$Res> {
  _$SendPrivateMessageResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendPrivateMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? topicId = freezed,
    Object? topicSlug = freezed,
    Object? postNumber = freezed,
    Object? username = freezed,
    Object? cooked = freezed,
    Object? raw = freezed,
    Object? createdAt = freezed,
    Object? errors = freezed,
    Object? errorType = freezed,
    Object? message = freezed,
    Object? success = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int?,
            topicId: freezed == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int?,
            topicSlug: freezed == topicSlug
                ? _value.topicSlug
                : topicSlug // ignore: cast_nullable_to_non_nullable
                      as String?,
            postNumber: freezed == postNumber
                ? _value.postNumber
                : postNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            username: freezed == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String?,
            cooked: freezed == cooked
                ? _value.cooked
                : cooked // ignore: cast_nullable_to_non_nullable
                      as String?,
            raw: freezed == raw
                ? _value.raw
                : raw // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as String?,
            errors: freezed == errors
                ? _value.errors
                : errors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            errorType: freezed == errorType
                ? _value.errorType
                : errorType // ignore: cast_nullable_to_non_nullable
                      as String?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            success: freezed == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SendPrivateMessageResponseImplCopyWith<$Res>
    implements $SendPrivateMessageResponseCopyWith<$Res> {
  factory _$$SendPrivateMessageResponseImplCopyWith(
    _$SendPrivateMessageResponseImpl value,
    $Res Function(_$SendPrivateMessageResponseImpl) then,
  ) = __$$SendPrivateMessageResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'topic_id') int? topicId,
    @JsonKey(name: 'topic_slug') String? topicSlug,
    @JsonKey(name: 'post_number') int? postNumber,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'cooked') String? cooked,
    @JsonKey(name: 'raw') String? raw,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'errors') List<String>? errors,
    @JsonKey(name: 'error_type') String? errorType,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'success') bool? success,
  });
}

/// @nodoc
class __$$SendPrivateMessageResponseImplCopyWithImpl<$Res>
    extends
        _$SendPrivateMessageResponseCopyWithImpl<
          $Res,
          _$SendPrivateMessageResponseImpl
        >
    implements _$$SendPrivateMessageResponseImplCopyWith<$Res> {
  __$$SendPrivateMessageResponseImplCopyWithImpl(
    _$SendPrivateMessageResponseImpl _value,
    $Res Function(_$SendPrivateMessageResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SendPrivateMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? topicId = freezed,
    Object? topicSlug = freezed,
    Object? postNumber = freezed,
    Object? username = freezed,
    Object? cooked = freezed,
    Object? raw = freezed,
    Object? createdAt = freezed,
    Object? errors = freezed,
    Object? errorType = freezed,
    Object? message = freezed,
    Object? success = freezed,
  }) {
    return _then(
      _$SendPrivateMessageResponseImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int?,
        topicId: freezed == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int?,
        topicSlug: freezed == topicSlug
            ? _value.topicSlug
            : topicSlug // ignore: cast_nullable_to_non_nullable
                  as String?,
        postNumber: freezed == postNumber
            ? _value.postNumber
            : postNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        username: freezed == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String?,
        cooked: freezed == cooked
            ? _value.cooked
            : cooked // ignore: cast_nullable_to_non_nullable
                  as String?,
        raw: freezed == raw
            ? _value.raw
            : raw // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as String?,
        errors: freezed == errors
            ? _value._errors
            : errors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        errorType: freezed == errorType
            ? _value.errorType
            : errorType // ignore: cast_nullable_to_non_nullable
                  as String?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        success: freezed == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SendPrivateMessageResponseImpl implements _SendPrivateMessageResponse {
  const _$SendPrivateMessageResponseImpl({
    @JsonKey(name: 'id') this.id,
    @JsonKey(name: 'topic_id') this.topicId,
    @JsonKey(name: 'topic_slug') this.topicSlug,
    @JsonKey(name: 'post_number') this.postNumber,
    @JsonKey(name: 'username') this.username,
    @JsonKey(name: 'cooked') this.cooked,
    @JsonKey(name: 'raw') this.raw,
    @JsonKey(name: 'created_at') this.createdAt,
    @JsonKey(name: 'errors') final List<String>? errors,
    @JsonKey(name: 'error_type') this.errorType,
    @JsonKey(name: 'message') this.message,
    @JsonKey(name: 'success') this.success,
  }) : _errors = errors;

  factory _$SendPrivateMessageResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$SendPrivateMessageResponseImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int? id;
  @override
  @JsonKey(name: 'topic_id')
  final int? topicId;
  @override
  @JsonKey(name: 'topic_slug')
  final String? topicSlug;
  @override
  @JsonKey(name: 'post_number')
  final int? postNumber;
  @override
  @JsonKey(name: 'username')
  final String? username;
  @override
  @JsonKey(name: 'cooked')
  final String? cooked;
  @override
  @JsonKey(name: 'raw')
  final String? raw;
  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;
  final List<String>? _errors;
  @override
  @JsonKey(name: 'errors')
  List<String>? get errors {
    final value = _errors;
    if (value == null) return null;
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'error_type')
  final String? errorType;
  @override
  @JsonKey(name: 'message')
  final String? message;
  @override
  @JsonKey(name: 'success')
  final bool? success;

  @override
  String toString() {
    return 'SendPrivateMessageResponse(id: $id, topicId: $topicId, topicSlug: $topicSlug, postNumber: $postNumber, username: $username, cooked: $cooked, raw: $raw, createdAt: $createdAt, errors: $errors, errorType: $errorType, message: $message, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendPrivateMessageResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.topicSlug, topicSlug) ||
                other.topicSlug == topicSlug) &&
            (identical(other.postNumber, postNumber) ||
                other.postNumber == postNumber) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.cooked, cooked) || other.cooked == cooked) &&
            (identical(other.raw, raw) || other.raw == raw) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality().equals(other._errors, _errors) &&
            (identical(other.errorType, errorType) ||
                other.errorType == errorType) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    topicId,
    topicSlug,
    postNumber,
    username,
    cooked,
    raw,
    createdAt,
    const DeepCollectionEquality().hash(_errors),
    errorType,
    message,
    success,
  );

  /// Create a copy of SendPrivateMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendPrivateMessageResponseImplCopyWith<_$SendPrivateMessageResponseImpl>
  get copyWith =>
      __$$SendPrivateMessageResponseImplCopyWithImpl<
        _$SendPrivateMessageResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SendPrivateMessageResponseImplToJson(this);
  }
}

abstract class _SendPrivateMessageResponse
    implements SendPrivateMessageResponse {
  const factory _SendPrivateMessageResponse({
    @JsonKey(name: 'id') final int? id,
    @JsonKey(name: 'topic_id') final int? topicId,
    @JsonKey(name: 'topic_slug') final String? topicSlug,
    @JsonKey(name: 'post_number') final int? postNumber,
    @JsonKey(name: 'username') final String? username,
    @JsonKey(name: 'cooked') final String? cooked,
    @JsonKey(name: 'raw') final String? raw,
    @JsonKey(name: 'created_at') final String? createdAt,
    @JsonKey(name: 'errors') final List<String>? errors,
    @JsonKey(name: 'error_type') final String? errorType,
    @JsonKey(name: 'message') final String? message,
    @JsonKey(name: 'success') final bool? success,
  }) = _$SendPrivateMessageResponseImpl;

  factory _SendPrivateMessageResponse.fromJson(Map<String, dynamic> json) =
      _$SendPrivateMessageResponseImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int? get id;
  @override
  @JsonKey(name: 'topic_id')
  int? get topicId;
  @override
  @JsonKey(name: 'topic_slug')
  String? get topicSlug;
  @override
  @JsonKey(name: 'post_number')
  int? get postNumber;
  @override
  @JsonKey(name: 'username')
  String? get username;
  @override
  @JsonKey(name: 'cooked')
  String? get cooked;
  @override
  @JsonKey(name: 'raw')
  String? get raw;
  @override
  @JsonKey(name: 'created_at')
  String? get createdAt;
  @override
  @JsonKey(name: 'errors')
  List<String>? get errors;
  @override
  @JsonKey(name: 'error_type')
  String? get errorType;
  @override
  @JsonKey(name: 'message')
  String? get message;
  @override
  @JsonKey(name: 'success')
  bool? get success;

  /// Create a copy of SendPrivateMessageResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendPrivateMessageResponseImplCopyWith<_$SendPrivateMessageResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PrivateMessageUnreadCount _$PrivateMessageUnreadCountFromJson(
  Map<String, dynamic> json,
) {
  return _PrivateMessageUnreadCount.fromJson(json);
}

/// @nodoc
mixin _$PrivateMessageUnreadCount {
  @JsonKey(name: 'topic_id')
  int get topicId => throw _privateConstructorUsedError;
  @JsonKey(name: 'unread_count')
  int get unreadCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'highest_post_number')
  int get highestPostNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_read_post_number')
  int get lastReadPostNumber => throw _privateConstructorUsedError;

  /// Serializes this PrivateMessageUnreadCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrivateMessageUnreadCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrivateMessageUnreadCountCopyWith<PrivateMessageUnreadCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivateMessageUnreadCountCopyWith<$Res> {
  factory $PrivateMessageUnreadCountCopyWith(
    PrivateMessageUnreadCount value,
    $Res Function(PrivateMessageUnreadCount) then,
  ) = _$PrivateMessageUnreadCountCopyWithImpl<$Res, PrivateMessageUnreadCount>;
  @useResult
  $Res call({
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'highest_post_number') int highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int lastReadPostNumber,
  });
}

/// @nodoc
class _$PrivateMessageUnreadCountCopyWithImpl<
  $Res,
  $Val extends PrivateMessageUnreadCount
>
    implements $PrivateMessageUnreadCountCopyWith<$Res> {
  _$PrivateMessageUnreadCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrivateMessageUnreadCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = null,
    Object? unreadCount = null,
    Object? highestPostNumber = null,
    Object? lastReadPostNumber = null,
  }) {
    return _then(
      _value.copyWith(
            topicId: null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int,
            unreadCount: null == unreadCount
                ? _value.unreadCount
                : unreadCount // ignore: cast_nullable_to_non_nullable
                      as int,
            highestPostNumber: null == highestPostNumber
                ? _value.highestPostNumber
                : highestPostNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            lastReadPostNumber: null == lastReadPostNumber
                ? _value.lastReadPostNumber
                : lastReadPostNumber // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrivateMessageUnreadCountImplCopyWith<$Res>
    implements $PrivateMessageUnreadCountCopyWith<$Res> {
  factory _$$PrivateMessageUnreadCountImplCopyWith(
    _$PrivateMessageUnreadCountImpl value,
    $Res Function(_$PrivateMessageUnreadCountImpl) then,
  ) = __$$PrivateMessageUnreadCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'topic_id') int topicId,
    @JsonKey(name: 'unread_count') int unreadCount,
    @JsonKey(name: 'highest_post_number') int highestPostNumber,
    @JsonKey(name: 'last_read_post_number') int lastReadPostNumber,
  });
}

/// @nodoc
class __$$PrivateMessageUnreadCountImplCopyWithImpl<$Res>
    extends
        _$PrivateMessageUnreadCountCopyWithImpl<
          $Res,
          _$PrivateMessageUnreadCountImpl
        >
    implements _$$PrivateMessageUnreadCountImplCopyWith<$Res> {
  __$$PrivateMessageUnreadCountImplCopyWithImpl(
    _$PrivateMessageUnreadCountImpl _value,
    $Res Function(_$PrivateMessageUnreadCountImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrivateMessageUnreadCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = null,
    Object? unreadCount = null,
    Object? highestPostNumber = null,
    Object? lastReadPostNumber = null,
  }) {
    return _then(
      _$PrivateMessageUnreadCountImpl(
        topicId: null == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int,
        unreadCount: null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
        highestPostNumber: null == highestPostNumber
            ? _value.highestPostNumber
            : highestPostNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        lastReadPostNumber: null == lastReadPostNumber
            ? _value.lastReadPostNumber
            : lastReadPostNumber // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivateMessageUnreadCountImpl implements _PrivateMessageUnreadCount {
  const _$PrivateMessageUnreadCountImpl({
    @JsonKey(name: 'topic_id') required this.topicId,
    @JsonKey(name: 'unread_count') this.unreadCount = 0,
    @JsonKey(name: 'highest_post_number') this.highestPostNumber = 0,
    @JsonKey(name: 'last_read_post_number') this.lastReadPostNumber = 0,
  });

  factory _$PrivateMessageUnreadCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrivateMessageUnreadCountImplFromJson(json);

  @override
  @JsonKey(name: 'topic_id')
  final int topicId;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey(name: 'highest_post_number')
  final int highestPostNumber;
  @override
  @JsonKey(name: 'last_read_post_number')
  final int lastReadPostNumber;

  @override
  String toString() {
    return 'PrivateMessageUnreadCount(topicId: $topicId, unreadCount: $unreadCount, highestPostNumber: $highestPostNumber, lastReadPostNumber: $lastReadPostNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivateMessageUnreadCountImpl &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.highestPostNumber, highestPostNumber) ||
                other.highestPostNumber == highestPostNumber) &&
            (identical(other.lastReadPostNumber, lastReadPostNumber) ||
                other.lastReadPostNumber == lastReadPostNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    topicId,
    unreadCount,
    highestPostNumber,
    lastReadPostNumber,
  );

  /// Create a copy of PrivateMessageUnreadCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivateMessageUnreadCountImplCopyWith<_$PrivateMessageUnreadCountImpl>
  get copyWith =>
      __$$PrivateMessageUnreadCountImplCopyWithImpl<
        _$PrivateMessageUnreadCountImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivateMessageUnreadCountImplToJson(this);
  }
}

abstract class _PrivateMessageUnreadCount implements PrivateMessageUnreadCount {
  const factory _PrivateMessageUnreadCount({
    @JsonKey(name: 'topic_id') required final int topicId,
    @JsonKey(name: 'unread_count') final int unreadCount,
    @JsonKey(name: 'highest_post_number') final int highestPostNumber,
    @JsonKey(name: 'last_read_post_number') final int lastReadPostNumber,
  }) = _$PrivateMessageUnreadCountImpl;

  factory _PrivateMessageUnreadCount.fromJson(Map<String, dynamic> json) =
      _$PrivateMessageUnreadCountImpl.fromJson;

  @override
  @JsonKey(name: 'topic_id')
  int get topicId;
  @override
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @override
  @JsonKey(name: 'highest_post_number')
  int get highestPostNumber;
  @override
  @JsonKey(name: 'last_read_post_number')
  int get lastReadPostNumber;

  /// Create a copy of PrivateMessageUnreadCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrivateMessageUnreadCountImplCopyWith<_$PrivateMessageUnreadCountImpl>
  get copyWith => throw _privateConstructorUsedError;
}

PrivateMessageTrackingStateResponse
_$PrivateMessageTrackingStateResponseFromJson(Map<String, dynamic> json) {
  return _PrivateMessageTrackingStateResponse.fromJson(json);
}

/// @nodoc
mixin _$PrivateMessageTrackingStateResponse {
  @JsonKey(name: 'private_message_topic_tracking_state')
  List<PrivateMessageUnreadCount> get trackingStates =>
      throw _privateConstructorUsedError;

  /// Serializes this PrivateMessageTrackingStateResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PrivateMessageTrackingStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PrivateMessageTrackingStateResponseCopyWith<
    PrivateMessageTrackingStateResponse
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivateMessageTrackingStateResponseCopyWith<$Res> {
  factory $PrivateMessageTrackingStateResponseCopyWith(
    PrivateMessageTrackingStateResponse value,
    $Res Function(PrivateMessageTrackingStateResponse) then,
  ) =
      _$PrivateMessageTrackingStateResponseCopyWithImpl<
        $Res,
        PrivateMessageTrackingStateResponse
      >;
  @useResult
  $Res call({
    @JsonKey(name: 'private_message_topic_tracking_state')
    List<PrivateMessageUnreadCount> trackingStates,
  });
}

/// @nodoc
class _$PrivateMessageTrackingStateResponseCopyWithImpl<
  $Res,
  $Val extends PrivateMessageTrackingStateResponse
>
    implements $PrivateMessageTrackingStateResponseCopyWith<$Res> {
  _$PrivateMessageTrackingStateResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PrivateMessageTrackingStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? trackingStates = null}) {
    return _then(
      _value.copyWith(
            trackingStates: null == trackingStates
                ? _value.trackingStates
                : trackingStates // ignore: cast_nullable_to_non_nullable
                      as List<PrivateMessageUnreadCount>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PrivateMessageTrackingStateResponseImplCopyWith<$Res>
    implements $PrivateMessageTrackingStateResponseCopyWith<$Res> {
  factory _$$PrivateMessageTrackingStateResponseImplCopyWith(
    _$PrivateMessageTrackingStateResponseImpl value,
    $Res Function(_$PrivateMessageTrackingStateResponseImpl) then,
  ) = __$$PrivateMessageTrackingStateResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'private_message_topic_tracking_state')
    List<PrivateMessageUnreadCount> trackingStates,
  });
}

/// @nodoc
class __$$PrivateMessageTrackingStateResponseImplCopyWithImpl<$Res>
    extends
        _$PrivateMessageTrackingStateResponseCopyWithImpl<
          $Res,
          _$PrivateMessageTrackingStateResponseImpl
        >
    implements _$$PrivateMessageTrackingStateResponseImplCopyWith<$Res> {
  __$$PrivateMessageTrackingStateResponseImplCopyWithImpl(
    _$PrivateMessageTrackingStateResponseImpl _value,
    $Res Function(_$PrivateMessageTrackingStateResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PrivateMessageTrackingStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? trackingStates = null}) {
    return _then(
      _$PrivateMessageTrackingStateResponseImpl(
        trackingStates: null == trackingStates
            ? _value._trackingStates
            : trackingStates // ignore: cast_nullable_to_non_nullable
                  as List<PrivateMessageUnreadCount>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivateMessageTrackingStateResponseImpl
    implements _PrivateMessageTrackingStateResponse {
  const _$PrivateMessageTrackingStateResponseImpl({
    @JsonKey(name: 'private_message_topic_tracking_state')
    final List<PrivateMessageUnreadCount> trackingStates = const [],
  }) : _trackingStates = trackingStates;

  factory _$PrivateMessageTrackingStateResponseImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$PrivateMessageTrackingStateResponseImplFromJson(json);

  final List<PrivateMessageUnreadCount> _trackingStates;
  @override
  @JsonKey(name: 'private_message_topic_tracking_state')
  List<PrivateMessageUnreadCount> get trackingStates {
    if (_trackingStates is EqualUnmodifiableListView) return _trackingStates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trackingStates);
  }

  @override
  String toString() {
    return 'PrivateMessageTrackingStateResponse(trackingStates: $trackingStates)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivateMessageTrackingStateResponseImpl &&
            const DeepCollectionEquality().equals(
              other._trackingStates,
              _trackingStates,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_trackingStates),
  );

  /// Create a copy of PrivateMessageTrackingStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivateMessageTrackingStateResponseImplCopyWith<
    _$PrivateMessageTrackingStateResponseImpl
  >
  get copyWith =>
      __$$PrivateMessageTrackingStateResponseImplCopyWithImpl<
        _$PrivateMessageTrackingStateResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivateMessageTrackingStateResponseImplToJson(this);
  }
}

abstract class _PrivateMessageTrackingStateResponse
    implements PrivateMessageTrackingStateResponse {
  const factory _PrivateMessageTrackingStateResponse({
    @JsonKey(name: 'private_message_topic_tracking_state')
    final List<PrivateMessageUnreadCount> trackingStates,
  }) = _$PrivateMessageTrackingStateResponseImpl;

  factory _PrivateMessageTrackingStateResponse.fromJson(
    Map<String, dynamic> json,
  ) = _$PrivateMessageTrackingStateResponseImpl.fromJson;

  @override
  @JsonKey(name: 'private_message_topic_tracking_state')
  List<PrivateMessageUnreadCount> get trackingStates;

  /// Create a copy of PrivateMessageTrackingStateResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PrivateMessageTrackingStateResponseImplCopyWith<
    _$PrivateMessageTrackingStateResponseImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
