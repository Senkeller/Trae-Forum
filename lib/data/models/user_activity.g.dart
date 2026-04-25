// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_activity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalFavoriteAdapter extends TypeAdapter<LocalFavorite> {
  @override
  final typeId = 1;

  @override
  LocalFavorite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalFavorite(
      id: fields[0] as String,
      feedId: fields[1] as String,
      uid: fields[2] as String,
      username: fields[3] as String,
      avatarUrl: fields[4] as String,
      deviceTitle: fields[5] as String,
      message: fields[6] as String,
      dateline: fields[7] as String,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, LocalFavorite obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.feedId)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.avatarUrl)
      ..writeByte(5)
      ..write(obj.deviceTitle)
      ..writeByte(6)
      ..write(obj.message)
      ..writeByte(7)
      ..write(obj.dateline)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalFavoriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BrowseHistoryAdapter extends TypeAdapter<BrowseHistory> {
  @override
  final typeId = 2;

  @override
  BrowseHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BrowseHistory(
      id: fields[0] as String,
      feedId: fields[1] as String,
      uid: fields[2] as String,
      username: fields[3] as String,
      avatarUrl: fields[4] as String,
      deviceTitle: fields[5] as String,
      message: fields[6] as String,
      dateline: fields[7] as String,
      viewedAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BrowseHistory obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.feedId)
      ..writeByte(2)
      ..write(obj.uid)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.avatarUrl)
      ..writeByte(5)
      ..write(obj.deviceTitle)
      ..writeByte(6)
      ..write(obj.message)
      ..writeByte(7)
      ..write(obj.dateline)
      ..writeByte(8)
      ..write(obj.viewedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BrowseHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FrequentlyVisitedAdapter extends TypeAdapter<FrequentlyVisited> {
  @override
  final typeId = 3;

  @override
  FrequentlyVisited read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FrequentlyVisited(
      id: fields[0] as String,
      topicId: fields[1] as String,
      topicName: fields[2] as String,
      topicTag: fields[3] as String?,
      visitCount: (fields[4] as num).toInt(),
      lastVisitedAt: fields[5] as DateTime,
      coverUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FrequentlyVisited obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.topicId)
      ..writeByte(2)
      ..write(obj.topicName)
      ..writeByte(3)
      ..write(obj.topicTag)
      ..writeByte(4)
      ..write(obj.visitCount)
      ..writeByte(5)
      ..write(obj.lastVisitedAt)
      ..writeByte(6)
      ..write(obj.coverUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FrequentlyVisitedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocalFavoriteImpl _$$LocalFavoriteImplFromJson(Map<String, dynamic> json) =>
    _$LocalFavoriteImpl(
      id: json['id'] as String,
      feedId: json['feedId'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String,
      deviceTitle: json['deviceTitle'] as String,
      message: json['message'] as String,
      dateline: json['dateline'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$LocalFavoriteImplToJson(_$LocalFavoriteImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feedId': instance.feedId,
      'uid': instance.uid,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'deviceTitle': instance.deviceTitle,
      'message': instance.message,
      'dateline': instance.dateline,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$BrowseHistoryImpl _$$BrowseHistoryImplFromJson(Map<String, dynamic> json) =>
    _$BrowseHistoryImpl(
      id: json['id'] as String,
      feedId: json['feedId'] as String,
      uid: json['uid'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String,
      deviceTitle: json['deviceTitle'] as String,
      message: json['message'] as String,
      dateline: json['dateline'] as String,
      viewedAt: DateTime.parse(json['viewedAt'] as String),
    );

Map<String, dynamic> _$$BrowseHistoryImplToJson(_$BrowseHistoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'feedId': instance.feedId,
      'uid': instance.uid,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'deviceTitle': instance.deviceTitle,
      'message': instance.message,
      'dateline': instance.dateline,
      'viewedAt': instance.viewedAt.toIso8601String(),
    };

_$FrequentlyVisitedImpl _$$FrequentlyVisitedImplFromJson(
  Map<String, dynamic> json,
) => _$FrequentlyVisitedImpl(
  id: json['id'] as String,
  topicId: json['topicId'] as String,
  topicName: json['topicName'] as String,
  topicTag: json['topicTag'] as String?,
  visitCount: (json['visitCount'] as num).toInt(),
  lastVisitedAt: DateTime.parse(json['lastVisitedAt'] as String),
  coverUrl: json['coverUrl'] as String?,
);

Map<String, dynamic> _$$FrequentlyVisitedImplToJson(
  _$FrequentlyVisitedImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'topicId': instance.topicId,
  'topicName': instance.topicName,
  'topicTag': instance.topicTag,
  'visitCount': instance.visitCount,
  'lastVisitedAt': instance.lastVisitedAt.toIso8601String(),
  'coverUrl': instance.coverUrl,
};
