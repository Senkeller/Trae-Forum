import '../models/discourse/discourse_topic.dart';

export 'topic_adapter.dart';
export 'post_adapter.dart';
export 'category_adapter.dart';
export 'user_adapter.dart';

/// Discourse 数据适配器
///
/// 负责将 Discourse API 数据转换为应用数据模型
/// 提供通用的工具方法供各专用适配器使用
class DiscourseAdapter {
  /// 格式化 Discourse 头像 URL
  ///
  /// [template] 头像模板
  /// [username] 用户名
  /// @return 完整的头像 URL
  static String formatAvatarUrl(String template, String username) {
    if (template.isEmpty) {
      return 'https://forum.trae.cn/user_avatar/forum.trae.cn/$username/120/0_2.png';
    }

    String url = template;
    url = url.replaceAll('{username}', username);
    url = url.replaceAll('{size}', '120');

    if (!url.startsWith('http')) {
      url = 'https://forum.trae.cn$url';
    }

    return url;
  }

  /// 查找用户 by ID
  ///
  /// [userId] 用户ID
  /// [users] 用户列表
  /// @return 匹配的用户，未找到则返回 null
  static DiscourseUserBasic? findUserById(int userId, List<DiscourseUserBasic> users) {
    if (userId == 0) return users.isNotEmpty ? users.first : null;
    try {
      return users.firstWhere((u) => u.id == userId);
    } catch (_) {
      return users.isNotEmpty ? users.first : null;
    }
  }

  /// 解析 ISO 8601 时间字符串为 Unix 时间戳
  ///
  /// [isoString] ISO 8601 格式的时间字符串
  /// @return Unix 时间戳（秒）
  static int parseIso8601ToTimestamp(String isoString) {
    if (isoString.isEmpty) return 0;
    try {
      final dateTime = DateTime.parse(isoString);
      return dateTime.millisecondsSinceEpoch ~/ 1000;
    } catch (_) {
      return 0;
    }
  }

  /// 处理 HTML 内容，清理和转换
  ///
  /// [html] HTML 内容
  /// @return 处理后的内容
  static String processHtmlContent(String? html) {
    if (html == null || html.isEmpty) return '';
    return html;
  }
}