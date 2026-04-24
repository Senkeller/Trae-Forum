import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/trae_dashboard_api.dart';
import '../models/trae_dashboard.dart';

part 'trae_dashboard_repository.g.dart';

/// Trae Dashboard 数据仓库
///
/// 封装 Dashboard 数据的获取逻辑，提供统一的接口给 UI 层使用
@riverpod
TraeDashboardRepository traeDashboardRepository(TraeDashboardRepositoryRef ref) {
  final api = ref.read(traeDashboardApiProvider);
  return TraeDashboardRepository(api);
}

/// Trae Dashboard 仓库类
class TraeDashboardRepository {
  final TraeDashboardApi _api;

  TraeDashboardRepository(this._api);

  /// 获取用户统计数据
  ///
  /// 返回用户的完整统计数据，包括热力图、代码采纳、模型偏好等
  /// 如果用户未登录或 Cookie 过期，会抛出异常
  Future<TraeUserStats> getUserStats() async {
    return await _api.getUserStats();
  }

  /// 获取用户信息
  ///
  /// 返回用户的基本信息（昵称、头像等）
  Future<TraeUserInfo> getUserInfo() async {
    return await _api.getUserInfo();
  }

  /// 检查登录状态
  ///
  /// 返回是否已登录且 Cookie 有效
  Future<bool> checkLoginStatus() async {
    return await _api.checkLoginStatus();
  }

  /// 获取热力图数据
  ///
  /// 返回按日期排序的每日活跃数据，用于热力图展示
  Future<List<DailyActivity>> getHeatmapData() async {
    final stats = await getUserStats();
    return stats.sortedDailyActivity;
  }

  /// 获取编程语言统计
  ///
  /// 返回按使用次数排序的编程语言统计
  Future<List<LanguageStat>> getLanguageStats() async {
    final stats = await getUserStats();
    return stats.sortedLanguageStats;
  }

  /// 获取模型偏好统计
  ///
  /// 返回按调用次数排序的 AI 模型统计
  Future<List<ModelStat>> getModelStats() async {
    final stats = await getUserStats();
    return stats.sortedModelStats;
  }

  /// 获取智能体使用统计
  ///
  /// 返回按使用次数排序的智能体统计
  Future<List<AgentStat>> getAgentStats() async {
    final stats = await getUserStats();
    return stats.sortedAgentStats;
  }

  /// 获取编程时段分布
  ///
  /// 返回24小时的编程活跃数据，用于时段分布图
  Future<List<HourlyActivity>> getHourlyActivity() async {
    final stats = await getUserStats();
    return stats.hourlyActivityList;
  }

  /// 获取用户概览数据
  ///
  /// 返回简化的用户数据摘要，用于快速展示
  Future<UserStatsSummary> getUserStatsSummary() async {
    final stats = await getUserStats();
    final userInfo = await getUserInfo();

    return UserStatsSummary(
      userId: stats.userId,
      screenName: userInfo.screenName,
      avatarUrl: userInfo.avatarUrl,
      registerDays: stats.registerDays,
      codeAcceptCount7d: stats.codeAcceptCount7d,
      conversationCount7d: stats.conversationCount7d,
      topModel: stats.topModel,
      primaryLanguage: stats.primaryLanguage,
      peakHour: stats.peakHour,
      dataDate: stats.dataDate,
    );
  }
}

/// 用户统计数据摘要
///
/// 用于快速展示的用户数据摘要
class UserStatsSummary {
  /// 用户ID
  final String userId;

  /// 显示名称
  final String screenName;

  /// 头像URL
  final String? avatarUrl;

  /// 注册天数
  final int registerDays;

  /// 近7天代码采纳次数
  final int codeAcceptCount7d;

  /// 近7天对话次数
  final int conversationCount7d;

  /// 最常用模型
  final String? topModel;

  /// 主要编程语言
  final String? primaryLanguage;

  /// 最活跃时段
  final int? peakHour;

  /// 数据日期
  final String dataDate;

  UserStatsSummary({
    required this.userId,
    required this.screenName,
    this.avatarUrl,
    required this.registerDays,
    required this.codeAcceptCount7d,
    required this.conversationCount7d,
    this.topModel,
    this.primaryLanguage,
    this.peakHour,
    required this.dataDate,
  });

  /// 获取格式化的注册天数文本
  String get registerDaysText => '使用 TRAE IDE 第 $registerDays 天';

  /// 获取格式化的代码采纳文本
  String get codeAcceptText => '$codeAcceptCount7d';

  /// 获取格式化的对话次数文本
  String get conversationText => '$conversationCount7d';

  /// 获取格式化的最活跃时段文本
  String? get peakHourText {
    if (peakHour == null) return null;
    return '${peakHour.toString().padLeft(2, '0')}:00';
  }
}
