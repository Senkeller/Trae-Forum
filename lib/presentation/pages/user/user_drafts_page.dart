import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../../core/network/api_service.dart';
import '../../../core/utils/draft_normalizer.dart';
import '../../../core/utils/html_text_util.dart';
import '../../../core/utils/relative_time_util.dart';
import '../../../core/utils/scroll_load_guard.dart';

/// 用户草稿列表页面
///
/// 展示指定用户的所有草稿内容，支持下拉刷新和加载更多
/// 每个草稿项显示标题、创建时间，并提供编辑按钮
class UserDraftsPage extends ConsumerStatefulWidget {
  /// 用户名（Discourse username），从路由参数获取
  final String username;

  /// 构造函数
  ///
  /// [username] 用户名，必需参数
  const UserDraftsPage({super.key, required this.username});

  @override
  ConsumerState<UserDraftsPage> createState() => _UserDraftsPageState();
}

class _UserDraftsPageState extends ConsumerState<UserDraftsPage> {
  static const int _pageSize = 30;
  final ScrollController _scrollController = ScrollController();

  /// 滚动加载守卫，用于管理列表的触底加载逻辑
  final ScrollLoadGuard _scrollLoadGuard = ScrollLoadGuard();

  /// 草稿列表数据
  List<UserActivity> _drafts = [];

  /// 是否正在加载数据
  bool _isLoading = false;

  /// 是否还有更多数据
  bool _hasMore = true;

  /// 当前页码
  int _currentOffset = 0;

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
  ///
  /// 从 API 获取用户的草稿列表，支持错误处理和状态更新
  Future<void> _loadData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityDrafts(offset: 0);

