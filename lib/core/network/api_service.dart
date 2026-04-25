import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/feed.dart';
import '../../data/models/comment.dart';
import '../../data/models/user.dart';
import '../../data/adapters/discourse_adapter.dart';
import '../../data/models/discourse/discourse_topic.dart';
import 'discourse_api_service.dart';

part 'api_service.g.dart';

@riverpod
class ApiService extends _$ApiService {
  late final DiscourseApiService _discourseApi;

  @override
  ApiService build() {
    _discourseApi = ref.read(discourseApiServiceProvider);
    return this;
  }

  // ==================== 首页 Feed (Discourse) ====================

  /// 获取首页 Feed 列表
  ///
  /// 调用 Discourse /latest.json API
  Future<HomeFeedResponse> getHomeFeed({
    required int page,
    int firstLaunch = 0,
    required String installTime,
    String? firstItem,
    String? lastItem,
    String ids = '',
  }) async {
    try {
      final discourseResponse = await _discourseApi.getLatestTopics(page: page);
      final Map<String, dynamic> data = discourseResponse.data;

      final topicListMap = data['topic_list'] as Map<String, dynamic>?;
      final topics = topicListMap?['topics'] as List<dynamic>? ?? [];
      final users = data['users'] as List<dynamic>? ?? [];

      final feeds = _adaptTopicsToFeeds(topics, users);

      return HomeFeedResponse(
        status: 200,
        message: 'success',
        data: feeds,
        total: feeds.length,
      );
    } catch (e) {
      return HomeFeedResponse(
        status: 500,
        message: 'Failed to fetch home feed: $e',
        data: [],
      );
    }
  }

  /// 获取热门 Feed 列表
  ///
  /// 调用 Discourse /hot.json API
  Future<HomeFeedResponse> getHotFeed({required int page}) async {
    try {
      final discourseResponse = await _discourseApi.getHotTopics(page: page);
      final Map<String, dynamic> data = discourseResponse.data;

      final topicListMap = data['topic_list'] as Map<String, dynamic>?;
      final topics = topicListMap?['topics'] as List<dynamic>? ?? [];
      final users = data['users'] as List<dynamic>? ?? [];

      final feeds = _adaptTopicsToFeeds(topics, users);

      return HomeFeedResponse(
        status: 200,
        message: 'success',
        data: feeds,
        total: feeds.length,
      );
    } catch (e) {
      return HomeFeedResponse(
        status: 500,
        message: 'Failed to fetch hot feed: $e',
        data: [],
      );
    }
  }

  /// 获取排行 Feed 列表
  ///
  /// 调用 Discourse /top.json API
  Future<HomeFeedResponse> getTopFeed({required int page}) async {
    try {
      final discourseResponse = await _discourseApi.getTopTopics(page: page);
      final Map<String, dynamic> data = discourseResponse.data;

      final topicListMap = data['topic_list'] as Map<String, dynamic>?;
      final topics = topicListMap?['topics'] as List<dynamic>? ?? [];
      final users = data['users'] as List<dynamic>? ?? [];

      final feeds = _adaptTopicsToFeeds(topics, users);

      return HomeFeedResponse(
        status: 200,
        message: 'success',
        data: feeds,
        total: feeds.length,
      );
    } catch (e) {
      return HomeFeedResponse(
        status: 500,
        message: 'Failed to fetch top feed: $e',
        data: [],
      );
    }
  }

  /// 获取分类 Feed 列表
  ///
  /// 调用 Discourse /c/{category_id}.json API
  Future<HomeFeedResponse> getCategoryFeed({
    required int categoryId,
    required int page,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getTopicsByCategory(
        categoryId,
        page: page,
      );
      final Map<String, dynamic> data = discourseResponse.data;

      final topicListMap = data['topic_list'] as Map<String, dynamic>?;
      final topics = topicListMap?['topics'] as List<dynamic>? ?? [];
      final users = data['users'] as List<dynamic>? ?? [];

      final feeds = _adaptTopicsToFeeds(topics, users);

      return HomeFeedResponse(
        status: 200,
        message: 'success',
        data: feeds,
        total: feeds.length,
      );
    } catch (e) {
      return HomeFeedResponse(
        status: 500,
        message: 'Failed to fetch category feed: $e',
        data: [],
      );
    }
  }

