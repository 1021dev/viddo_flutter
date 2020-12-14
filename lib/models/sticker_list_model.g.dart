// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StickerListModel _$StickerListModelFromJson(Map<String, dynamic> json) {
  return StickerListModel(
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : StickerModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$StickerListModelToJson(StickerListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'content': instance.content,
    };
