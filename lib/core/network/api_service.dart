import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../config/constants.dart';
import '../../data/models/feed.dart';
import '../../data/models/comment.dart';
import '../../data/models/user.dart';
import '../../data/adapters/discourse_adapter.dart';
import '../../data/models/discourse/discourse_topic.dart';
import '../../data/models/discourse/discourse_user.dart';
import 'discourse_api_service.dart';
import 'dio_client.dart';

part 'api_service.g.dart';

/// API 服务类
/// 
/// 负责调用后端 API，支持酷安 API 和 Discourse API
/// 通过适配器层统一数据格式
@riverpod
class ApiService extends _$ApiService {
  late final Dio _dio;
  late final DiscourseApiService _discourseApi;

  @override
  ApiService build() {
    _dio = DioClient.dio;
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
      return DiscourseAdapter.adaptTopicListResponse(discourseResponse);
    } catch (e) {
      return HomeFeedResponse(
        status: 500,
        message: 'Failed to fetch home feed: $e',
        data: [],
      );
    }
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
      final discourseResponse = await _discourseApi.getTopicDetail(int.parse(id));
      return DiscourseAdapter.adaptTopicDetailResponse(discourseResponse);
    } catch (e) {
      return FeedContentResponse(
        status: 500,
        message: 'Failed to fetch feed content: $e',
      );
    }
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
      final posts = await _discourseApi.getTopicPosts(int.parse(id), page: page);
      return DiscourseAdapter.adaptPostListResponse(posts, id);
    } catch (e) {
      return TotalReplyResponse(
        status: 500,
        message: 'Failed to fetch replies: $e',
        data: [],
      );
    }
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
      
      final feeds = discourseResponse.topics.map((topic) {
        final DiscourseTopic topicModel = DiscourseTopic(
          id: topic.id,
          title: topic.title ?? '',
          slug: topic.slug,
          categoryId: topic.categoryId,
          createdAt: topic.createdAt ?? DateTime.now().toIso8601String(),
          postsCount: topic.postsCount,
          replyCount: topic.replyCount,
          views: topic.views,
          likeCount: topic.likeCount,
          tags: topic.tags ?? [],
        );
        
        final DiscourseUserBasic user = DiscourseUserBasic(
          id: 0,
          username: topic.categoryName ?? 'unknown',
          avatarTemplate: '',
        );
        
        return DiscourseAdapter.adaptTopicToFeed(topicModel, [user]);
      }).toList();

      return HomeFeedResponse(
        status: 200,
        message: 'success',
        data: feeds,
      );
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
  Future<UserProfileResponse> getUserSpace({
    required String uid,
  }) async {
    try {
      final discourseResponse = await _discourseApi.getUserInfo(uid);
      final userInfo = discourseResponse.user != null
          ? DiscourseAdapter.adaptUserFromDetail(discourseResponse.user!)
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
  Future<UserProfileResponse> getProfile({
    required String uid,
  }) async {
    return getUserSpace(uid: uid);
  }

  /// 获取用户动态列表
  Future<HomeFeedResponse> getUserFeed({
    required String uid,
    required int page,
    String? lastItem,
  }) async {
    return getHomeFeed(page: page, installTime: '');
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

  // ==================== 应用相关 ====================

  /// 获取应用信息
  Future<FeedContentResponse> getAppInfo({
    required String id,
    int installed = 1,
  }) async {
    return FeedContentResponse(status: 404, message: 'Not implemented for Discourse');
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
  Future<UpdateCheckResponse> getAppsUpdate({
    required FormData data,
  }) async {
    return UpdateCheckResponse(status: 404, data: null);
  }

  // ==================== 话题/数码 ====================

  /// 获取话题详情
  Future<FeedContentResponse> getTopicLayout({
    required String tag,
  }) async {
    return getFeedContent(id: tag);
  }

  /// 获取数码详情
  Future<FeedContentResponse> getProductLayout({
    required String id,
  }) async {
    return FeedContentResponse(status: 404, message: 'Not implemented for Discourse');
  }

  /// 获取数码分类列表
  Future<HomeFeedResponse> getProductList() async {
    return HomeFeedResponse(status: 404, message: 'Not implemented for Discourse', data: []);
  }

  // ==================== 消息 ====================

  /// 获取消息列表
  Future<MessageResponse> getMessage({
    required String url,
    required int page,
    String? lastItem,
  }) async {
    return MessageResponse(status: 404, message: 'Not implemented for Discourse', data: []);
  }

  /// 检查未读消息数量
  Future<CheckCountResponse> checkCount() async {
    return CheckCountResponse(status: 200, data: {'count': 0});
  }

  // ==================== 动态操作 ====================

  /// 点赞/取消点赞动态
  Future<LikeFeedResponse> postLikeFeed({
    required String url,
    required String id,
  }) async {
    return LikeFeedResponse(status: 404, message: 'Not implemented for Discourse');
  }

  /// 点赞/取消点赞评论
  Future<LikeReplyResponse> postLikeReply({
    required String url,
    required String id,
  }) async {
    return LikeReplyResponse(status: 404, message: 'Not implemented for Discourse');
  }

  /// 关注/取消关注用户
  Future<LikeReplyResponse> postFollowUnFollow({
    required String url,
    required String uid,
  }) async {
    return LikeReplyResponse(status: 404, message: 'Not implemented for Discourse');
  }

  /// 发布评论
  Future<PostReplyResponse> postReply({
    required Map<String, String> data,
    required String id,
    required String type,
  }) async {
    return PostReplyResponse(status: 404, message: 'Not implemented for Discourse');
  }

  /// 发布动态
  Future<CreateFeedResponse> postCreateFeed({
    required Map<String, String> data,
  }) async {
    return CreateFeedResponse(status: 404, message: 'Not implemented for Discourse');
  }

  /// 删除动态/评论
  Future<LikeReplyResponse> postDelete({
    required String url,
    required String id,
  }) async {
    return LikeReplyResponse(status: 404, message: 'Not implemented for Discourse');
  }

  // ==================== 登录 ====================

  /// 预获取登录参数
  Future<Response> preGetLoginParam({
    String type = 'mobile',
  }) async {
    throw UnimplementedError('Login not implemented for Discourse');
  }

  /// 获取登录参数
  Future<Response> getLoginParam() async {
    throw UnimplementedError('Login not implemented for Discourse');
  }

  /// 尝试登录
  Future<Response> tryLogin({
    required Map<String, String?> data,
  }) async {
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

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
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

  factory MessageResponse.fromJson(Map<String, dynamic> json) => MessageResponse(
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

  factory LikeFeedResponse.fromJson(Map<String, dynamic> json) => LikeFeedResponse(
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

  factory LikeReplyResponse.fromJson(Map<String, dynamic> json) => LikeReplyResponse(
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

  factory PostReplyResponse.fromJson(Map<String, dynamic> json) => PostReplyResponse(
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

  factory CreateFeedResponse.fromJson(Map<String, dynamic> json) => CreateFeedResponse(
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

  factory LoadUrlResponse.fromJson(Map<String, dynamic> json) => LoadUrlResponse(
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
