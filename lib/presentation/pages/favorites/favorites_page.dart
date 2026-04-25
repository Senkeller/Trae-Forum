import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../config/constants.dart';
import '../../../core/utils/date_util.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../../data/repositories/bookmark_repository.dart';
import '../../providers/auth_provider.dart';

enum _FavoritesSortType {
  bookmarkedAt,
  lastActive,
}

class FavoritesPage extends ConsumerStatefulWidget {
  const FavoritesPage({super.key});

  @override
  ConsumerState<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends ConsumerState<FavoritesPage> {
  final RefreshController _refreshController = RefreshController();

  List<BookmarkTopicItem> _favoritesList = [];
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _errorMessage;
  int _currentPage = 0;
  _FavoritesSortType _sortType = _FavoritesSortType.bookmarkedAt;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  Future<void> _loadFavorites() async {
    final currentUser = ref.read(currentUserProvider);
    if (currentUser == null || currentUser.uid.isEmpty) {
      setState(() {
        _errorMessage = '请先登录';
        _favoritesList = [];
        _hasMore = false;
      });
      return;
    }

    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final repository = ref.read(bookmarkRepositoryProvider);
      final result = await repository.getBookmarkedTopics(page: 0);

      setState(() {
        _currentPage = 0;
        _favoritesList = result.items;
        _hasMore = result.hasMore;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '加载失败: $e';
      });
    }
  }

  Future<void> _onRefresh() async {
    try {
      await _loadFavorites();
      _refreshController.refreshCompleted();
    } catch (_) {
      _refreshController.refreshFailed();
    }
  }

  Future<void> _onLoading() async {
    if (_isLoadingMore || !_hasMore) {
      _refreshController.loadComplete();
      return;
    }

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final repository = ref.read(bookmarkRepositoryProvider);
      final result = await repository.getBookmarkedTopics(page: nextPage);
      final existing = _favoritesList.map((item) => item.topicId).toSet();
      final newItems = result.items
          .where((item) => !existing.contains(item.topicId))
          .toList();

      setState(() {
        _currentPage = nextPage;
        _favoritesList = [..._favoritesList, ...newItems];
        _hasMore = result.hasMore;
        _isLoadingMore = false;
      });

      _refreshController.loadComplete();
    } catch (e) {
      setState(() {
        _isLoadingMore = false;
      });
      _refreshController.loadFailed();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('加载更多失败: $e')));
      }
    }
  }

  Future<void> _removeFavorite(BookmarkTopicItem item) async {
    if (item.bookmarkId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('未找到书签ID，刷新后再试')));
      return;
    }

    final repository = ref.read(bookmarkRepositoryProvider);
    final result = await repository.deleteBookmark(item.bookmarkId!);
    if (!mounted) {
      return;
    }

    if (result.success) {
      setState(() {
        _favoritesList.removeWhere((it) => it.topicId == item.topicId);
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('已取消收藏')));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result.errorMessage ?? '取消收藏失败')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserProvider);
    final isLoggedIn = currentUser != null && currentUser.uid.isNotEmpty;

    if (!isLoggedIn) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('我的收藏'),
        ),
        body: _StateView(
          icon: Icons.account_circle_outlined,
          title: '未登录',
          message: '登录后可查看收藏',
          actionLabel: '去登录',
          onAction: () => context.push(RoutePaths.login),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的收藏'),
        actions: [
          PopupMenuButton<_FavoritesSortType>(
            initialValue: _sortType,
            onSelected: (value) {
              setState(() {
                _sortType = value;
              });
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _FavoritesSortType.bookmarkedAt,
                child: Text('最近收藏'),
              ),
              PopupMenuItem(
                value: _FavoritesSortType.lastActive,
                child: Text('最近活跃'),
              ),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Text(
                    _sortType == _FavoritesSortType.bookmarkedAt
                        ? '最近收藏'
                        : '最近活跃',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.swap_vert, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading && _favoritesList.isEmpty) {
      return const _FavoritesSkeletonList();
    }

    if (_errorMessage != null && _favoritesList.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadFavorites,
      );
    }

    if (_favoritesList.isEmpty) {
      return _StateView(
        icon: Icons.bookmark_outline,
        title: '暂无收藏',
        message: '你还没有收藏任何话题',
      );
    }

    final displayList = _sortedFavorites();

    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: _hasMore,
      onRefresh: _onRefresh,
      onLoading: _hasMore ? _onLoading : null,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: displayList.length,
        itemBuilder: (context, index) {
          final item = displayList[index];
          return _FavoriteCard(
            item: item,
            onTap: () {
              context.push(
                RoutePaths.feedDetail.replaceFirst(':id', item.topicId.toString()),
              );
            },
            onRemove: () => _removeFavorite(item),
          );
        },
      ),
    );
  }

  List<BookmarkTopicItem> _sortedFavorites() {
    final list = List<BookmarkTopicItem>.from(_favoritesList);
    list.sort((a, b) {
      final aTime = _parseSortTime(
        _sortType == _FavoritesSortType.bookmarkedAt
            ? (a.bookmarkedAt ?? a.createdAt)
            : (a.lastPostedAt ?? a.createdAt),
      );
      final bTime = _parseSortTime(
        _sortType == _FavoritesSortType.bookmarkedAt
            ? (b.bookmarkedAt ?? b.createdAt)
            : (b.lastPostedAt ?? b.createdAt),
      );
      return bTime.compareTo(aTime);
    });
    return list;
  }

  int _parseSortTime(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return 0;
    }
    final text = raw.trim();
    final iso = DateUtil.parseIso(text);
    if (iso != null) {
      return iso.millisecondsSinceEpoch;
    }
    final seconds = int.tryParse(text);
    if (seconds != null && seconds > 0) {
      return seconds * 1000;
    }
    return 0;
  }
}

