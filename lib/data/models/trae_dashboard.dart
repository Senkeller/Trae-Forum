import 'package:freezed_annotation/freezed_annotation.dart';

part 'trae_dashboard.freezed.dart';
part 'trae_dashboard.g.dart';

/// Trae Dashboard 用户统计数据模型
///
/// 包含用户的活跃天数、代码采纳、模型偏好等统计数据
@freezed
class TraeUserStats with _$TraeUserStats {
  /// 构造函数
  ///
  /// [userId] 用户ID
  /// [registerDays] 注册天数
  /// [dailyActivity] 每日活跃数据（365天热力图）
  /// [codeAcceptCount7d] 近7天代码采纳次数
  /// [languageStats] 按语言分类的代码采纳统计
  /// [conversationCount7d] 近7天对话次数
  /// [agentStats] 按智能体分类的使用统计
  /// [modelStats] 按模型分类的调用统计
  /// [hourlyActivity] 24小时编程时段分布
  /// [dataDate] 数据日期
  const factory TraeUserStats({
    @JsonKey(name: 'UserID') required String userId,
    @JsonKey(name: 'RegisterDays') required int registerDays,
    @JsonKey(name: 'AiCnt365d') required Map<String, int> dailyActivity,
    @JsonKey(name: 'CodeAiAcceptCnt7d') required int codeAcceptCount7d,
    @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
    required Map<String, int> languageStats,
    @JsonKey(name: 'CodeCompCnt7d') required int conversationCount7d,
    @JsonKey(name: 'CodeCompDiffAgentCnt7d')
    required Map<String, int> agentStats,
    @JsonKey(name: 'CodeCompDiffModelCnt7d')
    required Map<String, int> modelStats,
    @JsonKey(name: 'IdeActiveDiffHourCnt7d')
    required Map<String, int> hourlyActivity,
    @JsonKey(name: 'DataDate') required String dataDate,
    @JsonKey(name: 'IsIde') @Default(true) bool isIde,
  }) = _TraeUserStats;

  /// 从JSON解析
  factory TraeUserStats.fromJson(Map<String, dynamic> json) =>
      _$TraeUserStatsFromJson(json);

  /// 空工厂构造函数
  factory TraeUserStats.empty() => const TraeUserStats(
        userId: '',
        registerDays: 0,
        dailyActivity: {},
        codeAcceptCount7d: 0,
        languageStats: {},
        conversationCount7d: 0,
        agentStats: {},
        modelStats: {},
        hourlyActivity: {},
        dataDate: '',
      );
}

/// 每日活跃数据模型
///
/// 用于热力图展示的单日数据
class DailyActivity {
  /// 日期
  final DateTime date;

  /// 活跃次数
  final int count;

  /// 活跃等级（0-4，用于颜色深浅）
  final int level;

  /// 构造函数
  const DailyActivity({
    required this.date,
    required this.count,
    this.level = 0,
  });
}

/// 编程语言统计模型
class LanguageStat {
  /// 编程语言
  final String language;

  /// 采纳次数
  final int count;

  /// 占比（0-1）
  final double percentage;

  /// 构造函数
  const LanguageStat({
    required this.language,
    required this.count,
    this.percentage = 0.0,
  });
}

/// 智能体使用统计模型
class AgentStat {
  /// 智能体名称
  final String agentName;

  /// 使用次数
  final int count;

  /// 图标URL（可选）
  final String? iconUrl;

  /// 构造函数
  const AgentStat({
    required this.agentName,
    required this.count,
    this.iconUrl,
  });
}

/// AI 模型调用统计模型
class ModelStat {
  /// 模型名称
  final String modelName;

  /// 调用次数
  final int count;

  /// 占比（0-1）
  final double percentage;

  /// 构造函数
  const ModelStat({
    required this.modelName,
    required this.count,
    this.percentage = 0.0,
  });
}

/// 时段活跃数据模型
class HourlyActivity {
  /// 小时（0-23）
  final int hour;

  /// 活跃次数
  final int count;

  /// 是否为高峰时段
  final bool isPeak;

