import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/user_model.dart';
import 'package:bloc/bloc.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ApiService _apiService = ApiService();
  @override
  ProfileScreenState get initialState => ProfileScreenState();

  @override
  Stream<ProfileScreenState> mapEventToState(ProfileScreenEvent event) async* {
    if (event is UserProfile) {
      yield* _getAccountInfo(event);
    } else if (event is VerificationCode) {
      yield* _sendVerification(event);
    }
  }

  Stream<ProfileScreenState> _getAccountInfo(UserProfile event) async* {
    yield state.copyWith(isLoading: true);
    try {
      UserModel userModel = await _apiService.getUserProfile();
      yield state.copyWith(
        isLoading: false,
        userModel: userModel,
      );
    } catch (error) {
      yield ProfileScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    } finally {}
  }

  Stream<ProfileScreenState> _sendVerification(VerificationCode event) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool isLogin = await _apiService.getSmsCode(
        event.email,
        event.type,
      );
      if (isLogin) {
        yield VerificationSuccess();
      } else {
        yield ProfileScreenFailure(error: 'error');
      }
    } catch (error) {
      yield ProfileScreenFailure(error: error);
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }
}
