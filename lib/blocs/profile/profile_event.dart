import 'package:equatable/equatable.dart';

abstract class ProfileScreenEvent extends Equatable {
  ProfileScreenEvent();

  @override
  List<Object> get props => [];
}

class UserProfile extends ProfileScreenEvent {
  UserProfile();

  @override
  List<Object> get props => [];
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
