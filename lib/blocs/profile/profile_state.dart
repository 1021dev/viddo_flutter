import 'package:Viiddo/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: must_be_immutable
class ProfileScreenState {
  final bool isLoading;
  final bool isUploading;
  final UserModel userModel;
  String username;
  String avatar;
  String gender;
  String location;
  int birthday;
  bool verifical;
  List<PickedFile> imageFiles;
  List<String> uploadedFiles;
  ProfileScreenState({
    this.isLoading = false,
    this.isUploading = false,
    this.userModel,
    this.username = '',
    this.avatar = '',
    this.gender = '',
    this.location = '',
    this.birthday = 0,
    this.imageFiles = const [],
    this.verifical = false,
    this.uploadedFiles = const [],
  });

  ProfileScreenState copyWith({
    bool isLoading,
    bool isUploading,
    UserModel userModel,
    String username,
    String avatar,
    String gender,
    String location,
    int birthday,
    bool verifical,
    List<PickedFile> imageFiles,
    List<String> uploadedFiles,
  }) {
    return ProfileScreenState(
      isLoading: isLoading ?? this.isLoading,
      isUploading: isUploading ?? this.isUploading,
      userModel: userModel ?? this.userModel,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      location: location ?? this.location,
      birthday: birthday ?? this.birthday,
      verifical: verifical ?? this.verifical,
      imageFiles: imageFiles ?? this.imageFiles,
      uploadedFiles: uploadedFiles ?? this.uploadedFiles,
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
