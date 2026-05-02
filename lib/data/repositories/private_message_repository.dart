import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/discourse_api_service.dart';
import '../models/discourse/discourse_private_message.dart';
import '../models/discourse/discourse_post.dart';

part 'private_message_repository.g.dart';

/// 私信仓库
/// 负责处理私信相关的数据操作，包括获取会话列表、发送消息、获取消息详情等
@riverpod
PrivateMessageRepository privateMessageRepository(PrivateMessageRepositoryRef ref) {
  final apiService = ref.read(discourseApiServiceProvider);
  return PrivateMessageRepository(apiService);
}

/// 私信仓库类
class PrivateMessageRepository {
  final DiscourseApiService _apiService;

  PrivateMessageRepository(this._apiService);

  /// 获取私信会话列表
  ///
  /// [username] 当前用户名
  /// [page] 页码，从0开始
  /// 返回私信会话列表响应
  Future<DiscoursePrivateMessageListResponse> getConversations({
    required String username,
    int page = 0,
  }) async {
    try {
      final response = await _apiService.getPrivateMessageTopics(username, page: page);
      final data = response.data as Map<String, dynamic>;
      return DiscoursePrivateMessageListResponse.fromJson(data);
    } catch (e) {
      return const DiscoursePrivateMessageListResponse(
        topicList: DiscoursePrivateMessageList(topics: []),
      );
    }
  }

  /// 获取私信详情
  ///
  /// [topicId] 私信话题ID
  /// 返回私信详情响应
  Future<DiscoursePrivateMessageDetailResponse> getConversationDetail({
    required int topicId,
  }) async {
    try {
      final response = await _apiService.getPrivateMessageDetail(topicId);
      final data = response.data as Map<String, dynamic>;
      return DiscoursePrivateMessageDetailResponse.fromJson(data);
    } catch (e) {
      return const DiscoursePrivateMessageDetailResponse();
    }
  }

