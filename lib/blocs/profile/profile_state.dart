import 'package:Viiddo/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: must_be_immutable
class ProfileScreenState {
  final bool isLoading;
  final UserModel userModel;
  String username = '';
  String avatar = '';
  String gender = '';
  String location = '';
  int birthday;
  ProfileScreenState({
    this.isLoading = false,
    this.userModel,
    this.username,
    this.avatar,
    this.gender,
    this.location,
    this.birthday,
  });

  ProfileScreenState copyWith({
    bool isLoading,
    UserModel userModel,
    String username,
    String avatar,
    String gender,
    String location,
    int birthday,
  }) {
    return ProfileScreenState(
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ?? this.userModel,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      birthday: birthday ?? this.birthday,
    );
  }
}

class VerificationSuccess extends ProfileScreenState {}

class UpdateProfileSuccess extends ProfileScreenState {}

class ProfileScreenFailure extends ProfileScreenState {
  final String error;

  ProfileScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'ProfileScreenFailure { error: $error }';
}
