/// 测试工具类
///
/// 提供测试基类、Mock数据生成器和Provider容器包装器
/// 用于简化Widget测试的编写

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:traeu/data/models/feed.dart';
import 'package:traeu/data/models/user.dart';
import 'package:traeu/data/models/comment.dart';
import 'package:traeu/presentation/providers/settings_provider.dart';

/// Mock 数据生成器
///
/// 用于生成测试所需的Mock数据
class MockDataGenerator {
  /// 生成测试用的 HomeFeedData 列表
  ///
  /// [count] 生成的数量
  /// @return HomeFeedData 列表
  static List<HomeFeedData> generateFeedItems({int count = 5}) {
    return List.generate(count, (index) => generateFeedItem(index));
  }

  /// 生成单个 HomeFeedData
  ///
  /// [index] 索引，用于生成不同的数据
  /// @return HomeFeedData 实例
  static HomeFeedData generateFeedItem(int index) {
    return HomeFeedData(
      id: 'feed_$index',
      entityType: 'topic',
      title: '测试标题 $index',
      message: '这是测试内容 $index，用于Widget测试。',
      userInfo: UserInfo(
        uid: 'uid_$index',
        username: 'test_user_$index',
        avatar: 'https://example.com/avatar_$index.jpg',
      ),
      dateline: '${DateTime.now().millisecondsSinceEpoch ~/ 1000 - index * 3600}',
      replyNum: index * 5,
      forwardNum: index,
    );
  }

  /// 生成测试用的 UserInfo
  ///
  /// @return UserInfo 实例
  static UserInfo generateUserInfo() {
    return const UserInfo(
      uid: 'test_uid_123',
      username: 'test_user',
      avatar: 'https://example.com/avatar.jpg',
    );
  }

  /// 生成测试用的 UserProfile
  ///
  /// [userInfo] 用户信息
  /// @return UserProfile 实例
  static UserProfile generateUserProfile({UserInfo? userInfo}) {
    return UserProfile(
      userInfo: userInfo ?? generateUserInfo(),
      action: const UserAction(),
      feedCount: 10,
      replyCount: 5,
    );
  }

  /// 生成测试用的 ReplyData 列表
  ///
  /// [count] 生成的数量
  /// @return ReplyData 列表
  static List<ReplyData> generateReplyData({int count = 5}) {
    return List.generate(count, (index) => generateReply(index));
  }

  /// 生成单个 ReplyData
  ///
  /// [index] 索引
  /// @return ReplyData 实例
  static ReplyData generateReply(int index) {
    return ReplyData(
      id: 'reply_$index',
      uid: 'user_$index',
      username: 'reply_user_$index',
      avatar: 'https://example.com/avatar_$index.jpg',
      message: '<p>这是回复内容 $index</p>',
      dateline: '${DateTime.now().millisecondsSinceEpoch ~/ 1000 - index * 60}',
      likeNum: index * 2,
      replyNum: index,
      postNumber: index + 1,
      isLike: index % 2 == 0,
    );
  }

  /// 生成测试用的 FeedContentData
  ///
  /// @return FeedContentData 实例
  static FeedContentData generateFeedContentData() {
    return FeedContentData(
      id: '123',
      entityType: 'topic',
      title: '测试话题标题',
      message: '<p>这是测试话题的内容</p>',
      picArr: const [],
      userInfo: generateUserInfo(),
      action: const UserAction(
        isLike: false,
        isFavorite: false,
        likeNum: 10,
        favoriteNum: 5,
      ),
      dateline: '${DateTime.now().millisecondsSinceEpoch ~/ 1000}',
      replyNum: 20,
      forwardNum: 0,
    );
  }

  /// 生成测试用的 AppSettings
  ///
  /// @return AppSettings 实例
  static AppSettings generateAppSettings() {
    return const AppSettings(
      imageQuality: ImageQuality.high,
      fontSize: FontSize.medium,
      language: AppLanguage.simplifiedChinese,
      pushNotification: true,
      soundEnabled: true,
      vibrationEnabled: true,
    );
  }
}

