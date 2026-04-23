import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// UI 工具类
/// 提供屏幕适配、安全区域处理、键盘管理等功能
class UiUtil {
  UiUtil._();

  // 设计稿尺寸（基于标准 iPhone 14 Pro）
  static const double designWidth = 393;
  static const double designHeight = 852;

  /// 初始化屏幕适配
  /// [context] BuildContext
  static void init(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(designWidth, designHeight),
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  // ==================== 屏幕尺寸相关 ====================

  /// 获取屏幕宽度
  /// 返回屏幕宽度（逻辑像素）
  static double get screenWidth => ScreenUtil().screenWidth;

  /// 获取屏幕高度
  /// 返回屏幕高度（逻辑像素）
  static double get screenHeight => ScreenUtil().screenHeight;

  /// 获取屏幕物理宽度
  /// 返回屏幕物理宽度（物理像素）
  static double get physicalScreenWidth => ScreenUtil().screenWidth;

  /// 获取屏幕物理高度
  /// 返回屏幕物理高度（物理像素）
  static double get physicalScreenHeight => ScreenUtil().screenHeight;

  /// 获取屏幕像素密度
  /// 返回屏幕像素密度
  static double get pixelRatio => ScreenUtil().pixelRatio ?? 1.0;

  /// 获取状态栏高度
  /// 返回状态栏高度
  static double get statusBarHeight => ScreenUtil().statusBarHeight;

  /// 获取底部安全区域高度
  /// 返回底部安全区域高度
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  /// 获取可用屏幕高度（减去状态栏和底部安全区域）
  /// 返回可用屏幕高度
  static double get safeScreenHeight {
    return screenHeight - statusBarHeight - bottomBarHeight;
  }

  /// 获取导航栏高度
  /// 返回导航栏高度（包含状态栏）
  static double get appBarHeight => AppBar().preferredSize.height;

  /// 获取完整导航栏高度（包含状态栏）
  /// 返回完整导航栏高度
  static double get fullAppBarHeight => appBarHeight + statusBarHeight;

  // ==================== 适配方法 ====================

  /// 宽度适配
  /// [width] 设计稿宽度
  /// 返回适配后的宽度
  static double setWidth(double width) => ScreenUtil().setWidth(width);

  /// 高度适配
  /// [height] 设计稿高度
  /// 返回适配后的高度
  static double setHeight(double height) => ScreenUtil().setHeight(height);

  /// 半径适配
  /// [radius] 设计稿半径
  /// 返回适配后的半径
  static double setRadius(double radius) => ScreenUtil().radius(radius);

  /// 字体大小适配
  /// [fontSize] 设计稿字体大小
  /// 返回适配后的字体大小
  static double setSp(double fontSize) => ScreenUtil().setSp(fontSize);

  /// 设置宽度（根据屏幕宽度比例）
  /// [width] 设计稿宽度
  /// 返回按比例设置后的宽度
  static double setWidthPercent(double width) => ScreenUtil().screenWidth * width;

  /// 设置高度（根据屏幕高度比例）
  /// [height] 设计稿高度
  /// 返回按比例设置后的高度
  static double setHeightPercent(double height) => ScreenUtil().screenHeight * height;

  // ==================== 间距常量 ====================

  /// 超小间距（2）
  static double get xs => setWidth(2);

  /// 小间距（4）
  static double get sm => setWidth(4);

  /// 中间距（8）
  static double get md => setWidth(8);

  /// 大间距（12）
  static double get lg => setWidth(12);

  /// 超大间距（16）
  static double get xl => setWidth(16);

  /// 双倍超大间距（20）
  static double get xxl => setWidth(20);

  /// 三倍超大间距（24）
  static double get xxxl => setWidth(24);

  /// 四倍超大间距（32）
  static double get xxxxl => setWidth(32);

  // ==================== 边距快捷方法 ====================

  /// 获取水平边距
  /// [value] 边距值
  /// 返回水平 EdgeInsets
  static EdgeInsets horizontal(double value) =>
      EdgeInsets.symmetric(horizontal: setWidth(value));

  /// 获取垂直边距
  /// [value] 边距值
  /// 返回垂直 EdgeInsets
  static EdgeInsets vertical(double value) =>
      EdgeInsets.symmetric(vertical: setHeight(value));

  /// 获取四周边距
  /// [value] 边距值
  /// 返回四边 EdgeInsets
  static EdgeInsets all(double value) => EdgeInsets.all(setWidth(value));

  /// 获取对称边距
  /// [horizontal] 水平边距
  /// [vertical] 垂直边距
  /// 返回对称 EdgeInsets
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: setWidth(horizontal), vertical: setHeight(vertical));

