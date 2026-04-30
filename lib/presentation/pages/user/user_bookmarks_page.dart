import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../core/network/discourse_api_service.dart';
import '../../../core/utils/html_text_util.dart';
import '../../../core/utils/relative_time_util.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户书签页面
///
/// 展示用户的书签内容列表，支持下拉刷新和加载更多
class UserBookmarksPage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username）
  final String username;

  const UserBookmarksPage({super.key, required this.username});

  @override
  ConsumerState<UserBookmarksPage> createState() => _UserBookmarksPageState();
}

class _UserBookmarksPageState extends ConsumerState<UserBookmarksPage> {
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理书签列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  List<UserBookmark> _bookmarks = [];
  bool _isLoading = false;
  bool _isRefreshing = false;
  bool _hasMore = true;
  String? _errorMessage;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadBookmarks();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  /// 处理滚动事件，使用 ScrollLoadGuard 管理触底加载逻辑
  ///
  /// 当用户滚动到列表底部附近时，触发加载更多书签。
  /// 使用 ScrollLoadGuard 防止重复触发和并发请求。
  void _onScroll() {
    if (_isLoading || !_hasMore) return;

    _scrollLoadGuard.tryTrigger(
      scrollController: _scrollController,
      onLoad: () async {
        await _loadMoreBookmarks();
      },
    );
  }

  /// 加载书签列表
  ///
  /// 从服务器获取用户的书签数据，初始化或刷新时使用
  Future<void> _loadBookmarks() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _currentPage = 0;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityBookmarks(
        username: widget.username,
      );

      if (response.status == 1 || response.status == 200) {
        setState(() {
          _bookmarks = response.data.cast<UserBookmark>();
          _isLoading = false;
          _hasMore = response.data.length >= 20;
          _currentPage = 0;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = response.message ?? '加载书签失败';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = '网络错误: $e';
      });
    }
  }

  /// 刷新书签列表
  ///
  /// 下拉刷新时调用，重置页码并重新加载数据
  Future<void> _refreshBookmarks() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
      _errorMessage = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityBookmarks(
        username: widget.username,
      );

      if (response.status == 1 || response.status == 200) {
        setState(() {
          _bookmarks = response.data.cast<UserBookmark>();
          _isRefreshing = false;
          _hasMore = response.data.length >= 20;
          _currentPage = 0;
        });
      } else {
        setState(() {
          _isRefreshing = false;
          _errorMessage = response.message ?? '刷新书签失败';
        });
      }
    } catch (e) {
      setState(() {
        _isRefreshing = false;
        _errorMessage = '网络错误: $e';
      });
    }
  }

  /// 加载更多书签
  ///
  /// 滚动到底部时调用，加载下一页数据
  Future<void> _loadMoreBookmarks() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final nextPage = _currentPage + 1;
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityBookmarks(
        username: widget.username,
      );

      if (response.status == 1 || response.status == 200) {
        final newBookmarks = response.data;

        if (newBookmarks.isEmpty) {
          setState(() {
            _isLoading = false;
            _hasMore = false;
          });
        } else {
          setState(() {
            _bookmarks = [..._bookmarks, ...newBookmarks.cast<UserBookmark>()];
            _isLoading = false;
            _hasMore = newBookmarks.length >= 20;
            _currentPage = nextPage;
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = response.message ?? '加载更多书签失败';
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
      appBar: AppBar(title: const Text('书签')),
      body: RefreshIndicator(onRefresh: _refreshBookmarks, child: _buildBody()),
    );
  }

  /// 构建页面主体内容
  ///
  /// 根据当前状态返回不同的 UI：加载中、错误、空状态或列表
  Widget _buildBody() {
    if (_isLoading && _bookmarks.isEmpty) {
      return const _StateView(
        icon: Icons.bookmark_border,
        title: '正在加载书签',
        message: '正在从 forum.trae.cn 拉取书签数据…',
        loading: true,
      );
    }

    if (_errorMessage != null && _bookmarks.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadBookmarks,
      );
    }

    if (_bookmarks.isEmpty) {
      return const _StateView(
        icon: Icons.bookmark_border,
        title: '暂无书签',
        message: '该用户还没有添加任何书签。',
      );
    }

    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: _bookmarks.length + (_hasMore || _isLoading ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == _bookmarks.length) {
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

        final bookmark = _bookmarks[index];
        return _BookmarkCard(bookmark: bookmark);
      },
    );
  }
}

