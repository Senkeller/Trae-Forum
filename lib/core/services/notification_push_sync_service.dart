import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../network/discourse_api_service.dart';
import '../../data/models/discourse/discourse_notification.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/settings_provider.dart';
import 'local_notification_service.dart';

class NotificationPushSyncService with WidgetsBindingObserver {
  NotificationPushSyncService._();
  static final NotificationPushSyncService instance =
      NotificationPushSyncService._();

  static const String _lastPushedNotificationIdKey =
      'push_last_notification_id';
  static const Duration _foregroundInterval = Duration(seconds: 45);
  static const Duration _backgroundInterval = Duration(minutes: 3);

  Timer? _timer;
  Ref? _ref;
  bool _started = false;
  bool _syncing = false;
  int _lastPushedNotificationId = 0;
  bool _initializedBaseline = false;

  Future<void> start(Ref ref) async {
    if (_started) return;
    _started = true;
    _ref = ref;
    WidgetsBinding.instance.addObserver(this);

    await LocalNotificationService.instance.initialize();
    await LocalNotificationService.instance.requestPermissions();
    await _loadBaseline();

    _restartTimer(_foregroundInterval);
    unawaited(_syncOnce(seedOnlyIfNeeded: true));
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    WidgetsBinding.instance.removeObserver(this);
    _started = false;
    _ref = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_started) return;
    if (state == AppLifecycleState.resumed) {
      _restartTimer(_foregroundInterval);
      unawaited(_syncOnce());
      return;
    }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _restartTimer(_backgroundInterval);
    }
  }

  void _restartTimer(Duration interval) {
    _timer?.cancel();
    _timer = Timer.periodic(interval, (_) {
      unawaited(_syncOnce());
    });
  }

  Future<void> _loadBaseline() async {
    final prefs = await SharedPreferences.getInstance();
    _lastPushedNotificationId = prefs.getInt(_lastPushedNotificationIdKey) ?? 0;
    _initializedBaseline = _lastPushedNotificationId > 0;
  }

  Future<void> _saveBaseline() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastPushedNotificationIdKey, _lastPushedNotificationId);
  }

  Future<void> _syncOnce({bool seedOnlyIfNeeded = false}) async {
    if (_syncing) return;
    final ref = _ref;
    if (ref == null) return;

    _syncing = true;
    try {
      final settings = ref.read(currentSettingsProvider);
      if (!settings.pushNotification) return;

      final isAuthenticated = await ref.read(
        isAuthenticatedAsyncProvider.future,
      );
      if (!isAuthenticated) return;

      final api = ref.read(discourseApiServiceProvider);
      final response = await api.getNotifications(
        limit: 20,
        recent: true,
        bumpLastSeen: false,
      );

      if (response.statusCode != 200 ||
          response.data is! Map<String, dynamic>) {
        return;
      }

      final parsed = DiscourseNotificationResponse.fromJson(
        response.data as Map<String, dynamic>,
      );
      final unread = parsed.notifications.where((n) => !n.read).toList();
      if (unread.isEmpty) return;

      final maxNotificationId = unread
          .map((n) => n.id)
          .fold<int>(0, (maxId, id) => max(maxId, id));

      if (!_initializedBaseline && seedOnlyIfNeeded) {
        _lastPushedNotificationId = maxNotificationId;
        _initializedBaseline = true;
        await _saveBaseline();
        return;
      }

      _initializedBaseline = true;

      final newNotifications =
          unread.where((n) => n.id > _lastPushedNotificationId).toList()
            ..sort((a, b) => a.id.compareTo(b.id));

      if (newNotifications.isEmpty) {
        if (maxNotificationId > _lastPushedNotificationId) {
          _lastPushedNotificationId = maxNotificationId;
          await _saveBaseline();
        }
        return;
      }

      for (final notification in newNotifications.take(6)) {
        await LocalNotificationService.instance.showForumMessageNotification(
          notification: notification,
          settings: settings,
        );
      }

      _lastPushedNotificationId = maxNotificationId;
      await _saveBaseline();
    } catch (_) {
      // 推送同步失败静默处理，不影响主流程。
    } finally {
      _syncing = false;
    }
  }
}
