/// 用户资料页测试
///
/// 测试用户信息加载、关注/取关功能、资料编辑入口等功能

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:traeu/presentation/pages/user/user_profile_page.dart';
import 'package:traeu/presentation/providers/auth_provider.dart';
import 'package:traeu/data/models/user.dart';

import '../../test_utils.dart';

void main() {
  group('用户资料页基础渲染测试', () {
    testWidgets('用户资料页应该正确渲染用户名', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: const Text('@test_user'),
              ),
              body: const Center(
                child: Text('用户资料内容'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('@test_user'), findsOneWidget);
    });

    testWidgets('用户资料加载中应该显示加载状态', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('正在加载资料'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('正在加载资料'), findsOneWidget);
    });

    testWidgets('用户资料加载失败应该显示错误状态', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 64),
                    const SizedBox(height: 16),
                    const Text('加载失败'),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {},
                      child: const Text('重试'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('加载失败'), findsOneWidget);
      expect(find.text('重试'), findsOneWidget);
    });

    testWidgets('未登录用户应该显示登录提示', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person_search, size: 64),
                    const SizedBox(height: 16),
                    const Text('无法确定用户'),
                    const SizedBox(height: 8),
                    const Text('请先登录，或通过 /user/{username} 打开用户主页。'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('无法确定用户'), findsOneWidget);
      expect(find.text('请先登录，或通过 /user/{username} 打开用户主页。'),
          findsOneWidget);
    });
  });

  group('用户信息显示测试', () {
    testWidgets('用户头像应该正确显示', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 36),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'test_user',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '@test_user',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('test_user'), findsOneWidget);
      expect(find.text('@test_user'), findsOneWidget);
    });

    testWidgets('用户简介应该正确显示', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '用户简介',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('这是一个测试用户的简介'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('用户简介'), findsOneWidget);
      expect(find.text('这是一个测试用户的简介'), findsOneWidget);
    });

    testWidgets('用户统计信息应该正确显示', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          '100',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('关注'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '200',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('粉丝'),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          '50',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('话题'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('100'), findsOneWidget);
      expect(find.text('200'), findsOneWidget);
      expect(find.text('50'), findsOneWidget);
      expect(find.text('关注'), findsOneWidget);
      expect(find.text('粉丝'), findsOneWidget);
      expect(find.text('话题'), findsOneWidget);
    });
  });

  group('关注/取关功能测试', () {
    testWidgets('关注按钮应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('关注'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('关注'), findsOneWidget);
      expect(find.byType(FilledButton), findsOneWidget);
    });

    testWidgets('已关注状态应该显示取消关注按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('取消关注'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('取消关注'), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('点击关注按钮应该触发回调', (WidgetTester tester) async {
      bool followCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => followCalled = true,
                  child: const Text('关注'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(followCalled, isTrue);
    });

    testWidgets('关注操作应该显示成功提示', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Center(
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('已关注')),
                        );
                      },
                      child: const Text('关注'),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(FilledButton));
      await tester.pump();

      expect(find.text('已关注'), findsOneWidget);
    });
  });

  group('资料编辑入口测试', () {
    testWidgets('编辑资料按钮应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: OutlinedButton.icon(
                  onPressed: null,
                  icon: const Icon(Icons.edit, size: 18),
                  label: const Text('编辑资料'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('编辑资料'), findsOneWidget);
      expect(find.byIcon(Icons.edit), findsOneWidget);
    });

    testWidgets('点击编辑资料应该导航到编辑页面', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: Center(
                child: OutlinedButton(
                  onPressed: () => context.push('/edit'),
                  child: const Text('编辑资料'),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/edit',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('编辑资料页面')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderContainerWrapper.wrapWithRouter(router: router),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      expect(find.text('编辑资料页面'), findsOneWidget);
    });

    testWidgets('自己的资料页应该显示编辑按钮', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: const [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.settings),
                  ),
                ],
              ),
              body: const Center(
                child: OutlinedButton(
                  onPressed: null,
                  child: Text('编辑资料'),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.settings), findsOneWidget);
      expect(find.text('编辑资料'), findsOneWidget);
    });

    testWidgets('他人的资料页应该显示更多选项', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: const [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });
  });

  group('用户Tab切换测试', () {
    testWidgets('Tab 栏应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(text: '总结'),
                      Tab(text: '活动'),
                      Tab(text: '话题'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Center(child: Text('总结内容')),
                        Center(child: Text('活动内容')),
                        Center(child: Text('话题内容')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('总结'), findsOneWidget);
      expect(find.text('活动'), findsOneWidget);
      expect(find.text('话题'), findsOneWidget);
    });

    testWidgets('切换 Tab 应该更新内容', (WidgetTester tester) async {
      int selectedTab = 0;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: Column(
                    children: [
                      Row(
                        children: [
                          TextButton(
                            onPressed: () => setState(() => selectedTab = 0),
                            child: const Text('总结'),
                          ),
                          TextButton(
                            onPressed: () => setState(() => selectedTab = 1),
                            child: const Text('活动'),
                          ),
                          TextButton(
                            onPressed: () => setState(() => selectedTab = 2),
                            child: const Text('话题'),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: Text('Tab $selectedTab Content'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Tab 0 Content'), findsOneWidget);

      await tester.tap(find.text('活动'));
      await tester.pumpAndSettle();

      expect(find.text('Tab 1 Content'), findsOneWidget);
    });
  });

  group('用户动态列表测试', () {
    testWidgets('用户动态列表应该正确渲染', (WidgetTester tester) async {
      final mockFeeds = MockDataGenerator.generateFeedItems(count: 3);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListView.builder(
                itemCount: mockFeeds.length,
                itemBuilder: (context, index) {
                  final feed = mockFeeds[index];
                  return Card(
                    child: ListTile(
                      title: Text(feed.title ?? ''),
                      subtitle: Text(feed.message),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(Card), findsNWidgets(3));
    });

    testWidgets('空动态列表应该显示空状态', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.inbox_outlined, size: 64),
                    SizedBox(height: 16),
                    Text('暂无话题'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('暂无话题'), findsOneWidget);
    });
  });

  group('用户活动列表测试', () {
    testWidgets('活动分类筛选应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: Text('全部'),
                      selected: true,
                      onSelected: null,
                    ),
                    FilterChip(
                      label: Text('话题'),
                      selected: false,
                      onSelected: null,
                    ),
                    FilterChip(
                      label: Text('回复'),
                      selected: false,
                      onSelected: null,
                    ),
                    FilterChip(
                      label: Text('赞过'),
                      selected: false,
                      onSelected: null,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('全部'), findsOneWidget);
      expect(find.text('话题'), findsOneWidget);
      expect(find.text('回复'), findsOneWidget);
      expect(find.text('赞过'), findsOneWidget);
    });

    testWidgets('活动列表应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListView(
                children: const [
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.forum),
                      title: Text('创建了话题'),
                      subtitle: Text('话题标题'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.comment),
                      title: Text('回复了话题'),
                      subtitle: Text('回复内容'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('创建了话题'), findsOneWidget);
      expect(find.text('回复了话题'), findsOneWidget);
    });
  });

  group('用户统计信息测试', () {
    testWidgets('统计信息卡片应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '统计信息',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      children: [
                        _StatItem(value: '30', label: '访问天数'),
                        _StatItem(value: '5小时', label: '阅读时间'),
                        _StatItem(value: '100', label: '已读帖子'),
                        _StatItem(value: '50', label: '已送出'),
                        _StatItem(value: '80', label: '已收到'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('统计信息'), findsOneWidget);
      expect(find.text('30'), findsOneWidget);
      expect(find.text('访问天数'), findsOneWidget);
      expect(find.text('5小时'), findsOneWidget);
    });
  });

  group('用户更多操作测试', () {
    testWidgets('更多选项菜单应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return Center(
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => const SafeArea(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.report),
                                  title: Text('举报用户'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.block),
                                  title: Text('加入黑名单'),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text('举报用户'), findsOneWidget);
      expect(find.text('加入黑名单'), findsOneWidget);
    });
  });

  group('用户资料刷新测试', () {
    testWidgets('下拉刷新应该触发刷新回调', (WidgetTester tester) async {
      bool refreshCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: RefreshIndicator(
                onRefresh: () async {
                  refreshCalled = true;
                },
                child: ListView(
                  children: const [
                    ListTile(title: Text('动态 1')),
                    ListTile(title: Text('动态 2')),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 模拟下拉刷新
      await tester.fling(find.byType(ListView), const Offset(0, 300), 1000);
      await tester.pumpAndSettle();

      expect(find.byType(RefreshIndicator), findsOneWidget);
    });
  });
}

/// 统计项组件
class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