  /// 获取私信消息列表
  ///
  /// [topicId] 私信话题ID
  /// [page] 页码，从0开始
  /// 返回帖子列表
  Future<List<DiscoursePost>> getMessages({
    required int topicId,
    int page = 0,
  }) async {
    try {
      final response = await _apiService.getPrivateMessagePosts(topicId, page: page);
      final data = response.data as Map<String, dynamic>;
      final posts = data['post_stream']?['posts'] as List<dynamic>? ?? [];
      return posts
          .map((post) => DiscoursePost.fromJson(post as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 发送新私信（创建私信话题）
  ///
  /// [title] 私信标题
  /// [content] 私信内容（原始Markdown格式）
  /// [targetUsernames] 接收者用户名列表
  /// 返回发送响应
  Future<SendPrivateMessageResponse> sendPrivateMessage({
    required String title,
    required String content,
    required List<String> targetUsernames,
  }) async {
    try {
      final response = await _apiService.createPrivateMessage(
        title: title,
        raw: content,
        targetUsernames: targetUsernames,
      );
      final data = response.data as Map<String, dynamic>;
      return SendPrivateMessageResponse.fromJson(data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final data = e.response!.data as Map<String, dynamic>?;
        return SendPrivateMessageResponse(
          errors: data?['errors']?.cast<String>() ?? ['发送失败'],
          errorType: data?['error_type'],
          message: data?['message'],
        );
      }
      return SendPrivateMessageResponse(
        errors: ['网络错误: $e'],
      );
    }
  }

  /// 回复私信
  ///
  /// [topicId] 私信话题ID
  /// [content] 回复内容（原始Markdown格式）
  /// 返回发送响应
  Future<SendPrivateMessageResponse> replyToMessage({
    required int topicId,
    required String content,
  }) async {
    try {
      final response = await _apiService.replyToPrivateMessage(
        topicId: topicId,
        raw: content,
      );
      final data = response.data as Map<String, dynamic>;
      return SendPrivateMessageResponse.fromJson(data);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final data = e.response!.data as Map<String, dynamic>?;
        return SendPrivateMessageResponse(
          errors: data?['errors']?.cast<String>() ?? ['回复失败'],
          errorType: data?['error_type'],
          message: data?['message'],
        );
      }
      return SendPrivateMessageResponse(
        errors: ['网络错误: $e'],
      );
    }
  }

  /// 邀请用户加入私信
  ///
  /// [topicId] 私信话题ID
  /// [usernames] 要邀请的用户名列表
  Future<bool> inviteUsers({
    required int topicId,
    required List<String> usernames,
  }) async {
    try {
      final response = await _apiService.inviteToPrivateMessage(
        topicId: topicId,
        usernames: usernames,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// 离开私信会话
  ///
  /// [topicId] 私信话题ID
  /// [username] 当前用户名
  Future<bool> leaveConversation({
    required int topicId,
    required String username,
  }) async {
    try {
      final response = await _apiService.leavePrivateMessage(
        topicId: topicId,
        username: username,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  /// 获取私信未读计数
  ///
  /// [username] 当前用户名
  /// 返回未读计数列表
  Future<List<PrivateMessageUnreadCount>> getUnreadCounts({
    required String username,
  }) async {
    try {
      final response = await _apiService.getPrivateMessageTrackingState(username);
      final data = response.data as Map<String, dynamic>;
      final trackingState = data['private_message_topic_tracking_state'] as List<dynamic>? ?? [];
      return trackingState
          .map((item) => PrivateMessageUnreadCount.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return [];
    }
  }

  /// 计算总未读数
  ///
  /// [username] 当前用户名
  /// 返回总未读消息数
  Future<int> getTotalUnreadCount({required String username}) async {
    final counts = await getUnreadCounts(username: username);
    return counts.fold<int>(0, (sum, item) => sum + item.unreadCount);
  }

  /// 将会话列表转换为简化的会话摘要列表
  ///
  /// [response] 私信列表响应
  /// [currentUsername] 当前用户名（用于确定对方用户）
  /// 返回会话摘要列表
  List<PrivateMessageConversation> convertToConversations(
    DiscoursePrivateMessageListResponse response,
    String currentUsername,
  ) {
    final topics = response.topicList?.topics ?? [];
    final users = response.users;

    return topics.map((topic) {
      // 找到对方用户（非当前用户）
      DiscourseUserBasic? otherParticipant;
      if (topic.allowedUsers.isNotEmpty) {
        otherParticipant = topic.allowedUsers.firstWhere(
          (user) => user.username != currentUsername,
          orElse: () => topic.allowedUsers.first,
        );
      } else if (topic.participants.isNotEmpty) {
        // 从参与者转换为 DiscourseUserBasic
        final participant = topic.participants.firstWhere(
          (p) => p.username != currentUsername,
          orElse: () => topic.participants.first,
        );
        otherParticipant = DiscourseUserBasic(
          id: participant.id,
          username: participant.username,
          name: participant.name,
          avatarTemplate: participant.avatarTemplate,
        );
      }

      // 从用户列表中查找完整的用户信息
      DiscourseUserBasic? fullUserInfo;
      if (otherParticipant != null) {
        fullUserInfo = users.firstWhere(
          (u) => u.username == otherParticipant!.username,
          orElse: () => otherParticipant!,
        );
      }

      return PrivateMessageConversation(
        id: topic.id,
        title: topic.fancyTitle ?? topic.title,
        slug: topic.slug,
        lastMessage: topic.excerpt,
        lastPostedAt: topic.lastPostedAt ?? topic.bumpedAt,
        unreadCount: topic.unreadPosts,
        totalMessages: topic.postsCount,
        participants: topic.allowedUsers.isNotEmpty
            ? topic.allowedUsers
            : topic.participants.map((p) => DiscourseUserBasic(
                  id: p.id,
                  username: p.username,
                  name: p.name,
                  avatarTemplate: p.avatarTemplate,
                )).toList(),
        otherParticipant: fullUserInfo,
        createdAt: topic.createdAt,
        closed: topic.closed,
        archived: topic.archived,
      );
    }).toList();
  }
}
