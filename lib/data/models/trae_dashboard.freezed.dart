// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trae_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TraeUserStats _$TraeUserStatsFromJson(Map<String, dynamic> json) {
  return _TraeUserStats.fromJson(json);
}

/// @nodoc
mixin _$TraeUserStats {
  @JsonKey(name: 'UserID')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'RegisterDays')
  int get registerDays => throw _privateConstructorUsedError;
  @JsonKey(name: 'AiCnt365d')
  Map<String, int> get dailyActivity => throw _privateConstructorUsedError;
  @JsonKey(name: 'CodeAiAcceptCnt7d')
  int get codeAcceptCount7d => throw _privateConstructorUsedError;
  @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
  Map<String, int> get languageStats => throw _privateConstructorUsedError;
  @JsonKey(name: 'CodeCompCnt7d')
  int get conversationCount7d => throw _privateConstructorUsedError;
  @JsonKey(name: 'CodeCompDiffAgentCnt7d')
  Map<String, int> get agentStats => throw _privateConstructorUsedError;
  @JsonKey(name: 'CodeCompDiffModelCnt7d')
  Map<String, int> get modelStats => throw _privateConstructorUsedError;
  @JsonKey(name: 'IdeActiveDiffHourCnt7d')
  Map<String, int> get hourlyActivity => throw _privateConstructorUsedError;
  @JsonKey(name: 'DataDate')
  String get dataDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'IsIde')
  bool get isIde => throw _privateConstructorUsedError;

  /// Serializes this TraeUserStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TraeUserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TraeUserStatsCopyWith<TraeUserStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TraeUserStatsCopyWith<$Res> {
  factory $TraeUserStatsCopyWith(
    TraeUserStats value,
    $Res Function(TraeUserStats) then,
  ) = _$TraeUserStatsCopyWithImpl<$Res, TraeUserStats>;
  @useResult
  $Res call({
    @JsonKey(name: 'UserID') String userId,
    @JsonKey(name: 'RegisterDays') int registerDays,
    @JsonKey(name: 'AiCnt365d') Map<String, int> dailyActivity,
    @JsonKey(name: 'CodeAiAcceptCnt7d') int codeAcceptCount7d,
    @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
    Map<String, int> languageStats,
    @JsonKey(name: 'CodeCompCnt7d') int conversationCount7d,
    @JsonKey(name: 'CodeCompDiffAgentCnt7d') Map<String, int> agentStats,
    @JsonKey(name: 'CodeCompDiffModelCnt7d') Map<String, int> modelStats,
    @JsonKey(name: 'IdeActiveDiffHourCnt7d') Map<String, int> hourlyActivity,
    @JsonKey(name: 'DataDate') String dataDate,
    @JsonKey(name: 'IsIde') bool isIde,
  });
}

/// @nodoc
class _$TraeUserStatsCopyWithImpl<$Res, $Val extends TraeUserStats>
    implements $TraeUserStatsCopyWith<$Res> {
  _$TraeUserStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TraeUserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? registerDays = null,
    Object? dailyActivity = null,
    Object? codeAcceptCount7d = null,
    Object? languageStats = null,
    Object? conversationCount7d = null,
    Object? agentStats = null,
    Object? modelStats = null,
    Object? hourlyActivity = null,
    Object? dataDate = null,
    Object? isIde = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            registerDays: null == registerDays
                ? _value.registerDays
                : registerDays // ignore: cast_nullable_to_non_nullable
                      as int,
            dailyActivity: null == dailyActivity
                ? _value.dailyActivity
                : dailyActivity // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            codeAcceptCount7d: null == codeAcceptCount7d
                ? _value.codeAcceptCount7d
                : codeAcceptCount7d // ignore: cast_nullable_to_non_nullable
                      as int,
            languageStats: null == languageStats
                ? _value.languageStats
                : languageStats // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            conversationCount7d: null == conversationCount7d
                ? _value.conversationCount7d
                : conversationCount7d // ignore: cast_nullable_to_non_nullable
                      as int,
            agentStats: null == agentStats
                ? _value.agentStats
                : agentStats // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            modelStats: null == modelStats
                ? _value.modelStats
                : modelStats // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            hourlyActivity: null == hourlyActivity
                ? _value.hourlyActivity
                : hourlyActivity // ignore: cast_nullable_to_non_nullable
                      as Map<String, int>,
            dataDate: null == dataDate
                ? _value.dataDate
                : dataDate // ignore: cast_nullable_to_non_nullable
                      as String,
            isIde: null == isIde
                ? _value.isIde
                : isIde // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TraeUserStatsImplCopyWith<$Res>
    implements $TraeUserStatsCopyWith<$Res> {
  factory _$$TraeUserStatsImplCopyWith(
    _$TraeUserStatsImpl value,
    $Res Function(_$TraeUserStatsImpl) then,
  ) = __$$TraeUserStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'UserID') String userId,
    @JsonKey(name: 'RegisterDays') int registerDays,
    @JsonKey(name: 'AiCnt365d') Map<String, int> dailyActivity,
    @JsonKey(name: 'CodeAiAcceptCnt7d') int codeAcceptCount7d,
    @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
    Map<String, int> languageStats,
    @JsonKey(name: 'CodeCompCnt7d') int conversationCount7d,
    @JsonKey(name: 'CodeCompDiffAgentCnt7d') Map<String, int> agentStats,
    @JsonKey(name: 'CodeCompDiffModelCnt7d') Map<String, int> modelStats,
    @JsonKey(name: 'IdeActiveDiffHourCnt7d') Map<String, int> hourlyActivity,
    @JsonKey(name: 'DataDate') String dataDate,
    @JsonKey(name: 'IsIde') bool isIde,
  });
}

