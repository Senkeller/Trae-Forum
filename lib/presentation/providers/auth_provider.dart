import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';
import '../../data/models/user.dart';

part 'auth_provider.g.dart';

/// 认证状态 Notifier
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late ApiService _apiService;

  /// 构建认证状态
  @override
  AsyncValue<UserInfo> build() {
    _apiService = ref.read(apiServiceProvider);
    _loadUserInfo();
    return const AsyncValue.loading();
  }

  /// 从本地存储加载用户信息
  Future<void> _loadUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString('uid');
      final username = prefs.getString('username');
      final avatarUrl = prefs.getString('avatarUrl');

      if (uid != null && username != null) {
        final userInfo = UserInfo(
          uid: uid,
          username: username,
          avatar: avatarUrl ?? '',
        );
        state = AsyncData(userInfo);
      } else {
        state = const AsyncValue.data(UserInfo(uid: '', username: ''));
      }
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  /// 保存用户信息到本地存储
  Future<void> _saveUserInfo(UserInfo userInfo) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', userInfo.uid);
      await prefs.setString('username', userInfo.username);
      await prefs.setString('avatarUrl', userInfo.avatar ?? '');
    } catch (_) {}
  }

  /// 清除本地用户信息
  Future<void> _clearUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('uid');
      await prefs.remove('username');
      await prefs.remove('avatarUrl');
    } catch (_) {}
  }

  /// 使用 CoolApk 登录
  ///
  /// [coolApkId] CoolApk ID
  /// [coolApkToken] CoolApk Token
  /// 返回登录是否成功
  Future<bool> loginWithCoolApk(String coolApkId, String coolApkToken) async {
    state = const AsyncLoading();
    
    try {
      // Discourse API 暂不支持登录，返回 false
      return false;
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
      state = const AsyncValue.data(UserInfo(uid: '', username: ''));
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  /// 检查登录状态
  ///
  /// 向服务器验证当前 token 是否有效
  /// 返回 token 是否有效
  Future<bool> checkLoginStatus() async {
    final currentUser = state.valueOrNull;
    if (currentUser == null || currentUser.uid.isEmpty) {
      return false;
    }

    try {
      final response = await _apiService.checkLoginInfo();
      return response.status == 1;
    } catch (_) {
      return false;
    }
  }

  /// 刷新用户信息
  ///
  /// 从服务器获取最新用户信息
  Future<void> refreshUserInfo() async {
    final currentUser = state.valueOrNull;
    if (currentUser == null || currentUser.uid.isEmpty) return;

    state = const AsyncLoading();
    
    try {
      final response = await _apiService.getProfile(uid: currentUser.uid);
      if (response.status == 1 && response.data != null && response.data!.userInfo != null) {
        await _saveUserInfo(response.data!.userInfo!);
        state = AsyncData(response.data!.userInfo!);
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
  if (userInfo != null && userInfo.uid.isNotEmpty) {
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
  // Discourse API 暂不支持认证，返回 null
  return null;
}
