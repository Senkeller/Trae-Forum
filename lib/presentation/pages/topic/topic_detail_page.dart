import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../../core/network/discourse_api_service.dart';
import '../../../core/utils/tag_util.dart';
import '../../providers/home_provider.dart';
import '../../widgets/home/pinned_topics_banner.dart';

/// 标签详情页
///
/// 展示特定标签下的所有话题
class TopicDetailPage extends ConsumerStatefulWidget {
  final String tag;
  final int? expectedTopicCount;

  const TopicDetailPage({
    super.key,
    required this.tag,
    this.expectedTopicCount,
  });

  @override
  ConsumerState<TopicDetailPage> createState() => _TopicDetailPageState();
}

class _TopicDetailPageState extends ConsumerState<TopicDetailPage> {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  List<FeedItem> _topics = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMessage;
  int _currentPage = 0;

  /// 标签汉化映射表
  final Map<String, String> _tagLocalizationMap = const {
    // SOLO 相关
    'code-with-solo': 'Code-with-SOLO',
    'solo': 'SOLO赛',
    'solo-news': 'SOLO赛事速递',
    'solo-beginner': '新SOLO初体验',

    // 活动相关
    'event': '活动',
    'events': '活动',
    'activity': '活动',
    'contest': '比赛',
    'challenge': '挑战',
    'hello-ai': 'Hello-AI-科技致善',
    'more-coding': 'More-than-Coding',

    // 内容类型
    'announcement': '公告',
    'official': '官方',
    'news': '新闻',
    'update': '更新',
    'release': '发布',

    // 主题分类
    'help': '求助',
    'question': '问题',
    'support': '支持',

    // 建议反馈
    'suggestion': '建议',
    'feedback': '反馈',
    'feature-request': '功能请求',
    'bug': 'Bug',

    // 技巧分享
    'tips': '技巧',
    'tutorial': '教程',
    'guide': '指南',
    'how-to': '教程',
    'best-practice': '最佳实践',

    // 作品展示
    'showcase': '作品',
    'project': '项目',
    'demo': '演示',
    'portfolio': '作品集',

    // 交流讨论
    'discussion': '讨论',
    'general': '综合',
    'chat': '闲聊',
    'intro': '介绍',
    'introduction': '介绍',
    'newbie': '新人必看',

    // 技术相关
    'tech': '技术',
    'code': '代码',
    'development': '开发',
    'ai': 'AI',
    'ml': '机器学习',

    // 其他
    'pinned': '置顶',
    'featured': '精选',
  };