/// @nodoc
class __$$TraeUserStatsImplCopyWithImpl<$Res>
    extends _$TraeUserStatsCopyWithImpl<$Res, _$TraeUserStatsImpl>
    implements _$$TraeUserStatsImplCopyWith<$Res> {
  __$$TraeUserStatsImplCopyWithImpl(
    _$TraeUserStatsImpl _value,
    $Res Function(_$TraeUserStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TraeUserStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? registerDays = null,
    Object? dailyActivity = null,
    Object? codeAcceptCount7d = null,
    Object? languageStats = null,
    Object? conversationCount7d = null,
    Object? agentStats = null,
    Object? modelStats = null,
    Object? hourlyActivity = null,
    Object? dataDate = null,
    Object? isIde = null,
  }) {
    return _then(
      _$TraeUserStatsImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        registerDays: null == registerDays
            ? _value.registerDays
            : registerDays // ignore: cast_nullable_to_non_nullable
                  as int,
        dailyActivity: null == dailyActivity
            ? _value._dailyActivity
            : dailyActivity // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        codeAcceptCount7d: null == codeAcceptCount7d
            ? _value.codeAcceptCount7d
            : codeAcceptCount7d // ignore: cast_nullable_to_non_nullable
                  as int,
        languageStats: null == languageStats
            ? _value._languageStats
            : languageStats // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        conversationCount7d: null == conversationCount7d
            ? _value.conversationCount7d
            : conversationCount7d // ignore: cast_nullable_to_non_nullable
                  as int,
        agentStats: null == agentStats
            ? _value._agentStats
            : agentStats // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        modelStats: null == modelStats
            ? _value._modelStats
            : modelStats // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        hourlyActivity: null == hourlyActivity
            ? _value._hourlyActivity
            : hourlyActivity // ignore: cast_nullable_to_non_nullable
                  as Map<String, int>,
        dataDate: null == dataDate
            ? _value.dataDate
            : dataDate // ignore: cast_nullable_to_non_nullable
                  as String,
        isIde: null == isIde
            ? _value.isIde
            : isIde // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TraeUserStatsImpl implements _TraeUserStats {
  const _$TraeUserStatsImpl({
    @JsonKey(name: 'UserID') required this.userId,
    @JsonKey(name: 'RegisterDays') required this.registerDays,
    @JsonKey(name: 'AiCnt365d') required final Map<String, int> dailyActivity,
    @JsonKey(name: 'CodeAiAcceptCnt7d') required this.codeAcceptCount7d,
    @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
    required final Map<String, int> languageStats,
    @JsonKey(name: 'CodeCompCnt7d') required this.conversationCount7d,
    @JsonKey(name: 'CodeCompDiffAgentCnt7d')
    required final Map<String, int> agentStats,
    @JsonKey(name: 'CodeCompDiffModelCnt7d')
    required final Map<String, int> modelStats,
    @JsonKey(name: 'IdeActiveDiffHourCnt7d')
    required final Map<String, int> hourlyActivity,
    @JsonKey(name: 'DataDate') required this.dataDate,
    @JsonKey(name: 'IsIde') this.isIde = true,
  }) : _dailyActivity = dailyActivity,
       _languageStats = languageStats,
       _agentStats = agentStats,
       _modelStats = modelStats,
       _hourlyActivity = hourlyActivity;

  factory _$TraeUserStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$TraeUserStatsImplFromJson(json);

  @override
  @JsonKey(name: 'UserID')
  final String userId;
  @override
  @JsonKey(name: 'RegisterDays')
  final int registerDays;
  final Map<String, int> _dailyActivity;
  @override
  @JsonKey(name: 'AiCnt365d')
  Map<String, int> get dailyActivity {
    if (_dailyActivity is EqualUnmodifiableMapView) return _dailyActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_dailyActivity);
  }

  @override
  @JsonKey(name: 'CodeAiAcceptCnt7d')
  final int codeAcceptCount7d;
  final Map<String, int> _languageStats;
  @override
  @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
  Map<String, int> get languageStats {
    if (_languageStats is EqualUnmodifiableMapView) return _languageStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_languageStats);
  }

  @override
  @JsonKey(name: 'CodeCompCnt7d')
  final int conversationCount7d;
  final Map<String, int> _agentStats;
  @override
  @JsonKey(name: 'CodeCompDiffAgentCnt7d')
  Map<String, int> get agentStats {
    if (_agentStats is EqualUnmodifiableMapView) return _agentStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_agentStats);
  }

  final Map<String, int> _modelStats;
  @override
  @JsonKey(name: 'CodeCompDiffModelCnt7d')
  Map<String, int> get modelStats {
    if (_modelStats is EqualUnmodifiableMapView) return _modelStats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_modelStats);
  }

  final Map<String, int> _hourlyActivity;
  @override
  @JsonKey(name: 'IdeActiveDiffHourCnt7d')
  Map<String, int> get hourlyActivity {
    if (_hourlyActivity is EqualUnmodifiableMapView) return _hourlyActivity;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_hourlyActivity);
  }

  @override
  @JsonKey(name: 'DataDate')
  final String dataDate;
  @override
  @JsonKey(name: 'IsIde')
  final bool isIde;

  @override
  String toString() {
    return 'TraeUserStats(userId: $userId, registerDays: $registerDays, dailyActivity: $dailyActivity, codeAcceptCount7d: $codeAcceptCount7d, languageStats: $languageStats, conversationCount7d: $conversationCount7d, agentStats: $agentStats, modelStats: $modelStats, hourlyActivity: $hourlyActivity, dataDate: $dataDate, isIde: $isIde)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TraeUserStatsImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.registerDays, registerDays) ||
                other.registerDays == registerDays) &&
            const DeepCollectionEquality().equals(
              other._dailyActivity,
              _dailyActivity,
            ) &&
            (identical(other.codeAcceptCount7d, codeAcceptCount7d) ||
                other.codeAcceptCount7d == codeAcceptCount7d) &&
            const DeepCollectionEquality().equals(
              other._languageStats,
              _languageStats,
            ) &&
            (identical(other.conversationCount7d, conversationCount7d) ||
                other.conversationCount7d == conversationCount7d) &&
            const DeepCollectionEquality().equals(
              other._agentStats,
              _agentStats,
            ) &&
            const DeepCollectionEquality().equals(
              other._modelStats,
              _modelStats,
            ) &&
            const DeepCollectionEquality().equals(
              other._hourlyActivity,
              _hourlyActivity,
            ) &&
            (identical(other.dataDate, dataDate) ||
                other.dataDate == dataDate) &&
            (identical(other.isIde, isIde) || other.isIde == isIde));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    registerDays,
    const DeepCollectionEquality().hash(_dailyActivity),
    codeAcceptCount7d,
    const DeepCollectionEquality().hash(_languageStats),
    conversationCount7d,
    const DeepCollectionEquality().hash(_agentStats),
    const DeepCollectionEquality().hash(_modelStats),
    const DeepCollectionEquality().hash(_hourlyActivity),
    dataDate,
    isIde,
  );

  /// Create a copy of TraeUserStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TraeUserStatsImplCopyWith<_$TraeUserStatsImpl> get copyWith =>
      __$$TraeUserStatsImplCopyWithImpl<_$TraeUserStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TraeUserStatsImplToJson(this);
  }
}

