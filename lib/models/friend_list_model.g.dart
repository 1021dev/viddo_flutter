// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendListModel _$FriendListModelFromJson(Map<String, dynamic> json) {
  return FriendListModel(
    totalElements: json['totalElements'] as int,
    totalPages: json['totalPages'] as int,
    content: (json['content'] as List)
        ?.map((e) =>
            e == null ? null : FriendModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$FriendListModelToJson(FriendListModel instance) =>
    <String, dynamic>{
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'content': instance.content,
    };
