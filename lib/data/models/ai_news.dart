import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_news.freezed.dart';
part 'ai_news.g.dart';

/// AI快讯数据模型
///
/// 用于存储和展示AI相关的新闻资讯
@freezed
class AINews with _$AINews {
  const factory AINews({
    /// 新闻ID
    required String id,

    /// 新闻标题
    required String title,

    /// 新闻内容/摘要
    required String content,

    /// 来源网站
    required String source,

    /// 来源链接
    required String sourceUrl,

    /// 发布时间
    required String publishTime,

    /// 标签列表
    @Default([]) List<String> tags,

    /// 封面图片URL
    String? coverImage,

    /// 作者
    String? author,

    /// 浏览次数
    @Default(0) int viewCount,

    /// 是否热门
    @Default(false) bool isHot,
  }) = _AINews;

  factory AINews.fromJson(Map<String, dynamic> json) =>
      _$AINewsFromJson(json);
}

/// AI快讯列表响应模型
@freezed
class AINewsResponse with _$AINewsResponse {
  const factory AINewsResponse({
    /// 新闻列表
    required List<AINews> newsList,

    /// 是否有更多数据
    @Default(false) bool hasMore,

    /// 当前页码
    @Default(1) int currentPage,

    /// 总页数
    @Default(1) int totalPages,
  }) = _AINewsResponse;

  factory AINewsResponse.fromJson(Map<String, dynamic> json) =>
      _$AINewsResponseFromJson(json);
}
