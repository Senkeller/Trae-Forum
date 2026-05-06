import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_service.dart';
import '../../../core/utils/html_text_util.dart';
import '../../../core/utils/relative_time_util.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户已读内容页面
///
/// 展示指定用户已阅读的所有话题，支持下拉刷新和加载更多
class UserReadPage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username）
  final String username;

  const UserReadPage({super.key, required this.username});

  @override
  ConsumerState<UserReadPage> createState() => _UserReadPageState();
}

class _UserReadPageState extends ConsumerState<UserReadPage> {
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  /// 已读列表数据
  List<UserActivity> _readItems = [];

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
      final response = await apiService.getUserActivity(
        username: widget.username,
        page: 0,
      );

      if (response.status == 200) {
        setState(() {
          _readItems = response.data;
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
      final nextPage = _currentPage + 1;
      final response = await apiService.getUserActivity(
        username: widget.username,
        page: nextPage,
      );

      if (response.status == 200) {
        setState(() {
          _readItems.addAll(response.data);
          _hasMore = response.data.length >= 30;
          _currentPage = nextPage;
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
      appBar: AppBar(title: const Text('已读')),
      body: _buildBody(),
    );
  }

  /// 构建页面主体内容
  Widget _buildBody() {
    // 初始加载中
    if (_isLoading && _readItems.isEmpty) {
      return const _StateView(
        icon: Icons.menu_book,
        title: '正在加载已读内容',
        message: '请稍候…',
        loading: true,
      );
    }

    // 加载失败且没有数据
    if (_errorMessage != null && _readItems.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadData,
      );
    }

    // 空状态
    if (_readItems.isEmpty) {
      return const _StateView(
        icon: Icons.menu_book_outlined,
        title: '暂无已读内容',
        message: '该用户还没有阅读记录。',
      );
    }

    // 已读列表
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _readItems.length + (_hasMore || _isLoading ? 1 : 0),
        cacheExtent: 200,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          if (index < _readItems.length) {
            final item = _readItems[index];
            return _ReadItemCard(item: item);
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

/// 已读项卡片组件
///
/// 展示单个已读话题的标题、阅读时间等信息
class _ReadItemCard extends StatelessWidget {
  final UserActivity item;

  const _ReadItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (item.topicId > 0) {
            context.push('/feed/${item.topicId}');
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 用户信息行
              Row(
                children: [
                  if (item.avatarTemplate != null)
                    CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                        _formatAvatarUrl(item.avatarTemplate!),
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.username,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        if (item.createdAt != null)
                          Text(
                            RelativeTimeUtil.fromIso(item.createdAt!),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // 话题标题
              if (item.excerpt != null && item.excerpt!.isNotEmpty)
                Text(
                  item.excerpt!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                )
              else if (item.cooked != null && item.cooked!.isNotEmpty)
                Text(
                  HtmlTextUtil.stripHtml(item.cooked!),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                )
              else
                Text(
                  '话题 #${item.topicId}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                ),
              const SizedBox(height: 12),
              // 底部信息栏
              Row(
                children: [
                  // 阅读时间
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.createdAt != null
                        ? RelativeTimeUtil.fromIso(item.createdAt!)
                        : '未知时间',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  // 回复数
                  if (item.replyCount != null) ...[
                    Icon(
                      Icons.comment_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${item.replyCount}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(width: 16),
                  ],
                  // 浏览数
                  if (item.reads != null) ...[
                    Icon(
                      Icons.visibility_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${item.reads}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                  const Spacer(),
                  // 点赞数
                  if (item.likeCount != null && item.likeCount! > 0) ...[
                    Icon(
                      Icons.thumb_up_outlined,
                      size: 14,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${item.likeCount}',
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
