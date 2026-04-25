/// 标签组数据模型
///
/// 用于展示话题分类和标签
class TagGroup {
  /// 分类名称
  final String category;

  /// 分类图标
  final String icon;

  /// 标签列表
  final List<TagItem> tags;

  const TagGroup({
    required this.category,
    required this.icon,
    required this.tags,
  });
}

/// 标签项数据模型
///
/// 用于展示单个标签
class TagItem {
  /// 标签名称
  final String name;

  /// 标签slug
  final String slug;

  /// 话题数量
  final int count;

  /// 标签图标/图片URL
  final String? imageUrl;

  /// 标签颜色
  final String? color;

  const TagItem({
    required this.name,
    required this.slug,
    this.count = 0,
    this.imageUrl,
    this.color,
  });
}

/// 标签数据
///
/// 从 https://forum.trae.cn/tags 获取的标签数据
class TagData {
  /// 获取所有标签分组
  static List<TagGroup> getAllTagGroups() {
    return [
      const TagGroup(
        category: '推荐',
        icon: 'recommend',
        tags: [
          TagItem(name: '新人必看', slug: '40-tag', count: 156, color: '#FF6B6B'),
          TagItem(name: '精华神帖', slug: '32-tag', count: 89, color: '#FFD93D'),
          TagItem(name: 'featured', slug: '42-tag', count: 234, color: '#6BCB77'),
        ],
      ),
      const TagGroup(
        category: '热门',
        icon: 'hot',
        tags: [
          TagItem(name: '基础技巧', slug: '11-tag', count: 582, color: '#4ECDC4'),
          TagItem(name: 'solo', slug: '2-tag', count: 507, color: '#FF6B9D'),
          TagItem(name: 'Skills', slug: '7-tag', count: 280, color: '#C9B1FF'),
          TagItem(name: '模型', slug: '3-tag', count: 223, color: '#95E1D3'),
          TagItem(name: 'mcp', slug: '8-tag', count: 50, color: '#F38181'),
          TagItem(name: 'rules', slug: '6-tag', count: 22, color: '#AA96DA'),
        ],
      ),
      const TagGroup(
        category: '互动话题',
        icon: 'interaction',
        tags: [
          TagItem(name: 'trae今日打卡', slug: '26-tag', count: 111, color: '#FCBAD3'),
          TagItem(name: 'trae的n种用法', slug: '30-tag', count: 12, color: '#FFFFD2'),
          TagItem(name: '周五用trae早下班', slug: '25-tag', count: 1, color: '#A8D8EA'),
        ],
      ),
      const TagGroup(
        category: '产品功能',
        icon: 'product',
        tags: [
          TagItem(name: '自定义智能体', slug: '10-tag', count: 21, color: '#AA96DA'),
          TagItem(name: '远程开发', slug: '12-tag', count: 2, color: '#FCBAD3'),
          TagItem(name: '提示词工程', slug: '5-tag', count: 1, color: '#FFFFD2'),
          TagItem(name: 'cue', slug: '9-tag', count: 1, color: '#A8D8EA'),
        ],
      ),
      const TagGroup(
        category: 'SOLO活动',
        icon: 'solo',
        tags: [
          TagItem(name: '新SOLO初体验', slug: '46-tag', count: 89, color: '#FF6B6B'),
          TagItem(name: 'SOLO赛事速递', slug: '50-tag', count: 156, color: '#4ECDC4'),
          TagItem(name: 'Code-with-SOLO', slug: '47-tag', count: 45, color: '#FFD93D'),
          TagItem(name: 'More-than-Coding', slug: '48-tag', count: 34, color: '#6BCB77'),
          TagItem(name: 'Hello-AI-科技致善', slug: '51-tag', count: 67, color: '#FF6B9D'),
          TagItem(name: 'SOLO独立端', slug: '44-tag', count: 23, color: '#C9B1FF'),
          TagItem(name: 'trae技巧便利店', slug: '17-tag', count: 78, color: '#95E1D3'),
        ],
      ),
      const TagGroup(
        category: '行业/职业',
        icon: 'career',
        tags: [
          TagItem(name: '产品', slug: '33-tag', count: 156, color: '#F38181'),
          TagItem(name: '设计', slug: '41-tag', count: 134, color: '#AA96DA'),
          TagItem(name: '游戏开发', slug: '19-tag', count: 89, color: '#FCBAD3'),
          TagItem(name: '全栈开发', slug: '18-tag', count: 234, color: '#FFFFD2'),
          TagItem(name: '数据分析', slug: '35-tag', count: 67, color: '#A8D8EA'),
          TagItem(name: '市场运营', slug: '34-tag', count: 45, color: '#4ECDC4'),
        ],
      ),
      const TagGroup(
        category: '其他',
        icon: 'other',
        tags: [
          TagItem(name: '已解决', slug: '20-tag', count: 1234, color: '#6BCB77'),
          TagItem(name: 'openclaw', slug: '39-tag', count: 12, color: '#FF6B9D'),
          TagItem(name: '活动回顾', slug: '16-tag', count: 56, color: '#C9B1FF'),
          TagItem(name: '游戏', slug: '45-tag', count: 234, color: '#95E1D3'),
          TagItem(name: '模型效果', slug: '49-tag', count: 89, color: '#F38181'),
        ],
      ),
    ];
  }

  /// 获取所有分类名称
  static List<String> getCategories() {
    return getAllTagGroups().map((g) => g.category).toList();
  }

  /// 根据分类获取标签
  static List<TagItem> getTagsByCategory(String category) {
    final group = getAllTagGroups().firstWhere(
      (g) => g.category == category,
      orElse: () => const TagGroup(category: '', icon: '', tags: []),
    );
    return group.tags;
  }
}
