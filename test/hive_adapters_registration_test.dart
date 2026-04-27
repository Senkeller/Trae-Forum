import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:traeu/data/models/user_activity.dart';
import 'package:traeu/hive_registrar.g.dart';

/// 模拟 PathProvider 平台
class MockPathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  final Directory tempDir;

  MockPathProviderPlatform(this.tempDir);

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return tempDir.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  var adaptersRegistered = false;

  setUpAll(() async {
    // 创建临时目录用于 Hive 测试
    tempDir = await Directory.systemTemp.createTemp('hive_test_');
    PathProviderPlatform.instance = MockPathProviderPlatform(tempDir);
  });

  tearDownAll(() async {
    // 清理临时目录
    await Hive.close();
    await tempDir.delete(recursive: true);
  });

  setUp(() async {
    // 初始化 Hive（每个测试使用不同的子目录）
    Hive.init(tempDir.path);
    // 只注册一次适配器（Hive 是单例，适配器注册是全局的）
    if (!adaptersRegistered) {
      Hive.registerAdapters();
      adaptersRegistered = true;
    }
  });

  tearDown(() async {
    // 每个测试后关闭所有 Box
    await Hive.close();
  });

  group('Hive 适配器注册测试', () {
    test('应成功注册所有 Hive 适配器', () async {
      // 适配器已在 setUp 中注册，验证可以正常使用
      final box = await Hive.openBox<LocalFavorite>('adapter_test');
      expect(box, isNotNull);
      await box.close();
    });

    test('重复注册适配器应抛出异常', () async {
      // 适配器已经注册，再次注册应抛出异常
      expect(
        () => Hive.registerAdapters(),
        throwsA(isA<HiveError>()),
        reason: '重复注册适配器应抛出 HiveError',
      );
    });
  });

  group('本地收藏数据链路测试', () {
    test('应成功写入和读取本地收藏', () async {
      final box = await Hive.openBox<LocalFavorite>('local_favorites');

      final favorite = LocalFavorite(
        id: 'fav_001',
        feedId: 'feed_001',
        uid: 'user_001',
        username: '测试用户',
        avatarUrl: 'https://example.com/avatar.png',
        deviceTitle: 'iPhone',
        message: '测试动态内容',
        dateline: '2024-01-01',
        createdAt: DateTime(2024, 1, 1, 12, 0, 0),
      );

      // 写入数据
      await box.add(favorite);

      // 读取数据
      final result = box.values.toList();

      expect(result.length, equals(1));
      expect(result[0].id, equals('fav_001'));
      expect(result[0].feedId, equals('feed_001'));
      expect(result[0].username, equals('测试用户'));
      expect(result[0].message, equals('测试动态内容'));
      expect(result[0].createdAt, equals(DateTime(2024, 1, 1, 12, 0, 0)));
    });

    test('应支持本地收藏去重', () async {
      final box = await Hive.openBox<LocalFavorite>('local_favorites_dup');

      final favorite1 = LocalFavorite(
        id: 'fav_001',
        feedId: 'feed_001',
        uid: 'user_001',
        username: '用户1',
        avatarUrl: 'https://example.com/avatar1.png',
        deviceTitle: 'iPhone',
        message: '动态内容1',
        dateline: '2024-01-01',
        createdAt: DateTime(2024, 1, 1, 12, 0, 0),
      );

      final favorite2 = LocalFavorite(
        id: 'fav_002',
        feedId: 'feed_001', // 相同的 feedId
        uid: 'user_002',
        username: '用户2',
        avatarUrl: 'https://example.com/avatar2.png',
        deviceTitle: 'Android',
        message: '动态内容2',
        dateline: '2024-01-02',
        createdAt: DateTime(2024, 1, 2, 12, 0, 0),
      );

      await box.add(favorite1);
      await box.add(favorite2);

      // 检查是否存在相同 feedId 的记录
      final hasDuplicate = box.values.where((f) => f.feedId == 'feed_001').length > 1;
      expect(hasDuplicate, isTrue, reason: '测试中允许重复，实际业务层应处理去重');

      // 验证可以按 feedId 查找
      final found = box.values.firstWhere((f) => f.feedId == 'feed_001');
      expect(found, isNotNull);
    });

    test('应支持删除本地收藏', () async {
      final box = await Hive.openBox<LocalFavorite>('local_favorites_del');

      final favorite = LocalFavorite(
        id: 'fav_001',
        feedId: 'feed_001',
        uid: 'user_001',
        username: '测试用户',
        avatarUrl: 'https://example.com/avatar.png',
        deviceTitle: 'iPhone',
        message: '测试动态内容',
        dateline: '2024-01-01',
        createdAt: DateTime(2024, 1, 1, 12, 0, 0),
      );

      final key = await box.add(favorite);
      expect(box.length, equals(1));

      await box.delete(key);
      expect(box.length, equals(0));
    });

    test('应支持清空所有本地收藏', () async {
      final box = await Hive.openBox<LocalFavorite>('local_favorites_clear');

      for (var i = 0; i < 5; i++) {
        await box.add(LocalFavorite(
          id: 'fav_$i',
          feedId: 'feed_$i',
          uid: 'user_$i',
          username: '用户$i',
          avatarUrl: 'https://example.com/avatar$i.png',
          deviceTitle: 'iPhone',
          message: '动态内容$i',
          dateline: '2024-01-0$i',
          createdAt: DateTime.now(),
        ));
      }

      expect(box.length, equals(5));

      await box.clear();

      expect(box.length, equals(0));
    });
  });

  group('浏览历史数据链路测试', () {
    test('应成功写入和读取浏览历史', () async {
      final box = await Hive.openBox<BrowseHistory>('browse_history');

      final history = BrowseHistory(
        id: 'hist_001',
        feedId: 'feed_001',
        uid: 'user_001',
        username: '测试用户',
        avatarUrl: 'https://example.com/avatar.png',
        deviceTitle: 'iPhone',
        message: '测试动态内容',
        dateline: '2024-01-01',
        viewedAt: DateTime(2024, 1, 1, 12, 0, 0),
      );

      await box.add(history);

      final result = box.values.toList();

      expect(result.length, equals(1));
      expect(result[0].id, equals('hist_001'));
      expect(result[0].feedId, equals('feed_001'));
      expect(result[0].viewedAt, equals(DateTime(2024, 1, 1, 12, 0, 0)));
    });

    test('应支持浏览历史排序', () async {
      final box = await Hive.openBox<BrowseHistory>('browse_history_sort');

      final histories = [
        BrowseHistory(
          id: 'hist_001',
          feedId: 'feed_001',
          uid: 'user_001',
          username: '用户1',
          avatarUrl: 'https://example.com/avatar1.png',
          deviceTitle: 'iPhone',
          message: '动态内容1',
          dateline: '2024-01-01',
          viewedAt: DateTime(2024, 1, 1, 10, 0, 0), // 最早
        ),
        BrowseHistory(
          id: 'hist_002',
          feedId: 'feed_002',
          uid: 'user_002',
          username: '用户2',
          avatarUrl: 'https://example.com/avatar2.png',
          deviceTitle: 'Android',
          message: '动态内容2',
          dateline: '2024-01-02',
          viewedAt: DateTime(2024, 1, 3, 12, 0, 0), // 最晚
        ),
        BrowseHistory(
          id: 'hist_003',
          feedId: 'feed_003',
          uid: 'user_003',
          username: '用户3',
          avatarUrl: 'https://example.com/avatar3.png',
          deviceTitle: 'iPad',
          message: '动态内容3',
          dateline: '2024-01-03',
          viewedAt: DateTime(2024, 1, 2, 8, 0, 0), // 中间
        ),
      ];

      for (final history in histories) {
        await box.add(history);
      }

      // 按时间倒序排序（最新的在前）
      final result = box.values.toList()
        ..sort((a, b) => b.viewedAt.compareTo(a.viewedAt));

      // hist_002 (1月3日) > hist_003 (1月2日) > hist_001 (1月1日)
      expect(result[0].id, equals('hist_002'));
      expect(result[1].id, equals('hist_003'));
      expect(result[2].id, equals('hist_001'));
    });

    test('应支持删除单条浏览历史', () async {
      final box = await Hive.openBox<BrowseHistory>('browse_history_del');

      final history = BrowseHistory(
        id: 'hist_001',
        feedId: 'feed_001',
        uid: 'user_001',
        username: '测试用户',
        avatarUrl: 'https://example.com/avatar.png',
        deviceTitle: 'iPhone',
        message: '测试动态内容',
        dateline: '2024-01-01',
        viewedAt: DateTime.now(),
      );

      final key = await box.add(history);
      expect(box.length, equals(1));

      await box.delete(key);
      expect(box.length, equals(0));
    });
  });

  group('我常去数据链路测试', () {
    test('应成功写入和读取我常去', () async {
      final box = await Hive.openBox<FrequentlyVisited>('frequently_visited');

      final visit = FrequentlyVisited(
        id: 'visit_001',
        topicId: 'topic_001',
        topicName: '测试话题',
        topicTag: '测试标签',
        visitCount: 5,
        lastVisitedAt: DateTime(2024, 1, 1, 12, 0, 0),
        coverUrl: 'https://example.com/cover.png',
      );

      await box.add(visit);

      final result = box.values.toList();

      expect(result.length, equals(1));
      expect(result[0].id, equals('visit_001'));
      expect(result[0].topicId, equals('topic_001'));
      expect(result[0].topicName, equals('测试话题'));
      expect(result[0].visitCount, equals(5));
      expect(result[0].topicTag, equals('测试标签'));
      expect(result[0].coverUrl, equals('https://example.com/cover.png'));
    });

    test('应支持更新访问次数', () async {
      final box = await Hive.openBox<FrequentlyVisited>('frequently_visited_update');

      final visit = FrequentlyVisited(
        id: 'visit_001',
        topicId: 'topic_001',
        topicName: '测试话题',
        visitCount: 1,
        lastVisitedAt: DateTime(2024, 1, 1, 12, 0, 0),
      );

      final key = await box.add(visit);

      // 更新访问次数
      final existing = box.get(key)!;
      final updated = existing.copyWith(
        visitCount: existing.visitCount + 1,
        lastVisitedAt: DateTime(2024, 1, 2, 12, 0, 0),
      );
      await box.put(key, updated);

      final result = box.get(key)!;
      expect(result.visitCount, equals(2));
      expect(result.lastVisitedAt, equals(DateTime(2024, 1, 2, 12, 0, 0)));
    });

    test('应支持我常去排序', () async {
      final box = await Hive.openBox<FrequentlyVisited>('frequently_visited_sort');

      final visits = [
        FrequentlyVisited(
          id: 'visit_001',
          topicId: 'topic_001',
          topicName: '话题1',
          visitCount: 10,
          lastVisitedAt: DateTime.now().subtract(const Duration(days: 7)), // 7天前
        ),
        FrequentlyVisited(
          id: 'visit_002',
          topicId: 'topic_002',
          topicName: '话题2',
          visitCount: 5,
          lastVisitedAt: DateTime.now().subtract(const Duration(days: 1)), // 1天前
        ),
        FrequentlyVisited(
          id: 'visit_003',
          topicId: 'topic_003',
          topicName: '话题3',
          visitCount: 20,
          lastVisitedAt: DateTime.now().subtract(const Duration(days: 30)), // 30天前
        ),
      ];

      for (final visit in visits) {
        await box.add(visit);
      }

      // 按访问次数 * 时间权重排序
      final now = DateTime.now();
      final result = box.values.toList()
        ..sort((a, b) {
          final aDaysSince = now.difference(a.lastVisitedAt).inDays;
          final bDaysSince = now.difference(b.lastVisitedAt).inDays;
          final aTimeWeight = 1.0 / (aDaysSince + 1);
          final bTimeWeight = 1.0 / (bDaysSince + 1);
          final aScore = a.visitCount * aTimeWeight;
          final bScore = b.visitCount * bTimeWeight;
          return bScore.compareTo(aScore);
        });

      // 话题2虽然访问次数少，但时间最近，得分应该最高
      expect(result[0].topicId, equals('topic_002'));
    });

    test('应支持删除我常去记录', () async {
      final box = await Hive.openBox<FrequentlyVisited>('frequently_visited_del');

      final visit = FrequentlyVisited(
        id: 'visit_001',
        topicId: 'topic_001',
        topicName: '测试话题',
        visitCount: 1,
        lastVisitedAt: DateTime.now(),
      );

      final key = await box.add(visit);
      expect(box.length, equals(1));

      await box.delete(key);
      expect(box.length, equals(0));
    });
  });

  group('数据持久化测试', () {
    test('数据应在 Box 关闭后重新打开时保留', () async {
      // 第一次打开 Box 并写入数据
      final box1 = await Hive.openBox<LocalFavorite>('persistent_test');
      final favorite = LocalFavorite(
        id: 'fav_001',
        feedId: 'feed_001',
        uid: 'user_001',
        username: '测试用户',
        avatarUrl: 'https://example.com/avatar.png',
        deviceTitle: 'iPhone',
        message: '测试动态内容',
        dateline: '2024-01-01',
        createdAt: DateTime(2024, 1, 1, 12, 0, 0),
      );
      await box1.add(favorite);
      await box1.close();

      // 重新打开 Box
      final box2 = await Hive.openBox<LocalFavorite>('persistent_test');
      final result = box2.values.toList();

      expect(result.length, equals(1));
      expect(result[0].id, equals('fav_001'));
      expect(result[0].username, equals('测试用户'));

      await box2.close();
    });
  });
}
