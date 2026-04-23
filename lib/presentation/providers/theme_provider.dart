import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

/// 主题模式枚举
enum ThemeModeType {
  /// 跟随系统
  system,
  /// 浅色模式
  light,
  /// 深色模式
  dark,
}

/// 主题状态类
@riverpod
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const String _themeModeKey = 'theme_mode';

  /// 构建主题状态
  ///
  /// 从本地存储读取主题设置，默认为跟随系统
  @override
  Future<ThemeModeType> build() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_themeModeKey);
    if (themeModeIndex != null) {
      return ThemeModeType.values[themeModeIndex];
    }
    return ThemeModeType.system;
  }

  /// 设置主题模式
  ///
  /// [mode] 要设置的主题模式
  /// 将主题模式保存到本地存储并更新状态
  Future<void> setThemeMode(ThemeModeType mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
    state = AsyncData(mode);
  }

  /// 切换到浅色模式
  Future<void> setLightMode() async {
    await setThemeMode(ThemeModeType.light);
  }

  /// 切换到深色模式
  Future<void> setDarkMode() async {
    await setThemeMode(ThemeModeType.dark);
  }

  /// 切换到跟随系统
  Future<void> setSystemMode() async {
    await setThemeMode(ThemeModeType.system);
  }

  /// 切换主题模式
  ///
  /// 在当前主题模式之间循环切换：浅色 -> 深色 -> 跟随系统 -> 浅色
  Future<void> toggleTheme() async {
    final currentMode = state.valueOrNull ?? ThemeModeType.system;
    ThemeModeType newMode;
    switch (currentMode) {
      case ThemeModeType.light:
        newMode = ThemeModeType.dark;
        break;
      case ThemeModeType.dark:
        newMode = ThemeModeType.system;
        break;
      case ThemeModeType.system:
        newMode = ThemeModeType.light;
        break;
    }
    await setThemeMode(newMode);
  }
}

/// 当前主题模式 Provider
///
/// 提供当前的主题模式状态，用于监听主题变化
@riverpod
ThemeModeType currentThemeMode(CurrentThemeModeRef ref) {
  final themeModeAsync = ref.watch(themeModeNotifierProvider);
  return themeModeAsync.valueOrNull ?? ThemeModeType.system;
}

/// 是否为深色模式 Provider
///
/// 根据当前主题模式和系统亮度判断是否为深色模式
///
/// [context] BuildContext 用于获取系统亮度
/// 返回 true 表示当前是深色模式，false 表示浅色模式
@riverpod
bool isDarkMode(IsDarkModeRef ref, BuildContext context) {
  final themeMode = ref.watch(currentThemeModeProvider);
  switch (themeMode) {
    case ThemeModeType.light:
      return false;
    case ThemeModeType.dark:
      return true;
    case ThemeModeType.system:
      return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }
}

/// 主题模式显示名称扩展
extension ThemeModeTypeExtension on ThemeModeType {
  /// 获取主题模式的显示名称
  String get displayName {
    switch (this) {
      case ThemeModeType.system:
        return '跟随系统';
      case ThemeModeType.light:
        return '浅色模式';
      case ThemeModeType.dark:
        return '深色模式';
    }
  }

  /// 获取主题模式的图标
  IconData get icon {
    switch (this) {
      case ThemeModeType.system:
        return Icons.brightness_auto;
      case ThemeModeType.light:
        return Icons.brightness_high;
      case ThemeModeType.dark:
        return Icons.brightness_2;
    }
  }
}
