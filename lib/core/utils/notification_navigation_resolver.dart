import 'dart:convert';

import '../../config/constants.dart';

class NotificationNavigationDecision {
  final String targetPath;
  final bool isFallback;

  const NotificationNavigationDecision({
    required this.targetPath,
    required this.isFallback,
  });
}

class NotificationNavigationResolver {
  NotificationNavigationResolver._();

  static const String fallbackPath = RoutePaths.notifications;
  static const String secondaryFallbackPath = RoutePaths.message;

  static NotificationNavigationDecision resolveFromPayload(String? payload) {
    if (payload == null || payload.isEmpty) {
      return const NotificationNavigationDecision(
        targetPath: fallbackPath,
        isFallback: true,
      );
    }

    try {
      final map = jsonDecode(payload);
      if (map is! Map<String, dynamic>) {
        return const NotificationNavigationDecision(
          targetPath: fallbackPath,
          isFallback: true,
        );
      }

      final topicId =
          _extractPositiveInt(map, const ['topicId', 'topic_id']) ?? 0;
      final postNumber = _extractPositiveInt(map, const [
        'postNumber',
        'post_number',
      ]);
      if (topicId <= 0) {
        return const NotificationNavigationDecision(
          targetPath: fallbackPath,
          isFallback: true,
        );
      }

      final targetPath = postNumber != null && postNumber > 1
          ? '/feed/$topicId?postNumber=$postNumber'
          : '/feed/$topicId';
      return NotificationNavigationDecision(
        targetPath: targetPath,
        isFallback: false,
      );
    } catch (_) {
      return const NotificationNavigationDecision(
        targetPath: fallbackPath,
        isFallback: true,
      );
    }
  }

  static int? _extractPositiveInt(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final parsed = _tryParsePositiveInt(map[key]);
      if (parsed != null) return parsed;
    }
    return null;
  }

  static int? _tryParsePositiveInt(dynamic value) {
    if (value == null) return null;
    final parsed = switch (value) {
      int v => v,
      num v => v.toInt(),
      String v => int.tryParse(v),
      _ => int.tryParse(value.toString()),
    };
    if (parsed == null || parsed <= 0) return null;
    return parsed;
  }
}
