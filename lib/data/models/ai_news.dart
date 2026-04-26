import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_news.freezed.dart';
part 'ai_news.g.dart';

/// AI快讯分类枚举
enum AINewsCategory {
  /// 大模型
  llm,
  /// 图像生成
  imageGeneration,
  /// 视频生成
  videoGeneration,
  /// AI硬件
  aiHardware,
  /// AI应用
  aiApplication,
  /// 行业动态
  industryNews,
  /// 其他
  other,
}

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

    /// 分类
    @Default(AINewsCategory.other) AINewsCategory category,

    /// 封面图片URL
    String? coverImage,

    /// 作者
    String? author,

    /// 浏览次数
    @Default(0) int viewCount,

    /// 点赞数
    @Default(0) int likeCount,

    /// 评论数
    @Default(0) int commentCount,

    /// 是否热门
    @Default(false) bool isHot,

    /// 是否置顶
    @Default(false) bool isPinned,

    /// 是否已读
    @Default(false) bool isRead,

    /// 是否已收藏
    @Default(false) bool isBookmarked,

    /// 摘要（比content更简短）
    String? summary,

    /// 原始HTML内容（用于详情页）
    String? rawContent,

    /// 最后更新时间
    String? updatedAt,
  }) = _AINews;

  const AINews._();

  factory AINews.fromJson(Map<String, dynamic> json) =>
      _$AINewsFromJson(json);

  /// 获取格式化的发布时间
  String get formattedTime {
    if (publishTime.isEmpty) return '';
    try {
      final dateTime = DateTime.parse(publishTime);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) return '刚刚';
      if (difference.inHours < 1) return '${difference.inMinutes}分钟前';
      if (difference.inDays < 1) return '${difference.inHours}小时前';
      if (difference.inDays < 7) return '${difference.inDays}天前';
      return '${dateTime.month}月${dateTime.day}日';
    } catch (_) {
      return publishTime;
    }
  }

  /// 获取格式化的浏览量
  String get formattedViewCount {
    if (viewCount >= 10000) {
      return '${(viewCount / 10000).toStringAsFixed(1)}万';
    } else if (viewCount >= 1000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}k';
    }
    return viewCount.toString();
  }

  /// 获取主标签（第一个标签或根据分类）
  String get primaryTag {
    if (tags.isNotEmpty) return tags.first;
    return category.name;
  }

  /// 获取分类显示名称
  String get categoryDisplayName {
    switch (category) {
      case AINewsCategory.llm:
        return '大模型';
      case AINewsCategory.imageGeneration:
        return '图像生成';
      case AINewsCategory.videoGeneration:
        return '视频生成';
      case AINewsCategory.aiHardware:
        return 'AI硬件';
      case AINewsCategory.aiApplication:
        return 'AI应用';
      case AINewsCategory.industryNews:
        return '行业动态';
      case AINewsCategory.other:
        return '其他';
    }
  }

  /// 获取分类颜色
  Color get categoryColor {
    switch (category) {
      case AINewsCategory.llm:
        return const Color(0xFF6366F1);
      case AINewsCategory.imageGeneration:
        return const Color(0xFFEC4899);
      case AINewsCategory.videoGeneration:
        return const Color(0xFFF59E0B);
      case AINewsCategory.aiHardware:
        return const Color(0xFF10B981);
      case AINewsCategory.aiApplication:
        return const Color(0xFF3B82F6);
      case AINewsCategory.industryNews:
        return const Color(0xFF8B5CF6);
      case AINewsCategory.other:
        return const Color(0xFF6B7280);
    }
  }
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
