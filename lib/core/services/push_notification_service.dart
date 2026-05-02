import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/routes.dart';
import '../../data/models/discourse/discourse_notification.dart';
import '../../presentation/providers/settings_provider.dart';
import '../utils/notification_navigation_resolver.dart';
import 'local_notification_service.dart';

/// Firebase Cloud Messaging 推送通知服务
///
/// 负责处理FCM Token管理、前台/后台消息接收、本地通知展示
/// 以及通知点击跳转等功能
class PushNotificationService {
  PushNotificationService._();
  static final PushNotificationService instance = PushNotificationService._();

  static const String _fcmTokenKey = 'fcm_token';
  static const String _fcmTokenSentKey = 'fcm_token_sent_to_server';
  static const String _notificationEnabledKey = 'push_notification_enabled';

  FirebaseMessaging? _messaging;
  final LocalNotificationService _localNotificationService =
      LocalNotificationService.instance;

  bool _initialized = false;
  bool _firebaseAvailable = false;
  String? _currentToken;
  Ref? _ref;

  /// 获取当前FCM Token
  String? get currentToken => _currentToken;

  /// 是否已初始化
  bool get isInitialized => _initialized;

  /// 初始化推送服务
  ///
  /// [ref] Riverpod Ref，用于访问设置和状态
  Future<void> initialize(Ref ref) async {
    if (_initialized) return;

    _ref = ref;

    try {
      // 初始化Firebase（如果未配置Firebase，则跳过FCM功能）
      final firebaseInitialized = await _initializeFirebase();
      if (!firebaseInitialized) {
        debugPrint('⚠️ [PushNotificationService] Firebase未配置，跳过FCM推送服务');
        // 仍然初始化本地通知服务
        await _localNotificationService.initialize();
        _initialized = true;
        return;
      }

      // 初始化本地通知服务
      await _localNotificationService.initialize();

      // 请求通知权限
      await _requestPermission();

      // 配置FCM消息处理
      await _configureFCM();

      // 获取并保存FCM Token
      await _refreshToken();

      _initialized = true;
      debugPrint('✅ [PushNotificationService] 推送服务初始化完成');
    } catch (e, stackTrace) {
      debugPrint('❌ [PushNotificationService] 初始化失败: $e');
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// 初始化Firebase
  ///
  /// 返回是否成功初始化。如果没有配置Firebase（缺少google-services.json等），
  /// 则返回false，应用将继续运行但不使用FCM功能。
  Future<bool> _initializeFirebase() async {
    try {
      // 检查Firebase是否已初始化
      if (Firebase.apps.isNotEmpty) {
        debugPrint('ℹ️ [PushNotificationService] Firebase已初始化');
        _messaging = FirebaseMessaging.instance;
        _firebaseAvailable = true;
        return true;
      }

      // 尝试初始化Firebase
      await Firebase.initializeApp();
      debugPrint('✅ [PushNotificationService] Firebase初始化完成');
      _messaging = FirebaseMessaging.instance;
      _firebaseAvailable = true;
      return true;
    } catch (e) {
      // 检查是否是配置错误（缺少配置文件）
      final errorString = e.toString();
      if (errorString.contains('no-app') ||
          errorString.contains('configure') ||
          errorString.contains('google-services') ||
          errorString.contains('FirebaseApp')) {
        debugPrint('⚠️ [PushNotificationService] Firebase未配置: $e');
        debugPrint('   如需使用FCM推送功能，请配置Firebase项目');
        _firebaseAvailable = false;
        return false;
      }

      // 其他错误，记录但继续
      debugPrint('⚠️ [PushNotificationService] Firebase初始化失败: $e');
      _firebaseAvailable = false;
      return false;
    }
  }

  /// 请求通知权限
  ///
  /// iOS需要显式请求权限，Android 13+也需要
  Future<NotificationSettings?> _requestPermission() async {
    if (_messaging == null) return null;
    
    final settings = await _messaging!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    debugPrint(
      'ℹ️ [PushNotificationService] 通知权限状态: ${settings.authorizationStatus}',
    );

    // 同时请求本地通知权限
    await _localNotificationService.requestPermissions();

    return settings;
  }

  /// 检查通知权限状态
  Future<bool> checkPermission() async {
    if (_messaging == null) return false;
    final settings = await _messaging!.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional;
  }

  /// 配置FCM消息处理
  Future<void> _configureFCM() async {
    if (_messaging == null) return;
    
    // 设置前台消息处理
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // 设置后台消息处理（应用处于后台但未被杀死）
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    // 设置Token刷新监听
    _messaging!.onTokenRefresh.listen(_handleTokenRefresh);

    // 获取初始消息（应用从终止状态通过通知启动）
    final initialMessage = await _messaging!.getInitialMessage();
    if (initialMessage != null) {
      _handleInitialMessage(initialMessage);
    }

    // 注册后台消息处理程序（应用被杀死时）
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  /// 处理前台消息
  ///
  /// [message] FCM消息
  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('📩 [PushNotificationService] 收到前台消息:');
    debugPrint('  Title: ${message.notification?.title}');
    debugPrint('  Body: ${message.notification?.body}');
    debugPrint('  Data: ${message.data}');

    // 检查是否开启了推送通知
    if (_ref != null) {
      final settings = _ref!.read(currentSettingsProvider);
      if (!settings.pushNotification) {
        debugPrint('ℹ️ [PushNotificationService] 推送通知已关闭，忽略消息');
        return;
      }
    }

    // 解析消息数据
    final notification = _parseRemoteMessage(message);
    if (notification != null) {
      // 显示本地通知
      await _showLocalNotification(notification, message);
    }
  }

  /// 处理应用从后台通过通知启动
  ///
  /// [message] FCM消息
  Future<void> _handleMessageOpenedApp(RemoteMessage message) async {
    debugPrint('📩 [PushNotificationService] 应用从后台通过通知启动');
    _navigateFromMessage(message);
  }

  /// 处理初始消息（应用从终止状态启动）
  ///
  /// [message] FCM消息
  void _handleInitialMessage(RemoteMessage message) {
    debugPrint('📩 [PushNotificationService] 应用从终止状态通过通知启动');

    // 延迟导航，等待应用完全初始化
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _navigateFromMessage(message);
    });
  }

