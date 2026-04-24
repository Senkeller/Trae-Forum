import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/discourse_api_service.dart';
import '../../../data/models/discourse/discourse_post.dart';
import '../../../presentation/providers/reply_provider.dart';
import '../../../presentation/widgets/post/post_reply_input.dart';
import '../../../presentation/widgets/post/post_reply_list.dart';

/// 帖子详情页面示例
///
/// 展示如何使用回复功能组件
/// 实际使用时需要根据项目结构调整
class TopicDetailPageExample extends ConsumerStatefulWidget {
  /// 话题ID
  final int topicId;

  /// 构造函数
  const TopicDetailPageExample({
    super.key,
    required this.topicId,
  });

  @override
  ConsumerState<TopicDetailPageExample> createState() =>
      _TopicDetailPageExampleState();
}

class _TopicDetailPageExampleState
    extends ConsumerState<TopicDetailPageExample> {
  /// 帖子列表
  List<DiscoursePost> _posts = [];

  /// 是否正在加载
  bool _isLoading = false;

  /// 是否有更多数据
  bool _hasMore = false;

  /// 当前页码
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  /// 加载帖子列表
  Future<void> _loadPosts() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = ref.read(discourseApiServiceProvider);
      final response = await apiService.getTopicPosts(
        widget.topicId,
        page: _currentPage,
      );

      final data = response.data as Map<String, dynamic>?;
      final postStream = data?['post_stream'] as Map<String, dynamic>?;
      final postsData = postStream?['posts'] as List<dynamic>?;

      if (postsData != null) {
        final newPosts = postsData
            .map((json) => DiscoursePost.fromJson(json as Map<String, dynamic>))
            .toList();

        setState(() {
          if (_currentPage == 0) {
            _posts = newPosts;
          } else {
            _posts.addAll(newPosts);
          }
          _hasMore = newPosts.length >= 20;
        });
      }
    } catch (e) {
      // 处理错误
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('加载失败: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  /// 刷新帖子列表
  Future<void> _refreshPosts() async {
    _currentPage = 0;
    await _loadPosts();
  }

  /// 加载更多帖子
  Future<void> _loadMorePosts() async {
    if (_hasMore && !_isLoading) {
      _currentPage++;
      await _loadPosts();
    }
  }

  /// 处理回复点击
  void _handleReplyTap(DiscoursePost post) {
    // 设置回复目标
    ref.read(currentReplyTargetProvider.notifier).setTarget(
          postNumber: post.postNumber,
          username: post.username,
          content: post.cooked,
        );

    // 显示回复输入弹窗
    ReplyInputDialog.show(
      context: context,
      topicId: widget.topicId,
      onSendSuccess: () {
        // 发送成功后刷新列表
        _refreshPosts();
      },
    );
  }

  /// 处理点赞点击
  Future<void> _handleLikeTap(DiscoursePost post) async {
    // TODO: 实现点赞功能
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final replyState = ref.watch(replyNotifierProvider);

    // 监听回复状态变化
    ref.listen(replyNotifierProvider, (previous, current) {
      if (current.error != null && current.error != previous?.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(current.error!)),
        );
      }
      if (current.success && current.success != previous?.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('发送成功')),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('话题详情'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // TODO: 显示更多选项
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // 帖子内容区域
          Expanded(
            child: _isLoading && _posts.isEmpty
                ? const PostReplyListSkeleton()
                : PostReplyList(
                    topicId: widget.topicId,
                    posts: _posts,
                    isLoading: _isLoading,
                    hasMore: _hasMore,
                    onRefresh: _refreshPosts,
                    onLoadMore: _loadMorePosts,
                    onReplyTap: _handleReplyTap,
                    onLikeTap: _handleLikeTap,
                  ),
          ),
          // 底部回复栏
          PostReplyBottomBar(
            currentUserAvatar: null, // TODO: 获取当前用户头像
            hintText: '说点什么...',
            onInputTap: () {
              ReplyInputDialog.show(
                context: context,
                topicId: widget.topicId,
                onSendSuccess: () {
                  _refreshPosts();
                },
              );
            },
            likeCount: 0, // TODO: 获取话题点赞数
            commentCount: _posts.length,
            isLiked: false, // TODO: 获取当前用户是否点赞
            onLike: () {
              // TODO: 实现点赞
            },
            onShare: () {
              // TODO: 实现分享
            },
          ),
        ],
      ),
    );
  }
}

/// 话题详情页面路由
///
/// 用于导航到话题详情页面
class TopicDetailRoute {
  /// 打开话题详情页面
  ///
  /// [context] BuildContext
  /// [topicId] 话题ID
  static Future<void> open(
    BuildContext context, {
    required int topicId,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TopicDetailPageExample(topicId: topicId),
      ),
    );
  }
}
