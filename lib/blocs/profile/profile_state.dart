import 'package:Viiddo/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ProfileScreenState {
  final bool isLoading;
  final UserModel userModel;
  ProfileScreenState({
    this.isLoading = false,
    this.userModel,
  });

  ProfileScreenState copyWith({bool isLoading, UserModel userModel}) {
    return ProfileScreenState(
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
    );
  }
}

class VerificationSuccess extends ProfileScreenState {}

class ProfileScreenFailure extends ProfileScreenState {
  final String error;

  ProfileScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'ProfileScreenFailure { error: $error }';
}
