import 'package:dio/dio.dart';
import '../models/forum_topic.dart';
import '../../core/network/dio_client.dart';

/// 论坛数据仓库
/// 
/// 负责论坛相关的数据获取和缓存管理
class ForumRepository {
  final Dio _dio;

  ForumRepository({Dio? dio}) : _dio = dio ?? DioClient.dio;

  // ==================== 分类相关 ====================

  /// 获取论坛分类列表
  /// 
  /// @return 分类列表响应
  Future<ForumCategoryListResponse> getCategories() async {
    // 由于 TRAE 论坛没有公开 API，这里返回模拟数据
    // 实际项目中应该调用真实的 API
    await Future.delayed(const Duration(milliseconds: 500));
    
    return ForumCategoryListResponse(
      status: 200,
      message: 'success',
      data: _mockCategories,
    );
  }

  /// 根据 slug 获取分类
  /// 
  /// [slug] 分类别名
  /// @return 分类信息
  Future<ForumCategory?> getCategoryBySlug(String slug) async {
    final categories = await getCategories();
    return categories.data.firstWhere(
      (c) => c.slug == slug,
      orElse: () => throw Exception('Category not found'),
    );
  }

  // ==================== 话题相关 ====================

  /// 获取话题列表
  /// 
  /// [page] 页码
  /// [perPage] 每页数量
  /// [categorySlug] 分类别名（可选）
  /// [tagSlug] 标签别名（可选）
  /// [sortBy] 排序方式：latest, hot, top
  /// @return 话题列表响应
  Future<ForumTopicListResponse> getTopics({
    int page = 1,
    int perPage = 20,
    String? categorySlug,
    String? tagSlug,
    String sortBy = 'latest',
  }) async {
    // 模拟网络延迟
    await Future.delayed(const Duration(milliseconds: 800));
    
    // 根据参数筛选模拟数据
    var topics = List<ForumTopic>.from(_mockTopics);
    
    if (categorySlug != null) {
      topics = topics.where((t) => t.category?.slug == categorySlug).toList();
    }
    
    if (tagSlug != null) {
      topics = topics.where((t) => 
        t.tags.any((tag) => tag.slug == tagSlug)
      ).toList();
    }
    
    // 排序
    switch (sortBy) {
      case 'hot':
        topics.sort((a, b) => b.viewCount.compareTo(a.viewCount));
        break;
      case 'top':
        topics.sort((a, b) => b.voteCount.compareTo(a.voteCount));
        break;
      case 'latest':
      default:
        // 默认按时间排序
        break;
    }
    
    // 分页
    final startIndex = (page - 1) * perPage;
    final endIndex = startIndex + perPage;
    final paginatedTopics = topics.sublist(
      startIndex.clamp(0, topics.length),
      endIndex.clamp(0, topics.length),
    );
    
    return ForumTopicListResponse(
      status: 200,
      message: 'success',
      data: paginatedTopics,
      total: topics.length,
      page: page,
      perPage: perPage,
      hasMore: endIndex < topics.length,
    );
  }

  /// 获取话题详情
  /// 
  /// [topicId] 话题ID
  /// @return 话题详情响应
  Future<ForumTopicDetailResponse> getTopicDetail(String topicId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    final topic = _mockTopics.firstWhere(
      (t) => t.id == topicId,
      orElse: () => throw Exception('Topic not found'),
    );
    
    return ForumTopicDetailResponse(
      status: 200,
      message: 'success',
      data: topic,
    );
  }

  // ==================== 回复相关 ====================

  /// 获取话题回复列表
  /// 
  /// [topicId] 话题ID
  /// [page] 页码
  /// [perPage] 每页数量
  /// @return 回复列表响应
  Future<ForumReplyListResponse> getTopicReplies({
    required String topicId,
    int page = 1,
    int perPage = 20,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));
    
    final replies = _mockReplies
      .where((r) => r.topicId == topicId)
      .toList();
    
    final startIndex = (page - 1) * perPage;
    final endIndex = startIndex + perPage;
    final paginatedReplies = replies.sublist(
      startIndex.clamp(0, replies.length),
      endIndex.clamp(0, replies.length),
    );
    
