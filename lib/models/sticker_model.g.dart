// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StickerModel _$StickerModelFromJson(Map<String, dynamic> json) {
  return StickerModel(
    name: json['name'] as String,
    allowChangeColor: json['allowChangeColor'] as bool,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$StickerModelToJson(StickerModel instance) =>
    <String, dynamic>{
      'allowChangeColor': instance.allowChangeColor,
      'url': instance.url,
      'name': instance.name,
    };
