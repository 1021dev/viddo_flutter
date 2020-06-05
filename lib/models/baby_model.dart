import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'baby_model.g.dart';

@JsonSerializable(nullable: true)
class BabyModel extends Jsonable {
  String name;
  int objectId;
  String gender;
  int birthDay;
  String relationship;
  String avatar;
  String cover;
  int expectedDate;
  bool isCreator;
  String inviteCode;
  bool isBirth;
  bool refresh;

  BabyModel({
    this.name,
    this.objectId,
    this.gender,
    this.birthDay,
    this.cover,
    this.avatar,
    this.relationship,
    this.expectedDate,
    this.isCreator,
    this.inviteCode,
    this.isBirth,
    this.refresh,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$BabyModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$BabyModelToJson(this);
  }

  factory BabyModel.fromJson(Map<String, dynamic> json) =>
      _$BabyModelFromJson(json);

  BabyModel copyWith({
    String name,
    int objectId,
    String gender,
    int birthDay,
    String relationship,
    String avatar,
    String cover,
    int expectedDate,
    bool isCreator,
    String inviteCode,
    bool isBirth,
    bool refresh,
  }) {
    return BabyModel(
      name: name ?? this.name,
      objectId: objectId ?? this.objectId,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      relationship: relationship ?? this.relationship,
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
      expectedDate: expectedDate ?? this.expectedDate,
      isCreator: isCreator ?? this.isCreator,
      inviteCode: inviteCode ?? this.inviteCode,
      isBirth: isBirth ?? this.isBirth,
      refresh: refresh ?? this.refresh,
    );
  }
}
