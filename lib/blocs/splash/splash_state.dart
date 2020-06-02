import 'package:meta/meta.dart';

@immutable
class SplashScreenState {
  final bool isLoading;

  SplashScreenState({
    this.isLoading = false,
  });

  SplashScreenState copyWith({bool isLoading}) {
    return SplashScreenState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AutoLoginSuccess extends SplashScreenState {}

class AutoLoginFailure extends SplashScreenState {}
