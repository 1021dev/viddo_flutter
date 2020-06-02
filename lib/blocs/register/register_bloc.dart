import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
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
    } else if (event is FacebookLogin) {
      yield* _facebookLogin(event);
    }
  }

  Stream<RegisterScreenState> _register(Register event) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool isLogin =
          await _apiService.accountLogin(event.username, event.password);
      if (isLogin) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(Constants.SHOWWELCOME, true);
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

  Stream<RegisterScreenState> _facebookLogin(FacebookLogin event) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool isLogin = await _apiService.facebookLogin(
        event.platform,
        event.nikeName,
        event.code,
        event.avatar,
      );
      if (isLogin) {
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