  /// 获取标签的汉化显示文本
  String _getLocalizedTag(String tag) {
    final lowerTag = tag.toLowerCase().trim();
    final cleanTag = lowerTag.startsWith('#')
        ? lowerTag.substring(1)
        : lowerTag;
    return _tagLocalizationMap[cleanTag] ?? tag;
  }

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadTopics() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _currentPage = 0;
    });

    try {
      final discourseApi = ref.read(discourseApiServiceProvider);
      final response = await discourseApi.getTopicsByTag(widget.tag, page: 0);

      final (topics, hasMore) = _parseTopicsFromResponse(response);

      setState(() {
        _isLoading = false;
        _topics = topics;
        _currentPage = 0;
        _hasMore = hasMore;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '加载失败: $e';
      });
    }
  }

  Future<void> _onRefresh() async {
    await _loadTopics();
    _refreshController.refreshCompleted();
  }

  Future<void> _onLoading() async {
    if (_isLoadingMore || !_hasMore) {
      _refreshController.loadComplete();
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final discourseApi = ref.read(discourseApiServiceProvider);
      final response = await discourseApi.getTopicsByTag(
        widget.tag,
        page: nextPage,
      );

      final (newTopics, hasMore) = _parseTopicsFromResponse(response);

      setState(() {
        _isLoadingMore = false;
        _currentPage = nextPage;

        if (newTopics.isEmpty) {
          _hasMore = false;
        } else {
          final existingIds = _topics.map((e) => e.id).toSet();
          final dedupedNewTopics = newTopics
              .where((e) => !existingIds.contains(e.id))
              .toList();
          _topics = [..._topics, ...dedupedNewTopics];
          _hasMore = hasMore;
        }
      });
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
    }

    _refreshController.loadComplete();
  }

  /// 从响应中解析话题列表和分页信息
  ///
  /// 返回一个元组：(话题列表, 是否还有更多话题)
  (List<FeedItem>, bool) _parseTopicsFromResponse(dynamic response) {
    final raw = response.data;
    final data = raw is Map<String, dynamic>
        ? raw
        : Map<String, dynamic>.from(raw as Map);

    final topicListMap = data['topic_list'] as Map<String, dynamic>?;
    final topics = (topicListMap?['topics'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    final users = (data['users'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    // 检查是否还有更多话题
    // Discourse API 通过 more_topics_url 字段指示是否还有更多话题
    final moreTopicsUrl = topicListMap?['more_topics_url'] as String?;
    final hasMore = moreTopicsUrl != null && moreTopicsUrl.isNotEmpty;

    final userMap = <int, Map<String, dynamic>>{};
    for (final user in users) {
      final id = _parseInt(user['id']);
      if (id > 0) {
        userMap[id] = user;
      }
    }

    final feedItems = topics
        .map((topic) => _adaptTopicToFeedItem(topic, userMap))
        .toList();

    return (feedItems, hasMore);
  }

  FeedItem _adaptTopicToFeedItem(
    Map<String, dynamic> topic,
    Map<int, Map<String, dynamic>> userMap,
  ) {
    final posterList = (topic['posters'] as List<dynamic>? ?? const [])
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    final firstPosterUserId = posterList.isNotEmpty
        ? _parseInt(posterList.first['user_id'])
        : 0;
    final author = userMap[firstPosterUserId] ?? const <String, dynamic>{};

    final username = (author['username'] ?? topic['last_poster_username'] ?? '')
        .toString();
    final categoryId = _parseInt(topic['category_id']);
    final title = (topic['title'] ?? '').toString();
    final excerpt = _normalizeExcerpt(topic['excerpt']);
    final postsCount = _parseInt(topic['posts_count']);
    final replyCount = _parseInt(topic['reply_count']) > 0
        ? _parseInt(topic['reply_count'])
        : (postsCount > 0 ? postsCount - 1 : 0);

    final imageUrl = (topic['image_url'] ?? '').toString();

    return FeedItem(
      id: (topic['id'] ?? '').toString(),
      topicId: _parseInt(topic['id']),
      uid: firstPosterUserId > 0 ? firstPosterUserId.toString() : '',
      username: username.isNotEmpty ? username : 'unknown',
      avatarUrl: _formatAvatarUrl(
        (author['avatar_template'] ?? '').toString(),
        username,
      ),
      title: title,
      content: excerpt.isNotEmpty ? excerpt : title,
      category: 'Category $categoryId',
      categoryId: categoryId,
      createTime: _toUnixTimestamp(
        topic['last_posted_at'] ?? topic['created_at'],
      ),
      likeCount: _parseInt(topic['like_count']),
      replyCount: replyCount,
      viewCount: _parseInt(topic['views']),
      isLiked: false,
      images: imageUrl.isNotEmpty ? [imageUrl] : const [],
      type: 'topic',
      tags: TagUtil.parseTagList(topic['tags']),
      isPinned: topic['pinned'] == true,
    );
  }

  String _normalizeExcerpt(dynamic raw) {
    if (raw == null) return '';
    final text = raw.toString();
    final noTag = text
        .replaceAll(RegExp(r'<[^>]+>'), ' ')
        .replaceAll('&hellip;', '...')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"');
    return noTag.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  String _toUnixTimestamp(dynamic value) {
    if (value == null) return '';
    final source = value.toString();
    if (source.isEmpty) return '';

    final numeric = int.tryParse(source);
    if (numeric != null) {
      return numeric.toString();
    }

    final date = DateTime.tryParse(source);
    if (date == null) {
      return source;
    }
    return (date.toUtc().millisecondsSinceEpoch ~/ 1000).toString();
  }

  String _formatAvatarUrl(String avatarTemplate, String username) {
    if (avatarTemplate.isNotEmpty) {
      var url = avatarTemplate.replaceAll('{size}', '120');
      if (url.startsWith('//')) {
        return 'https:$url';
      }
      if (url.startsWith('/')) {
        return '${AppConstants.baseUrl}$url';
      }
      return url;
    }

    if (username.isEmpty) {
      return '';
    }

    return '${AppConstants.baseUrl}/user_avatar/forum.trae.cn/$username/120/0_2.png';
  }

  @override
  Widget build(BuildContext context) {
    final localizedTag = _getLocalizedTag(widget.tag);
    final expectedCount = widget.expectedTopicCount;
    final countSummary = expectedCount != null && expectedCount > 0
        ? '已加载 ${_topics.length} / 入口约 $expectedCount'
        : '已加载 ${_topics.length}';

    return Semantics(
      label: '话题详情页，标签 $localizedTag',
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('#$localizedTag'),
              Text(
                countSummary,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.open_in_browser),
              tooltip: '在论坛中查看',
              onPressed: () {
                // 构建论坛标签URL（使用原始标签值）
                final url = '${AppConstants.baseUrl}/tag/${widget.tag}';
                context.push(
                  '${RoutePaths.webview}?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent(localizedTag)}',
                );
              },
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _topics.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null && _topics.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadTopics,
      );
    }

    if (_topics.isEmpty) {
      final localizedTag = _getLocalizedTag(widget.tag);
      return _StateView(
        icon: Icons.tag,
        title: '暂无话题',
        message: '标签 #$localizedTag 下没有话题',
      );
    }

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: _hasMore,
      onRefresh: _onRefresh,
      onLoading: _hasMore ? _onLoading : null,
      header: const WaterDropMaterialHeader(
        backgroundColor: Colors.white,
        color: Colors.black87,
      ),
      footer: const ClassicFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        loadingText: '加载中...',
        noDataText: '没有更多了',
        idleText: '上拉加载更多',
      ),
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _topics.length + 2,
        cacheExtent: 200,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const PinnedTopicsBanner();
          }

          if (index == 1) {
            return _TopicCountHintCard(
              loadedCount: _topics.length,
              expectedCount: widget.expectedTopicCount,
            );
          }

          final topic = _topics[index - 2];
          return _TopicCard(
            topic: topic,
            onTap: () {
              context.push(RoutePaths.feedDetail.replaceFirst(':id', topic.id));
            },
          );
        },
      ),
    );
  }
}

