// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageRepositoryHash() => r'b1c64959b9d37f16dd7dad1dd3a142abcf2d8f4a';

/// 消息仓库
/// 负责处理消息相关的数据操作，包括获取消息列表、标记已读、检查未读数量等
///
/// Copied from [messageRepository].
@ProviderFor(messageRepository)
final messageRepositoryProvider =
    AutoDisposeProvider<MessageRepository>.internal(
      messageRepository,
      name: r'messageRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$messageRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MessageRepositoryRef = AutoDisposeProviderRef<MessageRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
