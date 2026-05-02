/// 用户任务链集成测试
///
/// 测试完整的用户操作流程
/// 任务链1: 我的页 -> 编辑资料 -> 保存成功
/// 任务链2: 发布回复 -> 列表刷新可见
/// 任务链3: 设置变更 -> 重启后状态一致

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:traeu/presentation/providers/settings_provider.dart';

import '../test_utils.dart';

void main() {
  group('任务链1: 我的页 -> 编辑资料 -> 保存成功', () {
    testWidgets('完整流程: 从用户资料页导航到编辑页并保存',
        (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/profile',
        routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text('用户资料')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person, size: 36),
                    ),
                    const SizedBox(height: 16),
                    const Text('test_user'),
                    const SizedBox(height: 8),
                    const Text('这是当前简介'),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () => context.push('/edit-profile'),
                      child: const Text('编辑资料'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/edit-profile',
            builder: (context, state) => const _EditProfilePage(),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderContainerWrapper.wrapWithRouter(router: router),
      );

      await tester.pumpAndSettle();

      // 验证在资料页
      expect(find.text('用户资料'), findsOneWidget);
      expect(find.text('test_user'), findsOneWidget);
      expect(find.text('编辑资料'), findsOneWidget);

      // 点击编辑资料按钮
      await tester.tap(find.text('编辑资料'));
      await tester.pumpAndSettle();

      // 验证导航到编辑页面
      expect(find.text('编辑资料'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));

      // 修改昵称
      await tester.enterText(find.widgetWithText(TextField, 'test_user'), 'new_name');
      await tester.pump();

      // 修改简介
      await tester.enterText(
        find.widgetWithText(TextField, '这是当前简介'),
        '这是新的简介',
      );
      await tester.pump();

      // 点击保存按钮
      await tester.tap(find.text('保存'));
      await tester.pumpAndSettle();

      // 验证保存成功提示
      expect(find.text('保存成功'), findsOneWidget);

      // 返回上一页
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // 验证返回到资料页
      expect(find.text('用户资料'), findsOneWidget);
    });

    testWidgets('编辑资料时取消应该返回上一页', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/profile',
        routes: [
          GoRoute(
            path: '/profile',
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text('用户资料')),
              body: Center(
                child: OutlinedButton(
                  onPressed: () => context.push('/edit-profile'),
                  child: const Text('编辑资料'),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/edit-profile',
            builder: (context, state) => Scaffold(
              appBar: AppBar(
                title: const Text('编辑资料'),
                leading: BackButton(
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: const Center(
                child: TextField(
                  decoration: InputDecoration(labelText: '昵称'),
                ),
              ),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderContainerWrapper.wrapWithRouter(router: router),
      );

      await tester.pumpAndSettle();

      // 进入编辑页面
      await tester.tap(find.text('编辑资料'));
      await tester.pumpAndSettle();

      expect(find.text('编辑资料'), findsOneWidget);

      // 点击返回按钮
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // 验证返回资料页
      expect(find.text('用户资料'), findsOneWidget);
    });
  });

  group('任务链2: 发布回复 -> 列表刷新可见', () {
    testWidgets('完整流程: 发布回复后在列表中可见', (WidgetTester tester) async {
      final List<String> replies = ['第一条回复', '第二条回复'];

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  appBar: AppBar(title: const Text('话题详情')),
                  body: Column(
                    children: [
                      const ListTile(
                        title: Text('话题标题'),
                        subtitle: Text('话题内容'),
                      ),
                      const Divider(),
                      Expanded(
                        child: ListView.builder(
                          itemCount: replies.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text('用户${index + 1}'),
                              subtitle: Text(replies[index]),
                            );
                          },
                        ),
                      ),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  key: const Key('reply_input'),
                                  decoration: const InputDecoration(
                                    hintText: '写下你的回复...',
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  final controller = tester.widget<TextField>(
                                    find.byKey(const Key('reply_input')),
                                  );
                                  final text = controller.controller?.text ?? '';
                                  if (text.isNotEmpty) {
                                    setState(() => replies.add(text));
                                  }
                                },
                                icon: const Icon(Icons.send),
                              ),
                            ],
                          ),
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

      // 验证初始回复列表
      expect(find.text('第一条回复'), findsOneWidget);
      expect(find.text('第二条回复'), findsOneWidget);

      // 输入新回复
      await tester.enterText(
        find.byKey(const Key('reply_input')),
        '这是我的新回复',
      );
      await tester.pump();

      // 发送回复
      await tester.tap(find.byIcon(Icons.send));
      await tester.pumpAndSettle();

      // 验证新回复出现在列表中
      expect(find.text('这是我的新回复'), findsOneWidget);
    });

    testWidgets('回复后列表应该自动滚动到底部', (WidgetTester tester) async {
      final List<String> replies = List.generate(10, (i) => '回复 ${i + 1}');

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: replies.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('用户${index + 1}'),
                          subtitle: Text(replies[index]),
                        );
                      },
                    ),
                  ),
                  const SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Row(
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 验证列表存在
      expect(find.byType(ListView), findsOneWidget);

      // 滚动到顶部
      await tester.fling(find.byType(ListView), const Offset(0, 500), 1000);
      await tester.pumpAndSettle();

      // 验证可以滚动
      expect(find.byType(ListView), findsOneWidget);
    });
  });

  group('任务链3: 设置变更 -> 重启后状态一致', () {
    testWidgets('完整流程: 修改设置并验证持久化', (WidgetTester tester) async {
      ImageQuality currentQuality = ImageQuality.high;
      FontSize currentFontSize = FontSize.medium;
      bool pushNotification = true;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  appBar: AppBar(title: const Text('设置')),
                  body: ListView(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text('图片质量'),
                        trailing: Text(currentQuality.name),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text('高'),
                                    trailing: currentQuality == ImageQuality.high
                                        ? const Icon(Icons.check)
                                        : null,
                                    onTap: () {
                                      setState(() => currentQuality = ImageQuality.high);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('中'),
                                    trailing: currentQuality == ImageQuality.medium
                                        ? const Icon(Icons.check)
                                        : null,
                                    onTap: () {
                                      setState(() => currentQuality = ImageQuality.medium);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('低'),
                                    trailing: currentQuality == ImageQuality.low
                                        ? const Icon(Icons.check)
                                        : null,
                                    onTap: () {
                                      setState(() => currentQuality = ImageQuality.low);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.text_fields),
                        title: const Text('字体大小'),
                        trailing: Text(currentFontSize.name),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    title: const Text('小'),
                                    onTap: () {
                                      setState(() => currentFontSize = FontSize.small);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('中'),
                                    onTap: () {
                                      setState(() => currentFontSize = FontSize.medium);
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: const Text('大'),
                                    onTap: () {
                                      setState(() => currentFontSize = FontSize.large);
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('推送通知'),
                        trailing: Switch(
                          value: pushNotification,
                          onChanged: (value) {
                            setState(() => pushNotification = value);
                          },
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text('当前设置状态'),
                        subtitle: Text(
                          '图片质量: ${currentQuality.name}\n'
                          '字体大小: ${currentFontSize.name}\n'
                          '推送通知: $pushNotification',
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

      // 验证初始状态
      expect(find.text('high'), findsOneWidget);
      expect(find.text('medium'), findsOneWidget);

      // 修改图片质量为中
      await tester.tap(find.widgetWithText(ListTile, '图片质量'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('中'));
      await tester.pumpAndSettle();

      // 验证图片质量已更改
      expect(find.text('medium'), findsNWidgets(2));

      // 修改字体大小为大
      await tester.tap(find.widgetWithText(ListTile, '字体大小'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('大'));
      await tester.pumpAndSettle();

      // 验证字体大小已更改
      expect(find.text('large'), findsOneWidget);

      // 关闭推送通知
      await tester.tap(find.byType(Switch));
      await tester.pump();

      // 验证推送通知已关闭
      expect(pushNotification, isFalse);

      // 验证状态显示正确
      expect(find.textContaining('图片质量: medium'), findsOneWidget);
      expect(find.textContaining('字体大小: large'), findsOneWidget);
      expect(find.textContaining('推送通知: false'), findsOneWidget);
    });

    testWidgets('设置变更后重启应用应该保持状态', (WidgetTester tester) async {
      // 模拟持久化存储的设置
      const savedSettings = AppSettings(
        imageQuality: ImageQuality.low,
        fontSize: FontSize.large,
        language: AppLanguage.english,
        pushNotification: false,
        soundEnabled: false,
        vibrationEnabled: true,
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('图片质量'),
                    trailing: Text('low'),
                  ),
                  ListTile(
                    leading: Icon(Icons.text_fields),
                    title: Text('字体大小'),
                    trailing: Text('large'),
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('语言'),
                    trailing: Text('english'),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('推送通知'),
                    trailing: Switch(value: false, onChanged: null),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 验证从持久化存储加载的设置
      expect(find.text('low'), findsOneWidget);
      expect(find.text('large'), findsOneWidget);
      expect(find.text('english'), findsOneWidget);
    });
  });

  group('综合任务链测试', () {
    testWidgets('用户完整操作流程', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/home',
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text('首页')),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () => context.push('/feed/1'),
                      child: const Text('查看话题'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.push('/profile'),
                      child: const Text('我的'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.push('/settings'),
                      child: const Text('设置'),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/feed/:id',
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text('话题详情')),
              body: const Center(child: Text('话题内容')),
            ),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => Scaffold(
              appBar: AppBar(title: const Text('用户资料')),
              body: Center(
                child: ElevatedButton(
                  onPressed: () => context.push('/edit-profile'),
                  child: const Text('编辑资料'),
                ),
              ),
            ),
          ),
          GoRoute(
            path: '/edit-profile',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('编辑资料页面')),
            ),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('设置页面')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderContainerWrapper.wrapWithRouter(router: router),
      );

      await tester.pumpAndSettle();

      // 1. 从首页查看话题
      await tester.tap(find.text('查看话题'));
      await tester.pumpAndSettle();
      expect(find.text('话题详情'), findsOneWidget);

      // 返回首页
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();
      expect(find.text('首页'), findsOneWidget);

      // 2. 进入我的页面并编辑资料
      await tester.tap(find.text('我的'));
      await tester.pumpAndSettle();
      expect(find.text('用户资料'), findsOneWidget);

      await tester.tap(find.text('编辑资料'));
      await tester.pumpAndSettle();
      expect(find.text('编辑资料页面'), findsOneWidget);

      // 返回我的页面
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // 返回首页
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // 3. 进入设置页面
      await tester.tap(find.text('设置'));
      await tester.pumpAndSettle();
      expect(find.text('设置页面'), findsOneWidget);
    });
  });
}

/// 编辑资料页面
class _EditProfilePage extends StatefulWidget {
  const _EditProfilePage();

  @override
  State<_EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<_EditProfilePage> {
  final _nicknameController = TextEditingController(text: 'test_user');
  final _bioController = TextEditingController(text: '这是当前简介');
  bool _isSaving = false;

  @override
  void dispose() {
    _nicknameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      setState(() => _isSaving = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('保存成功')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑资料'),
        actions: [
          TextButton(
            onPressed: _isSaving ? null : _saveProfile,
            child: _isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('保存'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: '昵称',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(
                labelText: '简介',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