abstract class _TraeUserStats implements TraeUserStats {
  const factory _TraeUserStats({
    @JsonKey(name: 'UserID') required final String userId,
    @JsonKey(name: 'RegisterDays') required final int registerDays,
    @JsonKey(name: 'AiCnt365d') required final Map<String, int> dailyActivity,
    @JsonKey(name: 'CodeAiAcceptCnt7d') required final int codeAcceptCount7d,
    @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
    required final Map<String, int> languageStats,
    @JsonKey(name: 'CodeCompCnt7d') required final int conversationCount7d,
    @JsonKey(name: 'CodeCompDiffAgentCnt7d')
    required final Map<String, int> agentStats,
    @JsonKey(name: 'CodeCompDiffModelCnt7d')
    required final Map<String, int> modelStats,
    @JsonKey(name: 'IdeActiveDiffHourCnt7d')
    required final Map<String, int> hourlyActivity,
    @JsonKey(name: 'DataDate') required final String dataDate,
    @JsonKey(name: 'IsIde') final bool isIde,
  }) = _$TraeUserStatsImpl;

  factory _TraeUserStats.fromJson(Map<String, dynamic> json) =
      _$TraeUserStatsImpl.fromJson;

  @override
  @JsonKey(name: 'UserID')
  String get userId;
  @override
  @JsonKey(name: 'RegisterDays')
  int get registerDays;
  @override
  @JsonKey(name: 'AiCnt365d')
  Map<String, int> get dailyActivity;
  @override
  @JsonKey(name: 'CodeAiAcceptCnt7d')
  int get codeAcceptCount7d;
  @override
  @JsonKey(name: 'CodeAiAcceptDiffLanguageCnt7d')
  Map<String, int> get languageStats;
  @override
  @JsonKey(name: 'CodeCompCnt7d')
  int get conversationCount7d;
  @override
  @JsonKey(name: 'CodeCompDiffAgentCnt7d')
  Map<String, int> get agentStats;
  @override
  @JsonKey(name: 'CodeCompDiffModelCnt7d')
  Map<String, int> get modelStats;
  @override
  @JsonKey(name: 'IdeActiveDiffHourCnt7d')
  Map<String, int> get hourlyActivity;
  @override
  @JsonKey(name: 'DataDate')
  String get dataDate;
  @override
  @JsonKey(name: 'IsIde')
  bool get isIde;

