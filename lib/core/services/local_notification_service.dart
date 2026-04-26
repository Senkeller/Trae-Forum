import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../config/routes.dart';
import '../../data/models/discourse/discourse_notification.dart';
import '../../presentation/providers/settings_provider.dart';

class LocalNotificationService {
  LocalNotificationService._();
  static final LocalNotificationService instance = LocalNotificationService._();

  static const String _channelId = 'forum_messages';
  static const String _channelName = '论坛消息';
  static const String _channelDesc = '论坛互动通知（回复、点赞、提及）';
  static const String _androidGroupKey = 'forum_messages_group';
  static const int _androidGroupSummaryId = -100;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final List<String> _recentAndroidLines = <String>[];
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _handleNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          _backgroundNotificationTapHandler,
    );

    final launchDetails = await _plugin.getNotificationAppLaunchDetails();
    final launchResponse = launchDetails?.notificationResponse;
    if (launchDetails?.didNotificationLaunchApp == true &&
        launchResponse != null) {
      _handleNotificationResponse(launchResponse);
    }

    _initialized = true;
  }

  Future<void> requestPermissions() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await android?.requestNotificationsPermission();

    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    await ios?.requestPermissions(alert: true, badge: true, sound: true);
  }

  Future<void> showForumMessageNotification({
    required DiscourseNotification notification,
    required AppSettings settings,
  }) async {
    final payload = jsonEncode({
      'notificationId': notification.id,
      'topicId': notification.topicId,
      'postNumber': notification.postNumber,
    });

    final title = _buildTitle(notification);
    final body = _buildBody(notification);

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      playSound: settings.soundEnabled,
      enableVibration: settings.vibrationEnabled,
      channelShowBadge: true,
      styleInformation: BigTextStyleInformation(body),
      ticker: title,
      groupKey: _androidGroupKey,
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: settings.soundEnabled,
      threadIdentifier: 'forum_messages',
    );

    await _plugin.show(
      notification.id,
      title,
      body,
      NotificationDetails(android: androidDetails, iOS: iosDetails),
      payload: payload,
    );

    await _showAndroidGroupSummary(
      title: title,
      body: body,
      settings: settings,
    );
  }

  String _buildTitle(DiscourseNotification notification) {
    final typeName = DiscourseNotificationType.getTypeName(
      notification.notificationType,
    );
    final username =
        notification.actingUserName ??
        notification.displayUsername ??
        notification.data?.displayUsername ??
        '论坛通知';
    return '$username · $typeName';
  }

  String _buildBody(DiscourseNotification notification) {
    final topicTitle =
        notification.topicTitle ??
        notification.fancyTitle ??
        notification.data?.topicTitle;
    if (topicTitle != null && topicTitle.trim().isNotEmpty) {
      return topicTitle.trim();
    }

    final message = notification.data?.message;
    if (message != null && message.trim().isNotEmpty) {
      return message.trim();
    }

    return '你有一条新的论坛消息';
  }

  void _handleNotificationResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || payload.isEmpty) return;

    try {
      final map = jsonDecode(payload) as Map<String, dynamic>;
      final topicId = map['topicId'] as int?;
      final postNumber = map['postNumber'] as int?;
      if (topicId == null || topicId <= 0) return;

      final path = postNumber != null && postNumber > 1
          ? '/feed/$topicId?postNumber=$postNumber'
          : '/feed/$topicId';
      AppRouter.router.push(path);
    } catch (e) {
      debugPrint('⚠️ [LocalNotificationService] 处理通知点击失败: $e');
    }
  }

  Future<void> _showAndroidGroupSummary({
    required String title,
    required String body,
    required AppSettings settings,
  }) async {
    _recentAndroidLines.add('$title：$body');
    if (_recentAndroidLines.length > 5) {
      _recentAndroidLines.removeAt(0);
    }

    final inbox = InboxStyleInformation(
      _recentAndroidLines.reversed.toList(),
      contentTitle: 'TRAE Forum 新消息',
      summaryText: '${_recentAndroidLines.length} 条新消息',
    );

    final summaryAndroidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      playSound: settings.soundEnabled,
      enableVibration: settings.vibrationEnabled,
      channelShowBadge: true,
      setAsGroupSummary: true,
      styleInformation: inbox,
      groupKey: _androidGroupKey,
    );

    await _plugin.show(
      _androidGroupSummaryId,
      'TRAE Forum',
      '你有新的社区消息',
      NotificationDetails(android: summaryAndroidDetails),
    );
  }
}

@pragma('vm:entry-point')
void _backgroundNotificationTapHandler(NotificationResponse response) {
  // 后台点击回调会在 isolate 中触发，导航由主 isolate 在启动后处理。
}
