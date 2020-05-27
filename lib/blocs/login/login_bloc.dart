import 'dart:async';

import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  int resourceID;
  @override
  LoginScreenState get initialState => LoginScreenState();

  @override
  Stream<LoginScreenState> mapEventToState(LoginScreenEvent event) async* {
    if (event is Login) {
      yield* _login(event);
    }
  }

  Stream<LoginScreenState> _login(Login event) async* {
    yield state.copyWith(isLoading: true);
    try {
      yield LoginSuccess();
    } catch (error) {
      yield LoginScreenFailure(error: error);
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }
}
