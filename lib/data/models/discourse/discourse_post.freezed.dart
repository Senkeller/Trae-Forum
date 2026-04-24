// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discourse_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

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

DiscoursePostListResponse _$DiscoursePostListResponseFromJson(
  Map<String, dynamic> json,
) {
  return _DiscoursePostListResponse.fromJson(json);
}

/// @nodoc
mixin _$DiscoursePostListResponse {
  @JsonKey(name: 'post_stream')
  DiscoursePostStream? get postStream => throw _privateConstructorUsedError;
  @JsonKey(name: 'timeline_lookup')
  List<List<dynamic>> get timelineLookup => throw _privateConstructorUsedError;
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

  /// Serializes this DiscoursePostListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DiscoursePostListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DiscoursePostListResponseCopyWith<DiscoursePostListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscoursePostListResponseCopyWith<$Res> {
  factory $DiscoursePostListResponseCopyWith(
    DiscoursePostListResponse value,
    $Res Function(DiscoursePostListResponse) then,
  ) = _$DiscoursePostListResponseCopyWithImpl<$Res, DiscoursePostListResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') List<List<dynamic>> timelineLookup,
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
}

/// @nodoc
class _$DiscoursePostListResponseCopyWithImpl<
  $Res,
  $Val extends DiscoursePostListResponse
>
    implements $DiscoursePostListResponseCopyWith<$Res> {
  _$DiscoursePostListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DiscoursePostListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postStream = freezed,
    Object? timelineLookup = null,
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

  /// Create a copy of DiscoursePostListResponse
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
}

/// @nodoc
abstract class _$$DiscoursePostListResponseImplCopyWith<$Res>
    implements $DiscoursePostListResponseCopyWith<$Res> {
  factory _$$DiscoursePostListResponseImplCopyWith(
    _$DiscoursePostListResponseImpl value,
    $Res Function(_$DiscoursePostListResponseImpl) then,
  ) = __$$DiscoursePostListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'post_stream') DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') List<List<dynamic>> timelineLookup,
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
}

/// @nodoc
class __$$DiscoursePostListResponseImplCopyWithImpl<$Res>
    extends
        _$DiscoursePostListResponseCopyWithImpl<
          $Res,
          _$DiscoursePostListResponseImpl
        >
    implements _$$DiscoursePostListResponseImplCopyWith<$Res> {
  __$$DiscoursePostListResponseImplCopyWithImpl(
    _$DiscoursePostListResponseImpl _value,
    $Res Function(_$DiscoursePostListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DiscoursePostListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postStream = freezed,
    Object? timelineLookup = null,
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
      _$DiscoursePostListResponseImpl(
        postStream: freezed == postStream
            ? _value.postStream
            : postStream // ignore: cast_nullable_to_non_nullable
                  as DiscoursePostStream?,
        timelineLookup: null == timelineLookup
            ? _value._timelineLookup
            : timelineLookup // ignore: cast_nullable_to_non_nullable
                  as List<List<dynamic>>,
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
class _$DiscoursePostListResponseImpl implements _DiscoursePostListResponse {
  const _$DiscoursePostListResponseImpl({
    @JsonKey(name: 'post_stream') this.postStream,
    @JsonKey(name: 'timeline_lookup')
    final List<List<dynamic>> timelineLookup = const [],
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
       _deletedBy = deletedBy,
       _actionsSummary = actionsSummary,
       _topicTimer = topicTimer,
       _thumbnails = thumbnails,
       _tags = tags,
       _tagsDescriptions = tagsDescriptions;

  factory _$DiscoursePostListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscoursePostListResponseImplFromJson(json);

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
    return 'DiscoursePostListResponse(postStream: $postStream, timelineLookup: $timelineLookup, id: $id, title: $title, fancyTitle: $fancyTitle, postsCount: $postsCount, createdAt: $createdAt, views: $views, replyCount: $replyCount, likeCount: $likeCount, lastPostedAt: $lastPostedAt, visible: $visible, closed: $closed, archived: $archived, hasSummary: $hasSummary, archetype: $archetype, slug: $slug, categoryId: $categoryId, wordCount: $wordCount, userId: $userId, pinnedGlobally: $pinnedGlobally, pinned: $pinned, pinnedAt: $pinnedAt, highestPostNumber: $highestPostNumber, lastReadPostNumber: $lastReadPostNumber, deletedBy: $deletedBy, actionsSummary: $actionsSummary, chunkSize: $chunkSize, bookmarked: $bookmarked, topicTimer: $topicTimer, messageBusLastId: $messageBusLastId, participantCount: $participantCount, showReadIndicator: $showReadIndicator, thumbnails: $thumbnails, tags: $tags, tagsDescriptions: $tagsDescriptions, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscoursePostListResponseImpl &&
            (identical(other.postStream, postStream) ||
                other.postStream == postStream) &&
            const DeepCollectionEquality().equals(
              other._timelineLookup,
              _timelineLookup,
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

  /// Create a copy of DiscoursePostListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscoursePostListResponseImplCopyWith<_$DiscoursePostListResponseImpl>
  get copyWith =>
      __$$DiscoursePostListResponseImplCopyWithImpl<
        _$DiscoursePostListResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscoursePostListResponseImplToJson(this);
  }
}

abstract class _DiscoursePostListResponse implements DiscoursePostListResponse {
  const factory _DiscoursePostListResponse({
    @JsonKey(name: 'post_stream') final DiscoursePostStream? postStream,
    @JsonKey(name: 'timeline_lookup') final List<List<dynamic>> timelineLookup,
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
  }) = _$DiscoursePostListResponseImpl;

  factory _DiscoursePostListResponse.fromJson(Map<String, dynamic> json) =
      _$DiscoursePostListResponseImpl.fromJson;

  @override
  @JsonKey(name: 'post_stream')
  DiscoursePostStream? get postStream;
  @override
  @JsonKey(name: 'timeline_lookup')
  List<List<dynamic>> get timelineLookup;
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

  /// Create a copy of DiscoursePostListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DiscoursePostListResponseImplCopyWith<_$DiscoursePostListResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}