class _FavoriteCard extends StatelessWidget {
  final BookmarkTopicItem item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteCard({
    required this.item,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final title = item.title.trim().isEmpty ? '未命名话题' : item.title.trim();
    final username = (item.username?.trim().isNotEmpty ?? false)
        ? item.username!.trim()
        : '匿名用户';
    final time = _formatDisplayTime(item.createdAt);
    final avatarUrl = DiscourseImageUrlResolver.resolveAvatarUrl(
      item.avatarTemplate ?? '',
      size: 72,
    );
    final avatarUrlValue = avatarUrl ?? '';
    final hasAvatar = avatarUrlValue.isNotEmpty;
    final excerpt = item.excerpt;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: hasAvatar
                        ? NetworkImage(avatarUrlValue)
                        : null,
                    child: !hasAvatar
                        ? const Icon(Icons.person, size: 18)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          time,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.bookmark,
                      color: colorScheme.primary,
                    ),
                    onPressed: onRemove,
                    tooltip: '取消收藏',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (excerpt.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  excerpt,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_outlined,
                    size: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${item.likeCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.comment_outlined,
                    size: 14,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${item.replyCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDisplayTime(String? createdAt) {
    if (createdAt == null || createdAt.trim().isEmpty) {
      return '未知时间';
    }

    final parsedIso = DateUtil.parseIso(createdAt.trim());
    if (parsedIso != null) {
      return DateUtil.getRelativeTime(parsedIso.toLocal());
    }

    final seconds = int.tryParse(createdAt.trim());
    if (seconds != null && seconds > 0) {
      return DateUtil.getRelativeTimeFromTimestampSeconds(seconds);
    }

    return createdAt.trim();
  }
}

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

class _FavoritesSkeletonList extends StatelessWidget {
  const _FavoritesSkeletonList();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: 6,
      itemBuilder: (context, index) => const _FavoriteSkeletonCard(),
    );
  }
}

class _FavoriteSkeletonCard extends StatelessWidget {
  const _FavoriteSkeletonCard();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _SkeletonBox(width: 36, height: 36, radius: 18, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SkeletonBox(width: 120, height: 12, radius: 6, color: color),
                      const SizedBox(height: 8),
                      _SkeletonBox(width: 80, height: 10, radius: 5, color: color),
                    ],
                  ),
                ),
                _SkeletonBox(width: 24, height: 24, radius: 6, color: color),
              ],
            ),
            const SizedBox(height: 14),
            _SkeletonBox(width: double.infinity, height: 14, radius: 7, color: color),
            const SizedBox(height: 8),
            _SkeletonBox(width: 220, height: 12, radius: 6, color: color),
            const SizedBox(height: 12),
            Row(
              children: [
                _SkeletonBox(width: 52, height: 10, radius: 5, color: color),
                const SizedBox(width: 16),
                _SkeletonBox(width: 52, height: 10, radius: 5, color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final Color color;

  const _SkeletonBox({
    required this.width,
    required this.height,
    required this.radius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
