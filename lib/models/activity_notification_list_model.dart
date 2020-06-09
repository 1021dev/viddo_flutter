import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/activity_notification_model.dart';
import 'package:Viiddo/models/message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_notification_list_model.g.dart';

@JsonSerializable(nullable: true)
class ActivityNotificationListModel extends Jsonable {
  int totalElements;
  int totalPages;
  List<ActivityNotificationModel> content;
  ActivityNotificationListModel({
    this.totalElements,
    this.totalPages,
    this.content,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$ActivityNotificationListModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$ActivityNotificationListModelToJson(this);
  }

  factory ActivityNotificationListModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityNotificationListModelFromJson(json);

  ActivityNotificationListModel copyWith({
    int totalElements,
    int totalPages,
    List<ActivityNotificationModel> content,
  }) {
    return ActivityNotificationListModel(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      content: content ?? this.content,
    );
  }
}
