import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户回复列表页
///
/// 展示指定用户的所有回复内容，支持下拉刷新和加载更多
class UserRepliesPage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username），从路由参数获取
  final String username;

  const UserRepliesPage({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<UserRepliesPage> createState() => _UserRepliesPageState();
}

class _UserRepliesPageState extends ConsumerState<UserRepliesPage> {
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  /// 回复列表数据
  List<UserActivity> _replies = [];

  /// 是否正在加载数据
  bool _isLoading = false;

  /// 是否正在刷新数据
  bool _isRefreshing = false;

  /// 是否还有更多数据
  bool _hasMore = true;

  /// 当前页码
  int _currentPage = 0;

  /// 错误信息
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadReplies();
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
    if (_isLoading || !_hasMore) return;

    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: _loadMoreReplies,
    );
  }

  /// 加载回复列表（首次加载）
  ///
  /// 从服务器获取用户的回复列表，初始化页面数据
  Future<void> _loadReplies() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _currentPage = 0;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityReplies(
        username: widget.username,
        page: 0,
      );

      if (response.status == 1 || response.status == 200) {
        setState(() {
          _replies = response.data;
          _isLoading = false;
          _hasMore = response.data.length >= 20;
          _currentPage = 0;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = response.message ?? '加载回复失败';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '网络错误: $e';
      });
    }
  }

  /// 刷新回复列表
  ///
  /// 下拉刷新时调用，重新加载第一页数据
  Future<void> _refreshReplies() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
      _errorMessage = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityReplies(
        username: widget.username,
        page: 0,
      );

      if (response.status == 1 || response.status == 200) {
        setState(() {
          _replies = response.data;
          _isRefreshing = false;
          _hasMore = response.data.length >= 20;
          _currentPage = 0;
        });
      } else {
        setState(() {
          _isRefreshing = false;
          _errorMessage = response.message ?? '刷新回复失败';
        });
      }
    } catch (e) {
      setState(() {
        _isRefreshing = false;
        _errorMessage = '网络错误: $e';
      });
    }
  }

  /// 加载更多回复
  ///
  /// 当用户滚动到底部时调用，加载下一页数据
  Future<void> _loadMoreReplies() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final nextPage = _currentPage + 1;
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityReplies(
        username: widget.username,
        page: nextPage,
      );

      if (response.status == 1 || response.status == 200) {
        final newReplies = response.data;

        if (newReplies.isEmpty) {
          setState(() {
            _isLoading = false;
            _hasMore = false;
          });
        } else {
          setState(() {
            _replies = [..._replies, ...newReplies];
            _isLoading = false;
            _currentPage = nextPage;
            _hasMore = newReplies.length >= 20;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = response.message ?? '加载更多回复失败';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '网络错误: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('回复'),
      ),
      body: _buildBody(),
    );
  }

  /// 构建页面主体内容
  ///
  /// 根据当前状态显示加载中、错误、空状态或列表内容
  Widget _buildBody() {
    if (_isLoading && _replies.isEmpty) {
      return const _StateView(
        icon: Icons.forum,
        title: '正在加载回复',
        message: '正在从 forum.trae.cn 拉取用户回复数据…',
        loading: true,
      );
    }

    if (_errorMessage != null && _replies.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadReplies,
      );
    }

    if (_replies.isEmpty) {
      return const _StateView(
        icon: Icons.forum_outlined,
        title: '暂无回复',
        message: '该用户还没有发表过回复。',
      );
    }

    return RefreshIndicator(
      onRefresh: _refreshReplies,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _replies.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _replies.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final reply = _replies[index];
          return _ReplyCard(reply: reply);
        },
      ),
    );
  }
}

/// 回复卡片组件
///
/// 展示单个回复的内容、所属话题标题和时间
class _ReplyCard extends StatelessWidget {
  final UserActivity reply;

  const _ReplyCard({required this.reply});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (reply.topicId > 0) {
            context.push(
              RoutePaths.feedDetail.replaceFirst(
                ':id',
                reply.topicId.toString(),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (reply.avatarTemplate != null)
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        _formatAvatarUrl(reply.avatarTemplate!),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          reply.username,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (reply.createdAt != null)
                          Text(
                            _formatTime(reply.createdAt!),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (reply.cooked != null && reply.cooked!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  _stripHtml(reply.cooked!),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              if (reply.topicSlug != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '话题 #${reply.topicSlug}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 格式化头像 URL
  ///
  /// [template] 头像模板地址，可能包含 {size} 占位符
  /// 返回完整的头像 URL
  String _formatAvatarUrl(String template) {
    if (template.startsWith('http')) {
      return template;
    }
    return 'https://forum.trae.cn${template.replaceAll('{size}', '60')}';
  }

  /// 格式化时间
  ///
  /// [isoTime] ISO 8601 格式的时间字符串
  /// 返回相对时间描述（如：2小时前、3天前）
  String _formatTime(String isoTime) {
    try {
      final dateTime = DateTime.parse(isoTime);
      final now = DateTime.now();
      final diff = now.difference(dateTime);

      if (diff.inDays > 0) {
        return '${diff.inDays} 天前';
      } else if (diff.inHours > 0) {
        return '${diff.inHours} 小时前';
      } else if (diff.inMinutes > 0) {
        return '${diff.inMinutes} 分钟前';
      } else {
        return '刚刚';
      }
    } catch (e) {
      return isoTime;
    }
  }

  /// 去除 HTML 标签
  ///
  /// [htmlString] 包含 HTML 标签的字符串
  /// 返回纯文本内容
  String _stripHtml(String htmlString) {
    return htmlString
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&amp;', '&')
        .trim();
  }
}

/// 状态视图组件
///
/// 用于展示加载中、错误、空状态等通用状态
class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final bool loading;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
    this.loading = false,
    this.actionLabel,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (loading)
              const CircularProgressIndicator()
            else
              Icon(icon, size: 56, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 16),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}
