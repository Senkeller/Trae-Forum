import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../providers/auth_provider.dart';
import '../../providers/main_provider.dart';
import '../../providers/notification_provider.dart';
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
class MainPage extends ConsumerStatefulWidget {
  /// 构造函数
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  bool _notificationInitialized = false;

  /// 页面列表
  static const List<Widget> _pages = [
    HomePage(),
    TopicsPage(),
    MessagePage(),
    ProfilePageNew(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(mainPageIndexProvider);
    final isAuthenticated = ref.watch(isAuthenticatedProvider);
    final unreadNotificationCount = ref.watch(unreadNotificationCountProvider);

    if (!isAuthenticated) {
      _notificationInitialized = false;
    }
    if (isAuthenticated && !_notificationInitialized) {
      _notificationInitialized = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(notificationNotifierProvider.notifier).loadNotifications();
      });
    }

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: _pages),
      bottomNavigationBar: Semantics(
        label: '底部导航栏',
        child: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) {
            if (index == currentIndex) {
              return;
            }
            HapticFeedbackUtil.trigger(ref, HapticScene.navSwitch);
            ref.read(mainPageIndexProvider.notifier).setIndex(index);
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: '首页',
              tooltip: '切换到首页',
            ),
            NavigationDestination(
              icon: Icon(Icons.forum_outlined),
              selectedIcon: Icon(Icons.forum),
              label: '话题',
              tooltip: '切换到话题页',
            ),
            NavigationDestination(
              icon: _NavIconWithDot(
                icon: const Icon(Icons.message_outlined),
                unreadCount: unreadNotificationCount,
              ),
              selectedIcon: _NavIconWithDot(
                icon: const Icon(Icons.message),
                unreadCount: unreadNotificationCount,
              ),
              label: '消息',
              tooltip: '切换到消息页',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: '我的',
              tooltip: '切换到个人中心',
            ),
          ],
        ),
      ),
    );
  }
}

class _NavIconWithDot extends StatelessWidget {
  const _NavIconWithDot({required this.icon, required this.unreadCount});

  final Widget icon;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final displayCount = unreadCount > 99 ? 99 : unreadCount;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (unreadCount > 0)
          Positioned(
            right: -6,
            top: -4,
            child: Container(
              width: 16,
              height: 16,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$displayCount',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
