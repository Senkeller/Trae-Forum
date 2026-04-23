import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart';
import '../../core/network/dio_client.dart';
import 'auth_provider.dart';
import 'home_provider.dart';

part 'user_provider.g.dart';

/// 用户资料数据模型
class UserProfile {
  /// 用户ID
  final String uid;
  /// 用户名
  final String username;
  /// 用户头像
  final String avatarUrl;
  /// 用户简介
  final String bio;
  /// 用户等级
  final int level;
  /// 经验值
  final int experience;
  /// 粉丝数
  final int fansCount;
  /// 关注数
  final int followCount;
  /// 动态数
  final int feedCount;
  /// 是否已关注
  final bool isFollowing;
  /// 注册时间
  final String? regDate;
  /// 最后登录时间
  final String? lastLogin;
  /// 是否被拉黑
  final bool isBlocked;

  const UserProfile({
    required this.uid,
    required this.username,
    required this.avatarUrl,
    this.bio = '',
    this.level = 0,
    this.experience = 0,
    this.fansCount = 0,
    this.followCount = 0,
    this.feedCount = 0,
    this.isFollowing = false,
    this.regDate,
    this.lastLogin,
    this.isBlocked = false,
  });

  /// 从 JSON 创建
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      uid: json['uid']?.toString() ?? '',
      username: json['username'] ?? '',
      avatarUrl: json['userAvatar'] ?? json['avatar'] ?? '',
      bio: json['bio'] ?? json['signature'] ?? '',
      level: json['level'] ?? 0,
      experience: json['experience'] ?? 0,
      fansCount: json['fans'] ?? json['fansCount'] ?? 0,
      followCount: json['follow'] ?? json['followCount'] ?? 0,
      feedCount: json['feed'] ?? json['feedCount'] ?? 0,
      isFollowing: json['isFollowing'] == 1 || json['isFollowing'] == true,
      regDate: json['regDate']?.toString(),
      lastLogin: json['lastLogin']?.toString(),
      isBlocked: json['isBlocked'] == 1 || json['isBlocked'] == true,
    );
  }

  /// 复制并修改
  UserProfile copyWith({
    String? uid,
    String? username,
    String? avatarUrl,
    String? bio,
    int? level,
    int? experience,
    int? fansCount,
    int? followCount,
    int? feedCount,
    bool? isFollowing,
    String? regDate,
    String? lastLogin,
    bool? isBlocked,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      fansCount: fansCount ?? this.fansCount,
      followCount: followCount ?? this.followCount,
      feedCount: feedCount ?? this.feedCount,
      isFollowing: isFollowing ?? this.isFollowing,
      regDate: regDate ?? this.regDate,
      lastLogin: lastLogin ?? this.lastLogin,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }
}

/// 用户空间状态类
class UserSpaceState {
  /// 用户ID
  final String uid;
  /// 用户资料
  final UserProfile? profile;
  /// 用户动态列表
  final List<FeedItem> feeds;
  /// 是否正在加载资料
  final bool isLoadingProfile;
  /// 是否正在加载动态
  final bool isLoadingFeeds;
  /// 是否正在刷新动态
  final bool isRefreshingFeeds;
  /// 动态当前页码
  final int feedPage;
  /// 是否还有更多动态
  final bool hasMoreFeeds;
  /// 错误信息
  final String? errorMessage;
  /// 最后加载标识
  final String? lastItem;

  const UserSpaceState({
    required this.uid,
    this.profile,
    this.feeds = const [],
    this.isLoadingProfile = false,
    this.isLoadingFeeds = false,
    this.isRefreshingFeeds = false,
    this.feedPage = 1,
    this.hasMoreFeeds = true,
    this.errorMessage,
    this.lastItem,
  });

