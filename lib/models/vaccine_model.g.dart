// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaccineModel _$VaccineModelFromJson(Map<String, dynamic> json) {
  return VaccineModel(
    objectId: json['objectId'] as int,
    title: json['title'] as String,
    status: json['status'] as String,
    planTime: json['planTime'] as int,
    realyTime: json['realyTime'] as int,
    introduce: json['introduce'] as String,
    alarmTime: json['alarmTime'] as int,
    birth: json['birth'] as int,
    timeTerval: json['timeTerval'] as String,
  );
}

Map<String, dynamic> _$VaccineModelToJson(VaccineModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'title': instance.title,
      'status': instance.status,
      'planTime': instance.planTime,
      'realyTime': instance.realyTime,
      'introduce': instance.introduce,
      'alarmTime': instance.alarmTime,
      'birth': instance.birth,
      'timeTerval': instance.timeTerval,
    };