class _TopicCountHintCard extends StatelessWidget {
  const _TopicCountHintCard({
    required this.loadedCount,
    required this.expectedCount,
  });

  final int loadedCount;
  final int? expectedCount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hintText = expectedCount != null && expectedCount! > 0
        ? '当前已加载 $loadedCount 条，入口显示约 $expectedCount 条。可下拉刷新或上拉继续加载。'
        : '当前已加载 $loadedCount 条，可下拉刷新或上拉继续加载。';

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.55),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              hintText,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  final FeedItem topic;
  final VoidCallback onTap;

  const _TopicCard({required this.topic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Semantics(
      label:
          '${topic.username}发布的话题：${topic.title}，${topic.likeCount}个赞，${topic.replyCount}条评论',
      hint: '双击查看详情',
      button: true,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: topic.avatarUrl.isNotEmpty
                          ? NetworkImage(topic.avatarUrl)
                          : null,
                      child: topic.avatarUrl.isEmpty
                          ? const Icon(Icons.person, size: 18)
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic.username,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            _formatTime(topic.createTime),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  topic.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (topic.content.isNotEmpty &&
                    topic.content != topic.title) ...[
                  const SizedBox(height: 8),
                  Text(
                    topic.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up_outlined,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.likeCount}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.comment_outlined,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.replyCount}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatTime(String timestamp) {
    if (timestamp.isEmpty) return '';

    try {
      final intTs = int.tryParse(timestamp);
      if (intTs == null) return timestamp;

      final dateTime = DateTime.fromMillisecondsSinceEpoch(intTs * 1000);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return '刚刚';
      }
      if (difference.inHours < 1) {
        return '${difference.inMinutes}分钟前';
      }
      if (difference.inDays < 1) {
        return '${difference.inHours}小时前';
      }
      if (difference.inDays < 7) {
        return '${difference.inDays}天前';
      }
      return '${dateTime.month}/${dateTime.day}';
    } catch (_) {
      return timestamp;
    }
  }
}

class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}
