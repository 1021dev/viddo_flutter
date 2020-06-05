// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BabyModel _$BabyModelFromJson(Map<String, dynamic> json) {
  return BabyModel(
    name: json['name'] as String,
    objectId: json['objectId'] as int,
    gender: json['gender'] as String,
    birthDay: json['birthDay'] as int,
    cover: json['cover'] as String,
    avatar: json['avatar'] as String,
    relationship: json['relationship'] as String,
    expectedDate: json['expectedDate'] as int,
    isCreator: json['isCreator'] as bool,
    inviteCode: json['inviteCode'] as String,
    isBirth: json['isBirth'] as bool,
    refresh: json['refresh'] as bool,
  );
}

Map<String, dynamic> _$BabyModelToJson(BabyModel instance) => <String, dynamic>{
      'name': instance.name,
      'objectId': instance.objectId,
      'gender': instance.gender,
      'birthDay': instance.birthDay,
      'relationship': instance.relationship,
      'avatar': instance.avatar,
      'cover': instance.cover,
      'expectedDate': instance.expectedDate,
      'isCreator': instance.isCreator,
      'inviteCode': instance.inviteCode,
      'isBirth': instance.isBirth,
      'refresh': instance.refresh,
    };
