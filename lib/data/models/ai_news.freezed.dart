// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_news.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AINews _$AINewsFromJson(Map<String, dynamic> json) {
  return _AINews.fromJson(json);
}

/// @nodoc
mixin _$AINews {
  /// 新闻ID
  String get id => throw _privateConstructorUsedError;

  /// 新闻标题
  String get title => throw _privateConstructorUsedError;

  /// 新闻内容/摘要
  String get content => throw _privateConstructorUsedError;

  /// 来源网站
  String get source => throw _privateConstructorUsedError;

  /// 来源链接
  String get sourceUrl => throw _privateConstructorUsedError;

  /// 发布时间
  String get publishTime => throw _privateConstructorUsedError;

  /// 标签列表
  List<String> get tags => throw _privateConstructorUsedError;

  /// 分类
  AINewsCategory get category => throw _privateConstructorUsedError;

  /// 封面图片URL
  String? get coverImage => throw _privateConstructorUsedError;

  /// 作者
  String? get author => throw _privateConstructorUsedError;

  /// 浏览次数
  int get viewCount => throw _privateConstructorUsedError;

  /// 点赞数
  int get likeCount => throw _privateConstructorUsedError;

  /// 评论数
  int get commentCount => throw _privateConstructorUsedError;

  /// 是否热门
  bool get isHot => throw _privateConstructorUsedError;

  /// 是否置顶
  bool get isPinned => throw _privateConstructorUsedError;

  /// 是否已读
  bool get isRead => throw _privateConstructorUsedError;

  /// 是否已收藏
  bool get isBookmarked => throw _privateConstructorUsedError;

  /// 摘要（比content更简短）
  String? get summary => throw _privateConstructorUsedError;

  /// 原始HTML内容（用于详情页）
  String? get rawContent => throw _privateConstructorUsedError;

  /// 最后更新时间
  String? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this AINews to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AINews
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AINewsCopyWith<AINews> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AINewsCopyWith<$Res> {
  factory $AINewsCopyWith(AINews value, $Res Function(AINews) then) =
      _$AINewsCopyWithImpl<$Res, AINews>;
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String source,
    String sourceUrl,
    String publishTime,
    List<String> tags,
    AINewsCategory category,
    String? coverImage,
    String? author,
    int viewCount,
    int likeCount,
    int commentCount,
    bool isHot,
    bool isPinned,
    bool isRead,
    bool isBookmarked,
    String? summary,
    String? rawContent,
    String? updatedAt,
  });
}

/// @nodoc
class _$AINewsCopyWithImpl<$Res, $Val extends AINews>
    implements $AINewsCopyWith<$Res> {
  _$AINewsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AINews
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? source = null,
    Object? sourceUrl = null,
    Object? publishTime = null,
    Object? tags = null,
    Object? category = null,
    Object? coverImage = freezed,
    Object? author = freezed,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? isHot = null,
    Object? isPinned = null,
    Object? isRead = null,
    Object? isBookmarked = null,
    Object? summary = freezed,
    Object? rawContent = freezed,
    Object? updatedAt = freezed,
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
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceUrl: null == sourceUrl
                ? _value.sourceUrl
                : sourceUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            publishTime: null == publishTime
                ? _value.publishTime
                : publishTime // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as AINewsCategory,
            coverImage: freezed == coverImage
                ? _value.coverImage
                : coverImage // ignore: cast_nullable_to_non_nullable
                      as String?,
            author: freezed == author
                ? _value.author
                : author // ignore: cast_nullable_to_non_nullable
                      as String?,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            likeCount: null == likeCount
                ? _value.likeCount
                : likeCount // ignore: cast_nullable_to_non_nullable
                      as int,
            commentCount: null == commentCount
                ? _value.commentCount
                : commentCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isHot: null == isHot
                ? _value.isHot
                : isHot // ignore: cast_nullable_to_non_nullable
                      as bool,
            isPinned: null == isPinned
                ? _value.isPinned
                : isPinned // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
            isBookmarked: null == isBookmarked
                ? _value.isBookmarked
                : isBookmarked // ignore: cast_nullable_to_non_nullable
                      as bool,
            summary: freezed == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String?,
            rawContent: freezed == rawContent
                ? _value.rawContent
                : rawContent // ignore: cast_nullable_to_non_nullable
                      as String?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AINewsImplCopyWith<$Res> implements $AINewsCopyWith<$Res> {
  factory _$$AINewsImplCopyWith(
    _$AINewsImpl value,
    $Res Function(_$AINewsImpl) then,
  ) = __$$AINewsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String source,
    String sourceUrl,
    String publishTime,
    List<String> tags,
    AINewsCategory category,
    String? coverImage,
    String? author,
    int viewCount,
    int likeCount,
    int commentCount,
    bool isHot,
    bool isPinned,
    bool isRead,
    bool isBookmarked,
    String? summary,
    String? rawContent,
    String? updatedAt,
  });
}

