import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_provider.g.dart';

/// 图片质量枚举
enum ImageQuality {
  /// 原图
  original,
  /// 高清
  high,
  /// 标清
  medium,
  /// 省流
  low,
}

/// 字体大小枚举
enum FontSize {
  /// 小
  small,
  /// 中
  medium,
  /// 大
  large,
  /// 超大
  extraLarge,
}

/// 语言设置枚举
enum AppLanguage {
  /// 跟随系统
  system,
  /// 简体中文
  simplifiedChinese,
  /// 繁体中文
  traditionalChinese,
  /// 英语
  english,
}

/// 应用设置状态类
class AppSettings {
  /// 图片质量
  final ImageQuality imageQuality;
  /// 字体大小
  final FontSize fontSize;
  /// 应用语言
  final AppLanguage language;
  /// 是否开启自动播放视频
  final bool autoPlayVideo;
  /// 是否仅在WiFi下自动播放
  final bool autoPlayVideoOnlyOnWifi;
  /// 是否开启省流量模式
  final bool dataSaverMode;
  /// 是否开启推送通知
  final bool pushNotification;
  /// 是否开启声音
  final bool soundEnabled;
  /// 是否开启振动
  final bool vibrationEnabled;
  /// 是否显示动态大图
  final bool showLargeImage;
  /// 动态列表显示密度
  final double listDensity;
  /// 是否开启夜间模式跟随系统
  final bool followSystemDarkMode;
  /// 是否开启手势返回
  final bool enableGestureBack;
  /// 是否开启双击点赞
  final bool enableDoubleTapLike;
  /// 是否缓存图片
  final bool cacheImages;
  /// 缓存大小限制（MB）
  final int cacheSizeLimit;

  const AppSettings({
    this.imageQuality = ImageQuality.high,
    this.fontSize = FontSize.medium,
    this.language = AppLanguage.system,
    this.autoPlayVideo = false,
    this.autoPlayVideoOnlyOnWifi = true,
    this.dataSaverMode = false,
    this.pushNotification = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.showLargeImage = true,
    this.listDensity = 1.0,
    this.followSystemDarkMode = true,
    this.enableGestureBack = true,
    this.enableDoubleTapLike = true,
    this.cacheImages = true,
    this.cacheSizeLimit = 500,
  });

  /// 从 JSON 创建
  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      imageQuality: ImageQuality.values[json['imageQuality'] ?? 1],
      fontSize: FontSize.values[json['fontSize'] ?? 1],
      language: AppLanguage.values[json['language'] ?? 0],
      autoPlayVideo: json['autoPlayVideo'] ?? false,
      autoPlayVideoOnlyOnWifi: json['autoPlayVideoOnlyOnWifi'] ?? true,
      dataSaverMode: json['dataSaverMode'] ?? false,
      pushNotification: json['pushNotification'] ?? true,
      soundEnabled: json['soundEnabled'] ?? true,
      vibrationEnabled: json['vibrationEnabled'] ?? true,
      showLargeImage: json['showLargeImage'] ?? true,
      listDensity: json['listDensity']?.toDouble() ?? 1.0,
      followSystemDarkMode: json['followSystemDarkMode'] ?? true,
      enableGestureBack: json['enableGestureBack'] ?? true,
      enableDoubleTapLike: json['enableDoubleTapLike'] ?? true,
      cacheImages: json['cacheImages'] ?? true,
      cacheSizeLimit: json['cacheSizeLimit'] ?? 500,
    );
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'imageQuality': imageQuality.index,
      'fontSize': fontSize.index,
      'language': language.index,
      'autoPlayVideo': autoPlayVideo,
      'autoPlayVideoOnlyOnWifi': autoPlayVideoOnlyOnWifi,
      'dataSaverMode': dataSaverMode,
      'pushNotification': pushNotification,
      'soundEnabled': soundEnabled,
      'vibrationEnabled': vibrationEnabled,
      'showLargeImage': showLargeImage,
      'listDensity': listDensity,
      'followSystemDarkMode': followSystemDarkMode,
      'enableGestureBack': enableGestureBack,
      'enableDoubleTapLike': enableDoubleTapLike,
      'cacheImages': cacheImages,
      'cacheSizeLimit': cacheSizeLimit,
    };
  }

  /// 复制并修改
  AppSettings copyWith({
    ImageQuality? imageQuality,
    FontSize? fontSize,
    AppLanguage? language,
    bool? autoPlayVideo,
    bool? autoPlayVideoOnlyOnWifi,
    bool? dataSaverMode,
    bool? pushNotification,
    bool? soundEnabled,
    bool? vibrationEnabled,
    bool? showLargeImage,
    double? listDensity,
    bool? followSystemDarkMode,
    bool? enableGestureBack,
    bool? enableDoubleTapLike,
    bool? cacheImages,
    int? cacheSizeLimit,
  }) {
    return AppSettings(
      imageQuality: imageQuality ?? this.imageQuality,
      fontSize: fontSize ?? this.fontSize,
      language: language ?? this.language,
      autoPlayVideo: autoPlayVideo ?? this.autoPlayVideo,
      autoPlayVideoOnlyOnWifi: autoPlayVideoOnlyOnWifi ?? this.autoPlayVideoOnlyOnWifi,
      dataSaverMode: dataSaverMode ?? this.dataSaverMode,
      pushNotification: pushNotification ?? this.pushNotification,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      showLargeImage: showLargeImage ?? this.showLargeImage,
      listDensity: listDensity ?? this.listDensity,
      followSystemDarkMode: followSystemDarkMode ?? this.followSystemDarkMode,
      enableGestureBack: enableGestureBack ?? this.enableGestureBack,
      enableDoubleTapLike: enableDoubleTapLike ?? this.enableDoubleTapLike,
      cacheImages: cacheImages ?? this.cacheImages,
      cacheSizeLimit: cacheSizeLimit ?? this.cacheSizeLimit,
    );
  }
}

