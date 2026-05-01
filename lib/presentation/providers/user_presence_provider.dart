import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/discourse_api_service.dart';
import 'auth_provider.dart';

part 'user_presence_provider.g.dart';

/// 用户在线状态枚举
enum UserPresenceStatus {
  /// 在线
  online,

  /// 离线
  offline,

  /// 未知（加载中或未获取）
  unknown,
}

/// 用户在线状态扩展
extension UserPresenceStatusExtension on UserPresenceStatus {
  /// 获取显示名称
  String get displayName {
    switch (this) {
      case UserPresenceStatus.online:
        return '在线';
      case UserPresenceStatus.offline:
        return '离线';
      case UserPresenceStatus.unknown:
        return '加载中...';
    }
  }

  /// 获取状态颜色
  Color get color {
    switch (this) {
      case UserPresenceStatus.online:
        return const Color(0xFF00B96B); // 绿色
      case UserPresenceStatus.offline:
        return const Color(0xFF999999); // 灰色
      case UserPresenceStatus.unknown:
        return const Color(0xFFCCCCCC); // 浅灰
    }
  }

  /// 是否是在线状态
  bool get isOnline => this == UserPresenceStatus.online;

  /// 是否是离线状态
  bool get isOffline => this == UserPresenceStatus.offline;
}

/// 用户在线状态 Notifier
@riverpod
class UserPresenceNotifier extends _$UserPresenceNotifier {
  static const String _presenceKey = 'user_hide_presence';
  DiscourseApiService? _discourseApiService;

  /// 构建在线状态
  @override
  Future<UserPresenceStatus> build() async {
    _discourseApiService = ref.read(discourseApiServiceProvider);

    // 监听当前用户变化，当用户切换时重新加载状态
    ref.listen(currentUserProvider, (previous, next) {
      if (previous?.username != next?.username) {
        // 用户切换，重新加载状态
        _loadPresenceStatus();
      }
    });

    return _loadPresenceStatus();
  }

  /// 从本地存储和服务器加载在线状态
  Future<UserPresenceStatus> _loadPresenceStatus() async {
    final currentUser = ref.read(currentUserProvider);

    // 未登录时返回离线状态
    if (currentUser == null || currentUser.username.isEmpty) {
      debugPrint('[UserPresenceNotifier] 用户未登录，返回离线状态');
      return UserPresenceStatus.offline;
    }

    try {
      // 先尝试从本地存储读取缓存的状态
      final prefs = await SharedPreferences.getInstance();
      final cachedHidePresence = prefs.getBool(_presenceKey);

      if (cachedHidePresence != null) {
        debugPrint('[UserPresenceNotifier] 从本地缓存加载状态: hide_presence=$cachedHidePresence');
        return cachedHidePresence
            ? UserPresenceStatus.offline
            : UserPresenceStatus.online;
      }

      // 本地没有缓存，从服务器获取
      return await _fetchPresenceStatusFromServer(currentUser.username);
    } catch (e) {
      debugPrint('[UserPresenceNotifier] 加载在线状态失败: $e');
      // 出错时默认返回在线状态
      return UserPresenceStatus.online;
    }
  }