/// 书签卡片组件
///
/// 展示单个书签的标题、摘要和时间信息
class _BookmarkCard extends StatelessWidget {
  final UserBookmark bookmark;

  const _BookmarkCard({required this.bookmark});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          if (bookmark.topicId > 0) {
            context.push(
              RoutePaths.feedDetail.replaceFirst(
                ':id',
                bookmark.topicId.toString(),
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
              Text(
                bookmark.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              if (bookmark.excerpt != null && bookmark.excerpt!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  HtmlTextUtil.stripHtml(bookmark.excerpt!),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    RelativeTimeUtil.fromIso(bookmark.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (bookmark.postNumber != null) ...[
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '#${bookmark.postNumber}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onPrimaryContainer,
                        ),
                      ),
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

}

/// 状态视图组件
///
/// 用于展示加载中、错误、空状态等统一风格的视图
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

/// 用户书签数据模型
///
/// 表示单个书签的信息
class UserBookmark {
  /// 书签 ID
  final int id;

  /// 话题 ID
  final int topicId;

  /// 话题标题
  final String title;

  /// 内容摘要
  final String? excerpt;

  /// 帖子编号
  final int? postNumber;

  /// 创建时间（ISO 8601 格式）
  final String createdAt;

  /// 话题链接
  final String? topicUrl;

  const UserBookmark({
    required this.id,
    required this.topicId,
    required this.title,
    this.excerpt,
    this.postNumber,
    required this.createdAt,
    this.topicUrl,
  });

  /// 从 JSON 创建
  factory UserBookmark.fromJson(Map<String, dynamic> json) {
    return UserBookmark(
      id: json['id'] ?? 0,
      topicId: json['topic_id'] ?? 0,
      title: json['title'] ?? '',
      excerpt: json['excerpt'],
      postNumber: json['post_number'],
      createdAt: json['created_at'] ?? '',
      topicUrl: json['topic_url'],
    );
  }
}

/// 用户书签响应
///
/// API 返回的书签列表响应数据
class UserBookmarksResponse {
  /// 状态码
  final int? status;

  /// 消息
  final String? message;

  /// 书签列表
  final List<UserBookmark> data;

  UserBookmarksResponse({this.status, this.message, this.data = const []});

  factory UserBookmarksResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> bookmarksJson =
        json['user_bookmark_list']?['bookmarks'] ?? [];
    return UserBookmarksResponse(
      status: json['status'],
      message: json['message'],
      data: bookmarksJson
          .map((item) => UserBookmark.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// ApiService 扩展方法
///
/// 提供获取用户书签的 API 方法
extension ApiServiceBookmarks on ApiService {
  /// 获取用户活动书签列表
  ///
  /// [username] 用户名
  /// [page] 页码，从0开始
  Future<UserBookmarksResponse> getUserActivityBookmarks({
    required String username,
    int page = 0,
  }) async {
    try {
      final discourseApi = ref.read(discourseApiServiceProvider);
      final response = await discourseApi.getUserBookmarks(page: page);
      final Map<String, dynamic> data = response.data;

      final List<dynamic> bookmarksJson =
          data['user_bookmark_list']?['bookmarks'] ?? [];
      final bookmarks = bookmarksJson
          .map((item) => UserBookmark.fromJson(item as Map<String, dynamic>))
          .toList();

      return UserBookmarksResponse(
        status: 200,
        message: 'success',
        data: bookmarks,
      );
    } catch (e) {
      return UserBookmarksResponse(
        status: 500,
        message: 'Failed to fetch user bookmarks: $e',
        data: [],
      );
    }
  }
}
