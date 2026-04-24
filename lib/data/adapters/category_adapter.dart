import '../models/discourse/discourse_category.dart';

/// Category 适配器
///
/// 负责将 Discourse Category 数据转换为应用所需的数据格式
class CategoryAdapter {
  /// 将 Discourse Category 适配为分类模型
  ///
  /// [category] Discourse 分类数据
  /// @return 适配后的分类数据
  static Map<String, dynamic> adaptCategory(DiscourseCategory category) {
    return {
      'id': category.id.toString(),
      'name': category.name,
      'slug': category.slug,
      'description': category.description ?? '',
      'color': category.color,
      'topicCount': category.topicCount,
      'postCount': category.postCount,
    };
  }

  /// 将 Discourse Category 列表适配为分类列表
  ///
  /// [categories] Discourse 分类列表
  /// @return 适配后的分类列表
  static List<Map<String, dynamic>> adaptCategoryList(
    List<DiscourseCategory> categories,
  ) {
    return categories.map((category) => adaptCategory(category)).toList();
  }
}