import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'unread_message_model.g.dart';

@JsonSerializable(nullable: true)
class UnreadMessageModel extends Jsonable {
  bool hasUnread;
  int activityCount;
  int messageCount;

  UnreadMessageModel({
    this.hasUnread,
    this.activityCount,
    this.messageCount,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$UnreadMessageModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$UnreadMessageModelToJson(this);
  }

  factory UnreadMessageModel.fromJson(Map<String, dynamic> json) =>
      _$UnreadMessageModelFromJson(json);

  UnreadMessageModel copyWith({
    bool hasUnread,
    int activityCount,
    int messageCount,
  }) {
    return UnreadMessageModel(
      hasUnread: hasUnread ?? this.hasUnread,
      activityCount: activityCount ?? this.activityCount,
      messageCount: messageCount ?? this.messageCount,
    );
  }
}
