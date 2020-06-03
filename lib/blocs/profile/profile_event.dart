import 'package:equatable/equatable.dart';

abstract class ProfileScreenEvent extends Equatable {
  ProfileScreenEvent();

  @override
  List<Object> get props => [];
}

class InitProfileScreen extends ProfileScreenEvent {}

class UserProfile extends ProfileScreenEvent {
  UserProfile();

  @override
  List<Object> get props => [];
}

class UpdateUserProfile extends ProfileScreenEvent {
  dynamic map;
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
