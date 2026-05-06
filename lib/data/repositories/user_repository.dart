import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart' as api;
import '../models/feed.dart';

part 'user_repository.g.dart';

/// 用户仓库
/// 负责处理用户相关的数据操作，包括获取用户信息、用户动态、关注/取消关注等
@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  final apiService = ref.read(api.apiServiceProvider);
  return UserRepository(apiService);
}

/// 用户仓库类
class UserRepository {
  final api.ApiService _apiService;

  UserRepository(this._apiService);

  /// 获取用户空间信息
  ///
  /// [uid] 用户 ID
  Future<api.UserProfileResponse> getUserSpace({
    required String uid,
  }) async {
    return await _apiService.getUserSpace(uid: uid);
  }

  /// 获取用户资料
  ///
  /// [uid] 用户 ID
  Future<api.UserProfileResponse> getProfile({
    required String uid,
  }) async {
    return await _apiService.getProfile(uid: uid);
  }

  /// 获取用户动态列表
  ///
  /// [uid] 用户 ID
  Future<HomeFeedResponse> getUserFeedList({
    required String uid,
    required int page,
    String? lastItem,
  }) async {
    return await _apiService.getUserFeed(uid: uid, page: page, lastItem: lastItem);
  }

  /// 关注用户
  ///
  /// [uid] 用户 ID
  Future<api.LikeReplyResponse> followUser({
    required String uid,
  }) async {
    return await _apiService.postFollowUnFollow(isFollow: true, uid: uid);
  }

  /// 取消关注用户
  ///
  /// [uid] 用户 ID
  Future<api.LikeReplyResponse> unfollowUser({
    required String uid,
  }) async {
    return await _apiService.postFollowUnFollow(isFollow: false, uid: uid);
  }

  /// 获取关注列表
  ///
  /// [uid] 用户 ID
  Future<HomeFeedResponse> getFollowList({
    required String uid,
    required int page,
    String? lastItem,
  }) async {
    return await _apiService.getFollowList(
      url: '',
      uid: uid,
      page: page,
      lastItem: lastItem,
    );
  }

  /// 获取粉丝列表
  ///
  /// [uid] 用户 ID
  Future<HomeFeedResponse> getFansList({
    required String uid,
    required int page,
    String? lastItem,
  }) async {
    return await _apiService.getFollowList(
      url: '',
      uid: uid,
      page: page,
      lastItem: lastItem,
    );
  }
}
