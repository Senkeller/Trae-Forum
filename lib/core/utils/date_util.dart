import 'package:intl/intl.dart';

/// 日期时间工具类
/// 提供日期格式化、相对时间计算、时间戳转换等功能
class DateUtil {
  DateUtil._();

  // 常用日期格式
  static const String formatDefault = 'yyyy-MM-dd HH:mm:ss';
  static const String formatDate = 'yyyy-MM-dd';
  static const String formatTime = 'HH:mm:ss';
  static const String formatDateTime = 'yyyy-MM-dd HH:mm';
  static const String formatMonthDay = 'MM-dd';
  static const String formatMonthDayTime = 'MM-dd HH:mm';
  static const String formatYearMonth = 'yyyy-MM';
  static const String formatCompact = 'yyyyMMddHHmmss';

  /// 格式化日期时间
  /// [date] 日期时间对象
  /// [pattern] 格式化模式，默认为 'yyyy-MM-dd HH:mm:ss'
  /// 返回格式化后的字符串
  static String format(DateTime date, {String pattern = formatDefault}) {
    return DateFormat(pattern).format(date);
  }

  /// 格式化时间戳（毫秒）
  /// [timestamp] 毫秒时间戳
  /// [pattern] 格式化模式，默认为 'yyyy-MM-dd HH:mm:ss'
  /// 返回格式化后的字符串
  static String formatTimestamp(int timestamp, {String pattern = formatDefault}) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return format(date, pattern: pattern);
  }

  /// 格式化时间戳（秒）
  /// [timestamp] 秒时间戳
  /// [pattern] 格式化模式，默认为 'yyyy-MM-dd HH:mm:ss'
  /// 返回格式化后的字符串
  static String formatTimestampSeconds(int timestamp, {String pattern = formatDefault}) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return format(date, pattern: pattern);
  }

  /// 获取相对时间显示
  /// [date] 目标日期时间
  /// [now] 当前时间，默认为系统当前时间
  /// 返回相对时间字符串（刚刚、几分钟前、几小时前等）
  static String getRelativeTime(DateTime date, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final difference = current.difference(date);

    if (difference.inSeconds < 60) {
      return '刚刚';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分钟前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}小时前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}天前';
    } else if (difference.inDays < 30) {
      return '${(difference.inDays / 7).floor()}周前';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else {
      return '${(difference.inDays / 365).floor()}年前';
    }
  }

  /// 获取相对时间显示（从时间戳毫秒）
  /// [timestamp] 毫秒时间戳
  /// 返回相对时间字符串
  static String getRelativeTimeFromTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return getRelativeTime(date);
  }

  /// 获取相对时间显示（从时间戳秒）
  /// [timestamp] 秒时间戳
  /// 返回相对时间字符串
  static String getRelativeTimeFromTimestampSeconds(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return getRelativeTime(date);
  }

  /// 获取智能时间显示
  /// 如果是今天，显示时间；如果是昨天，显示"昨天 HH:mm"；如果是今年，显示"MM-dd"；否则显示"yyyy-MM-dd"
  /// [date] 目标日期时间
  /// 返回智能格式化字符串
  static String getSmartTime(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final targetDate = DateTime(date.year, date.month, date.day);

    if (targetDate == today) {
      return format(date, pattern: 'HH:mm');
    } else if (targetDate == yesterday) {
      return '昨天 ${format(date, pattern: 'HH:mm')}';
    } else if (date.year == now.year) {
      return format(date, pattern: formatMonthDay);
    } else {
      return format(date, pattern: formatDate);
    }
  }

  /// 获取智能时间显示（从时间戳毫秒）
  /// [timestamp] 毫秒时间戳
  /// 返回智能格式化字符串
  static String getSmartTimeFromTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return getSmartTime(date);
  }

  /// 解析日期字符串
  /// [dateString] 日期字符串
  /// [pattern] 日期格式模式
  /// 返回 DateTime 对象，解析失败返回 null
  static DateTime? parse(String dateString, {String pattern = formatDefault}) {
    try {
      return DateFormat(pattern).parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// 解析 ISO 8601 格式日期
  /// [dateString] ISO 8601 格式字符串
  /// 返回 DateTime 对象，解析失败返回 null
  static DateTime? parseIso(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  /// 获取当前时间戳（毫秒）
  /// 返回当前时间的毫秒时间戳
  static int get currentTimestamp => DateTime.now().millisecondsSinceEpoch;

  /// 获取当前时间戳（秒）
  /// 返回当前时间的秒时间戳
  static int get currentTimestampSeconds =>
      DateTime.now().millisecondsSinceEpoch ~/ 1000;

  /// 日期转时间戳（毫秒）
  /// [date] 日期时间对象
  /// 返回毫秒时间戳
  static int toTimestamp(DateTime date) => date.millisecondsSinceEpoch;

  /// 日期转时间戳（秒）
  /// [date] 日期时间对象
  /// 返回秒时间戳
  static int toTimestampSeconds(DateTime date) =>
      date.millisecondsSinceEpoch ~/ 1000;

  /// 获取一天的开始时间
  /// [date] 目标日期
  /// 返回当天 00:00:00 的 DateTime
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// 获取一天的结束时间
  /// [date] 目标日期
  /// 返回当天 23:59:59 的 DateTime
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }

  /// 获取本周开始时间（周一）
  /// [date] 目标日期
  /// 返回本周一的 DateTime
  static DateTime getStartOfWeek(DateTime date) {
    final weekday = date.weekday;
    return getStartOfDay(date.subtract(Duration(days: weekday - 1)));
  }

  /// 获取本周结束时间（周日）
  /// [date] 目标日期
  /// 返回本周日的 DateTime
  static DateTime getEndOfWeek(DateTime date) {
    final weekday = date.weekday;
    return getEndOfDay(date.add(Duration(days: 7 - weekday)));
  }

  /// 获取本月开始时间
  /// [date] 目标日期
  /// 返回本月 1 号的 DateTime
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  /// 获取本月结束时间
  /// [date] 目标日期
  /// 返回本月最后一天的 DateTime
  static DateTime getEndOfMonth(DateTime date) {
    final nextMonth = DateTime(date.year, date.month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1));
  }

  /// 判断是否为今天
  /// [date] 目标日期
  /// 返回是否为今天
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// 判断是否为昨天
  /// [date] 目标日期
  /// 返回是否为昨天
  static bool isYesterday(DateTime date) {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year &&
        date.month == yesterday.month &&
        date.day == yesterday.day;
  }

  /// 判断是否为同年
  /// [date1] 日期 1
  /// [date2] 日期 2，默认为当前时间
  /// 返回是否为同一年
  static bool isSameYear(DateTime date1, {DateTime? date2}) {
    final other = date2 ?? DateTime.now();
    return date1.year == other.year;
  }

  /// 判断是否为同月
  /// [date1] 日期 1
  /// [date2] 日期 2，默认为当前时间
  /// 返回是否为同一月
  static bool isSameMonth(DateTime date1, {DateTime? date2}) {
    final other = date2 ?? DateTime.now();
    return date1.year == other.year && date1.month == other.month;
  }

  /// 判断是否为同一天
  /// [date1] 日期 1
  /// [date2] 日期 2，默认为当前时间
  /// 返回是否为同一天
  static bool isSameDay(DateTime date1, {DateTime? date2}) {
    final other = date2 ?? DateTime.now();
    return date1.year == other.year &&
        date1.month == other.month &&
        date1.day == other.day;
  }

  /// 计算两个日期之间的天数差
  /// [date1] 日期 1
  /// [date2] 日期 2
  /// 返回天数差（date2 - date1）
  static int daysBetween(DateTime date1, DateTime date2) {
    final d1 = DateTime(date1.year, date1.month, date1.day);
    final d2 = DateTime(date2.year, date2.month, date2.day);
    return d2.difference(d1).inDays;
  }

  /// 添加天数
  /// [date] 原始日期
  /// [days] 要添加的天数
  /// 返回新的 DateTime
  static DateTime addDays(DateTime date, int days) {
    return date.add(Duration(days: days));
  }

  /// 添加小时
  /// [date] 原始日期
  /// [hours] 要添加的小时数
  /// 返回新的 DateTime
  static DateTime addHours(DateTime date, int hours) {
    return date.add(Duration(hours: hours));
  }

  /// 添加分钟
  /// [date] 原始日期
  /// [minutes] 要添加的分钟数
  /// 返回新的 DateTime
  static DateTime addMinutes(DateTime date, int minutes) {
    return date.add(Duration(minutes: minutes));
  }

  /// 获取星期几的中文名称
  /// [date] 目标日期
  /// 返回星期几的中文名称
  static String getWeekdayName(DateTime date) {
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return weekdays[date.weekday - 1];
  }

  /// 获取星期几的完整中文名称
  /// [date] 目标日期
  /// 返回星期几的完整中文名称
  static String getWeekdayNameFull(DateTime date) {
    const weekdays = [
      '星期一',
      '星期二',
      '星期三',
      '星期四',
      '星期五',
      '星期六',
      '星期日'
    ];
    return weekdays[date.weekday - 1];
  }

  /// 格式化时长
  /// [duration] 时长
  /// [showSeconds] 是否显示秒，默认为 true
  /// 返回格式化后的时长字符串（如 01:30:45）
  static String formatDuration(Duration duration, {bool showSeconds = true}) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      if (showSeconds) {
        return '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
      } else {
        return '${_twoDigits(hours)}:${_twoDigits(minutes)}';
      }
    } else {
      if (showSeconds) {
        return '${_twoDigits(minutes)}:${_twoDigits(seconds)}';
      } else {
        return _twoDigits(minutes);
      }
    }
  }

  /// 格式化秒数为时长字符串
  /// [seconds] 秒数
  /// 返回格式化后的时长字符串
  static String formatSeconds(int seconds) {
    return formatDuration(Duration(seconds: seconds));
  }

  /// 辅助方法：将数字格式化为两位字符串
  /// [n] 数字
  /// 返回两位数字符串
  static String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }
}
