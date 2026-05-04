import '../../../data/models/discourse/discourse_notification.dart';

String getNotificationActionText(
  int notificationType, {
  NotificationData? data,
}) {
  switch (notificationType) {
    case DiscourseNotificationType.mentioned:
    case DiscourseNotificationType.groupMentioned:
      return '在话题中@了你';
    case DiscourseNotificationType.replied:
      return '回复了你发布的话题';
    case DiscourseNotificationType.posted:
      return '回复了你的评论';
    case DiscourseNotificationType.questionAnswerUserCommented:
      return '评论了你关注的问答内容';
    case DiscourseNotificationType.quoted:
      return '引用了你的内容';
    case DiscourseNotificationType.liked:
    case DiscourseNotificationType.likedConsolidated:
      final count = data?.count ?? 1;
      return count > 1 ? '等$count人赞了你' : '赞了你';
    case DiscourseNotificationType.reaction:
      return '回应了你的内容';
    case DiscourseNotificationType.grantedBadge:
      return '你获得了徽章';
    case DiscourseNotificationType.following:
      return '关注了你';
    case DiscourseNotificationType.followingCreatedTopic:
      return '发布了新话题';
    case DiscourseNotificationType.followingReplied:
      return '回复了你关注的话题';
    case DiscourseNotificationType.edited:
      return '更新了与你相关的帖子';
    case DiscourseNotificationType.invitedToPrivateMessage:
      return '邀请你加入私信';
    case DiscourseNotificationType.invitedToTopic:
      return '邀请你参与话题讨论';
    case DiscourseNotificationType.linked:
    case DiscourseNotificationType.linkedConsolidated:
      return '在帖子中提到了你的内容';
    case DiscourseNotificationType.movedPost:
      return '调整了与你相关帖子的归类';
    case DiscourseNotificationType.watchingCategoryOrTag:
      return '你关注的分类或标签有新内容';
    case DiscourseNotificationType.chatMention:
      return '在聊天中@了你';
    case DiscourseNotificationType.chatMessage:
      return '发送了新的聊天消息';
    case DiscourseNotificationType.chatQuoted:
      return '在聊天中引用了你';
    case DiscourseNotificationType.chatInvitation:
      return '邀请你加入聊天';
    case DiscourseNotificationType.eventInvitation:
      return '邀请你参与活动';
    case DiscourseNotificationType.eventReminder:
      return '向你发送了活动提醒';
    case DiscourseNotificationType.topicReminder:
      return '向你发送了话题提醒';
    case DiscourseNotificationType.watchingFirstPost:
      return '你关注的话题发布了首帖';
    case DiscourseNotificationType.postApproved:
      return '你的帖子已通过审核';
    case DiscourseNotificationType.codeReviewCommitApproved:
      return '你的代码审查提交已通过';
    case DiscourseNotificationType.membershipRequestAccepted:
      return '你的成员请求已被接受';
    case DiscourseNotificationType.membershipRequestConsolidated:
      return '你的成员请求状态已更新';
    case DiscourseNotificationType.votesReleased:
      return '你的投票额度已恢复';
    case DiscourseNotificationType.assigned:
      return '向你分配了新的待办事项';
    case DiscourseNotificationType.custom:
      return '向你发送了系统消息通知';
    case DiscourseNotificationType.newFeatures:
      return '发布了新功能公告';
    case DiscourseNotificationType.adminProblems:
      return '发布了管理员状态提醒';
    case DiscourseNotificationType.upcomingChangeAvailable:
      return '发布了即将生效的变更通知';
    case DiscourseNotificationType.upcomingChangeAutomaticallyPromoted:
      return '发布的变更已自动升级';
    default:
      return '向你发送了通知';
  }
}

String getNotificationContentText(DiscourseNotification notification) {
  final message = _normalizeText(notification.data?.message);
  if (message != null) {
    return message;
  }

  final topicTitle = _normalizeText(notification.topicTitle ?? notification.fancyTitle);
  if (topicTitle != null) {
    return '话题：$topicTitle';
  }

  switch (notification.notificationType) {
    case DiscourseNotificationType.mentioned:
    case DiscourseNotificationType.groupMentioned:
      return '有人在话题内容中@了你，点击查看上下文';
    case DiscourseNotificationType.replied:
      return '有人回复了你发布的话题，点击查看回复详情';
    case DiscourseNotificationType.posted:
      return '有人回复了你的评论，点击查看对话上下文';
    case DiscourseNotificationType.liked:
    case DiscourseNotificationType.likedConsolidated:
      return '你的内容又收到了新的赞';
    case DiscourseNotificationType.quoted:
      return '有人引用了你的内容，点击查看原文上下文';
    case DiscourseNotificationType.reaction:
      return '有人对你的内容做出了回应，点击查看互动详情';
    case DiscourseNotificationType.chatMessage:
    case DiscourseNotificationType.chatMention:
    case DiscourseNotificationType.chatQuoted:
      return '有新的聊天动态，点击进入聊天查看';
    case DiscourseNotificationType.invitedToPrivateMessage:
      return '你收到了私信会话邀请';
    case DiscourseNotificationType.postApproved:
      return '系统已完成帖子审核，请查看最新状态';
    case DiscourseNotificationType.codeReviewCommitApproved:
      return '系统已完成代码审查审批，请查看结果';
    case DiscourseNotificationType.votesReleased:
      return '系统已恢复你的投票额度，可继续参与投票';
    case DiscourseNotificationType.upcomingChangeAvailable:
      return '系统发布了即将生效的变更，请提前关注影响范围';
    case DiscourseNotificationType.upcomingChangeAutomaticallyPromoted:
      return '系统已自动应用变更升级，请确认当前使用状态';
    default:
      return '点击查看通知详情';
  }
}

String? _normalizeText(String? raw) {
  if (raw == null || raw.trim().isEmpty) {
    return null;
  }
  final stripped = raw
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&quot;', '"')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  if (stripped.isEmpty) {
    return null;
  }
  return stripped;
}
