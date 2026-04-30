import 'dart:convert';

/// 标准化草稿解析结果
class DraftNormalizedData {
  final String? title;
  final String? content;

  const DraftNormalizedData({this.title, this.content});
}

/// 草稿数据标准化工具
///
/// 统一解析常见草稿结构，兼容：
/// - 顶层或嵌套字段（draft/data/payload）
/// - 标题字段（title/topic_title/subject）
/// - 内容字段（raw/content/cooked 等）
class DraftNormalizer {
  static const List<String> _titleKeys = ['title', 'topic_title', 'subject'];
  static const List<String> _contentKeys = [
    'raw',
    'content',
    'draft',
    'markdown',
    'body',
    'cooked',
    'reply',
  ];
  static const List<String> _nestedMapKeys = ['draft', 'data', 'payload'];

  /// 将草稿字符串标准化为可用标题与内容
  ///
  /// 当 `rawDraftData` 是 JSON 时，会优先按标准字段提取；
  /// 当不是 JSON 时，会将其作为纯文本内容返回。
  static DraftNormalizedData normalize(String? rawDraftData) {
    final raw = rawDraftData?.trim();
    if (raw == null || raw.isEmpty) {
      return const DraftNormalizedData();
    }

    final parsed = _parseRawDraftMap(raw);
    if (parsed == null) {
      return DraftNormalizedData(content: raw);
    }

    final title = _firstNonEmpty(parsed, _titleKeys);
    final content = _firstNonEmpty(parsed, _contentKeys);
    return DraftNormalizedData(title: title, content: content);
  }

  static String? _firstNonEmpty(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value == null) continue;
      final text = value.toString().trim();
      if (text.isNotEmpty) return text;
    }
    return null;
  }

  static Map<String, dynamic>? _parseRawDraftMap(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return _flattenDraftMap(decoded);
      }
      if (decoded is Map) {
        return _flattenDraftMap(Map<String, dynamic>.from(decoded));
      }
    } catch (_) {
      // 纯文本草稿不是错误，交由上层回退处理
    }
    return null;
  }

  static Map<String, dynamic> _flattenDraftMap(Map<String, dynamic> source) {
    final flat = <String, dynamic>{};
    final queue = <Map<String, dynamic>>[source];

    while (queue.isNotEmpty) {
      final current = queue.removeLast();
      flat.addAll(current);

      for (final key in _nestedMapKeys) {
        final nested = current[key];
        if (nested is Map<String, dynamic>) {
          queue.add(nested);
        } else if (nested is Map) {
          queue.add(Map<String, dynamic>.from(nested));
        }
      }
    }

    return flat;
  }
}
