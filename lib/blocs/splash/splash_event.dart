import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class TryAutoLogin extends SplashScreenEvent {}
