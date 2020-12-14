import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/login_model.dart';
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
    } else if (event is FacebookLoginEvent) {
      yield* _facebookLogin(event);
    }
  }

  Stream<LoginScreenState> _login(Login event) async* {
    yield state.copyWith(isLoading: true);
    try {
      LoginModel loginModel =
          await _apiService.accountLogin(event.username, event.password);
      if (loginModel != null) {
        state.copyWith(isLoading: false);
        yield LoginSuccess(isVerical: loginModel.user.vertical);
      } else {
        yield state.copyWith(isLoading: false);
        yield LoginScreenFailure(error: 'error');
      }
    } catch (error) {
      state.copyWith(isLoading: false);
      yield LoginScreenFailure(error: error.toString());
    }
  }

  Stream<LoginScreenState> _facebookLogin(FacebookLoginEvent event) async* {
    yield state.copyWith(isLoading: true);
    try {
      var profile = await _apiService.getFacebookProfile(event.accessToken);
      String avatar = profile['picture']['data']['url'];
      String nikName = profile['name'];
      LoginModel loginModel = await _apiService.facebookLogin(
        'Facebook',
        nikName,
        '${event.accessToken.userId}',
        avatar,
      );
      if (loginModel != null) {
        state.copyWith(isLoading: false);
        yield LoginSuccess(isVerical: loginModel.user.vertical);
      } else {
        yield state.copyWith(isLoading: false);
        yield LoginScreenFailure(error: 'error');
      }
    } catch (error) {
      yield state.copyWith(isLoading: false);
      yield LoginScreenFailure(error: error);
    }
  }
}
