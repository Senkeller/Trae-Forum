import '../models/discourse/discourse_topic.dart';
import '../models/discourse/discourse_user.dart';
import '../models/user.dart';
import 'discourse_adapter.dart';

/// User 适配器
///
/// 负责将 Discourse User 数据转换为应用 User 数据格式
class UserAdapter {
  /// 将 Discourse User Basic 适配为 UserInfo
  ///
  /// [user] Discourse 用户数据
  /// @return UserInfo 实例
  static UserInfo adaptUser(DiscourseUserBasic user) {
    return UserInfo(
      uid: user.id.toString(),
      username: user.username,
      avatar: DiscourseAdapter.formatAvatarUrl(
        user.avatarTemplate,
        user.username,
      ),
      level: user.trustLevel,
    );
  }

  /// 将 Discourse User 详情适配为 UserInfo
  ///
  /// [user] Discourse 用户详情数据
  /// @return UserInfo 实例
  static UserInfo adaptUserFromDetail(DiscourseUser user) {
    return UserInfo(
      uid: user.id.toString(),
      username: user.username,
      avatar: DiscourseAdapter.formatAvatarUrl(
        user.avatarTemplate,
        user.username,
      ),
      level: user.trustLevel,
      bio: user.title ?? '',
    );
  }

  /// 将 Discourse User Basic Info 列表适配为 UserInfo 列表
  ///
  /// [users] Discourse 用户基本信息列表
  /// @return UserInfo 列表
  static List<UserInfo> adaptUserList(List<DiscourseUserBasicInfo> users) {
    return users.map((user) => adaptUserBasicInfo(user)).toList();
  }

  /// 将 Discourse User Basic Info 适配为 UserInfo
  ///
  /// [user] Discourse 用户基本信息
  /// @return UserInfo 实例
  static UserInfo adaptUserBasicInfo(DiscourseUserBasicInfo user) {
    return UserInfo(
      uid: user.id.toString(),
      username: user.username,
      avatar: DiscourseAdapter.formatAvatarUrl(
        user.avatarTemplate,
        user.username,
      ),
      level: user.trustLevel,
    );
  }
}