import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../config/constants.dart';
import '../../core/network/discourse_api_service.dart';
import '../../core/utils/html_text_util.dart';

part 'bookmark_repository.g.dart';

/// 收藏操作结果
class BookmarkResult {
  final bool success;
  final String? errorMessage;
  final int? bookmarkId;
  final String? bookmarkableType;
  final int? bookmarkableId;

  BookmarkResult({
    required this.success,
    this.errorMessage,
    this.bookmarkId,
    this.bookmarkableType,
    this.bookmarkableId,
  });

  factory BookmarkResult.success({
    int? bookmarkId,
    String? bookmarkableType,
    int? bookmarkableId,
  }) {
    return BookmarkResult(
      success: true,
      bookmarkId: bookmarkId,
      bookmarkableType: bookmarkableType,
      bookmarkableId: bookmarkableId,
    );
  }

  factory BookmarkResult.failure(String message) {
    return BookmarkResult(success: false, errorMessage: message);
  }
}

/// 书签/收藏仓库
/// 负责处理话题收藏相关的数据操作
@riverpod
BookmarkRepository bookmarkRepository(Ref ref) {
  final discourseApi = ref.read(discourseApiServiceProvider);
  return BookmarkRepository(discourseApi);
}

/// 书签/收藏仓库类
class BookmarkRepository {
  final DiscourseApiService _discourseApi;

  BookmarkRepository(this._discourseApi);

