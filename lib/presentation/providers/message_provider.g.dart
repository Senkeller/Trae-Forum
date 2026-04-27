// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$messageListHash() => r'e8ddc25048ca2740152cd5234808824c32b83e43';

/// 消息列表 Provider
///
/// Copied from [messageList].
@ProviderFor(messageList)
final messageListProvider = AutoDisposeProvider<List<MessageItem>>.internal(
  messageList,
  name: r'messageListProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MessageListRef = AutoDisposeProviderRef<List<MessageItem>>;
String _$unreadMessageCountHash() =>
    r'b6d46a4a5e17635d23d7dabb921ca3952cb3f537';

/// 未读消息计数 Provider
///
/// Copied from [unreadMessageCount].
@ProviderFor(unreadMessageCount)
final unreadMessageCountProvider = AutoDisposeProvider<UnreadCount>.internal(
  unreadMessageCount,
  name: r'unreadMessageCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadMessageCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UnreadMessageCountRef = AutoDisposeProviderRef<UnreadCount>;
String _$totalUnreadCountHash() => r'da80c9e027ea4d5933222511ddb8604a2aab4876';

/// 总未读消息数 Provider
///
/// Copied from [totalUnreadCount].
@ProviderFor(totalUnreadCount)
final totalUnreadCountProvider = AutoDisposeProvider<int>.internal(
  totalUnreadCount,
  name: r'totalUnreadCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$totalUnreadCountHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TotalUnreadCountRef = AutoDisposeProviderRef<int>;
String _$currentMessageTypeHash() =>
    r'eca8c09c8cb36d1db2756e28bdfa61c18503e48a';

/// 当前消息类型 Provider
///
/// Copied from [currentMessageType].
@ProviderFor(currentMessageType)
final currentMessageTypeProvider = AutoDisposeProvider<MessageType>.internal(
  currentMessageType,
  name: r'currentMessageTypeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentMessageTypeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentMessageTypeRef = AutoDisposeProviderRef<MessageType>;
String _$isMessageLoadingHash() => r'8837077917162bebcd47c56290740aa2abe023ba';

/// 是否正在加载消息 Provider
///
/// Copied from [isMessageLoading].
@ProviderFor(isMessageLoading)
final isMessageLoadingProvider = AutoDisposeProvider<bool>.internal(
  isMessageLoading,
  name: r'isMessageLoadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isMessageLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsMessageLoadingRef = AutoDisposeProviderRef<bool>;
String _$messageNotifierHash() => r'596a1b25fa1a60aa54d0f8d17b29cfb9e2743a0a';

/// 消息状态 Notifier
///
/// Copied from [MessageNotifier].
@ProviderFor(MessageNotifier)
final messageNotifierProvider =
    AutoDisposeNotifierProvider<MessageNotifier, MessageState>.internal(
      MessageNotifier.new,
      name: r'messageNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$messageNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$MessageNotifier = AutoDisposeNotifier<MessageState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
