import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:bloc/bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  ApiService _apiService = ApiService();
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
      bool isLogin =
          await _apiService.accountLogin(event.username, event.password);
      if (isLogin) {
        yield LoginSuccess();
      } else {
        yield LoginScreenFailure(error: 'error');
      }
    } catch (error) {
      yield LoginScreenFailure(error: error);
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }
}
