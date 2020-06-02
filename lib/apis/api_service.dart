
import 'package:Viiddo/models/login_model.dart';
import 'package:Viiddo/models/response_model.dart';
import 'package:Viiddo/models/user_model.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../env.dart';
import 'base_client.dart';

class ApiService {
  BaseClient _client = BaseClient();

  String url = Env().baseUrl;

  Future<bool> accountLogin(
    String email,
    String password,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'password': password,
      });
      Response response = await _client.postForm(
        '${url}account/login',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('accountLogin: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          LoginModel loginModel = LoginModel.fromJson(responseModel.content);

          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(Constants.TOKEN, loginModel.token);
          sharedPreferences.setInt(
              Constants.OBJECTID, loginModel.user.objectId);
          sharedPreferences.setBool(Constants.FACEBOOK_LOGIN, false);
          sharedPreferences.setString(Constants.EMAIL, loginModel.user.email);
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('accountLogin error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> facebookLogin(
    String platform,
    String code,
    String nikeName,
    String avatar,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'platform': platform,
        'code': code,
        'nikeName': nikeName,
        'avatar': avatar,
      });
      Response response = await _client.postForm(
        '${url}account/login',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('facebookLogin: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          LoginModel loginModel = LoginModel.fromJson(responseModel.content);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(Constants.TOKEN, loginModel.token);
          sharedPreferences.setInt(
              Constants.OBJECTID, loginModel.user.objectId);
          sharedPreferences.setBool(Constants.FACEBOOK_LOGIN, true);

          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('facebookLogin error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> accountRegister(
    String email,
    String username,
    String password,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'name': username,
        'email': email,
        'code': '',
        'password': password,
      });
      Response response = await _client.postForm(
        '${url}account/register',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('accountRegister: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('accountRegister error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> updatePassword(
    String email,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'email': email,
      });
      Response response = await _client.postForm(
        '${url}account/updatePassword',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('updatePassword: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('updatePassword error: $e, $s');
      return Future.error(e);
    }
  }

  Future<UserModel> getUserProfile() async {
    try {
      Response response = await _client.postForm(
        '${url}user/getMyProfile',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getUserProfile: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          UserModel userModel = UserModel.fromJson(responseModel.content);
          return userModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getUserProfile error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> getSmsCode(
    String email,
    String type,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'type': type,
      });
      Response response = await _client.postForm(
        '${url}account/getSmsCode',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('updatePassword: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('updatePassword error: $e, $s');
      return Future.error(e);
    }
  }
}
