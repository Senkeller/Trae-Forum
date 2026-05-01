import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/notification_push_sync_service.dart';
import 'settings_provider.dart';

final pushBootstrapProvider = Provider<bool>((ref) {
  NotificationPushSyncService.instance.start(ref);

  ref.listen<AppSettings>(currentSettingsProvider, (previous, next) {
    if (previous?.pushNotification == next.pushNotification) {
      return;
    }
    NotificationPushSyncService.instance.updatePushEnabled(
      next.pushNotification,
    );
  });

  ref.onDispose(NotificationPushSyncService.instance.stop);
  return true;
});
