/// HTML 文本工具
class HtmlTextUtil {
  HtmlTextUtil._();

  /// 去除常见 HTML 标签并解码常见实体
  static String stripHtml(
    String input, {
    String tagReplacement = '',
    bool collapseWhitespace = false,
  }) {
    var text = input.replaceAll(RegExp(r'<[^>]*>'), tagReplacement);
    text = text
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&#160;', ' ')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");
    if (collapseWhitespace) {
      text = text.replaceAll(RegExp(r'\s+'), ' ');
    }
    return text.trim();
  }
}