  /// 从服务器获取在线状态
  Future<UserPresenceStatus> _fetchPresenceStatusFromServer(String username) async {
    try {
      if (_discourseApiService == null) {
        return UserPresenceStatus.unknown;
      }

      final response = await _discourseApiService!.getUserPresenceStatus(username);

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        final user = data['user'] as Map<String, dynamic>?;

        if (user != null) {
          // 检查 user_option 中的 hide_presence
          final userOption = user['user_option'] as Map<String, dynamic>?;
          final hidePresence = userOption?['hide_presence'] as bool? ?? false;

          // 缓存到本地
          await _savePresenceToLocal(hidePresence);

          debugPrint('[UserPresenceNotifier] 从服务器获取状态: hide_presence=$hidePresence');
          return hidePresence ? UserPresenceStatus.offline : UserPresenceStatus.online;
        }
      }

      return UserPresenceStatus.unknown;
    } catch (e) {
      debugPrint('[UserPresenceNotifier] 从服务器获取状态失败: $e');
      return UserPresenceStatus.unknown;
    }
  }

  /// 保存状态到本地存储
  Future<void> _savePresenceToLocal(bool hidePresence) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_presenceKey, hidePresence);
    } catch (_) {
      // 忽略保存失败
    }
  }

  /// 切换在线/离线状态
  ///
  /// 返回切换后的状态
  Future<UserPresenceStatus> togglePresence() async {
    final currentUser = ref.read(currentUserProvider);

    // 未登录时不能切换状态
    if (currentUser == null || currentUser.username.isEmpty) {
      throw Exception('用户未登录，无法切换在线状态');
    }

    // 获取当前状态
    final currentStatus = state.valueOrNull ?? UserPresenceStatus.online;
    final newHidePresence = !currentStatus.isOffline; // 当前在线则设为离线，反之亦然

    // 乐观更新 UI
    final newStatus = newHidePresence
        ? UserPresenceStatus.offline
        : UserPresenceStatus.online;
    state = AsyncData(newStatus);

    try {
      if (_discourseApiService == null) {
        throw Exception('API 服务未初始化');
      }

      // 调用 API 切换状态
      final response = await _discourseApiService!.toggleUserPresence(
        username: currentUser.username,
        hidePresence: newHidePresence,
      );

      if (response.statusCode == 200) {
        // 保存到本地
        await _savePresenceToLocal(newHidePresence);

        debugPrint('[UserPresenceNotifier] 状态切换成功: ${newStatus.displayName}');
        return newStatus;
      } else {
        // API 调用失败，恢复原来的状态
        state = AsyncData(currentStatus);
        throw Exception('切换状态失败: ${response.statusCode}');
      }
    } catch (e) {
      // 发生错误，恢复原来的状态
      state = AsyncData(currentStatus);
      debugPrint('[UserPresenceNotifier] 切换状态失败: $e');
      throw Exception('切换在线状态失败: $e');
    }
  }

  /// 设置为在线状态
  Future<void> setOnline() async {
    await _setPresence(false);
  }

  /// 设置为离线状态
  Future<void> setOffline() async {
    await _setPresence(true);
  }

  /// 设置在线状态（内部方法）
  Future<void> _setPresence(bool hidePresence) async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.username.isEmpty) {
      throw Exception('用户未登录');
    }

    final targetStatus = hidePresence
        ? UserPresenceStatus.offline
        : UserPresenceStatus.online;

    // 如果已经是目标状态，直接返回
    if (state.valueOrNull == targetStatus) {
      return;
    }

    state = AsyncData(targetStatus);

    try {
      if (_discourseApiService == null) {
        throw Exception('API 服务未初始化');
      }

      final response = await _discourseApiService!.toggleUserPresence(
        username: currentUser.username,
        hidePresence: hidePresence,
      );

      if (response.statusCode == 200) {
        await _savePresenceToLocal(hidePresence);
        debugPrint('[UserPresenceNotifier] 状态设置成功: ${targetStatus.displayName}');
      } else {
        // 恢复状态
        await refresh();
        throw Exception('设置状态失败: ${response.statusCode}');
      }
    } catch (e) {
      // 恢复状态
      await refresh();
      throw Exception('设置在线状态失败: $e');
    }
  }

  /// 刷新在线状态（从服务器重新获取）
  Future<void> refresh() async {
    state = const AsyncLoading();

    try {
      final status = await _loadPresenceStatus();
      state = AsyncData(status);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// 清除本地缓存的状态
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_presenceKey);
      debugPrint('[UserPresenceNotifier] 本地缓存已清除');
    } catch (_) {
      // 忽略清除失败
    }
  }
}

/// 当前用户在线状态 Provider（同步版本）
@riverpod
UserPresenceStatus currentUserPresence(CurrentUserPresenceRef ref) {
  final presenceAsync = ref.watch(userPresenceNotifierProvider);
  return presenceAsync.when(
    data: (status) => status,
    loading: () => UserPresenceStatus.unknown,
    error: (error, stackTrace) => UserPresenceStatus.unknown,
  );
}

/// 是否在线 Provider
@riverpod
bool isUserOnline(IsUserOnlineRef ref) {
  final presence = ref.watch(currentUserPresenceProvider);
  return presence.isOnline;
}

/// 是否离线 Provider
@riverpod
bool isUserOffline(IsUserOfflineRef ref) {
  final presence = ref.watch(currentUserPresenceProvider);
  return presence.isOffline;
}
