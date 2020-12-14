import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vaccine_model.g.dart';

@JsonSerializable(nullable: true)
class VaccineModel extends Jsonable {
  int objectId;
  String title;
  String status;
  int planTime;
  int realyTime;
  String introduce;
  int alarmTime;
  int birth;
  String timeTerval;

  VaccineModel({
    this.objectId,
    this.title,
    this.status,
    this.planTime,
    this.realyTime,
    this.introduce,
    this.alarmTime,
    this.birth,
    this.timeTerval,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$VaccineModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$VaccineModelToJson(this);
  }

  factory VaccineModel.fromJson(Map<String, dynamic> json) =>
      _$VaccineModelFromJson(json);

  VaccineModel copyWith({
    int objectId,
    String title,
    String status,
    int planTime,
    int realyTime,
    String introduce,
    int alarmTime,
    int birth,
    String timeTerval,
  }) {
    return VaccineModel(
      objectId: objectId ?? this.objectId,
      title: title ?? this.title,
      status: status ?? this.status,
      planTime: planTime ?? this.planTime,
      realyTime: realyTime ?? this.realyTime,
      introduce: introduce ?? this.introduce,
      alarmTime: alarmTime ?? this.alarmTime,
      birth: birth ?? this.birth,
      timeTerval: timeTerval ?? this.timeTerval,
    );
  }
}
