import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户已解决页面
///
/// 展示用户标记为已解决的内容列表，支持下拉刷新和加载更多
class UserSolvedPage extends ConsumerStatefulWidget {
  /// 用户名（从路由参数获取）
  final String username;

  /// 构造函数
  ///
  /// [username] 用户名（必填）
  const UserSolvedPage({
    super.key,
    required this.username,
  });

  @override
  ConsumerState<UserSolvedPage> createState() => _UserSolvedPageState();
}

/// 页面状态类
class _UserSolvedPageState extends ConsumerState<UserSolvedPage> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  /// 已解决列表数据
  List<UserActivity> _solvedList = [];

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
  ///
  /// 从 API 获取第一页已解决列表数据
  Future<void> _loadData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivitySolved(
        username: widget.username,
        offset: 0,
      );

      if (response.status == 200) {
        setState(() {
          _solvedList = response.data;
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
  ///
  /// 重新加载第一页数据，用于下拉刷新操作
  Future<void> _onRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
      _errorMessage = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivitySolved(
        username: widget.username,
        offset: 0,
      );

      if (response.status == 200) {
        setState(() {
          _solvedList = response.data;
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
  ///
  /// 加载下一页数据并追加到列表中
  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final nextOffset = (_currentPage + 1) * AppConstants.pageSize;
      final response = await apiService.getUserActivitySolved(
        username: widget.username,
        offset: nextOffset,
      );

      if (response.status == 200) {
        setState(() {
          _solvedList.addAll(response.data);
          _hasMore = response.data.length >= AppConstants.pageSize;
          _currentPage = _currentPage + 1;
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
        title: const Text('已解决'),
      ),
      body: _buildBody(),
    );
  }

  /// 构建页面主体
  ///
  /// 根据当前状态返回不同的视图：加载中、错误、空状态或列表
  Widget _buildBody() {
    // 初始加载中
    if (_isLoading && _solvedList.isEmpty && _errorMessage == null) {
      return const _StateView(
        icon: Icons.check_circle_outline,
        title: '正在加载',
        message: '正在获取已解决列表...',
        loading: true,
      );
    }

    // 加载出错
    if (_errorMessage != null && _solvedList.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadData,
      );
    }

    // 空状态
    if (_solvedList.isEmpty) {
      return const _StateView(
        icon: Icons.check_circle_outline,
        title: '暂无已解决',
        message: '该用户还没有标记任何内容为已解决。',
      );
    }

    // 列表内容
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _solvedList.length + (_hasMore || _isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _solvedList.length) {
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

          final activity = _solvedList[index];
          return _SolvedCard(activity: activity);
        },
      ),
    );
  }
}

/// 已解决项卡片组件
///
/// 参考 user_profile_page.dart 中的 _ActivityCard 样式
/// 显示话题标题、解决时间、勾选标记
class _SolvedCard extends StatelessWidget {
  /// 用户活动数据
  final UserActivity activity;

  /// 构造函数
  ///
  /// [activity] 用户活动数据（必填）
  const _SolvedCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

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
              // 标题行：勾选标记 + 话题标题
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 勾选标记
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 话题标题
                  Expanded(
                    child: Text(
                      activity.topicSlug != null
                          ? '话题 #${activity.topicSlug}'
                          : '话题 #${activity.topicId}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
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
              // 底部信息：作者和解决时间
              const SizedBox(height: 12),
              Row(
                children: [
                  if (activity.avatarTemplate != null)
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(
                        _formatAvatarUrl(activity.avatarTemplate!),
                      ),
                    ),
                  if (activity.avatarTemplate != null)
                    const SizedBox(width: 8),
                  Text(
                    activity.username,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const Spacer(),
                  if (activity.createdAt != null)
                    Text(
                      _formatTime(activity.createdAt!),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                ],
              ),
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

  /// 构造函数
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
