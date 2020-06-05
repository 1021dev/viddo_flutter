import 'dart:io';
import 'dart:math';

import 'package:amazon_s3_cognito/amazon_s3_cognito.dart';
import 'package:amazon_s3_cognito/aws_region.dart';
import 'package:aws_s3/aws_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'package:Viiddo/models/login_model.dart';
import 'package:Viiddo/models/response_model.dart';
import 'package:Viiddo/models/user_model.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

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
              Constants.OBJECT_ID, loginModel.user.objectId);
          sharedPreferences.setBool(Constants.FACEBOOK_LOGIN, false);
          sharedPreferences.setString(Constants.EMAIL, loginModel.user.email);
          if (loginModel.user != null) {
            UserModel userModel = loginModel.user;
            sharedPreferences.setString(Constants.EMAIL, userModel.email ?? '');
            sharedPreferences.setString(
                Constants.USERNAME, userModel.nikeName ?? '');
            sharedPreferences.setString(
                Constants.AVATAR, userModel.avatar ?? '');
            sharedPreferences.setString(Constants.GENDER, userModel.gender);
            sharedPreferences.setString(
                Constants.LOCATION, userModel.area ?? '');
            sharedPreferences.setInt(
                Constants.BIRTHDAY, userModel.birthDay ?? 0);
            sharedPreferences.setBool(
                Constants.IS_VERI_CAL, userModel.vertical ?? 0);
          }

          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('accountLogin error: $e, $s');
      return Future.error(e);
    }
  }

  Future<dynamic> getFacebookProfile(FacebookAccessToken accessToken) async {
    try {
      Response graphResponse = await _client.getTypeless(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture.height(200)&access_token=${accessToken.token}');
      var profile = json.decode(graphResponse.data);
      return profile;
    } on DioError catch (e, s) {
      print('graph api error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> facebookLogin(
    String platform,
    String nikeName,
    String code,
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
              Constants.OBJECT_ID, loginModel.user.objectId);
          if (loginModel.user != null) {
            UserModel userModel = loginModel.user;
            sharedPreferences.setString(Constants.EMAIL, userModel.email ?? '');
            sharedPreferences.setString(
                Constants.USERNAME, userModel.nikeName ?? '');
            sharedPreferences.setString(
                Constants.AVATAR, userModel.avatar ?? '');
            sharedPreferences.setString(Constants.GENDER, userModel.gender);
            sharedPreferences.setString(
                Constants.LOCATION, userModel.area ?? '');
            sharedPreferences.setInt(
                Constants.BIRTHDAY, userModel.birthDay ?? 0);
            sharedPreferences.setBool(
                Constants.IS_VERI_CAL, userModel.vertical ?? 0);
          }

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
          LoginModel loginModel = LoginModel.fromJson(responseModel.content);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(Constants.TOKEN, loginModel.token);
          sharedPreferences.setInt(
              Constants.OBJECT_ID, loginModel.user.objectId);
          if (loginModel.user != null) {
            UserModel userModel = loginModel.user;
            sharedPreferences.setString(Constants.EMAIL, userModel.email ?? '');
            sharedPreferences.setString(
                Constants.USERNAME, userModel.nikeName ?? '');
            sharedPreferences.setString(
                Constants.AVATAR, userModel.avatar ?? '');
            sharedPreferences.setString(Constants.GENDER, userModel.gender);
            sharedPreferences.setString(
                Constants.LOCATION, userModel.area ?? '');
            sharedPreferences.setInt(
                Constants.BIRTHDAY, userModel.birthDay ?? 0);
            sharedPreferences.setBool(
                Constants.IS_VERI_CAL, userModel.vertical ?? 0);
          }

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
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        if (responseModel.status == 1000) {
          return Future.error(e);
        }
        if (responseModel.content != null) {
          UserModel userModel = UserModel.fromJson(responseModel.content);
          if (userModel != null) {
            sharedPreferences.setString(Constants.EMAIL, userModel.email ?? '');
            sharedPreferences.setString(
                Constants.USERNAME, userModel.nikeName ?? '');
            sharedPreferences.setString(
                Constants.AVATAR, userModel.avatar ?? '');
            sharedPreferences.setString(Constants.GENDER, userModel.gender);
            sharedPreferences.setString(
                Constants.LOCATION, userModel.area ?? '');
            sharedPreferences.setInt(
                Constants.BIRTHDAY, userModel.birthDay ?? 0);
            sharedPreferences.setBool(
                Constants.IS_VERI_CAL, userModel.vertical ?? 0);
          }

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

  Future<bool> updateProfile(
    dynamic map,
  ) async {
    try {
      FormData formData = FormData.fromMap(map);
      Response response = await _client.postForm(
        '${url}user/editMyProfile',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('updateProfile: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          UserModel userModel = UserModel.fromJson(responseModel.content);
          if (userModel != null) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString(
                Constants.USERNAME, userModel.nikeName ?? '');
            sharedPreferences.setString(
                Constants.AVATAR, userModel.avatar ?? '');
            sharedPreferences.setString(Constants.GENDER, userModel.gender);
            sharedPreferences.setString(
                Constants.LOCATION, userModel.area ?? '');
            sharedPreferences.setInt(
                Constants.BIRTHDAY, userModel.birthDay ?? 0);
            sharedPreferences.setBool(
                Constants.IS_VERI_CAL, userModel.vertical ?? 0);
          }
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('updateProfile error: $e, $s');
      return Future.error(e);
    }
  }

  // UploadA
  Future<List<String>> uploadProfileImage(
    List<File> imageFiles,
  ) async {
    try {
      List<String> urls = [];
      for (int i = 0; i < imageFiles.length; i++) {
        String uuid = Uuid().v1();
        String path = imageFiles[i].path;
        String extension = p.extension(path);

//        String result;
//        AwsS3 awsS3 = AwsS3(
//            awsFolderPath: 'imgbaby/Posts',
//            file: imageFiles[i],
//            fileNameWithExt: '${uuid}_$i.$extension',
//            poolId: Constants.cognitoPoolId,
//            region: Regions.US_EAST_2,
//            bucketName: Constants.bucket);
//        try {
//          try {
//            result = await awsS3.uploadFile;
//            debugPrint("Result :'$result'.");
//          } on PlatformException {
//            debugPrint("Result :'$result'.");
//          }
//        } on PlatformException catch (e) {
//          debugPrint("Failed :'${e.message}'.");
//        }

        String uploadedImageUrl = await AmazonS3Cognito.upload(
            imageFiles[i].path,
            Constants.bucket,
            Constants.cognitoPoolId,
            '${uuid}_$i.$extension',
            AwsRegion.US_EAST_2,
            AwsRegion.US_EAST_2);
        String url =
            'https://d1qaud6fcxefsz.cloudfront.net/Posts/${uuid}_$i.$extension';
        if (uploadedImageUrl != null) {
          urls.add(url);
        }
      }
      return urls;
    } on DioError catch (e, s) {
      print('updateProfile error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> getFriendsByBaby(
    dynamic map,
  ) async {
    try {
      FormData formData = FormData.fromMap(map);
      Response response = await _client.postForm(
        '${url}user/editMyProfile',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('updateProfile: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          UserModel userModel = UserModel.fromJson(responseModel.content);
          if (userModel != null) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString(
                Constants.USERNAME, userModel.nikeName ?? '');
            sharedPreferences.setString(
                Constants.AVATAR, userModel.avatar ?? '');
            sharedPreferences.setString(Constants.GENDER, userModel.gender);
            sharedPreferences.setString(
                Constants.LOCATION, userModel.area ?? '');
            sharedPreferences.setInt(
                Constants.BIRTHDAY, userModel.birthDay ?? 0);
            sharedPreferences.setBool(
                Constants.IS_VERI_CAL, userModel.vertical ?? 0);
          }
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('updateProfile error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> getBabyInfo(
    dynamic map,
  ) async {
    try {
      FormData formData = FormData.fromMap(map);
      Response response = await _client.postForm(
        '${url}user/getBabyInfo',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('updateProfile: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.content != null) {
          UserModel userModel = UserModel.fromJson(responseModel.content);
          if (userModel != null) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString(
                Constants.USERNAME, userModel.nikeName ?? '');
            sharedPreferences.setString(
                Constants.AVATAR, userModel.avatar ?? '');
            sharedPreferences.setString(Constants.GENDER, userModel.gender);
            sharedPreferences.setString(
                Constants.LOCATION, userModel.area ?? '');
            sharedPreferences.setInt(
                Constants.BIRTHDAY, userModel.birthDay ?? 0);
          }
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('updateProfile error: $e, $s');
      return Future.error(e);
    }
  }
}
