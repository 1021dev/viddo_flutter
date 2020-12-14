// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unread_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnreadMessageModel _$UnreadMessageModelFromJson(Map<String, dynamic> json) {
  return UnreadMessageModel(
    hasUnread: json['hasUnread'] as bool,
    activityCount: json['activityCount'] as int,
    messageCount: json['messageCount'] as int,
  );
}

Map<String, dynamic> _$UnreadMessageModelToJson(UnreadMessageModel instance) =>
    <String, dynamic>{
      'hasUnread': instance.hasUnread,
      'activityCount': instance.activityCount,
      'messageCount': instance.messageCount,
    };
