import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'friend_model.g.dart';

@JsonSerializable(nullable: true)
class FriendModel extends Jsonable {
  String nikeName;
  int objectId;
  String gender;
  int birthDay;
  String area;
  String avatar;
  bool relationShip;
  bool isCreator;

  FriendModel({
    this.nikeName,
    this.objectId,
    this.gender,
    this.birthDay,
    this.area,
    this.avatar,
    this.relationShip,
    this.isCreator,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$FriendModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$FriendModelToJson(this);
  }

  factory FriendModel.fromJson(Map<String, dynamic> json) =>
      _$FriendModelFromJson(json);

  FriendModel copyWith({
    String nikeName,
    int objectId,
    String gender,
    int birthDay,
    String area,
    String relationship,
    String avatar,
    bool isCreator,
  }) {
    return FriendModel(
      nikeName: nikeName ?? this.nikeName,
      objectId: objectId ?? this.objectId,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      area: area ?? this.area,
      relationShip: relationShip ?? this.relationShip,
      avatar: avatar ?? this.avatar,
      isCreator: isCreator ?? this.isCreator,
    );
  }
}
