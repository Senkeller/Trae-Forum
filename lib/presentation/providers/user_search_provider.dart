import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/discourse_api_service.dart';
import '../../core/utils/discourse_image_url_resolver.dart';

part 'user_search_provider.g.dart';

/// 用户搜索结果数据模型
class UserSearchResult {
  /// 用户ID
  final int id;
  /// 用户名
  final String username;
  /// 显示名称
  final String? name;
  /// 头像URL模板
  final String avatarTemplate;
  /// 是否在线
  final bool? online;

  const UserSearchResult({
    required this.id,
    required this.username,
    this.name,
    required this.avatarTemplate,
    this.online,
  });

  /// 从JSON创建
  factory UserSearchResult.fromJson(Map<String, dynamic> json) {
    return UserSearchResult(
      id: json['id'] as int? ?? 0,
      username: json['username'] as String? ?? '',
      name: json['name'] as String?,
      avatarTemplate: json['avatar_template'] as String? ?? '',
      online: json['online'] as bool?,
    );
  }

  /// 获取解析后的头像URL
  String get avatarUrl {
    final url = DiscourseImageUrlResolver.resolveAvatarUrl(
      avatarTemplate,
      size: 96,
    );
    return url ?? '';
  }

  /// 获取显示名称（优先使用name，否则使用username）
  String get displayName => name?.isNotEmpty == true ? name! : username;
}

/// 用户搜索状态类
class UserSearchState {
  /// 搜索关键词
  final String keyword;
  /// 搜索结果列表
  final List<UserSearchResult> results;
  /// 是否正在搜索
  final bool isSearching;
  /// 错误信息
  final String? errorMessage;
  /// 是否显示搜索结果
  final bool showResults;
  /// 已选中的用户
  final UserSearchResult? selectedUser;

  const UserSearchState({
    this.keyword = '',
    this.results = const [],
    this.isSearching = false,
    this.errorMessage,
    this.showResults = false,
    this.selectedUser,
  });

  /// 复制并修改
  UserSearchState copyWith({
    String? keyword,
    List<UserSearchResult>? results,
    bool? isSearching,
    String? errorMessage,
    bool? showResults,
    UserSearchResult? selectedUser,
    bool clearSelectedUser = false,
  }) {
    return UserSearchState(
      keyword: keyword ?? this.keyword,
      results: results ?? this.results,
      isSearching: isSearching ?? this.isSearching,
      errorMessage: errorMessage,
      showResults: showResults ?? this.showResults,
      selectedUser: clearSelectedUser ? null : (selectedUser ?? this.selectedUser),
    );
  }
}

/// 用户搜索状态 Notifier
@riverpod
class UserSearchNotifier extends _$UserSearchNotifier {
  late DiscourseApiService _discourseApi;

  /// 构建搜索状态
  @override
  UserSearchState build() {
    _discourseApi = ref.read(discourseApiServiceProvider);
    return const UserSearchState();
  }

  /// 设置搜索关键词
  ///
  /// [keyword] 搜索关键词
  void setKeyword(String keyword) {
    state = state.copyWith(
      keyword: keyword,
      showResults: keyword.isNotEmpty,
    );
    
    if (keyword.isNotEmpty) {
      search(keyword);
    } else {
      state = state.copyWith(
        results: [],
        showResults: false,
        errorMessage: null,
      );
    }
  }

  /// 执行用户搜索
  ///
  /// [query] 搜索关键词
  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = state.copyWith(
        results: [],
        isSearching: false,
        showResults: false,
      );
      return;
    }

    state = state.copyWith(
      isSearching: true,
      errorMessage: null,
      showResults: true,
    );

    try {
      final response = await _discourseApi.searchUsers(query.trim(), limit: 20);
      final data = response.data as Map<String, dynamic>?;
      
      if (data == null) {
        state = state.copyWith(
          results: [],
          isSearching: false,
        );
        return;
      }

      // 解析用户列表
      final users = data['users'] as List<dynamic>? ?? [];
      final results = users
          .whereType<Map<String, dynamic>>()
          .map((user) => UserSearchResult.fromJson(user))
          .toList();

      state = state.copyWith(
        results: results,
        isSearching: false,
      );
    } catch (e) {
      state = state.copyWith(
        isSearching: false,
        errorMessage: '搜索失败: $e',
        results: [],
      );
    }
  }

  /// 选择用户
  ///
  /// [user] 选中的用户
  void selectUser(UserSearchResult user) {
    state = state.copyWith(
      selectedUser: user,
      keyword: user.username,
      showResults: false,
    );
  }

  /// 清除选中的用户
  void clearSelection() {
    state = state.copyWith(
      clearSelectedUser: true,
      keyword: '',
      results: [],
      showResults: false,
    );
  }

  /// 隐藏搜索结果
  void hideResults() {
    state = state.copyWith(showResults: false);
  }

  /// 显示搜索结果
  void showResultsList() {
    if (state.results.isNotEmpty) {
      state = state.copyWith(showResults: true);
    }
  }

  /// 清除搜索结果
  void clear() {
    state = const UserSearchState();
  }
}

/// 用户搜索结果 Provider
@riverpod
List<UserSearchResult> userSearchResults(UserSearchResultsRef ref) {
  return ref.watch(userSearchNotifierProvider).results;
}

/// 是否正在搜索 Provider
@riverpod
bool isUserSearching(IsUserSearchingRef ref) {
  return ref.watch(userSearchNotifierProvider).isSearching;
}

/// 选中的用户 Provider
@riverpod
UserSearchResult? selectedUser(SelectedUserRef ref) {
  return ref.watch(userSearchNotifierProvider).selectedUser;
}
