import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/models/trae_dashboard.dart';
import '../../data/repositories/trae_dashboard_repository.dart';
import '../../core/network/trae_dashboard_api.dart';

part 'trae_dashboard_provider.g.dart';

/// Dashboard 数据状态
class DashboardState {
  final bool isLoading;
  final bool isRefreshing;
  final TraeUserStats? stats;
  final TraeUserInfo? userInfo;
  final String? error;

  const DashboardState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.stats,
    this.userInfo,
    this.error,
  });

  DashboardState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    TraeUserStats? stats,
    TraeUserInfo? userInfo,
    String? error,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      stats: stats ?? this.stats,
      userInfo: userInfo ?? this.userInfo,
      error: error ?? this.error,
    );
  }

  bool get hasData => stats != null;
  bool get hasError => error != null;
}

/// Dashboard 状态 Notifier
class TraeDashboardNotifier extends StateNotifier<DashboardState> {
  final TraeDashboardRepository _repository;

  TraeDashboardNotifier(this._repository) : super(const DashboardState());

  /// 加载 Dashboard 数据
  Future<void> loadData() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final stats = await _repository.getUserStats();
      final userInfo = await _repository.getUserInfo();

      state = state.copyWith(
        isLoading: false,
        stats: stats,
        userInfo: userInfo,
        error: null,
      );
    } on TraeApiException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '加载数据失败: $e',
      );
    }
  }

  /// 刷新 Dashboard 数据
  Future<void> refresh() async {
    if (state.isRefreshing) return;

    state = state.copyWith(isRefreshing: true, error: null);

    try {
      final stats = await _repository.getUserStats();
      final userInfo = await _repository.getUserInfo();

      state = state.copyWith(
        isRefreshing: false,
        stats: stats,
        userInfo: userInfo,
        error: null,
      );
    } on TraeApiException catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        error: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        isRefreshing: false,
        error: '刷新数据失败: $e',
      );
    }
  }

  /// 清除错误状态
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Dashboard Notifier Provider
final traeDashboardNotifierProvider = StateNotifierProvider<TraeDashboardNotifier, DashboardState>((ref) {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return TraeDashboardNotifier(repository);
});

/// Dashboard 状态 Provider
@riverpod
class DashboardStateNotifier extends _$DashboardStateNotifier {
  TraeDashboardRepository? _repository;

  @override
  AsyncValue<DashboardData> build() {
    // 初始化 repository
    _repository = ref.read(traeDashboardRepositoryProvider);
    // 立即返回 loading 状态，然后异步加载数据
    _loadData();
    return const AsyncValue.loading();
  }

  Future<void> _loadData() async {
    // 确保 repository 已初始化
    final repo = _repository ?? ref.read(traeDashboardRepositoryProvider);
    
    if (repo == null) {
      state = AsyncValue.error('Repository 未初始化', StackTrace.current);
      return;
    }

    try {
      print('[DashboardStateNotifier] 开始加载数据...');
      final stats = await repo.getUserStats();
      print('[DashboardStateNotifier] 获取到 stats: ${stats.userId}');
      final userInfo = await repo.getUserInfo();
      print('[DashboardStateNotifier] 获取到 userInfo: ${userInfo.screenName}');

      state = AsyncValue.data(DashboardData(
        stats: stats,
        userInfo: userInfo,
      ));
      print('[DashboardStateNotifier] 数据加载完成');
    } on TraeApiException catch (e) {
      print('[DashboardStateNotifier] API 错误: ${e.message}');
      state = AsyncValue.error(e, StackTrace.current);
    } catch (e, stackTrace) {
      print('[DashboardStateNotifier] 错误: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await _loadData();
  }
}

/// Dashboard 数据包装类
class DashboardData {
  final TraeUserStats stats;
  final TraeUserInfo userInfo;

  DashboardData({
    required this.stats,
    required this.userInfo,
  });
}

/// 用户统计数据 Provider
@riverpod
Future<TraeUserStats> traeUserStats(TraeUserStatsRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getUserStats();
}

/// 用户信息 Provider
@riverpod
Future<TraeUserInfo> traeUserInfo(TraeUserInfoRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getUserInfo();
}

/// 热力图数据 Provider
@riverpod
Future<List<DailyActivity>> heatmapData(HeatmapDataRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getHeatmapData();
}

/// 编程语言统计 Provider
@riverpod
Future<List<LanguageStat>> languageStats(LanguageStatsRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getLanguageStats();
}

/// 模型偏好统计 Provider
@riverpod
Future<List<ModelStat>> modelStats(ModelStatsRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getModelStats();
}

/// 智能体使用统计 Provider
@riverpod
Future<List<AgentStat>> agentStats(AgentStatsRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getAgentStats();
}

/// 编程时段分布 Provider
@riverpod
Future<List<HourlyActivity>> hourlyActivity(HourlyActivityRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getHourlyActivity();
}

/// 用户概览数据 Provider
@riverpod
Future<UserStatsSummary> userStatsSummary(UserStatsSummaryRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.getUserStatsSummary();
}

/// 检查登录状态 Provider
@riverpod
Future<bool> traeLoginStatus(TraeLoginStatusRef ref) async {
  final repository = ref.read(traeDashboardRepositoryProvider);
  return await repository.checkLoginStatus();
}
