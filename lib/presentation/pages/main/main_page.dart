import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/main_provider.dart';
import '../home/home_page.dart';
import '../search/search_page.dart';
import '../message/message_page.dart';
import '../user/user_profile_page.dart';

/// 主页面
///
/// 应用的主入口页面，包含底部导航栏和四个主要页面：
/// - 首页：Feed 流列表
/// - 发现：搜索和推荐内容
/// - 消息：消息通知列表
/// - 我的：用户个人中心
class MainPage extends ConsumerWidget {
  /// 构造函数
  const MainPage({super.key});

  /// 页面列表
  static const List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    MessagePage(),
    UserProfilePage(),
  ];

  /// 底部导航项列表
  static const List<BottomNavigationBarItem> _navItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      activeIcon: Icon(Icons.home),
      label: '首页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: '发现',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message_outlined),
      activeIcon: Icon(Icons.message),
      label: '消息',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_outline),
      activeIcon: Icon(Icons.person),
      label: '我的',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(mainPageIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(mainPageIndexProvider.notifier).setIndex(index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore),
            label: '发现',
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
