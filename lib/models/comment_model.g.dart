// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) {
  return CommentModel(
    content: json['content'] as String,
    createTime: json['createTime'] as int,
    creator: json['creator'] == null
        ? null
        : DynamicCreator.fromJson(json['creator'] as Map<String, dynamic>),
    objectId: json['objectId'] as int,
    parentId: json['parentId'] as int,
    replyUser: json['replyUser'] == null
        ? null
        : DynamicCreator.fromJson(json['replyUser'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'content': instance.content,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'objectId': instance.objectId,
      'parentId': instance.parentId,
      'replyUser': instance.replyUser,
    };
