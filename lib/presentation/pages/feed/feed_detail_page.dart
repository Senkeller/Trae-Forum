import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/theme.dart';

/// 动态详情页
///
/// 展示单个动态的详细内容和评论列表
/// 包含：动态内容、图片、互动操作、评论列表
class FeedDetailPage extends ConsumerStatefulWidget {
  /// 动态 ID
  final String feedId;

  /// 构造函数
  const FeedDetailPage({
    super.key,
    required this.feedId,
  });

  @override
  ConsumerState<FeedDetailPage> createState() => _FeedDetailPageState();
}

/// 动态详情页状态
class _FeedDetailPageState extends ConsumerState<FeedDetailPage> {
  /// 评论输入控制器
  final TextEditingController _commentController = TextEditingController();

  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('动态详情'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // 内容区域
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                // 动态内容
                SliverToBoxAdapter(
                  child: _FeedContent(feedId: widget.feedId),
                ),
                // 评论标题
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Text(
                          '评论',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '12',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        _CommentSortButton(
                          onSortChanged: (sort) {
                            // TODO: 切换排序方式
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                // 评论列表
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _CommentItem(index: index),
                    childCount: 10,
                  ),
                ),
              ],
            ),
          ),
          // 底部评论输入栏
          _BottomCommentBar(
            controller: _commentController,
            onSend: () {
              // TODO: 发送评论
              _commentController.clear();
            },
          ),
        ],
      ),
    );
  }

  /// 显示更多选项菜单
  ///
  /// [context] 构建上下文
  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('分享'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: 分享
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('举报'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: 举报
              },
            ),
            ListTile(
              leading: const Icon(Icons.block),
              title: const Text('屏蔽'),
              onTap: () {
                Navigator.of(context).pop();
                // TODO: 屏蔽
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 动态内容组件
///
/// 展示动态的详细内容，包括用户信息、内容、图片、互动数据
class _FeedContent extends StatelessWidget {
  /// 动态 ID
  final String feedId;

  /// 构造函数
  const _FeedContent({required this.feedId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户信息
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: colorScheme.primaryContainer,
                child: Text(
                  'U',
                  style: TextStyle(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '用户名',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '2小时前 · 来自 iPhone',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              FilledButton.tonal(
                onPressed: () {},
                child: const Text('关注'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 内容
          Text(
            '这是动态 #$feedId 的详细内容。这里展示了完整的内容文本，可以包含多行文字。',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          // 图片网格
          _ImageGrid(imageCount: 3),
          const SizedBox(height: 16),
          // 话题标签
          Wrap(
            spacing: 8,
            children: [
              ActionChip(
                avatar: const Icon(Icons.tag, size: 16),
                label: const Text('Flutter'),
                onPressed: () {},
              ),
              ActionChip(
                avatar: const Icon(Icons.tag, size: 16),
                label: const Text('移动开发'),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 互动数据
          Row(
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                '1.2k 浏览',
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 操作栏
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActionButton(
                icon: Icons.thumb_up_outlined,
                activeIcon: Icons.thumb_up,
                label: '128',
                isActive: false,
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.comment_outlined,
                label: '12',
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.star_border,
                activeIcon: Icons.star,
                label: '收藏',
                isActive: false,
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.share_outlined,
                label: '分享',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 图片网格组件
///
/// 展示动态的图片列表
class _ImageGrid extends StatelessWidget {
  /// 图片数量
  final int imageCount;

  /// 构造函数
  const _ImageGrid({required this.imageCount});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: imageCount,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              Icons.image,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        );
      },
    );
  }
}

/// 操作按钮组件
///
/// 用于点赞、评论、收藏、分享等操作
class _ActionButton extends StatelessWidget {
  /// 未激活图标
  final IconData icon;

  /// 激活图标
  final IconData? activeIcon;

  /// 标签
  final String label;

  /// 是否激活
  final bool isActive;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _ActionButton({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.isActive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final activeColor = AppTheme.likeColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? (activeIcon ?? icon) : icon,
              size: 20,
              color: isActive ? activeColor : colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isActive ? activeColor : colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 评论排序按钮
///
/// 用于切换评论排序方式
class _CommentSortButton extends StatelessWidget {
  /// 排序变更回调
  final ValueChanged<String> onSortChanged;

  /// 构造函数
  const _CommentSortButton({required this.onSortChanged});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: 'time',
      onSelected: onSortChanged,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'time',
          child: Text('时间排序'),
        ),
        const PopupMenuItem(
          value: 'hot',
          child: Text('热度排序'),
        ),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '时间排序',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Icon(Icons.arrow_drop_down, size: 18),
        ],
      ),
    );
  }
}

/// 评论项组件
///
/// 单个评论的展示
class _CommentItem extends StatelessWidget {
  /// 索引
  final int index;

  /// 构造函数
  const _CommentItem({required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isReply = index % 3 == 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: colorScheme.primaryContainer,
            child: Text(
              'C$index',
              style: TextStyle(
                fontSize: 10,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '评论用户 $index',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isReply) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          '楼主',
                          style: TextStyle(
                            fontSize: 10,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                if (isReply && index > 0)
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '回复 @用户 ${index - 1}: 这是被回复的内容',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                Text(
                  '这是第 $index 条评论的内容，展示评论的样式和布局效果。',
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '${index + 1}小时前',
                      style: theme.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    _CommentActionButton(
                      icon: Icons.thumb_up_outlined,
                      label: '${index * 2 + 1}',
                      onTap: () {},
                    ),
                    _CommentActionButton(
                      icon: Icons.comment_outlined,
                      label: '回复',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 评论操作按钮
///
/// 评论项内的操作按钮（点赞、回复）
class _CommentActionButton extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标签
  final String label;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _CommentActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 2),
            Text(
              label,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

/// 底部评论输入栏
///
/// 固定在底部的评论输入区域
class _BottomCommentBar extends StatelessWidget {
  /// 输入控制器
  final TextEditingController controller;

  /// 发送回调
  final VoidCallback onSend;

  /// 构造函数
  const _BottomCommentBar({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withOpacity(0.2)),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: '写评论...',
                  hintStyle: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  filled: true,
                  fillColor: colorScheme.surfaceVariant,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onSend,
              icon: const Icon(Icons.send),
              color: colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
