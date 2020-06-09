import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ProfileScreenEvent extends Equatable {
  ProfileScreenEvent();

  @override
  List<Object> get props => [];
}

class InitProfileScreen extends ProfileScreenEvent {}

@immutable
class PickImageFile extends ProfileScreenEvent {
  List<File> pickedFiles = [];
  PickImageFile(
    this.pickedFiles,
  );

  @override
  List<Object> get props => [
        this.pickedFiles,
      ];
}

class UserProfile extends ProfileScreenEvent {}

class UpdateBirthDay extends ProfileScreenEvent {
  final DateTime birthday;
  UpdateBirthDay(
    this.birthday,
  );

  @override
  List<Object> get props => [
        this.birthday,
      ];
}

@immutable
class UpdateUserProfile extends ProfileScreenEvent {
  final dynamic map;
  UpdateUserProfile(
    this.map,
  );

  @override
  List<Object> get props => [
        this.map,
      ];
}

class VerificationCode extends ProfileScreenEvent {
  String email;
  String type;

  VerificationCode(
    this.email,
    this.type,
  );

  @override
  List<Object> get props => [
        this.email,
        this.type,
      ];
}
