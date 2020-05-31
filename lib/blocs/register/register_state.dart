import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class RegisterScreenState {
  final bool isLoading;

  RegisterScreenState({this.isLoading = false});

  RegisterScreenState copyWith({bool isLoading}) {
    return RegisterScreenState(isLoading: isLoading ?? this.isLoading);
  }
}

class RegisterSuccess extends RegisterScreenState {}

class RegisterScreenFailure extends RegisterScreenState {
  final String error;

  RegisterScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'RegisterScreenFailure { error: $error }';
}
