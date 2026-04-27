import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/constants.dart';
import '../../../core/utils/date_util.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../core/utils/haptic_feedback_util.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../../data/models/comment.dart';
import '../../../data/models/feed.dart';
import '../../../data/repositories/bookmark_repository.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../data/repositories/feed_repository.dart';
import '../../pages/common/image_preview_page.dart';
import '../../providers/auth_provider.dart';
import '../../providers/bookmark_provider.dart';
import '../../providers/like_provider.dart';
import '../../providers/reply_provider.dart';
import '../../providers/user_activity_provider.dart';
import '../../widgets/common/cached_image.dart';
import '../../widgets/common/rich_text_view.dart';
import '../../widgets/detail/table_of_contents.dart';
import '../../widgets/detail/toc_progress_bar.dart';
import '../../widgets/detail/topic_magazine_renderer.dart';
import '../../widgets/editor/composer_editor.dart';
import '../../widgets/comment_input_bar.dart';
import '../../widgets/skeleton/feed_detail_skeleton.dart';

class FeedDetailPage extends ConsumerStatefulWidget {
  final String feedId;

  const FeedDetailPage({super.key, required this.feedId});

  @override
  ConsumerState<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends ConsumerState<FeedDetailPage> {
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理评论列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard(threshold: 220);

  FeedContentData? _topicDetail;
  List<TopicContentBlock> _topicBlocks = const [];
  List<ReplyData> _comments = const [];

  /// 目录项列表
  List<TocItem> _tocItems = const [];

  /// 标题块的 GlobalKey 列表
  List<GlobalKey> _headingKeys = const [];

  bool _isTopicLoading = true;
  bool _isCommentsLoading = true;
  bool _isLoadingMoreComments = false;
  bool _isSendingComment = false;
  bool _hasMoreComments = true;
  String? _replyToUsername;
  int? _replyToPostNumber;

  int _commentsPage = 1;
  String _commentSortType = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    // 延迟数据加载，等待页面动画完成后再加载
    // 避免跳转动画卡顿
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _loadInitialData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多评论。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _handleScroll() {
    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: _loadMoreComments,
    );
  }

