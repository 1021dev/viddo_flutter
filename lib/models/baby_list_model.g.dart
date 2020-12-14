// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baby_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BabyListModel _$BabyListModelFromJson(Map<String, dynamic> json) {
  return BabyListModel(
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : BabyModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BabyListModelToJson(BabyListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'content': instance.content,
    };
