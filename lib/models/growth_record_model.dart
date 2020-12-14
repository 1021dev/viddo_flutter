import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'growth_record_model.g.dart';

@JsonSerializable(nullable: true)
class GrowthRecordModel extends Jsonable {
  int objectId;
  int recodTime;
  double height;
  double weight;
  int birth;

  GrowthRecordModel({
    this.objectId,
    this.recodTime,
    this.height,
    this.weight,
    this.birth,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$GrowthRecordModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$GrowthRecordModelToJson(this);
  }

  factory GrowthRecordModel.fromJson(Map<String, dynamic> json) =>
      _$GrowthRecordModelFromJson(json);

  GrowthRecordModel copyWith({
    int objectId,
    int recodTime,
    double height,
    double weight,
    int birth,
  }) {
    return GrowthRecordModel(
      objectId: objectId ?? this.objectId,
      recodTime: recodTime ?? this.recodTime,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      birth: birth ?? this.birth,
    );
  }
}