  List<HomeFeedData> _adaptTopicsToFeeds(
    List<dynamic> topics,
    List<dynamic> users,
  ) {
    final userList = users.map((u) {
      final map = u as Map<String, dynamic>;
      return DiscourseUserBasic(
        id: map['id'] ?? 0,
        username: map['username'] ?? '',
        name: map['name'],
        avatarTemplate: map['avatar_template'] ?? '',
        trustLevel: map['trust_level'],
      );
    }).toList();

    return topics.map((topic) {
      final map = topic as Map<String, dynamic>;
      final posters = map['posters'] as List<dynamic>? ?? [];

      final topicModel = DiscourseTopic(
        id: map['id'] ?? 0,
        title: map['title'] ?? '',
        slug: map['slug'] ?? '',
        categoryId: map['category_id'] ?? 0,
        createdAt: map['created_at'] ?? '',
        lastPostedAt: map['last_posted_at'],
        postsCount: map['posts_count'] ?? 0,
        replyCount: map['reply_count'] ?? 0,
        views: map['views'] ?? 0,
        likeCount: map['like_count'] ?? 0,
        excerpt: map['excerpt'],
        imageUrl: map['image_url'],
        pinned: map['pinned'] ?? false,
        visible: map['visible'] ?? true,
        closed: map['closed'] ?? false,
        archived: map['archived'] ?? false,
        tags: (map['tags'] as List<dynamic>?)?.cast<String>() ?? [],
        posters: posters.map((p) {
          final posterMap = p as Map<String, dynamic>;
          return DiscoursePoster(
            userId: posterMap['user_id'] ?? 0,
            extras: posterMap['extras'],
            description: posterMap['description'],
          );
        }).toList(),
      );

      return TopicAdapter.adaptTopicToFeed(topicModel, userList);
    }).toList();
  }

  // ==================== 动态详情 (Discourse) ====================

  /// 获取动态详情
  ///
  /// 调用 Discourse /t/{id}.json API
  Future<FeedContentResponse> getFeedContent({
    required String id,
    String? rid,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getTopicDetail(
        int.parse(id),
      );
      final Map<String, dynamic> data = discourseResponse.data;

      final postStreamMap = data['post_stream'] as Map<String, dynamic>?;
      final posts = postStreamMap?['posts'] as List<dynamic>? ?? [];

      if (posts.isEmpty) {
        return FeedContentResponse(status: 200, message: 'success', data: null);
      }

      final firstPost = posts.first as Map<String, dynamic>;
      final userInfo = _adaptUserInfo(firstPost);

      final feedData = FeedContentData(
        id: data['id']?.toString() ?? '0',
        entityType: 'feed',
        title: data['title'] ?? '',
        message: DiscourseAdapter.processHtmlContent(firstPost['cooked'] ?? ''),
        picArr: [],
        userInfo: userInfo,
        dateline: DiscourseAdapter.parseIso8601ToTimestamp(
          data['created_at'] ?? '',
        ).toString(),
        replyNum: data['reply_count'] ?? 0,
        forwardNum: 0,
        isTop: data['pinned'] ?? false,
      );

      return FeedContentResponse(
        status: 200,
        message: 'success',
        data: feedData,
      );
    } catch (e) {
      return FeedContentResponse(
        status: 500,
        message: 'Failed to fetch feed content: $e',
      );
    }
  }

  UserInfo _adaptUserInfo(Map<String, dynamic> post) {
    return UserInfo(
      uid: post['user_id']?.toString() ?? '0',
      username: post['username'] ?? '',
      avatar: DiscourseAdapter.formatAvatarUrl(
        post['avatar_template'] ?? '',
        post['username'] ?? '',
      ),
      level: post['trust_level'] ?? 1,
    );
  }

  // ==================== 评论列表 (Discourse) ====================

  /// 获取评论列表
  ///
  /// 调用 Discourse /t/{id}/posts.json API
  Future<TotalReplyResponse> getFeedContentReply({
    required String id,
    String listType = '',
    required int page,
    String? firstItem,
    String? lastItem,
    int discussMode = 0,
    String feedType = 'feed',
    int blockStatus = 0,
    int fromFeedAuthor = 0,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getTopicPosts(
        int.parse(id),
        page: page,
      );
      final Map<String, dynamic> data = discourseResponse.data;

      final posts = data['post_stream']?['posts'] as List<dynamic>? ?? [];
      final replies = _adaptPostsToReplies(posts, id);

      return TotalReplyResponse(
        status: 200,
        message: 'success',
        data: replies,
        total: replies.length,
      );
    } catch (e) {
      return TotalReplyResponse(
        status: 500,
        message: 'Failed to fetch replies: $e',
        data: [],
      );
    }
  }

