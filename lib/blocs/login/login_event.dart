import 'package:equatable/equatable.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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
class FacebookLoginEvent extends LoginScreenEvent {
  final FacebookAccessToken accessToken;

  FacebookLoginEvent(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}