/// @nodoc
class __$$AINewsImplCopyWithImpl<$Res>
    extends _$AINewsCopyWithImpl<$Res, _$AINewsImpl>
    implements _$$AINewsImplCopyWith<$Res> {
  __$$AINewsImplCopyWithImpl(
    _$AINewsImpl _value,
    $Res Function(_$AINewsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AINews
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? source = null,
    Object? sourceUrl = null,
    Object? publishTime = null,
    Object? tags = null,
    Object? category = null,
    Object? coverImage = freezed,
    Object? author = freezed,
    Object? viewCount = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? isHot = null,
    Object? isPinned = null,
    Object? isRead = null,
    Object? isBookmarked = null,
    Object? summary = freezed,
    Object? rawContent = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$AINewsImpl(
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
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceUrl: null == sourceUrl
            ? _value.sourceUrl
            : sourceUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        publishTime: null == publishTime
            ? _value.publishTime
            : publishTime // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as AINewsCategory,
        coverImage: freezed == coverImage
            ? _value.coverImage
            : coverImage // ignore: cast_nullable_to_non_nullable
                  as String?,
        author: freezed == author
            ? _value.author
            : author // ignore: cast_nullable_to_non_nullable
                  as String?,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        likeCount: null == likeCount
            ? _value.likeCount
            : likeCount // ignore: cast_nullable_to_non_nullable
                  as int,
        commentCount: null == commentCount
            ? _value.commentCount
            : commentCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isHot: null == isHot
            ? _value.isHot
            : isHot // ignore: cast_nullable_to_non_nullable
                  as bool,
        isPinned: null == isPinned
            ? _value.isPinned
            : isPinned // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
        isBookmarked: null == isBookmarked
            ? _value.isBookmarked
            : isBookmarked // ignore: cast_nullable_to_non_nullable
                  as bool,
        summary: freezed == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String?,
        rawContent: freezed == rawContent
            ? _value.rawContent
            : rawContent // ignore: cast_nullable_to_non_nullable
                  as String?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AINewsImpl extends _AINews {
  const _$AINewsImpl({
    required this.id,
    required this.title,
    required this.content,
    required this.source,
    required this.sourceUrl,
    required this.publishTime,
    final List<String> tags = const [],
    this.category = AINewsCategory.other,
    this.coverImage,
    this.author,
    this.viewCount = 0,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isHot = false,
    this.isPinned = false,
    this.isRead = false,
    this.isBookmarked = false,
    this.summary,
    this.rawContent,
    this.updatedAt,
  }) : _tags = tags,
       super._();

  factory _$AINewsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AINewsImplFromJson(json);

  /// 新闻ID
  @override
  final String id;

  /// 新闻标题
  @override
  final String title;

  /// 新闻内容/摘要
  @override
  final String content;

  /// 来源网站
  @override
  final String source;

  /// 来源链接
  @override
  final String sourceUrl;

  /// 发布时间
  @override
  final String publishTime;

  /// 标签列表
  final List<String> _tags;

  /// 标签列表
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// 分类
  @override
  @JsonKey()
  final AINewsCategory category;

  /// 封面图片URL
  @override
  final String? coverImage;

  /// 作者
  @override
  final String? author;

  /// 浏览次数
  @override
  @JsonKey()
  final int viewCount;

  /// 点赞数
  @override
  @JsonKey()
  final int likeCount;

  /// 评论数
  @override
  @JsonKey()
  final int commentCount;

  /// 是否热门
  @override
  @JsonKey()
  final bool isHot;

  /// 是否置顶
  @override
  @JsonKey()
  final bool isPinned;

  /// 是否已读
  @override
  @JsonKey()
  final bool isRead;

  /// 是否已收藏
  @override
  @JsonKey()
  final bool isBookmarked;

  /// 摘要（比content更简短）
  @override
  final String? summary;

  /// 原始HTML内容（用于详情页）
  @override
  final String? rawContent;

  /// 最后更新时间
  @override
  final String? updatedAt;

  @override
  String toString() {
    return 'AINews(id: $id, title: $title, content: $content, source: $source, sourceUrl: $sourceUrl, publishTime: $publishTime, tags: $tags, category: $category, coverImage: $coverImage, author: $author, viewCount: $viewCount, likeCount: $likeCount, commentCount: $commentCount, isHot: $isHot, isPinned: $isPinned, isRead: $isRead, isBookmarked: $isBookmarked, summary: $summary, rawContent: $rawContent, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AINewsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.publishTime, publishTime) ||
                other.publishTime == publishTime) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            (identical(other.isHot, isHot) || other.isHot == isHot) &&
            (identical(other.isPinned, isPinned) ||
                other.isPinned == isPinned) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isBookmarked, isBookmarked) ||
                other.isBookmarked == isBookmarked) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.rawContent, rawContent) ||
                other.rawContent == rawContent) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    title,
    content,
    source,
    sourceUrl,
    publishTime,
    const DeepCollectionEquality().hash(_tags),
    category,
    coverImage,
    author,
    viewCount,
    likeCount,
    commentCount,
    isHot,
    isPinned,
    isRead,
    isBookmarked,
    summary,
    rawContent,
    updatedAt,
  ]);

  /// Create a copy of AINews
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AINewsImplCopyWith<_$AINewsImpl> get copyWith =>
      __$$AINewsImplCopyWithImpl<_$AINewsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AINewsImplToJson(this);
  }
}

