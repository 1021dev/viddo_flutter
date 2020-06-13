// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrowthRecordModel _$GrowthRecordModelFromJson(Map<String, dynamic> json) {
  return GrowthRecordModel(
    objectId: json['objectId'] as int,
    recodTime: json['recodTime'] as int,
    height: (json['height'] as num)?.toDouble(),
    weight: (json['weight'] as num)?.toDouble(),
    birth: json['birth'] as int,
  );
}

Map<String, dynamic> _$GrowthRecordModelToJson(GrowthRecordModel instance) =>
    <String, dynamic>{
      'objectId': instance.objectId,
      'recodTime': instance.recodTime,
      'height': instance.height,
      'weight': instance.weight,
      'birth': instance.birth,
    };
