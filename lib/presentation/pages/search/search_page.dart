import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/utils/scroll_load_guard.dart';
import '../../providers/search_provider.dart' as sp;
import 'widgets/hot_search_section.dart';
import 'widgets/ranking_section.dart';

/// 搜索建议数据模型
class SearchSuggestion {
  final String keyword;
  final String? subtitle;
  final IconData icon;

  const SearchSuggestion({
    required this.keyword,
    this.subtitle,
    required this.icon,
  });
}

/// 搜索页面
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理搜索结果列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: sp.SearchType.values.length, vsync: this);
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      // 加载热门搜索和榜单数据
      ref.read(sp.searchNotifierProvider.notifier).loadHotSearches();
      ref.read(sp.searchNotifierProvider.notifier).loadRankingTopics();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多搜索结果。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _onScroll() {
    final state = ref.read(sp.searchNotifierProvider);
    if (state.isSearching || state.isLoadingMore || !state.hasMore || state.results.isEmpty) {
      return;
    }

    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        ref.read(sp.searchNotifierProvider.notifier).loadMore();
      },
    );
  }

  void _performSearch(String query) {
    final keyword = query.trim();
    if (keyword.isEmpty) return;

    _searchController.text = keyword;
    _focusNode.unfocus();
    ref.read(sp.searchNotifierProvider.notifier).search(keyword);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(sp.searchNotifierProvider);

    if (_searchController.text != searchState.keyword &&
        searchState.keyword.isNotEmpty &&
        !_focusNode.hasFocus) {
      _searchController.text = searchState.keyword;
    }

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: _performSearch,
          onChanged: (_) => setState(() {}),
          decoration: InputDecoration(
            hintText: '搜索 forum.trae.cn 话题',
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      ref.read(sp.searchNotifierProvider.notifier).clearResults();
                      setState(() {});
                    },
                  )
                : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => _performSearch(_searchController.text),
            child: const Text('搜索'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: sp.SearchType.values
              .map((type) => Tab(text: type.displayName))
              .toList(),
          onTap: (index) {
            final type = sp.SearchType.values[index];
            final notifier = ref.read(sp.searchNotifierProvider.notifier);
            notifier.setSearchType(type);

            final keyword = _searchController.text.trim();
            if (keyword.isNotEmpty) {
              notifier.search(keyword);
            }
          },
        ),
      ),
      body: _SearchBody(
        state: searchState,
        scrollController: _scrollController,
        onRetry: () => _performSearch(searchState.keyword),
        onSearch: _performSearch,
        onHistoryTap: (keyword) {
          _searchController.text = keyword;
          _performSearch(keyword);
        },
        onDeleteHistoryItem: (keyword) {
          ref.read(sp.searchNotifierProvider.notifier).removeFromHistory(keyword);
        },
        onClearHistory: () {
          ref.read(sp.searchNotifierProvider.notifier).clearHistory();
        },
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  final sp.SearchState state;
  final ScrollController scrollController;
  final VoidCallback onRetry;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onHistoryTap;
  final ValueChanged<String> onDeleteHistoryItem;
  final VoidCallback onClearHistory;

  const _SearchBody({
    required this.state,
    required this.scrollController,
    required this.onRetry,
    required this.onSearch,
    required this.onHistoryTap,
    required this.onDeleteHistoryItem,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    if (state.isSearching && state.results.isEmpty) {
      return const _StateView(
        icon: Icons.search,
        title: '正在搜索',
        message: '正在从 forum.trae.cn 拉取结果…',
        loading: true,
      );
    }

    if (state.errorMessage != null && state.results.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '搜索失败',
        message: state.errorMessage!,
        actionLabel: '重试',
        onAction: onRetry,
      );
    }

    if (state.keyword.trim().isNotEmpty && state.results.isEmpty) {
      return const _StateView(
        icon: Icons.search_off,
        title: '没有搜索结果',
        message: '试试更短关键词或换一个分类',
      );
    }

    if (state.results.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async => onSearch(state.keyword),
        child: ListView.builder(
          controller: scrollController,
          itemCount: state.results.length + 1,
          itemBuilder: (context, index) {
            if (index == state.results.length) {
              if (state.isLoadingMore) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (!state.hasMore) {
                return const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: Text('没有更多结果了')),
                );
              }

              return const SizedBox.shrink();
            }

            final result = state.results[index];
            final topicId = (result.extra?['topicId'] ?? result.id).toString();
            final username = (result.extra?['username'] ?? '').toString();
            final avatarUrl = (result.extra?['avatarUrl'] ?? '').toString();
            final replyCount = result.extra?['replyCount'];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                onTap: topicId.isEmpty
                    ? null
                    : () {
                        context.push(
                          RoutePaths.feedDetail.replaceFirst(':id', topicId),
                        );
                      },
                leading: CircleAvatar(
                  backgroundImage: avatarUrl.isNotEmpty
                      ? NetworkImage(avatarUrl)
                      : null,
                  child: avatarUrl.isEmpty ? const Icon(Icons.person) : null,
                ),
                title: Text(
                  result.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if ((result.description ?? '').isNotEmpty)
                      Text(
                        result.description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    Text(
                      '话题 #$topicId${username.isNotEmpty ? ' · @$username' : ''}${replyCount != null ? ' · 回复 $replyCount' : ''}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
            );
          },
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 搜索历史
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '搜索历史',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (state.searchHistory.isNotEmpty)
                InkWell(
                  onTap: onClearHistory,
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.delete_outline,
                      size: 18,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (state.searchHistory.isEmpty)
            Text(
              '暂无搜索历史',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            )
          else
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: state.searchHistory.map((keyword) {
                return ActionChip(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  avatar: const Icon(Icons.history, size: 14),
                  label: Text(
                    keyword,
                    style: const TextStyle(fontSize: 12),
                  ),
                  onPressed: () => onHistoryTap(keyword),
                );
              }).toList(),
            ),
          const SizedBox(height: 16),
          // 热门搜索
          HotSearchSection(
            onSearch: onSearch,
          ),
          const SizedBox(height: 16),
          // 榜单区域
          const RankingSection(),
        ],
      ),
    );
  }
}

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
              FilledButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
