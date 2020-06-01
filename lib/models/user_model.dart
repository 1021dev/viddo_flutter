import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable(nullable: true)
class UserModel extends Jsonable {
  String nikeName;
  int objectId;
  String gender;
  int birthDay;
  String area;
  String avatar;
  String email;
  String account;
  bool vertical;
  int id;

  UserModel({
    this.nikeName,
    this.objectId,
    this.gender,
    this.birthDay,
    this.area,
    this.avatar,
    this.email,
    this.account,
    this.vertical,
    this.id,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$UserModelToJson(this);
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel copyWith({
    String nikeName,
    int objectId,
    String gender,
    int birthDay,
    String area,
    String avatar,
    String email,
    String account,
    bool vertical,
    int id,
  }) {
    return UserModel(
      nikeName: nikeName ?? this.nikeName,
      objectId: objectId ?? this.objectId,
      gender: gender ?? this.gender,
      birthDay: birthDay ?? this.birthDay,
      area: area ?? this.area,
      avatar: avatar ?? this.avatar,
      email: email ?? this.email,
      account: account ?? this.account,
      vertical: vertical ?? this.vertical,
      id: id ?? this.id,
    );
  }
}
