// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageListModel _$MessageListModelFromJson(Map<String, dynamic> json) {
  return MessageListModel(
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : MessageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MessageListModelToJson(MessageListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'content': instance.content,
    };
