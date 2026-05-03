import 'package:flutter/material.dart';
import '../../../config/theme.dart';
import '../../../data/models/feed.dart';

export '../../../data/models/feed.dart' show TopComment;

/// 精选评论组件
///
/// 用于在动态卡片中展示高赞评论，包含：
/// - 高赞标签（绿色背景、白色文字）
/// - 评论者用户名（品牌主色）
/// - 评论内容摘要
/// - 点击事件处理
///
/// 使用示例：
/// ```dart
/// FeaturedComment(
///   comment: TopComment(
///     id: 'comment_001',
///     username: '小明',
///     content: '这张照片拍得真好看！',
///     likeCount: 12,
///   ),
///   onTap: () => navigateToCommentDetail(),
/// )
/// ```
class FeaturedComment extends StatelessWidget {
  /// 评论数据
  final TopComment? comment;

  /// 点击回调
  final VoidCallback? onTap;

  /// 内容最大行数
  final int maxLines;

  /// 构造函数
  ///
  /// [comment] 评论数据，为 null 时返回空组件
  /// [onTap] 点击回调
  /// [maxLines] 内容最大行数，默认 2
  const FeaturedComment({
    super.key,
    this.comment,
    this.onTap,
    this.maxLines = 2,
  });

  @override
  Widget build(BuildContext context) {
    // 空值安全处理：无评论时返回空组件
    if (comment == null) {
      return const SizedBox.shrink();
    }

    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 高赞标签
            _buildLikeBadge(),
            const SizedBox(width: 8),
            // 评论内容
            Expanded(
              child: _buildCommentContent(context),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建高赞标签
  ///
  /// 显示点赞数量，绿色背景、白色文字
  Widget _buildLikeBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: const BoxDecoration(
        color: AppTheme.successColor,
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      child: Text(
        '${comment!.likeCount}赞',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
      ),
    );
  }

  /// 构建评论内容
  ///
  /// 包含用户名（品牌主色）和内容摘要
  Widget _buildCommentContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          // 用户名
          TextSpan(
            text: comment!.username,
            style: TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
          // 分隔符
          TextSpan(
            text: '：',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          // 评论内容
          TextSpan(
            text: comment!.content,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

/// 精选评论列表组件
///
/// 用于展示多条精选评论
///
/// 使用示例：
/// ```dart
/// FeaturedCommentList(
///   comments: [
///     TopComment(id: '1', username: '用户A', content: '评论内容', likeCount: 10),
///     TopComment(id: '2', username: '用户B', content: '另一条评论', likeCount: 8),
///   ],
///   onCommentTap: (comment) => navigateToDetail(comment),
/// )
/// ```
class FeaturedCommentList extends StatelessWidget {
  /// 评论列表
  final List<TopComment> comments;

  /// 评论点击回调
  final Function(TopComment comment)? onCommentTap;

  /// 最大显示数量
  final int maxCount;

  /// 条目间距
  final double itemSpacing;

  /// 构造函数
  ///
  /// [comments] 评论列表（必填）
  /// [onCommentTap] 评论点击回调
  /// [maxCount] 最大显示数量，默认 5
  /// [itemSpacing] 条目间距，默认 8
  const FeaturedCommentList({
    super.key,
    required this.comments,
    this.onCommentTap,
    this.maxCount = 5,
    this.itemSpacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    // 空值安全处理
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }

    // 限制显示数量
    final displayComments = comments.take(maxCount).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < displayComments.length; i++) ...[
          FeaturedComment(
            comment: displayComments[i],
            onTap: onCommentTap != null
                ? () => onCommentTap!(displayComments[i])
                : null,
          ),
          if (i < displayComments.length - 1)
            SizedBox(height: itemSpacing),
        ],
      ],
    );
  }
}
