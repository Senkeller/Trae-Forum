import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../user/user_avatar.dart';
import '../user/user_name.dart';
import '../common/cached_image.dart';

/// 评论数据模型
class CommentData {
  /// 评论 ID
  final String id;

  /// 用户头像 URL
  final String? avatarUrl;

  /// 用户 ID
  final String? userId;

  /// 用户名
  final String username;

  /// 用户等级
  final UserLevel userLevel;

  /// 评论内容
  final String content;

  /// 评论图片
  final List<String> images;

  /// 发布时间
  final DateTime publishTime;

  /// 点赞数
  final int likeCount;

  /// 是否已点赞
  final bool isLiked;

  /// 回复数
  final int replyCount;

  /// 回复列表（子评论）
  final List<CommentData>? replies;

  /// 被回复用户（用于子评论）
  final String? replyToUsername;

  /// 构造函数
  CommentData({
    required this.id,
    this.avatarUrl,
    this.userId,
    required this.username,
    this.userLevel = UserLevel.normal,
    required this.content,
    this.images = const [],
    required this.publishTime,
    this.likeCount = 0,
    this.isLiked = false,
    this.replyCount = 0,
    this.replies,
    this.replyToUsername,
  });
}

/// 评论卡片组件
///
/// 展示评论内容、作者信息、点赞数等
class CommentCard extends StatelessWidget {
  /// 评论数据
  final CommentData data;

  /// 点击回调
  final VoidCallback? onTap;

  /// 点赞回调
  final VoidCallback? onLike;

  /// 回复回调
  final VoidCallback? onReply;

  /// 更多操作回调
  final VoidCallback? onMore;

  /// 图片点击回调
  final Function(int index)? onImageTap;

  /// 是否显示回复列表
  final bool showReplies;

  /// 最大显示回复数
  final int maxReplies;

  /// 是否为子评论
  final bool isSubComment;

  /// 构造函数
  ///
  /// [data] 评论数据（必填）
  /// [onTap] 点击回调
  /// [onLike] 点赞回调
  /// [onReply] 回复回调
  /// [onMore] 更多操作回调
  /// [onImageTap] 图片点击回调
  /// [showReplies] 是否显示回复列表，默认 true
  /// [maxReplies] 最大显示回复数，默认 3
  /// [isSubComment] 是否为子评论，默认 false
  const CommentCard({
    super.key,
    required this.data,
    this.onTap,
    this.onLike,
    this.onReply,
    this.onMore,
    this.onImageTap,
    this.showReplies = true,
    this.maxReplies = 3,
    this.isSubComment = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          left: isSubComment ? 16 : 16,
          right: 16,
          top: 12,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withOpacity(0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像
            UserAvatar(
              avatarUrl: data.avatarUrl,
              userId: data.userId,
              size: isSubComment ? 32 : 40,
            ),
            const SizedBox(width: 12),
            // 内容区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 作者信息
                  _buildAuthorInfo(context),
                  const SizedBox(height: 4),
                  // 评论内容
                  _buildContent(context),
                  // 评论图片
                  if (data.images.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildImages(context),
                  ],
                  const SizedBox(height: 8),
                  // 时间和操作
                  _buildActions(context),
                  // 回复列表
                  if (showReplies &&
                      data.replies != null &&
                      data.replies!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _buildReplies(context),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建作者信息
  Widget _buildAuthorInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // 用户名
        UserName(
          username: data.username,
          userId: data.userId,
          level: data.userLevel,
          showLevel: true,
          style: textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        // 楼主标识
        if (!isSubComment) ...[
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '楼主',
              style: textTheme.labelSmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// 构建评论内容
  Widget _buildContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // 子评论需要显示回复对象
    if (isSubComment && data.replyToUsername != null) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '回复 ',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
            TextSpan(
              text: '@${data.replyToUsername}',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
            TextSpan(
              text: '：${data.content}',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onBackground,
              ),
            ),
          ],
        ),
      );
    }

    return Text(
      data.content,
      style: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onBackground,
        height: 1.5,
      ),
    );
  }

