// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageModel _$PageModelFromJson(Map<String, dynamic> json) {
  return PageModel(
    totalPage: json['totalPage'] as int,
    size: json['size'] as int,
    current: json['current'] as int,
    total: json['total'] as int,
  );
}

Map<String, dynamic> _$PageModelToJson(PageModel instance) => <String, dynamic>{
      'totalPage': instance.totalPage,
      'size': instance.size,
      'current': instance.current,
      'total': instance.total,
    };
