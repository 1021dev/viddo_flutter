// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_notification_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityNotificationListModel _$ActivityNotificationListModelFromJson(
    Map<String, dynamic> json) {
  return ActivityNotificationListModel(
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    content: (json['content'] as List)
        ?.map((e) => e == null
            ? null
            : ActivityNotificationModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActivityNotificationListModelToJson(
        ActivityNotificationListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'content': instance.content,
    };
