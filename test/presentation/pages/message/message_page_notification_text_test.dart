import 'package:flutter_test/flutter_test.dart';
import 'package:traeu/data/models/discourse/discourse_notification.dart';
import 'package:traeu/presentation/pages/message/notification_copy.dart';

void main() {
  group('getNotificationActionText', () {
    test('uses specific copy for mention/reply types', () {
      expect(
        getNotificationActionText(DiscourseNotificationType.mentioned),
        '在话题中@了你',
      );
      expect(
        getNotificationActionText(DiscourseNotificationType.groupMentioned),
        '在话题中@了你',
      );
      expect(
        getNotificationActionText(DiscourseNotificationType.replied),
        '回复了你发布的话题',
      );
      expect(
        getNotificationActionText(DiscourseNotificationType.posted),
        '回复了你的评论',
      );
    });

    test('keeps like copy with consolidated count', () {
      expect(
        getNotificationActionText(
          DiscourseNotificationType.liked,
          data: const NotificationData(count: 3),
        ),
        '等3人赞了你',
      );
    });

    test('uses formal tone for system notifications', () {
      expect(
        getNotificationActionText(DiscourseNotificationType.assigned),
        '向你分配了新的待办事项',
      );
      expect(
        getNotificationActionText(
          DiscourseNotificationType.upcomingChangeAvailable,
        ),
        '发布了即将生效的变更通知',
      );
    });
  });

  group('getNotificationContentText', () {
    test('prefers cleaned message summary and topic fallback', () {
      final withMessage = DiscourseNotification(
        id: 1,
        notificationType: DiscourseNotificationType.mentioned,
        data: const NotificationData(message: '<p>你好&nbsp;@你</p>'),
      );
      expect(getNotificationContentText(withMessage), '你好 @你');

      final withTopic = DiscourseNotification(
        id: 2,
        notificationType: DiscourseNotificationType.replied,
        topicTitle: '这是一个话题',
      );
      expect(getNotificationContentText(withTopic), '话题：这是一个话题');
    });

    test('uses natural social tone and formal system tone for fallback copy', () {
      final social = DiscourseNotification(
        id: 3,
        notificationType: DiscourseNotificationType.liked,
      );
      expect(getNotificationContentText(social), '你的内容又收到了新的赞');

      final system = DiscourseNotification(
        id: 4,
        notificationType: DiscourseNotificationType.postApproved,
      );
      expect(getNotificationContentText(system), '系统已完成帖子审核，请查看最新状态');
    });
  });
}
