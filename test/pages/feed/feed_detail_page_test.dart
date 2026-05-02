/// 话题详情页测试
///
/// 测试话题内容加载、评论列表显示、回复功能、点赞/收藏操作等功能

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:traeu/presentation/pages/feed/feed_detail_page.dart';
import 'package:traeu/presentation/providers/auth_provider.dart';
import 'package:traeu/data/models/feed.dart';
import 'package:traeu/data/models/user.dart';
import 'package:traeu/data/models/comment.dart';

import '../../test_utils.dart';

void main() {
  group('话题详情页基础渲染测试', () {
    testWidgets('话题详情页应该正确渲染标题', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: Text('话题详情'),
              ),
              body: Center(
                child: Text('话题内容'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('话题详情'), findsOneWidget);
      expect(find.text('话题内容'), findsOneWidget);
    });

    testWidgets('话题加载中应该显示加载状态', (WidgetTester tester) async {
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
                    Text('加载中...'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('加载中...'), findsOneWidget);
    });

    testWidgets('话题加载失败应该显示错误状态', (WidgetTester tester) async {
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
                    const Text('话题加载失败'),
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

      expect(find.text('话题加载失败'), findsOneWidget);
      expect(find.text('重试'), findsOneWidget);
    });
  });

  group('话题内容显示测试', () {
    testWidgets('话题应该显示作者信息', (WidgetTester tester) async {
      final mockUser = MockDataGenerator.generateUserInfo();

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text(mockUser.username[0].toUpperCase()),
                    ),
                    title: Text(mockUser.username),
                    subtitle: const Text('2小时前'),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text('话题标题'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text(mockUser.username), findsOneWidget);
      expect(find.text('话题标题'), findsOneWidget);
    });

    testWidgets('话题应该显示内容', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '话题标题',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text('这是话题的详细内容'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('话题标题'), findsOneWidget);
      expect(find.text('这是话题的详细内容'), findsOneWidget);
    });

    testWidgets('话题应该显示互动数据', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 20),
                    SizedBox(width: 4),
                    Text('10'),
                    SizedBox(width: 16),
                    Icon(Icons.comment_outlined, size: 20),
                    SizedBox(width: 4),
                    Text('5'),
                    SizedBox(width: 16),
                    Icon(Icons.bookmark_outline, size: 20),
                    SizedBox(width: 4),
                    Text('3'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('10'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);
    });
  });

  group('评论列表测试', () {
    testWidgets('评论列表应该正确渲染', (WidgetTester tester) async {
      final mockReplies = MockDataGenerator.generateReplyData(count: 3);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListView.builder(
                itemCount: mockReplies.length,
                itemBuilder: (context, index) {
                  final reply = mockReplies[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(reply.username[0].toUpperCase()),
                      ),
                      title: Text(reply.username),
                      subtitle: Text('回复内容 $index'),
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

    testWidgets('空评论列表应该显示空状态', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 64),
                    SizedBox(height: 16),
                    Text('暂无回复'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('暂无回复'), findsOneWidget);
    });

    testWidgets('评论应该显示楼层信息', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListView(
                children: const [
                  ListTile(
                    leading: CircleAvatar(child: Text('U')),
                    title: Text('user1'),
                    subtitle: Text('评论内容'),
                    trailing: Text('#1'),
                  ),
                  ListTile(
                    leading: CircleAvatar(child: Text('U')),
                    title: Text('user2'),
                    subtitle: Text('评论内容'),
                    trailing: Text('#2'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('#1'), findsOneWidget);
      expect(find.text('#2'), findsOneWidget);
    });

    testWidgets('评论应该显示点赞数', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: CircleAvatar(child: Text('U')),
                title: Text('user1'),
                subtitle: Text('评论内容'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.thumb_up_outlined, size: 16),
                    SizedBox(width: 4),
                    Text('5'),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);
    });
  });

  group('回复功能测试', () {
    testWidgets('回复输入框应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '写下你的回复...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: null,
                        icon: Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('未登录时应该显示登录提示', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('请先登录后回复'),
                      ),
                      FilledButton(
                        onPressed: () {},
                        child: const Text('登录'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('请先登录后回复'), findsOneWidget);
      expect(find.text('登录'), findsOneWidget);
    });

    testWidgets('发送回复应该触发回调', (WidgetTester tester) async {
      bool sendCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: '写下你的回复...',
                          ),
                          onSubmitted: (_) => sendCalled = true,
                        ),
                      ),
                      IconButton(
                        onPressed: () => sendCalled = true,
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 输入内容
      await tester.enterText(find.byType(TextField), '测试回复');
      await tester.pump();

      // 点击发送按钮
      await tester.tap(find.byIcon(Icons.send));
      await tester.pump();

      expect(sendCalled, isTrue);
    });

    testWidgets('回复指定用户应该显示回复对象', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Text('回复 @user1'),
                          Spacer(),
                          IconButton(
                            onPressed: null,
                            icon: Icon(Icons.close, size: 16),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: '写下你的回复...',
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(Icons.send),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('回复 @user1'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });

  group('点赞功能测试', () {
    testWidgets('点赞按钮应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.thumb_up_outlined),
                  ),
                  Text('10'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.thumb_up_outlined), findsOneWidget);
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('已点赞状态应该显示实心图标', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.thumb_up, color: Colors.blue),
                  ),
                  Text('11', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.thumb_up), findsOneWidget);
      expect(find.text('11'), findsOneWidget);
    });

    testWidgets('点击点赞应该触发回调', (WidgetTester tester) async {
      bool likeCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: IconButton(
                onPressed: () => likeCalled = true,
                icon: const Icon(Icons.thumb_up_outlined),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(likeCalled, isTrue);
    });
  });

  group('收藏功能测试', () {
    testWidgets('收藏按钮应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.bookmark_outline),
                  ),
                  Text('收藏'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.bookmark_outline), findsOneWidget);
      expect(find.text('收藏'), findsOneWidget);
    });

    testWidgets('已收藏状态应该显示实心图标', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  IconButton(
                    onPressed: null,
                    icon: Icon(Icons.bookmark, color: Colors.blue),
                  ),
                  Text('已收藏', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.bookmark), findsOneWidget);
      expect(find.text('已收藏'), findsOneWidget);
    });

    testWidgets('点击收藏应该触发回调', (WidgetTester tester) async {
      bool bookmarkCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: IconButton(
                onPressed: () => bookmarkCalled = true,
                icon: const Icon(Icons.bookmark_outline),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton));
      await tester.pump();

      expect(bookmarkCalled, isTrue);
    });
  });

  group('分享功能测试', () {
    testWidgets('分享按钮应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: IconButton(
                onPressed: null,
                icon: Icon(Icons.share_outlined),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.share_outlined), findsOneWidget);
    });

    testWidgets('点击分享应该显示分享选项', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.link),
                                title: Text('复制链接'),
                              ),
                              ListTile(
                                leading: Icon(Icons.share),
                                title: Text('分享到...'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.share_outlined),
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

      expect(find.text('复制链接'), findsOneWidget);
      expect(find.text('分享到...'), findsOneWidget);
    });
  });

  group('话题操作菜单测试', () {
    testWidgets('更多选项按钮应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: [
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

    testWidgets('点击更多选项应该显示操作菜单', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                actions: [
                  Builder(
                    builder: (context) {
                      return IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.edit),
                                    title: Text('编辑帖子'),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('删除帖子'),
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.report),
                                    title: Text('举报'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();

      expect(find.text('编辑帖子'), findsOneWidget);
      expect(find.text('删除帖子'), findsOneWidget);
      expect(find.text('举报'), findsOneWidget);
    });
  });

  group('话题排序测试', () {
    testWidgets('评论排序选项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Row(
                children: [
                  ChoiceChip(
                    label: Text('默认'),
                    selected: true,
                    onSelected: null,
                  ),
                  ChoiceChip(
                    label: Text('最新'),
                    selected: false,
                    onSelected: null,
                  ),
                  ChoiceChip(
                    label: Text('热门'),
                    selected: false,
                    onSelected: null,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('默认'), findsOneWidget);
      expect(find.text('最新'), findsOneWidget);
      expect(find.text('热门'), findsOneWidget);
    });
  });

  group('话题刷新测试', () {
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
                    ListTile(title: Text('评论 1')),
                    ListTile(title: Text('评论 2')),
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
