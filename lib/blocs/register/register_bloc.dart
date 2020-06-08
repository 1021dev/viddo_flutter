import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/login_model.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterScreenBloc
    extends Bloc<RegisterScreenEvent, RegisterScreenState> {
  ApiService _apiService = ApiService();
  @override
  RegisterScreenState get initialState => RegisterScreenState();

  @override
  Stream<RegisterScreenState> mapEventToState(
      RegisterScreenEvent event) async* {
    if (event is Register) {
      yield* _register(event);
    } else if (event is FacebookRegisterEvent) {
      yield* _facebookLogin(event);
    }
  }

  Stream<RegisterScreenState> _register(Register event) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool isLogin = await _apiService.accountRegister(
          event.email, event.username, event.password);
      if (isLogin) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(Constants.SHOW_WELCOME, true);
        yield RegisterSuccess();
      } else {
        yield RegisterScreenFailure(error: 'error');
      }
    } catch (error) {
      yield RegisterScreenFailure(error: error);
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<RegisterScreenState> _facebookLogin(
      FacebookRegisterEvent event) async* {
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
        yield RegisterSuccess();
      } else {
        yield RegisterScreenFailure(error: 'error');
      }
    } catch (error) {
      yield RegisterScreenFailure(error: error);
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }
}
