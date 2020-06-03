import 'dart:async';

import 'package:Viiddo/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String token = sharedPreferences.getString(Constants.TOKEN);
      if (token != null && token.length > 0) {
        yield AutoLoginSuccess();
      } else {
        yield AutoLoginFailure();
      }
    } catch (error) {
      yield AutoLoginFailure();
    }
  }
}
