// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'growth_record_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GrowthRecordListModel _$GrowthRecordListModelFromJson(
    Map<String, dynamic> json) {
  return GrowthRecordListModel(
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    content: (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : GrowthRecordModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GrowthRecordListModelToJson(
        GrowthRecordListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'content': instance.content,
    };
