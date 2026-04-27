// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'composer_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$composerStateHash() => r'294f83250a1f40297ce65362c8811162f1359352';

/// 全局 Composer 状态 Provider
///
/// 用于在应用中共享编辑器状态
///
/// Copied from [composerState].
@ProviderFor(composerState)
final composerStateProvider = AutoDisposeProvider<ComposerState>.internal(
  composerState,
  name: r'composerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$composerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ComposerStateRef = AutoDisposeProviderRef<ComposerState>;
String _$composerRawTextHash() => r'6f48097237bdba722aeec69e38f90765af2e95d1';

/// 原始文本 Provider
///
/// Copied from [composerRawText].
@ProviderFor(composerRawText)
final composerRawTextProvider = AutoDisposeProvider<String>.internal(
  composerRawText,
  name: r'composerRawTextProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$composerRawTextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ComposerRawTextRef = AutoDisposeProviderRef<String>;
String _$composerIsEmptyHash() => r'f70f8c64c48593852a27130598de4e0db9c42129';

/// 是否为空 Provider
///
/// Copied from [composerIsEmpty].
@ProviderFor(composerIsEmpty)
final composerIsEmptyProvider = AutoDisposeProvider<bool>.internal(
  composerIsEmpty,
  name: r'composerIsEmptyProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$composerIsEmptyHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ComposerIsEmptyRef = AutoDisposeProviderRef<bool>;
String _$composerAttachmentsHash() =>
    r'6d02b620d779fc20f2c1da6bf588a6b0b341208f';

/// 附件列表 Provider
///
/// Copied from [composerAttachments].
@ProviderFor(composerAttachments)
final composerAttachmentsProvider =
    AutoDisposeProvider<List<AttachmentItem>>.internal(
      composerAttachments,
      name: r'composerAttachmentsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$composerAttachmentsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ComposerAttachmentsRef = AutoDisposeProviderRef<List<AttachmentItem>>;
String _$composerIsPreviewHash() => r'a77aa7adfd8dc49d23bf76d7b89f1c9a47543241';

/// 是否处于预览模式 Provider
///
/// Copied from [composerIsPreview].
@ProviderFor(composerIsPreview)
final composerIsPreviewProvider = AutoDisposeProvider<bool>.internal(
  composerIsPreview,
  name: r'composerIsPreviewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$composerIsPreviewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ComposerIsPreviewRef = AutoDisposeProviderRef<bool>;
String _$composerIsUploadingHash() =>
    r'7f793d41c6ccdf8781eddb087599fac394fc4e5d';

/// 是否正在上传 Provider
///
/// Copied from [composerIsUploading].
@ProviderFor(composerIsUploading)
final composerIsUploadingProvider = AutoDisposeProvider<bool>.internal(
  composerIsUploading,
  name: r'composerIsUploadingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$composerIsUploadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ComposerIsUploadingRef = AutoDisposeProviderRef<bool>;
String _$composerNotifierHash() => r'120438d5adf9f04fc1e8955871a6314aa4317eff';

/// Composer 状态管理器
///
/// 提供编辑器状态的管理和操作，包括：
/// - 文本编辑和选区管理
/// - Markdown 语法包裹
/// - 附件管理
/// - 预览模式切换
/// - URL 校验与自动转换
///
/// Copied from [ComposerNotifier].
@ProviderFor(ComposerNotifier)
final composerNotifierProvider =
    AutoDisposeNotifierProvider<ComposerNotifier, ComposerState>.internal(
      ComposerNotifier.new,
      name: r'composerNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$composerNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ComposerNotifier = AutoDisposeNotifier<ComposerState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