  /// 计算目录项的滚动位置
  void _calculateTocOffsets() {
    if (_tocItems.isEmpty || _headingKeys.isEmpty) return;

    for (final item in _tocItems) {
      final blockIndex = item.blockIndex;
      if (blockIndex >= 0 && blockIndex < _headingKeys.length) {
        final key = _headingKeys[blockIndex];
        if (key.currentContext != null) {
          final renderBox =
              key.currentContext!.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            final position = renderBox.localToGlobal(Offset.zero);
            // 获取 CustomScrollView 的滚动位置
            item.offset =
                position.dy + _scrollController.offset - 100; // 减去顶部偏移
          }
        }
      }
    }
  }

  Future<void> _loadInitialData({bool showLoading = true}) async {
    if (showLoading && mounted) {
      setState(() {
        _isTopicLoading = true;
        _isCommentsLoading = true;
        _errorMessage = null;
      });
    }

    final feedRepository = ref.read(feedRepositoryProvider);
    final commentRepository = ref.read(commentRepositoryProvider);

    try {
      final responses = await Future.wait<dynamic>([
        feedRepository.getFeedDetail(id: widget.feedId),
        commentRepository.getCommentList(
          id: widget.feedId,
          page: 1,
          listType: _commentSortType,
        ),
      ]);

      final detailResponse = responses[0] as FeedContentResponse;
      final commentResponse = responses[1] as TotalReplyResponse;

      if (!_isSuccessStatus(detailResponse.status) ||
          detailResponse.data == null) {
        throw Exception(
          detailResponse.message.isNotEmpty
              ? detailResponse.message
              : '加载话题详情失败',
        );
      }

      final topicDetail = detailResponse.data!;

      // 使用 compute 将数据解析移到后台线程，避免阻塞 UI
      final topicBlocks = await compute(
        _parseTopicContent,
        topicDetail.message,
      );

      // 提取目录项并为每个标题创建 GlobalKey
      final tocItems = TocUtils.extractFromBlocks(topicBlocks);
      final headingKeys = List<GlobalKey>.generate(
        topicBlocks.length,
        (index) => topicBlocks[index].type == TopicContentBlockType.heading
            ? GlobalKey()
            : GlobalKey(),
      );

      final rawComments = _isSuccessStatus(commentResponse.status)
          ? commentResponse.data
          : const <ReplyData>[];
      final comments = _stripFirstPostIfNeeded(topicDetail, rawComments);

      if (!mounted) {
        return;
      }

      setState(() {
        _topicDetail = topicDetail;
        _topicBlocks = topicBlocks;
        _tocItems = tocItems;
        _headingKeys = headingKeys;
        _comments = comments;
        _commentsPage = 1;
        _hasMoreComments = rawComments.length >= AppConstants.pageSize;
        _isTopicLoading = false;
        _isCommentsLoading = false;
        _errorMessage = _isSuccessStatus(commentResponse.status)
            ? null
            : (commentResponse.message.isNotEmpty
                  ? commentResponse.message
                  : '回复加载失败');
      });

      // 延迟计算目录项的滚动位置
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _calculateTocOffsets();
      });
      _initializeLikeStatesForReplies(comments);
      _initializeBookmarkState(topicDetail);

      // 记录浏览历史
      _recordBrowseHistory(topicDetail);
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isTopicLoading = false;
        _isCommentsLoading = false;
        _errorMessage = '加载失败: $error';
      });
    }
  }

  Future<void> _reloadComments({String? listType}) async {
    if (_isCommentsLoading) {
      return;
    }

    if (listType != null) {
      _commentSortType = listType;
    }

    setState(() {
      _isCommentsLoading = true;
      _errorMessage = null;
    });

    final commentRepository = ref.read(commentRepositoryProvider);

    try {
      final response = await commentRepository.getCommentList(
        id: widget.feedId,
        page: 1,
        listType: _commentSortType,
      );

      if (!mounted) {
        return;
      }

      if (_isSuccessStatus(response.status)) {
        final topic = _topicDetail;
        final normalized = topic == null
            ? response.data
            : _stripFirstPostIfNeeded(topic, response.data);

        setState(() {
          _comments = normalized;
          _commentsPage = 1;
          _hasMoreComments = response.data.length >= AppConstants.pageSize;
          _isCommentsLoading = false;
        });
        _initializeLikeStatesForReplies(normalized);
      } else {
        setState(() {
          _isCommentsLoading = false;
          _errorMessage = response.message.isNotEmpty
              ? response.message
              : '回复加载失败';
        });
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isCommentsLoading = false;
        _errorMessage = '回复加载失败: $error';
      });
    }
  }

  Future<void> _loadMoreComments() async {
    if (_isLoadingMoreComments || _isCommentsLoading || !_hasMoreComments) {
      return;
    }

    setState(() {
      _isLoadingMoreComments = true;
    });

    final commentRepository = ref.read(commentRepositoryProvider);

    try {
      final nextPage = _commentsPage + 1;
      final response = await commentRepository.getCommentList(
        id: widget.feedId,
        page: nextPage,
        listType: _commentSortType,
      );

      if (!mounted) {
        return;
      }

      if (_isSuccessStatus(response.status)) {
        final existingIds = _comments.map((reply) => reply.id).toSet();
        final newItems = response.data
            .where((reply) => !existingIds.contains(reply.id))
            .toList();

        setState(() {
          _comments = [..._comments, ...newItems];
          _commentsPage = nextPage;
          _hasMoreComments = response.data.length >= AppConstants.pageSize;
          _isLoadingMoreComments = false;
        });
        _initializeLikeStatesForReplies(newItems);
      } else {
        setState(() {
          _isLoadingMoreComments = false;
          _hasMoreComments = false;
          _errorMessage = response.message.isNotEmpty
              ? response.message
              : '加载更多回复失败';
        });
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoadingMoreComments = false;
        _errorMessage = '加载更多回复失败: $error';
      });
    }
  }

  List<ReplyData> _stripFirstPostIfNeeded(
    FeedContentData topicDetail,
    List<ReplyData> replies,
  ) {
    if (replies.isEmpty) {
      return replies;
    }

    final first = replies.first;
    final topicAuthorId = topicDetail.userInfo?.uid;
    final sameAuthor =
        topicAuthorId != null &&
        topicAuthorId.isNotEmpty &&
        first.uid == topicAuthorId;

    if (!sameAuthor) {
      return replies;
    }

    final bodyMessage = _normalizeHtml(topicDetail.message);
    final firstMessage = _normalizeHtml(first.message);

    if (bodyMessage.isNotEmpty && bodyMessage == firstMessage) {
      return replies.skip(1).toList();
    }

    return replies;
  }

  bool _isSuccessStatus(int status) {
    return status == 200 || status == 1;
  }

  String _normalizeHtml(String html) {
    return html.replaceAll(RegExp(r'\s+'), '').replaceAll('&nbsp;', '').trim();
  }

  /// 记录浏览历史
  ///
  /// 当用户查看帖子详情时，将帖子信息保存到本地浏览历史
  /// [topicDetail] 帖子详情数据
  Future<void> _recordBrowseHistory(FeedContentData topicDetail) async {
    try {
      final userInfo = topicDetail.userInfo;
      if (userInfo == null) return;

      await ref
          .read(browseHistoriesProvider.notifier)
          .addHistory(
            feedId: widget.feedId,
            uid: userInfo.uid,
            username: userInfo.username,
            avatarUrl: userInfo.avatar ?? '',
            deviceTitle: topicDetail.title ?? '',
            message: topicDetail.message.isNotEmpty
                ? topicDetail.message.substring(
                    0,
                    topicDetail.message.length > 100
                        ? 100
                        : topicDetail.message.length,
                  )
                : '',
            dateline: topicDetail.dateline,
          );
    } catch (e) {
      // 记录浏览历史失败不应影响用户体验，静默处理
      debugPrint('记录浏览历史失败: $e');
    }
  }

  Future<void> _openExternalLink(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && mounted) {
      context.push(
        '${RoutePaths.webview}?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent('外部链接')}',
      );
    }
  }

  void _startReplyTo(ReplyData reply) {
    final username = reply.username;
    setState(() {
      _replyToUsername = username;
      // 使用 reply id 进行楼中楼回复
      _replyToPostNumber = int.tryParse(reply.id);
    });
  }

  Future<void> _sendComment(String content) async {
    final hasSession = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!hasSession) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先登录后再回复'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () => context.push(RoutePaths.login),
          ),
        ),
      );
      return;
    }

    final trimmedContent = content.trim();
    if (trimmedContent.isEmpty || _isSendingComment) {
      return;
    }

    setState(() {
      _isSendingComment = true;
    });

    final commentRepository = ref.read(commentRepositoryProvider);

    try {
      final topicId = int.tryParse(widget.feedId);
      if (topicId == null || topicId <= 0) {
        throw Exception('无效的话题ID: ${widget.feedId}');
      }

      final response = await commentRepository.createComment(
        topicId: topicId,
        content: trimmedContent,
        replyToPostNumber: _replyToPostNumber,
      );

      if (!mounted) {
        return;
      }

      if (response.success) {
        setState(() {
          _replyToUsername = null;
          _replyToPostNumber = null;
          if (_topicDetail != null) {
            _topicDetail = _topicDetail!.copyWith(
              replyNum: _topicDetail!.replyNum + 1,
            );
          }
        });

        await _reloadComments();
        if (!mounted) {
          return;
        }
        HapticFeedbackUtil.trigger(ref, HapticScene.commentSuccess);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('回复发送成功')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.errorMessage ?? '回复发送失败')),
        );
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('回复发送失败: $error')));
    } finally {
      if (mounted) {
        setState(() {
          _isSendingComment = false;
        });
      }
    }
  }

  /// 处理点赞
  Future<void> _handleLike() async {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);

    final topicId = int.tryParse(widget.feedId);
    if (topicId == null || topicId <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('无效的话题ID')));
      return;
    }

    final hasSession = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!hasSession) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先登录后再点赞'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () => context.push(RoutePaths.login),
          ),
        ),
      );
      return;
    }

    // 乐观更新 UI
    final currentIsLiked = _topicDetail?.action.isLike ?? false;
    final currentLikeNum = _topicDetail?.action.likeNum ?? 0;

    setState(() {
      if (_topicDetail != null) {
        _topicDetail = _topicDetail!.copyWith(
          action: _topicDetail!.action.copyWith(
            isLike: !currentIsLiked,
            likeNum: currentIsLiked
                ? (currentLikeNum - 1).clamp(0, currentLikeNum)
                : currentLikeNum + 1,
          ),
        );
      }
    });

    // 调用点赞 API
    try {
      await ref.read(likeProvider.notifier).toggleLike(topicId);
    } catch (e) {
      // 失败时回滚
      if (mounted) {
        setState(() {
          if (_topicDetail != null) {
            _topicDetail = _topicDetail!.copyWith(
              action: _topicDetail!.action.copyWith(
                isLike: currentIsLiked,
                likeNum: currentLikeNum,
              ),
            );
          }
        });
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('点赞失败: $e')));
      }
    }
  }

  /// 处理收藏
  Future<void> _handleFavorite() async {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);
    await _toggleBookmark();
  }

  /// 处理分享
  void _handleShare() {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);
    final topicUrl = 'https://forum.trae.cn/t/${widget.feedId}';
    Clipboard.setData(ClipboardData(text: topicUrl));
    HapticFeedbackUtil.trigger(ref, HapticScene.copySuccess);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('链接已复制到剪贴板')));
  }

  Future<void> _initializeBookmarkState(FeedContentData topicDetail) async {
    final topicId = int.tryParse(widget.feedId) ?? int.tryParse(topicDetail.id);
    if (topicId == null || topicId <= 0) {
      return;
    }

    var isBookmarked = topicDetail.action.isFavorite;
    int? bookmarkId;

    final hasSession = await ref.read(isAuthenticatedAsyncProvider.future);
    if (hasSession) {
      bookmarkId = await ref
          .read(bookmarkRepositoryProvider)
          .findBookmarkIdByTopicId(topicId);
      if (bookmarkId != null) {
        isBookmarked = true;
      }
    }

    if (!mounted) {
      return;
    }

    ref
        .read(bookmarkProvider.notifier)
        .syncPost(topicId, bookmarkId: bookmarkId, isBookmarked: isBookmarked);
  }

  Future<void> _toggleBookmark() async {
    HapticFeedbackUtil.trigger(ref, HapticScene.tap);

    final topicId = int.tryParse(widget.feedId);
    if (topicId == null || topicId <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('无效的话题ID，无法操作书签')));
      return;
    }

    final hasSession = await ref.read(isAuthenticatedAsyncProvider.future);
    if (!hasSession) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('请先登录后再使用书签'),
          action: SnackBarAction(
            label: '登录',
            onPressed: () => context.push(RoutePaths.login),
          ),
        ),
      );
      return;
    }

    final notifier = ref.read(bookmarkProvider.notifier);
    final beforeState = ref.read(postBookmarkStateProvider(topicId));
    if (beforeState == null) {
      notifier.initializePost(
        topicId,
        isBookmarked: _topicDetail?.action.isFavorite ?? false,
      );
    }

    await notifier.toggleBookmark(topicId, bookmarkId: beforeState?.bookmarkId);
    if (!mounted) {
      return;
    }

    final currentState = ref.read(postBookmarkStateProvider(topicId));
    final message = currentState?.errorMessage;
    if (message != null && message.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
      notifier.clearError(topicId);
      return;
    }

    final tips = (currentState?.isBookmarked ?? false) ? '已添加论坛书签' : '已取消论坛书签';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(tips)));
  }

  @override
  Widget build(BuildContext context) {
    final detail = _topicDetail;
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          detail?.title?.trim().isNotEmpty == true
              ? detail!.title!.trim()
              : '话题详情',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                await HapticFeedbackUtil.trigger(ref, HapticScene.refresh);
                await _loadInitialData(showLoading: false);
                await HapticFeedbackUtil.trigger(ref, HapticScene.refreshDone);
              },
              child: _buildContent(context),
            ),
          ),
          // 目录进度条（放在回复输入栏上方）
          TocProgressBar(
            items: _tocItems,
            scrollController: _scrollController,
            visible: _tocItems.length >= 2,
          ),
          CommentInputBar(
            isLoggedIn: isLoggedIn,
            isSending: _isSendingComment,
            replyingToUsername: _replyToUsername,
            onCancelReply: () {
              setState(() {
                _replyToUsername = null;
                _replyToPostNumber = null;
              });
            },
            onSend: (content) => _sendComment(content),
            onLoginTap: () => context.push(RoutePaths.login),
            commentCount: _topicDetail?.replyNum ?? 0,
            likeCount: _topicDetail?.action.likeNum ?? 0,
            favoriteCount: _topicDetail?.action.favoriteNum ?? 0,
            shareCount: 0,
            isLiked: _topicDetail?.action.isLike ?? false,
            isFavorited: _topicDetail?.action.isFavorite ?? false,
            onLikeTap: _handleLike,
            onFavoriteTap: _handleFavorite,
            onShareTap: _handleShare,
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_isTopicLoading && _topicDetail == null) {
      return const FeedDetailSkeleton();
    }

    if (_topicDetail == null) {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        children: [
          Icon(
            Icons.error_outline,
            size: 54,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 12),
          Text(
            _errorMessage ?? '话题加载失败',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 14),
          FilledButton(onPressed: _loadInitialData, child: const Text('重试')),
        ],
      );
    }

    final detail = _topicDetail!;
    final topicId = int.tryParse(widget.feedId) ?? int.tryParse(detail.id) ?? 0;
    final bookmarkState = topicId > 0
        ? ref.watch(postBookmarkStateProvider(topicId))
        : null;
    final isBookmarked =
        bookmarkState?.isBookmarked ?? detail.action.isFavorite;
    final isBookmarkLoading = bookmarkState?.isLoading ?? false;

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: _TopicHeaderSection(
            detail: detail,
            blocks: _topicBlocks,
            headingKeys: _headingKeys,
            onLinkTap: _openExternalLink,
            isBookmarked: isBookmarked,
            isBookmarkLoading: isBookmarkLoading,
            onBookmarkTap: _toggleBookmark,
            onOpenInBrowserTap: () =>
                _openExternalLink('https://forum.trae.cn/t/${widget.feedId}'),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
            child: Row(
              children: [
                Text(
                  '回复',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${detail.replyNum}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                _CommentSortButton(
                  currentSort: _commentSortType,
                  onSortChanged: (sort) async {
                    await HapticFeedbackUtil.trigger(ref, HapticScene.tap);
                    await _reloadComments(listType: sort);
                  },
                ),
              ],
            ),
          ),
        ),
        if (_errorMessage != null)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onErrorContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (_isCommentsLoading && _comments.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_comments.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                '暂无回复',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        else
          SliverList.builder(
            itemCount: _comments.length,
            // 添加 findChildIndexCallback 优化大列表性能
            findChildIndexCallback: (key) {
              if (key is ValueKey<String>) {
                final id = key.value.replaceFirst('reply_', '');
                return _comments.indexWhere((reply) => reply.id == id);
              }
              return null;
            },
            itemBuilder: (context, index) {
              final reply = _comments[index];
              return _ReplyItem(
                key: ValueKey('reply_${reply.id}'),
                reply: reply,
                floor: index + 1,
                topicAuthorUid: detail.userInfo?.uid,
                onLinkTap: _openExternalLink,
                onReplyTap: () => _startReplyTo(reply),
                onEditTap: () => _showEditReplyBottomSheet(reply),
                onDeleteTap: () => _showDeleteReplyConfirm(reply),
              );
            },
          ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Center(
              child: _isLoadingMoreComments
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : (!_hasMoreComments && _comments.isNotEmpty)
                  ? Text(
                      '没有更多回复了',
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }

  void _showMoreOptions(BuildContext context) {
    final currentUser = ref.read(currentUserProvider);
    final topicAuthorId = _topicDetail?.userInfo?.uid;
    final isTopicAuthor = currentUser?.uid == topicAuthorId;

    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 编辑话题选项（仅楼主可见）
            if (isTopicAuthor)
              ListTile(
                leading: Icon(
                  Icons.edit,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('编辑帖子'),
                onTap: () {
                  Navigator.of(context).pop();
                  HapticFeedbackUtil.trigger(ref, HapticScene.tap);
                  _navigateToEditPage();
                },
              ),
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('分享话题链接'),
              onTap: () {
                Navigator.of(context).pop();
                HapticFeedbackUtil.trigger(ref, HapticScene.tap);
                final topicUrl = 'https://forum.trae.cn/t/${widget.feedId}';
                Clipboard.setData(ClipboardData(text: topicUrl));
                HapticFeedbackUtil.trigger(ref, HapticScene.copySuccess);
                ScaffoldMessenger.of(
                  this.context,
                ).showSnackBar(const SnackBar(content: Text('链接已复制到剪贴板')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.open_in_browser_outlined),
              title: const Text('在浏览器中打开'),
              onTap: () {
                Navigator.of(context).pop();
                HapticFeedbackUtil.trigger(ref, HapticScene.tap);
                _openExternalLink('https://forum.trae.cn/t/${widget.feedId}');
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 导航到编辑页面
  ///
  /// 使用 push 导航到编辑页面，等待返回结果
  /// 如果编辑成功，刷新话题详情
  Future<void> _navigateToEditPage() async {
    final result = await context.push('/feed/${widget.feedId}/edit');
    // 如果编辑成功，刷新话题详情
    if (result == true && mounted) {
      await _loadInitialData(showLoading: false);
    }
  }

  void _initializeLikeStatesForReplies(List<ReplyData> replies) {
    final notifier = ref.read(likeProvider.notifier);
    for (final reply in replies) {
      final postId = int.tryParse(reply.id);
      if (postId != null && postId > 0) {
        notifier.initializePost(
          postId,
          likeCount: reply.likeNum,
          isLiked: reply.isLike,
        );
      }
    }
  }

  /// 显示编辑回复 Bottom Sheet
  ///
  /// [reply] 要编辑的回复数据
  /// 使用 Bottom Sheet 展示 ComposerEditor，支持 Markdown 编辑与预览
  void _showEditReplyBottomSheet(ReplyData reply) {
    final colorScheme = Theme.of(context).colorScheme;
    final postId = int.tryParse(reply.id);
    if (postId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('无效的回复ID')));
      return;
    }

    // 保存原始内容用于回滚
    final originalContent = reply.message;
    // 保存回复索引用于局部更新
    final replyIndex = _comments.indexWhere((r) => r.id == reply.id);
    // 用于保存编辑器内容的回调
    String currentContent = originalContent;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Consumer(
            builder: (context, ref, child) {
              final replyState = ref.watch(replyNotifierProvider);

              return Column(
                children: [
                  // 顶部拖动指示器
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
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
                  // 标题栏
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: colorScheme.outline.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '编辑回复',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        // 取消按钮
                        TextButton(
                          onPressed: replyState.isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          child: const Text('取消'),
                        ),
                        const SizedBox(width: 8),
                        // 保存按钮
                        FilledButton(
                          onPressed: replyState.isLoading
                              ? null
                              : () async {
                                  final content = currentContent.trim();

                                  if (content.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('回复内容不能为空')),
                                    );
                                    return;
                                  }

                                  // 乐观更新：先更新本地数据
                                  if (replyIndex >= 0 && mounted) {
                                    setState(() {
                                      _comments = _comments.map((r) {
                                        if (r.id == reply.id) {
                                          return r.copyWith(message: content);
                                        }
                                        return r;
                                      }).toList();
                                    });
                                  }

                                  // 关闭 Bottom Sheet
                                  Navigator.of(context).pop();

                                  // 调用 API 保存
                                  final result = await ref
                                      .read(replyNotifierProvider.notifier)
                                      .editReply(
                                        postId: postId,
                                        content: content,
                                      );

                                  if (!mounted) return;

                                  if (result.success) {
                                    HapticFeedbackUtil.trigger(
                                      ref,
                                      HapticScene.commentSuccess,
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('回复编辑成功')),
                                    );
                                  } else {
                                    // 失败回滚：恢复原始内容
                                    if (replyIndex >= 0) {
                                      setState(() {
                                        _comments = _comments.map((r) {
                                          if (r.id == reply.id) {
                                            return r.copyWith(
                                              message: originalContent,
                                            );
                                          }
                                          return r;
                                        }).toList();
                                      });
                                    }
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          result.errorMessage ?? '编辑失败',
                                        ),
                                        action: SnackBarAction(
                                          label: '重试',
                                          onPressed: () =>
                                              _showEditReplyBottomSheet(reply),
                                        ),
                                      ),
                                    );
                                  }
                                },
                          child: replyState.isLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('保存'),
                        ),
                      ],
                    ),
                  ),
                  // 编辑器区域
                  Expanded(
                    child: ComposerEditor(
                      initialText: originalContent,
                      hintText: '编辑你的回复...',
                      autofocus: true,
                      showPreview: true,
                      showToolbar: true,
                      enableSplitView: true,
                      initialMode: ComposerEditorMode.edit,
                      minHeight: 300,
                      onTextChanged: (text) {
                        currentContent = text;
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  /// 显示删除回复确认对话框
  ///
  /// [reply] 要删除的回复数据
  void _showDeleteReplyConfirm(ReplyData reply) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('删除回复'),
        content: const Text('确定要删除这条回复吗？此操作不可撤销。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          Consumer(
            builder: (context, ref, child) {
              final replyState = ref.watch(replyNotifierProvider);
              return FilledButton(
                onPressed: replyState.isLoading
                    ? null
                    : () async {
                        final postId = int.tryParse(reply.id);
                        if (postId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('无效的回复ID')),
                          );
                          return;
                        }

                        // 保存删除前的状态，用于错误恢复
                        final previousComments = List<ReplyData>.from(
                          _comments,
                        );
                        final previousReplyNum = _topicDetail?.replyNum ?? 0;

                        // 乐观删除：立即从列表中移除
                        _optimisticRemoveReply(reply);

                        Navigator.of(context).pop();

                        final result = await ref
                            .read(replyNotifierProvider.notifier)
                            .deleteReply(postId);

                        if (!mounted) return;

                        if (result.success) {
                          HapticFeedbackUtil.trigger(
                            ref,
                            HapticScene.deleteSuccess,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('回复已删除')),
                          );
                        } else {
                          // 删除失败，恢复列表
                          _restoreComments(previousComments, previousReplyNum);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                result.errorMessage ?? '删除失败，请稍后重试',
                              ),
                              action: SnackBarAction(
                                label: '重试',
                                onPressed: () => _showDeleteReplyConfirm(reply),
                              ),
                            ),
                          );
                        }
                      },
                style: FilledButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
                child: replyState.isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('删除'),
              );
            },
          ),
        ],
      ),
    );
  }

  /// 乐观删除：立即从列表中移除回复并更新计数
  ///
  /// [reply] 要移除的回复数据
  void _optimisticRemoveReply(ReplyData reply) {
    if (!mounted) return;

    setState(() {
      // 从列表中移除
      _comments = _comments.where((item) => item.id != reply.id).toList();

      // 更新回复计数
      if (_topicDetail != null) {
        final newReplyNum = (_topicDetail!.replyNum - 1).clamp(
          0,
          _topicDetail!.replyNum,
        );
        _topicDetail = _topicDetail!.copyWith(replyNum: newReplyNum);
      }
    });
  }

  /// 恢复评论列表和计数（删除失败时调用）
  ///
  /// [previousComments] 删除前的评论列表
  /// [previousReplyNum] 删除前的回复数
  void _restoreComments(
    List<ReplyData> previousComments,
    int previousReplyNum,
  ) {
    if (!mounted) return;

    setState(() {
      _comments = previousComments;
      if (_topicDetail != null) {
        _topicDetail = _topicDetail!.copyWith(replyNum: previousReplyNum);
      }
    });
  }
}

