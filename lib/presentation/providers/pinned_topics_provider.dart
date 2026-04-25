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
  /// 从论坛API获取置顶话题数据，包括全局置顶和官方公告分类置顶
  Future<void> loadPinnedTopics() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // 分别获取不同来源的话题，避免一个失败影响其他
      final allTopics = <Map<String, dynamic>>[];
      final allUsers = <Map<String, dynamic>>[];
      final allCategories = <Map<String, dynamic>>[];
      final seenTopicIds = <int>{};

      // 1. 获取最新话题（包含全局置顶）
      try {
        final response = await _discourseApiService.getLatestTopics(page: 0);
        final raw = response.data;
        final data = raw is Map<String, dynamic> ? raw : Map<String, dynamic>.from(raw as Map);
        
        final topicListMap = data['topic_list'] as Map<String, dynamic>?;
        final topics = (topicListMap?['topics'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        
        for (final topic in topics) {
          final id = _parseInt(topic['id']);
          if (id > 0 && seenTopicIds.add(id)) {
            allTopics.add(topic);
          }
        }
        
        final users = (data['users'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        allUsers.addAll(users);
        
        final categories = (data['categories'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        allCategories.addAll(categories);
        
        print('📌 [PinnedTopics] 获取最新话题: ${topics.length}个');
      } catch (e) {
        print('📌 [PinnedTopics] 获取最新话题失败: $e');
      }

      // 2. 获取官方公告分类话题
      try {
        final response = await _discourseApiService.getTopicsByCategory(4, page: 0);
        final raw = response.data;
        final data = raw is Map<String, dynamic> ? raw : Map<String, dynamic>.from(raw as Map);
        
        final topicListMap = data['topic_list'] as Map<String, dynamic>?;
        final topics = (topicListMap?['topics'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        
        for (final topic in topics) {
          final id = _parseInt(topic['id']);
          if (id > 0 && seenTopicIds.add(id)) {
            allTopics.add(topic);
          }
        }
        
        final users = (data['users'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        allUsers.addAll(users);
        
        final categories = (data['categories'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        allCategories.addAll(categories);
        
        print('📌 [PinnedTopics] 获取官方公告: ${topics.length}个');
      } catch (e) {
        print('📌 [PinnedTopics] 获取官方公告失败: $e');
      }

      // 3. 获取福利活动分类话题
      try {
        final response = await _discourseApiService.getTopicsByCategory(29, page: 0);
        final raw = response.data;
        final data = raw is Map<String, dynamic> ? raw : Map<String, dynamic>.from(raw as Map);
        
        final topicListMap = data['topic_list'] as Map<String, dynamic>?;
        final topics = (topicListMap?['topics'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        
        for (final topic in topics) {
          final id = _parseInt(topic['id']);
          if (id > 0 && seenTopicIds.add(id)) {
            allTopics.add(topic);
          }
        }
        
        final users = (data['users'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        allUsers.addAll(users);
        
        final categories = (data['categories'] as List<dynamic>? ?? const [])
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
        allCategories.addAll(categories);
        
        print('📌 [PinnedTopics] 获取福利活动: ${topics.length}个');
      } catch (e) {
        print('📌 [PinnedTopics] 获取福利活动失败: $e');
      }

      // 构建用户映射表
      final userMap = <int, Map<String, dynamic>>{};
      for (final user in allUsers) {
        final id = _parseInt(user['id']);
        if (id > 0) {
          userMap[id] = user;
        }
      }

      // 构建分类映射表
      final categoryMap = <int, Map<String, dynamic>>{};
      for (final category in allCategories) {
        final id = _parseInt(category['id']);
        if (id > 0) {
          categoryMap[id] = category;
        }
      }

      // 过滤出置顶话题并转换为模型
      // 置顶话题判断：pinned 为 true 或 pinned_globally 为 true
      print('📌 [PinnedTopics] 总话题数: ${allTopics.length}');
      
      final pinnedTopics = allTopics
          .where((topic) {
            final pinned = topic['pinned'];
            final pinnedGlobally = topic['pinned_globally'];
            
            // 判断是否为置顶
            bool isPinned = false;
            
            // 检查 pinned 字段
            if (pinned != null) {
              if (pinned is bool) {
                isPinned = pinned;
              } else if (pinned is int) {
                isPinned = pinned > 0;
              } else if (pinned is String) {
                isPinned = pinned.toLowerCase() == 'true' || pinned == '1';
              }
            }
            
            // 检查 pinned_globally 字段
            if (!isPinned && pinnedGlobally != null) {
              if (pinnedGlobally is bool) {
                isPinned = pinnedGlobally;
              } else if (pinnedGlobally is int) {
                isPinned = pinnedGlobally > 0;
              } else if (pinnedGlobally is String) {
                isPinned = pinnedGlobally.toLowerCase() == 'true' || pinnedGlobally == '1';
              }
            }
            
            if (isPinned) {
              print('📌 [PinnedTopics] ✅ 置顶话题: ${topic['title']}');
            }
            
            return isPinned;
          })
          .take(10)
          .map((topic) => PinnedTopic.fromTopicData(topic, userMap, categoryMap))
          .toList();
      
      print('📌 [PinnedTopics] 过滤后置顶话题数: ${pinnedTopics.length}');

      state = state.copyWith(
        topics: pinnedTopics,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      print('📌 [PinnedTopics] 加载失败: $e');
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
