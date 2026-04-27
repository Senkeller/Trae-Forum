import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:traeu/data/models/user_activity.dart';
import 'package:traeu/data/repositories/user_activity_repository.dart';

/// 模拟 PathProvider
class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async {
    return '/tmp/test_hive';
  }
}

void main() {
  late UserActivityRepository repository;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    PathProviderPlatform.instance = FakePathProviderPlatform();

    // 初始化 Hive
    Hive.init('/tmp/test_hive');

    // 注册适配器
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(LocalFavoriteAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(BrowseHistoryAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(FrequentlyVisitedAdapter());
    }
  });

  setUp(() async {
    repository = UserActivityRepository();

    // 清空所有数据，确保测试隔离
    await repository.clearAllFrequentlyVisited();
  });

  tearDownAll(() async {
    // 关闭 Hive
    await Hive.close();
  });

  group('recordVisit 测试', () {
    test('空数据首次调用 recordVisit 应成功写入新记录', () async {
      // 验证初始状态为空
      final initialList = await repository.getAllFrequentlyVisited();
      expect(initialList, isEmpty);

      // 首次调用 recordVisit
      await repository.recordVisit(
        topicId: 'topic_001',
        topicName: '测试话题',
        topicTag: '测试标签',
        coverUrl: 'https://example.com/cover.jpg',
      );

      // 验证记录已写入
      final result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(1));
      expect(result[0].topicId, equals('topic_001'));
      expect(result[0].topicName, equals('测试话题'));
      expect(result[0].topicTag, equals('测试标签'));
      expect(result[0].coverUrl, equals('https://example.com/cover.jpg'));
      expect(result[0].visitCount, equals(1));
      expect(result[0].lastVisitedAt, isNotNull);
    });

    test('重复调用 recordVisit 应正确累加 visitCount', () async {
      const topicId = 'topic_002';
      const topicName = '测试话题2';

      // 首次访问
      await repository.recordVisit(
        topicId: topicId,
        topicName: topicName,
      );

      final firstVisit = await repository.getAllFrequentlyVisited();
      expect(firstVisit.length, equals(1));
      expect(firstVisit[0].visitCount, equals(1));
      final firstVisitTime = firstVisit[0].lastVisitedAt;

      // 等待一小段时间确保时间戳不同
      await Future.delayed(const Duration(milliseconds: 10));

      // 第二次访问同一话题
      await repository.recordVisit(
        topicId: topicId,
        topicName: topicName,
      );

      final secondVisit = await repository.getAllFrequentlyVisited();
      expect(secondVisit.length, equals(1)); // 仍然是同一条记录
      expect(secondVisit[0].visitCount, equals(2)); // 访问次数累加
      expect(secondVisit[0].lastVisitedAt.isAfter(firstVisitTime), isTrue); // 时间更新

      // 第三次访问
      await Future.delayed(const Duration(milliseconds: 10));
      await repository.recordVisit(
        topicId: topicId,
        topicName: topicName,
      );

      final thirdVisit = await repository.getAllFrequentlyVisited();
      expect(thirdVisit[0].visitCount, equals(3)); // 访问次数继续累加
    });

    test('访问不同话题应创建多条记录', () async {
      // 访问话题1
      await repository.recordVisit(
        topicId: 'topic_a',
        topicName: '话题A',
      );

      // 访问话题2
      await repository.recordVisit(
        topicId: 'topic_b',
        topicName: '话题B',
      );

      // 访问话题3
      await repository.recordVisit(
        topicId: 'topic_c',
        topicName: '话题C',
      );

      final result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(3));

      // 验证每条记录的独立性
      final topicIds = result.map((e) => e.topicId).toList();
      expect(topicIds, contains('topic_a'));
      expect(topicIds, contains('topic_b'));
      expect(topicIds, contains('topic_c'));

      // 每条记录的访问次数都应为1
      for (final item in result) {
        expect(item.visitCount, equals(1));
      }
    });

    test('多次访问同一话题，其他话题记录不受影响', () async {
      // 创建多个话题记录
      await repository.recordVisit(
        topicId: 'topic_main',
        topicName: '主要话题',
      );
      await repository.recordVisit(
        topicId: 'topic_other',
        topicName: '其他话题',
      );

      // 多次访问主要话题
      for (int i = 0; i < 5; i++) {
        await Future.delayed(const Duration(milliseconds: 5));
        await repository.recordVisit(
          topicId: 'topic_main',
          topicName: '主要话题',
        );
      }

      final result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(2));

      // 找到主要话题和其他话题
      final mainTopic = result.firstWhere((e) => e.topicId == 'topic_main');
      final otherTopic = result.firstWhere((e) => e.topicId == 'topic_other');

      // 主要话题访问次数应为6（首次+5次重复）
      expect(mainTopic.visitCount, equals(6));
      // 其他话题访问次数应保持为1
      expect(otherTopic.visitCount, equals(1));
    });

    test('recordVisit 应支持可选参数为空', () async {
      await repository.recordVisit(
        topicId: 'topic_minimal',
        topicName: '最小参数话题',
        // topicTag 和 coverUrl 不传
      );

      final result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(1));
      expect(result[0].topicId, equals('topic_minimal'));
      expect(result[0].topicName, equals('最小参数话题'));
      expect(result[0].topicTag, isNull);
      expect(result[0].coverUrl, isNull);
      expect(result[0].visitCount, equals(1));
    });
  });

  group('getAllFrequentlyVisited 排序测试', () {
    test('应按访问次数和时间权重综合排序', () async {
      // 创建三个话题，设置不同的访问次数
      await repository.recordVisit(topicId: 't1', topicName: '话题1');
      await repository.recordVisit(topicId: 't2', topicName: '话题2');
      await repository.recordVisit(topicId: 't3', topicName: '话题3');

      // 话题1访问5次
      for (int i = 0; i < 4; i++) {
        await Future.delayed(const Duration(milliseconds: 5));
        await repository.recordVisit(topicId: 't1', topicName: '话题1');
      }

      // 话题2访问3次
      for (int i = 0; i < 2; i++) {
        await Future.delayed(const Duration(milliseconds: 5));
        await repository.recordVisit(topicId: 't2', topicName: '话题2');
      }

      // 话题3只访问1次

      final result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(3));

      // 访问次数：t1=5, t2=3, t3=1
      // 由于时间相近，访问次数多的应该排在前面
      expect(result[0].topicId, equals('t1'));
      expect(result[0].visitCount, equals(5));
      expect(result[1].topicId, equals('t2'));
      expect(result[1].visitCount, equals(3));
      expect(result[2].topicId, equals('t3'));
      expect(result[2].visitCount, equals(1));
    });
  });

  group('removeFrequentlyVisited 测试', () {
    test('应成功删除指定话题记录', () async {
      // 创建记录
      await repository.recordVisit(topicId: 'to_delete', topicName: '待删除');
      await repository.recordVisit(topicId: 'to_keep', topicName: '保留');

      var result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(2));

      // 删除指定记录
      await repository.removeFrequentlyVisited('to_delete');

      result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(1));
      expect(result[0].topicId, equals('to_keep'));
    });

    test('删除不存在的话题不应报错', () async {
      await repository.recordVisit(topicId: 'existing', topicName: '存在');

      // 删除不存在的话题
      await expectLater(
        repository.removeFrequentlyVisited('non_existing'),
        completes,
      );

      // 验证现有记录不受影响
      final result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(1));
      expect(result[0].topicId, equals('existing'));
    });
  });

  group('clearAllFrequentlyVisited 测试', () {
    test('应清空所有我常去记录', () async {
      // 创建多条记录
      await repository.recordVisit(topicId: 't1', topicName: '话题1');
      await repository.recordVisit(topicId: 't2', topicName: '话题2');
      await repository.recordVisit(topicId: 't3', topicName: '话题3');

      var result = await repository.getAllFrequentlyVisited();
      expect(result.length, equals(3));

      // 清空所有记录
      await repository.clearAllFrequentlyVisited();

      result = await repository.getAllFrequentlyVisited();
      expect(result, isEmpty);
    });
  });
}
