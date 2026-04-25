/// 标签解析工具。
///
/// 兼容多种来源格式：
/// - `String`（正常标签）
/// - `Map`（如 `{id, name, slug}`）
/// - 字符串化对象（如 `"{id: 1, name: xxx, slug: yyy}"`）
class TagUtil {
  const TagUtil._();

  static List<String> parseTagList(dynamic rawTags) {
    if (rawTags is! List) {
      return const [];
    }

    final tags = <String>[];
    for (final item in rawTags) {
      final parsed = _parseSingle(item);
      if (parsed.isNotEmpty && !tags.contains(parsed)) {
        tags.add(parsed);
      }
    }
    return tags;
  }

  static String _parseSingle(dynamic value) {
    if (value == null) return '';

    if (value is Map) {
      return _sanitize(
        (value['name'] ?? value['slug'] ?? value['id'] ?? '').toString(),
      );
    }

    if (value is String) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return '';

      if (trimmed.startsWith('{') && trimmed.endsWith('}')) {
        final nameMatch = RegExp(r'name\s*:\s*([^,}]+)').firstMatch(trimmed);
        if (nameMatch != null) {
          return _sanitize(nameMatch.group(1) ?? '');
        }
        final slugMatch = RegExp(r'slug\s*:\s*([^,}]+)').firstMatch(trimmed);
        if (slugMatch != null) {
          return _sanitize(slugMatch.group(1) ?? '');
        }
        final idMatch = RegExp(r'id\s*:\s*([^,}]+)').firstMatch(trimmed);
        if (idMatch != null) {
          return _sanitize(idMatch.group(1) ?? '');
        }
      }

      return _sanitize(trimmed);
    }

    return _sanitize(value.toString());
  }

  static String _sanitize(String input) {
    var text = input.trim();
    if (text.isEmpty) return '';

    // 清理常见包裹符号
    text = text
        .replaceAll(RegExp("^[\"'`]+"), '')
        .replaceAll(RegExp("[\"'`]+\$"), '')
        .trim();

    // 去掉 # 前缀，避免重复显示 ##
    text = text.replaceFirst(RegExp(r'^#+\s*'), '').trim();

    // 过滤明显是键名的脏值
    final lower = text.toLowerCase();
    if (lower == 'id' || lower == 'name' || lower == 'slug') {
      return '';
    }

    return text;
  }
}
