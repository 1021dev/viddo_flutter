// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicContent _$DynamicContentFromJson(Map<String, dynamic> json) {
  return DynamicContent(
    address: json['address'] as String,
    albums: (json['albums'] as List)?.map((e) => e as String)?.toList(),
    baby: json['baby'] == null
        ? null
        : BabyModel.fromJson(json['baby'] as Map<String, dynamic>),
    commentCount: json['commentCount'] as int,
    commentList: (json['commentList'] as List)
        ?.map((e) =>
            e == null ? null : CommentModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    content: json['content'] as String,
    createTime: json['createTime'] as int,
    creator: json['creator'] == null
        ? null
        : DynamicCreator.fromJson(json['creator'] as Map<String, dynamic>),
    expectedDate: json['expectedDate'] as int,
    field: json['field'] as String,
    likeCount: json['likeCount'] as int,
    likeList: (json['likeList'] as List)
        ?.map((e) => e == null
            ? null
            : DynamicCreator.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    objectId: json['objectId'] as int,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : DynamicTag.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    isLike: json['isLike'] as bool,
    canEdit: json['canEdit'] as bool,
    toWho: json['toWho'] as String,
    lat: (json['lat'] as num)?.toDouble(),
    lng: (json['lng'] as num)?.toDouble(),
    babys: (json['babys'] as List)
        ?.map((e) =>
            e == null ? null : BabyInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$DynamicContentToJson(DynamicContent instance) =>
    <String, dynamic>{
      'address': instance.address,
      'albums': instance.albums,
      'baby': instance.baby,
      'commentCount': instance.commentCount,
      'commentList': instance.commentList,
      'content': instance.content,
      'createTime': instance.createTime,
      'creator': instance.creator,
      'expectedDate': instance.expectedDate,
      'field': instance.field,
      'likeCount': instance.likeCount,
      'likeList': instance.likeList,
      'objectId': instance.objectId,
      'tags': instance.tags,
      'isLike': instance.isLike,
      'canEdit': instance.canEdit,
      'toWho': instance.toWho,
      'lat': instance.lat,
      'lng': instance.lng,
      'babys': instance.babys,
    };
