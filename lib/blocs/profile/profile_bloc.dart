import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/user_model.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileScreenBloc extends Bloc<ProfileScreenEvent, ProfileScreenState> {
  ApiService _apiService = ApiService();

  final MainScreenBloc mainScreenBloc;
  ProfileScreenBloc({@required this.mainScreenBloc});


  @override
  ProfileScreenState get initialState => ProfileScreenState();

  @override
  Stream<ProfileScreenState> mapEventToState(ProfileScreenEvent event) async* {
    if (event is InitProfileScreen) {
      yield* _initLoad();
    } else if (event is UserProfile) {
      yield* _getAccountInfo(event);
    } else if (event is VerificationCode) {
      yield* _sendVerification(event);
    } else if (event is UpdateUserProfile) {
      yield* _updateProfile(event);
    } else if (event is PickImageFile) {
      yield* _pickImageFile(event);
    } else if (event is UpdateBirthDay) {
      yield state.copyWith(birthday: event.birthday.millisecondsSinceEpoch);
    }
  }

  Stream<ProfileScreenState> _initLoad() async* {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String username = sharedPreferences.getString(Constants.USERNAME) ?? '';
      String avatar = sharedPreferences.getString(Constants.AVATAR) ?? '';
      String gender = sharedPreferences.getString(Constants.GENDER) ?? '';
      String location = sharedPreferences.getString(Constants.LOCATION) ?? '';
      int birthday = sharedPreferences.getInt(Constants.BIRTHDAY) ?? 0;
      String email = sharedPreferences.getString(Constants.EMAIL) ?? '';
      bool isVerical =
          sharedPreferences.getBool(Constants.IS_VERI_CAL) ?? false;
      add(UserProfile());
      yield state.copyWith(
        username: username,
        email: email,
        avatar: avatar,
        gender: gender,
        location: location,
        birthday: birthday,
        verifical: isVerical,
      );
    } catch (error) {
      yield ProfileScreenFailure(error: error);
    }
  }

  Stream<ProfileScreenState> _getAccountInfo(UserProfile event) async* {
    try {
      UserModel userModel = await _apiService.getUserProfile();
      String email = userModel.email ?? '';
      String username = userModel.nikeName ?? '';
      String avatar = userModel.avatar ?? '';
      String gender = userModel.gender ?? '';
      String location = userModel.area ?? '';
      int birthday = userModel.birthDay ?? 0;
      bool isVerical = userModel.vertical ?? false;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString(Constants.USERNAME, username);
      sharedPreferences.setString(Constants.AVATAR, avatar);
      sharedPreferences.setString(Constants.GENDER, gender);
      sharedPreferences.setString(Constants.LOCATION, location);
      sharedPreferences.setInt(Constants.BIRTHDAY, birthday);
      sharedPreferences.setString(Constants.EMAIL, email);
      sharedPreferences.setBool(Constants.IS_VERI_CAL, isVerical);

      yield state.copyWith(
        userModel: userModel,
        username: username,
        email: email,
        avatar: avatar,
        gender: gender,
        location: location,
        birthday: birthday,
        verifical: isVerical,
      );
    } catch (error) {
      yield ProfileScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<ProfileScreenState> _sendVerification(VerificationCode event) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool isLogin = await _apiService.getSmsCode(
        event.email,
        event.type,
      );
      yield state.copyWith(isLoading: false);
      if (isLogin) {
        yield VerificationSuccess();
      } else {
        yield ProfileScreenFailure(error: 'error');
      }
    } catch (error) {
      yield ProfileScreenFailure(error: error);
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
        yield* _initLoad();
        yield UpdateProfileSuccess();
      } else {
        yield ProfileScreenFailure(error: 'error');
      }
    } catch (error) {
      yield ProfileScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<ProfileScreenState> _pickImageFile(PickImageFile event) async* {
    try {
      yield state.copyWith(isUploading: true);
      List<String> urls =
          await _apiService.uploadProfileImage(event.pickedFiles);
      String avatar = '';
      if (urls.length > 0) {
        avatar = urls.first;
      }
      yield state.copyWith(
          uploadedFiles: urls, isUploading: false, avatar: avatar);
      if(avatar != '') {
        add(UpdateUserProfile({'avatar': avatar}));
      }
    } catch (error) {
      yield ProfileScreenFailure(error: error);
      yield state.copyWith(isUploading: false);
    }
  }
}
