// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$replyNotifierHash() => r'd3575ba591b6068193b91b7141e29275ef873e96';

/// 回复状态管理器
///
/// 处理回复相关的业务逻辑，包括发送回复、保存草稿等
///
/// Copied from [ReplyNotifier].
@ProviderFor(ReplyNotifier)
final replyNotifierProvider =
    AutoDisposeNotifierProvider<ReplyNotifier, ReplyState>.internal(
      ReplyNotifier.new,
      name: r'replyNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$replyNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReplyNotifier = AutoDisposeNotifier<ReplyState>;
String _$currentReplyTargetHash() =>
    r'29aa76171f07695d1097c0db0532221aff2562f9';

/// 当前回复目标Provider
///
/// 用于管理当前正在回复的目标（楼中楼回复）
///
/// Copied from [CurrentReplyTarget].
@ProviderFor(CurrentReplyTarget)
final currentReplyTargetProvider =
    AutoDisposeNotifierProvider<CurrentReplyTarget, ReplyTarget?>.internal(
      CurrentReplyTarget.new,
      name: r'currentReplyTargetProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentReplyTargetHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentReplyTarget = AutoDisposeNotifier<ReplyTarget?>;
String _$replyDraftHash() => r'42f2005da1b521e364fa93de937328842dc2a635';

/// 回复草稿内容Provider
///
/// 用于管理回复输入框的草稿内容
///
/// Copied from [ReplyDraft].
@ProviderFor(ReplyDraft)
final replyDraftProvider =
    AutoDisposeNotifierProvider<ReplyDraft, String>.internal(
      ReplyDraft.new,
      name: r'replyDraftProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$replyDraftHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReplyDraft = AutoDisposeNotifier<String>;
String _$replyListRefreshHash() => r'ff767b9f1cb2985a6f541eeb5c1e67bce797f2d9';

/// 话题回复列表刷新触发器
///
/// 用于触发回复列表的刷新
///
/// Copied from [ReplyListRefresh].
@ProviderFor(ReplyListRefresh)
final replyListRefreshProvider =
    AutoDisposeNotifierProvider<ReplyListRefresh, int>.internal(
      ReplyListRefresh.new,
      name: r'replyListRefreshProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$replyListRefreshHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReplyListRefresh = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
