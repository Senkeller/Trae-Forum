import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traeu/data/models/trae_dashboard.dart';
import 'package:traeu/data/repositories/trae_dashboard_repository.dart';

// 直接复制 provider 代码中的 DashboardData 类用于测试
class DashboardData {
  final TraeUserStats stats;
  final TraeUserInfo userInfo;

  DashboardData({
    required this.stats,
    required this.userInfo,
  });
}

class MockTraeDashboardRepository extends Mock
    implements TraeDashboardRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockTraeDashboardRepository mockRepository;

  setUp(() {
    mockRepository = MockTraeDashboardRepository();
  });

  group('DashboardData 模型', () {
    test('DashboardData 构造函数正确存储数据', () {
      final stats = TraeUserStats.empty();
      final userInfo = TraeUserInfo.empty();

      final data = DashboardData(stats: stats, userInfo: userInfo);

      expect(data.stats, equals(stats));
      expect(data.userInfo, equals(userInfo));
    });

    test('DashboardData 可以存储真实数据', () {
      final stats = TraeUserStats(
        userId: 'test_user',
        registerDays: 100,
        dailyActivity: {'20240101': 10},
        codeAcceptCount7d: 50,
        languageStats: {'Dart': 30},
        conversationCount7d: 25,
        agentStats: {'Builder': 15},
        modelStats: {'GPT-4': 40},
        hourlyActivity: {'9': 5},
        dataDate: '2024-01-15',
      );
      final userInfo = TraeUserInfo(
        userId: 'test_user',
        screenName: 'Test User',
        avatarUrl: 'https://example.com/avatar.png',
      );

      final data = DashboardData(stats: stats, userInfo: userInfo);

      expect(data.stats.userId, equals('test_user'));
      expect(data.userInfo.screenName, equals('Test User'));
      expect(data.stats.registerDays, equals(100));
    });
  });

  group('TraeUserStats 模型', () {
    test('empty() 创建空对象', () {
      final stats = TraeUserStats.empty();

      expect(stats.userId, equals(''));
      expect(stats.registerDays, equals(0));
      expect(stats.dailyActivity, isEmpty);
    });

    test('copyWith 修改属性', () {
      final stats = TraeUserStats.empty().copyWith(userId: 'user_1');

      expect(stats.userId, equals('user_1'));
    });

    test('sortedDailyActivity 返回排序后的数据', () {
      final stats = TraeUserStats(
        userId: 'user_1',
        registerDays: 10,
        dailyActivity: {'20240102': 10, '20240101': 5},
        codeAcceptCount7d: 0,
        languageStats: {},
        conversationCount7d: 0,
        agentStats: {},
        modelStats: {},
        hourlyActivity: {},
        dataDate: '2024-01-15',
      );

      final sorted = stats.sortedDailyActivity;

      expect(sorted.length, equals(2));
      expect(sorted.first.count, equals(5)); // 20240101
      expect(sorted.last.count, equals(10)); // 20240102
    });

    test('sortedLanguageStats 返回排序后的语言统计', () {
      final stats = TraeUserStats(
        userId: 'user_1',
        registerDays: 10,
        dailyActivity: {},
        codeAcceptCount7d: 50,
        languageStats: {'Python': 20, 'Dart': 30},
        conversationCount7d: 0,
        agentStats: {},
        modelStats: {},
        hourlyActivity: {},
        dataDate: '2024-01-15',
      );

      final sorted = stats.sortedLanguageStats;

      expect(sorted.length, equals(2));
      expect(sorted.first.language, equals('Dart'));
      expect(sorted.first.count, equals(30));
    });

    test('sortedModelStats 返回排序后的模型统计', () {
      final stats = TraeUserStats(
        userId: 'user_1',
        registerDays: 10,
        dailyActivity: {},
        codeAcceptCount7d: 0,
        languageStats: {},
        conversationCount7d: 0,
        agentStats: {},
        modelStats: {'Claude': 10, 'GPT-4': 40},
        hourlyActivity: {},
        dataDate: '2024-01-15',
      );

      final sorted = stats.sortedModelStats;

      expect(sorted.length, equals(2));
      expect(sorted.first.modelName, equals('GPT-4'));
      expect(sorted.first.count, equals(40));
    });

    test('hourlyActivityList 返回24小时数据', () {
      final stats = TraeUserStats(
        userId: 'user_1',
        registerDays: 10,
        dailyActivity: {},
        codeAcceptCount7d: 0,
        languageStats: {},
        conversationCount7d: 0,
        agentStats: {},
        modelStats: {},
        hourlyActivity: {'9': 5, '10': 10},
        dataDate: '2024-01-15',
      );

      final hourly = stats.hourlyActivityList;

      expect(hourly.length, equals(24));
      expect(hourly[9].count, equals(5));
      expect(hourly[10].count, equals(10));
    });
  });

  group('TraeUserInfo 模型', () {
    test('empty() 创建空对象', () {
      final info = TraeUserInfo.empty();

      expect(info.userId, equals(''));
      expect(info.screenName, equals(''));
    });

    test('copyWith 修改属性', () {
      final info = TraeUserInfo.empty().copyWith(screenName: 'Test');

      expect(info.screenName, equals('Test'));
    });
  });

  group('Mock Repository', () {
    test('mock getUserStats', () async {
      final testStats = TraeUserStats.empty().copyWith(userId: 'mock_user');
      when(() => mockRepository.getUserStats())
          .thenAnswer((_) async => testStats);

      final result = await mockRepository.getUserStats();

      expect(result.userId, equals('mock_user'));
      verify(() => mockRepository.getUserStats()).called(1);
    });

    test('mock getUserInfo', () async {
      final testInfo = TraeUserInfo.empty().copyWith(screenName: 'Mock User');
      when(() => mockRepository.getUserInfo())
          .thenAnswer((_) async => testInfo);

      final result = await mockRepository.getUserInfo();

      expect(result.screenName, equals('Mock User'));
      verify(() => mockRepository.getUserInfo()).called(1);
    });

    test('mock checkLoginStatus', () async {
      when(() => mockRepository.checkLoginStatus())
          .thenAnswer((_) async => true);

      final result = await mockRepository.checkLoginStatus();

      expect(result, isTrue);
    });

    test('mock getHeatmapData', () async {
      final testStats = TraeUserStats(
        userId: 'user_1',
        registerDays: 10,
        dailyActivity: {'20240101': 5, '20240102': 10},
        codeAcceptCount7d: 0,
        languageStats: {},
        conversationCount7d: 0,
        agentStats: {},
        modelStats: {},
        hourlyActivity: {},
        dataDate: '2024-01-15',
      );
      when(() => mockRepository.getUserStats())
          .thenAnswer((_) async => testStats);
      when(() => mockRepository.getHeatmapData())
          .thenAnswer((_) async => testStats.sortedDailyActivity);

      final result = await mockRepository.getHeatmapData();

      expect(result.length, equals(2));
    });
  });

  group('Repository Provider', () {
    test('traeDashboardRepositoryProvider 可以被覆盖', () {
      final container = ProviderContainer(
        overrides: [
          traeDashboardRepositoryProvider.overrideWithValue(mockRepository),
        ],
      );

      final repository = container.read(traeDashboardRepositoryProvider);

      expect(repository, equals(mockRepository));

      container.dispose();
    });
  });
}
