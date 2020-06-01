// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return UserModel(
    nikeName: json['nikeName'] as String,
    objectId: json['objectId'] as int,
    gender: json['gender'] as String,
    birthDay: json['birthDay'] as int,
    area: json['area'] as String,
    avatar: json['avatar'] as String,
    email: json['email'] as String,
    account: json['account'] as String,
    vertical: json['vertical'] as bool,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'nikeName': instance.nikeName,
      'objectId': instance.objectId,
      'gender': instance.gender,
      'birthDay': instance.birthDay,
      'area': instance.area,
      'avatar': instance.avatar,
      'email': instance.email,
      'account': instance.account,
      'vertical': instance.vertical,
      'id': instance.id,
    };
