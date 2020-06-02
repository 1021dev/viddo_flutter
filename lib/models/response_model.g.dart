// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) {
  return ResponseModel(
    head: json['head'] as bool,
    content: json['content'],
    status: json['status'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'head': instance.head,
      'content': instance.content,
      'status': instance.status,
      'message': instance.message,
    };
