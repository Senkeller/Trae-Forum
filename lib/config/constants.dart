/// 应用常量配置
class AppConstants {
  // 应用信息
  static const String appName = 'TRAE Forum';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.trae.forum';

  // API 配置
  static const String baseUrl = 'https://forum.trae.cn';
  static const String cdnUrl = 'https://trae-forum-cdn.trae.com.cn';
  static const String forumUrl = 'https://forum.trae.cn';

  // Discourse API 路径
  static const String discourseLatest = '/latest.json';
  static const String discourseCategories = '/categories.json';
  static const String discourseTopic = '/t/{id}.json';
  static const String discourseTopicPosts = '/t/{id}/posts.json';
  static const String discourseSearch = '/search.json';
  static const String discourseUser = '/u/{username}.json';

  // TRAE 论坛分类 ID 映射
  static const Map<String, int> forumCategoryIds = {
    'official': 4, // 官方公告
    'officialProductUpdates': 17, // 官方/产品更新
    'officialModelUpdates': 18, // 官方/模型更新
    'officialPolicyAnnouncements': 19, // 官方/政策公告
    'officialCommunityNews': 20, // 官方/社区动态
    'help': 7, // 帮助与支持
    'suggestions': 8, // 产品建议
    'tips': 9, // 技巧分享
    'showcase': 10, // 案例与作品
    'discussion': 11, // 互动交流
    'events': 29, // 福利活动
    'partners': 33, // 社区伙伴
    'solo': 35, // SOLO挑战赛专区
  };

  static const List<int> officialSubCategoryIds = [17, 18, 19, 20];

  // 分页配置
  static const int pageSize = 20;
  static const int maxPageSize = 50;

  // 缓存配置
  static const Duration cacheMaxAge = Duration(days: 7);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB

  // 超时配置
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // 图片配置
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxImageWidth = 1920;
  static const int maxImageHeight = 1920;
  static const List<String> supportedImageFormats = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'webp',
  ];

  // 主题配置
  static const String themeLight = 'light';
  static const String themeDark = 'dark';
  static const String themeSystem = 'system';

  // 字体大小配置
  static const double fontSizeSmall = 0.85;
  static const double fontSizeNormal = 1.0;
  static const double fontSizeLarge = 1.15;
  static const double fontSizeExtraLarge = 1.3;

  // 动画时长
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 2);

  // 防抖配置
  static const Duration debounceDuration = Duration(milliseconds: 500);
  static const Duration throttleDuration = Duration(milliseconds: 1000);
}

/// 存储键名
class StorageKeys {
  // 用户相关
  static const String userToken = 'user_token';
  static const String userId = 'user_id';
  static const String userInfo = 'user_info';
  static const String isLoggedIn = 'is_logged_in';

  // 设置相关
  static const String themeMode = 'theme_mode';
  static const String fontScale = 'font_scale';
  static const String imageQuality = 'image_quality';
  static const String autoPlayVideo = 'auto_play_video';
  static const String useExternalBrowser = 'use_external_browser';

  // 缓存相关
  static const String searchHistory = 'search_history';
  static const String browseHistory = 'browse_history';
  static const String localFavorites = 'local_favorites';
  static const String draftPosts = 'draft_posts';

  // 黑名单
  static const String blacklistedUsers = 'blacklisted_users';
  static const String blacklistedTopics = 'blacklisted_topics';

  // 首页配置
  static const String homeTabOrder = 'home_tab_order';
  static const String homeTabVisibility = 'home_tab_visibility';

  // 设备信息
  static const String deviceId = 'device_id';
  static const String installTime = 'install_time';
  static const String lastVersion = 'last_version';
}

/// 路由路径
class RoutePaths {
  // 主页面
  static const String main = '/';
  static const String home = '/home';

  // Feed 相关
  static const String feedDetail = '/feed/:id';
  static const String feedCreate = '/feed/create';
  static const String feedReply = '/feed/:id/reply';

  // 用户相关
  static const String userProfile = '/user/:uid';
  static const String userEdit = '/user/edit';
  static const String followList = '/user/:uid/follows';
  static const String fanList = '/user/:uid/fans';

  // 话题相关
  static const String topicList = '/topics';
  static const String topics = '/topics/category';
  static const String topicDetail = '/topic/:tag';
  static const String tagDetail = '/tag/:tag';
  static const String productDetail = '/product/:id';

  // 搜索
  static const String search = '/search';
  static const String searchResult = '/search/result';

  // 消息
  static const String message = '/messages';
  static const String messageDetail = '/messages/:type';
  static const String notifications = '/notifications';
  static const String notificationSettings = '/notifications/settings';

  // 设置
  static const String settings = '/settings';
  static const String themeSettings = '/settings/theme';
  static const String fontSettings = '/settings/font';
  static const String accountSecurity = '/settings/account-security';
  static const String blacklist = '/settings/blacklist';
  static const String about = '/settings/about';

  // 登录
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // 其他
  static const String webview = '/webview';
  static const String history = '/history';
  static const String favorites = '/favorites';
  static const String imagePreview = '/image-preview';

  // Trae Dashboard
  static const String traeDashboard = '/trae-dashboard';

  // 用户活动相关（本地收藏、浏览历史、我常去）
  static const String localFavorites = '/user/local-favorites';
  static const String browseHistory = '/user/browse-history';
  static const String frequentlyVisited = '/user/frequently-visited';

  // 用户活动相关（服务器数据）
  static const String myFavorites = '/user/my-favorites';
  static const String myLikes = '/user/my-likes';
  static const String myReplies = '/user/my-replies';
}

/// 图片质量
enum ImageQuality {
  low('低', 'low'),
  medium('中', 'medium'),
  high('高', 'high'),
  original('原图', 'original');

  final String label;
  final String value;

  const ImageQuality(this.label, this.value);
}

/// 评论排序方式
enum CommentSortType {
  time('时间', 'time'),
  hot('热度', 'hot');

  final String label;
  final String value;

  const CommentSortType(this.label, this.value);
}

/// 搜索类型
enum SearchType {
  all('全部', 'all'),
  feed('动态', 'feed'),
  user('用户', 'user'),
  topic('话题', 'topic'),
  app('应用', 'app'),
  product('数码', 'product');

  final String label;
  final String value;

  const SearchType(this.label, this.value);
}

/// 消息类型
enum MessageType {
  all('全部', 'all'),
  mention('@我的', 'mention'),
  reply('回复', 'reply'),
  like('赞', 'like'),
  follow('关注', 'follow'),
  system('系统', 'system');

  final String label;
  final String value;

  const MessageType(this.label, this.value);
}