  /// 复制并修改
  UserSpaceState copyWith({
    String? uid,
    UserProfile? profile,
    List<FeedItem>? feeds,
    bool? isLoadingProfile,
    bool? isLoadingFeeds,
    bool? isRefreshingFeeds,
    int? feedPage,
    bool? hasMoreFeeds,
    String? errorMessage,
    String? lastItem,
  }) {
    return UserSpaceState(
      uid: uid ?? this.uid,
      profile: profile ?? this.profile,
      feeds: feeds ?? this.feeds,
      isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
      isLoadingFeeds: isLoadingFeeds ?? this.isLoadingFeeds,
      isRefreshingFeeds: isRefreshingFeeds ?? this.isRefreshingFeeds,
      feedPage: feedPage ?? this.feedPage,
      hasMoreFeeds: hasMoreFeeds ?? this.hasMoreFeeds,
      errorMessage: errorMessage,
      lastItem: lastItem ?? this.lastItem,
    );
  }
}

/// 用户空间状态 Notifier（家族 Provider）
@riverpod
class UserSpaceNotifier extends _$UserSpaceNotifier {
  late ApiService _apiService;

  /// 构建用户空间状态
  ///
  /// [uid] 用户ID
  @override
  UserSpaceState build(String uid) {
    _apiService = ApiService(ref.read(dioClientProvider));
    return UserSpaceState(uid: uid);
  }

