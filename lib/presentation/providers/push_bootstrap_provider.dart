import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/services/notification_push_sync_service.dart';

final pushBootstrapProvider = Provider<bool>((ref) {
  NotificationPushSyncService.instance.start(ref);
  ref.onDispose(NotificationPushSyncService.instance.stop);
  return true;
});
