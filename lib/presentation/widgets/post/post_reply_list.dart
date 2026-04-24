import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/theme.dart';
import '../../../data/models/discourse/discourse_post.dart';
import '../../../presentation/providers/reply_provider.dart';
import '../../widgets/user/user_avatar.dart';

/// 帖子回复列表组件
///
/// 显示话题的所有回复，支持下拉刷新和上拉加载更多
class PostReplyList extends ConsumerStatefulWidget {
  /// 话题ID
  final int topicId;

  /// 回复列表
  final List<DiscoursePost> posts;

  /// 是否正在加载
  final bool isLoading;

  /// 是否有更多数据
  final bool hasMore;

  /// 下拉刷新回调
  final Future<void> Function()? onRefresh;

  /// 加载更多回调
  final Future<void> Function()? onLoadMore;

  /// 点击回复回调
  final Function(DiscoursePost post)? onReplyTap;

  /// 点击点赞回调
  final Function(DiscoursePost post)? onLikeTap;

  /// 构造函数
  const PostReplyList({
    super.key,
    required this.topicId,
    required this.posts,
    this.isLoading = false,
    this.hasMore = false,
    this.onRefresh,
    this.onLoadMore,
    this.onReplyTap,
    this.onLikeTap,
  });

  @override
  ConsumerState<PostReplyList> createState() => _PostReplyListState();
}

class _PostReplyListState extends ConsumerState<PostReplyList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 滚动监听，实现上拉加载更多
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      if (!widget.isLoading && widget.hasMore && widget.onLoadMore != null) {
        widget.onLoadMore!();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 监听刷新触发器
    ref.listen(replyListRefreshProvider, (_, __) {
      widget.onRefresh?.call();
    });

    if (widget.posts.isEmpty && !widget.isLoading) {
      return _buildEmptyState(context);
    }

    return RefreshIndicator(
      onRefresh: widget.onRefresh ?? () async {},
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.posts.length + (widget.hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= widget.posts.length) {
            return _buildLoadMoreIndicator(context);
          }

          final post = widget.posts[index];
          return PostReplyItem(
            post: post,
            onReplyTap: () => widget.onReplyTap?.call(post),
            onLikeTap: () => widget.onLikeTap?.call(post),
          );
        },
      ),
    );
  }

  /// 构建空状态
  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 64,
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无回复',
            style: textTheme.titleMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '成为第一个回复的人吧！',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建加载更多指示器
  Widget _buildLoadMoreIndicator(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
        ),
      ),
    );
  }
}

/// 帖子回复项组件
///
/// 显示单个回复的内容，包括用户信息、内容、操作按钮等
class PostReplyItem extends StatelessWidget {
  /// 帖子数据
  final DiscoursePost post;

  /// 点击回复回调
  final VoidCallback? onReplyTap;

  /// 点击点赞回调
  final VoidCallback? onLikeTap;

