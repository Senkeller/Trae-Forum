import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/core/utils/notification_navigation_resolver.dart';

void main() {
  group('NotificationNavigationResolver', () {
    test('returns feed detail path for valid topicId', () {
      const payload = '{"topicId":123}';
      final decision = NotificationNavigationResolver.resolveFromPayload(
        payload,
      );

      expect(decision.targetPath, '/feed/123');
      expect(decision.isFallback, isFalse);
    });

    test('supports snake_case keys and string numeric values', () {
      const payload = '{"topic_id":"456","post_number":"9"}';
      final decision = NotificationNavigationResolver.resolveFromPayload(
        payload,
      );

      expect(decision.targetPath, '/feed/456?postNumber=9');
      expect(decision.isFallback, isFalse);
    });

    test('falls back when payload is empty or invalid', () {
      final emptyDecision = NotificationNavigationResolver.resolveFromPayload(
        '',
      );
      final invalidDecision = NotificationNavigationResolver.resolveFromPayload(
        'not-json',
      );

      expect(
        emptyDecision.targetPath,
        NotificationNavigationResolver.fallbackPath,
      );
      expect(emptyDecision.isFallback, isTrue);
      expect(
        invalidDecision.targetPath,
        NotificationNavigationResolver.fallbackPath,
      );
      expect(invalidDecision.isFallback, isTrue);
    });

    test('falls back when topicId is missing or not positive', () {
      const missingTopicIdPayload = '{"postNumber":3}';
      const invalidTopicIdPayload = '{"topicId":0}';

      final missingDecision = NotificationNavigationResolver.resolveFromPayload(
        missingTopicIdPayload,
      );
      final invalidDecision = NotificationNavigationResolver.resolveFromPayload(
        invalidTopicIdPayload,
      );

      expect(
        missingDecision.targetPath,
        NotificationNavigationResolver.fallbackPath,
      );
      expect(missingDecision.isFallback, isTrue);
      expect(
        invalidDecision.targetPath,
        NotificationNavigationResolver.fallbackPath,
      );
      expect(invalidDecision.isFallback, isTrue);
    });
  });
}
