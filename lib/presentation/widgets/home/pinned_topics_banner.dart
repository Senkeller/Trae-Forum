import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../data/models/pinned_topic.dart';
import '../../providers/pinned_topics_provider.dart';

/// 置顶话题Banner组件
///
/// 展示TRAE论坛社区置顶贴，横向滚动卡片形式
class PinnedTopicsBanner extends ConsumerStatefulWidget {
  const PinnedTopicsBanner({super.key});

  @override
  ConsumerState<PinnedTopicsBanner> createState() => _PinnedTopicsBannerState();
}

class _PinnedTopicsBannerState extends ConsumerState<PinnedTopicsBanner> {
  final PageController _pageController = PageController(viewportFraction: 0.92);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    // 页面加载时获取置顶话题
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pinnedTopicsNotifierProvider.notifier).loadPinnedTopics();
    });
    _pageController.addListener(_onPageChanged);
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

  @override
  Widget build(BuildContext context) {
    final pinnedTopics = ref.watch(pinnedTopicsListProvider);
    final isLoading = ref.watch(isPinnedTopicsLoadingProvider);
    final errorMessage = ref.watch(pinnedTopicsErrorProvider);

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
          height: 100,
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
                        : Theme.of(context).colorScheme.outline.withOpacity(0.3),
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
        return _PinnedTopicCard(
          topic: topic,
          onTap: () => _onTopicTap(topic),
        );
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
          child: const Center(
            child: CircularProgressIndicator(),
          ),
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

/// 置顶话题卡片
class _PinnedTopicCard extends StatelessWidget {
  final PinnedTopic topic;
  final VoidCallback onTap;

  const _PinnedTopicCard({
    required this.topic,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: colorScheme.outline.withOpacity(0.1),
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 置顶标签和标题在同一行
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 置顶标识
                    Container(
                      margin: const EdgeInsets.only(right: 8, top: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '置顶',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                    // 话题标题
                    Expanded(
                      child: Text(
                        topic.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // 底部信息
                Row(
                  children: [
                    // 作者头像
                    CircleAvatar(
                      radius: 10,
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
                                fontSize: 10,
                                color: colorScheme.onPrimaryContainer,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 6),
                    // 作者名
                    Expanded(
                      child: Text(
                        topic.username,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // 浏览数
                    Icon(
                      Icons.visibility_outlined,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.views}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                    const SizedBox(width: 12),
                    // 回复数
                    Icon(
                      Icons.comment_outlined,
                      size: 14,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.replyCount}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
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

}