abstract class _AINews extends AINews {
  const factory _AINews({
    required final String id,
    required final String title,
    required final String content,
    required final String source,
    required final String sourceUrl,
    required final String publishTime,
    final List<String> tags,
    final AINewsCategory category,
    final String? coverImage,
    final String? author,
    final int viewCount,
    final int likeCount,
    final int commentCount,
    final bool isHot,
    final bool isPinned,
    final bool isRead,
    final bool isBookmarked,
    final String? summary,
    final String? rawContent,
    final String? updatedAt,
  }) = _$AINewsImpl;
  const _AINews._() : super._();

  factory _AINews.fromJson(Map<String, dynamic> json) = _$AINewsImpl.fromJson;

  /// 新闻ID
  @override
  String get id;

  /// 新闻标题
  @override
  String get title;

  /// 新闻内容/摘要
  @override
  String get content;

  /// 来源网站
  @override
  String get source;

  /// 来源链接
  @override
  String get sourceUrl;

  /// 发布时间
  @override
  String get publishTime;

  /// 标签列表
  @override
  List<String> get tags;

  /// 分类
  @override
  AINewsCategory get category;

  /// 封面图片URL
  @override
  String? get coverImage;

  /// 作者
  @override
  String? get author;

  /// 浏览次数
  @override
  int get viewCount;

  /// 点赞数
  @override
  int get likeCount;

  /// 评论数
  @override
  int get commentCount;

  /// 是否热门
  @override
  bool get isHot;

  /// 是否置顶
  @override
  bool get isPinned;

  /// 是否已读
  @override
  bool get isRead;

  /// 是否已收藏
  @override
  bool get isBookmarked;

  /// 摘要（比content更简短）
  @override
  String? get summary;

  /// 原始HTML内容（用于详情页）
  @override
  String? get rawContent;

  /// 最后更新时间
  @override
  String? get updatedAt;