  /// 处理Token刷新
  ///
  /// [token] 新的FCM Token
  Future<void> _handleTokenRefresh(String token) async {
    debugPrint('🔄 [PushNotificationService] FCM Token已刷新');
    _currentToken = token;
    await _saveToken(token);
    await _sendTokenToServer(token);
  }

  /// 刷新FCM Token
  Future<void> _refreshToken() async {
    if (_messaging == null) return;
    
    try {
      final token = await _messaging!.getToken();
      if (token != null) {
        _currentToken = token;
        await _saveToken(token);
        await _sendTokenToServer(token);
        debugPrint('✅ [PushNotificationService] FCM Token获取成功');
      }
    } catch (e) {
      debugPrint('❌ [PushNotificationService] 获取FCM Token失败: $e');
    }
  }

  /// 保存Token到本地
  ///
  /// [token] FCM Token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fcmTokenKey, token);
  }

  /// 从本地获取Token
  Future<String?> _getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fcmTokenKey);
  }

  /// 发送Token到服务器
  ///
  /// [token] FCM Token
  /// 实际项目中应该调用后端API将Token与用户关联
  Future<void> _sendTokenToServer(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastSentToken = prefs.getString(_fcmTokenSentKey);

      // 如果Token未变化，不需要重新发送
      if (lastSentToken == token) {
        debugPrint('ℹ️ [PushNotificationService] Token未变化，跳过发送');
        return;
      }

      // TODO: 调用后端API发送Token
      // 示例: await _ref?.read(apiServiceProvider).registerFCMToken(token);
      debugPrint('📤 [PushNotificationService] 发送Token到服务器: $token');

      // 标记Token已发送
      await prefs.setString(_fcmTokenSentKey, token);
    } catch (e) {
      debugPrint('❌ [PushNotificationService] 发送Token到服务器失败: $e');
    }
  }

  /// 删除服务器上的Token（退出登录时调用）
  Future<void> deleteToken() async {
    if (_messaging == null) return;
    
    try {
      // TODO: 调用后端API删除Token
      // 示例: await _ref?.read(apiServiceProvider).unregisterFCMToken(_currentToken);

      await _messaging!.deleteToken();
      _currentToken = null;

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_fcmTokenKey);
      await prefs.remove(_fcmTokenSentKey);

      debugPrint('✅ [PushNotificationService] FCM Token已删除');
    } catch (e) {
      debugPrint('❌ [PushNotificationService] 删除Token失败: $e');
    }
  }

  /// 订阅主题
  ///
  /// [topic] 主题名称
  Future<void> subscribeToTopic(String topic) async {
    if (_messaging == null) return;
    
    try {
      await _messaging!.subscribeToTopic(topic);
      debugPrint('✅ [PushNotificationService] 已订阅主题: $topic');
    } catch (e) {
      debugPrint('❌ [PushNotificationService] 订阅主题失败: $e');
    }
  }

  /// 取消订阅主题
  ///
  /// [topic] 主题名称
  Future<void> unsubscribeFromTopic(String topic) async {
    if (_messaging == null) return;
    
    try {
      await _messaging!.unsubscribeFromTopic(topic);
      debugPrint('✅ [PushNotificationService] 已取消订阅主题: $topic');
    } catch (e) {
      debugPrint('❌ [PushNotificationService] 取消订阅主题失败: $e');
    }
  }

  /// 解析FCM消息为本地通知模型
  ///
  /// [message] FCM消息
  DiscourseNotification? _parseRemoteMessage(RemoteMessage message) {
    try {
      final data = message.data;

      // 从data中提取通知信息
      final notificationId = int.tryParse(data['notification_id'] ?? '') ??
          DateTime.now().millisecondsSinceEpoch;
      final topicId = int.tryParse(data['topic_id'] ?? '');
      final postNumber = int.tryParse(data['post_number'] ?? '');
      final notificationType =
          int.tryParse(data['notification_type'] ?? '') ?? 0;

      if (topicId == null) {
        debugPrint('⚠️ [PushNotificationService] 消息缺少topic_id');
        return null;
      }

      return DiscourseNotification(
        id: notificationId,
        notificationType: notificationType,
        topicId: topicId,
        postNumber: postNumber,
        topicTitle: message.notification?.title ?? data['title'],
        fancyTitle: message.notification?.title ?? data['title'],
        actingUserName: data['username'],
        displayUsername: data['username'],
        read: false,
        createdAt: DateTime.now().toIso8601String(),
        data: NotificationData(
          topicTitle: data['title'],
          originalPostId: int.tryParse(data['post_id'] ?? ''),
          originalPostType: 1,
          displayUsername: data['username'],
        ),
      );
    } catch (e) {
      debugPrint('❌ [PushNotificationService] 解析消息失败: $e');
      return null;
    }
  }

  /// 显示本地通知
  ///
  /// [notification] 通知模型
  /// [message] FCM消息
  Future<void> _showLocalNotification(
    DiscourseNotification notification,
    RemoteMessage message,
  ) async {
    if (_ref == null) return;

    final settings = _ref!.read(currentSettingsProvider);

    // 检查通知类型是否被允许
    if (!_isNotificationTypeEnabled(notification.notificationType, settings)) {
      return;
    }

    await _localNotificationService.showForumMessageNotification(
      notification: notification,
      settings: settings,
    );
  }

  /// 检查通知类型是否被允许
  ///
  /// [type] 通知类型
  /// [settings] 应用设置
  bool _isNotificationTypeEnabled(int type, AppSettings settings) {
    switch (type) {
      case DiscourseNotificationType.replied:
      case DiscourseNotificationType.posted:
      case DiscourseNotificationType.quoted:
        return settings.notifyReplies;
      case DiscourseNotificationType.liked:
      case DiscourseNotificationType.likedConsolidated:
      case DiscourseNotificationType.reaction:
        return settings.notifyLikes;
      case DiscourseNotificationType.mentioned:
      case DiscourseNotificationType.groupMentioned:
        return settings.notifyMentions;
      case DiscourseNotificationType.following:
      case DiscourseNotificationType.followingCreatedTopic:
      case DiscourseNotificationType.followingReplied:
        return settings.notifyFollows;
      default:
        return settings.notifySystem;
    }
  }

  /// 从消息导航到对应页面
  ///
  /// [message] FCM消息
  void _navigateFromMessage(RemoteMessage message) {
    final data = message.data;
    final topicId = data['topic_id'];
    final postNumber = data['post_number'];
    final notificationType = data['notification_type'];

    // 构建payload
    final payload = jsonEncode({
      'topicId': topicId,
      'postNumber': postNumber,
      'notificationType': notificationType,
    });

    // 使用导航解析器获取目标路径
    final decision = NotificationNavigationResolver.resolveFromPayload(payload);

    // 执行导航
    try {
      AppRouter.router.push(decision.targetPath);
      debugPrint('✅ [PushNotificationService] 导航到: ${decision.targetPath}');
    } catch (e) {
      debugPrint('❌ [PushNotificationService] 导航失败: $e');
      // 导航失败时跳转到通知列表
      AppRouter.push('/message');
    }
  }

  /// 设置推送通知开关
  ///
  /// [enabled] 是否开启
  Future<void> setPushNotificationEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationEnabledKey, enabled);

    if (enabled) {
      // 开启时刷新Token
      await _refreshToken();
    } else {
      // 关闭时删除Token
      await deleteToken();
    }
  }

  /// 获取推送通知开关状态
  Future<bool> getPushNotificationEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_notificationEnabledKey) ?? true;
  }

  /// 销毁服务
  void dispose() {
    _ref = null;
    _initialized = false;
  }
}