  /// 构造函数
  const PostReplyItem({
    super.key,
    required this.post,
    this.onReplyTap,
    this.onLikeTap,
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
            color: colorScheme.outline.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息行
          Row(
            children: [
              // 头像
              UserAvatar(
                avatarUrl: _getAvatarUrl(),
                size: 40,
              ),
              const SizedBox(width: 12),
              // 用户名和楼层信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post.username,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (post.admin == true) ...[
                          const SizedBox(width: 4),
                          _buildBadge(context, '官方', colorScheme.primary),
                        ],
                        if (post.moderator == true) ...[
                          const SizedBox(width: 4),
                          _buildBadge(context, '版主', Colors.orange),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          '#${post.postNumber}',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatTime(post.createdAt),
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 回复目标（楼中楼）
          if (post.replyToPostNumber != null)
            _buildReplyTarget(context),
          // 内容
          if (post.cooked != null)
            Html(
              data: post.cooked,
              style: {
                'body': Style(
                  margin: Margins.zero,
                  padding: HtmlPaddings.zero,
                  fontSize: FontSize(14),
                  color: colorScheme.onSurface,
                ),
                'p': Style(
                  margin: Margins.only(bottom: Margin(8)),
                ),
                'blockquote': Style(
                  margin: Margins.only(left: Margin(8), bottom: Margin(8)),
                  padding: HtmlPaddings.only(left: HtmlPadding(12)),
                  border: Border(
                    left: BorderSide(
                      color: colorScheme.outline.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                  color: colorScheme.onSurfaceVariant,
                ),
                'a': Style(
                  color: colorScheme.primary,
                  textDecoration: TextDecoration.none,
                ),
                'img': Style(
                  width: Width.auto(),
                  height: Height.auto(),
                  maxWidth: MaxWidth(100, Unit.percent),
                ),
                'pre': Style(
                  backgroundColor: colorScheme.surfaceVariant,
                  padding: HtmlPaddings.all(12),
                  borderRadius: BorderRadius.circular(8),
                ),
                'code': Style(
                  backgroundColor: colorScheme.surfaceVariant,
                  padding: HtmlPaddings.symmetric(horizontal: 4, vertical: 2),
                  borderRadius: BorderRadius.circular(4),
                  fontFamily: 'monospace',
                ),
              },
            ),
          const SizedBox(height: 12),
          // 操作按钮
          _buildActionBar(context),
        ],
      ),
    );
  }

  /// 构建徽章
  Widget _buildBadge(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 构建回复目标（楼中楼引用）
  Widget _buildReplyTarget(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            Icons.reply,
            size: 16,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '回复 #${post.replyToPostNumber}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  /// 构建操作栏
  Widget _buildActionBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // 点赞按钮
        _buildActionButton(
          context,
          icon: post.yours == true && post.likeCount > 0
              ? Icons.favorite
              : Icons.favorite_border,
          count: post.likeCount,
          isActive: post.yours == true && post.likeCount > 0,
          activeColor: AppTheme.likeColor,
          onTap: onLikeTap,
        ),
        const SizedBox(width: 24),
        // 回复按钮
        _buildActionButton(
          context,
          icon: Icons.chat_bubble_outline,
          label: '回复',
          onTap: onReplyTap,
        ),
        const Spacer(),
        // 更多操作
        GestureDetector(
          onTap: () => _showMoreOptions(context),
          child: Icon(
            Icons.more_vert,
            size: 20,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final iconColor = isActive
        ? (activeColor ?? colorScheme.primary)
        : colorScheme.onSurfaceVariant;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: iconColor,
          ),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: textTheme.bodySmall?.copyWith(
                color: iconColor,
              ),
            ),
          ],
          if (label != null && count == 0) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: iconColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// 显示更多选项
  void _showMoreOptions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.outline.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('复制内容'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: 实现复制功能
                },
              ),
              ListTile(
                leading: const Icon(Icons.report_outlined),
                title: const Text('举报'),
                onTap: () {
                  Navigator.of(context).pop();
                  // TODO: 实现举报功能
                },
              ),
              if (post.canEdit == true)
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('编辑'),
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: 实现编辑功能
                  },
                ),
              if (post.canDelete == true)
                ListTile(
                  leading: Icon(Icons.delete, color: colorScheme.error),
                  title: Text('删除', style: TextStyle(color: colorScheme.error)),
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: 实现删除功能
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  /// 获取头像URL
  String? _getAvatarUrl() {
    if (post.avatarTemplate.isEmpty) return null;
    return 'https://forum.trae.cn${post.avatarTemplate.replaceAll('{size}', '96')}';
  }

  /// 格式化时间
  String _formatTime(String isoTime) {
    final dateTime = DateTime.parse(isoTime);
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()}年前';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()}个月前';
    } else if (diff.inDays > 0) {
      return '${diff.inDays}天前';
    } else if (diff.inHours > 0) {
      return '${diff.inHours}小时前';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes}分钟前';
    } else {
      return '刚刚';
    }
  }
}

/// 回复列表骨架屏
///
/// 用于加载中状态的占位显示
class PostReplyListSkeleton extends StatelessWidget {
  /// 骨架项数量
  final int itemCount;

  /// 构造函数
  const PostReplyListSkeleton({
    super.key,
    this.itemCount = 5,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 头像占位
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 用户名占位
                    Container(
                      width: 80,
                      height: 14,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 内容占位
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // 操作栏占位
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            color: colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