  List<ReplyData> _adaptPostsToReplies(List<dynamic> posts, String topicId) {
    return posts.map((post) {
      final map = post as Map<String, dynamic>;
      return ReplyData(
        id: map['id']?.toString() ?? '0',
        uid: map['user_id']?.toString() ?? '0',
        username: map['username'] ?? '',
        avatar: DiscourseAdapter.formatAvatarUrl(
          map['avatar_template'] ?? '',
          map['username'] ?? '',
        ),
        message: DiscourseAdapter.processHtmlContent(map['cooked'] ?? ''),
        dateline: DiscourseAdapter.parseIso8601ToTimestamp(
          map['created_at'] ?? '',
        ).toString(),
        likeNum: map['like_count'] ?? 0,
        replyNum: map['reply_count'] ?? 0,
        replyTo: map['reply_to_user']?['username'],
        replyUid: map['reply_to_user']?['user_id']?.toString(),
      );
    }).toList();
  }

  /// 获取楼中楼回复
  Future<TotalReplyResponse> getReply2Reply({
    required String id,
    required int page,
    String? lastItem,
  }) async {
    return getFeedContentReply(id: id, page: page);
  }

  // ==================== 搜索 (Discourse) ====================

  /// 搜索
  ///
  /// 调用 Discourse /search.json API
  Future<HomeFeedResponse> getSearch({
    required String type,
    String feedType = 'all',
    String sort = 'default',
    required String keyWord,
    String? pageType,
    String? pageParam,
    required int page,
    String? lastItem,
    int showAnonymous = -1,
  }) async {
    try {
      final discourseResponse = await _discourseApi.searchTopics(keyWord);
      final Map<String, dynamic> data = discourseResponse.data;

      final topics = data['topics'] as List<dynamic>? ?? [];
      final users = data['users'] as List<dynamic>? ?? [];

      final feeds = _adaptTopicsToFeeds(topics, users);

      return HomeFeedResponse(status: 200, message: 'success', data: feeds);
    } catch (e) {
      return HomeFeedResponse(
        status: 500,
        message: 'Failed to search: $e',
        data: [],
      );
    }
  }

  // ==================== 用户相关 ====================

  /// 获取用户空间信息
  ///
  /// 调用 Discourse /u/{username}.json API
  Future<UserProfileResponse> getUserSpace({required String uid}) async {
    try {
      final discourseResponse = await _discourseApi.getUserInfo(uid);
      final Map<String, dynamic> data = discourseResponse.data;

      final userMap = data['user'] as Map<String, dynamic>?;
      final userInfo = userMap != null
          ? UserInfo(
              uid: userMap['id']?.toString() ?? '0',
              username: userMap['username'] ?? uid,
              avatar: DiscourseAdapter.formatAvatarUrl(
                userMap['avatar_template'] ?? '',
                userMap['username'] ?? '',
              ),
              level: userMap['trust_level'] ?? 1,
            )
          : UserInfo(uid: '0', username: uid);

      return UserProfileResponse(
        status: 200,
        message: 'success',
        data: UserProfile(userInfo: userInfo),
      );
    } catch (e) {
      return UserProfileResponse(
        status: 500,
        message: 'Failed to fetch user space: $e',
      );
    }
  }

  /// 获取用户资料
  Future<UserProfileResponse> getProfile({required String uid}) async {
    return getUserSpace(uid: uid);
  }

  /// 获取用户动态列表
  Future<HomeFeedResponse> getUserFeed({
    required String uid,
    required int page,
    String? lastItem,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserTopics(
        uid,
        page: page,
      );
      final Map<String, dynamic> data = discourseResponse.data;

      final topicListMap = data['topic_list'] as Map<String, dynamic>?;
      final topics = topicListMap?['topics'] as List<dynamic>? ?? [];
      final users = data['users'] as List<dynamic>? ?? [];

      final feeds = _adaptTopicsToFeeds(topics, users);

      return HomeFeedResponse(
        status: 200,
        message: 'success',
        data: feeds,
        total: feeds.length,
      );
    } catch (e) {
      return HomeFeedResponse(
        status: 500,
        message: 'Failed to fetch user feed: $e',
        data: [],
      );
    }
  }

  /// 获取关注/粉丝列表
  Future<HomeFeedResponse> getFollowList({
    required String url,
    required String uid,
    required int page,
    String? lastItem,
  }) async {
    return getHomeFeed(page: page, installTime: '');
  }

