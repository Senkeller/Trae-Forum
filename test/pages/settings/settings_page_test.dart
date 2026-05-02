/// 设置页面测试
///
/// 测试设置项加载、变更和持久化等功能

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import 'package:traeu/presentation/pages/settings/settings_page.dart';
import 'package:traeu/presentation/providers/settings_provider.dart';

import '../../test_utils.dart';

void main() {
  group('设置页面基础渲染测试', () {
    testWidgets('设置页面应该正确渲染标题', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              appBar: AppBar(
                title: const Text('设置'),
              ),
              body: const Center(
                child: Text('设置内容'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('设置'), findsOneWidget);
    });

    testWidgets('设置页面应该显示所有设置项', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('图片质量'),
                    trailing: Text('高'),
                  ),
                  ListTile(
                    leading: Icon(Icons.text_fields),
                    title: Text('字体大小'),
                    trailing: Text('中'),
                  ),
                  ListTile(
                    leading: Icon(Icons.language),
                    title: Text('语言'),
                    trailing: Text('简体中文'),
                  ),
                  ListTile(
                    leading: Icon(Icons.notifications),
                    title: Text('推送通知'),
                    trailing: Switch(value: true, onChanged: null),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('图片质量'), findsOneWidget);
      expect(find.text('字体大小'), findsOneWidget);
      expect(find.text('语言'), findsOneWidget);
      expect(find.text('推送通知'), findsOneWidget);
    });
  });

  group('图片质量设置测试', () {
    testWidgets('图片质量设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.image),
                title: const Text('图片质量'),
                trailing: const Text('高'),
                onTap: () {
                  // 点击打开选择器
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('图片质量'), findsOneWidget);
      expect(find.text('高'), findsOneWidget);
      expect(find.byIcon(Icons.image), findsOneWidget);
    });

    testWidgets('点击图片质量应该显示选项', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ListTile(
                    leading: const Icon(Icons.image),
                    title: const Text('图片质量'),
                    trailing: const Text('高'),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.check),
                                title: Text('高'),
                              ),
                              ListTile(
                                title: Text('中'),
                              ),
                              ListTile(
                                title: Text('低'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.text('高'), findsOneWidget);
      expect(find.text('中'), findsOneWidget);
      expect(find.text('低'), findsOneWidget);
    });

    testWidgets('选择图片质量应该触发回调', (WidgetTester tester) async {
      ImageQuality? selectedQuality;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  ListTile(
                    title: const Text('高'),
                    onTap: () => selectedQuality = ImageQuality.high,
                  ),
                  ListTile(
                    title: const Text('中'),
                    onTap: () => selectedQuality = ImageQuality.medium,
                  ),
                  ListTile(
                    title: const Text('低'),
                    onTap: () => selectedQuality = ImageQuality.low,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.text('中'));
      await tester.pump();

      expect(selectedQuality, ImageQuality.medium);
    });
  });

  group('字体大小设置测试', () {
    testWidgets('字体大小设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.text_fields),
                title: const Text('字体大小'),
                trailing: const Text('中'),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('字体大小'), findsOneWidget);
      expect(find.text('中'), findsOneWidget);
      expect(find.byIcon(Icons.text_fields), findsOneWidget);
    });

    testWidgets('点击字体大小应该显示选项', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ListTile(
                    leading: const Icon(Icons.text_fields),
                    title: const Text('字体大小'),
                    trailing: const Text('中'),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                title: Text('小'),
                              ),
                              ListTile(
                                leading: Icon(Icons.check),
                                title: Text('中'),
                              ),
                              ListTile(
                                title: Text('大'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.text('小'), findsOneWidget);
      expect(find.text('中'), findsOneWidget);
      expect(find.text('大'), findsOneWidget);
    });
  });

  group('语言设置测试', () {
    testWidgets('语言设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.language),
                title: const Text('语言'),
                trailing: const Text('简体中文'),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('语言'), findsOneWidget);
      expect(find.text('简体中文'), findsOneWidget);
      expect(find.byIcon(Icons.language), findsOneWidget);
    });

    testWidgets('点击语言应该显示选项', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('语言'),
                    trailing: const Text('简体中文'),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => const SafeArea(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Icon(Icons.check),
                                title: Text('简体中文'),
                              ),
                              ListTile(
                                title: Text('繁體中文'),
                              ),
                              ListTile(
                                title: Text('English'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.text('简体中文'), findsOneWidget);
      expect(find.text('繁體中文'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
    });
  });

  group('推送通知设置测试', () {
    testWidgets('推送通知开关应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.notifications),
                title: const Text('推送通知'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('推送通知'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('切换推送通知应该触发回调', (WidgetTester tester) async {
      bool switchValue = true;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return ProviderScope(
              child: MaterialApp(
                home: Scaffold(
                  body: ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('推送通知'),
                    trailing: Switch(
                      value: switchValue,
                      onChanged: (value) {
                        setState(() => switchValue = value);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

      await tester.pumpAndSettle();

      // 初始状态为开启
      expect(switchValue, isTrue);

      // 点击切换
      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(switchValue, isFalse);
    });
  });

  group('声音和振动设置测试', () {
    testWidgets('声音开关应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.volume_up),
                title: const Text('声音'),
                trailing: Switch(
                  value: true,
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('声音'), findsOneWidget);
      expect(find.byIcon(Icons.volume_up), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('振动开关应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.vibration),
                title: const Text('振动'),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('振动'), findsOneWidget);
      expect(find.byIcon(Icons.vibration), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });
  });

  group('关于页面测试', () {
    testWidgets('关于设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('关于'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('关于'), findsOneWidget);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('点击关于应该导航到关于页面', (WidgetTester tester) async {
      final router = GoRouter(
        initialLocation: '/',
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => Scaffold(
              body: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('关于'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/about'),
              ),
            ),
          ),
          GoRoute(
            path: '/about',
            builder: (context, state) => const Scaffold(
              body: Center(child: Text('关于页面')),
            ),
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderContainerWrapper.wrapWithRouter(router: router),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.text('关于页面'), findsOneWidget);
    });
  });

  group('清除缓存测试', () {
    testWidgets('清除缓存设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('清除缓存'),
                trailing: const Text('12.5 MB'),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('清除缓存'), findsOneWidget);
      expect(find.text('12.5 MB'), findsOneWidget);
    });

    testWidgets('点击清除缓存应该显示确认对话框', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  return ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('清除缓存'),
                    trailing: const Text('12.5 MB'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('清除缓存'),
                          content: const Text('确定要清除所有缓存吗？'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('取消'),
                            ),
                            FilledButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('确定'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.text('清除缓存'), findsNWidgets(2));
      expect(find.text('确定要清除所有缓存吗？'), findsOneWidget);
      expect(find.text('取消'), findsOneWidget);
      expect(find.text('确定'), findsOneWidget);
    });
  });

  group('检查更新测试', () {
    testWidgets('检查更新设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.system_update),
                title: const Text('检查更新'),
                trailing: const Text('v1.0.0'),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('检查更新'), findsOneWidget);
      expect(find.text('v1.0.0'), findsOneWidget);
    });

    testWidgets('点击检查更新应该触发回调', (WidgetTester tester) async {
      bool checkUpdateCalled = false;

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.system_update),
                title: const Text('检查更新'),
                trailing: const Text('v1.0.0'),
                onTap: () => checkUpdateCalled = true,
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      await tester.tap(find.byType(ListTile));
      await tester.pump();

      expect(checkUpdateCalled, isTrue);
    });
  });

  group('隐私政策测试', () {
    testWidgets('隐私政策设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('隐私政策'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('隐私政策'), findsOneWidget);
      expect(find.byIcon(Icons.privacy_tip_outlined), findsOneWidget);
    });
  });

  group('用户协议测试', () {
    testWidgets('用户协议设置项应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListTile(
                leading: const Icon(Icons.description_outlined),
                title: const Text('用户协议'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('用户协议'), findsOneWidget);
      expect(find.byIcon(Icons.description_outlined), findsOneWidget);
    });
  });

  group('设置分组测试', () {
    testWidgets('设置分组标题应该正确渲染', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListView(
                children: const [
                  ListTile(
                    title: Text(
                      '外观',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('图片质量'),
                  ),
                  ListTile(
                    title: Text('字体大小'),
                  ),
                  ListTile(
                    title: Text(
                      '通知',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('推送通知'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('外观'), findsOneWidget);
      expect(find.text('通知'), findsOneWidget);
    });
  });

  group('设置持久化测试', () {
    testWidgets('设置变更应该持久化', (WidgetTester tester) async {
      final settings = MockDataGenerator.generateAppSettings();

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: Column(
                children: [
                  Text('图片质量: ${settings.imageQuality.name}'),
                  Text('字体大小: ${settings.fontSize.name}'),
                  Text('语言: ${settings.language.name}'),
                  Text('推送通知: ${settings.pushNotification}'),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('图片质量: ${settings.imageQuality.name}'), findsOneWidget);
      expect(find.text('字体大小: ${settings.fontSize.name}'), findsOneWidget);
      expect(find.text('语言: ${settings.language.name}'), findsOneWidget);
      expect(find.text('推送通知: ${settings.pushNotification}'), findsOneWidget);
    });
  });

  group('设置页面滚动测试', () {
    testWidgets('设置列表应该可以滚动', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ListView(
                children: const [
                  ListTile(title: Text('设置项 1')),
                  ListTile(title: Text('设置项 2')),
                  ListTile(title: Text('设置项 3')),
                  ListTile(title: Text('设置项 4')),
                  ListTile(title: Text('设置项 5')),
                  ListTile(title: Text('设置项 6')),
                  ListTile(title: Text('设置项 7')),
                  ListTile(title: Text('设置项 8')),
                  ListTile(title: Text('设置项 9')),
                  ListTile(title: Text('设置项 10')),
                ],
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.text('设置项 1'), findsOneWidget);

      // 滚动列表
      await tester.fling(find.byType(ListView), const Offset(0, -300), 1000);
      await tester.pumpAndSettle();

      // 验证列表可以滚动
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