  /// 加载用户资料
  ///
  /// 从服务器获取用户详细信息
  Future<void> loadUserProfile() async {
    state = state.copyWith(isLoadingProfile: true, errorMessage: null);

    try {
      final response = await _apiService.getUserSpace(uid: state.uid);

      if (response.status == 1 && response.data != null) {
        final profileData = response.data as Map<String, dynamic>;
        final profile = UserProfile.fromJson(profileData);

        state = state.copyWith(
          profile: profile,
          isLoadingProfile: false,
        );
      } else {
        state = state.copyWith(
          isLoadingProfile: false,
          errorMessage: '加载用户资料失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingProfile: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 加载用户动态列表
  ///
  /// 从服务器获取用户的动态列表
  Future<void> loadUserFeeds() async {
    if (state.isLoadingFeeds) return;

    state = state.copyWith(
      isLoadingFeeds: true,
      errorMessage: null,
      feedPage: 1,
    );

    try {
      final response = await _apiService.getUserFeed(
        uid: state.uid,
        page: 1,
      );

      if (response.status == 1 && response.data != null) {
        final feeds = (response.data as List<dynamic>)
            .map((item) => FeedItem.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(
          feeds: feeds,
          isLoadingFeeds: false,
          hasMoreFeeds: feeds.length >= 20,
          feedPage: 1,
          lastItem: feeds.isNotEmpty ? feeds.last.id : null,
        );
      } else {
        state = state.copyWith(
          isLoadingFeeds: false,
          errorMessage: '加载动态失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingFeeds: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 刷新用户动态列表
  Future<void> refreshUserFeeds() async {
    if (state.isRefreshingFeeds) return;

    state = state.copyWith(
      isRefreshingFeeds: true,
      errorMessage: null,
    );

    try {
      final response = await _apiService.getUserFeed(
        uid: state.uid,
        page: 1,
      );

      if (response.status == 1 && response.data != null) {
        final feeds = (response.data as List<dynamic>)
            .map((item) => FeedItem.fromJson(item as Map<String, dynamic>))
            .toList();

        state = state.copyWith(
          feeds: feeds,
          isRefreshingFeeds: false,
          hasMoreFeeds: feeds.length >= 20,
          feedPage: 1,
          lastItem: feeds.isNotEmpty ? feeds.last.id : null,
        );
      } else {
        state = state.copyWith(
          isRefreshingFeeds: false,
          errorMessage: '刷新动态失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isRefreshingFeeds: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 加载更多用户动态
  Future<void> loadMoreUserFeeds() async {
    if (state.isLoadingFeeds || !state.hasMoreFeeds) return;

    state = state.copyWith(
      isLoadingFeeds: true,
      errorMessage: null,
    );

    try {
      final nextPage = state.feedPage + 1;

      final response = await _apiService.getUserFeed(
        uid: state.uid,
        page: nextPage,
        lastItem: state.lastItem,
      );

      if (response.status == 1 && response.data != null) {
        final newFeeds = (response.data as List<dynamic>)
            .map((item) => FeedItem.fromJson(item as Map<String, dynamic>))
            .toList();

        if (newFeeds.isEmpty) {
          state = state.copyWith(
            isLoadingFeeds: false,
            hasMoreFeeds: false,
          );
        } else {
          state = state.copyWith(
            feeds: [...state.feeds, ...newFeeds],
            isLoadingFeeds: false,
            feedPage: nextPage,
            hasMoreFeeds: newFeeds.length >= 20,
            lastItem: newFeeds.last.id,
          );
        }
      } else {
        state = state.copyWith(
          isLoadingFeeds: false,
          errorMessage: '加载更多动态失败',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoadingFeeds: false,
        errorMessage: '网络错误: $e',
      );
    }
  }

  /// 关注/取消关注用户
  ///
  /// 需要用户已登录
  /// 返回操作是否成功
  Future<bool> toggleFollow() async {
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    if (!isAuthenticated) {
      state = state.copyWith(errorMessage: '请先登录');
      return false;
    }

    final profile = state.profile;
    if (profile == null) return false;

    try {
      final url = profile.isFollowing
          ? '/v6/user/unfollow'
          : '/v6/user/follow';

      final response = await _apiService.postFollowUnFollow(
        url: url,
        uid: state.uid,
      );

      if (response.status == 1) {
        final updatedProfile = profile.copyWith(
          isFollowing: !profile.isFollowing,
          fansCount: profile.isFollowing
              ? profile.fansCount - 1
              : profile.fansCount + 1,
        );

        state = state.copyWith(profile: updatedProfile);
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(errorMessage: '操作失败: $e');
      return false;
    }
  }

  /// 更新动态点赞状态
  ///
  /// [feedId] 动态ID
  /// [isLiked] 新的点赞状态
  /// [likeCount] 新的点赞数
  void updateFeedLike(String feedId, bool isLiked, int likeCount) {
    final updatedFeeds = state.feeds.map((feed) {
      if (feed.id == feedId) {
        return feed.copyWith(isLiked: isLiked, likeCount: likeCount);
      }
      return feed;
    }).toList();

    state = state.copyWith(feeds: updatedFeeds);
  }

  /// 清空错误信息
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

/// 用户资料 Provider（带参数）
///
/// [uid] 用户ID
@riverpod
UserProfile? userProfile(UserProfileRef ref, String uid) {
  return ref.watch(userSpaceNotifierProvider(uid)).profile;
}

/// 用户动态列表 Provider
///
/// [uid] 用户ID
@riverpod
List<FeedItem> userFeeds(UserFeedsRef ref, String uid) {
  return ref.watch(userSpaceNotifierProvider(uid)).feeds;
}

/// 用户是否正在加载资料 Provider
///
/// [uid] 用户ID
@riverpod
bool isUserProfileLoading(IsUserProfileLoadingRef ref, String uid) {
  return ref.watch(userSpaceNotifierProvider(uid)).isLoadingProfile;
}

/// 用户是否正在加载动态 Provider
///
/// [uid] 用户ID
@riverpod
bool isUserFeedsLoading(IsUserFeedsLoadingRef ref, String uid) {
  return ref.watch(userSpaceNotifierProvider(uid)).isLoadingFeeds;
}

/// 用户关注状态 Provider
///
/// [uid] 用户ID
@riverpod
bool isFollowingUser(IsFollowingUserRef ref, String uid) {
  return ref.watch(userSpaceNotifierProvider(uid)).profile?.isFollowing ?? false;
}