class _TopicHeaderSection extends StatelessWidget {
  final FeedContentData detail;
  final List<TopicContentBlock> blocks;
  final List<GlobalKey> headingKeys;
  final ValueChanged<String> onLinkTap;
  final bool isBookmarked;
  final bool isBookmarkLoading;
  final VoidCallback onBookmarkTap;
  final VoidCallback onOpenInBrowserTap;

  const _TopicHeaderSection({
    required this.detail,
    required this.blocks,
    required this.headingKeys,
    required this.onLinkTap,
    required this.isBookmarked,
    required this.isBookmarkLoading,
    required this.onBookmarkTap,
    required this.onOpenInBrowserTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final username = detail.userInfo?.username ?? '匿名用户';
    final avatar = detail.userInfo?.avatar;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.12),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (detail.title?.trim().isNotEmpty == true)
            Text(
              detail.title!.trim(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.25,
              ),
            ),
          if (detail.title?.trim().isNotEmpty == true)
            const SizedBox(height: 16),
          Row(
            children: [
              _AuthorAvatar(avatar: avatar, username: username),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            username,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                        if (detail.isTop) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '置顶',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _formatTimestamp(detail.dateline),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          TopicMagazineRenderer(
            blocks: blocks,
            onLinkTap: onLinkTap,
            headingKeys: headingKeys,
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Icon(
                Icons.chat_bubble_outline_rounded,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                '${detail.replyNum} 条回复',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: isBookmarkLoading ? null : onBookmarkTap,
                icon: isBookmarkLoading
                    ? SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.primary,
                        ),
                      )
                    : Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        size: 16,
                        color: isBookmarked
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                      ),
                label: Text(isBookmarked ? '已加书签' : '书签'),
              ),
              OutlinedButton.icon(
                onPressed: onOpenInBrowserTap,
                icon: const Icon(Icons.open_in_browser_outlined, size: 16),
                label: const Text('论坛网页'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  minimumSize: const Size(0, 34),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _formatTimestamp(String dateline) {
    final seconds = int.tryParse(dateline) ?? 0;
    if (seconds <= 0) {
      return '未知时间';
    }
    return DateUtil.getRelativeTimeFromTimestampSeconds(seconds);
  }
}

/// 在后台线程解析话题内容
/// 用于 compute 函数，必须是顶层函数或静态方法
List<TopicContentBlock> _parseTopicContent(String message) {
  return TopicCookedParser.parse(message);
}

class _AuthorAvatar extends StatelessWidget {
  final String? avatar;
  final String username;

  const _AuthorAvatar({required this.avatar, required this.username});

  @override
  Widget build(BuildContext context) {
    final imageUrl = avatar;
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return ClipOval(
        child: CachedImage(
          imageUrl: imageUrl,
          width: 44,
          height: 44,
          fit: BoxFit.cover,
        ),
      );
    }

    return CircleAvatar(
      radius: 22,
      child: Text(username.isNotEmpty ? username[0].toUpperCase() : '?'),
    );
  }
}

class _CommentSortButton extends StatelessWidget {
  final String currentSort;
  final ValueChanged<String> onSortChanged;

  const _CommentSortButton({
    required this.currentSort,
    required this.onSortChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isHot = currentSort == 'hot';
    return PopupMenuButton<String>(
      initialValue: currentSort,
      onSelected: onSortChanged,
      itemBuilder: (context) => const [
        PopupMenuItem(value: '', child: Text('时间排序')),
        PopupMenuItem(value: 'hot', child: Text('热度排序')),
      ],
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isHot ? '热度排序' : '时间排序',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const Icon(Icons.arrow_drop_down_rounded, size: 18),
        ],
      ),
    );
  }
}

class _ReplyItem extends ConsumerWidget {
  final ReplyData reply;
  final int floor;
  final String? topicAuthorUid;
  final ValueChanged<String> onLinkTap;
  final VoidCallback? onReplyTap;
  final VoidCallback? onEditTap;
  final VoidCallback? onDeleteTap;

