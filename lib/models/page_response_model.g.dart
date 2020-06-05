// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponseModel _$PageResponseModelFromJson(Map<String, dynamic> json) {
  return PageResponseModel(
    content: json['content'] as List,
    page: json['page'] == null
        ? null
        : PageModel.fromJson(json['page'] as Map<String, dynamic>),
    totalPage: json['totalPage'] as int,
    size: json['size'] as int,
    totalElements: json['totalElements'] as int,
  );
}

Map<String, dynamic> _$PageResponseModelToJson(PageResponseModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'page': instance.page,
      'totalPage': instance.totalPage,
      'size': instance.size,
      'totalElements': instance.totalElements,
    };