  /// Create a copy of AINews
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AINewsImplCopyWith<_$AINewsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AINewsResponse _$AINewsResponseFromJson(Map<String, dynamic> json) {
  return _AINewsResponse.fromJson(json);
}

/// @nodoc
mixin _$AINewsResponse {
  /// 新闻列表
  List<AINews> get newsList => throw _privateConstructorUsedError;

  /// 是否有更多数据
  bool get hasMore => throw _privateConstructorUsedError;

  /// 当前页码
  int get currentPage => throw _privateConstructorUsedError;

  /// 总页数
  int get totalPages => throw _privateConstructorUsedError;

  /// Serializes this AINewsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AINewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AINewsResponseCopyWith<AINewsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AINewsResponseCopyWith<$Res> {
  factory $AINewsResponseCopyWith(
    AINewsResponse value,
    $Res Function(AINewsResponse) then,
  ) = _$AINewsResponseCopyWithImpl<$Res, AINewsResponse>;
  @useResult
  $Res call({
    List<AINews> newsList,
    bool hasMore,
    int currentPage,
    int totalPages,
  });
}

/// @nodoc
class _$AINewsResponseCopyWithImpl<$Res, $Val extends AINewsResponse>
    implements $AINewsResponseCopyWith<$Res> {
  _$AINewsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AINewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsList = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? totalPages = null,
  }) {
    return _then(
      _value.copyWith(
            newsList: null == newsList
                ? _value.newsList
                : newsList // ignore: cast_nullable_to_non_nullable
                      as List<AINews>,
            hasMore: null == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool,
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AINewsResponseImplCopyWith<$Res>
    implements $AINewsResponseCopyWith<$Res> {
  factory _$$AINewsResponseImplCopyWith(
    _$AINewsResponseImpl value,
    $Res Function(_$AINewsResponseImpl) then,
  ) = __$$AINewsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<AINews> newsList,
    bool hasMore,
    int currentPage,
    int totalPages,
  });
}

/// @nodoc
class __$$AINewsResponseImplCopyWithImpl<$Res>
    extends _$AINewsResponseCopyWithImpl<$Res, _$AINewsResponseImpl>
    implements _$$AINewsResponseImplCopyWith<$Res> {
  __$$AINewsResponseImplCopyWithImpl(
    _$AINewsResponseImpl _value,
    $Res Function(_$AINewsResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AINewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? newsList = null,
    Object? hasMore = null,
    Object? currentPage = null,
    Object? totalPages = null,
  }) {
    return _then(
      _$AINewsResponseImpl(
        newsList: null == newsList
            ? _value._newsList
            : newsList // ignore: cast_nullable_to_non_nullable
                  as List<AINews>,
        hasMore: null == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool,
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AINewsResponseImpl implements _AINewsResponse {
  const _$AINewsResponseImpl({
    required final List<AINews> newsList,
    this.hasMore = false,
    this.currentPage = 1,
    this.totalPages = 1,
  }) : _newsList = newsList;

  factory _$AINewsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AINewsResponseImplFromJson(json);

  /// 新闻列表
  final List<AINews> _newsList;

  /// 新闻列表
  @override
  List<AINews> get newsList {
    if (_newsList is EqualUnmodifiableListView) return _newsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_newsList);
  }

  /// 是否有更多数据
  @override
  @JsonKey()
  final bool hasMore;

  /// 当前页码
  @override
  @JsonKey()
  final int currentPage;

  /// 总页数
  @override
  @JsonKey()
  final int totalPages;

  @override
  String toString() {
    return 'AINewsResponse(newsList: $newsList, hasMore: $hasMore, currentPage: $currentPage, totalPages: $totalPages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AINewsResponseImpl &&
            const DeepCollectionEquality().equals(other._newsList, _newsList) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_newsList),
    hasMore,
    currentPage,
    totalPages,
  );

  /// Create a copy of AINewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AINewsResponseImplCopyWith<_$AINewsResponseImpl> get copyWith =>
      __$$AINewsResponseImplCopyWithImpl<_$AINewsResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AINewsResponseImplToJson(this);
  }
}

abstract class _AINewsResponse implements AINewsResponse {
  const factory _AINewsResponse({
    required final List<AINews> newsList,
    final bool hasMore,
    final int currentPage,
    final int totalPages,
  }) = _$AINewsResponseImpl;

  factory _AINewsResponse.fromJson(Map<String, dynamic> json) =
      _$AINewsResponseImpl.fromJson;

  /// 新闻列表
  @override
  List<AINews> get newsList;

  /// 是否有更多数据
  @override
  bool get hasMore;

  /// 当前页码
  @override
  int get currentPage;

  /// 总页数
  @override
  int get totalPages;

  /// Create a copy of AINewsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AINewsResponseImplCopyWith<_$AINewsResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