  const _ReplyItem({
    super.key,
    required this.reply,
    required this.floor,
    required this.topicAuthorUid,
    required this.onLinkTap,
    this.onReplyTap,
    this.onEditTap,
    this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTopicAuthor = topicAuthorUid != null && topicAuthorUid == reply.uid;
    final likeState = ref.watch(
      postLikeStateProvider(int.tryParse(reply.id) ?? 0),
    );
    final isLiked = likeState?.isLiked ?? reply.isLike;
    final likeNum = likeState?.likeCount ?? reply.likeNum;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.12),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentAvatar(avatar: reply.avatar, username: reply.username),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        reply.username,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    if (isTopicAuthor) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '楼主',
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: colorScheme.onPrimaryContainer),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      '#$floor',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  _formatTimestamp(reply.dateline),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                if (reply.replyTo != null && reply.replyTo!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      '回复 @${reply.replyTo}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                _ReplyMessage(htmlContent: reply.message, onLinkTap: onLinkTap),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final postId = int.tryParse(reply.id);
                        if (postId != null && postId > 0) {
                          await HapticFeedbackUtil.trigger(
                            ref,
                            isLiked ? HapticScene.unlike : HapticScene.like,
                          );
                          await ref
                              .read(likeProvider.notifier)
                              .toggleLike(postId);
                        }
                      },
                      child: Row(
                        children: [
                          Icon(
                            isLiked
                                ? Icons.thumb_up_alt
                                : Icons.thumb_up_alt_outlined,
                            size: 16,
                            color: isLiked
                                ? colorScheme.primary
                                : colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '$likeNum',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: isLiked
                                      ? colorScheme.primary
                                      : colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    GestureDetector(
                      onTap: () async {
                        await HapticFeedbackUtil.trigger(ref, HapticScene.tap);
                        onReplyTap?.call();
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.reply_outlined,
                            size: 16,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '回复',
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    // 更多操作菜单
                    _buildMoreOptionsButton(context, ref),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建更多操作按钮
  ///
  /// [context] 构建上下文
  /// [ref] WidgetRef 用于获取 Provider
  Widget _buildMoreOptionsButton(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final currentUser = ref.watch(currentUserProvider);
    final isCurrentUser = currentUser?.uid == reply.uid;

    // 如果没有编辑/删除权限，不显示更多按钮
    if (!isCurrentUser) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () => _showMoreOptions(context),
      child: Icon(
        Icons.more_vert,
        size: 18,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }

  /// 显示更多操作菜单
  ///
  /// [context] 构建上下文
  void _showMoreOptions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖动指示器
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
            // 编辑选项
            ListTile(
              leading: Icon(Icons.edit, color: colorScheme.primary),
              title: const Text('编辑'),
              onTap: () {
                Navigator.of(context).pop();
                onEditTap?.call();
              },
            ),
            // 删除选项
            ListTile(
              leading: Icon(Icons.delete, color: colorScheme.error),
              title: Text('删除', style: TextStyle(color: colorScheme.error)),
              onTap: () {
                Navigator.of(context).pop();
                onDeleteTap?.call();
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _formatTimestamp(String dateline) {
    final seconds = int.tryParse(dateline) ?? 0;
    if (seconds <= 0) {
      return '未知时间';
    }
    return DateUtil.getRelativeTimeFromTimestampSeconds(seconds);
  }
}

class _ReplyMessage extends StatefulWidget {
  final String htmlContent;
  final ValueChanged<String> onLinkTap;

  const _ReplyMessage({required this.htmlContent, required this.onLinkTap});

  @override
  State<_ReplyMessage> createState() => _ReplyMessageState();
}

class _ReplyMessageState extends State<_ReplyMessage> {
  static const int _maxLines = 8;

  /// 是否已展开
  bool _isExpanded = false;

  @override
  void didUpdateWidget(covariant _ReplyMessage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.htmlContent != widget.htmlContent && _isExpanded) {
      _isExpanded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final imageUrls = TopicCookedParser.extractImages(
      widget.htmlContent,
    ).map(DiscourseImageUrlResolver.toOriginalUrl).whereType<String>().toList();

    void previewImage(String url) {
      final images = imageUrls.isEmpty ? <String>[url] : imageUrls;
      final index = images.indexOf(url);
      ImagePreviewPage.show(
        context,
        imageUrls: images,
        initialIndex: index < 0 ? 0 : index,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final needsCollapse = _shouldCollapse(context, constraints.maxWidth);

        if (!needsCollapse) {
          return RichTextView(
            htmlContent: widget.htmlContent,
            onLinkTap: widget.onLinkTap,
            onImageTap: previewImage,
          );
        }

        final contentWidget = _isExpanded
            ? RichTextView(
                key: const ValueKey('expanded_reply_content'),
                htmlContent: widget.htmlContent,
                onLinkTap: widget.onLinkTap,
                onImageTap: previewImage,
              )
            : ClipRect(
                key: const ValueKey('collapsed_reply_content'),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _calculateFoldedHeight(context),
                  ),
                  child: Stack(
                    children: [
                      RichTextView(
                        htmlContent: widget.htmlContent,
                        onLinkTap: widget.onLinkTap,
                        onImageTap: previewImage,
                      ),
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 140),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              child: contentWidget,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  _isExpanded ? '收起' : '查看更多',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  double _calculateFoldedHeight(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final fontSize = textTheme.bodyMedium?.fontSize ?? 14;
    const lineHeight = 1.5;
    final estimatedLineHeight = fontSize * lineHeight;
    return estimatedLineHeight * _maxLines + 56;
  }

  bool _shouldCollapse(BuildContext context, double maxWidth) {
    final html = widget.htmlContent.trim();
    if (html.isEmpty) return false;

    final hasHeavyBlocks = RegExp(
      r'<\s*(img|pre|blockquote|table|ul|ol|li|h[1-6]|iframe|video)\b',
      caseSensitive: false,
    ).hasMatch(html);
    if (hasHeavyBlocks) {
      return true;
    }

    final plainText = _extractPlainText(html);
    if (plainText.isEmpty) return false;

    if (plainText.runes.length > 220) {
      return true;
    }
    final lineCount = '\n'.allMatches(plainText).length + 1;
    if (lineCount > _maxLines) {
      return true;
    }

    final effectiveWidth = maxWidth.isFinite && maxWidth > 0
        ? maxWidth
        : MediaQuery.of(context).size.width - 32;
    final textPainter = TextPainter(
      text: TextSpan(
        text: plainText,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
      ),
      maxLines: _maxLines,
      textDirection: Directionality.of(context),
    )..layout(maxWidth: effectiveWidth);

    return textPainter.didExceedMaxLines;
  }

  /// 去除 HTML 标签，用于测量文本长度
  String _extractPlainText(String htmlText) {
    return htmlText
        .replaceAll(
          RegExp(r'</(p|div|li|blockquote|h[1-6])>', caseSensitive: false),
          '\n',
        )
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll(RegExp(r'[ \t\r\f\v]+'), ' ')
        .replaceAll(RegExp(r'\n{3,}'), '\n\n')
        .trim();
  }
}

class _CommentAvatar extends StatelessWidget {
  final String? avatar;
  final String username;

  const _CommentAvatar({required this.avatar, required this.username});

  @override
  Widget build(BuildContext context) {
    if (avatar != null && avatar!.isNotEmpty) {
      return ClipOval(
        child: CachedImage(
          imageUrl: avatar!,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
        ),
      );
    }

    return CircleAvatar(
      radius: 18,
      child: Text(
        username.isNotEmpty ? username[0].toUpperCase() : '?',
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}
