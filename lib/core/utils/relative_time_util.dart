import 'date_util.dart';

/// 相对时间显示工具
class RelativeTimeUtil {
  RelativeTimeUtil._();

  /// 将 ISO 时间字符串转为相对时间
  static String fromIso(String isoTime, {String? fallback}) {
    final date = DateUtil.parseIso(isoTime);
    if (date == null) return fallback ?? isoTime;
    return DateUtil.getRelativeTime(date);
  }
}
