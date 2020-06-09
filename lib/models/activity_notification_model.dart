import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'activity_notification_model.g.dart';

@JsonSerializable(nullable: true)
class ActivityNotificationModel extends Jsonable {
  String title;
  int objectId;
  String subtitle;
  int createTime;
  bool read;
  String cover;
  String userCover;
  int postId;
  bool isSelect;

  ActivityNotificationModel({
    this.title,
    this.objectId,
    this.subtitle,
    this.createTime,
    this.read,
    this.cover,
    this.userCover,
    this.postId,
    this.isSelect,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$ActivityNotificationModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$ActivityNotificationModelToJson(this);
  }

  factory ActivityNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityNotificationModelFromJson(json);

  ActivityNotificationModel copyWith({
    String title,
    int objectId,
    String subtitle,
    int createTime,
    bool read,
    String cover,
    String userCover,
    int postId,
    bool isSelect,
  }) {
    return ActivityNotificationModel(
      title: title ?? this.title,
      objectId: objectId ?? this.objectId,
      subtitle: subtitle ?? this.subtitle,
      createTime: createTime ?? this.createTime,
      read: read ?? this.read,
      cover: cover ?? this.cover,
      userCover: userCover ?? this.userCover,
      postId: postId ?? this.postId,
      isSelect: isSelect ?? this.isSelect,
    );
  }
}
