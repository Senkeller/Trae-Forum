import 'dart:async';
import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/network/discourse_api_service.dart';
import '../../data/models/draft_model.dart';

part 'feed_draft_provider.freezed.dart';
part 'feed_draft_provider.g.dart';

/// 发帖草稿状态
///
/// 管理发帖草稿的状态，包括加载状态、错误信息和草稿数据
@freezed
class FeedDraftState with _$FeedDraftState {
  /// 构造函数
  ///
  /// [isLoading] 是否正在加载
  /// [isSaving] 是否正在保存
  /// [error] 错误信息
  /// [draftSaved] 草稿是否已保存
  /// [lastSavedAt] 最后保存时间
  /// [hasDraft] 是否存在草稿
  /// [draftData] 草稿数据
  const factory FeedDraftState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    String? error,
    @Default(false) bool draftSaved,
    DateTime? lastSavedAt,
    @Default(false) bool hasDraft,
    FeedDraftData? draftData,
  }) = _FeedDraftState;

  /// 初始状态
  factory FeedDraftState.initial() => const FeedDraftState();
}

/// 发帖草稿数据
///
/// 包含发帖所需的完整草稿信息
@freezed
class FeedDraftData with _$FeedDraftData {
  /// 构造函数
  ///
  /// [title] 标题
  /// [content] 正文内容
  /// [category] 分类ID
  /// [tags] 标签列表
  /// [layoutMode] 布局模式
  /// [savedAt] 保存时间
  const factory FeedDraftData({
    required String title,
    required String content,
    required String category,
    @Default([]) List<String> tags,
    @Default('cover') String layoutMode,
    required DateTime savedAt,
  }) = _FeedDraftData;

  /// 从JSON解析
  factory FeedDraftData.fromJson(Map<String, dynamic> json) =>
      _$FeedDraftDataFromJson(json);

  /// 创建新的草稿数据
  factory FeedDraftData.create({
    String title = '',
    String content = '',
    String category = 'discussion',
    List<String> tags = const [],
    String layoutMode = 'cover',
  }) =>
      FeedDraftData(
        title: title,
        content: content,
        category: category,
        tags: tags,
        layoutMode: layoutMode,
        savedAt: DateTime.now(),
      );
}

/// 发帖草稿状态管理器
///
/// 处理发帖草稿相关的业务逻辑，包括保存、加载、删除草稿等
@riverpod
class FeedDraftNotifier extends _$FeedDraftNotifier {
  static const String _draftKey = 'new_topic';
  Timer? _autoSaveTimer;

  @override
  FeedDraftState build() {
    // 清理定时器
    ref.onDispose(() {
      _autoSaveTimer?.cancel();
    });
    return FeedDraftState.initial();
  }

  /// 加载草稿
  ///
  /// 从服务器获取已保存的草稿
  /// @return 是否成功加载草稿
  Future<bool> loadDraft() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final discourseApi = ref.read(discourseApiServiceProvider);
      final response = await discourseApi.getDraft(_draftKey);

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data as Map<String, dynamic>?;
        final draftJson = data?['draft'] as String?;

