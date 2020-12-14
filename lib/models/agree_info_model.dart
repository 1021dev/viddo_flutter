import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agree_info_model.g.dart';

@JsonSerializable(nullable: true)
class AgreeInfoModel extends Jsonable {
  String cover;
  int objectId;
  String name;
  String sex;
  String loction;
  String information;
  bool isMake;

  AgreeInfoModel({
    this.name,
    this.objectId,
    this.cover,
    this.sex,
    this.loction,
    this.information,
    this.isMake,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$AgreeInfoModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$AgreeInfoModelToJson(this);
  }

  factory AgreeInfoModel.fromJson(Map<String, dynamic> json) =>
      _$AgreeInfoModelFromJson(json);

  AgreeInfoModel copyWith({
    String cover,
    int objectId,
    String name,
    String sex,
    String loction,
    String information,
    bool isMake,
  }) {
    return AgreeInfoModel(
      name: name ?? this.name,
      objectId: objectId ?? this.objectId,
      cover: cover ?? this.cover,
      sex: sex ?? this.sex,
      loction: loction ?? this.loction,
      information: information ?? this.information,
      isMake: isMake ?? this.isMake,
    );
  }
}
