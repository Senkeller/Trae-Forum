import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/constants.dart';
import '../../../core/utils/date_util.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../data/models/comment.dart';
import '../../../data/models/feed.dart';
import '../../../data/repositories/comment_repository.dart';
import '../../../data/repositories/feed_repository.dart';
import '../../pages/common/image_preview_page.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/cached_image.dart';
import '../../widgets/common/rich_text_view.dart';
import '../../widgets/detail/topic_magazine_renderer.dart';

class FeedDetailPage extends ConsumerStatefulWidget {
  final String feedId;

  const FeedDetailPage({super.key, required this.feedId});

  @override
  ConsumerState<FeedDetailPage> createState() => _FeedDetailPageState();
}

class _FeedDetailPageState extends ConsumerState<FeedDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  FeedContentData? _topicDetail;
  List<TopicContentBlock> _topicBlocks = const [];
  List<ReplyData> _comments = const [];

  bool _isTopicLoading = true;
  bool _isCommentsLoading = true;
  bool _isLoadingMoreComments = false;
  bool _isSendingComment = false;
  bool _hasMoreComments = true;
  String? _replyToUsername;

  int _commentsPage = 1;
  String _commentSortType = '';
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    _loadInitialData();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    final threshold = _scrollController.position.maxScrollExtent - 220;
    if (_scrollController.position.pixels >= threshold) {
      _loadMoreComments();
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
      final topicBlocks = TopicCookedParser.parse(topicDetail.message);

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

  void _startReplyTo(String username) {
    setState(() {
      _replyToUsername = username;
    });

    final prefix = '@$username ';
    if (!_commentController.text.trim().startsWith(prefix.trim())) {
      _commentController.value = TextEditingValue(
        text: prefix,
        selection: TextSelection.collapsed(offset: prefix.length),
      );
    }
    _commentFocusNode.requestFocus();
  }

  Future<void> _sendComment() async {
    final user = ref.read(currentUserProvider);
    if (user == null || user.uid.isEmpty) {
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

    final content = _commentController.text.trim();
    if (content.isEmpty || _isSendingComment) {
      return;
    }

    setState(() {
      _isSendingComment = true;
    });

    final commentRepository = ref.read(commentRepositoryProvider);

    try {
      final response = await commentRepository.sendComment(
        id: widget.feedId,
        message: content,
        type: 'feed',
      );

      if (!mounted) {
        return;
      }

      final ok = response.status == 200 || response.status == 1;
      if (ok) {
        setState(() {
          _commentController.clear();
          _replyToUsername = null;
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('回复发送成功')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(response.message ?? '回复发送失败')));
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
              onRefresh: () => _loadInitialData(showLoading: false),
              child: _buildContent(context),
            ),
          ),
          _BottomCommentBar(
            controller: _commentController,
            focusNode: _commentFocusNode,
            isLoggedIn: isLoggedIn,
            isSending: _isSendingComment,
            replyingToUsername: _replyToUsername,
            onCancelReply: () {
              setState(() {
                _replyToUsername = null;
              });
            },
            onSend: _sendComment,
            onLoginTap: () => context.push(RoutePaths.login),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (_isTopicLoading && _topicDetail == null) {
      return ListView(
        children: const [
          SizedBox(height: 280),
          Center(child: CircularProgressIndicator()),
        ],
      );
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

    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(
          child: _TopicHeaderSection(
            detail: detail,
            blocks: _topicBlocks,
            onLinkTap: _openExternalLink,
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
                  onSortChanged: (sort) => _reloadComments(listType: sort),
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
            itemBuilder: (context, index) {
              final reply = _comments[index];
              return _ReplyItem(
                reply: reply,
                floor: index + 1,
                topicAuthorUid: detail.userInfo?.uid,
                onLinkTap: _openExternalLink,
                onReplyTap: () => _startReplyTo(reply.username),
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
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share_outlined),
              title: const Text('分享话题链接'),
              onTap: () {
                Navigator.of(context).pop();
                final topicUrl = 'https://forum.trae.cn/t/${widget.feedId}';
                ScaffoldMessenger.of(
                  this.context,
                ).showSnackBar(SnackBar(content: Text('链接: $topicUrl')));
              },
            ),
            ListTile(
              leading: const Icon(Icons.open_in_browser_outlined),
              title: const Text('在浏览器中打开'),
              onTap: () {
                Navigator.of(context).pop();
                _openExternalLink('https://forum.trae.cn/t/${widget.feedId}');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicHeaderSection extends StatelessWidget {
  final FeedContentData detail;
  final List<TopicContentBlock> blocks;
  final ValueChanged<String> onLinkTap;

  const _TopicHeaderSection({
    required this.detail,
    required this.blocks,
    required this.onLinkTap,
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
          TopicMagazineRenderer(blocks: blocks, onLinkTap: onLinkTap),
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

class _ReplyItem extends StatelessWidget {
  final ReplyData reply;
  final int floor;
  final String? topicAuthorUid;
  final ValueChanged<String> onLinkTap;
  final VoidCallback? onReplyTap;

  const _ReplyItem({
    required this.reply,
    required this.floor,
    required this.topicAuthorUid,
    required this.onLinkTap,
    this.onReplyTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTopicAuthor = topicAuthorUid != null && topicAuthorUid == reply.uid;

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
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${reply.likeNum}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 14),
                    GestureDetector(
                      onTap: onReplyTap,
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
                  ],
                ),
              ],
            ),
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

class _ReplyMessage extends StatelessWidget {
  final String htmlContent;
  final ValueChanged<String> onLinkTap;

  const _ReplyMessage({required this.htmlContent, required this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    final imageUrls = TopicCookedParser.extractImages(
      htmlContent,
    ).map(DiscourseImageUrlResolver.toOriginalUrl).whereType<String>().toList();

    return RichTextView(
      htmlContent: htmlContent,
      onLinkTap: onLinkTap,
      onImageTap: (url) {
        final images = imageUrls.isEmpty ? <String>[url] : imageUrls;
        final index = images.indexOf(url);
        ImagePreviewPage.show(
          context,
          imageUrls: images,
          initialIndex: index < 0 ? 0 : index,
        );
      },
    );
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

class _BottomCommentBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isLoggedIn;
  final bool isSending;
  final String? replyingToUsername;
  final VoidCallback? onCancelReply;
  final Future<void> Function() onSend;
  final VoidCallback onLoginTap;

  const _BottomCommentBar({
    required this.controller,
    required this.focusNode,
    required this.isLoggedIn,
    required this.isSending,
    required this.replyingToUsername,
    required this.onCancelReply,
    required this.onSend,
    required this.onLoginTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        border: Border(
          top: BorderSide(color: colorScheme.outline.withValues(alpha: 0.2)),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyingToUsername != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.reply_rounded,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '正在回复 @$replyingToUsername',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: onCancelReply,
                      child: Icon(
                        Icons.close_rounded,
                        size: 18,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (context, value, _) {
                final hasText = value.text.trim().isNotEmpty;

                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        enabled: isLoggedIn && !isSending,
                        decoration: InputDecoration(
                          hintText: isLoggedIn ? '写下你的回复...' : '登录后参与回复',
                          filled: true,
                          fillColor: colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.6),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                        ),
                        minLines: 1,
                        maxLines: 4,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) {
                          if (isLoggedIn && hasText && !isSending) {
                            onSend();
                          } else if (!isLoggedIn) {
                            onLoginTap();
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: isSending
                          ? null
                          : (isLoggedIn
                                ? (hasText ? onSend : null)
                                : onLoginTap),
                      icon: isSending
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(
                              isLoggedIn
                                  ? Icons.send_rounded
                                  : Icons.login_rounded,
                            ),
                      color: colorScheme.primary,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