  /// 获取用户总结
  Future<UserSummaryResponse> getUserSummary({required String username}) async {
    try {
      final discourseResponse = await _discourseApi.getUserSummary(username);
      final Map<String, dynamic> data = discourseResponse.data;
      return UserSummaryResponse.fromJson(data);
    } catch (e) {
      return UserSummaryResponse(
        status: 500,
        message: 'Failed to fetch user summary: $e',
      );
    }
  }

  /// 获取用户活动
  Future<UserActivityResponse> getUserActivity({
    required String username,
    int page = 0,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserActivity(
        username,
        page: page,
      );
      final List<dynamic> data = discourseResponse.data as List<dynamic>;
      final activities = data.map((item) {
        return UserActivity.fromJson(item as Map<String, dynamic>);
      }).toList();
      return UserActivityResponse(
        status: 200,
        message: 'success',
        data: activities,
      );
    } catch (e) {
      return UserActivityResponse(
        status: 500,
        message: 'Failed to fetch user activity: $e',
      );
    }
  }

  /// 获取用户活动 - 话题
  Future<UserActivityResponse> getUserActivityTopics({
    required String username,
    int page = 0,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserActivityTopics(
        username,
        page: page,
      );
      final List<dynamic> data = discourseResponse.data as List<dynamic>;
      final activities = data.map((item) {
        return UserActivity.fromJson(item as Map<String, dynamic>);
      }).toList();
      return UserActivityResponse(
        status: 200,
        message: 'success',
        data: activities,
      );
    } catch (e) {
      return UserActivityResponse(
        status: 500,
        message: 'Failed to fetch user activity topics: $e',
      );
    }
  }

  /// 获取用户活动 - 回复
  Future<UserActivityResponse> getUserActivityReplies({
    required String username,
    int page = 0,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserActivityReplies(
        username,
        page: page,
      );
      final List<dynamic> data = discourseResponse.data as List<dynamic>;
      final activities = data.map((item) {
        return UserActivity.fromJson(item as Map<String, dynamic>);
      }).toList();
      return UserActivityResponse(
        status: 200,
        message: 'success',
        data: activities,
      );
    } catch (e) {
      return UserActivityResponse(
        status: 500,
        message: 'Failed to fetch user activity replies: $e',
      );
    }
  }

  /// 获取用户活动 - 赞
  Future<UserActivityResponse> getUserActivityLikes({
    required String username,
    int page = 0,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserActivityLikes(
        username,
        page: page,
      );
      final List<dynamic> data = discourseResponse.data as List<dynamic>;
      final activities = data.map((item) {
        return UserActivity.fromJson(item as Map<String, dynamic>);
      }).toList();
      return UserActivityResponse(
        status: 200,
        message: 'success',
        data: activities,
      );
    } catch (e) {
      return UserActivityResponse(
        status: 500,
        message: 'Failed to fetch user activity likes: $e',
      );
    }
  }

  /// 获取用户活动 - 已解决
  Future<UserActivityResponse> getUserActivitySolved({
    required String username,
    int page = 0,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserActivitySolved(
        username,
        page: page,
      );
      final List<dynamic> data = discourseResponse.data as List<dynamic>;
      final activities = data.map((item) {
        return UserActivity.fromJson(item as Map<String, dynamic>);
      }).toList();
      return UserActivityResponse(
        status: 200,
        message: 'success',
        data: activities,
      );
    } catch (e) {
      return UserActivityResponse(
        status: 500,
        message: 'Failed to fetch user activity solved: $e',
      );
    }
  }

  /// 获取用户活动 - 投票
  Future<UserActivityResponse> getUserActivityVotes({
    required String username,
    int page = 0,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserActivityVotes(
        username,
        page: page,
      );
      final List<dynamic> data = discourseResponse.data as List<dynamic>;
      final activities = data.map((item) {
        return UserActivity.fromJson(item as Map<String, dynamic>);
      }).toList();
      return UserActivityResponse(
        status: 200,
        message: 'success',
        data: activities,
      );
    } catch (e) {
      return UserActivityResponse(
        status: 500,
        message: 'Failed to fetch user activity votes: $e',
      );
    }
  }

  // ==================== 应用相关 ====================

  /// 获取应用信息
  Future<FeedContentResponse> getAppInfo({
    required String id,
    int installed = 1,
  }) async {
    return FeedContentResponse(
      status: 404,
      message: 'Not implemented for Discourse',
    );
  }

  /// 获取应用下载链接
  Future<dynamic> getAppDownloadLink({
    required String id,
    required String aid,
    required String vc,
  }) async {
    return {'error': 'Not implemented for Discourse'};
  }

