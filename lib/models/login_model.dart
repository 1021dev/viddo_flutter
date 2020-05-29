import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable(nullable: true)
class LoginModel extends Jsonable {
  String token;
  UserModel user;

  LoginModel({
    this.token,
    this.user,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$LoginModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$LoginModelToJson(this);
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      _$LoginModelFromJson(json);

  LoginModel copyWith({
    String token,
    UserModel user,
  }) {
    return LoginModel(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}