  /// 添加话题到书签
  ///
  /// [topicId] 话题ID
  /// [reminderAt] 提醒时间（可选，ISO8601格式）
  /// 返回收藏操作结果
  Future<BookmarkResult> createBookmark({
    required int topicId,
    String? reminderAt,
  }) async {
    try {
      final response = await _discourseApi.createBookmark(
        topicId: topicId,
        reminderAt: reminderAt,
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>?;
        // 处理 id 可能是字符串或整数的情况
        final idValue = data?['id'];
        int? bookmarkId;
        if (idValue is int) {
          bookmarkId = idValue;
        } else if (idValue is String) {
          bookmarkId = int.tryParse(idValue);
        }

        return BookmarkResult.success(
          bookmarkId: bookmarkId,
          bookmarkableType: 'Topic',
          bookmarkableId: topicId,
        );
      } else if (response.statusCode == 403) {
        return BookmarkResult.failure('权限不足或会话已过期，请重新登录');
      } else if (response.statusCode == 422) {
        final errors = response.data?['errors'];
        if (errors != null && errors is List && errors.isNotEmpty) {
          return BookmarkResult.failure(errors.first.toString());
        }
        return BookmarkResult.failure('请求参数错误');
      } else {
        return BookmarkResult.failure('收藏失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return BookmarkResult.failure('收藏时发生错误: $e');
    }
  }

  /// 删除书签
  ///
  /// [bookmarkId] 书签ID
  /// 返回删除操作结果
  Future<BookmarkResult> deleteBookmark(int bookmarkId) async {
    try {
      final response = await _discourseApi.deleteBookmark(bookmarkId);

      if (response.statusCode == 200) {
        return BookmarkResult.success(bookmarkId: bookmarkId);
      } else if (response.statusCode == 403) {
        return BookmarkResult.failure('权限不足或会话已过期，请重新登录');
      } else if (response.statusCode == 404) {
        return BookmarkResult.failure('书签不存在或已被删除');
      } else {
        return BookmarkResult.failure('取消收藏失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return BookmarkResult.failure('取消收藏时发生错误: $e');
    }
  }

  /// 获取当前用户的书签列表
  ///
  /// [page] 页码，从0开始
  /// 返回包含书签列表的响应
  Future<Response> getUserBookmarks({int page = 0}) async {
    return _discourseApi.getUserBookmarks(page: page);
  }

  /// 获取论坛书签话题列表（已解析）
  Future<BookmarkTopicPageResult> getBookmarkedTopics({int page = 0}) async {
    final response = await getUserBookmarks(page: page);
    if (response.statusCode != 200) {
      return const BookmarkTopicPageResult(items: [], hasMore: false);
    }

    final items = _extractBookmarkTopics(response.data);
    final hasMore = _extractHasMore(response.data, itemCount: items.length);
    return BookmarkTopicPageResult(items: items, hasMore: hasMore);
  }

  /// 查找指定话题对应的书签ID
  ///
  /// 某些场景只有“已收藏”布尔态，没有书签ID，需要先反查再删除。
  Future<int?> findBookmarkIdByTopicId(int topicId) async {
    try {
      final response = await getUserBookmarks(page: 0);
      if (response.statusCode != 200) return null;
      return _extractBookmarkIdFromPayload(response.data, topicId);
    } catch (_) {
      return null;
    }
  }

  /// 更新书签提醒时间
  ///
  /// [bookmarkId] 书签ID
  /// [reminderAt] 新的提醒时间（ISO8601格式），传空字符串可清除提醒
  /// 返回更新操作结果
  Future<BookmarkResult> updateBookmarkReminder({
    required int bookmarkId,
    String? reminderAt,
  }) async {
    try {
      final response = await _discourseApi.updateBookmarkReminder(
        bookmarkId: bookmarkId,
        reminderAt: reminderAt,
      );

      if (response.statusCode == 200) {
        return BookmarkResult.success(bookmarkId: bookmarkId);
      } else if (response.statusCode == 403) {
        return BookmarkResult.failure('权限不足或会话已过期，请重新登录');
      } else if (response.statusCode == 404) {
        return BookmarkResult.failure('书签不存在');
      } else {
        return BookmarkResult.failure('更新提醒失败: HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return BookmarkResult.failure('更新提醒时发生错误: $e');
    }
  }

  /// 处理 Dio 错误
  BookmarkResult _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return BookmarkResult.failure('网络连接超时，请检查网络后重试');
      case DioExceptionType.connectionError:
        return BookmarkResult.failure('网络连接失败，请检查网络设置');
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final data = e.response?.data as Map<String, dynamic>?;

        if (statusCode == 401) {
          return BookmarkResult.failure('未登录或登录已过期，请重新登录');
        } else if (statusCode == 403) {
          return BookmarkResult.failure('权限验证失败，请刷新页面后重试');
        } else if (statusCode == 422) {
          final errors = data?['errors'];
          if (errors != null && errors is List && errors.isNotEmpty) {
            return BookmarkResult.failure(errors.first.toString());
          }
          return BookmarkResult.failure('请求参数验证失败');
        } else {
          return BookmarkResult.failure('服务器错误: HTTP $statusCode');
        }
      case DioExceptionType.cancel:
        return BookmarkResult.failure('请求已取消');
      default:
        return BookmarkResult.failure('网络请求失败: ${e.message}');
    }
  }

  int? _extractBookmarkIdFromPayload(dynamic payload, int topicId) {
    final maps = <Map<dynamic, dynamic>>[];

    void walk(dynamic node) {
      if (node is Map) {
        maps.add(node);
        node.forEach((_, value) => walk(value));
      } else if (node is List) {
        for (final item in node) {
          walk(item);
        }
      }
    }

    walk(payload);

    int? toInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    for (final map in maps) {
      final bookmarkableId = toInt(map['bookmarkable_id']);
      final topicIdInNode = toInt(map['topic_id']);
      final candidateTopicId = bookmarkableId ?? topicIdInNode;
      if (candidateTopicId != topicId) continue;

      final bookmarkId = toInt(map['id']) ?? toInt(map['bookmark_id']);
      if (bookmarkId != null) return bookmarkId;
    }

    return null;
  }

  List<BookmarkTopicItem> _extractBookmarkTopics(dynamic payload) {
    final maps = <Map<dynamic, dynamic>>[];
    final resultByTopic = <int, BookmarkTopicItem>{};

    void walk(dynamic node) {
      if (node is Map) {
        maps.add(node);
        node.forEach((_, value) => walk(value));
      } else if (node is List) {
        for (final item in node) {
          walk(item);
        }
      }
    }

    walk(payload);

    for (final map in maps) {
      final parsed = _parseBookmarkTopic(map);
      if (parsed == null) continue;
      final existing = resultByTopic[parsed.topicId];
      if (existing == null) {
        resultByTopic[parsed.topicId] = parsed;
      } else {
        resultByTopic[parsed.topicId] = _mergeBookmarkTopic(existing, parsed);
      }
    }

    return resultByTopic.values.toList();
  }

  BookmarkTopicItem? _parseBookmarkTopic(Map<dynamic, dynamic> map) {
    int? toInt(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value);
      return null;
    }

    String? toStringOrNull(dynamic value) {
      if (value == null) return null;
      final text = value.toString().trim();
      return text.isEmpty ? null : text;
    }

    Map<dynamic, dynamic>? toMap(dynamic value) {
      if (value is Map<dynamic, dynamic>) return value;
      return null;
    }

    final nestedTopic = toMap(map['topic']);
    final nestedUser = toMap(map['user']) ?? toMap(map['last_poster']);
    final bookmarkableType = toStringOrNull(map['bookmarkable_type']);

    final topicId =
        toInt(map['bookmarkable_id']) ??
        toInt(map['topic_id']) ??
        toInt(nestedTopic?['id']);
    if (topicId == null || topicId <= 0) {
      return null;
    }

    if (bookmarkableType != null &&
        bookmarkableType.isNotEmpty &&
        bookmarkableType.toLowerCase() != 'topic') {
      return null;
    }

    final title =
        toStringOrNull(map['topic_title']) ??
        toStringOrNull(map['fancy_title']) ??
        toStringOrNull(map['title']) ??
        toStringOrNull(nestedTopic?['fancy_title']) ??
        toStringOrNull(nestedTopic?['title']) ??
        '';

    final excerpt = _stripHtml(
      toStringOrNull(map['excerpt']) ??
          toStringOrNull(map['topic_excerpt']) ??
          toStringOrNull(nestedTopic?['excerpt']) ??
          '',
    );

    final username =
        toStringOrNull(map['username']) ??
        toStringOrNull(map['last_poster_username']) ??
        toStringOrNull(nestedUser?['username']) ??
        toStringOrNull(nestedTopic?['last_poster_username']);

    final avatarTemplate =
        toStringOrNull(map['avatar_template']) ??
        toStringOrNull(map['last_poster_avatar_template']) ??
        toStringOrNull(nestedUser?['avatar_template']);

    final bookmarkId = toInt(map['bookmark_id']) ?? toInt(map['id']);
    final createdAt =
        toStringOrNull(map['bookmarked_at']) ??
        toStringOrNull(map['created_at']) ??
        toStringOrNull(map['last_posted_at']) ??
        toStringOrNull(nestedTopic?['last_posted_at']);
    final bookmarkedAt =
        toStringOrNull(map['bookmarked_at']) ??
        toStringOrNull(map['created_at']);
    final lastPostedAt =
        toStringOrNull(map['last_posted_at']) ??
        toStringOrNull(nestedTopic?['last_posted_at']);

    final likeCount =
        toInt(map['like_count']) ??
        toInt(map['op_like_count']) ??
        toInt(nestedTopic?['like_count']) ??
        0;

    final replyCount =
        toInt(map['reply_count']) ?? toInt(nestedTopic?['reply_count']) ?? 0;

    return BookmarkTopicItem(
      topicId: topicId,
      bookmarkId: bookmarkId,
      title: title,
      excerpt: excerpt,
      username: username,
      avatarTemplate: avatarTemplate,
      createdAt: createdAt,
      bookmarkedAt: bookmarkedAt,
      lastPostedAt: lastPostedAt,
      likeCount: likeCount,
      replyCount: replyCount,
    );
  }

  BookmarkTopicItem _mergeBookmarkTopic(
    BookmarkTopicItem current,
    BookmarkTopicItem incoming,
  ) {
    String pickString(String a, String b) => a.trim().isNotEmpty ? a : b;
    String? pickNullable(String? a, String? b) {
      if (a != null && a.trim().isNotEmpty) return a;
      if (b != null && b.trim().isNotEmpty) return b;
      return null;
    }

    return BookmarkTopicItem(
      topicId: current.topicId,
      bookmarkId: current.bookmarkId ?? incoming.bookmarkId,
      title: pickString(current.title, incoming.title),
      excerpt: pickString(current.excerpt, incoming.excerpt),
      username: pickNullable(current.username, incoming.username),
      avatarTemplate: pickNullable(
        current.avatarTemplate,
        incoming.avatarTemplate,
      ),
      createdAt: pickNullable(current.createdAt, incoming.createdAt),
      bookmarkedAt: pickNullable(current.bookmarkedAt, incoming.bookmarkedAt),
      lastPostedAt: pickNullable(current.lastPostedAt, incoming.lastPostedAt),
      likeCount: current.likeCount > 0 ? current.likeCount : incoming.likeCount,
      replyCount: current.replyCount > 0
          ? current.replyCount
          : incoming.replyCount,
    );
  }

  bool _extractHasMore(dynamic payload, {required int itemCount}) {
    if (payload is Map<dynamic, dynamic>) {
      final candidates = [
        payload['has_more'],
        payload['more'],
        payload['load_more_bookmarks'],
        payload['can_load_more'],
      ];
      for (final value in candidates) {
        if (value is bool) return value;
      }
    }
    return itemCount >= AppConstants.pageSize;
  }

  String _stripHtml(String raw) {
    if (raw.isEmpty) return '';
    return HtmlTextUtil.stripHtml(
      raw,
      tagReplacement: ' ',
      collapseWhitespace: true,
    );
  }
}

class BookmarkTopicItem {
  final int topicId;
  final int? bookmarkId;
  final String title;
  final String excerpt;
  final String? username;
  final String? avatarTemplate;
  final String? createdAt;
  final String? bookmarkedAt;
  final String? lastPostedAt;
  final int likeCount;
  final int replyCount;

  const BookmarkTopicItem({
    required this.topicId,
    this.bookmarkId,
    required this.title,
    required this.excerpt,
    this.username,
    this.avatarTemplate,
    this.createdAt,
    this.bookmarkedAt,
    this.lastPostedAt,
    this.likeCount = 0,
    this.replyCount = 0,
  });
}

class BookmarkTopicPageResult {
  final List<BookmarkTopicItem> items;
  final bool hasMore;

  const BookmarkTopicPageResult({required this.items, required this.hasMore});
}
