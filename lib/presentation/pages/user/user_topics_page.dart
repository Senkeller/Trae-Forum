import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_service.dart';
import '../../../core/utils/relative_time_util.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户话题列表页面
///
/// 展示指定用户发布的所有话题，支持下拉刷新和加载更多
class UserTopicsPage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username）
  final String username;

  const UserTopicsPage({super.key, required this.username});

  @override
  ConsumerState<UserTopicsPage> createState() => _UserTopicsPageState();
}

class _UserTopicsPageState extends ConsumerState<UserTopicsPage> {
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  /// 话题列表数据
  List<UserActivity> _topics = [];

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
    _loadData();
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
        await _loadMore();
      },
    );
  }

  /// 加载初始数据
  Future<void> _loadData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityTopics(
        username: widget.username,
        offset: 0,
      );

      if (response.status == 200) {
        setState(() {
          _topics = response.data;
          _hasMore = response.data.length >= 30;
          _currentPage = 0;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? '加载失败';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '加载失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 加载更多数据
  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final nextOffset = (_currentPage + 1) * 30;
      final response = await apiService.getUserActivityTopics(
        username: widget.username,
        offset: nextOffset,
      );

      if (response.status == 200) {
        setState(() {
          _topics.addAll(response.data);
          _hasMore = response.data.length >= 30;
          _currentPage = _currentPage + 1;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? '加载更多失败';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '加载更多失败: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    await _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('话题')),
      body: _buildBody(),
    );
  }

  /// 构建页面主体内容
  Widget _buildBody() {
    // 初始加载中
    if (_isLoading && _topics.isEmpty) {
      return const _StateView(
        icon: Icons.forum,
        title: '正在加载话题',
        message: '请稍候…',
        loading: true,
      );
    }

    // 加载失败且没有数据
    if (_errorMessage != null && _topics.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadData,
      );
    }

    // 空状态
    if (_topics.isEmpty) {
      return const _StateView(
        icon: Icons.inbox,
        title: '暂无话题',
        message: '该用户还没有发布任何话题。',
      );
    }

    // 话题列表
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _topics.length + (_hasMore || _isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _topics.length) {
            final topic = _topics[index];
            return _TopicCard(topic: topic);
          } else {
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
        },
      ),
    );
  }
}

/// 话题卡片组件
///
/// 展示单个话题的标题、时间、回复数、浏览数等信息
class _TopicCard extends StatelessWidget {
  final UserActivity topic;

  const _TopicCard({required this.topic});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (topic.topicId > 0) {
            context.push('/feed/${topic.topicId}');
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题
              Text(
                topic.excerpt ?? '话题 #${topic.topicId}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 12),
              // 底部信息栏：时间、回复数、浏览数
              Row(
                children: [
                  // 时间
                  if (topic.createdAt != null) ...[
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatTime(topic.createdAt!),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                  ],
                  // 回复数
                  if (topic.replyCount != null) ...[
                    Icon(
                      Icons.comment_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.replyCount}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                  ],
                  // 浏览数
                  if (topic.reads != null) ...[
                    Icon(
                      Icons.visibility_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.reads}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const Spacer(),
                  // 点赞数
                  if (topic.likeCount != null && topic.likeCount! > 0) ...[
                    Icon(
                      Icons.thumb_up_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${topic.likeCount}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 格式化时间显示
  ///
  /// [isoTime] ISO 8601 格式的时间字符串
  /// 返回相对时间描述（如：2小时前、3天前）
  String _formatTime(String isoTime) {
    return RelativeTimeUtil.fromIso(isoTime);
  }
}

/// 状态视图组件
///
/// 用于展示加载中、空状态、错误状态等
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