  /// 获取指定边距
  /// [left] 左边距
  /// [top] 上边距
  /// [right] 右边距
  /// [bottom] 下边距
  /// 返回指定 EdgeInsets
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: setWidth(left),
        top: setHeight(top),
        right: setWidth(right),
        bottom: setHeight(bottom),
      );

  // ==================== 安全区域 ====================

  /// 获取顶部安全边距
  /// [context] BuildContext
  /// 返回顶部安全边距
  static double safeTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  /// 获取底部安全边距
  /// [context] BuildContext
  /// 返回底部安全边距
  static double safeBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  /// 获取左侧安全边距
  /// [context] BuildContext
  /// 返回左侧安全边距
  static double safeLeft(BuildContext context) {
    return MediaQuery.of(context).padding.left;
  }

  /// 获取右侧安全边距
  /// [context] BuildContext
  /// 返回右侧安全边距
  static double safeRight(BuildContext context) {
    return MediaQuery.of(context).padding.right;
  }

  /// 获取安全区域边距
  /// [context] BuildContext
  /// 返回安全区域 EdgeInsets
  static EdgeInsets safePadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// 获取底部安全区域高度（包含键盘高度）
  /// [context] BuildContext
  /// 返回底部安全区域高度
  static double safeBottomWithKeyboard(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    final padding = MediaQuery.of(context).padding;
    return viewInsets.bottom > 0 ? viewInsets.bottom : padding.bottom;
  }

  /// 获取视图内边距（键盘弹出时）
  /// [context] BuildContext
  /// 返回视图内边距
  static EdgeInsets viewInsets(BuildContext context) {
    return MediaQuery.of(context).viewInsets;
  }

  /// 获取视图边距
  /// [context] BuildContext
  /// 返回视图边距
  static EdgeInsets viewPadding(BuildContext context) {
    return MediaQuery.of(context).viewPadding;
  }

  // ==================== 键盘相关 ====================

  /// 隐藏键盘
  /// [context] BuildContext
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  /// 显示键盘
  /// [context] BuildContext
  /// [focusNode] 焦点节点
  static void showKeyboard(BuildContext context, FocusNode focusNode) {
    FocusScope.of(context).requestFocus(focusNode);
  }

  /// 判断键盘是否显示
  /// [context] BuildContext
  /// 返回键盘是否显示
  static bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  /// 获取键盘高度
  /// [context] BuildContext
  /// 返回键盘高度
  static double keyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  // ==================== 系统 UI ====================

  /// 设置状态栏样式（亮色图标，用于深色背景）
  static void setStatusBarLight() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  /// 设置状态栏样式（暗色图标，用于浅色背景）
  static void setStatusBarDark() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  /// 设置系统导航栏样式（亮色图标，用于深色背景）
  static void setNavigationBarLight() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  /// 设置系统导航栏样式（暗色图标，用于浅色背景）
  static void setNavigationBarDark() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  /// 设置全屏模式
  static void setFullscreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  /// 退出全屏模式
  static void exitFullscreen() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  /// 设置屏幕方向为竖屏
  static void setPortraitOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// 设置屏幕方向为横屏
  static void setLandscapeOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  /// 设置屏幕方向为全部方向
  static void setAllOrientations() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // ==================== 辅助方法 ====================

  /// 判断是否为小屏幕设备（宽度小于 360）
  /// 返回是否为小屏幕设备
  static bool get isSmallScreen => screenWidth < 360;

  /// 判断是否为大屏幕设备（宽度大于 600）
  /// 返回是否为大屏幕设备
  static bool get isLargeScreen => screenWidth > 600;

  /// 判断是否为平板设备（宽度大于 600）
  /// 返回是否为平板设备
  static bool get isTablet => screenWidth > 600;

  /// 获取屏幕类型
  /// 返回屏幕类型字符串
  static String get screenType {
    if (screenWidth < 360) return 'small';
    if (screenWidth < 600) return 'normal';
    if (screenWidth < 900) return 'large';
    return 'xlarge';
  }
}

/// UI 扩展
extension UiExtension on BuildContext {
  /// 获取屏幕宽度
  double get screenWidth => UiUtil.screenWidth;

  /// 获取屏幕高度
  double get screenHeight => UiUtil.screenHeight;

  /// 获取状态栏高度
  double get statusBarHeight => UiUtil.statusBarHeight;

  /// 获取底部安全区域高度
  double get bottomBarHeight => UiUtil.bottomBarHeight;

  /// 获取安全区域边距
  EdgeInsets get safePadding => UiUtil.safePadding(this);

  /// 获取顶部安全边距
  double get safeTop => UiUtil.safeTop(this);

  /// 获取底部安全边距
  double get safeBottom => UiUtil.safeBottom(this);

  /// 获取键盘高度
  double get keyboardHeight => UiUtil.keyboardHeight(this);

  /// 判断键盘是否显示
  bool get isKeyboardVisible => UiUtil.isKeyboardVisible(this);

  /// 隐藏键盘
  void hideKeyboard() => UiUtil.hideKeyboard(this);

  /// 显示键盘
  void showKeyboard(FocusNode focusNode) =>
      UiUtil.showKeyboard(this, focusNode);

  /// 获取主题
  ThemeData get theme => Theme.of(this);

  /// 获取颜色方案
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// 获取文本主题
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// 判断是否为深色模式
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

/// Widget 扩展
extension WidgetUiExtension on Widget {
  /// 添加水平内边距
  Widget paddingHorizontal(double value) =>
      Padding(padding: UiUtil.horizontal(value), child: this);

  /// 添加垂直内边距
  Widget paddingVertical(double value) =>
      Padding(padding: UiUtil.vertical(value), child: this);

  /// 添加四边内边距
  Widget paddingAll(double value) =>
      Padding(padding: UiUtil.all(value), child: this);

  /// 添加对称内边距
  Widget paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      Padding(
        padding: UiUtil.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  /// 添加指定内边距
  Widget paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      Padding(
        padding: UiUtil.only(
          left: left,
          top: top,
          right: right,
          bottom: bottom,
        ),
        child: this,
      );

  /// 添加顶部安全区域内边距
  Widget safeAreaTop(BuildContext context) =>
      Padding(padding: EdgeInsets.only(top: UiUtil.safeTop(context)), child: this);

  /// 添加底部安全区域内边距
  Widget safeAreaBottom(BuildContext context) =>
      Padding(padding: EdgeInsets.only(bottom: UiUtil.safeBottom(context)), child: this);

  /// 添加完整安全区域内边距
  Widget safeArea(BuildContext context) =>
      Padding(padding: UiUtil.safePadding(context), child: this);
}
