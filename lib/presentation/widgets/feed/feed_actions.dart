import 'package:flutter/material.dart';
import '../../../config/theme.dart';

/// 动态操作按钮数据模型
class FeedActionData {
  /// 图标
  final IconData icon;

  /// 选中图标
  final IconData? selectedIcon;

  /// 数量
  final int count;

  /// 是否已选中
  final bool isSelected;

  /// 标签
  final String? label;

  /// 构造函数
  FeedActionData({
    required this.icon,
    this.selectedIcon,
    this.count = 0,
    this.isSelected = false,
    this.label,
  });
}

/// 动态操作栏组件
///
/// 展示点赞、评论、分享等操作按钮
class FeedActions extends StatelessWidget {
  /// 点赞数
  final int likeCount;

  /// 评论数
  final int commentCount;

  /// 分享数
  final int shareCount;

  /// 是否已点赞
  final bool isLiked;

  /// 是否已收藏
  final bool isFavorited;

  /// 点赞回调
  final VoidCallback? onLike;

  /// 评论回调
  final VoidCallback? onComment;

  /// 分享回调
  final VoidCallback? onShare;

  /// 收藏回调
  final VoidCallback? onFavorite;

  /// 更多操作回调
  final VoidCallback? onMore;

  /// 是否显示收藏按钮
  final bool showFavorite;

  /// 是否显示分享按钮
  final bool showShare;

