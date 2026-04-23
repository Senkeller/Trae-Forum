// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$apiServiceHash() => r'fed2f9670cafc3a33aa315d98668a810e21ba4c2';

/// API 服务类
///
/// 负责调用后端 API，支持酷安 API 和 Discourse API
/// 通过适配器层统一数据格式
///
/// Copied from [ApiService].
@ProviderFor(ApiService)
final apiServiceProvider =
    AutoDisposeNotifierProvider<ApiService, ApiService>.internal(
      ApiService.new,
      name: r'apiServiceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$apiServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ApiService = AutoDisposeNotifier<ApiService>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