  /// 检查应用更新
  Future<UpdateCheckResponse> getAppsUpdate({required FormData data}) async {
    return UpdateCheckResponse(status: 404, data: null);
  }

  // ==================== 话题/数码 ====================

  /// 获取话题详情
  Future<FeedContentResponse> getTopicLayout({required String tag}) async {
    return getFeedContent(id: tag);
  }

  /// 获取数码详情
  Future<FeedContentResponse> getProductLayout({required String id}) async {
    return FeedContentResponse(
      status: 404,
      message: 'Not implemented for Discourse',
    );
  }

  /// 获取数码分类列表
  Future<HomeFeedResponse> getProductList() async {
    return HomeFeedResponse(
      status: 404,
      message: 'Not implemented for Discourse',
      data: [],
    );
  }

  // ==================== 消息 ====================

  /// 获取消息列表
  Future<MessageResponse> getMessage({
    required String url,
    required int page,
    String? lastItem,
  }) async {
    try {
      final isPrivateMessages = url.contains('private');
      List<dynamic> messages = [];

      if (isPrivateMessages) {
        final discourseResponse = await _discourseApi.getPrivateMessages('');
        final Map<String, dynamic> data = discourseResponse.data;
        final topicListMap = data['topic_list'] as Map<String, dynamic>?;
        final topics = topicListMap?['topics'] as List<dynamic>? ?? [];
        messages = topics.map((topic) {
          final map = topic as Map<String, dynamic>;
          return {
            'id': map['id'],
            'title': map['title'],
            'last_posted_at': map['last_posted_at'],
            'reply_count': map['reply_count'],
          };
        }).toList();
      } else {
        final discourseResponse = await _discourseApi.getNotifications(
          limit: 30,
          recent: true,
        );
        final Map<String, dynamic> data = discourseResponse.data;
        final notifications = data['notifications'] as List<dynamic>? ?? [];
        messages = notifications.map((notif) {
          final map = notif as Map<String, dynamic>;
          return {
            'id': map['id'],
            'notification_type': map['notification_type'],
            'data': map['data'],
            'created_at': map['created_at'],
          };
        }).toList();
      }

      return MessageResponse(status: 200, message: 'success', data: messages);
    } catch (e) {
      return MessageResponse(
        status: 500,
        message: 'Failed to fetch messages: $e',
        data: [],
      );
    }
  }

  /// 检查未读消息数量
  Future<CheckCountResponse> checkCount() async {
    try {
      final discourseResponse = await _discourseApi.getNotifications(
        limit: 1,
        recent: false,
      );
      final Map<String, dynamic> data = discourseResponse.data;
      final totalRows = data['total_rows_notifications'] ?? 0;
      return CheckCountResponse(status: 200, data: {'count': totalRows});
    } catch (e) {
      return CheckCountResponse(status: 200, data: {'count': 0});
    }
  }

  // ==================== 动态操作 ====================

