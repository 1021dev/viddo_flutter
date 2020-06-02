import 'package:equatable/equatable.dart';

abstract class RegisterScreenEvent extends Equatable {
  RegisterScreenEvent();

  @override
  List<Object> get props => [];
}

class Register extends RegisterScreenEvent {
  final String username;
  final String email;
  final String password;

  Register(
    this.username,
    this.email,
    this.password,
  );

  @override
  List<Object> get props => [
        username,
        email,
        password,
      ];
}

// ignore: must_be_immutable
class FacebookLogin extends RegisterScreenEvent {
  final String platform = 'Facebook';
  final String nikeName;
  final String code;
  final String avatar;

  FacebookLogin(this.nikeName, this.code, this.avatar);

  @override
  List<Object> get props => [platform, nikeName, code, avatar];
}
