// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendModel _$FriendModelFromJson(Map<String, dynamic> json) {
  return FriendModel(
    nikeName: json['nikeName'] as String,
    objectId: json['objectId'] as int,
    gender: json['gender'] as String,
    birthDay: json['birthDay'] as int,
    area: json['area'] as String,
    avatar: json['avatar'] as String,
    relationShip: json['relationShip'] as bool,
    isCreator: json['isCreator'] as bool,
  );
}

Map<String, dynamic> _$FriendModelToJson(FriendModel instance) =>
    <String, dynamic>{
      'nikeName': instance.nikeName,
      'objectId': instance.objectId,
      'gender': instance.gender,
      'birthDay': instance.birthDay,
      'area': instance.area,
      'avatar': instance.avatar,
      'relationShip': instance.relationShip,
      'isCreator': instance.isCreator,
    };
