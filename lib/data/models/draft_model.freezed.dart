// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'draft_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DraftModel _$DraftModelFromJson(Map<String, dynamic> json) {
  return _DraftModel.fromJson(json);
}

/// @nodoc
mixin _$DraftModel {
  int get topicId => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get savedAt => throw _privateConstructorUsedError;
  int? get replyToPostNumber => throw _privateConstructorUsedError;
  String? get replyToUsername => throw _privateConstructorUsedError;

  /// Serializes this DraftModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DraftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DraftModelCopyWith<DraftModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DraftModelCopyWith<$Res> {
  factory $DraftModelCopyWith(
    DraftModel value,
    $Res Function(DraftModel) then,
  ) = _$DraftModelCopyWithImpl<$Res, DraftModel>;
  @useResult
  $Res call({
    int topicId,
    String content,
    String savedAt,
    int? replyToPostNumber,
    String? replyToUsername,
  });
}

/// @nodoc
class _$DraftModelCopyWithImpl<$Res, $Val extends DraftModel>
    implements $DraftModelCopyWith<$Res> {
  _$DraftModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DraftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = null,
    Object? content = null,
    Object? savedAt = null,
    Object? replyToPostNumber = freezed,
    Object? replyToUsername = freezed,
  }) {
    return _then(
      _value.copyWith(
            topicId: null == topicId
                ? _value.topicId
                : topicId // ignore: cast_nullable_to_non_nullable
                      as int,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            savedAt: null == savedAt
                ? _value.savedAt
                : savedAt // ignore: cast_nullable_to_non_nullable
                      as String,
            replyToPostNumber: freezed == replyToPostNumber
                ? _value.replyToPostNumber
                : replyToPostNumber // ignore: cast_nullable_to_non_nullable
                      as int?,
            replyToUsername: freezed == replyToUsername
                ? _value.replyToUsername
                : replyToUsername // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DraftModelImplCopyWith<$Res>
    implements $DraftModelCopyWith<$Res> {
  factory _$$DraftModelImplCopyWith(
    _$DraftModelImpl value,
    $Res Function(_$DraftModelImpl) then,
  ) = __$$DraftModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int topicId,
    String content,
    String savedAt,
    int? replyToPostNumber,
    String? replyToUsername,
  });
}

/// @nodoc
class __$$DraftModelImplCopyWithImpl<$Res>
    extends _$DraftModelCopyWithImpl<$Res, _$DraftModelImpl>
    implements _$$DraftModelImplCopyWith<$Res> {
  __$$DraftModelImplCopyWithImpl(
    _$DraftModelImpl _value,
    $Res Function(_$DraftModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DraftModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topicId = null,
    Object? content = null,
    Object? savedAt = null,
    Object? replyToPostNumber = freezed,
    Object? replyToUsername = freezed,
  }) {
    return _then(
      _$DraftModelImpl(
        topicId: null == topicId
            ? _value.topicId
            : topicId // ignore: cast_nullable_to_non_nullable
                  as int,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        savedAt: null == savedAt
            ? _value.savedAt
            : savedAt // ignore: cast_nullable_to_non_nullable
                  as String,
        replyToPostNumber: freezed == replyToPostNumber
            ? _value.replyToPostNumber
            : replyToPostNumber // ignore: cast_nullable_to_non_nullable
                  as int?,
        replyToUsername: freezed == replyToUsername
            ? _value.replyToUsername
            : replyToUsername // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DraftModelImpl implements _DraftModel {
  const _$DraftModelImpl({
    required this.topicId,
    required this.content,
    required this.savedAt,
    this.replyToPostNumber,
    this.replyToUsername,
  });

  factory _$DraftModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DraftModelImplFromJson(json);

  @override
  final int topicId;
  @override
  final String content;
  @override
  final String savedAt;
  @override
  final int? replyToPostNumber;
  @override
  final String? replyToUsername;

  @override
  String toString() {
    return 'DraftModel(topicId: $topicId, content: $content, savedAt: $savedAt, replyToPostNumber: $replyToPostNumber, replyToUsername: $replyToUsername)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DraftModelImpl &&
            (identical(other.topicId, topicId) || other.topicId == topicId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            (identical(other.replyToPostNumber, replyToPostNumber) ||
                other.replyToPostNumber == replyToPostNumber) &&
            (identical(other.replyToUsername, replyToUsername) ||
                other.replyToUsername == replyToUsername));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    topicId,
    content,
    savedAt,
    replyToPostNumber,
    replyToUsername,
  );

  /// Create a copy of DraftModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DraftModelImplCopyWith<_$DraftModelImpl> get copyWith =>
      __$$DraftModelImplCopyWithImpl<_$DraftModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DraftModelImplToJson(this);
  }
}

abstract class _DraftModel implements DraftModel {
  const factory _DraftModel({
    required final int topicId,
    required final String content,
    required final String savedAt,
    final int? replyToPostNumber,
    final String? replyToUsername,
  }) = _$DraftModelImpl;

  factory _DraftModel.fromJson(Map<String, dynamic> json) =
      _$DraftModelImpl.fromJson;

  @override
  int get topicId;
  @override
  String get content;
  @override
  String get savedAt;
  @override
  int? get replyToPostNumber;
  @override
  String? get replyToUsername;

  /// Create a copy of DraftModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DraftModelImplCopyWith<_$DraftModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