/// 设置状态 Notifier
@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  static const String _settingsKey = 'app_settings';
  AppSettings _latestSettings = const AppSettings();

  /// 构建设置状态
  @override
  Future<AppSettings> build() async {
    final loaded = await _loadSettings();
    _latestSettings = loaded;
    return loaded;
  }

  /// 从本地存储加载设置
  Future<AppSettings> _loadSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final settingsJson = prefs.getString(_settingsKey);
      if (settingsJson != null) {
        // 这里简化处理，实际应该使用 jsonDecode
        // 暂时返回默认设置
        return const AppSettings();
      }
      return const AppSettings();
    } catch (e) {
      return const AppSettings();
    }
  }

  /// 保存设置到本地存储
  Future<void> _saveSettings(AppSettings settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // 这里简化处理，实际应该使用 jsonEncode
      await prefs.setString(_settingsKey, settings.toJson().toString());
    } catch (e) {
      // 保存失败
    }
  }

  /// 安全地获取当前设置
  /// 如果 state 还未初始化，返回默认设置
  AppSettings _getCurrentSettings() {
    return _latestSettings;
  }

  /// 安全地设置 state
  /// 确保在 build 完成后才设置 state
  void _setStateSafe(AppSettings settings) {
    _latestSettings = settings;
    try {
      state = AsyncData(settings);
    } catch (e) {
      // state 还未初始化，忽略
    }
  }

  /// 更新设置
  ///
  /// [settings] 新的设置
  Future<void> updateSettings(AppSettings settings) async {
    await _saveSettings(settings);
    _setStateSafe(settings);
  }

  /// 设置图片质量
  ///
  /// [quality] 图片质量
  Future<void> setImageQuality(ImageQuality quality) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(imageQuality: quality);
    await updateSettings(newSettings);
  }

  /// 设置字体大小
  ///
  /// [fontSize] 字体大小
  Future<void> setFontSize(FontSize fontSize) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(fontSize: fontSize);
    await updateSettings(newSettings);
  }

  /// 设置应用语言
  ///
  /// [language] 应用语言
  Future<void> setLanguage(AppLanguage language) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(language: language);
    await updateSettings(newSettings);
  }

  /// 设置自动播放视频
  ///
  /// [enabled] 是否开启
  Future<void> setAutoPlayVideo(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(autoPlayVideo: enabled);
    await updateSettings(newSettings);
  }

  /// 设置仅在WiFi下自动播放
  ///
  /// [enabled] 是否开启
  Future<void> setAutoPlayVideoOnlyOnWifi(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(autoPlayVideoOnlyOnWifi: enabled);
    await updateSettings(newSettings);
  }

  /// 设置省流量模式
  ///
  /// [enabled] 是否开启
  Future<void> setDataSaverMode(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(dataSaverMode: enabled);
    await updateSettings(newSettings);
  }

  /// 设置推送通知
  ///
  /// [enabled] 是否开启
  Future<void> setPushNotification(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(pushNotification: enabled);
    await updateSettings(newSettings);
  }

  /// 设置声音
  ///
  /// [enabled] 是否开启
  Future<void> setSoundEnabled(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(soundEnabled: enabled);
    await updateSettings(newSettings);
  }

  /// 设置振动
  ///
  /// [enabled] 是否开启
  Future<void> setVibrationEnabled(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(vibrationEnabled: enabled);
    await updateSettings(newSettings);
  }

  /// 设置显示大图
  ///
  /// [enabled] 是否开启
  Future<void> setShowLargeImage(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(showLargeImage: enabled);
    await updateSettings(newSettings);
  }

  /// 设置列表密度
  ///
  /// [density] 密度值（0.8 - 1.2）
  Future<void> setListDensity(double density) async {
    final currentSettings = _getCurrentSettings();
    final clampedDensity = density.clamp(0.8, 1.2);
    final newSettings = currentSettings.copyWith(listDensity: clampedDensity);
    await updateSettings(newSettings);
  }

  /// 设置跟随系统暗黑模式
  ///
  /// [enabled] 是否开启
  Future<void> setFollowSystemDarkMode(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(followSystemDarkMode: enabled);
    await updateSettings(newSettings);
  }

  /// 设置手势返回
  ///
  /// [enabled] 是否开启
  Future<void> setEnableGestureBack(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(enableGestureBack: enabled);
    await updateSettings(newSettings);
  }

  /// 设置双击点赞
  ///
  /// [enabled] 是否开启
  Future<void> setEnableDoubleTapLike(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(enableDoubleTapLike: enabled);
    await updateSettings(newSettings);
  }

  /// 设置缓存图片
  ///
  /// [enabled] 是否开启
  Future<void> setCacheImages(bool enabled) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(cacheImages: enabled);
    await updateSettings(newSettings);
  }

  /// 设置缓存大小限制
  ///
  /// [sizeMB] 缓存大小限制（MB）
  Future<void> setCacheSizeLimit(int sizeMB) async {
    final currentSettings = _getCurrentSettings();
    final newSettings = currentSettings.copyWith(cacheSizeLimit: sizeMB);
    await updateSettings(newSettings);
  }

  /// 重置所有设置为默认值
  Future<void> resetToDefault() async {
    const defaultSettings = AppSettings();
    await updateSettings(defaultSettings);
  }

  /// 清除缓存
  ///
  /// 返回清除的缓存大小（字节）
  Future<int> clearCache() async {
    // 这里应该实现实际的缓存清理逻辑
    // 返回清理的缓存大小
    return 0;
  }
}