      if (response.status == 200) {
        setState(() {
          _drafts = response.data;
          _hasMore = response.data.length >= _pageSize;
          _currentOffset = response.data.length;
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
  ///
  /// 分页加载更多草稿数据，追加到现有列表
  Future<void> _loadMore() async {
    if (_isLoading || !_hasMore) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final response = await apiService.getUserActivityDrafts(
        offset: _currentOffset,
      );

      if (response.status == 200) {
        final drafts = response.data;
        setState(() {
          _drafts.addAll(drafts);
          _hasMore = drafts.length >= _pageSize;
          _currentOffset += drafts.length;
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
  ///
  /// 重新加载第一页数据
  Future<void> _onRefresh() async {
    await _loadData();
  }

  /// 编辑草稿
  ///
  /// [draft] 要编辑的草稿对象
  /// 跳转到编辑页面或打开编辑器
  void _editDraft(UserActivity draft) {
    final content = _extractDraftContent(draft);
    final title = _extractDraftTitle(draft);
    final encodedTitle = Uri.encodeComponent(title);
    final encodedContent = Uri.encodeComponent(content);
    context.push(
      '${RoutePaths.feedCreate}?title=$encodedTitle&content=$encodedContent',
    );
  }

  String _extractDraftTitle(UserActivity draft) {
    final normalized = DraftNormalizer.normalize(draft.draftData);
    final parsedTitle = normalized.title;
    if (parsedTitle != null && parsedTitle.isNotEmpty) {
      return parsedTitle;
    }
    if (draft.excerpt != null && draft.excerpt!.trim().isNotEmpty) {
      return _stripHtml(draft.excerpt!);
    }
    if (draft.topicSlug != null && draft.topicSlug!.trim().isNotEmpty) {
      return draft.topicSlug!.trim();
    }
    return '草稿 ${draft.id}';
  }

  String _extractDraftContent(UserActivity draft) {
    final normalized = DraftNormalizer.normalize(draft.draftData);
    final parsedContent = normalized.content;
    if (parsedContent != null && parsedContent.trim().isNotEmpty) {
      return parsedContent.trim();
    }

    final rawData = draft.draftData?.trim();
    if (rawData != null && rawData.isNotEmpty) {
      return rawData;
    }

    if (draft.cooked != null && draft.cooked!.trim().isNotEmpty) {
      return _stripHtml(draft.cooked!);
    }
    if (draft.excerpt != null && draft.excerpt!.trim().isNotEmpty) {
      return _stripHtml(draft.excerpt!);
    }
    return '';
  }

  String _stripHtml(String htmlString) {
    return HtmlTextUtil.stripHtml(htmlString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('草稿')),
      body: _buildBody(),
    );
  }

  /// 构建页面主体内容
  ///
  /// 根据当前状态返回不同的视图：
  /// - 加载中：显示加载指示器
  /// - 错误：显示错误信息和重试按钮
  /// - 空状态：显示空状态提示
  /// - 有数据：显示草稿列表
  Widget _buildBody() {
    // 初始加载中
    if (_isLoading && _drafts.isEmpty) {
      return const _StateView(
        icon: Icons.edit_note,
        title: '正在加载草稿',
        message: '请稍候…',
        loading: true,
      );
    }

    // 加载失败且没有数据
    if (_errorMessage != null && _drafts.isEmpty) {
      return _StateView(
        icon: Icons.error_outline,
        title: '加载失败',
        message: _errorMessage!,
        actionLabel: '重试',
        onAction: _loadData,
      );
    }

    // 空状态
    if (_drafts.isEmpty) {
      return const _StateView(
        icon: Icons.edit_off,
        title: '暂无草稿',
        message: '您还没有保存任何草稿。',
      );
    }

    // 草稿列表
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _drafts.length + (_hasMore || _isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < _drafts.length) {
            final draft = _drafts[index];
            return _DraftCard(draft: draft, onEdit: () => _editDraft(draft));
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

/// 草稿卡片组件
///
/// 展示单个草稿的标题、创建时间，并提供编辑按钮
/// 参考 user_profile_page.dart 中的 _ActivityCard 组件样式
class _DraftCard extends StatelessWidget {
  final UserActivity draft;
  final VoidCallback onEdit;

  /// 构造函数
  ///
  /// [draft] 草稿数据对象，必需参数
  /// [onEdit] 编辑按钮点击回调，必需参数
  const _DraftCard({required this.draft, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 标题行：包含草稿标题和编辑按钮
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 草稿图标
                  Icon(Icons.edit_note, size: 20, color: colorScheme.primary),
                  const SizedBox(width: 12),
                  // 标题内容
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 草稿标题
                        Text(
                          _getDraftTitle(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 8),
                        // 创建时间
                        if (draft.createdAt != null)
                          Text(
                            _formatTime(draft.createdAt!),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colorScheme.onSurfaceVariant),
                          ),
                      ],
                    ),
                  ),
                  // 编辑按钮
                  IconButton(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined),
                    tooltip: '编辑',
                    color: colorScheme.primary,
                  ),
                ],
              ),
              // 草稿内容预览
              if (draft.cooked != null && draft.cooked!.isNotEmpty) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _stripHtml(draft.cooked!),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
              // 话题标签
              if (draft.topicSlug != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '话题 #${draft.topicSlug}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
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

  /// 获取草稿标题
  ///
  /// 优先使用 excerpt 作为标题，如果没有则使用默认标题
  /// 返回草稿标题字符串
  String _getDraftTitle() {
    if (draft.excerpt != null && draft.excerpt!.isNotEmpty) {
      return _stripHtml(draft.excerpt!);
    }
    if (draft.cooked != null && draft.cooked!.isNotEmpty) {
      final stripped = _stripHtml(draft.cooked!);
      return stripped.length > 50
          ? '${stripped.substring(0, 50)}...'
          : stripped;
    }
    return '草稿 #${draft.id}';
  }

  /// 格式化时间显示
  ///
  /// [isoTime] ISO 8601 格式的时间字符串
  /// 返回相对时间描述（如：2小时前、3天前）
  String _formatTime(String isoTime) {
    return RelativeTimeUtil.fromIso(isoTime);
  }

  /// 去除 HTML 标签
  ///
  /// [htmlString] 包含 HTML 标签的字符串
  /// 返回纯文本字符串
  String _stripHtml(String htmlString) {
    return HtmlTextUtil.stripHtml(htmlString);
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

  /// 构造函数
  ///
  /// [icon] 图标，必需参数
  /// [title] 标题，必需参数
  /// [message] 消息内容，必需参数
  /// [loading] 是否显示加载状态，默认为 false
  /// [actionLabel] 操作按钮文本，可选
  /// [onAction] 操作按钮回调，可选
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
