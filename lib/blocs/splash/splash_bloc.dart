import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  @override
  SplashScreenState get initialState => SplashScreenState();

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    if (event is TryAutoLogin) {
      yield* _autoLogin();
    }
  }

  Stream<SplashScreenState> _autoLogin() async* {
    try {
      yield AutoLoginFailure();
    } catch (error) {
      yield AutoLoginFailure();
    }
  }
}