  /// Create a copy of TraeUserStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TraeUserStatsImplCopyWith<_$TraeUserStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TraeUserInfo _$TraeUserInfoFromJson(Map<String, dynamic> json) {
  return _TraeUserInfo.fromJson(json);
}

/// @nodoc
mixin _$TraeUserInfo {
  @JsonKey(name: 'UserID')
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'ScreenName')
  String get screenName => throw _privateConstructorUsedError;
  @JsonKey(name: 'AvatarUrl')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'RegisterTime')
  String? get registerTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'LastLoginTime')
  String? get lastLoginTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'Region')
  String get region => throw _privateConstructorUsedError;

  /// Serializes this TraeUserInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TraeUserInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TraeUserInfoCopyWith<TraeUserInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TraeUserInfoCopyWith<$Res> {
  factory $TraeUserInfoCopyWith(
    TraeUserInfo value,
    $Res Function(TraeUserInfo) then,
  ) = _$TraeUserInfoCopyWithImpl<$Res, TraeUserInfo>;
  @useResult
  $Res call({
    @JsonKey(name: 'UserID') String userId,
    @JsonKey(name: 'ScreenName') String screenName,
    @JsonKey(name: 'AvatarUrl') String? avatarUrl,
    @JsonKey(name: 'RegisterTime') String? registerTime,
    @JsonKey(name: 'LastLoginTime') String? lastLoginTime,
    @JsonKey(name: 'Region') String region,
  });
}

/// @nodoc
class _$TraeUserInfoCopyWithImpl<$Res, $Val extends TraeUserInfo>
    implements $TraeUserInfoCopyWith<$Res> {
  _$TraeUserInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TraeUserInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? screenName = null,
    Object? avatarUrl = freezed,
    Object? registerTime = freezed,
    Object? lastLoginTime = freezed,
    Object? region = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            screenName: null == screenName
                ? _value.screenName
                : screenName // ignore: cast_nullable_to_non_nullable
                      as String,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            registerTime: freezed == registerTime
                ? _value.registerTime
                : registerTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastLoginTime: freezed == lastLoginTime
                ? _value.lastLoginTime
                : lastLoginTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            region: null == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TraeUserInfoImplCopyWith<$Res>
    implements $TraeUserInfoCopyWith<$Res> {
  factory _$$TraeUserInfoImplCopyWith(
    _$TraeUserInfoImpl value,
    $Res Function(_$TraeUserInfoImpl) then,
  ) = __$$TraeUserInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'UserID') String userId,
    @JsonKey(name: 'ScreenName') String screenName,
    @JsonKey(name: 'AvatarUrl') String? avatarUrl,
    @JsonKey(name: 'RegisterTime') String? registerTime,
    @JsonKey(name: 'LastLoginTime') String? lastLoginTime,
    @JsonKey(name: 'Region') String region,
  });
}

