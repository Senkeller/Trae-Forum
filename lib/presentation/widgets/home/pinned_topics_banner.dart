import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/network/discourse_api_service.dart';
import '../../../data/models/pinned_topic.dart';
import '../../providers/pinned_topics_provider.dart';

/// 置顶话题Banner组件
///
/// 展示TRAE论坛社区置顶贴，横向滚动卡片形式
class PinnedTopicsBanner extends ConsumerStatefulWidget {
  /// 可选分类ID。
  ///
  /// - `null`：使用全局置顶聚合逻辑
  /// - 非 `null`：只展示指定分类中的置顶话题
  final int? categoryId;

  const PinnedTopicsBanner({super.key, this.categoryId});

  @override
  ConsumerState<PinnedTopicsBanner> createState() => _PinnedTopicsBannerState();
}

class _PinnedTopicsBannerState extends ConsumerState<PinnedTopicsBanner> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;
  List<PinnedTopic> _categoryPinnedTopics = const [];
  bool _isCategoryLoading = false;
  String? _categoryErrorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
    _pageController.addListener(_onPageChanged);
  }

  @override
  void didUpdateWidget(covariant PinnedTopicsBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoryId != widget.categoryId) {
      _loadData();
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentPage) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  Future<void> _loadData() async {
    if (widget.categoryId == null) {
      ref.read(pinnedTopicsNotifierProvider.notifier).loadPinnedTopics();
      return;
    }
    await _loadCategoryPinnedTopics(widget.categoryId!);
  }

  Future<void> _loadCategoryPinnedTopics(int categoryId) async {
    if (_isCategoryLoading) return;

    setState(() {
      _isCategoryLoading = true;
      _categoryErrorMessage = null;
    });

    try {
      final discourseApiService = ref.read(discourseApiServiceProvider);
      final response = await discourseApiService.getTopicsByCategory(
        categoryId,
        page: 0,
      );
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
      final categories = (data['categories'] as List<dynamic>? ?? const [])
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      final userMap = <int, Map<String, dynamic>>{};
      for (final user in users) {
        final id = _parseInt(user['id']);
        if (id > 0) userMap[id] = user;
      }

      final categoryMap = <int, Map<String, dynamic>>{};
      for (final category in categories) {
        final id = _parseInt(category['id']);
        if (id > 0) categoryMap[id] = category;
      }

      final pinnedTopics = topics
          .where(_isTopicPinned)
          .take(10)
          .map(
            (topic) => PinnedTopic.fromTopicData(topic, userMap, categoryMap),
          )
          .toList();

      if (!mounted) return;
      setState(() {
        _categoryPinnedTopics = pinnedTopics;
        _isCategoryLoading = false;
        _categoryErrorMessage = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isCategoryLoading = false;
        _categoryErrorMessage = '加载失败';
      });
    }
  }

  bool _isTopicPinned(Map<String, dynamic> topic) {
    final pinned = topic['pinned'];
    final pinnedGlobally = topic['pinned_globally'];

    bool isPinned = false;
    if (pinned is bool) {
      isPinned = pinned;
    } else if (pinned is int) {
      isPinned = pinned > 0;
    } else if (pinned is String) {
      isPinned = pinned.toLowerCase() == 'true' || pinned == '1';
    }

    if (!isPinned) {
      if (pinnedGlobally is bool) {
        isPinned = pinnedGlobally;
      } else if (pinnedGlobally is int) {
        isPinned = pinnedGlobally > 0;
      } else if (pinnedGlobally is String) {
        isPinned =
            pinnedGlobally.toLowerCase() == 'true' || pinnedGlobally == '1';
      }
    }

    return isPinned;
  }

  @override
  Widget build(BuildContext context) {
    final pinnedTopics = widget.categoryId == null
        ? ref.watch(pinnedTopicsListProvider)
        : _categoryPinnedTopics;
    final isLoading = widget.categoryId == null
        ? ref.watch(isPinnedTopicsLoadingProvider)
        : _isCategoryLoading;
    final errorMessage = widget.categoryId == null
        ? ref.watch(pinnedTopicsErrorProvider)
        : _categoryErrorMessage;

    // 如果没有置顶话题且不加载中，不显示Banner
    if (pinnedTopics.isEmpty && !isLoading && errorMessage == null) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Banner内容
        SizedBox(
          height: 152,
          child: isLoading && pinnedTopics.isEmpty
              ? _buildLoadingPlaceholder()
              : errorMessage != null && pinnedTopics.isEmpty
              ? _buildErrorPlaceholder(errorMessage)
              : _buildTopicsCarousel(pinnedTopics),
        ),
        // 指示器
        if (pinnedTopics.length > 1)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pinnedTopics.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _currentPage == index ? 16 : 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: _currentPage == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(
                            context,
                          ).colorScheme.outline.withOpacity(0.3),
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  /// 构建话题轮播
  Widget _buildTopicsCarousel(List<PinnedTopic> topics) {
    return PageView.builder(
      controller: _pageController,
      itemCount: topics.length,
      padEnds: false,
      itemBuilder: (context, index) {
        final topic = topics[index];
        return _PinnedTopicCard(topic: topic, onTap: () => _onTopicTap(topic));
      },
    );
  }

  /// 构建加载占位
  Widget _buildLoadingPlaceholder() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          width: 320,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  /// 构建错误占位
  Widget _buildErrorPlaceholder(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            '加载失败',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ],
      ),
    );
  }

  /// 点击话题
  void _onTopicTap(PinnedTopic topic) {
    context.push('/feed/${topic.id}');
  }
}

int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}

/// 置顶话题卡片
class _PinnedTopicCard extends StatelessWidget {
  final PinnedTopic topic;
  final VoidCallback onTap;

  const _PinnedTopicCard({required this.topic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Material(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        shadowColor: colorScheme.shadow.withOpacity(0.1),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 300,
            height: 152,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primaryContainer.withOpacity(0.3),
                  colorScheme.surface,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 顶部：置顶标签 + 分类
                Row(
                  children: [
                    // 置顶标识
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.push_pin,
                            size: 12,
                            color: colorScheme.onPrimary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '置顶',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // 互动数据
                    _buildStatChip(
                      icon: Icons.visibility_outlined,
                      value: topic.views,
                      colorScheme: colorScheme,
                    ),
                    const SizedBox(width: 8),
                    _buildStatChip(
                      icon: Icons.comment_outlined,
                      value: topic.replyCount,
                      colorScheme: colorScheme,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // 话题标题
                Flexible(
                  child: Text(
                    topic.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                      color: colorScheme.onSurface,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 12),
                // 底部：作者信息
                Row(
                  children: [
                    // 作者头像
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 14,
                        backgroundColor: colorScheme.primaryContainer,
                        backgroundImage: topic.avatarUrl.isNotEmpty
                            ? NetworkImage(topic.avatarUrl)
                            : null,
                        onBackgroundImageError: (_, __) {},
                        child: topic.avatarUrl.isEmpty
                            ? Text(
                                topic.username.isNotEmpty
                                    ? topic.username[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // 作者名
                    Expanded(
                      child: Text(
                        topic.username,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 箭头指示
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: colorScheme.primary,
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

  Widget _buildStatChip({
    required IconData icon,
    required int value,
    required ColorScheme colorScheme,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 2),
          Text(
            _formatNumber(value),
            style: TextStyle(
              fontSize: 11,
              color: colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int num) {
    if (num >= 10000) {
      return '${(num / 10000).toStringAsFixed(1)}w';
    } else if (num >= 1000) {
      return '${(num / 1000).toStringAsFixed(1)}k';
    }
    return num.toString();
  }
}
