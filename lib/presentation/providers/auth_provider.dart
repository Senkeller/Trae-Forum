import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';
import '../../core/network/dio_client.dart';

part 'auth_provider.g.dart';

/// 用户信息模型
class UserInfo {
  /// 用户ID
  final String uid;
  /// 用户名
  final String username;
  /// 用户头像URL
  final String avatarUrl;
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
  /// 是否已登录
  final bool isLogin;
  /// Token
  final String? token;

  const UserInfo({
    this.uid = '',
    this.username = '',
    this.avatarUrl = '',
    this.level = 0,
    this.experience = 0,
    this.fansCount = 0,
    this.followCount = 0,
    this.feedCount = 0,
    this.isLogin = false,
    this.token,
  });

  /// 从未登录状态创建
  factory UserInfo.unauthenticated() => const UserInfo();

  /// 从 JSON 创建
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      uid: json['uid']?.toString() ?? '',
      username: json['username'] ?? '',
      avatarUrl: json['userAvatar'] ?? json['avatar'] ?? '',
      level: json['level'] ?? 0,
      experience: json['experience'] ?? 0,
      fansCount: json['fans'] ?? 0,
      followCount: json['follow'] ?? 0,
      feedCount: json['feed'] ?? 0,
      isLogin: true,
      token: json['token'],
    );
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'userAvatar': avatarUrl,
      'level': level,
      'experience': experience,
      'fans': fansCount,
      'follow': followCount,
      'feed': feedCount,
      'token': token,
    };
  }

  /// 复制并修改
  UserInfo copyWith({
    String? uid,
    String? username,
    String? avatarUrl,
    int? level,
    int? experience,
    int? fansCount,
    int? followCount,
    int? feedCount,
    bool? isLogin,
    String? token,
  }) {
    return UserInfo(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      fansCount: fansCount ?? this.fansCount,
      followCount: followCount ?? this.followCount,
      feedCount: feedCount ?? this.feedCount,
      isLogin: isLogin ?? this.isLogin,
      token: token ?? this.token,
    );
  }
}

/// 认证状态类
@riverpod
class AuthNotifier extends _$AuthNotifier {
  static const String _userInfoKey = 'user_info';
  static const String _tokenKey = 'auth_token';

  late ApiService _apiService;

  /// 构建认证状态
  ///
  /// 从本地存储读取用户登录信息，初始化认证状态
  @override
  Future<UserInfo> build() async {
    _apiService = ref.read(apiServiceProvider);
    return _loadUserInfo();
  }

  /// 从本地存储加载用户信息
  ///
  /// 返回加载的用户信息，如果没有则返回未登录状态
  Future<UserInfo> _loadUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(_tokenKey);
      
      if (token == null || token.isEmpty) {
        return UserInfo.unauthenticated();
      }

      // 尝试从本地缓存获取用户信息
      final userInfoJson = prefs.getString(_userInfoKey);
      if (userInfoJson != null) {
        // 这里简化处理，实际应该从服务器验证 token
        return UserInfo.fromJson({'token': token});
      }

      return UserInfo.unauthenticated();
    } catch (e) {
      return UserInfo.unauthenticated();
    }
  }

  /// 保存用户信息到本地存储
  ///
  /// [userInfo] 要保存的用户信息
  Future<void> _saveUserInfo(UserInfo userInfo) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userInfoKey, userInfo.toJson().toString());
    if (userInfo.token != null) {
      await prefs.setString(_tokenKey, userInfo.token!);
    }
  }

  /// 清除本地存储的用户信息
  Future<void> _clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userInfoKey);
    await prefs.remove(_tokenKey);
  }

  /// 用户登录
  ///
  /// [username] 用户名
  /// [password] 密码
  /// 返回登录是否成功
  Future<bool> login(String username, String password) async {
    state = const AsyncLoading();
    
    try {
      // 这里应该调用实际的登录 API
      // 暂时模拟登录成功
      final userInfo = UserInfo(
        uid: '12345',
        username: username,
        avatarUrl: 'https://example.com/avatar.jpg',
        level: 5,
        experience: 1000,
        fansCount: 100,
        followCount: 50,
        feedCount: 20,
        isLogin: true,
        token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      );

      await _saveUserInfo(userInfo);
      state = AsyncData(userInfo);
      return true;
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  /// 使用 CoolApk 登录
  ///
  /// [coolApkId] CoolApk ID
  /// [coolApkToken] CoolApk Token
  /// 返回登录是否成功
  Future<bool> loginWithCoolApk(String coolApkId, String coolApkToken) async {
    state = const AsyncLoading();
    
    try {
      final response = await _apiService.tryLogin({
        'coolapkId': coolApkId,
        'coolapkToken': coolApkToken,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 1) {
          final userInfo = UserInfo.fromJson(data['data']);
          await _saveUserInfo(userInfo);
          state = AsyncData(userInfo);
          return true;
        }
      }
      
      throw Exception('登录失败');
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
      return false;
    }
  }

  /// 用户登出
  ///
  /// 清除本地用户信息并更新状态为未登录
  Future<void> logout() async {
    state = const AsyncLoading();
    
    try {
      await _clearUserInfo();
      state = const AsyncData(UserInfo());
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  /// 检查登录状态
  ///
  /// 向服务器验证当前 token 是否有效
  /// 返回 token 是否有效
  Future<bool> checkLoginStatus() async {
    try {
      final currentUser = state.valueOrNull;
      if (currentUser == null || !currentUser.isLogin) {
        return false;
      }

      final response = await _apiService.checkLoginInfo();
      if (response.status == 1) {
        // 更新用户信息
        final updatedUser = UserInfo.fromJson(response.data);
        await _saveUserInfo(updatedUser);
        state = AsyncData(updatedUser);
        return true;
      }
      
      // Token 无效，登出
      await logout();
      return false;
    } catch (e) {
      await logout();
      return false;
    }
  }

  /// 更新用户信息
  ///
  /// [userInfo] 新的用户信息
  Future<void> updateUserInfo(UserInfo userInfo) async {
    await _saveUserInfo(userInfo);
    state = AsyncData(userInfo);
  }

  /// 刷新用户信息
  ///
  /// 从服务器获取最新的用户信息
  Future<void> refreshUserInfo() async {
    final currentUser = state.valueOrNull;
    if (currentUser == null || !currentUser.isLogin) {
      return;
    }

    state = const AsyncLoading();
    
    try {
      final response = await _apiService.getProfile(uid: currentUser.uid);
      if (response.status == 1 && response.data != null) {
        final userInfo = UserInfo.fromJson(response.data);
        await _saveUserInfo(userInfo);
        state = AsyncData(userInfo);
      }
    } catch (e, stackTrace) {
      // 刷新失败，保持原有状态
      state = AsyncData(currentUser);
    }
  }
}

/// 当前用户信息 Provider
///
/// 提供当前登录用户的信息，未登录时返回 null
@riverpod
UserInfo? currentUser(CurrentUserRef ref) {
  final authAsync = ref.watch(authNotifierProvider);
  final userInfo = authAsync.valueOrNull;
  if (userInfo != null && userInfo.isLogin) {
    return userInfo;
  }
  return null;
}

/// 是否已登录 Provider
///
/// 返回当前用户是否已登录
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
}

/// 用户 Token Provider
///
/// 返回当前用户的 token，未登录时返回 null
@riverpod
String? authToken(AuthTokenRef ref) {
  final user = ref.watch(currentUserProvider);
  return user?.token;
}
