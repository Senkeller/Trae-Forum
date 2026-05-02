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

  /// 简化 HTML 内容，保留基本格式但移除不必要的标签
  ///
  /// [html] 原始 HTML 内容
  /// @return 简化后的 HTML 内容
  static String simplifyHtml(String html) {
    var result = html;

    // 移除 script 和 style 标签及其内容
    result = result.replaceAll(RegExp(r'<script[^>]*>[\s\S]*?</script>', caseSensitive: false), '');
    result = result.replaceAll(RegExp(r'<style[^>]*>[\s\S]*?</style>', caseSensitive: false), '');

    // 移除 data-* 属性
    result = result.replaceAll(RegExp(r'\sdata-[\w-]+="[^"]*"'), '');

    // 移除 class 属性（但保留一些基本类）
    result = result.replaceAll(RegExp(r'\sclass="[^"]*"'), '');

    // 移除 id 属性
    result = result.replaceAll(RegExp(r'\sid="[^"]*"'), '');

    // 移除空的 span 标签
    result = result.replaceAll(RegExp(r'<span>\s*</span>'), '');

    // 移除空的 p 标签
    result = result.replaceAll(RegExp(r'<p>\s*</p>'), '');

    // 移除多余的空白
    result = result.replaceAll(RegExp(r'>\s+<'), '><');

    return result.trim();
  }
}
