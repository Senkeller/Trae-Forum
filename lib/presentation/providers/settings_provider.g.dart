// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentSettingsHash() => r'1ca3715345058826c72ce0a7654c26831388198b';

/// 当前设置 Provider
///
/// Copied from [currentSettings].
@ProviderFor(currentSettings)
final currentSettingsProvider = AutoDisposeProvider<AppSettings>.internal(
  currentSettings,
  name: r'currentSettingsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSettingsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentSettingsRef = AutoDisposeProviderRef<AppSettings>;
String _$imageQualityHash() => r'9bc80a45649e5ac16c3d50aa7f302db52a4579cc';

/// 图片质量 Provider
///
/// Copied from [imageQuality].
@ProviderFor(imageQuality)
final imageQualityProvider = AutoDisposeProvider<ImageQuality>.internal(
  imageQuality,
  name: r'imageQualityProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$imageQualityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ImageQualityRef = AutoDisposeProviderRef<ImageQuality>;
String _$fontSizeHash() => r'64c633985779e7fb3d7f525ded6717d48099d3a6';

/// 字体大小 Provider
///
/// Copied from [fontSize].
@ProviderFor(fontSize)
final fontSizeProvider = AutoDisposeProvider<FontSize>.internal(
  fontSize,
  name: r'fontSizeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fontSizeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FontSizeRef = AutoDisposeProviderRef<FontSize>;
String _$appLanguageHash() => r'56e11e64d9f41a9c18d6ea17a5d45c395aa5bba2';

/// 应用语言 Provider
///
/// Copied from [appLanguage].
@ProviderFor(appLanguage)
final appLanguageProvider = AutoDisposeProvider<AppLanguage>.internal(
  appLanguage,
  name: r'appLanguageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$appLanguageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AppLanguageRef = AutoDisposeProviderRef<AppLanguage>;
String _$isDataSaverModeHash() => r'70dd12c419eaf56a39869e82d726373311ea88fb';

/// 是否开启省流量模式 Provider
///
/// Copied from [isDataSaverMode].
@ProviderFor(isDataSaverMode)
final isDataSaverModeProvider = AutoDisposeProvider<bool>.internal(
  isDataSaverMode,
  name: r'isDataSaverModeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isDataSaverModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsDataSaverModeRef = AutoDisposeProviderRef<bool>;
String _$isPushNotificationEnabledHash() =>
    r'1cf5a53765eafeb84ac0787e126cc1b9e39b8864';

/// 是否开启推送通知 Provider
///
/// Copied from [isPushNotificationEnabled].
@ProviderFor(isPushNotificationEnabled)
final isPushNotificationEnabledProvider = AutoDisposeProvider<bool>.internal(
  isPushNotificationEnabled,
  name: r'isPushNotificationEnabledProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isPushNotificationEnabledHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsPushNotificationEnabledRef = AutoDisposeProviderRef<bool>;
String _$settingsNotifierHash() => r'3cac20212457f5273a694427d6282714e5daa926';

/// 设置状态 Notifier
///
/// Copied from [SettingsNotifier].
@ProviderFor(SettingsNotifier)
final settingsNotifierProvider =
    AutoDisposeAsyncNotifierProvider<SettingsNotifier, AppSettings>.internal(
      SettingsNotifier.new,
      name: r'settingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SettingsNotifier = AutoDisposeAsyncNotifier<AppSettings>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
