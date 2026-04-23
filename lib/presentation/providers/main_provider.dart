import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 底部导航栏当前索引状态
///
/// 使用 StateNotifier 管理底部导航栏的当前选中索引
/// 支持持久化（可选）
class MainPageIndexNotifier extends StateNotifier<int> {
  /// 构造函数，初始索引为 0（首页）
  MainPageIndexNotifier() : super(0);

  /// 设置当前索引
  ///
  /// [index] 新的索引值，范围为 0-3
  void setIndex(int index) {
    if (index >= 0 && index <= 3) {
      state = index;
    }
  }

  /// 切换到首页
  void goToHome() => setIndex(0);

  /// 切换到发现页
  void goToDiscover() => setIndex(1);

  /// 切换到消息页
  void goToMessage() => setIndex(2);

  /// 切换到我的页面
  void goToProfile() => setIndex(3);
}

/// 底部导航栏当前索引 Provider
///
/// 用于管理主页面底部导航栏的状态
final mainPageIndexProvider = StateNotifierProvider<MainPageIndexNotifier, int>(
  (ref) => MainPageIndexNotifier(),
);

/// 页面标题列表
const List<String> _pageTitles = ['首页', '发现', '消息', '我的'];

/// 获取当前页面标题 Provider
///
/// 根据当前索引返回对应的页面标题
final currentPageTitleProvider = Provider<String>((ref) {
  final index = ref.watch(mainPageIndexProvider);
  return _pageTitles[index];
});
