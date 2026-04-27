import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户投票页面
///
/// 展示指定用户的投票记录列表
class UserVotesPage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username）
  final String username;

  const UserVotesPage({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<UserVotesPage> createState() => _UserVotesPageState();
}

class _UserVotesPageState extends ConsumerState<UserVotesPage> {
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  /// 投票列表数据
  List<UserActivity> _votes = [];

  /// 是否正在加载数据
  bool _isLoading = false;

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
    _loadVotes(refresh: true);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多数据。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _onScroll() {
    if (_isLoading || !_hasMore) return;

    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        await _loadVotes();
      },
    );
  }

  /// 加载用户投票数据
  ///
  /// [refresh] 是否为刷新操作，true 则重置页码和数据
  Future<void> _loadVotes({bool refresh = false}) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      if (refresh) {
        _errorMessage = null;
      }
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityVotes(
        username: widget.username,
      );

      if (response.status == 200) {
        final newVotes = response.data;

        setState(() {
          if (refresh) {
            _votes = newVotes;
            _currentPage = 1;
          } else {
            _votes.addAll(newVotes);
            _currentPage++;
          }
          _hasMore = newVotes.length >= AppConstants.pageSize;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? '加载失败';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '加载失败: $e';
        _isLoading = false;
      });
    }
  }

  /// 处理下拉刷新
  Future<void> _onRefresh() async {
    await _loadVotes(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('投票'),
      ),
      body: _buildBody(),
    );
  }

  /// 构建页面主体内容
  Widget _buildBody() {
    // 初始加载状态
    if (_isLoading && _votes.isEmpty) {
      return const _StateView(
        icon: Icons.how_to_vote,
        title: '正在加载投票',
        message: '正在从 forum.trae.cn 拉取投票数据…',
        loading: true,
      );
    }

    // 错误状态
    if (_errorMessage != null && _votes.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: () => _loadVotes(refresh: true),
      );
    }

    // 空状态
    if (_votes.isEmpty) {
      return const _StateView(
        icon: Icons.how_to_vote_outlined,
        title: '暂无投票',
        message: '该用户还没有投票记录。',
      );
    }

    // 列表内容
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _votes.length + (_hasMore || _isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _votes.length) {
            // 底部加载指示器
            if (_isLoading) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (!_hasMore) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Center(child: Text('没有更多内容了')),
              );
            }
            return const SizedBox.shrink();
          }

          final vote = _votes[index];
          return _VoteCard(vote: vote);
        },
      ),
    );
  }
}

/// 投票卡片组件
///
/// 展示单个投票记录的卡片，参考 _ActivityCard 样式
class _VoteCard extends StatelessWidget {
  final UserActivity vote;

  const _VoteCard({required this.vote});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (vote.topicId > 0) {
            context.push(
              RoutePaths.feedDetail.replaceFirst(
                ':id',
                vote.topicId.toString(),
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.how_to_vote,
                      size: 20,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '参与了投票',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                        if (vote.createdAt != null)
                          Text(
                            _formatTime(vote.createdAt!),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: colorScheme.onSurfaceVariant,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (vote.topicSlug != null) ...[
                Text(
                  vote.topicSlug!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
              if (vote.excerpt != null && vote.excerpt!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  _stripHtml(vote.excerpt!),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 格式化时间显示
  ///
  /// [isoTime] ISO 8601 格式的时间字符串
  /// 返回相对时间描述（如 "2 小时前"、"3 天前"）
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
/// 用于展示加载中、错误、空状态等统一状态视图
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
