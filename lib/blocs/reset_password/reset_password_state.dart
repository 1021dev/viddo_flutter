import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ResetPasswordScreenState {
  final bool isLoading;

  ResetPasswordScreenState({this.isLoading = false});

  ResetPasswordScreenState copyWith({bool isLoading}) {
    return ResetPasswordScreenState(isLoading: isLoading ?? this.isLoading);
  }
}

class ResetCodeSentSuccess extends ResetPasswordScreenState {}

class ResetPasswordScreenFailure extends ResetPasswordScreenState {
  final String error;

  ResetPasswordScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'ResetPasswordScreenFailure { error: $error }';
}