  /// 构建图片
  Widget _buildImages(BuildContext context) {
    final images = data.images.take(3).toList();

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (int i = 0; i < images.length; i++)
          GestureDetector(
            onTap: () => onImageTap?.call(i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedImage(
                imageUrl: images[i],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
      ],
    );
  }

  /// 构建操作栏
  Widget _buildActions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // 时间
        Text(
          _formatTime(data.publishTime),
          style: textTheme.bodySmall?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(width: 16),
        // 回复按钮
        GestureDetector(
          onTap: onReply,
          child: Text(
            '回复',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        const Spacer(),
        // 点赞按钮
        GestureDetector(
          onTap: onLike,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                data.isLiked ? Icons.favorite : Icons.favorite_border,
                size: 14,
                color: data.isLiked
                    ? AppTheme.likeColor
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 2),
              Text(
                data.likeCount > 0 ? data.likeCount.toString() : '点赞',
                style: textTheme.bodySmall?.copyWith(
                  color: data.isLiked
                      ? AppTheme.likeColor
                      : colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 构建回复列表
  Widget _buildReplies(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final replies = data.replies!.take(maxReplies).toList();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < replies.length; i++) ...[
            if (i > 0) const SizedBox(height: 8),
            _buildReplyItem(context, replies[i]),
          ],
          // 查看更多回复
          if (data.replyCount > maxReplies) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: onTap,
              child: Text(
                '查看全部 ${data.replyCount} 条回复 >',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 构建回复项
  Widget _buildReplyItem(BuildContext context, CommentData reply) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: reply.username,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (reply.replyToUsername != null) ...[
            TextSpan(
              text: ' 回复 ',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            TextSpan(
              text: reply.replyToUsername,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          TextSpan(
            text: '：${reply.content}',
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onBackground,
            ),
          ),
        ],
      ),
    );
  }

  /// 格式化时间
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}年前';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}个月前';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}

/// 简洁版评论卡片
///
/// 用于评论列表的简洁展示
class CommentCardSimple extends StatelessWidget {
  /// 评论数据
  final CommentData data;

  /// 点击回调
  final VoidCallback? onTap;

  /// 构造函数
  ///
  /// [data] 评论数据（必填）
  /// [onTap] 点击回调
  const CommentCardSimple({
    super.key,
    required this.data,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: colorScheme.outline.withOpacity(0.3),
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 头像
            UserAvatar(
              avatarUrl: data.avatarUrl,
              userId: data.userId,
              size: 36,
            ),
            const SizedBox(width: 12),
            // 内容
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 用户名
                  UserName(
                    username: data.username,
                    userId: data.userId,
                    level: data.userLevel,
                    showLevel: false,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 内容
                  Text(
                    data.content,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onBackground,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // 时间
                  Text(
                    _formatTime(data.publishTime),
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 格式化时间
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}天前';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}小时前';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}

/// 评论列表标题组件
///
/// 显示评论总数和排序选项
class CommentListHeader extends StatelessWidget {
  /// 评论总数
  final int totalCount;

  /// 当前排序方式
  final CommentSortType sortType;

  /// 排序变更回调
  final ValueChanged<CommentSortType>? onSortChanged;

  /// 构造函数
  ///
  /// [totalCount] 评论总数，默认 0
  /// [sortType] 当前排序方式，默认 hot
  /// [onSortChanged] 排序变更回调
  const CommentListHeader({
    super.key,
    this.totalCount = 0,
    this.sortType = CommentSortType.hot,
    this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          // 评论数
          Text(
            '评论 $totalCount',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: colorScheme.onBackground,
            ),
          ),
          const Spacer(),
          // 排序选项
          _buildSortButton(
            context,
            label: '最热',
            isActive: sortType == CommentSortType.hot,
            onTap: () => onSortChanged?.call(CommentSortType.hot),
          ),
          const SizedBox(width: 16),
          _buildSortButton(
            context,
            label: '最新',
            isActive: sortType == CommentSortType.latest,
            onTap: () => onSortChanged?.call(CommentSortType.latest),
          ),
        ],
      ),
    );
  }

  /// 构建排序按钮
  Widget _buildSortButton(
    BuildContext context, {
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: textTheme.bodyMedium?.copyWith(
          color: isActive ? colorScheme.primary : colorScheme.onSurfaceVariant,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    );
  }
}

/// 评论排序类型
enum CommentSortType {
  /// 最热
  hot,
  /// 最新
  latest,
}