/// @nodoc
class __$$TraeUserInfoImplCopyWithImpl<$Res>
    extends _$TraeUserInfoCopyWithImpl<$Res, _$TraeUserInfoImpl>
    implements _$$TraeUserInfoImplCopyWith<$Res> {
  __$$TraeUserInfoImplCopyWithImpl(
    _$TraeUserInfoImpl _value,
    $Res Function(_$TraeUserInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TraeUserInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? screenName = null,
    Object? avatarUrl = freezed,
    Object? registerTime = freezed,
    Object? lastLoginTime = freezed,
    Object? region = null,
  }) {
    return _then(
      _$TraeUserInfoImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        screenName: null == screenName
            ? _value.screenName
            : screenName // ignore: cast_nullable_to_non_nullable
                  as String,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        registerTime: freezed == registerTime
            ? _value.registerTime
            : registerTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastLoginTime: freezed == lastLoginTime
            ? _value.lastLoginTime
            : lastLoginTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        region: null == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TraeUserInfoImpl implements _TraeUserInfo {
  const _$TraeUserInfoImpl({
    @JsonKey(name: 'UserID') required this.userId,
    @JsonKey(name: 'ScreenName') required this.screenName,
    @JsonKey(name: 'AvatarUrl') this.avatarUrl,
    @JsonKey(name: 'RegisterTime') this.registerTime,
    @JsonKey(name: 'LastLoginTime') this.lastLoginTime,
    @JsonKey(name: 'Region') this.region = 'CN',
  });

  factory _$TraeUserInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TraeUserInfoImplFromJson(json);

  @override
  @JsonKey(name: 'UserID')
  final String userId;
  @override
  @JsonKey(name: 'ScreenName')
  final String screenName;
  @override
  @JsonKey(name: 'AvatarUrl')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'RegisterTime')
  final String? registerTime;
  @override
  @JsonKey(name: 'LastLoginTime')
  final String? lastLoginTime;
  @override
  @JsonKey(name: 'Region')
  final String region;

  @override
  String toString() {
    return 'TraeUserInfo(userId: $userId, screenName: $screenName, avatarUrl: $avatarUrl, registerTime: $registerTime, lastLoginTime: $lastLoginTime, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TraeUserInfoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.screenName, screenName) ||
                other.screenName == screenName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.registerTime, registerTime) ||
                other.registerTime == registerTime) &&
            (identical(other.lastLoginTime, lastLoginTime) ||
                other.lastLoginTime == lastLoginTime) &&
            (identical(other.region, region) || other.region == region));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    screenName,
    avatarUrl,
    registerTime,
    lastLoginTime,
    region,
  );

  /// Create a copy of TraeUserInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TraeUserInfoImplCopyWith<_$TraeUserInfoImpl> get copyWith =>
      __$$TraeUserInfoImplCopyWithImpl<_$TraeUserInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TraeUserInfoImplToJson(this);
  }
}

abstract class _TraeUserInfo implements TraeUserInfo {
  const factory _TraeUserInfo({
    @JsonKey(name: 'UserID') required final String userId,
    @JsonKey(name: 'ScreenName') required final String screenName,
    @JsonKey(name: 'AvatarUrl') final String? avatarUrl,
    @JsonKey(name: 'RegisterTime') final String? registerTime,
    @JsonKey(name: 'LastLoginTime') final String? lastLoginTime,
    @JsonKey(name: 'Region') final String region,
  }) = _$TraeUserInfoImpl;

  factory _TraeUserInfo.fromJson(Map<String, dynamic> json) =
      _$TraeUserInfoImpl.fromJson;

  @override
  @JsonKey(name: 'UserID')
  String get userId;
  @override
  @JsonKey(name: 'ScreenName')
  String get screenName;
  @override
  @JsonKey(name: 'AvatarUrl')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'RegisterTime')
  String? get registerTime;
  @override
  @JsonKey(name: 'LastLoginTime')
  String? get lastLoginTime;
  @override
  @JsonKey(name: 'Region')
  String get region;

  /// Create a copy of TraeUserInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TraeUserInfoImplCopyWith<_$TraeUserInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
