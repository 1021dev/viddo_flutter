import 'package:equatable/equatable.dart';

abstract class LoginScreenEvent extends Equatable {
  LoginScreenEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginScreenEvent {
  final String username;
  final String password;

  Login(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}

// ignore: must_be_immutable
class FacebookLogin extends LoginScreenEvent {
  final String platform = 'Facebook';
  final String nikeName;
  final String code;
  final String avatar;

  FacebookLogin(this.nikeName, this.code, this.avatar);

  @override
  List<Object> get props => [platform, nikeName, code, avatar];
}
