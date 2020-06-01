// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_category_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StickerCategory _$StickerCategoryFromJson(Map<String, dynamic> json) {
  return StickerCategory(
    name: json['name'] as String,
    objectId: json['objectId'] as int,
  );
}

Map<String, dynamic> _$StickerCategoryToJson(StickerCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'objectId': instance.objectId,
    };
