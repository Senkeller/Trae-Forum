// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AINewsImpl _$$AINewsImplFromJson(Map<String, dynamic> json) => _$AINewsImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  source: json['source'] as String,
  sourceUrl: json['sourceUrl'] as String,
  publishTime: json['publishTime'] as String,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  category:
      $enumDecodeNullable(_$AINewsCategoryEnumMap, json['category']) ??
      AINewsCategory.other,
  coverImage: json['coverImage'] as String?,
  author: json['author'] as String?,
  viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
  likeCount: (json['likeCount'] as num?)?.toInt() ?? 0,
  commentCount: (json['commentCount'] as num?)?.toInt() ?? 0,
  isHot: json['isHot'] as bool? ?? false,
  isPinned: json['isPinned'] as bool? ?? false,
  isRead: json['isRead'] as bool? ?? false,
  isBookmarked: json['isBookmarked'] as bool? ?? false,
  summary: json['summary'] as String?,
  rawContent: json['rawContent'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$$AINewsImplToJson(_$AINewsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'source': instance.source,
      'sourceUrl': instance.sourceUrl,
      'publishTime': instance.publishTime,
      'tags': instance.tags,
      'category': _$AINewsCategoryEnumMap[instance.category]!,
      'coverImage': instance.coverImage,
      'author': instance.author,
      'viewCount': instance.viewCount,
      'likeCount': instance.likeCount,
      'commentCount': instance.commentCount,
      'isHot': instance.isHot,
      'isPinned': instance.isPinned,
      'isRead': instance.isRead,
      'isBookmarked': instance.isBookmarked,
      'summary': instance.summary,
      'rawContent': instance.rawContent,
      'updatedAt': instance.updatedAt,
    };

const _$AINewsCategoryEnumMap = {
  AINewsCategory.llm: 'llm',
  AINewsCategory.imageGeneration: 'imageGeneration',
  AINewsCategory.videoGeneration: 'videoGeneration',
  AINewsCategory.aiHardware: 'aiHardware',
  AINewsCategory.aiApplication: 'aiApplication',
  AINewsCategory.industryNews: 'industryNews',
  AINewsCategory.other: 'other',
};

_$AINewsResponseImpl _$$AINewsResponseImplFromJson(Map<String, dynamic> json) =>
    _$AINewsResponseImpl(
      newsList: (json['newsList'] as List<dynamic>)
          .map((e) => AINews.fromJson(e as Map<String, dynamic>))
          .toList(),
      hasMore: json['hasMore'] as bool? ?? false,
      currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$$AINewsResponseImplToJson(
  _$AINewsResponseImpl instance,
) => <String, dynamic>{
  'newsList': instance.newsList,
  'hasMore': instance.hasMore,
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
};
