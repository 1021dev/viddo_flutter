// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agree_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgreeInfoModel _$AgreeInfoModelFromJson(Map<String, dynamic> json) {
  return AgreeInfoModel(
    name: json['name'] as String,
    objectId: json['objectId'] as int,
    cover: json['cover'] as String,
    sex: json['sex'] as String,
    loction: json['loction'] as String,
    information: json['information'] as String,
    isMake: json['isMake'] as bool,
  );
}

Map<String, dynamic> _$AgreeInfoModelToJson(AgreeInfoModel instance) =>
    <String, dynamic>{
      'cover': instance.cover,
      'objectId': instance.objectId,
      'name': instance.name,
      'sex': instance.sex,
      'loction': instance.loction,
      'information': instance.information,
      'isMake': instance.isMake,
    };
