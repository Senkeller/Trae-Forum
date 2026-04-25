import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/network/discourse_api_service.dart';
import '../../../data/models/pinned_topic.dart';

part 'pinned_topics_provider.g.dart';

/// 置顶话题列表状态
class PinnedTopicsState {
  final List<PinnedTopic> topics;
  final bool isLoading;
  final String? errorMessage;

  const PinnedTopicsState({
    this.topics = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  PinnedTopicsState copyWith({
    List<PinnedTopic>? topics,
    bool? isLoading,
    String? errorMessage,
  }) {
    return PinnedTopicsState(
      topics: topics ?? this.topics,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// 置顶话题Notifier
@riverpod
class PinnedTopicsNotifier extends _$PinnedTopicsNotifier {
  late DiscourseApiService _discourseApiService;

  @override
  PinnedTopicsState build() {
    _discourseApiService = ref.read(discourseApiServiceProvider);
    return const PinnedTopicsState();
  }

  /// 加载置顶话题列表
  ///
  /// 从论坛API获取置顶话题数据
  Future<void> loadPinnedTopics() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await _discourseApiService.getLatestTopics(page: 0);
      final raw = response.data;
      final data = raw is Map<String, dynamic> ? raw : Map<String, dynamic>.from(raw as Map);

      // 解析话题列表
      final topicListMap = data['topic_list'] as Map<String, dynamic>?;
      final topics = (topicListMap?['topics'] as List<dynamic>? ?? const [])
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      // 解析用户信息
      final users = (data['users'] as List<dynamic>? ?? const [])
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      // 解析分类信息
      final categories = (data['categories'] as List<dynamic>? ?? const [])
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      // 构建用户映射表
      final userMap = <int, Map<String, dynamic>>{};
      for (final user in users) {
        final id = _parseInt(user['id']);
        if (id > 0) {
          userMap[id] = user;
        }
      }

      // 构建分类映射表
      final categoryMap = <int, Map<String, dynamic>>{};
      for (final category in categories) {
        final id = _parseInt(category['id']);
        if (id > 0) {
          categoryMap[id] = category;
        }
      }

      // 过滤出置顶话题并转换为模型
      // 置顶话题判断：pinned 为 true 或 pinned_globally 为 true 或 pinned_at 不为空
      final pinnedTopics = topics
          .where((topic) {
            final pinned = topic['pinned'];
            final pinnedGlobally = topic['pinned_globally'];
            final pinnedAt = topic['pinned_at'];
            final isPinned = pinned == true || 
                            pinned == 1 || 
                            pinnedGlobally == true || 
                            pinnedGlobally == 1 ||
                            (pinnedAt != null && pinnedAt.toString().isNotEmpty);
            return isPinned;
          })
          .take(10)
          .map((topic) => PinnedTopic.fromTopicData(topic, userMap, categoryMap))
          .toList();

      state = state.copyWith(
        topics: pinnedTopics,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '加载置顶话题失败: $e',
      );
    }
  }

  /// 刷新置顶话题
  Future<void> refresh() async {
    await loadPinnedTopics();
  }
}

/// 置顶话题列表Provider
@riverpod
List<PinnedTopic> pinnedTopicsList(PinnedTopicsListRef ref) {
  return ref.watch(pinnedTopicsNotifierProvider).topics;
}

/// 置顶话题加载状态Provider
@riverpod
bool isPinnedTopicsLoading(IsPinnedTopicsLoadingRef ref) {
  return ref.watch(pinnedTopicsNotifierProvider).isLoading;
}

/// 置顶话题错误信息Provider
@riverpod
String? pinnedTopicsError(PinnedTopicsErrorRef ref) {
  return ref.watch(pinnedTopicsNotifierProvider).errorMessage;
}

int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  return int.tryParse(value.toString()) ?? 0;
}
