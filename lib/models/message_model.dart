import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'message_model.g.dart';

@JsonSerializable(nullable: true)
class MessageModel extends Jsonable {
  String content;
  int createTime;
  bool isRead;
  int objectId;
  String subtitle;
  String title;
  bool invitate;
  String type;
  bool isSelect;

  MessageModel({
    this.content,
    this.createTime,
    this.isRead,
    this.objectId,
    this.subtitle,
    this.title,
    this.invitate,
    this.type,
    this.isSelect,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$MessageModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$MessageModelToJson(this);
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  MessageModel copyWith({
    String content,
    int createTime,
    bool isRead,
    int objectId,
    String subtitle,
    String title,
    bool invitate,
    String type,
    bool isSelect,
  }) {
    return MessageModel(
      content: content ?? this.content,
      createTime: createTime ?? this.createTime,
      isRead: isRead ?? this.isRead,
      objectId: objectId ?? this.objectId,
      subtitle: subtitle ?? this.subtitle,
      title: title ?? this.title,
      invitate: invitate ?? this.invitate,
      type: type ?? this.type,
      isSelect: isSelect ?? this.isSelect,
    );
  }
}