  /// 构造函数
  const HourlyActivity({
    required this.hour,
    required this.count,
    this.isPeak = false,
  });
}

/// Trae 用户信息模型
@freezed
class TraeUserInfo with _$TraeUserInfo {
  /// 构造函数
  ///
  /// [userId] 用户ID
  /// [screenName] 显示名称
  /// [avatarUrl] 头像URL
  /// [registerTime] 注册时间
  /// [lastLoginTime] 最后登录时间
  const factory TraeUserInfo({
    @JsonKey(name: 'UserID') required String userId,
    @JsonKey(name: 'ScreenName') required String screenName,
    @JsonKey(name: 'AvatarUrl') String? avatarUrl,
    @JsonKey(name: 'RegisterTime') String? registerTime,
    @JsonKey(name: 'LastLoginTime') String? lastLoginTime,
    @JsonKey(name: 'Region') @Default('CN') String region,
  }) = _TraeUserInfo;

  factory TraeUserInfo.fromJson(Map<String, dynamic> json) =>
      _$TraeUserInfoFromJson(json);

  factory TraeUserInfo.empty() => const TraeUserInfo(
        userId: '',
        screenName: '',
      );
}



/// TraeUserStats 扩展方法
extension TraeUserStatsExtension on TraeUserStats {
  /// 获取排序后的每日活跃数据（用于热力图）
  ///
  /// 返回按日期排序的 DailyActivity 列表
  List<DailyActivity> get sortedDailyActivity {
    final entries = dailyActivity.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return entries.map((e) {
      final dateStr = e.key;
      final date = DateTime.parse(
        '${dateStr.substring(0, 4)}-${dateStr.substring(4, 6)}-${dateStr.substring(6, 8)}',
      );
      return DailyActivity(
        date: date,
        count: e.value,
        level: _calculateActivityLevel(e.value),
      );
    }).toList();
  }

  /// 计算活跃等级（0-4）
  int _calculateActivityLevel(int count) {
    if (count == 0) return 0;
    if (count < 10) return 1;
    if (count < 30) return 2;
    if (count < 60) return 3;
    return 4;
  }

  /// 获取排序后的编程语言统计
  List<LanguageStat> get sortedLanguageStats {
    final total = codeAcceptCount7d;
    if (total == 0) return [];

    final entries = languageStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries.map((e) => LanguageStat(
          language: e.key,
          count: e.value,
          percentage: e.value / total,
        )).toList();
  }

  /// 获取排序后的智能体统计
  List<AgentStat> get sortedAgentStats {
    final entries = agentStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries.map((e) => AgentStat(
          agentName: e.key,
          count: e.value,
        )).toList();
  }

  /// 获取排序后的模型统计
  List<ModelStat> get sortedModelStats {
    final total = modelStats.values.fold<int>(0, (sum, count) => sum + count);
    if (total == 0) return [];

    final entries = modelStats.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return entries.map((e) => ModelStat(
          modelName: e.key,
          count: e.value,
          percentage: e.value / total,
        )).toList();
  }

  /// 获取24小时时段数据（按小时排序）
  List<HourlyActivity> get hourlyActivityList {
    final maxCount = hourlyActivity.values.isEmpty
        ? 0
        : hourlyActivity.values.reduce((a, b) => a > b ? a : b);

    return List.generate(24, (hour) {
      final count = hourlyActivity[hour.toString()] ?? 0;
      return HourlyActivity(
        hour: hour,
        count: count,
        isPeak: maxCount > 0 && count > maxCount * 0.7,
      );
    });
  }

  /// 获取最常用模型
  String? get topModel {
    if (modelStats.isEmpty) return null;
    return sortedModelStats.first.modelName;
  }

  /// 获取最活跃时段
  int? get peakHour {
    if (hourlyActivity.isEmpty) return null;
    final sorted = hourlyActivityList..sort((a, b) => b.count.compareTo(a.count));
    return sorted.first.hour;
  }

  /// 获取主要编程语言
  String? get primaryLanguage {
    if (languageStats.isEmpty) return null;
    return sortedLanguageStats.first.language;
  }
}
