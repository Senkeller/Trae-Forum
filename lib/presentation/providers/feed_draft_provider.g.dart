// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_draft_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FeedDraftDataImpl _$$FeedDraftDataImplFromJson(Map<String, dynamic> json) =>
    _$FeedDraftDataImpl(
      title: json['title'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      layoutMode: json['layoutMode'] as String? ?? 'cover',
      savedAt: DateTime.parse(json['savedAt'] as String),
    );

Map<String, dynamic> _$$FeedDraftDataImplToJson(_$FeedDraftDataImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'category': instance.category,
      'tags': instance.tags,
      'layoutMode': instance.layoutMode,
      'savedAt': instance.savedAt.toIso8601String(),
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$feedDraftNotifierHash() => r'3b7d24d7c2debb06153856aa8abdfbfb66b6cbd0';

/// 发帖草稿状态管理器
///
/// 处理发帖草稿相关的业务逻辑，包括保存、加载、删除草稿等
///
/// Copied from [FeedDraftNotifier].
@ProviderFor(FeedDraftNotifier)
final feedDraftNotifierProvider =
    AutoDisposeNotifierProvider<FeedDraftNotifier, FeedDraftState>.internal(
      FeedDraftNotifier.new,
      name: r'feedDraftNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$feedDraftNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FeedDraftNotifier = AutoDisposeNotifier<FeedDraftState>;
String _$feedDraftContentHash() => r'b2687b7762bc36a88c87a3d2e9b554ea5f03884f';

/// 当前发帖草稿内容Provider
///
/// 用于管理发帖输入框的草稿内容
///
/// Copied from [FeedDraftContent].
@ProviderFor(FeedDraftContent)
final feedDraftContentProvider =
    AutoDisposeNotifierProvider<FeedDraftContent, FeedDraftData>.internal(
      FeedDraftContent.new,
      name: r'feedDraftContentProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$feedDraftContentHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FeedDraftContent = AutoDisposeNotifier<FeedDraftData>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
