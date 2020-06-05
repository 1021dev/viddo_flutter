import 'package:equatable/equatable.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

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
class FacebookRegisterEvent extends RegisterScreenEvent {
  final FacebookAccessToken accessToken;

  FacebookRegisterEvent(this.accessToken);

  @override
  List<Object> get props => [accessToken];
}
