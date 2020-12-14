import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dynamic_creator.dart';
part 'comment_model.g.dart';

@JsonSerializable(nullable: true)
class CommentModel extends Jsonable {
  String content;
  int createTime;
  DynamicCreator creator;
  int objectId;
  int parentId;
  DynamicCreator replyUser;

  CommentModel({
    this.content,
    this.createTime,
    this.creator,
    this.objectId,
    this.parentId,
    this.replyUser,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$CommentModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$CommentModelToJson(this);
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  CommentModel copyWith({
    String content,
    int createTime,
    DynamicCreator creator,
    int objectId,
    int parentId,
    DynamicCreator replyUser,
  }) {
    return CommentModel(
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      creator: creator ?? this.creator,
      objectId: objectId ?? this.objectId,
      parentId: parentId ?? this.parentId,
      replyUser: replyUser ?? this.replyUser,
    );
  }
}
