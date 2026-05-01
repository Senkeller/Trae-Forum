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
  static const String _recentPushedNotificationIdsKey =
      'push_recent_notification_ids';
  static const Duration _foregroundInterval = Duration(seconds: 45);
  static const Duration _backgroundInterval = Duration(minutes: 3);
  static const Duration _maxBackoffInterval = Duration(minutes: 15);
  static const int _maxRecentPushedIds = 64;

  Timer? _timer;
  Ref? _ref;
  bool _started = false;
  bool _syncing = false;
  bool _isForeground = true;
  bool _permissionRequested = false;
  int _consecutiveFailures = 0;
  Duration _currentInterval = _foregroundInterval;
  int _lastPushedNotificationId = 0;
  bool _initializedBaseline = false;
  final List<int> _recentPushedIds = <int>[];

  Future<void> start(Ref ref) async {
    if (_started) return;
    _started = true;
    _ref = ref;
    WidgetsBinding.instance.addObserver(this);

    await LocalNotificationService.instance.initialize();
    await _loadBaseline();

    _currentInterval = _foregroundInterval;
    _restartTimer(_currentInterval);
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
      _isForeground = true;
      _currentInterval = _foregroundInterval;
      _restartTimer(_currentInterval);
      unawaited(_syncOnce());
      return;
    }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      _isForeground = false;
      _currentInterval = _backgroundInterval;
      _restartTimer(_currentInterval);
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
    final rawIds =
        prefs.getStringList(_recentPushedNotificationIdsKey) ?? const [];
    _recentPushedIds
      ..clear()
      ..addAll(
        rawIds.map(int.tryParse).whereType<int>().toSet().toList()..sort(),
      );
    _initializedBaseline = _lastPushedNotificationId > 0;
  }

  Future<void> _saveBaseline() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastPushedNotificationIdKey, _lastPushedNotificationId);
    await prefs.setStringList(
      _recentPushedNotificationIdsKey,
      _recentPushedIds.map((id) => id.toString()).toList(),
    );
  }

  void updatePushEnabled(bool enabled) {
    if (!_started) return;
    if (!enabled) {
      _timer?.cancel();
      _timer = null;
      return;
    }
    _currentInterval = _isForeground
        ? _foregroundInterval
        : _backgroundInterval;
    _restartTimer(_currentInterval);
    unawaited(_syncOnce(seedOnlyIfNeeded: true));
  }

  void _recordPushedId(int id) {
    if (_recentPushedIds.contains(id)) return;
    _recentPushedIds.add(id);
    if (_recentPushedIds.length > _maxRecentPushedIds) {
      _recentPushedIds.removeAt(0);
    }
  }

  bool _wasAlreadyPushed(DiscourseNotification notification) {
    return _recentPushedIds.contains(notification.id);
  }

  void _onSyncSuccess() {
    _consecutiveFailures = 0;
    final target = _isForeground ? _foregroundInterval : _backgroundInterval;
    if (_currentInterval != target) {
      _currentInterval = target;
      _restartTimer(_currentInterval);
    }
  }

  void _onSyncFailure() {
    _consecutiveFailures += 1;
    final base = _isForeground ? _foregroundInterval : _backgroundInterval;
    final exponent = _consecutiveFailures.clamp(0, 4).toInt();
    final multiplier = 1 << exponent;
    final next = Duration(seconds: base.inSeconds * multiplier);
    final bounded = next > _maxBackoffInterval ? _maxBackoffInterval : next;
    if (bounded != _currentInterval) {
      _currentInterval = bounded;
      _restartTimer(_currentInterval);
    }
  }

  Future<void> _syncOnce({bool seedOnlyIfNeeded = false}) async {
    if (_syncing) return;
    final ref = _ref;
    if (ref == null) return;

    _syncing = true;
    try {
      final settings = ref.read(currentSettingsProvider);
      if (!settings.pushNotification) return;
      if (!_permissionRequested) {
        _permissionRequested = true;
        await LocalNotificationService.instance.requestPermissions();
      }

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
      await LocalNotificationService.instance.syncUnreadBadgeCount(
        unread.length,
      );
      if (unread.isEmpty) {
        _onSyncSuccess();
        return;
      }

      final maxNotificationId = unread
          .map((n) => n.id)
          .fold<int>(0, (maxId, id) => max(maxId, id));

      if (!_initializedBaseline && seedOnlyIfNeeded) {
        _lastPushedNotificationId = maxNotificationId;
        _initializedBaseline = true;
        await _saveBaseline();
        _onSyncSuccess();
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
        _onSyncSuccess();
        return;
      }

      for (final notification in newNotifications.take(6)) {
        if (_wasAlreadyPushed(notification)) {
          continue;
        }
        await LocalNotificationService.instance.showForumMessageNotification(
          notification: notification,
          settings: settings,
        );
        _recordPushedId(notification.id);
      }

      _lastPushedNotificationId = maxNotificationId;
      await _saveBaseline();
      _onSyncSuccess();
    } catch (_) {
      // 推送同步失败静默处理，不影响主流程。
      _onSyncFailure();
    } finally {
      _syncing = false;
    }
  }
}
