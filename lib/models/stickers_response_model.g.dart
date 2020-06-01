// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stickers_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StickersResponseModel _$StickersResponseModelFromJson(
    Map<String, dynamic> json) {
  return StickersResponseModel(
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : StickerModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    page: json['page'] == null
        ? null
        : PageModel.fromJson(json['page'] as Map<String, dynamic>),
    totalPage: json['totalPage'] as int,
    size: json['size'] as int,
    totalElements: json['totalElements'] as int,
  );
}

Map<String, dynamic> _$StickersResponseModelToJson(
        StickersResponseModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'page': instance.page,
      'totalPage': instance.totalPage,
      'size': instance.size,
      'totalElements': instance.totalElements,
    };