  /// 点赞/取消点赞动态
  Future<LikeFeedResponse> postLikeFeed({
    required String url,
    required String id,
  }) async {
    try {
      final postId = int.parse(id);
      await _discourseApi.likePost(postId);
      return LikeFeedResponse(
        status: 200,
        message: 'success',
        data: {'liked': true},
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          return LikeFeedResponse(
            status: 401,
            message: 'Unauthorized - please login first',
          );
        }
        return LikeFeedResponse(
          status: e.response?.statusCode ?? 500,
          message: 'Failed to like feed: $e',
        );
      }
      return LikeFeedResponse(status: 500, message: 'Failed to like feed: $e');
    }
  }

  /// 点赞/取消点赞评论
  Future<LikeReplyResponse> postLikeReply({
    required String url,
    required String id,
  }) async {
    try {
      final postId = int.parse(id);
      await _discourseApi.likePost(postId);
      return LikeReplyResponse(
        status: 200,
        message: 'success',
        data: {'liked': true},
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          return LikeReplyResponse(
            status: 401,
            message: 'Unauthorized - please login first',
          );
        }
        return LikeReplyResponse(
          status: e.response?.statusCode ?? 500,
          message: 'Failed to like reply: $e',
        );
      }
      return LikeReplyResponse(
        status: 500,
        message: 'Failed to like reply: $e',
      );
    }
  }

  /// 关注/取消关注用户
  Future<LikeReplyResponse> postFollowUnFollow({
    required String url,
    required String uid,
  }) async {
    try {
      final isFollow = url.contains('follow');
      if (isFollow) {
        await _discourseApi.followUser(uid);
      } else {
        await _discourseApi.unfollowUser(uid);
      }
      return LikeReplyResponse(
        status: 200,
        message: 'success',
        data: {'following': isFollow},
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          return LikeReplyResponse(
            status: 401,
            message: 'Unauthorized - please login first',
          );
        }
        return LikeReplyResponse(
          status: e.response?.statusCode ?? 500,
          message: 'Failed to follow/unfollow user: $e',
        );
      }
      return LikeReplyResponse(
        status: 500,
        message: 'Failed to follow/unfollow user: $e',
      );
    }
  }

  /// 发布评论
  Future<PostReplyResponse> postReply({
    required Map<String, String> data,
    required String id,
    required String type,
  }) async {
    try {
      final topicId = int.parse(id);
      final content = (data['content'] ?? data['message'] ?? '').trim();
      final replyToPostNumberStr = data['reply_to_post_number'];
      final replyToPostNumber = replyToPostNumberStr != null
          ? int.tryParse(replyToPostNumberStr)
          : null;

      await _discourseApi.createPost(
        topicId: topicId,
        raw: content,
        replyToPostNumber: replyToPostNumber,
      );

      return PostReplyResponse(
        status: 200,
        message: 'success',
        data: {'topic_id': topicId},
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          return PostReplyResponse(
            status: 401,
            message: 'Unauthorized - please login first',
          );
        }
        return PostReplyResponse(
          status: e.response?.statusCode ?? 500,
          message: 'Failed to post reply: $e',
        );
      }
      return PostReplyResponse(
        status: 500,
        message: 'Failed to post reply: $e',
      );
    }
  }

  /// 发布动态
  Future<CreateFeedResponse> postCreateFeed({
    required Map<String, String> data,
  }) async {
    try {
      final title = data['title'] ?? '';
      final content = data['content'] ?? '';
      final categoryStr = data['category'];
      final category = categoryStr != null ? int.tryParse(categoryStr) : null;

      await _discourseApi.createTopic(
        title: title,
        raw: content,
        category: category,
      );

      return CreateFeedResponse(
        status: 200,
        message: 'success',
        data: {'title': title},
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          return CreateFeedResponse(
            status: 401,
            message: 'Unauthorized - please login first',
          );
        }
        return CreateFeedResponse(
          status: e.response?.statusCode ?? 500,
          message: 'Failed to create feed: $e',
        );
      }
      return CreateFeedResponse(
        status: 500,
        message: 'Failed to create feed: $e',
      );
    }
  }

  /// 删除动态/评论
  Future<LikeReplyResponse> postDelete({
    required String url,
    required String id,
  }) async {
    try {
      final postId = int.parse(id);
      await _discourseApi.deletePost(postId: postId);
      return LikeReplyResponse(
        status: 200,
        message: 'success',
        data: {'deleted': true},
      );
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 403) {
          return LikeReplyResponse(
            status: 401,
            message: 'Unauthorized - please login first',
          );
        }
        return LikeReplyResponse(
          status: e.response?.statusCode ?? 500,
          message: 'Failed to delete: $e',
        );
      }
      return LikeReplyResponse(status: 500, message: 'Failed to delete: $e');
    }
  }

  // ==================== 登录 ====================

  /// 预获取登录参数
  Future<Response> preGetLoginParam({String type = 'mobile'}) async {
    throw UnimplementedError('Login not implemented for Discourse');
  }

  /// 获取登录参数
  Future<Response> getLoginParam() async {
    throw UnimplementedError('Login not implemented for Discourse');
  }

  /// 尝试登录
  Future<Response> tryLogin({required Map<String, String?> data}) async {
    throw UnimplementedError('Login not implemented for Discourse');
  }

  /// 检查登录信息
  Future<CheckResponse> checkLoginInfo() async {
    return CheckResponse(status: 200, data: {'isLogin': false});
  }

  // ==================== 其他 ====================

  /// 获取数据列表
  Future<HomeFeedResponse> getDataList({
    required String url,
    required String title,
    String? subTitle,
    String? lastItem,
    required int page,
  }) async {
    return HomeFeedResponse(status: 404, message: 'Not implemented', data: []);
  }

  /// 搜索标签
  Future<HomeFeedResponse> getSearchTag({
    required String query,
    required int page,
    String? recentIds,
    String? firstItem,
    String? lastItem,
  }) async {
    return getSearch(keyWord: query, type: 'all', page: page);
  }

  /// 加载分享链接
  Future<LoadUrlResponse> loadShareUrl({
    required String url,
    String packageName = '',
  }) async {
    return LoadUrlResponse(status: 200, data: {'url': url});
  }

  /// 上传图片准备
  Future<OSSUploadPrepareResponse> postOSSUploadPrepare({
    required Map<String, String> data,
  }) async {
    return OSSUploadPrepareResponse(status: 404, message: 'Not implemented');
  }
}

