import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/user_model.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_event.dart';
import 'profile_state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ApiService _apiService = ApiService();
  @override
  ProfileScreenState get initialState => ProfileScreenState();

  @override
  Stream<ProfileScreenState> mapEventToState(ProfileScreenEvent event) async* {
    if (event is InitProfileScreen) {
      yield* _initLoad(event);
    } else if (event is UserProfile) {
      yield* _getAccountInfo(event);
    } else if (event is VerificationCode) {
      yield* _sendVerification(event);
    } else if (event is UpdateUserProfile) {
      yield* _updateProfile(event);
    }
  }

  Stream<ProfileScreenState> _initLoad(InitProfileScreen event) async* {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String username = sharedPreferences.getString(Constants.USERNAME) ?? '';
      String avatar = sharedPreferences.getString(Constants.AVATAR) ?? '';
      String gender = sharedPreferences.getString(Constants.GENDER) ?? '';
      String location = sharedPreferences.getString(Constants.LOCATION) ?? '';
      int birthday = sharedPreferences.getInt(Constants.BIRTHDAY) ?? '';
      yield state.copyWith(
        username: username,
      );
    } catch (error) {
      yield ProfileScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    } finally {}
  }

  Stream<ProfileScreenState> _getAccountInfo(UserProfile event) async* {
    try {
      UserModel userModel = await _apiService.getUserProfile();
      yield state.copyWith(
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

  Stream<ProfileScreenState> _updateProfile(UpdateUserProfile event) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool success = await _apiService.updateProfile(
        event.map,
      );
      if (success) {
        yield UpdateProfileSuccess();
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
