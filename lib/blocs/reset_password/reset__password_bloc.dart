import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:bloc/bloc.dart';

import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPassowrdScreenBloc
    extends Bloc<ResetPasswordScreenEvent, ResetPasswordScreenState> {
  ApiService _apiService = ApiService();
  @override
  ResetPasswordScreenState get initialState => ResetPasswordScreenState();

  @override
  Stream<ResetPasswordScreenState> mapEventToState(
      ResetPasswordScreenEvent event) async* {
    if (event is ResetPassword) {
      yield* _resetPassword(event);
    }
  }

  Stream<ResetPasswordScreenState> _resetPassword(ResetPassword event) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool isLogin = await _apiService.updatePassword(event.email);
      if (isLogin) {
        yield ResetCodeSentSuccess();
      } else {
        yield ResetPasswordScreenFailure(error: 'error');
      }
    } catch (error) {
      yield ResetPasswordScreenFailure(error: error);
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }
}