/// 当前设置 Provider
@riverpod
AppSettings currentSettings(CurrentSettingsRef ref) {
  final settingsAsync = ref.watch(settingsNotifierProvider);
  return settingsAsync.when(
    data: (settings) => settings,
    loading: () => const AppSettings(),
    error: (error, stackTrace) => const AppSettings(),
  );
}

/// 图片质量 Provider
@riverpod
ImageQuality imageQuality(ImageQualityRef ref) {
  return ref.watch(currentSettingsProvider).imageQuality;
}

/// 字体大小 Provider
@riverpod
FontSize fontSize(FontSizeRef ref) {
  return ref.watch(currentSettingsProvider).fontSize;
}

/// 应用语言 Provider
@riverpod
AppLanguage appLanguage(AppLanguageRef ref) {
  return ref.watch(currentSettingsProvider).language;
}

/// 是否开启省流量模式 Provider
@riverpod
bool isDataSaverMode(IsDataSaverModeRef ref) {
  return ref.watch(currentSettingsProvider).dataSaverMode;
}

/// 是否开启推送通知 Provider
@riverpod
bool isPushNotificationEnabled(IsPushNotificationEnabledRef ref) {
  return ref.watch(currentSettingsProvider).pushNotification;
}

/// 图片质量扩展
extension ImageQualityExtension on ImageQuality {
  /// 获取图片质量的显示名称
  String get displayName {
    switch (this) {
      case ImageQuality.original:
        return '原图';
      case ImageQuality.high:
        return '高清';
      case ImageQuality.medium:
        return '标清';
      case ImageQuality.low:
        return '省流';
    }
  }

  /// 获取图片质量的缩略图后缀
  String get thumbnailSuffix {
    switch (this) {
      case ImageQuality.original:
        return '';
      case ImageQuality.high:
        return '.s.jpg';
      case ImageQuality.medium:
        return '.m.jpg';
      case ImageQuality.low:
        return '.l.jpg';
    }
  }
}

/// 字体大小扩展
extension FontSizeExtension on FontSize {
  /// 获取字体大小的显示名称
  String get displayName {
    switch (this) {
      case FontSize.small:
        return '小';
      case FontSize.medium:
        return '中';
      case FontSize.large:
        return '大';
      case FontSize.extraLarge:
        return '超大';
    }
  }

  /// 获取字体大小的缩放比例
  double get scaleFactor {
    switch (this) {
      case FontSize.small:
        return 0.85;
      case FontSize.medium:
        return 1.0;
      case FontSize.large:
        return 1.15;
      case FontSize.extraLarge:
        return 1.3;
    }
  }
}

/// 应用语言扩展
extension AppLanguageExtension on AppLanguage {
  /// 获取应用语言的显示名称
  String get displayName {
    switch (this) {
      case AppLanguage.system:
        return '跟随系统';
      case AppLanguage.simplifiedChinese:
        return '简体中文';
      case AppLanguage.traditionalChinese:
        return '繁体中文';
      case AppLanguage.english:
        return 'English';
    }
  }

  /// 获取语言代码
  String get languageCode {
    switch (this) {
      case AppLanguage.system:
        return 'system';
      case AppLanguage.simplifiedChinese:
        return 'zh_CN';
      case AppLanguage.traditionalChinese:
        return 'zh_TW';
      case AppLanguage.english:
        return 'en';
    }
  }
}
