// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_draft_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$FeedDraftState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSaving => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool get draftSaved => throw _privateConstructorUsedError;
  DateTime? get lastSavedAt => throw _privateConstructorUsedError;
  bool get hasDraft => throw _privateConstructorUsedError;
  FeedDraftData? get draftData => throw _privateConstructorUsedError;

  /// Create a copy of FeedDraftState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedDraftStateCopyWith<FeedDraftState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedDraftStateCopyWith<$Res> {
  factory $FeedDraftStateCopyWith(
    FeedDraftState value,
    $Res Function(FeedDraftState) then,
  ) = _$FeedDraftStateCopyWithImpl<$Res, FeedDraftState>;
  @useResult
  $Res call({
    bool isLoading,
    bool isSaving,
    String? error,
    bool draftSaved,
    DateTime? lastSavedAt,
    bool hasDraft,
    FeedDraftData? draftData,
  });

  $FeedDraftDataCopyWith<$Res>? get draftData;
}

/// @nodoc
class _$FeedDraftStateCopyWithImpl<$Res, $Val extends FeedDraftState>
    implements $FeedDraftStateCopyWith<$Res> {
  _$FeedDraftStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedDraftState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? error = freezed,
    Object? draftSaved = null,
    Object? lastSavedAt = freezed,
    Object? hasDraft = null,
    Object? draftData = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSaving: null == isSaving
                ? _value.isSaving
                : isSaving // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            draftSaved: null == draftSaved
                ? _value.draftSaved
                : draftSaved // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastSavedAt: freezed == lastSavedAt
                ? _value.lastSavedAt
                : lastSavedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            hasDraft: null == hasDraft
                ? _value.hasDraft
                : hasDraft // ignore: cast_nullable_to_non_nullable
                      as bool,
            draftData: freezed == draftData
                ? _value.draftData
                : draftData // ignore: cast_nullable_to_non_nullable
                      as FeedDraftData?,
          )
          as $Val,
    );
  }

  /// Create a copy of FeedDraftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FeedDraftDataCopyWith<$Res>? get draftData {
    if (_value.draftData == null) {
      return null;
    }

    return $FeedDraftDataCopyWith<$Res>(_value.draftData!, (value) {
      return _then(_value.copyWith(draftData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FeedDraftStateImplCopyWith<$Res>
    implements $FeedDraftStateCopyWith<$Res> {
  factory _$$FeedDraftStateImplCopyWith(
    _$FeedDraftStateImpl value,
    $Res Function(_$FeedDraftStateImpl) then,
  ) = __$$FeedDraftStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    bool isSaving,
    String? error,
    bool draftSaved,
    DateTime? lastSavedAt,
    bool hasDraft,
    FeedDraftData? draftData,
  });

  @override
  $FeedDraftDataCopyWith<$Res>? get draftData;
}

/// @nodoc
class __$$FeedDraftStateImplCopyWithImpl<$Res>
    extends _$FeedDraftStateCopyWithImpl<$Res, _$FeedDraftStateImpl>
    implements _$$FeedDraftStateImplCopyWith<$Res> {
  __$$FeedDraftStateImplCopyWithImpl(
    _$FeedDraftStateImpl _value,
    $Res Function(_$FeedDraftStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedDraftState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isSaving = null,
    Object? error = freezed,
    Object? draftSaved = null,
    Object? lastSavedAt = freezed,
    Object? hasDraft = null,
    Object? draftData = freezed,
  }) {
    return _then(
      _$FeedDraftStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSaving: null == isSaving
            ? _value.isSaving
            : isSaving // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        draftSaved: null == draftSaved
            ? _value.draftSaved
            : draftSaved // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastSavedAt: freezed == lastSavedAt
            ? _value.lastSavedAt
            : lastSavedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        hasDraft: null == hasDraft
            ? _value.hasDraft
            : hasDraft // ignore: cast_nullable_to_non_nullable
                  as bool,
        draftData: freezed == draftData
            ? _value.draftData
            : draftData // ignore: cast_nullable_to_non_nullable
                  as FeedDraftData?,
      ),
    );
  }
}

/// @nodoc

class _$FeedDraftStateImpl implements _FeedDraftState {
  const _$FeedDraftStateImpl({
    this.isLoading = false,
    this.isSaving = false,
    this.error,
    this.draftSaved = false,
    this.lastSavedAt,
    this.hasDraft = false,
    this.draftData,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isSaving;
  @override
  final String? error;
  @override
  @JsonKey()
  final bool draftSaved;
  @override
  final DateTime? lastSavedAt;
  @override
  @JsonKey()
  final bool hasDraft;
  @override
  final FeedDraftData? draftData;

  @override
  String toString() {
    return 'FeedDraftState(isLoading: $isLoading, isSaving: $isSaving, error: $error, draftSaved: $draftSaved, lastSavedAt: $lastSavedAt, hasDraft: $hasDraft, draftData: $draftData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedDraftStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSaving, isSaving) ||
                other.isSaving == isSaving) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.draftSaved, draftSaved) ||
                other.draftSaved == draftSaved) &&
            (identical(other.lastSavedAt, lastSavedAt) ||
                other.lastSavedAt == lastSavedAt) &&
            (identical(other.hasDraft, hasDraft) ||
                other.hasDraft == hasDraft) &&
            (identical(other.draftData, draftData) ||
                other.draftData == draftData));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    isSaving,
    error,
    draftSaved,
    lastSavedAt,
    hasDraft,
    draftData,
  );

  /// Create a copy of FeedDraftState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedDraftStateImplCopyWith<_$FeedDraftStateImpl> get copyWith =>
      __$$FeedDraftStateImplCopyWithImpl<_$FeedDraftStateImpl>(
        this,
        _$identity,
      );
}

