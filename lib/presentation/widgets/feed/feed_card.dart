import 'package:flutter/material.dart';
import '../common/cached_image.dart';
import '../common/loading_widget.dart';
import '../user/user_name.dart';
import '../user/follow_button.dart';
import 'feed_author.dart';
import 'feed_content.dart';
import 'feed_actions.dart';

/// 动态卡片数据模型
class FeedCardData {
  /// 动态 ID
  final String id;

  /// 用户头像 URL
  final String? avatarUrl;

  /// 用户 ID
  final String? userId;

  /// 用户名
  final String username;

  /// 发布时间
  final DateTime? publishTime;

  /// 发布地点
  final String? location;

  /// 用户等级
  final UserLevel userLevel;

  /// 文字内容
  final String? text;

  /// 图片列表
  final List<String> images;

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

  /// 关注状态
  final bool isFollowing;

  /// 构造函数
  FeedCardData({
    required this.id,
    this.avatarUrl,
    this.userId,
    required this.username,
    this.publishTime,
    this.location,
    this.userLevel = UserLevel.normal,
    this.text,
    this.images = const [],
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.isLiked = false,
    this.isFavorited = false,
    this.isFollowing = false,
  });
}

/// 动态卡片组件
///
/// 组合作者信息、内容、操作栏的完整动态卡片
class FeedCard extends StatelessWidget {
  /// 动态数据
  final FeedCardData data;

  /// 点击卡片回调
  final VoidCallback? onTap;

  /// 点赞回调
  final VoidCallback? onLike;

  /// 评论回调
  final VoidCallback? onComment;

  /// 分享回调
  final VoidCallback? onShare;

  /// 收藏回调
  final VoidCallback? onFavorite;

  /// 关注回调
  final VoidCallback? onFollow;

  /// 更多操作回调
  final VoidCallback? onMore;

  /// 图片点击回调
  final Function(int index)? onImageTap;

  /// 是否显示关注按钮
  final bool showFollowButton;

  /// 是否显示收藏按钮
  final bool showFavoriteButton;

  /// 是否显示分享按钮
  final bool showShareButton;

  /// 卡片外边距
  final EdgeInsetsGeometry margin;

  /// 卡片内边距
  final EdgeInsetsGeometry padding;

  /// 构造函数
  ///
  /// [data] 动态数据（必填）
  /// [onTap] 点击卡片回调
  /// [onLike] 点赞回调
  /// [onComment] 评论回调
  /// [onShare] 分享回调
  /// [onFavorite] 收藏回调
  /// [onFollow] 关注回调
  /// [onMore] 更多操作回调
  /// [onImageTap] 图片点击回调
  /// [showFollowButton] 是否显示关注按钮，默认 true
  /// [showFavoriteButton] 是否显示收藏按钮，默认 true
  /// [showShareButton] 是否显示分享按钮，默认 true
  /// [margin] 卡片外边距，默认 EdgeInsets.symmetric(vertical: 4)
  /// [padding] 卡片内边距，默认 EdgeInsets.zero
  const FeedCard({
    super.key,
    required this.data,
    this.onTap,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onFavorite,
    this.onFollow,
    this.onMore,
    this.onImageTap,
    this.showFollowButton = true,
    this.showFavoriteButton = true,
    this.showShareButton = true,
    this.margin = const EdgeInsets.symmetric(vertical: 4),
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: margin,
      color: colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 作者信息
              FeedAuthor(
                avatarUrl: data.avatarUrl,
                userId: data.userId,
                username: data.username,
                publishTime: data.publishTime,
                location: data.location,
                userLevel: data.userLevel,
                showFollowButton: showFollowButton,
                followStatus: data.isFollowing
                    ? FollowStatus.following
                    : FollowStatus.notFollowing,
                onFollowTap: onFollow,
                onMoreTap: onMore,
              ),
              // 内容
              FeedContent(
                text: data.text,
                images: data.images,
                onImageTap: onImageTap,
              ),
              const SizedBox(height: 12),
              // 操作栏
              FeedActions(
                likeCount: data.likeCount,
                commentCount: data.commentCount,
                shareCount: data.shareCount,
                isLiked: data.isLiked,
                isFavorited: data.isFavorited,
                onLike: onLike,
                onComment: onComment,
                onShare: onShare,
                onFavorite: onFavorite,
                showFavorite: showFavoriteButton,
                showShare: showShareButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 简洁版动态卡片
///
/// 用于列表展示，信息更简洁
class FeedCardSimple extends StatelessWidget {
  /// 动态数据
  final FeedCardData data;

  /// 点击卡片回调
  final VoidCallback? onTap;

  /// 点赞回调
  final VoidCallback? onLike;

  /// 评论回调
  final VoidCallback? onComment;

  /// 构造函数
  ///
  /// [data] 动态数据（必填）
  /// [onTap] 点击卡片回调
  /// [onLike] 点赞回调
  /// [onComment] 评论回调
  const FeedCardSimple({
    super.key,
    required this.data,
    this.onTap,
    this.onLike,
    this.onComment,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: colorScheme.surface,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 作者信息（简洁版）
              FeedAuthorSimple(
                avatarUrl: data.avatarUrl,
                userId: data.userId,
                username: data.username,
                publishTime: data.publishTime,
              ),
              const SizedBox(height: 8),
              // 内容预览
              if (data.text != null && data.text!.isNotEmpty)
                Text(
                  data.text!,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onBackground,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              // 图片预览（最多3张）
              if (data.images.isNotEmpty) ...[
                const SizedBox(height: 8),
                _buildImagePreview(),
              ],
              const SizedBox(height: 8),
              // 操作栏（简洁版）
              FeedActionsSimple(
                likeCount: data.likeCount,
                commentCount: data.commentCount,
                isLiked: data.isLiked,
                onLike: onLike,
                onComment: onComment,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建图片预览
  Widget _buildImagePreview() {
    final previewImages = data.images.take(3).toList();

    return Row(
      children: [
        for (int i = 0; i < previewImages.length; i++) ...[
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedImage(
                  imageUrl: previewImages[i],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          if (i < previewImages.length - 1) const SizedBox(width: 4),
        ],
      ],
    );
  }
}

/// 动态卡片骨架屏
///
/// 用于加载状态的占位展示
class FeedCardSkeleton extends StatelessWidget {
  /// 构造函数
  const FeedCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const CardSkeletonWidget(
      cardCount: 1,
      showImage: true,
    );
  }
}
