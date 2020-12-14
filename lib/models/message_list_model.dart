import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_list_model.g.dart';

@JsonSerializable(nullable: true)
class MessageListModel extends Jsonable {
  int totalElements;
  int totalPages;
  List<MessageModel> content;
  MessageListModel({
    this.totalElements,
    this.totalPages,
    this.content,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$MessageListModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$MessageListModelToJson(this);
  }

  factory MessageListModel.fromJson(Map<String, dynamic> json) =>
      _$MessageListModelFromJson(json);

  MessageListModel copyWith({
    int totalElements,
    int totalPages,
    List<MessageModel> content,
  }) {
    return MessageListModel(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      content: content ?? this.content,
    );
  }
}