abstract class _FeedDraftState implements FeedDraftState {
  const factory _FeedDraftState({
    final bool isLoading,
    final bool isSaving,
    final String? error,
    final bool draftSaved,
    final DateTime? lastSavedAt,
    final bool hasDraft,
    final FeedDraftData? draftData,
  }) = _$FeedDraftStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isSaving;
  @override
  String? get error;
  @override
  bool get draftSaved;
  @override
  DateTime? get lastSavedAt;
  @override
  bool get hasDraft;
  @override
  FeedDraftData? get draftData;

  /// Create a copy of FeedDraftState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedDraftStateImplCopyWith<_$FeedDraftStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FeedDraftData _$FeedDraftDataFromJson(Map<String, dynamic> json) {
  return _FeedDraftData.fromJson(json);
}

/// @nodoc
mixin _$FeedDraftData {
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  String get layoutMode => throw _privateConstructorUsedError;
  DateTime get savedAt => throw _privateConstructorUsedError;

  /// Serializes this FeedDraftData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FeedDraftData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FeedDraftDataCopyWith<FeedDraftData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedDraftDataCopyWith<$Res> {
  factory $FeedDraftDataCopyWith(
    FeedDraftData value,
    $Res Function(FeedDraftData) then,
  ) = _$FeedDraftDataCopyWithImpl<$Res, FeedDraftData>;
  @useResult
  $Res call({
    String title,
    String content,
    String category,
    List<String> tags,
    String layoutMode,
    DateTime savedAt,
  });
}

/// @nodoc
class _$FeedDraftDataCopyWithImpl<$Res, $Val extends FeedDraftData>
    implements $FeedDraftDataCopyWith<$Res> {
  _$FeedDraftDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FeedDraftData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? category = null,
    Object? tags = null,
    Object? layoutMode = null,
    Object? savedAt = null,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            layoutMode: null == layoutMode
                ? _value.layoutMode
                : layoutMode // ignore: cast_nullable_to_non_nullable
                      as String,
            savedAt: null == savedAt
                ? _value.savedAt
                : savedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FeedDraftDataImplCopyWith<$Res>
    implements $FeedDraftDataCopyWith<$Res> {
  factory _$$FeedDraftDataImplCopyWith(
    _$FeedDraftDataImpl value,
    $Res Function(_$FeedDraftDataImpl) then,
  ) = __$$FeedDraftDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String content,
    String category,
    List<String> tags,
    String layoutMode,
    DateTime savedAt,
  });
}

/// @nodoc
class __$$FeedDraftDataImplCopyWithImpl<$Res>
    extends _$FeedDraftDataCopyWithImpl<$Res, _$FeedDraftDataImpl>
    implements _$$FeedDraftDataImplCopyWith<$Res> {
  __$$FeedDraftDataImplCopyWithImpl(
    _$FeedDraftDataImpl _value,
    $Res Function(_$FeedDraftDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FeedDraftData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? content = null,
    Object? category = null,
    Object? tags = null,
    Object? layoutMode = null,
    Object? savedAt = null,
  }) {
    return _then(
      _$FeedDraftDataImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        layoutMode: null == layoutMode
            ? _value.layoutMode
            : layoutMode // ignore: cast_nullable_to_non_nullable
                  as String,
        savedAt: null == savedAt
            ? _value.savedAt
            : savedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FeedDraftDataImpl implements _FeedDraftData {
  const _$FeedDraftDataImpl({
    required this.title,
    required this.content,
    required this.category,
    final List<String> tags = const [],
    this.layoutMode = 'cover',
    required this.savedAt,
  }) : _tags = tags;

  factory _$FeedDraftDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeedDraftDataImplFromJson(json);

  @override
  final String title;
  @override
  final String content;
  @override
  final String category;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  @JsonKey()
  final String layoutMode;
  @override
  final DateTime savedAt;

  @override
  String toString() {
    return 'FeedDraftData(title: $title, content: $content, category: $category, tags: $tags, layoutMode: $layoutMode, savedAt: $savedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedDraftDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.layoutMode, layoutMode) ||
                other.layoutMode == layoutMode) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    content,
    category,
    const DeepCollectionEquality().hash(_tags),
    layoutMode,
    savedAt,
  );

  /// Create a copy of FeedDraftData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedDraftDataImplCopyWith<_$FeedDraftDataImpl> get copyWith =>
      __$$FeedDraftDataImplCopyWithImpl<_$FeedDraftDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeedDraftDataImplToJson(this);
  }
}

abstract class _FeedDraftData implements FeedDraftData {
  const factory _FeedDraftData({
    required final String title,
    required final String content,
    required final String category,
    final List<String> tags,
    final String layoutMode,
    required final DateTime savedAt,
  }) = _$FeedDraftDataImpl;

  factory _FeedDraftData.fromJson(Map<String, dynamic> json) =
      _$FeedDraftDataImpl.fromJson;

  @override
  String get title;
  @override
  String get content;
  @override
  String get category;
  @override
  List<String> get tags;
  @override
  String get layoutMode;
  @override
  DateTime get savedAt;

  /// Create a copy of FeedDraftData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FeedDraftDataImplCopyWith<_$FeedDraftDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
