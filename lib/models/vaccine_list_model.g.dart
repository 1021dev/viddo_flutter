// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vaccine_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VaccineListModel _$VaccineListModelFromJson(Map<String, dynamic> json) {
  return VaccineListModel(
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : VaccineModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VaccineListModelToJson(VaccineListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'content': instance.content,
    };
