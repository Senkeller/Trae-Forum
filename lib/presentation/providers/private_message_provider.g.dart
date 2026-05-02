// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'private_message_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$privateMessageUnreadCountHash() =>
    r'5c405391e99996bb33173c664621c7074c11c7d9';

/// 私信未读总数 Provider
///
/// Copied from [privateMessageUnreadCount].
@ProviderFor(privateMessageUnreadCount)
final privateMessageUnreadCountProvider =
    AutoDisposeFutureProvider<int>.internal(
      privateMessageUnreadCount,
      name: r'privateMessageUnreadCountProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$privateMessageUnreadCountHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PrivateMessageUnreadCountRef = AutoDisposeFutureProviderRef<int>;
String _$conversationListHash() => r'c7c9883bba9ad770393462fca320e63913179984';

/// 会话列表 Provider（简化访问）
///
/// Copied from [conversationList].
@ProviderFor(conversationList)
final conversationListProvider =
    AutoDisposeProvider<List<PrivateMessageConversation>>.internal(
      conversationList,
      name: r'conversationListProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$conversationListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConversationListRef =
    AutoDisposeProviderRef<List<PrivateMessageConversation>>;
String _$hasUnreadPrivateMessagesHash() =>
    r'6df32c1c1ae51ac4778e81ec586dc5ffc4c17c0d';

/// 是否有未读私信 Provider
///
/// Copied from [hasUnreadPrivateMessages].
@ProviderFor(hasUnreadPrivateMessages)
final hasUnreadPrivateMessagesProvider = AutoDisposeProvider<bool>.internal(
  hasUnreadPrivateMessages,
  name: r'hasUnreadPrivateMessagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$hasUnreadPrivateMessagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HasUnreadPrivateMessagesRef = AutoDisposeProviderRef<bool>;
String _$privateMessageConversationNotifierHash() =>
    r'131c141cd121bb7ea32e0616d5c2b72e774b2c35';

/// 私信会话列表 Notifier
///
/// Copied from [PrivateMessageConversationNotifier].
@ProviderFor(PrivateMessageConversationNotifier)
final privateMessageConversationNotifierProvider =
    AutoDisposeNotifierProvider<
      PrivateMessageConversationNotifier,
      PrivateMessageConversationState
    >.internal(
      PrivateMessageConversationNotifier.new,
      name: r'privateMessageConversationNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$privateMessageConversationNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PrivateMessageConversationNotifier =
    AutoDisposeNotifier<PrivateMessageConversationState>;
String _$privateMessageChatNotifierHash() =>
    r'8595721db5857d37a59fb09b739e0a0e3690e270';

/// 私信聊天 Notifier
///
/// Copied from [PrivateMessageChatNotifier].
@ProviderFor(PrivateMessageChatNotifier)
final privateMessageChatNotifierProvider =
    AutoDisposeNotifierProvider<
      PrivateMessageChatNotifier,
      PrivateMessageChatState
    >.internal(
      PrivateMessageChatNotifier.new,
      name: r'privateMessageChatNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$privateMessageChatNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$PrivateMessageChatNotifier =
    AutoDisposeNotifier<PrivateMessageChatState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
