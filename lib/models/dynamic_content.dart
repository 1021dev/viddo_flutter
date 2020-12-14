import 'dart:core';

import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'baby_info.dart';
import 'comment_model.dart';
import 'dynamic_creator.dart';
import 'dynamic_tag.dart';
part 'dynamic_content.g.dart';

@JsonSerializable(nullable: true)
class DynamicContent extends Jsonable {
  String address;
  List<String> albums;
  BabyModel baby;
  int commentCount;
  List<CommentModel> commentList;
  String content;
  int createTime;
  DynamicCreator creator;
  int expectedDate;
  String field;
  int likeCount;
  List<DynamicCreator> likeList;
  int objectId;
  List<DynamicTag> tags;
  bool isLike;
  bool canEdit;
  String toWho;
  double lat;
  double lng;
  List<BabyInfo> babys;

  DynamicContent({
    this.address,
    this.albums,
    this.baby,
    this.commentCount,
    this.commentList,
    this.content,
    this.createTime,
    this.creator,
    this.expectedDate,
    this.field,
    this.likeCount,
    this.likeList,
    this.objectId,
    this.tags,
    this.isLike,
    this.canEdit,
    this.toWho,
    this.lat,
    this.lng,
    this.babys,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DynamicContentFromJson(json);
  }

  @override
  Map toJson() {
    return _$DynamicContentToJson(this);
  }

  factory DynamicContent.fromJson(Map<String, dynamic> json) =>
      _$DynamicContentFromJson(json);

  DynamicContent copyWith({
    String address,
    List<String> albums,
    BabyModel baby,
    int commentCount,
    List<CommentModel> commentList,
    String content,
    int createTime,
    DynamicCreator creator,
    int expectedDate,
    String field,
    int likeCount,
    List<DynamicCreator> likeList,
    int objectId,
    List<DynamicTag> tags,
    bool isLike,
    bool canEdit,
    int toWho,
    double lat,
    double lng,
    List<BabyInfo> babys,
  }) {
    return DynamicContent(
      address: address ?? this.address,
      albums: albums ?? this.albums,
      baby: baby ?? this.baby,
      commentCount: commentCount ?? this.commentCount,
      commentList: commentList ?? this.commentList,
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      creator: creator ?? this.creator,
      expectedDate: expectedDate ?? this.expectedDate,
      field: field ?? this.field,
      likeCount: likeCount ?? this.likeCount,
      likeList: likeList ?? this.likeList,
      objectId: objectId ?? this.objectId,
      tags: tags ?? this.tags,
      isLike: isLike ?? this.isLike,
      canEdit: canEdit ?? this.canEdit,
      toWho: toWho ?? this.toWho,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      babys: babys ?? this.babys,
    );
  }
}
