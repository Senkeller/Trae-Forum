import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/main_provider.dart';
import '../home/home_page.dart';
import '../message/message_page.dart';
import '../topics/topics_page.dart';
import '../user/profile_page_new.dart';

/// 主页面
///
/// 应用的主入口页面，包含底部导航栏和四个主要页面：
/// - 首页：Feed 流列表
/// - 话题：话题聚合页面
/// - 消息：消息通知列表
/// - 我的：用户个人中心
class MainPage extends ConsumerWidget {
  /// 构造函数
  const MainPage({super.key});

  /// 页面列表
  static const List<Widget> _pages = [
    HomePage(),
    TopicsPage(),
    MessagePage(),
    ProfilePageNew(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainPageIndexProvider);

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          if (index == currentIndex) {
            return;
          }
          HapticFeedbackUtil.trigger(ref, HapticScene.navSwitch);
          ref.read(mainPageIndexProvider.notifier).setIndex(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.forum_outlined),
            selectedIcon: Icon(Icons.forum),
            label: '话题',
          ),
          NavigationDestination(
            icon: Icon(Icons.message_outlined),
            selectedIcon: Icon(Icons.message),
            label: '消息',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
