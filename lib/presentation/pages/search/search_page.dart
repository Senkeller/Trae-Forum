import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/constants.dart';
import '../../../config/theme.dart';

/// 搜索页面
///
/// 提供搜索功能，包括搜索建议、热门搜索、搜索历史等
/// 支持多种搜索类型：全部、动态、用户、话题、应用、数码
class SearchPage extends ConsumerStatefulWidget {
  /// 构造函数
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

/// 搜索页面状态
class _SearchPageState extends ConsumerState<SearchPage>
    with SingleTickerProviderStateMixin {
  /// 搜索控制器
  final TextEditingController _searchController = TextEditingController();

  /// 焦点节点
  final FocusNode _focusNode = FocusNode();

  /// Tab 控制器
  late TabController _tabController;

  /// 当前搜索类型
  SearchType _currentSearchType = SearchType.all;

  /// 是否正在搜索
  bool _isSearching = false;

  /// 搜索历史
  final List<String> _searchHistory = [
    'Flutter',
    'Dart',
    '移动开发',
    'Riverpod',
  ];

  /// 热门搜索
  final List<String> _hotSearches = [
    'Flutter 3.0',
    'Dart 3',
    'Material Design 3',
    'iOS 开发',
    'Android 开发',
    '跨平台开发',
    '状态管理',
    '性能优化',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: SearchType.values.length,
      vsync: this,
    );
    // 自动聚焦搜索框
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    _tabController.dispose();
    super.dispose();
  }

  /// 执行搜索
  ///
  /// [query] 搜索关键词
  void _performSearch(String query) {
    if (query.isEmpty) return;

    // 添加到搜索历史
    if (!_searchHistory.contains(query)) {
      setState(() {
        _searchHistory.insert(0, query);
      });
    }

    // 跳转到搜索结果页
    context.push('${RoutePaths.searchResult}?q=$query');
  }

  /// 清除搜索历史
  void _clearHistory() {
    setState(() {
      _searchHistory.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: _performSearch,
          decoration: InputDecoration(
            hintText: '搜索感兴趣的内容',
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {});
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _performSearch(_searchController.text);
            },
            child: const Text('搜索'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: SearchType.values
              .map((type) => Tab(text: type.label))
              .toList(),
          onTap: (index) {
            setState(() {
              _currentSearchType = SearchType.values[index];
            });
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: SearchType.values.map((type) {
          return _SearchContent(
            searchHistory: _searchHistory,
            hotSearches: _hotSearches,
            onHistoryTap: (query) {
              _searchController.text = query;
              _performSearch(query);
            },
            onHotSearchTap: (query) {
              _searchController.text = query;
              _performSearch(query);
            },
            onClearHistory: _clearHistory,
          );
        }).toList(),
      ),
    );
  }
}

/// 搜索内容组件
///
/// 展示搜索历史和热门搜索
class _SearchContent extends StatelessWidget {
  /// 搜索历史
  final List<String> searchHistory;

  /// 热门搜索
  final List<String> hotSearches;

  /// 历史点击回调
  final ValueChanged<String> onHistoryTap;

  /// 热门搜索点击回调
  final ValueChanged<String> onHotSearchTap;

  /// 清除历史回调
  final VoidCallback onClearHistory;

  /// 构造函数
  const _SearchContent({
    required this.searchHistory,
    required this.hotSearches,
    required this.onHistoryTap,
    required this.onHotSearchTap,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 搜索历史
          if (searchHistory.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '搜索历史',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton.icon(
                  onPressed: onClearHistory,
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text('清除'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: searchHistory.map((query) {
                return ActionChip(
                  avatar: const Icon(Icons.history, size: 16),
                  label: Text(query),
                  onPressed: () => onHistoryTap(query),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
          ],

          // 热门搜索
          Text(
            '热门搜索',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...hotSearches.asMap().entries.map((entry) {
            final index = entry.key;
            final query = entry.value;
            return _HotSearchItem(
              rank: index + 1,
              query: query,
              onTap: () => onHotSearchTap(query),
            );
          }),

          // 推荐话题
          const SizedBox(height: 24),
          Text(
            '推荐话题',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              'Flutter',
              'Dart',
              '移动开发',
              'UI设计',
              '性能优化',
              '开源项目',
              '技术分享',
              '求职招聘',
            ].map((topic) {
              return FilterChip(
                label: Text('#$topic'),
                onSelected: (_) => onHotSearchTap(topic),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

/// 热门搜索项
///
/// 单个热门搜索的展示项
class _HotSearchItem extends StatelessWidget {
  /// 排名
  final int rank;

  /// 搜索词
  final String query;

  /// 点击回调
  final VoidCallback onTap;

  /// 构造函数
  const _HotSearchItem({
    required this.rank,
    required this.query,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // 根据排名设置颜色
    Color rankColor;
    if (rank == 1) {
      rankColor = AppTheme.hotSearchFirstColor;
    } else if (rank == 2) {
      rankColor = AppTheme.hotSearchSecondColor;
    } else if (rank == 3) {
      rankColor = AppTheme.hotSearchThirdColor;
    } else {
      rankColor = colorScheme.onSurfaceVariant;
    }

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            SizedBox(
              width: 28,
              child: Text(
                '$rank',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: rankColor,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                query,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            if (rank <= 3)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: rankColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '热',
                  style: TextStyle(
                    fontSize: 10,
                    color: rankColor,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
