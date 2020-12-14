// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityNotificationModel _$ActivityNotificationModelFromJson(
    Map<String, dynamic> json) {
  return ActivityNotificationModel(
    title: json['title'] as String,
    objectId: json['objectId'] as int,
    subtitle: json['subtitle'] as String,
    createTime: json['createTime'] as int,
    read: json['read'] as bool,
    cover: json['cover'] as String,
    userCover: json['userCover'] as String,
    postId: json['postId'] as int,
    isSelect: json['isSelect'] as bool,
  );
}

Map<String, dynamic> _$ActivityNotificationModelToJson(
        ActivityNotificationModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'objectId': instance.objectId,
      'subtitle': instance.subtitle,
      'createTime': instance.createTime,
      'read': instance.read,
      'cover': instance.cover,
      'userCover': instance.userCover,
      'postId': instance.postId,
      'isSelect': instance.isSelect,
    };