        if (draftJson != null && draftJson.isNotEmpty) {
          try {
            final draftMap = jsonDecode(draftJson) as Map<String, dynamic>;
            final draftData = FeedDraftData.fromJson(draftMap);

            state = state.copyWith(
              isLoading: false,
              hasDraft: true,
              draftData: draftData,
              draftSaved: true,
              lastSavedAt: draftData.savedAt,
            );
            return true;
          } catch (e) {
            // JSON解析失败，尝试作为纯文本内容处理
            final draftData = FeedDraftData.create(
              content: draftJson,
            );
            state = state.copyWith(
              isLoading: false,
              hasDraft: true,
              draftData: draftData,
              draftSaved: true,
            );
            return true;
          }
        }
      }

      state = state.copyWith(isLoading: false, hasDraft: false);
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '加载草稿失败: $e',
      );
      return false;
    }
  }

  /// 保存草稿
  ///
  /// [title] 标题
  /// [content] 正文内容
  /// [category] 分类ID
  /// [tags] 标签列表
  /// [layoutMode] 布局模式
  /// @return 是否保存成功
  Future<bool> saveDraft({
    required String title,
    required String content,
    required String category,
    List<String> tags = const [],
    String layoutMode = 'cover',
  }) async {
    // 如果标题和内容都为空，不保存
    if (title.trim().isEmpty && content.trim().isEmpty) {
      return false;
    }

    state = state.copyWith(isSaving: true, error: null);

    try {
      final draftData = FeedDraftData(
        title: title.trim(),
        content: content.trim(),
        category: category,
        tags: tags,
        layoutMode: layoutMode,
        savedAt: DateTime.now(),
      );

      final discourseApi = ref.read(discourseApiServiceProvider);
      final draftJson = jsonEncode(draftData.toJson());

      final response = await discourseApi.saveDraft(
        draftKey: _draftKey,
        data: draftJson,
        sequence: DraftSequence.next(),
      );

      final success = response.statusCode == 200;

      if (success) {
        state = state.copyWith(
          isSaving: false,
          draftSaved: true,
          lastSavedAt: draftData.savedAt,
          hasDraft: true,
          draftData: draftData,
        );
      } else {
        state = state.copyWith(
          isSaving: false,
          error: '保存草稿失败: HTTP ${response.statusCode}',
        );
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        isSaving: false,
        error: '保存草稿失败: $e',
      );
      return false;
    }
  }

  /// 删除草稿
  ///
  /// 删除服务器上保存的草稿
  Future<void> deleteDraft() async {
    try {
      final discourseApi = ref.read(discourseApiServiceProvider);
      await discourseApi.deleteDraft(
        draftKey: _draftKey,
        sequence: DraftSequence.next(),
      );

      state = state.copyWith(
        draftSaved: false,
        hasDraft: false,
        draftData: null,
        lastSavedAt: null,
      );
    } catch (e) {
      // 忽略删除错误
    }
  }

  /// 启动自动保存
  ///
  /// [title] 标题
  /// [content] 正文内容
  /// [category] 分类ID
  /// [tags] 标签列表
  /// [layoutMode] 布局模式
  /// [interval] 自动保存间隔，默认30秒
  void startAutoSave({
    required String title,
    required String content,
    required String category,
    List<String> tags = const [],
    String layoutMode = 'cover',
    Duration interval = const Duration(seconds: 30),
  }) {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(interval, (_) {
      saveDraft(
        title: title,
        content: content,
        category: category,
        tags: tags,
        layoutMode: layoutMode,
      );
    });
  }

  /// 停止自动保存
  void stopAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = null;
  }

  /// 立即执行一次自动保存
  ///
  /// [title] 标题
  /// [content] 正文内容
  /// [category] 分类ID
  /// [tags] 标签列表
  /// [layoutMode] 布局模式
  Future<bool> autoSaveNow({
    required String title,
    required String content,
    required String category,
    List<String> tags = const [],
    String layoutMode = 'cover',
  }) async {
    return await saveDraft(
      title: title,
      content: content,
      category: category,
      tags: tags,
      layoutMode: layoutMode,
    );
  }

  /// 重置状态
  void reset() {
    _autoSaveTimer?.cancel();
    state = FeedDraftState.initial();
  }

  /// 清除错误
  void clearError() {
    state = state.copyWith(error: null);
  }

  /// 标记草稿已恢复
  void markDraftRestored() {
    state = state.copyWith(hasDraft: false);
  }
}

/// 当前发帖草稿内容Provider
///
/// 用于管理发帖输入框的草稿内容
@riverpod
class FeedDraftContent extends _$FeedDraftContent {
  @override
  FeedDraftData build() {
    return FeedDraftData.create();
  }

  /// 更新草稿内容
  void update({
    String? title,
    String? content,
    String? category,
    List<String>? tags,
    String? layoutMode,
  }) {
    state = state.copyWith(
      title: title ?? state.title,
      content: content ?? state.content,
      category: category ?? state.category,
      tags: tags ?? state.tags,
      layoutMode: layoutMode ?? state.layoutMode,
      savedAt: DateTime.now(),
    );
  }

  /// 设置完整草稿数据
  void setDraftData(FeedDraftData data) {
    state = data;
  }

  /// 清除草稿内容
  void clear() {
    state = FeedDraftData.create();
  }
}
