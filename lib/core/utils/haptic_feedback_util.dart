import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../presentation/providers/settings_provider.dart';

/// 统一管理应用触觉反馈。
///
/// 通过设置页的「振动」开关控制是否启用。
enum HapticScene {
  tap,
  navSwitch,
  like,
  unlike,
  refresh,
  refreshDone,
  message,
  commentSuccess,
  copySuccess,
}

class HapticFeedbackUtil {
  const HapticFeedbackUtil._();

  static Future<void> trigger(
    WidgetRef ref,
    HapticScene scene, {
    bool ignoreSettings = false,
  }) async {
    if (!ignoreSettings) {
      final enabled = ref.read(currentSettingsProvider).vibrationEnabled;
      if (!enabled) return;
    }

    try {
      switch (scene) {
        case HapticScene.tap:
          await HapticFeedback.selectionClick();
          break;
        case HapticScene.navSwitch:
          await HapticFeedback.selectionClick();
          break;
        case HapticScene.like:
          await HapticFeedback.lightImpact();
          break;
        case HapticScene.unlike:
          await HapticFeedback.selectionClick();
          break;
        case HapticScene.refresh:
          await HapticFeedback.lightImpact();
          break;
        case HapticScene.refreshDone:
          await HapticFeedback.lightImpact();
          break;
        case HapticScene.message:
          await HapticFeedback.lightImpact();
          break;
        case HapticScene.commentSuccess:
          await HapticFeedback.lightImpact();
          break;
        case HapticScene.copySuccess:
          await HapticFeedback.selectionClick();
          break;
      }
    } catch (_) {
      // 不支持触觉反馈的平台静默跳过。
    }
  }
}
