import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class LoginScreenState {
  final bool isLoading;

  LoginScreenState({
    this.isLoading = false,
  });

  LoginScreenState copyWith({
    bool isLoading,
  }) {
    return LoginScreenState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class LoginSuccess extends LoginScreenState {
  final bool isVerical;

  LoginSuccess({@required this.isVerical}) : super();

  @override
  String toString() => 'LoginSuccess { isVerical: $isVerical }';
}

class LoginScreenFailure extends LoginScreenState {
  final String error;

  LoginScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'LoginScreenFailure { error: $error }';
}
