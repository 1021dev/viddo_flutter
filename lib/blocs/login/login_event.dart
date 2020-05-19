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
