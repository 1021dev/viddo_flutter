// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    content: json['content'] as String,
    createTime: json['createTime'] as int,
    isRead: json['isRead'] as bool,
    objectId: json['objectId'] as int,
    subtitle: json['subtitle'] as String,
    title: json['title'] as String,
    invitate: json['invitate'] as bool,
    type: json['type'] as String,
    isSelect: json['isSelect'] as bool,
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createTime': instance.createTime,
      'isRead': instance.isRead,
      'objectId': instance.objectId,
      'subtitle': instance.subtitle,
      'title': instance.title,
      'invitate': instance.invitate,
      'type': instance.type,
      'isSelect': instance.isSelect,
    };