/// 后台消息处理程序
///
/// 必须在顶层定义，不能是类的实例方法
/// 当应用被杀死时，系统会调用此函数处理FCM消息
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // 确保Flutter绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();

  debugPrint('📩 [FCM Background] 收到后台消息:');
  debugPrint('  Title: ${message.notification?.title}');
  debugPrint('  Body: ${message.notification?.body}');
  debugPrint('  Data: ${message.data}');

  // 初始化Firebase（如果未初始化）
  // 如果没有配置Firebase，则直接返回，不处理后台消息
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (e) {
    debugPrint('⚠️ [FCM Background] Firebase未配置，跳过后台消息处理: $e');
    return;
  }

  // 初始化本地通知
  await LocalNotificationService.instance.initialize();

  // 解析并显示通知
  final notification = _parseBackgroundMessage(message);
  if (notification != null) {
    // 获取保存的设置
    final prefs = await SharedPreferences.getInstance();
    final settingsJson = prefs.getString('app_settings');
    final settings = settingsJson != null
        ? AppSettings.fromJson(
            Map<String, dynamic>.from(jsonDecode(settingsJson)),
          )
        : const AppSettings();

    // 检查推送通知是否开启
    if (!settings.pushNotification) {
      return;
    }

    await LocalNotificationService.instance.showForumMessageNotification(
      notification: notification,
      settings: settings,
    );
  }
}

/// 解析后台消息
///
/// [message] FCM消息
DiscourseNotification? _parseBackgroundMessage(RemoteMessage message) {
  try {
    final data = message.data;
    final notificationId = int.tryParse(data['notification_id'] ?? '') ??
        DateTime.now().millisecondsSinceEpoch;
    final topicId = int.tryParse(data['topic_id'] ?? '');
    final postNumber = int.tryParse(data['post_number'] ?? '');
    final notificationType = int.tryParse(data['notification_type'] ?? '') ?? 0;

    if (topicId == null) {
      return null;
    }

    return DiscourseNotification(
      id: notificationId,
      notificationType: notificationType,
      topicId: topicId,
      postNumber: postNumber,
      topicTitle: message.notification?.title ?? data['title'],
      fancyTitle: message.notification?.title ?? data['title'],
      actingUserName: data['username'],
      displayUsername: data['username'],
      read: false,
      createdAt: DateTime.now().toIso8601String(),
      data: NotificationData(
        topicTitle: data['title'],
        originalPostId: int.tryParse(data['post_id'] ?? ''),
        originalPostType: 1,
        displayUsername: data['username'],
      ),
    );
  } catch (e) {
    return null;
  }
}
