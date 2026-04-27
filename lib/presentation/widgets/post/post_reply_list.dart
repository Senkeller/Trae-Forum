import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/theme.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../../data/models/discourse/discourse_post.dart';
import '../../../presentation/providers/reply_provider.dart';
import '../../widgets/common/cached_image.dart';
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

  /// 滚动加载守卫，用于管理回复列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

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

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多回复。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _onScroll() {
    if (!widget.hasMore || widget.onLoadMore == null) return;

    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        if (!widget.isLoading) {
          widget.onLoadMore!();
        }
      },
    );
  }

  /// 构建帖子回复列表
  ///
  /// [context] 构建上下文
  /// @return 回复列表 Widget
  @override
  Widget build(BuildContext context) {
    // 监听刷新触发器
    ref.listen(replyListRefreshProvider, (_, _) {
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
        cacheExtent: MediaQuery.of(context).size.height * 0.5,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        addSemanticIndexes: false,
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
/// 支持内容折叠展开功能，当内容超过6行时显示"展开"按钮
class PostReplyItem extends StatefulWidget {
  /// 帖子数据
  final DiscoursePost post;

  /// 点击回复回调
  final VoidCallback? onReplyTap;

  /// 点击点赞回调
  final VoidCallback? onLikeTap;

  /// 最大显示行数（折叠状态）
  final int maxLines;

  /// 构造函数
  const PostReplyItem({
    super.key,
    required this.post,
    this.onReplyTap,
    this.onLikeTap,
    this.maxLines = 6,
  });

  @override
  State<PostReplyItem> createState() => _PostReplyItemState();
}

class _PostReplyItemState extends State<PostReplyItem> {
  /// 是否已展开
  bool _isExpanded = false;

  /// 切换展开/收起状态
  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
          _buildUserInfo(context),
          const SizedBox(height: 12),
          // 回复目标（楼中楼）
          if (widget.post.replyToPostNumber != null) _buildReplyTarget(context),
          // 内容（带折叠展开功能）
          if (widget.post.cooked != null) _buildContent(context),
          const SizedBox(height: 12),
          // 操作按钮
          _buildActionBar(context),
        ],
      ),
    );
  }

  /// 构建用户信息行
  ///
  /// [context] 构建上下文
  /// @return 用户信息行 Widget
  Widget _buildUserInfo(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        // 头像
        UserAvatar(avatarUrl: _getAvatarUrl(), size: 40),
        const SizedBox(width: 12),
        // 用户名和楼层信息
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    widget.post.username,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (widget.post.admin == true) ...[
                    const SizedBox(width: 4),
                    _buildBadge(context, '官方', colorScheme.primary),
                  ],
                  if (widget.post.moderator == true) ...[
                    const SizedBox(width: 4),
                    _buildBadge(context, '版主', Colors.orange),
                  ],
                ],
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    '#${widget.post.postNumber}',
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(widget.post.createdAt),
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
    );
  }

  /// 构建内容区域（带折叠展开功能）
  ///
  /// [context] 构建上下文
  /// @return 内容区域 Widget
  Widget _buildContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final colorScheme = Theme.of(context).colorScheme;
        final needsCollapse = _shouldCollapse(context, constraints.maxWidth);
        return _buildContentWithFold(context, colorScheme, needsCollapse);
      },
    );
  }

  /// 基于内容文本测量是否超过折叠阈值
  bool _shouldCollapse(BuildContext context, double maxWidth) {
    final cooked = widget.post.cooked;
    if (cooked == null || cooked.trim().isEmpty) {
      return false;
    }

    // 富文本块元素通常占据较大空间，优先触发折叠
    final hasHeavyBlocks = RegExp(
      r'<\s*(img|pre|blockquote|table|ul|ol|li|h[1-6]|iframe|video)\b',
      caseSensitive: false,
    ).hasMatch(cooked);
    if (hasHeavyBlocks) {
      return true;
    }

    final plainText = _extractPlainText(cooked);
    if (plainText.isEmpty) {
      return false;
    }

    // 长文本和多换行先走快速判定，避免仅靠绘制测量漏判
    const collapseTextLengthThreshold = 220;
    if (plainText.runes.length > collapseTextLengthThreshold) {
      return true;
    }
    final lineCount = '\n'.allMatches(plainText).length + 1;
    if (lineCount > widget.maxLines) {
      return true;
    }

    final effectiveMaxWidth = maxWidth.isFinite && maxWidth > 0
        ? maxWidth
        : MediaQuery.of(context).size.width - 32;
    final textTheme = Theme.of(context).textTheme;
    final textPainter = TextPainter(
      text: TextSpan(
        text: plainText,
        style: textTheme.bodyMedium?.copyWith(fontSize: 14, height: 1.5),
      ),
      maxLines: widget.maxLines,
      textDirection: Directionality.of(context),
    )..layout(maxWidth: effectiveMaxWidth);

    return textPainter.didExceedMaxLines;
  }

  /// 将 HTML 内容转换为纯文本用于估算行数
  String _extractPlainText(String html) {
    return html
        .replaceAll(
          RegExp(r'</(p|div|li|blockquote|h[1-6])>', caseSensitive: false),
          '\n',
        )
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .replaceAll(RegExp(r'[ \t\r\f\v]+'), ' ')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }

  /// 构建带折叠功能的内容
  Widget _buildContentWithFold(
    BuildContext context,
    ColorScheme colorScheme,
    bool needsCollapse,
  ) {
    // 构建 HTML 内容
    Widget htmlContent = Html(
      data: widget.post.cooked,
      style: {
        'body': Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(14),
          color: colorScheme.onSurface,
          lineHeight: LineHeight(1.5),
        ),
        'p': Style(
          margin: Margins.only(bottom: 8),
          lineHeight: LineHeight(1.5),
        ),
        'blockquote': Style(
          margin: Margins.only(left: 8, bottom: 8),
          padding: HtmlPaddings.only(left: 12),
          border: Border(
            left: BorderSide(
              color: colorScheme.outline.withOpacity(0.5),
              width: 3,
            ),
          ),
          color: colorScheme.onSurfaceVariant,
          lineHeight: LineHeight(1.5),
        ),
        'a': Style(
          color: colorScheme.primary,
          textDecoration: TextDecoration.none,
        ),
        'img': Style(width: Width.auto(), height: Height.auto()),
        'pre': Style(
          backgroundColor: colorScheme.surfaceVariant,
          padding: HtmlPaddings.all(12),
          margin: Margins.only(bottom: 8),
        ),
        'code': Style(
          backgroundColor: colorScheme.surfaceVariant,
          padding: HtmlPaddings.symmetric(horizontal: 4, vertical: 2),
          fontFamily: 'monospace',
        ),
        'h1': Style(
          fontSize: FontSize(18),
          fontWeight: FontWeight.bold,
          margin: Margins.only(bottom: 8),
        ),
        'h2': Style(
          fontSize: FontSize(16),
          fontWeight: FontWeight.bold,
          margin: Margins.only(bottom: 8),
        ),
        'h3': Style(
          fontSize: FontSize(15),
          fontWeight: FontWeight.bold,
          margin: Margins.only(bottom: 8),
        ),
        'ul': Style(margin: Margins.only(left: 16, bottom: 8)),
        'ol': Style(margin: Margins.only(left: 16, bottom: 8)),
        'li': Style(margin: Margins.only(bottom: 4)),
      },
      extensions: [
        // 自定义图片渲染，限制表情包尺寸
        ImageExtension(
          builder: (extensionContext) {
            final imageUrl = DiscourseImageUrlResolver.resolveFromAttributes(
              extensionContext.attributes,
            );
            if (imageUrl == null) return const SizedBox.shrink();

            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 120,
                  maxHeight: 120,
                ),
                child: CachedImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                  memCacheWidth: 240,
                  memCacheHeight: 240,
                ),
              ),
            );
          },
        ),
      ],
    );

    // 如果需要折叠且未展开，限制高度
    if (needsCollapse && !_isExpanded) {
      htmlContent = ClipRect(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: _calculateFoldedHeight(context),
          ),
          child: Stack(
            children: [
              htmlContent,
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  child: Container(
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colorScheme.surface.withOpacity(0),
                          colorScheme.surface,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 内容区域
        htmlContent,
        // 展开/收起按钮
        if (needsCollapse) ...[
          const SizedBox(height: 8),
          GestureDetector(
            onTap: _toggleExpanded,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? '收起' : '查看更多',
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// 计算折叠状态下的最大高度
  ///
  /// [context] 构建上下文
  /// @return 最大高度值
  double _calculateFoldedHeight(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fontSize = textTheme.bodyMedium?.fontSize ?? 14;
    const lineHeight = 1.5;
    final estimatedLineHeight = fontSize * lineHeight;

    // 6行文本高度 + 段落间距(每段8px，最多5段) + 边距
    return estimatedLineHeight * widget.maxLines + 40 + 16;
  }

  /// 构建徽章
  ///
  /// [context] 构建上下文
  /// [text] 徽章显示的文本
  /// [color] 徽章颜色
  /// @return 徽章 Widget
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
  ///
  /// [context] 构建上下文
  /// @return 回复目标引用 Widget
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
          Icon(Icons.reply, size: 16, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '回复 #${widget.post.replyToPostNumber}',
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
  ///
  /// [context] 构建上下文
  /// @return 操作栏 Widget
  Widget _buildActionBar(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        // 点赞按钮
        _buildActionButton(
          context,
          icon: widget.post.yours == true && widget.post.likeCount > 0
              ? Icons.favorite
              : Icons.favorite_border,
          count: widget.post.likeCount,
          isActive: widget.post.yours == true && widget.post.likeCount > 0,
          activeColor: AppTheme.likeColor,
          onTap: widget.onLikeTap,
        ),
        const SizedBox(width: 24),
        // 回复按钮
        _buildActionButton(
          context,
          icon: Icons.chat_bubble_outline,
          label: '回复',
          onTap: widget.onReplyTap,
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
  ///
  /// [context] 构建上下文
  /// [icon] 按钮图标
  /// [count] 计数显示，默认为 0
  /// [label] 标签文本，可选
  /// [isActive] 是否处于激活状态，默认为 false
  /// [activeColor] 激活状态颜色，可选
  /// [onTap] 点击回调，可选
  /// @return 操作按钮 Widget
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
          Icon(icon, size: 18, color: iconColor),
          if (count > 0) ...[
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: textTheme.bodySmall?.copyWith(color: iconColor),
            ),
          ],
          if (label != null && count == 0) ...[
            const SizedBox(width: 4),
            Text(label, style: textTheme.bodySmall?.copyWith(color: iconColor)),
          ],
        ],
      ),
    );
  }

  /// 显示更多选项
  ///
  /// [context] 构建上下文
  /// 显示底部弹出菜单，提供复制、举报、编辑、删除等操作选项
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
              if (widget.post.canEdit == true)
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('编辑'),
                  onTap: () {
                    Navigator.of(context).pop();
                    // TODO: 实现编辑功能
                  },
                ),
              if (widget.post.canDelete == true)
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

  /// 获取头像 URL
  ///
  /// 根据帖子数据生成完整的头像 URL
  /// @return 头像 URL 字符串，如果模板为空则返回 null
  String? _getAvatarUrl() {
    if (widget.post.avatarTemplate.isEmpty) return null;
    return 'https://forum.trae.cn${widget.post.avatarTemplate.replaceAll('{size}', '96')}';
  }

  /// 格式化时间
  ///
  /// [isoTime] ISO 8601 格式的时间字符串
  /// @return 格式化后的相对时间文本（如：刚刚、5分钟前、2小时前等）
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
  const PostReplyListSkeleton({super.key, this.itemCount = 5});

  /// 构建骨架屏
  ///
  /// [context] 构建上下文
  /// @return 骨架屏 Widget
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
