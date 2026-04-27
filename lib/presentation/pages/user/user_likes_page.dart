import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户点赞页面
///
/// 展示用户点赞的内容列表，支持下拉刷新和加载更多
class UserLikesPage extends ConsumerStatefulWidget {
  /// 用户名（从路由参数获取）
  final String username;

  const UserLikesPage({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<UserLikesPage> createState() => _UserLikesPageState();
}

/// 页面状态类
class _UserLikesPageState extends ConsumerState<UserLikesPage> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  /// 点赞列表数据
  List<UserActivity> _likes = [];

  /// 是否正在加载中
  bool _isLoading = false;

  /// 是否正在刷新中
  bool _isRefreshing = false;

  /// 是否有更多数据
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
      onLoad: _loadMore,
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
      final response = await apiService.getUserActivityLikes(
        username: widget.username,
        page: 0,
      );

      if (response.status == 200) {
        setState(() {
          _likes = response.data;
          _hasMore = response.data.length >= AppConstants.pageSize;
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

  /// 下拉刷新
  Future<void> _onRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
      _errorMessage = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityLikes(
        username: widget.username,
        page: 0,
      );

      if (response.status == 200) {
        setState(() {
          _likes = response.data;
          _hasMore = response.data.length >= AppConstants.pageSize;
          _currentPage = 0;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? '刷新失败';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = '刷新失败: $e';
      });
    } finally {
      setState(() {
        _isRefreshing = false;
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
      final nextPage = _currentPage + 1;
      final response = await apiService.getUserActivityLikes(
        username: widget.username,
        page: nextPage,
      );

      if (response.status == 200) {
        setState(() {
          _likes.addAll(response.data);
          _hasMore = response.data.length >= AppConstants.pageSize;
          _currentPage = nextPage;
        });
      } else {
        setState(() {
          _hasMore = false;
        });
      }
    } catch (e) {
      setState(() {
        _hasMore = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('赞'),
      ),
      body: _buildBody(),
    );
  }

  /// 构建页面主体
  Widget _buildBody() {
    // 初始加载中
    if (_isLoading && _likes.isEmpty && _errorMessage == null) {
      return const _StateView(
        icon: Icons.favorite_border,
        title: '正在加载',
        message: '正在获取点赞列表...',
        loading: true,
      );
    }

    // 加载出错
    if (_errorMessage != null && _likes.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadData,
      );
    }

    // 空状态
    if (_likes.isEmpty) {
      return const _StateView(
        icon: Icons.favorite_border,
        title: '暂无点赞',
        message: '该用户还没有点赞任何内容。',
      );
    }

    // 列表内容
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _likes.length + (_hasMore || _isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _likes.length) {
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

          final activity = _likes[index];
          return _LikeCard(activity: activity);
        },
      ),
    );
  }
}

/// 点赞项卡片组件
///
/// 参考 user_profile_page.dart 中的 _ActivityCard 样式
class _LikeCard extends StatelessWidget {
  /// 用户活动数据
  final UserActivity activity;

  const _LikeCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (activity.topicId > 0) {
            context.push(
              RoutePaths.feedDetail.replaceFirst(
                ':id',
                activity.topicId.toString(),
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
              // 作者信息行
              Row(
                children: [
                  if (activity.avatarTemplate != null)
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        _formatAvatarUrl(activity.avatarTemplate!),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.username,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        if (activity.createdAt != null)
                          Text(
                            _formatTime(activity.createdAt!),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              // 内容区域
              if (activity.cooked != null && activity.cooked!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  _stripHtml(activity.cooked!),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
              // 话题标签
              if (activity.topicSlug != null) ...[
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
                    '话题 #${activity.topicSlug}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
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
  /// [template] 头像模板字符串
  /// 返回完整的头像 URL
  String _formatAvatarUrl(String template) {
    if (template.startsWith('http')) {
      return template;
    }
    return 'https://forum.trae.cn${template.replaceAll('{size}', '60')}';
  }

  /// 格式化时间
  ///
  /// [isoTime] ISO 格式的时间字符串
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
/// 用于展示加载中、空状态、错误状态等
class _StateView extends StatelessWidget {
  /// 图标
  final IconData icon;

  /// 标题
  final String title;

  /// 描述信息
  final String message;

  /// 是否显示加载指示器
  final bool loading;

  /// 操作按钮文本
  final String? actionLabel;

  /// 操作按钮回调
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
