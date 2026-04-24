import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'like_button.dart';

/// 点赞按钮使用示例
///
/// 本文件展示了如何在不同场景下使用点赞按钮组件
class LikeButtonExamples extends StatelessWidget {
  const LikeButtonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('点赞按钮示例'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 示例1：基本用法
          _buildExampleCard(
            title: '基本用法',
            description: '使用 postId 和初始状态',
            child: const LikeButton(
              postId: 12345,
              initialLikeCount: 42,
              initialIsLiked: false,
            ),
          ),

          // 示例2：使用 actions_summary
          _buildExampleCard(
            title: '使用 actions_summary',
            description: '从 Discourse API 响应中解析点赞状态',
            child: LikeButton(
              postId: 12346,
              actionsSummary: const [
                {'id': 2, 'count': 18, 'acted': true}
              ],
            ),
          ),

          // 示例3：自定义大小
          _buildExampleCard(
            title: '自定义大小',
            description: '调整图标和文字大小',
            child: const LikeButton(
              postId: 12347,
              initialLikeCount: 128,
              initialIsLiked: true,
              iconSize: 28,
              fontSize: 16,
            ),
          ),

          // 示例4：不显示数字
          _buildExampleCard(
            title: '不显示数字',
            description: '仅显示图标',
            child: const LikeButton(
              postId: 12348,
              initialLikeCount: 999,
              showCount: false,
            ),
          ),

          // 示例5：简洁版
          _buildExampleCard(
            title: '简洁版',
            description: '用于紧凑空间',
            child: const LikeButtonSimple(
              postId: 12349,
              initialLikeCount: 56,
              initialIsLiked: false,
            ),
          ),

          // 示例6：带回调函数
          _buildExampleCard(
            title: '带回调函数',
            description: '监听点赞/取消点赞事件',
            child: LikeButton(
              postId: 12350,
              initialLikeCount: 0,
              onLike: () {
                debugPrint('用户点赞了帖子 12350');
              },
              onUnlike: () {
                debugPrint('用户取消点赞帖子 12350');
              },
              onError: (error) {
                debugPrint('点赞出错: $error');
              },
            ),
          ),

          // 示例7：在帖子卡片中使用
          _buildExampleCard(
            title: '在帖子卡片中使用',
            description: '完整的帖子卡片示例',
            child: _buildPostCardExample(),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required String description,
    required Widget child,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCardExample() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 用户头像和名称
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue[100],
                child: const Text('U'),
              ),
              const SizedBox(width: 8),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '用户名',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '2小时前',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // 帖子内容
          const Text(
            '这是一个示例帖子内容，展示了如何在帖子卡片中使用点赞按钮组件。',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 12),
          // 操作栏
          Row(
            children: [
              // 点赞按钮
              LikeButton(
                postId: 99999,
                initialLikeCount: 18,
                initialIsLiked: false,
              ),
              const SizedBox(width: 16),
              // 评论按钮
              Row(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 20,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '5',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // 分享按钮
              Icon(
                Icons.share,
                size: 20,
                color: Colors.grey[600],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// 在话题详情页中使用点赞按钮的示例
///
/// 假设你有一个 DiscoursePost 对象，可以这样使用：
/// ```dart
/// class PostWidget extends ConsumerWidget {
///   final DiscoursePost post;
///
///   const PostWidget({super.key, required this.post});
///
///   @override
///   Widget build(BuildContext context, WidgetRef ref) {
///     // 从 post 中提取点赞信息
///     final likeInfo = LikeRepository.extractLikeInfo(post.actionsSummary);
///
///     return Column(
///       children: [
///         // 帖子内容
///         HtmlWidget(post.cooked ?? ''),
///
///         // 点赞按钮
///         LikeButton(
///           postId: post.id,
///           actionsSummary: post.actionsSummary,
///           onError: (error) {
///             ScaffoldMessenger.of(context).showSnackBar(
///               SnackBar(content: Text(error)),
///             );
///           },
///         ),
///       ],
///     );
///   }
/// }
/// ```
class PostWidgetExample extends ConsumerWidget {
  final int postId;
  final String? cooked;
  final List<dynamic>? actionsSummary;
  final int? likeCount;

  const PostWidgetExample({
    super.key,
    required this.postId,
    this.cooked,
    this.actionsSummary,
    this.likeCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 帖子内容（这里简化显示）
            if (cooked != null)
              Text(
                cooked!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            const SizedBox(height: 16),
            // 操作栏
            Row(
              children: [
                // 点赞按钮 - 使用 actionsSummary 初始化
                LikeButton(
                  postId: postId,
                  actionsSummary: actionsSummary,
                  initialLikeCount: likeCount ?? 0,
                ),
                const Spacer(),
                // 其他操作按钮...
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
