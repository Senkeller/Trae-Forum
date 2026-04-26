import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_service.dart';
import '../../core/network/dio_client.dart';
import '../../core/network/cookie_manager.dart';
import '../../core/network/discourse_api_service.dart';
import '../../core/network/native_cookie_bridge.dart';
import '../../data/models/user.dart';

part 'auth_provider.g.dart';

/// 认证状态 Notifier
@riverpod
class AuthNotifier extends _$AuthNotifier {
  late ApiService _apiService;
  late DiscourseApiService _discourseApiService;

  /// 构建认证状态
  @override
  AsyncValue<UserInfo> build() {
    _apiService = ref.read(apiServiceProvider);
    _discourseApiService = ref.read(discourseApiServiceProvider);
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

      debugPrint('🔍 [AuthNotifier] 从本地加载: uid=$uid, username=$username');

      if (uid != null && username != null && uid.isNotEmpty) {
        final userInfo = UserInfo(
          uid: uid,
          username: username,
          avatar: avatarUrl ?? '',
        );
        if (_isPlaceholderUser(userInfo)) {
          debugPrint('⚠️ [AuthNotifier] 本地用户为占位数据，尝试从论坛会话刷新');
          final restoredUser = await _restoreUserInfoFromDiscourseSession();
          if (restoredUser != null) {
            debugPrint('✅ [AuthNotifier] 论坛会话刷新成功: ${restoredUser.username}');
            state = AsyncData(restoredUser);
            return;
          }
        } else {
          debugPrint('✅ [AuthNotifier] 加载用户信息成功: ${userInfo.username}');
          state = AsyncData(userInfo);
          return;
        }
      } else {
        debugPrint('ℹ️ [AuthNotifier] 本地无用户信息，尝试从 Discourse 会话恢复');
      }

      final restoredUser = await _restoreUserInfoFromDiscourseSession();
      if (restoredUser != null) {
        debugPrint(
          '✅ [AuthNotifier] Discourse 会话恢复成功: ${restoredUser.username}',
        );
        state = AsyncData(restoredUser);
        return;
      }

      debugPrint('ℹ️ [AuthNotifier] 未检测到可用会话，设置为未登录');
      state = const AsyncValue.data(UserInfo(uid: '', username: ''));
    } catch (e, stackTrace) {
      debugPrint('❌ [AuthNotifier] 加载用户信息失败: $e');
      state = AsyncError(e, stackTrace);
    }
  }

  /// 从 Discourse Cookie 会话恢复用户信息
  ///
  /// 当本地用户信息丢失但 Cookie 仍有效时，避免页面误判为未登录
  Future<UserInfo?> _restoreUserInfoFromDiscourseSession() async {
    try {
      // 先尝试从系统 WebView CookieManager 同步完整 Cookie（含 HttpOnly）
      await NativeCookieBridge.syncCookiesToDio('https://forum.trae.cn');

      // 直接探测当前会话接口，避免仅依赖 Cookie 名称判断导致误判。
      final sessionUser = await _fetchCurrentSessionUser();
      if (sessionUser != null) {
        await _saveUserInfo(sessionUser);
        return sessionUser;
      }

      final hasSession = await DioClient.hasDiscourseSession();

      // 兜底探活：会话可用但当前接口未返回用户详情时，不写入占位用户名，避免污染展示。
      final probe = await _discourseApiService.getNotifications(
        limit: 1,
        recent: true,
        bumpLastSeen: false,
      );
      if (probe.statusCode == 200) {
        debugPrint('⚠️ [AuthNotifier] 会话可用但未获取到用户名，保留未登录展示避免脏数据');
      } else if (!hasSession) {
        debugPrint('ℹ️ [AuthNotifier] 未探测到有效论坛会话');
      }
      return null;
    } catch (e) {
      debugPrint('⚠️ [AuthNotifier] Discourse 会话恢复失败: $e');
      return null;
    }
  }

  Future<UserInfo?> _fetchCurrentSessionUser() async {
    try {
      final response = await _discourseApiService.getCurrentSession();
      final data = response.data;
      if (response.statusCode != 200 || data is! Map<String, dynamic>) {
        return null;
      }

      final currentUser = data['current_user'];
      if (currentUser is! Map<String, dynamic>) {
        return null;
      }

      final username = (currentUser['username']?.toString() ?? '').trim();
      if (username.isEmpty) {
        return null;
      }

      final uid = (currentUser['id']?.toString() ?? username).trim();
      final avatarTemplate = (currentUser['avatar_template']?.toString() ?? '')
          .trim();
      final avatar = avatarTemplate.isNotEmpty
          ? _formatAvatarUrl(username, avatarTemplate)
          : '';

      return UserInfo(uid: uid, username: username, avatar: avatar);
    } catch (e) {
      debugPrint('⚠️ [AuthNotifier] 获取当前会话用户失败: $e');
      return null;
    }
  }

  String _formatAvatarUrl(String username, String avatarTemplate) {
    var url = avatarTemplate.replaceAll('{size}', '120');
    if (url.startsWith('//')) {
      url = 'https:$url';
    } else if (url.startsWith('/')) {
      url = 'https://forum.trae.cn$url';
    } else if (!url.startsWith('http')) {
      url =
          'https://forum.trae.cn/user_avatar/forum.trae.cn/$username/120/0_2.png';
    }
    return url;
  }

  bool _isPlaceholderUser(UserInfo? userInfo) {
    if (userInfo == null) return true;
    final username = userInfo.username.trim();
    final uid = userInfo.uid.trim();
    return username.isEmpty ||
        uid.isEmpty ||
        username == '用户' ||
        uid == 'webview_user';
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

  /// 旧版登录入口（已废弃）
  ///
  /// [coolApkId] 历史参数
  /// [coolApkToken] 历史参数
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
  /// 清除本地用户信息、Cookie 并更新状态为未登录
  Future<void> logout() async {
    state = const AsyncLoading();

    try {
      // 清除本地用户信息
      await _clearUserInfo();

      // 清除 Dio Cookie
      await DioClient.clearCookies();

      // 清除 Trae Cookie
      await TraeCookieManager.clearCookies();

      debugPrint('✅ [AuthNotifier] 用户登出完成');
      state = const AsyncValue.data(UserInfo(uid: '', username: ''));
    } catch (e, stackTrace) {
      debugPrint('❌ [AuthNotifier] 登出失败: $e');
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
      final userInfo = response.data?.userInfo;
      if (response.status == 1 && userInfo != null) {
        await _saveUserInfo(userInfo);
        state = AsyncData(userInfo);
      }
    } catch (e) {
      // 刷新失败，保持原有状态
      state = AsyncData(currentUser);
    }
  }

  /// 设置用户信息（用于 WebView 登录成功后）
  ///
  /// [userInfo] 用户信息对象
  /// 将用户信息保存到本地存储并更新状态
  Future<void> setUserInfo(UserInfo userInfo) async {
    debugPrint('💾 [AuthNotifier] setUserInfo 被调用: ${userInfo.username}');
    try {
      var finalUser = userInfo;
      if (_isPlaceholderUser(finalUser)) {
        debugPrint('⚠️ [AuthNotifier] setUserInfo 收到占位用户，尝试会话回填真实账号');
        final restoredUser = await _restoreUserInfoFromDiscourseSession();
        if (restoredUser != null) {
          finalUser = restoredUser;
        }
      }

      await _saveUserInfo(finalUser);
      debugPrint('✅ [AuthNotifier] 用户信息已保存到本地');
      state = AsyncData(finalUser);
      debugPrint('✅ [AuthNotifier] 状态已更新');
    } catch (e, stackTrace) {
      debugPrint('❌ [AuthNotifier] setUserInfo 失败: $e');
      state = AsyncError(e, stackTrace);
    }
  }

  /// 强制从论坛会话刷新当前用户信息
  Future<UserInfo?> refreshFromSession() async {
    final restoredUser = await _restoreUserInfoFromDiscourseSession();
    if (restoredUser != null) {
      state = AsyncData(restoredUser);
    }
    return restoredUser;
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

/// 是否已登录 Provider（同步版本）
///
/// 返回当前用户是否已登录（仅检查本地有效用户）
/// 用于需要同步检查的场景
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  final user = ref.watch(currentUserProvider);
  return user != null;
}

/// 是否已登录 Provider（异步版本）
///
/// 返回当前用户是否已登录（支持本地缓存与论坛会话）
/// 用于需要完整检查登录状态的场景
@riverpod
Future<bool> isAuthenticatedAsync(IsAuthenticatedAsyncRef ref) async {
  // 1. 先检查本地用户状态
  final user = ref.read(currentUserProvider);
  final isPlaceholder =
      user == null ||
      user.username.trim().isEmpty ||
      user.uid.trim().isEmpty ||
      user.username.trim() == '用户' ||
      user.uid.trim() == 'webview_user';

  if (!isPlaceholder) {
    debugPrint('✅ [isAuthenticatedAsync] 本地用户已登录: ${user.username}');
    return true;
  }

  // 2. 尝试从论坛会话回填真实用户
  final restored = await ref
      .read(authNotifierProvider.notifier)
      .refreshFromSession();
  if (restored != null &&
      restored.uid.isNotEmpty &&
      restored.username.isNotEmpty) {
    debugPrint('✅ [isAuthenticatedAsync] 论坛会话已恢复: ${restored.username}');
    return true;
  }

  // 3. 检查论坛会话 Cookie（仅作线索，不直接判定登录）
  final hasDiscourseCookie = await DioClient.hasDiscourseSession();
  debugPrint(
    '🔍 [isAuthenticatedAsync] Discourse session cookie: $hasDiscourseCookie',
  );

  // 4. 统一使用 current session 判定，避免仅凭 Cookie 误判已登录
  try {
    final response = await ref
        .read(discourseApiServiceProvider)
        .getCurrentSession();
    final data = response.data;
    final currentUser = data is Map<String, dynamic>
        ? data['current_user']
        : null;
    if (response.statusCode == 200 &&
        currentUser is Map<String, dynamic> &&
        (currentUser['username']?.toString().trim().isNotEmpty ?? false)) {
      debugPrint('✅ [isAuthenticatedAsync] current session 命中，判定为已登录');
      return true;
    }
  } catch (_) {
    // ignore: 探活失败时继续返回 false
  }

  debugPrint('ℹ️ [isAuthenticatedAsync] current session 未命中，判定为未登录');
  return false;
}

/// 用户 Token Provider
///
/// 返回当前用户的 token，未登录时返回 null
@riverpod
String? authToken(AuthTokenRef ref) {
  // Discourse API 暂不支持认证，返回 null
  return null;
}
