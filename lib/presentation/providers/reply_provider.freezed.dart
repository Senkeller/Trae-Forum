// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reply_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ReplyState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;
  int? get postId => throw _privateConstructorUsedError;
  bool get draftSaved => throw _privateConstructorUsedError;

  /// Create a copy of ReplyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReplyStateCopyWith<ReplyState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyStateCopyWith<$Res> {
  factory $ReplyStateCopyWith(
    ReplyState value,
    $Res Function(ReplyState) then,
  ) = _$ReplyStateCopyWithImpl<$Res, ReplyState>;
  @useResult
  $Res call({
    bool isLoading,
    String? error,
    bool success,
    int? postId,
    bool draftSaved,
  });
}

/// @nodoc
class _$ReplyStateCopyWithImpl<$Res, $Val extends ReplyState>
    implements $ReplyStateCopyWith<$Res> {
  _$ReplyStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReplyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? success = null,
    Object? postId = freezed,
    Object? draftSaved = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            postId: freezed == postId
                ? _value.postId
                : postId // ignore: cast_nullable_to_non_nullable
                      as int?,
            draftSaved: null == draftSaved
                ? _value.draftSaved
                : draftSaved // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReplyStateImplCopyWith<$Res>
    implements $ReplyStateCopyWith<$Res> {
  factory _$$ReplyStateImplCopyWith(
    _$ReplyStateImpl value,
    $Res Function(_$ReplyStateImpl) then,
  ) = __$$ReplyStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String? error,
    bool success,
    int? postId,
    bool draftSaved,
  });
}

/// @nodoc
class __$$ReplyStateImplCopyWithImpl<$Res>
    extends _$ReplyStateCopyWithImpl<$Res, _$ReplyStateImpl>
    implements _$$ReplyStateImplCopyWith<$Res> {
  __$$ReplyStateImplCopyWithImpl(
    _$ReplyStateImpl _value,
    $Res Function(_$ReplyStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReplyState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? success = null,
    Object? postId = freezed,
    Object? draftSaved = null,
  }) {
    return _then(
      _$ReplyStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        postId: freezed == postId
            ? _value.postId
            : postId // ignore: cast_nullable_to_non_nullable
                  as int?,
        draftSaved: null == draftSaved
            ? _value.draftSaved
            : draftSaved // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$ReplyStateImpl implements _ReplyState {
  const _$ReplyStateImpl({
    this.isLoading = false,
    this.error,
    this.success = false,
    this.postId,
    this.draftSaved = false,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool success;
  @override
  final int? postId;
  @override
  @JsonKey()
  final bool draftSaved;

  @override
  String toString() {
    return 'ReplyState(isLoading: $isLoading, error: $error, success: $success, postId: $postId, draftSaved: $draftSaved)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.draftSaved, draftSaved) ||
                other.draftSaved == draftSaved));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isLoading, error, success, postId, draftSaved);

  /// Create a copy of ReplyState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyStateImplCopyWith<_$ReplyStateImpl> get copyWith =>
      __$$ReplyStateImplCopyWithImpl<_$ReplyStateImpl>(this, _$identity);
}

abstract class _ReplyState implements ReplyState {
  const factory _ReplyState({
    final bool isLoading,
    final String? error,
    final bool success,
    final int? postId,
    final bool draftSaved,
  }) = _$ReplyStateImpl;

  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool get success;
  @override
  int? get postId;
  @override
  bool get draftSaved;

  /// Create a copy of ReplyState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplyStateImplCopyWith<_$ReplyStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ReplyTarget {
  int get postNumber => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReplyTargetCopyWith<ReplyTarget> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReplyTargetCopyWith<$Res> {
  factory $ReplyTargetCopyWith(
    ReplyTarget value,
    $Res Function(ReplyTarget) then,
  ) = _$ReplyTargetCopyWithImpl<$Res, ReplyTarget>;
  @useResult
  $Res call({int postNumber, String username, String? content});
}

/// @nodoc
class _$ReplyTargetCopyWithImpl<$Res, $Val extends ReplyTarget>
    implements $ReplyTargetCopyWith<$Res> {
  _$ReplyTargetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postNumber = null,
    Object? username = null,
    Object? content = freezed,
  }) {
    return _then(
      _value.copyWith(
            postNumber: null == postNumber
                ? _value.postNumber
                : postNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ReplyTargetImplCopyWith<$Res>
    implements $ReplyTargetCopyWith<$Res> {
  factory _$$ReplyTargetImplCopyWith(
    _$ReplyTargetImpl value,
    $Res Function(_$ReplyTargetImpl) then,
  ) = __$$ReplyTargetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int postNumber, String username, String? content});
}

/// @nodoc
class __$$ReplyTargetImplCopyWithImpl<$Res>
    extends _$ReplyTargetCopyWithImpl<$Res, _$ReplyTargetImpl>
    implements _$$ReplyTargetImplCopyWith<$Res> {
  __$$ReplyTargetImplCopyWithImpl(
    _$ReplyTargetImpl _value,
    $Res Function(_$ReplyTargetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? postNumber = null,
    Object? username = null,
    Object? content = freezed,
  }) {
    return _then(
      _$ReplyTargetImpl(
        postNumber: null == postNumber
            ? _value.postNumber
            : postNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$ReplyTargetImpl implements _ReplyTarget {
  const _$ReplyTargetImpl({
    required this.postNumber,
    required this.username,
    this.content,
  });

  @override
  final int postNumber;
  @override
  final String username;
  @override
  final String? content;

  @override
  String toString() {
    return 'ReplyTarget(postNumber: $postNumber, username: $username, content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReplyTargetImpl &&
            (identical(other.postNumber, postNumber) ||
                other.postNumber == postNumber) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode => Object.hash(runtimeType, postNumber, username, content);

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReplyTargetImplCopyWith<_$ReplyTargetImpl> get copyWith =>
      __$$ReplyTargetImplCopyWithImpl<_$ReplyTargetImpl>(this, _$identity);
}

abstract class _ReplyTarget implements ReplyTarget {
  const factory _ReplyTarget({
    required final int postNumber,
    required final String username,
    final String? content,
  }) = _$ReplyTargetImpl;

  @override
  int get postNumber;
  @override
  String get username;
  @override
  String? get content;

  /// Create a copy of ReplyTarget
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReplyTargetImplCopyWith<_$ReplyTargetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
