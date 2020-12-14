// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_creator.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicCreator _$DynamicCreatorFromJson(Map<String, dynamic> json) {
  return DynamicCreator(
    avatar: json['avatar'] as String,
    name: json['name'] as String,
    objectId: json['objectId'] as int,
    nickName: json['nickName'] as String,
  );
}

Map<String, dynamic> _$DynamicCreatorToJson(DynamicCreator instance) =>
    <String, dynamic>{
      'avatar': instance.avatar,
      'name': instance.name,
      'objectId': instance.objectId,
      'nickName': instance.nickName,
    };
