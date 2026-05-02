import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/notification_push_sync_service.dart';
import '../../core/services/push_notification_service.dart';
import 'settings_provider.dart';

/// 推送服务启动Provider
///
/// 同时启动轮询推送服务和FCM实时推送服务
final pushBootstrapProvider = Provider<bool>((ref) {
  // 启动轮询推送服务（作为FCM的备用方案）
  NotificationPushSyncService.instance.start(ref);

  // 初始化FCM推送服务
  PushNotificationService.instance.initialize(ref);

  ref.listen<AppSettings>(currentSettingsProvider, (previous, next) {
    if (previous?.pushNotification == next.pushNotification) {
      return;
    }
    // 更新轮询服务状态
    NotificationPushSyncService.instance.updatePushEnabled(
      next.pushNotification,
    );
    // 更新FCM服务状态
    PushNotificationService.instance.setPushNotificationEnabled(
      next.pushNotification,
    );
  });

  ref.onDispose(() {
    NotificationPushSyncService.instance.stop();
    PushNotificationService.instance.dispose();
  });
  return true;
});