    return ForumReplyListResponse(
      status: 200,
      message: 'success',
      data: paginatedReplies,
      total: replies.length,
      page: page,
      hasMore: endIndex < replies.length,
    );
  }

  // ==================== 标签相关 ====================

  /// 获取标签列表
  /// 
  /// @return 标签列表响应
  Future<ForumTagListResponse> getTags() async {
    await Future.delayed(const Duration(milliseconds: 400));
    
    return ForumTagListResponse(
      status: 200,
      message: 'success',
      data: _mockTags,
    );
  }

  // ==================== 搜索相关 ====================

  /// 搜索话题
  /// 
  /// [query] 搜索关键词
  /// [page] 页码
  /// @return 话题列表响应
  Future<ForumTopicListResponse> searchTopics({
    required String query,
    int page = 1,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));
    
    final topics = _mockTopics.where((t) =>
      t.title.toLowerCase().contains(query.toLowerCase()) ||
      t.content.toLowerCase().contains(query.toLowerCase())
    ).toList();
    
    return ForumTopicListResponse(
      status: 200,
      message: 'success',
      data: topics,
      total: topics.length,
      page: page,
      hasMore: false,
    );
  }

  // ==================== 模拟数据 ====================
  
  /// 模拟分类数据
  static final List<ForumCategory> _mockCategories = [
    const ForumCategory(
      id: '1',
      name: '官方公告',
      slug: 'official',
      description: 'TRAE 官方公告和更新',
      color: '#E53935',
      icon: 'campaign',
      topicCount: 15,
      displayOrder: 1,
    ),
    const ForumCategory(
      id: '2',
      name: '帮助与支持',
      slug: 'help',
      description: '使用帮助和技术支持',
      color: '#1E88E5',
      icon: 'help_outline',
      topicCount: 128,
      displayOrder: 2,
    ),
    const ForumCategory(
      id: '3',
      name: '产品建议',
      slug: 'suggestions',
      description: '产品功能建议和反馈',
      color: '#43A047',
      icon: 'lightbulb_outline',
      topicCount: 256,
      displayOrder: 3,
    ),
    const ForumCategory(
      id: '4',
      name: '技巧分享',
      slug: 'tips',
      description: '使用技巧和最佳实践',
      color: '#FB8C00',
      icon: 'tips_and_updates',
      topicCount: 189,
      displayOrder: 4,
    ),
    const ForumCategory(
      id: '5',
      name: '案例与作品',
      slug: 'showcase',
      description: '用户作品和案例展示',
      color: '#8E24AA',
      icon: 'workspace_premium',
      topicCount: 342,
      displayOrder: 5,
    ),
    const ForumCategory(
      id: '6',
      name: '互动交流',
      slug: 'discussion',
      description: '开发者交流讨论',
      color: '#00ACC1',
      icon: 'forum',
      topicCount: 567,
      displayOrder: 6,
    ),
    const ForumCategory(
      id: '7',
      name: '福利活动',
      slug: 'events',
      description: '社区福利和活动',
      color: '#FDD835',
      icon: 'card_giftcard',
      topicCount: 23,
      displayOrder: 7,
    ),
    const ForumCategory(
      id: '8',
      name: 'SOLO挑战赛',
      slug: 'solo',
      description: 'SOLO 挑战赛专区',
      color: '#EC407A',
      icon: 'emoji_events',
      topicCount: 89,
      displayOrder: 8,
    ),
  ];

  /// 模拟标签数据
  static final List<ForumTag> _mockTags = [
    const ForumTag(id: '1', name: 'SOLO赛事速递', slug: 'solo-news', color: '#E91E63'),
    const ForumTag(id: '2', name: '新SOLO初体验', slug: 'solo-beginner', color: '#9C27B0'),
    const ForumTag(id: '3', name: '新人必看', slug: 'newbie', color: '#3F51B5'),
    const ForumTag(id: '4', name: 'Code-with-SOLO', slug: 'code-solo', color: '#2196F3'),
    const ForumTag(id: '5', name: 'Hello-AI-科技致善', slug: 'hello-ai', color: '#009688'),
    const ForumTag(id: '6', name: 'More-than-Codin', slug: 'more-coding', color: '#FF9800'),
    const ForumTag(id: '7', name: 'featured', slug: 'featured', color: '#FF5722'),
    const ForumTag(id: '8', name: 'Bug反馈', slug: 'bug', color: '#795548'),
  ];

  /// 模拟作者数据
  static final List<ForumAuthor> _mockAuthors = [
    const ForumAuthor(
      id: '1',
      username: 'trae_official',
      displayName: 'TRAE官方',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=trae',
      level: 99,
      isAdmin: true,
    ),
    const ForumAuthor(
      id: '2',
      username: 'developer_jack',
      displayName: '开发者Jack',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=jack',
      level: 15,
    ),
    const ForumAuthor(
      id: '3',
      username: 'ai_enthusiast',
      displayName: 'AI爱好者',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=ai',
      level: 8,
    ),
    const ForumAuthor(
      id: '4',
      username: 'flutter_master',
      displayName: 'Flutter大神',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=flutter',
      level: 25,
      isModerator: true,
    ),
    const ForumAuthor(
      id: '5',
      username: 'solo_winner',
      displayName: 'SOLO冠军',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=solo',
      level: 12,
    ),
  ];

  /// 模拟话题数据
  static final List<ForumTopic> _mockTopics = [
    ForumTopic(
      id: '1',
      title: '【新增公益赛道】SOLO 挑战赛「Hello AI 科技致善」公益赛道作品提交指南',
      content: '欢迎来到「AI 无限职场」SOLO 挑战赛！这里是全新公益赛道「Hello AI 科技致善」的作品提交指南。\n\nTRAE × 脉脉「AI 无限职场」SOLO 挑战赛报名已突破1.2万人。不少提交的作品已从职场效率延伸至视障辅助...',
      excerpt: '欢迎来到「AI 无限职场」SOLO 挑战赛！这里是全新公益赛道「Hello AI 科技致善」的作品提交指南...',
      author: _mockAuthors[0],
      category: _mockCategories[7],
      tags: [_mockTags[4], _mockTags[0], _mockTags[6]],
      voteCount: 188,
      replyCount: 86,
      viewCount: 3600,
      createdAt: '2026-04-23T10:00:00Z',
      isPinned: true,
      isFeatured: true,
      lastReplyAt: '2026-04-23T13:00:00Z',
    ),
    ForumTopic(
      id: '2',
      title: '社区公告｜欢迎来到 TRAE 官方中文社区！',
      content: 'Hey，新朋友！欢迎加入 TRAE 官方中文社区。这里是属于中国开发者与 AI Coding 爱好者的阵地，我们致力于与大家一起共建最具活力、温度与价值的AI编程社区。\n\n社区导航：如何高效玩转这里？',
      excerpt: 'Hey，新朋友！欢迎加入 TRAE 官方中文社区...',
      author: _mockAuthors[0],
      category: _mockCategories[0],
      tags: [_mockTags[2]],
      voteCount: 229,
      replyCount: 67,
      viewCount: 6700,
      createdAt: '2026-04-22T08:00:00Z',
      isPinned: true,
      isFeatured: true,
    ),
    ForumTopic(
      id: '3',
      title: '【Code With SOLO】用 AI 搭建体检报告 OCR 智能管理系统，50+ 指标自动解析',
      content: '分享一个使用 TRAE AI 辅助开发的体检报告 OCR 系统，可以自动识别和解析50多项健康指标...',
      excerpt: '分享一个使用 TRAE AI 辅助开发的体检报告 OCR 系统...',
      author: _mockAuthors[2],
      category: _mockCategories[7],
      tags: [_mockTags[3]],
      voteCount: 45,
      replyCount: 12,
      viewCount: 890,
      createdAt: '2026-04-23T09:30:00Z',
      isFeatured: true,
    ),
    ForumTopic(
      id: '4',
      title: '初具游形 大家今天在用trae做什么？',
      content: '好奇大家今天都在用 TRAE 做什么项目？来分享一下吧！',
      excerpt: '好奇大家今天都在用 TRAE 做什么项目？',
      author: _mockAuthors[3],
      category: _mockCategories[5],
      tags: [],
      voteCount: 23,
      replyCount: 45,
      viewCount: 567,
      createdAt: '2026-04-23T08:00:00Z',
    ),
    ForumTopic(
      id: '5',
      title: '【Code With SOLO】用TRAE SOLO完善 AI伴你衣食行医',
      content: '参加 SOLO 挑战赛的作品，用 TRAE 开发了一个AI助手，帮助解决日常生活中的衣食行医问题...',
      excerpt: '参加 SOLO 挑战赛的作品...',
      author: _mockAuthors[4],
      category: _mockCategories[7],
      tags: [_mockTags[3], _mockTags[4]],
      voteCount: 14,
      replyCount: 11,
      viewCount: 340,
      createdAt: '2026-04-23T07:00:00Z',
      isFeatured: true,
    ),
    ForumTopic(
      id: '6',
      title: 'trae中的claude code插件是不是下架了?',
      content: '发现 claude code 插件找不到了，是不是下架了？',
      excerpt: '发现 claude code 插件找不到了...',
      author: _mockAuthors[1],
      category: _mockCategories[1],
      tags: [_mockTags[7]],
      voteCount: 5,
      replyCount: 8,
      viewCount: 234,
      createdAt: '2026-04-23T06:00:00Z',
    ),
    ForumTopic(
      id: '7',
      title: '十分钟生成中期汇报ppt',
      content: '用 TRAE 十分钟就生成了一个完整的中期汇报 PPT，效率太高了！',
      excerpt: '用 TRAE 十分钟就生成了一个完整的中期汇报 PPT...',
      author: _mockAuthors[2],
      category: _mockCategories[7],
      tags: [_mockTags[5]],
      voteCount: 89,
      replyCount: 23,
      viewCount: 1200,
      createdAt: '2026-04-22T15:00:00Z',
      isFeatured: true,
    ),
  ];

  /// 模拟回复数据
  static final List<ForumReply> _mockReplies = [
    ForumReply(
      id: '1',
      topicId: '1',
      content: '欢迎参加 SOLO 挑战赛！',
      author: _mockAuthors[0],
      createdAt: '2026-04-23T10:30:00Z',
      voteCount: 5,
      isAccepted: false,
    ),
  ];
}