// ==================== 响应模型 ====================

/// 用户资料响应
class UserProfileResponse {
  final int? status;
  final String? message;
  final UserProfile? data;

  UserProfileResponse({this.status, this.message, this.data});

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      UserProfileResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'] != null ? UserProfile.fromJson(json['data']) : null,
      );
}

/// 更新检查响应
class UpdateCheckResponse {
  final int? status;
  final dynamic data;

  UpdateCheckResponse({this.status, this.data});

  factory UpdateCheckResponse.fromJson(Map<String, dynamic> json) =>
      UpdateCheckResponse(status: json['status'], data: json['data']);
}

/// 消息响应
class MessageResponse {
  final int? status;
  final String? message;
  final List<dynamic>? data;

  MessageResponse({this.status, this.message, this.data});

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      MessageResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}

/// 检查数量响应
class CheckCountResponse {
  final int? status;
  final dynamic data;

  CheckCountResponse({this.status, this.data});

  factory CheckCountResponse.fromJson(Map<String, dynamic> json) =>
      CheckCountResponse(status: json['status'], data: json['data']);
}

/// 点赞动态响应
class LikeFeedResponse {
  final int? status;
  final String? message;
  final dynamic data;

  LikeFeedResponse({this.status, this.message, this.data});

  factory LikeFeedResponse.fromJson(Map<String, dynamic> json) =>
      LikeFeedResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}

/// 点赞回复响应
class LikeReplyResponse {
  final int? status;
  final String? message;
  final dynamic data;

  LikeReplyResponse({this.status, this.message, this.data});

  factory LikeReplyResponse.fromJson(Map<String, dynamic> json) =>
      LikeReplyResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}

/// 发布回复响应
class PostReplyResponse {
  final int? status;
  final String? message;
  final dynamic data;

  PostReplyResponse({this.status, this.message, this.data});

  factory PostReplyResponse.fromJson(Map<String, dynamic> json) =>
      PostReplyResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}

/// 创建动态响应
class CreateFeedResponse {
  final int? status;
  final String? message;
  final dynamic data;

  CreateFeedResponse({this.status, this.message, this.data});

  factory CreateFeedResponse.fromJson(Map<String, dynamic> json) =>
      CreateFeedResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}

/// 检查响应
class CheckResponse {
  final int? status;
  final String? message;
  final dynamic data;

  CheckResponse({this.status, this.message, this.data});

  factory CheckResponse.fromJson(Map<String, dynamic> json) => CheckResponse(
    status: json['status'],
    message: json['message'],
    data: json['data'],
  );
}

/// 加载 URL 响应
class LoadUrlResponse {
  final int? status;
  final String? message;
  final dynamic data;

  LoadUrlResponse({this.status, this.message, this.data});

  factory LoadUrlResponse.fromJson(Map<String, dynamic> json) =>
      LoadUrlResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}

/// OSS 上传准备响应
class OSSUploadPrepareResponse {
  final int? status;
  final String? message;
  final dynamic data;

  OSSUploadPrepareResponse({this.status, this.message, this.data});

  factory OSSUploadPrepareResponse.fromJson(Map<String, dynamic> json) =>
      OSSUploadPrepareResponse(
        status: json['status'],
        message: json['message'],
        data: json['data'],
      );
}

/// 用户总结响应
class UserSummaryResponse {
  final int? status;
  final String? message;
  final UserSummary? data;

  UserSummaryResponse({this.status, this.message, this.data});