  /// 构造函数
  ///
  /// [likeCount] 点赞数，默认 0
  /// [commentCount] 评论数，默认 0
  /// [shareCount] 分享数，默认 0
  /// [isLiked] 是否已点赞，默认 false
  /// [isFavorited] 是否已收藏，默认 false
  /// [onLike] 点赞回调
  /// [onComment] 评论回调
  /// [onShare] 分享回调
  /// [onFavorite] 收藏回调
  /// [onMore] 更多操作回调
  /// [showFavorite] 是否显示收藏按钮，默认 true
  /// [showShare] 是否显示分享按钮，默认 true
  const FeedActions({
    super.key,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.isLiked = false,
    this.isFavorited = false,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onFavorite,
    this.onMore,
    this.showFavorite = true,
    this.showShare = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // 点赞按钮
          Expanded(
            child: _buildActionButton(
              context,
              icon: isLiked ? Icons.favorite : Icons.favorite_border,
              count: likeCount,
              isActive: isLiked,
              activeColor: AppTheme.likeColor,
              onTap: onLike,
              semanticsLabel: isLiked ? '已点赞，$likeCount人点赞' : '点赞，$likeCount人点赞',
            ),
          ),
          // 评论按钮
          Expanded(
            child: _buildActionButton(
              context,
              icon: Icons.chat_bubble_outline,
              count: commentCount,
              onTap: onComment,
              semanticsLabel: '评论，$commentCount条评论',
            ),
          ),
          // 收藏按钮
          if (showFavorite)
            Expanded(
              child: _buildActionButton(
                context,
                icon: isFavorited ? Icons.star : Icons.star_border,
                label: isFavorited ? '已收藏' : '收藏',
                isActive: isFavorited,
                activeColor: AppTheme.favoriteColor,
                onTap: onFavorite,
                semanticsLabel: isFavorited ? '已收藏' : '收藏',
              ),
            ),
          // 分享按钮
          if (showShare)
            Expanded(
              child: _buildActionButton(
                context,
                icon: Icons.share,
                count: shareCount,
                onTap: onShare,
                semanticsLabel: '分享，$shareCount次分享',
              ),
            ),
          // 更多按钮
          if (onMore != null)
            _buildActionButton(
              context,
              icon: Icons.more_horiz,
              onTap: onMore,
              semanticsLabel: '更多操作',
            ),
        ],
      ),
    );
  }

  /// 构建操作按钮
  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    int count = 0,
    String? label,
    bool isActive = false,
    Color? activeColor,
    VoidCallback? onTap,
    String? semanticsLabel,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final iconColor = isActive
        ? (activeColor ?? colorScheme.primary)
        : colorScheme.onSurfaceVariant;

    final textColor = isActive
        ? (activeColor ?? colorScheme.primary)
        : colorScheme.onSurfaceVariant;

    final displayText = count > 0 ? _formatCount(count) : (label ?? '');
    final fullSemanticsLabel = semanticsLabel ?? displayText;

    return Semantics(
      label: fullSemanticsLabel,
      button: true,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: iconColor,
                ),
                if (count > 0 || (label != null && label.isNotEmpty)) ...[
                  const SizedBox(width: 4),
                  Text(
                    displayText,
                    style: textTheme.bodySmall?.copyWith(
                      color: textColor,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 格式化数量
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

/// 简洁版动态操作栏
///
/// 用于需要简洁展示操作按钮的场景
class FeedActionsSimple extends StatelessWidget {
  /// 点赞数
  final int likeCount;

  /// 评论数
  final int commentCount;

  /// 是否已点赞
  final bool isLiked;

  /// 点赞回调
  final VoidCallback? onLike;

  /// 评论回调
  final VoidCallback? onComment;

  /// 分享回调
  final VoidCallback? onShare;

  /// 构造函数
  ///
  /// [likeCount] 点赞数
  /// [commentCount] 评论数
  /// [isLiked] 是否已点赞
  /// [onLike] 点赞回调
  /// [onComment] 评论回调
  /// [onShare] 分享回调
  const FeedActionsSimple({
    super.key,
    this.likeCount = 0,
    this.commentCount = 0,
    this.isLiked = false,
    this.onLike,
    this.onComment,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 点赞
        GestureDetector(
          onTap: onLike,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: isLiked ? AppTheme.likeColor : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 2),
              Text(
                _formatCount(likeCount),
                style: textTheme.bodySmall?.copyWith(
                  color: isLiked ? AppTheme.likeColor : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // 评论
        GestureDetector(
          onTap: onComment,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.chat_bubble_outline,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 2),
              Text(
                _formatCount(commentCount),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        // 分享
        GestureDetector(
          onTap: onShare,
          child: Icon(
            Icons.share,
            size: 16,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// 格式化数量
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

/// 动态操作按钮（单个）
///
/// 用于自定义操作栏场景
class FeedActionButton extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 选中图标
  final IconData? activeIcon;

  /// 数量
  final int count;

  /// 标签
  final String? label;

  /// 是否已选中
  final bool isActive;

  /// 激活颜色
  final Color? activeColor;

  /// 点击回调
  final VoidCallback? onTap;

  /// 图标大小
  final double iconSize;

  /// 构造函数
  ///
  /// [icon] 图标（必填）
  /// [activeIcon] 选中图标
  /// [count] 数量
  /// [label] 标签
  /// [isActive] 是否已选中
  /// [activeColor] 激活颜色
  /// [onTap] 点击回调
  /// [iconSize] 图标大小，默认 20
  const FeedActionButton({
    super.key,
    required this.icon,
    this.activeIcon,
    this.count = 0,
    this.label,
    this.isActive = false,
    this.activeColor,
    this.onTap,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final displayIcon = isActive && activeIcon != null ? activeIcon! : icon;
    final iconColor = isActive
        ? (activeColor ?? colorScheme.primary)
        : colorScheme.onSurfaceVariant;
    final textColor = isActive
        ? (activeColor ?? colorScheme.primary)
        : colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                displayIcon,
                size: iconSize,
                color: iconColor,
              ),
              if (count > 0 || (label != null && label!.isNotEmpty)) ...[
                const SizedBox(width: 4),
                Text(
                  count > 0 ? _formatCount(count) : label!,
                  style: textTheme.bodySmall?.copyWith(
                    color: textColor,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 格式化数量
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
