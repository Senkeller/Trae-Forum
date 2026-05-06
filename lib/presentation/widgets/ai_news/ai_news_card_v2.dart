import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../data/models/ai_news.dart';

/// AI快讯卡片组件 V2
///
/// 全新设计的卡片，提升视觉体验和交互
class AINewsCardV2 extends StatelessWidget {
  /// AI快讯数据
  final AINews news;

  /// 点击回调
  final VoidCallback? onTap;

  /// 收藏回调
  final VoidCallback? onBookmark;

  /// 分享回调
  final VoidCallback? onShare;

  /// 构造函数
  const AINewsCardV2({
    super.key,
    required this.news,
    this.onTap,
    this.onBookmark,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withAlpha(13),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: colorScheme.outline.withAlpha(26),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: colorScheme.primary.withAlpha(26),
            highlightColor: colorScheme.primary.withAlpha(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 顶部区域：分类标签 + 热门/置顶标识
                _buildHeader(context),

                // 内容区域
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题
                      _buildTitle(context),

                      const SizedBox(height: 12),

                      // 摘要内容
                      _buildSummary(context),

                      const SizedBox(height: 16),

                      // 底部信息栏
                      _buildFooter(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 构建头部区域
  Widget _buildHeader(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            news.categoryColor.withAlpha(26),
            colorScheme.surface,
          ],
        ),
      ),
      child: Row(
        children: [
          // 分类标签
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: news.categoryColor.withAlpha(51),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: news.categoryColor.withAlpha(102),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _getCategoryIcon(),
                  size: 12,
                  color: news.categoryColor,
                ),
                const SizedBox(width: 4),
                Text(
                  news.categoryDisplayName,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: news.categoryColor,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // 置顶标识
          if (news.isPinned)
            _buildBadge(
              context,
              icon: Icons.push_pin,
              label: '置顶',
              color: Colors.orange,
            ),

          // 热门标识
          if (news.isHot)
            _buildBadge(
              context,
              icon: Icons.local_fire_department,
              label: '热门',
              color: Colors.red,
            ),
        ],
      ),
    );
  }

  /// 构建徽章
  Widget _buildBadge(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withAlpha(26),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建标题
  Widget _buildTitle(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      news.title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.4,
        fontSize: 16,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 构建摘要
  Widget _buildSummary(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final summaryText = news.summary ?? news.content;

    return Text(
      summaryText,
      style: TextStyle(
        fontSize: 14,
        height: 1.6,
        color: colorScheme.onSurfaceVariant,
      ),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
    );
  }

  /// 构建底部信息栏
  Widget _buildFooter(BuildContext context) {
    return Row(
      children: [
        // 来源
        _buildInfoItem(
          context,
          icon: Icons.source_outlined,
          text: news.source,
        ),

        const SizedBox(width: 16),

        // 时间
        _buildInfoItem(
          context,
          icon: Icons.access_time_rounded,
          text: news.formattedTime,
        ),

        const Spacer(),

        // 浏览量
        if (news.viewCount > 0)
          _buildInfoItem(
            context,
            icon: Icons.visibility_outlined,
            text: news.formattedViewCount,
          ),

        const SizedBox(width: 12),

        // 操作按钮
        _buildActionButtons(context),
      ],
    );
  }

  /// 构建信息项
  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: colorScheme.onSurfaceVariant.withAlpha(179),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant.withAlpha(179),
          ),
        ),
      ],
    );
  }

  /// 构建操作按钮
  Widget _buildActionButtons(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 收藏按钮
        if (onBookmark != null)
          _buildIconButton(
            context,
            icon: news.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            color: news.isBookmarked ? colorScheme.primary : null,
            onTap: () {
              HapticFeedback.lightImpact();
              onBookmark?.call();
            },
          ),

        // 分享按钮
        if (onShare != null)
          _buildIconButton(
            context,
            icon: Icons.share_outlined,
            onTap: () {
              HapticFeedback.lightImpact();
              onShare?.call();
            },
          ),
      ],
    );
  }

  /// 构建图标按钮
  Widget _buildIconButton(
    BuildContext context, {
    required IconData icon,
    Color? color,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 18,
            color: color ?? colorScheme.onSurfaceVariant.withAlpha(179),
          ),
        ),
      ),
    );
  }

  /// 获取分类图标
  IconData _getCategoryIcon() {
    switch (news.category) {
      case AINewsCategory.llm:
        return Icons.psychology;
      case AINewsCategory.imageGeneration:
        return Icons.image;
      case AINewsCategory.videoGeneration:
        return Icons.videocam;
      case AINewsCategory.aiHardware:
        return Icons.memory;
      case AINewsCategory.aiApplication:
        return Icons.apps;
      case AINewsCategory.industryNews:
        return Icons.business;
      case AINewsCategory.other:
        return Icons.category;
    }
  }
}

/// AI快讯骨架屏卡片 V2
class AINewsSkeletonCardV2 extends StatelessWidget {
  const AINewsSkeletonCardV2({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final skeletonColor = colorScheme.surfaceContainerHighest;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头部骨架
          Row(
            children: [
              Container(
                width: 70,
                height: 24,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              const Spacer(),
              Container(
                width: 50,
                height: 20,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 标题骨架
          Container(
            width: double.infinity,
            height: 20,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 20,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(height: 12),

          // 内容骨架
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: double.infinity,
            height: 16,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            height: 16,
            decoration: BoxDecoration(
              color: skeletonColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),

          const SizedBox(height: 16),

          // 底部骨架
          Row(
            children: [
              Container(
                width: 80,
                height: 14,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 60,
                height: 14,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const Spacer(),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: skeletonColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