/// Provider 容器包装器
///
/// 用于在测试中包装Widget并提供ProviderScope
class ProviderContainerWrapper {
  /// 创建带 ProviderScope 的测试 Widget
  ///
  /// [child] 被包装的子Widget
  /// [overrides] 需要覆盖的Provider
  /// @return ProviderScope 包装的Widget
  static Widget wrap({
    required Widget child,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  /// 创建带 Router 的 ProviderScope 包装
  ///
  /// [router] GoRouter 实例
  /// [overrides] 需要覆盖的Provider
  /// @return ProviderScope 包装的MaterialApp.router
  static Widget wrapWithRouter({
    required GoRouter router,
    List<Override> overrides = const [],
  }) {
    return ProviderScope(
      overrides: overrides,
      child: MaterialApp.router(
        routerConfig: router,
      ),
    );
  }
}

/// 测试路由构建器
///
/// 用于构建测试用的路由配置
class TestRouterBuilder {
  /// 构建基础测试路由
  ///
  /// [initialLocation] 初始路由
  /// [routes] 路由列表
  /// @return GoRouter 实例
  static GoRouter build({
    String initialLocation = '/',
    required List<GoRoute> routes,
  }) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: routes,
    );
  }

  /// 构建带主页的路由
  ///
  /// [homeBuilder] 主页构建器
  /// @return GoRouter 实例
  static GoRouter buildWithHome({
    required Widget Function(BuildContext, GoRouterState) homeBuilder,
  }) {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: homeBuilder,
        ),
      ],
    );
  }
}

/// Widget 测试扩展
///
/// 提供便捷的Widget测试方法
extension WidgetTesterExtension on WidgetTester {
  /// 异步泵送并等待 settle
  ///
  /// [widget] 要泵送的Widget
  Future<void> pumpWidgetAndSettle(Widget widget) async {
    await pumpWidget(widget);
    await pumpAndSettle();
  }

  /// 带超时的 pumpAndSettle
  ///
  /// [timeout] 超时时间
  Future<void> pumpAndSettleWithTimeout({
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final startTime = DateTime.now();
    while (true) {
      if (DateTime.now().difference(startTime) > timeout) {
        break;
      }
      await pump(const Duration(milliseconds: 100));
      if (!binding.hasScheduledFrame) {
        break;
      }
    }
  }

  /// 查找并点击 Widget
  ///
  /// [finder] Widget查找器
  Future<void> tapAndSettle(Finder finder) async {
    await tap(finder);
    await pumpAndSettle();
  }

  /// 滚动列表到指定位置
  ///
  /// [listFinder] 列表Finder
  /// [offset] 滚动偏移
  Future<void> scrollList(Finder listFinder, double offset) async {
    await drag(listFinder, Offset(0, offset));
    await pumpAndSettle();
  }
}

/// Mock 类
///
/// 用于测试中替代真实依赖
class MockBuildContext extends Mock implements BuildContext {}

class MockWidgetRef extends Mock implements WidgetRef {}

/// 测试常量
///
/// 定义测试中使用的常量
class TestConstants {
  /// 默认等待时间
  static const Duration defaultWait = Duration(milliseconds: 100);

  /// 动画完成等待时间
  static const Duration animationWait = Duration(milliseconds: 300);

  /// 网络请求模拟等待时间
  static const Duration networkWait = Duration(milliseconds: 500);

  /// 测试用的 Feed ID
  static const String testFeedId = 'test_feed_123';

  /// 测试用的用户名
  static const String testUsername = 'test_user';

  /// 测试用的用户ID
  static const String testUserId = 'test_uid_123';
}

/// 测试匹配器
///
/// 自定义的Widget测试匹配器
class TestMatchers {
  /// 匹配包含指定文本的Widget
  static Matcher containsText(String text) {
    return findsWidgets;
  }

  /// 匹配指定类型的Widget至少有一个
  static Matcher hasWidgetOfType<T extends Widget>() {
    return findsOneWidget;
  }
}
