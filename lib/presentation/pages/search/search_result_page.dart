import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../providers/search_provider.dart';
import '../../widgets/home/pinned_topics_banner.dart';
import '../../widgets/user/user_avatar.dart';

/// 搜索结果页面
///
/// 显示指定关键词的搜索结果列表，支持下拉刷新和上拉加载更多
class SearchResultPage extends ConsumerStatefulWidget {
  final String query;

  const SearchResultPage({super.key, required this.query});

  @override
  ConsumerState<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends ConsumerState<SearchResultPage> {
  final RefreshController _refreshController = RefreshController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // 页面初始化时执行搜索
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _performSearch();
    });
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 执行搜索
  void _performSearch() {
    ref.read(searchNotifierProvider.notifier).search(widget.query);
  }

  /// 下拉刷新
  Future<void> _onRefresh() async {
    await ref.read(searchNotifierProvider.notifier).search(widget.query);
    _refreshController.refreshCompleted();
  }

  /// 上拉加载更多
  Future<void> _onLoading() async {
    await ref.read(searchNotifierProvider.notifier).loadMore();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('搜索: ${widget.query}')),
      body: _buildBody(searchState),
    );
  }

  /// 构建页面主体内容
  Widget _buildBody(SearchState state) {
    // 首次加载中
    if (state.isSearching && state.results.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // 搜索出错且没有结果
    if (state.errorMessage != null && state.results.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '搜索失败',
        message: state.errorMessage!,
        actionLabel: '重试',
        onAction: _performSearch,
      );
    }

    // 没有搜索结果
    if (state.results.isEmpty) {
      return _StateView(
        icon: Icons.search_off,
        title: '没有搜索结果',
        message: '试试其他关键词',
      );
    }

    // 显示搜索结果列表
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: state.hasMore,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: state.results.length + 1,
        cacheExtent: 200,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const PinnedTopicsBanner();
          }

          final result = state.results[index - 1];
          return _ResultCard(
            result: result,
            onTap: () {
              final topicId = result.extra?['topicId']?.toString() ?? '';
              if (topicId.isNotEmpty) {
                context.push(
                  RoutePaths.feedDetail.replaceFirst(':id', topicId),
                );
              }
            },
          );
        },
      ),
    );
  }
}

/// 搜索结果卡片
class _ResultCard extends StatelessWidget {
  final SearchResult result;
  final VoidCallback onTap;

  const _ResultCard({required this.result, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = result.title;
    final description = result.description ?? '';
    final username = result.extra?['username']?.toString() ?? '';
    final avatarUrl = result.extra?['avatarUrl']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserAvatar(
                avatarUrl: avatarUrl.isNotEmpty ? avatarUrl : null,
                size: 44,
                memCacheWidth: 100,
                memCacheHeight: 100,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      username.isNotEmpty ? '@$username' : '',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

/// 状态视图组件
///
/// 用于显示空状态、错误状态等
class _StateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  const _StateView({
    required this.icon,
    required this.title,
    required this.message,
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