  factory UserSummaryResponse.fromJson(Map<String, dynamic> json) {
    return UserSummaryResponse(
      status: 200,
      message: 'success',
      data: json['user_summary'] != null
          ? UserSummary.fromJson(json['user_summary'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// 用户总结数据
class UserSummary {
  final int topicCount;
  final int postCount;
  final int likesReceived;
  final int likesGiven;
  final int postsReadCount;
  final int daysVisited;
  final int timeRead;
  final List<UserSummaryTopic> topics;
  final List<UserSummaryReply> replies;

  UserSummary({
    this.topicCount = 0,
    this.postCount = 0,
    this.likesReceived = 0,
    this.likesGiven = 0,
    this.postsReadCount = 0,
    this.daysVisited = 0,
    this.timeRead = 0,
    this.topics = const [],
    this.replies = const [],
  });

  factory UserSummary.fromJson(Map<String, dynamic> json) {
    return UserSummary(
      topicCount: json['topic_count'] ?? 0,
      postCount: json['post_count'] ?? 0,
      likesReceived: json['likes_received'] ?? 0,
      likesGiven: json['likes_given'] ?? 0,
      postsReadCount: json['posts_read_count'] ?? 0,
      daysVisited: json['days_visited'] ?? 0,
      timeRead: json['time_read'] ?? 0,
      topics:
          (json['topics'] as List<dynamic>?)
              ?.map((e) => UserSummaryTopic.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      replies:
          (json['replies'] as List<dynamic>?)
              ?.map((e) => UserSummaryReply.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

/// 用户总结中的话题
class UserSummaryTopic {
  final int id;
  final String title;
  final int likeCount;
  final int replyCount;
  final int views;
  final String? excerpt;
  final String? createdAt;

  UserSummaryTopic({
    this.id = 0,
    this.title = '',
    this.likeCount = 0,
    this.replyCount = 0,
    this.views = 0,
    this.excerpt,
    this.createdAt,
  });

  factory UserSummaryTopic.fromJson(Map<String, dynamic> json) {
    return UserSummaryTopic(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      likeCount: json['like_count'] ?? 0,
      replyCount: json['reply_count'] ?? 0,
      views: json['views'] ?? 0,
      excerpt: json['excerpt'],
      createdAt: json['created_at'],
    );
  }
}

/// 用户总结中的回复
class UserSummaryReply {
  final int topicId;
  final String topicTitle;
  final String? postNumber;
  final String? excerpt;
  final int? likeCount;
  final String? createdAt;

  UserSummaryReply({
    this.topicId = 0,
    this.topicTitle = '',
    this.postNumber,
    this.excerpt,
    this.likeCount,
    this.createdAt,
  });

  factory UserSummaryReply.fromJson(Map<String, dynamic> json) {
    return UserSummaryReply(
      topicId: json['topic_id'] ?? 0,
      topicTitle: json['topic_title'] ?? '',
      postNumber: json['post_number']?.toString(),
      excerpt: json['excerpt'],
      likeCount: json['like_count'],
      createdAt: json['created_at'],
    );
  }
}

/// 用户活动响应
class UserActivityResponse {
  final int? status;
  final String? message;
  final List<UserActivity> data;

  UserActivityResponse({this.status, this.message, this.data = const []});
}

/// 用户活动数据
class UserActivity {
  final int id;
  final String username;
  final String? avatarTemplate;
  final String? createdAt;
  final String? cooked;
  final int? postNumber;
  final int? postsCount;
  final int? replyCount;
  final int? likeCount;
  final int? reads;
  final double? score;
  final int topicId;
  final String? topicSlug;
  final String? userTitle;
  final int? userId;
  final bool? moderator;
  final bool? admin;
  final bool? staff;
  final int? trustLevel;
  final String? excerpt;
  final String? postUrl;
  final Map<String, dynamic>? replyToUser;

  UserActivity({
    this.id = 0,
    this.username = '',
    this.avatarTemplate,
    this.createdAt,
    this.cooked,
    this.postNumber,
    this.postsCount,
    this.replyCount,
    this.likeCount,
    this.reads,
    this.score,
    this.topicId = 0,
    this.topicSlug,
    this.userTitle,
    this.userId,
    this.moderator,
    this.admin,
    this.staff,
    this.trustLevel,
    this.excerpt,
    this.postUrl,
    this.replyToUser,
  });

  factory UserActivity.fromJson(Map<String, dynamic> json) {
    return UserActivity(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      avatarTemplate: json['avatar_template'],
      createdAt: json['created_at'],
      cooked: json['cooked'],
      postNumber: json['post_number'],
      postsCount: json['posts_count'],
      replyCount: json['reply_count'],
      likeCount: json['like_count'],
      reads: json['reads'],
      score: (json['score'] as num?)?.toDouble(),
      topicId: json['topic_id'] ?? 0,
      topicSlug: json['topic_slug'],
      userTitle: json['user_title'],
      userId: json['user_id'],
      moderator: json['moderator'],
      admin: json['admin'],
      staff: json['staff'],
      trustLevel: json['trust_level'],
      excerpt: json['excerpt'],
      postUrl: json['post_url'],
      replyToUser: json['reply_to_user'] as Map<String, dynamic>?,
    );
  }
}
