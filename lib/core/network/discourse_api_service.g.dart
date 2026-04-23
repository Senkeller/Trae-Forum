// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discourse_api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$discourseApiServiceHash() =>
    r'4c59ecd6725be3e9c0b365af82f5ba747826e9ff';

/// Discourse API 服务
///
/// 负责调用 Discourse 论坛 API 端点
///
/// Copied from [DiscourseApiService].
@ProviderFor(DiscourseApiService)
final discourseApiServiceProvider =
    AutoDisposeNotifierProvider<
      DiscourseApiService,
      DiscourseApiService
    >.internal(
      DiscourseApiService.new,
      name: r'discourseApiServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$discourseApiServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$DiscourseApiService = AutoDisposeNotifier<DiscourseApiService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
