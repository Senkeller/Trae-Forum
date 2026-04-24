// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$commentRepositoryHash() => r'97b044bc11c73e3fb202d0ec5a066fa7a9e91656';

/// 评论仓库
/// 负责处理评论相关的数据操作，包括获取评论列表、发布评论、点赞评论、获取楼中楼回复等
///
/// Copied from [commentRepository].
@ProviderFor(commentRepository)
final commentRepositoryProvider =
    AutoDisposeProvider<CommentRepository>.internal(
      commentRepository,
      name: r'commentRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$commentRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CommentRepositoryRef = AutoDisposeProviderRef<CommentRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
