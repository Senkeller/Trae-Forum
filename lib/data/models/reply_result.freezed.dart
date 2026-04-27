// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ReplyResult _$ReplyResultFromJson(Map<String, dynamic> json) {
  return _ReplyResult.fromJson(json);
}

/// @nodoc
mixin _$ReplyResult {
  bool get success => throw _privateConstructorUsedError;
  int? get postId => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Serializes this ReplyResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReplyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReplyResultCopyWith<ReplyResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyResultCopyWith<$Res> {
  factory $ReplyResultCopyWith(
    ReplyResult value,
    $Res Function(ReplyResult) then,
  ) = _$ReplyResultCopyWithImpl<$Res, ReplyResult>;
  @useResult
  $Res call({bool success, int? postId, String? errorMessage});
}

/// @nodoc
class _$ReplyResultCopyWithImpl<$Res, $Val extends ReplyResult>
    implements $ReplyResultCopyWith<$Res> {
  _$ReplyResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReplyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? postId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            postId: freezed == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as int?,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReplyResultImplCopyWith<$Res>
    implements $ReplyResultCopyWith<$Res> {
  factory _$$ReplyResultImplCopyWith(
    _$ReplyResultImpl value,
    $Res Function(_$ReplyResultImpl) then,
  ) = __$$ReplyResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool success, int? postId, String? errorMessage});
}

/// @nodoc
class __$$ReplyResultImplCopyWithImpl<$Res>
    extends _$ReplyResultCopyWithImpl<$Res, _$ReplyResultImpl>
    implements _$$ReplyResultImplCopyWith<$Res> {
  __$$ReplyResultImplCopyWithImpl(
    _$ReplyResultImpl _value,
    $Res Function(_$ReplyResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReplyResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? postId = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _$ReplyResultImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        postId: freezed == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as int?,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ReplyResultImpl implements _ReplyResult {
  const _$ReplyResultImpl({
    this.success = false,
    this.postId,
    this.errorMessage,
  });

  factory _$ReplyResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReplyResultImplFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  final int? postId;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'ReplyResult(success: $success, postId: $postId, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, success, postId, errorMessage);

  /// Create a copy of ReplyResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyResultImplCopyWith<_$ReplyResultImpl> get copyWith =>
      __$$ReplyResultImplCopyWithImpl<_$ReplyResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReplyResultImplToJson(this);
  }
}

abstract class _ReplyResult implements ReplyResult {
  const factory _ReplyResult({
    final bool success,
    final int? postId,
    final String? errorMessage,
  }) = _$ReplyResultImpl;

  factory _ReplyResult.fromJson(Map<String, dynamic> json) =
      _$ReplyResultImpl.fromJson;

  @override
  bool get success;
  @override
  int? get postId;
  @override
  String? get errorMessage;

  /// Create a copy of ReplyResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplyResultImplCopyWith<_$ReplyResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
