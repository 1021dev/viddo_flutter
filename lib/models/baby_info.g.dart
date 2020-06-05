// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BabyInfo _$BabyInfoFromJson(Map<String, dynamic> json) {
  return BabyInfo(
    name: json['name'] as String,
    objectId: json['objectId'] as int,
    cover: json['cover'] as String,
  );
}

Map<String, dynamic> _$BabyInfoToJson(BabyInfo instance) => <String, dynamic>{
      'name': instance.name,
      'objectId': instance.objectId,
      'cover': instance.cover,
    };
