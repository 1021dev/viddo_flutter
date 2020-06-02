import 'package:equatable/equatable.dart';

abstract class ResetPasswordScreenEvent extends Equatable {
  ResetPasswordScreenEvent();

  @override
  List<Object> get props => [];
}

class ResetPassword extends ResetPasswordScreenEvent {
  final String email;

  ResetPassword(
    this.email,
  );

  @override
  List<Object> get props => [
        email,
      ];
}
