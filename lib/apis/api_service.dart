import 'dart:io';
import 'dart:math';

import 'package:Viiddo/models/activity_notification_list_model.dart';
import 'package:Viiddo/models/agree_info_model.dart';
import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/friend_list_model.dart';
import 'package:Viiddo/models/growth_record_list_model.dart';
import 'package:Viiddo/models/message_list_model.dart';
import 'package:Viiddo/models/message_model.dart';
import 'package:Viiddo/models/page_response_model.dart';
import 'package:Viiddo/models/sticker_category_model.dart';
import 'package:Viiddo/models/sticker_list_model.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:Viiddo/models/vaccine_list_model.dart';
import 'package:Viiddo/models/vaccine_model.dart';
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

  Future<LoginModel> accountLogin(
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
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
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
          return loginModel;
        }
      }
      return null;
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

  Future<LoginModel> facebookLogin(
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
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
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

          return loginModel;
        }
      }
      return null;
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
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
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
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
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
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
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
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
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

  Future<bool> resetPassword(
      String email,
      String password,
      String code,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'email': email,
        'password': password,
        'code': code,
      });
      Response response = await _client.postForm(
        '${url}account/resetpassword',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('resetPassword: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('resetPassword error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> changeEmail(
      String oldEmail,
      String newEmail,
      String password,
      String newCode,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'oldEmail': oldEmail,
        'newEmail': newEmail,
        'password': password,
        'newCode': newCode,
      });
      Response response = await _client.postForm(
        '${url}account/changeEmail',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('changeEmail: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('changeEmail error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> verifyOldEmail(
      String oldEmail,
      String code,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'oldEmail': oldEmail,
        'code': code,
      });
      Response response = await _client.postForm(
        '${url}account/verifyOldEmail',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('verifyOldEmail: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('verifyOldEmail error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> checkCode(
      String code,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'code': code,
      });
      Response response = await _client.postForm(
        '${url}account/checkCode',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('checkCode: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('checkCode error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> logout() async {
    try {
      Response response = await _client.postForm(
        '${url}account/logout',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('logout: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('logout error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> accountTime() async {
    try {
      Response response = await _client.postForm(
        '${url}account/time',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('accountTime: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('accountTime error: $e, $s');
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
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
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

        String result;
        AwsS3 awsS3 = AwsS3(
            awsFolderPath: 'Posts',
            file: imageFiles[i],
            fileNameWithExt: '${uuid}_$i$extension',
            poolId: Constants.cognitoPoolId,
            region: Regions.US_EAST_2,
            bucketName: Constants.bucket);
        try {
          try {
            result = await awsS3.uploadFile;
            debugPrint("Result :'$result'.");
          } on PlatformException {
            debugPrint("Result :'$result'.");
          }
        } on PlatformException catch (e) {
          debugPrint("Failed :'${e.message}'.");
        }

        // String uploadedImageUrl = await AmazonS3Cognito.upload(
        //     imageFiles[i].path,
        //     Constants.bucket,
        //     Constants.cognitoPoolId,
        //     '${uuid}_$i.$extension',
        //     AwsRegion.US_EAST_2,
        //     AwsRegion.US_EAST_2);
        String url =
            'https://d1qaud6fcxefsz.cloudfront.net/Posts/${uuid}_$i$extension';
        if (result != null) {
          urls.add(url);
        }
      }
      return urls;
    } on DioError catch (e, s) {
      print('updateProfile error: $e, $s');
      return Future.error(e);
    }
  }

  Future<FriendListModel> getFriendsByBaby(
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({'objectId': objectId});
      Response response = await _client.postForm(
        '${url}user/getFriendsByBaby',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getFriendsByBaby: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          FriendListModel friendListModel =
              FriendListModel.fromJson(responseModel.content);
          return friendListModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getFriendsByBaby error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> inviteJoinBaby(
    int objectId,
    String email,
  ) async {
    try {
      FormData formData = FormData.fromMap({'objectId': objectId, 'email': email});
      Response response = await _client.postForm(
        '${url}user/inviteJoinBaby',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('inviteJoinBaby: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('inviteJoinBaby error: $e, $s');
      return Future.error(e);
    }
  }

  Future<BabyModel> getBabyInfo(
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({'objectId': objectId});
      Response response = await _client.postForm(
        '${url}user/getBabyInfo',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getBabyInfo: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          BabyModel babyModel = BabyModel.fromJson(responseModel.content);
          if (babyModel != null) {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setInt(
                Constants.BABY_ID, babyModel.objectId ?? 0);
            sharedPreferences.setString(
                Constants.BABY_ICON, babyModel.avatar ?? '');
            sharedPreferences.setBool(
                Constants.IS_CREATOR, babyModel.isCreator ?? false);
            sharedPreferences.setBool(
                Constants.IS_BIRTH, babyModel.isBirth ?? false);
          }
          return babyModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getBabyInfo error: $e, $s');
      return Future.error(e);
    }
  }

  Future<BabyListModel> getMyBabyList(
    int page,
  ) async {
    try {
      FormData formData = FormData.fromMap({'page': page});
      Response response = await _client.postForm(
        '${url}user/getMyBabys',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getMyBabyList: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          BabyListModel babyListModel =
              BabyListModel.fromJson(responseModel.content);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          int objectId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
          if (objectId == 0 && babyListModel.content.length > 0) {
            sharedPreferences.setInt(
                Constants.BABY_ID, babyListModel.content.first.objectId ?? 0);
            sharedPreferences.setString(
                Constants.BABY_ICON, babyListModel.content.first.avatar ?? '');
            sharedPreferences.setBool(Constants.IS_CREATOR,
                babyListModel.content.first.isCreator ?? false);
            sharedPreferences.setBool(Constants.IS_BIRTH,
                babyListModel.content.first.isBirth ?? false);
          }

          return babyListModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getMyBabyList error: $e, $s');
      return Future.error(e);
    }
  }

  Future<PageResponseModel> getMomentByBaby(
    int babyId,
    int page,
    bool tag,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': babyId,
        'page': page,
        'tag': tag,
      });
      Response response = await _client.postForm(
        '${url}information/getMomentsByBaby',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getMomentByBaby: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          PageResponseModel pageResponseModel =
              PageResponseModel.fromJson(responseModel.content);
          if (pageResponseModel.content != null) {
            return pageResponseModel;
          }
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getMomentByBaby error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> deleteMoment(
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
      });
      Response response = await _client.postForm(
        '${url}information/deleteMoment',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('deleteMoment: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('deleteMoment error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> deleteBaby(
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
      });
      Response response = await _client.postForm(
        '${url}user/deleteBaby',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('deleteBaby: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('deleteBaby error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> deleteBodyRecord(
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
      });
      Response response = await _client.postForm(
        '${url}user/deleteBodyRecord',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('deleteBodyRecord: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('deleteBodyRecord error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> removeFriendShip(
    int objectId,
    int babyId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'babyId': babyId,
      });
      Response response = await _client.postForm(
        '${url}user/removeFriendShip',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('removeFriendShip: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('removeFriendShip error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> babyBorn(
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
      });
      Response response = await _client.postForm(
        '${url}user/babyBorn',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('babyBorn: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('babyBorn error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> postMonment(
      String content,
      String resource,
      String tags,
      String address,
      double lat,
      double lng,
      String toWho,
      int addTime,
      String babyids,
      int objectId,
      int tagId,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'content': content,
        'resource': resource,
        'tags': tags,
        'address': address,
        'lat': lat,
        'lng': lng,
        'toWho': toWho,
        'addTime': addTime,
        'babyids': babyids,
        'objectId': objectId,
        'tagId': tagId,
      });
      Response response = await _client.postForm(
        '${url}information/postMonment',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('postMonment: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('postMonment error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> getRefreshInformation() async {
    try {
      Response response = await _client.postForm(
        '${url}information/refresh',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getRefreshInformation: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          bool isRefresh = responseModel.content['refresh'] ?? false;
          return isRefresh;
        }
      }
      return Future.error('Error');
    } on DioError catch (e, s) {
      print('getRefreshInformation error: $e, $s');
      return Future.error(e);
    }
  }

  Future<UnreadMessageModel> getUnreadMessages() async {
    try {
      Response response = await _client.postForm(
        '${url}common/unreadMessage',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getUnreadMessages: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          UnreadMessageModel unreadMessageModel =
              UnreadMessageModel.fromJson(responseModel.content);
          return unreadMessageModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getRefreshInformation error: $e, $s');
      return Future.error(e);
    }
  }

  Future<MessageModel> getSystemMessageDetails(int objectId) async {
    try {
      FormData formData = FormData.fromMap({'objectId': objectId});
      Response response = await _client.postForm(
        '${url}common/getSystemMsgDetails',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getSystemMessageDetails: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          MessageModel messageModel =
              MessageModel.fromJson(responseModel.content);
          return messageModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getSystemMessageDetails error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> feedback(
      String content,
      String attachs,
      String email,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'content': content,
        'attachs': attachs,
        'email': email,
      });
      Response response = await _client.postForm(
        '${url}common/feedback',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getSystemMessageDetails: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        return true;
      }
      return false;
    } on DioError catch (e, s) {
      print('getSystemMessageDetails error: $e, $s');
      return Future.error(e);
    }
  }

  Future<String> getStaticPage(
      String content,
      String attachs,
      String email,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'content': content,
        'attachs': attachs,
        'email': email,
      });
      Response response = await _client.postForm(
        '${url}common/getStaticPage',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getSystemMessageDetails: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return responseModel.content['data'];
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getSystemMessageDetails error: $e, $s');
      return Future.error(e);
    }
  }

  Future<MessageListModel> getSystemessage(int page) async {
    try {
      FormData formData = FormData.fromMap({'page': page});
      Response response = await _client.postForm(
        '${url}common/getSystemMsg',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getSystemessage: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          MessageListModel messageListModel =
              MessageListModel.fromJson(responseModel.content);
          return messageListModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getSystemessage error: $e, $s');
      return Future.error(e);
    }
  }

  Future<ActivityNotificationListModel> getActivityList(int page) async {
    try {
      FormData formData = FormData.fromMap({'page': page});
      Response response = await _client.postForm(
        '${url}common/activityList',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getActivityList: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          ActivityNotificationListModel activityNotificationListModel =
              ActivityNotificationListModel.fromJson(responseModel.content);
          return activityNotificationListModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getActivityList error: $e, $s');
      return Future.error(e);
    }
  }

  Future<ResponseModel> makeMessageRead(int objectId, bool readAll) async {
    try {
      FormData formData = FormData.fromMap({'objectId': objectId, 'readAll': readAll});
      Response response = await _client.postForm(
        '${url}common/isReadMessage',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('makeMessageRead: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        return responseModel;
      }
      return null;
    } on DioError catch (e, s) {
      print('makeMessageRead error: $e, $s');
      return Future.error(e);
    }
  }

  Future<ResponseModel> deleteMessage(String objectIds, bool deleteAll) async {
    try {
      FormData formData = FormData.fromMap({'objectIds': objectIds, 'deleteAll': deleteAll});
      Response response = await _client.postForm(
        '${url}common/deleteMessage',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('makeMessageRead: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        return responseModel;
      }
      return null;
    } on DioError catch (e, s) {
      print('makeMessageRead error: $e, $s');
      return Future.error(e);
    }
  }

  Future<UnreadMessageModel> getMessageUnreadCount() async {
    try {
      Response response = await _client.postForm(
        '${url}common/messageUnreadCount',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getMessageUnreadCount: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          UnreadMessageModel unreadMessageModel = UnreadMessageModel.fromJson(responseModel.content);
          return unreadMessageModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getMessageUnreadCount error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> updateBabyInformation(
    dynamic map,
  ) async {
    try {
      FormData formData = FormData.fromMap(map);
      Response response = await _client.postForm(
        '${url}user/editBabyInfo',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('updateBabyInformation: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          // UserModel userModel = UserModel.fromJson(responseModel.content);
          // if (userModel != null) {
          //   SharedPreferences sharedPreferences =
          //       await SharedPreferences.getInstance();
          //   sharedPreferences.setString(
          //       Constants.USERNAME, userModel.nikeName ?? '');
          //   sharedPreferences.setString(
          //       Constants.AVATAR, userModel.avatar ?? '');
          //   sharedPreferences.setString(Constants.GENDER, userModel.gender);
          //   sharedPreferences.setString(
          //       Constants.LOCATION, userModel.area ?? '');
          //   sharedPreferences.setInt(
          //       Constants.BIRTHDAY, userModel.birthDay ?? 0);
          //   sharedPreferences.setBool(
          //       Constants.IS_VERI_CAL, userModel.vertical ?? 0);
          // }
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('updateBabyInformation error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> updateLike(
    int objectId, bool isLike,
  ) async {
    try {
      FormData formData = FormData.fromMap({'objectId': objectId, 'isLike': isLike});
      Response response = await _client.postForm(
        '${url}information/isLikeMoment',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('isLikeMoment: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status == 200) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('isLikeMoment error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> addBodyRecord(
    double height,
    double weight,
    int recodTime,
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'weight': weight,
        'height': height,
        'recodTime': recodTime,
        });
      Response response = await _client.postForm(
        '${url}user/addBodyRecord',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('addBodyRecord: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status == 200) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('addBodyRecord error: $e, $s');
      return Future.error(e);
    }
  }

  Future<GrowthRecordListModel> getBodyRecord(
    int page,
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'page': page,
        });
      Response response = await _client.postForm(
        '${url}user/getBodyRecord',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getBodyRecord: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status == 200) {
          GrowthRecordListModel growthRecordListModel = GrowthRecordListModel.fromJson(responseModel.content);
          return growthRecordListModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getBodyRecord error: $e, $s');
      return Future.error(e);
    }
  }

  Future<VaccineListModel> getVaccineByBaby(
    int page,
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'page': page,
        });
      Response response = await _client.postForm(
        '${url}user/getVaccineByBaby',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getVaccineByBaby: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status != null) {
          VaccineListModel vaccineListModel = VaccineListModel.fromJson(responseModel.content);
          return vaccineListModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getVaccineByBaby error: $e, $s');
      return Future.error(e);
    }
  }

  Future<VaccineModel> getVaccineDetails(
    int babyId,
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'babyId': babyId,
        });
      Response response = await _client.postForm(
        '${url}user/getVaccineDetails',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getVaccineDetails: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status != null) {
          VaccineModel vaccineModel = VaccineModel.fromJson(responseModel.content);
          return vaccineModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getVaccineDetails error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> setVaccineStatus(
    int babyId,
    int time,
    String status,
    int objectId,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'time': time,
        'status': status,
        'babyId': babyId,
        });
      Response response = await _client.postForm(
        '${url}user/setVaccineStatus',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('setVaccineStatus: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('setVaccineStatus error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> postComment(
    int objectId, int parentId, int replyUserId, String content,
  ) async {
    try {
      FormData formData = FormData.fromMap({'objectId': objectId, 'parentId': parentId, 'replyUserId': replyUserId, 'content': content});
      Response response = await _client.postForm(
        '${url}information/postComment',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('postComment: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status == 200) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('postComment error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> addBaby(
    String avatar,
    String name,
    int birthday,
    String relationship,
    bool isBirth,
    String gender,
    int expectedDate,
  ) async {
    try {
      FormData formData = FormData.fromMap({
        'avatar': avatar,
        'name': name,
        'birthday': birthday,
        'relationship': relationship,
        'isBirth': isBirth,
        'gender': gender,
        'expectedDate': expectedDate,
        });
      Response response = await _client.postForm(
        '${url}user/addBaby',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('addBaby: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.status == 200) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('addBaby error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> verifyInvitationCode(
      String invitationCode,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'invitationCode': invitationCode,
      });
      Response response = await _client.postForm(
        '${url}user/VerifyInvitationCode',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('verifyInvitationCode: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('verifyInvitationCode error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> joinBaby(
      String invitationCode,
      String relationship,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'invitationCode': invitationCode,
        'relationship': relationship,
      });
      Response response = await _client.postForm(
        '${url}user/joinBaby',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('joinBaby: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('joinBaby error: $e, $s');
      return Future.error(e);
    }
  }

  Future<DynamicContent> getMomentDetails(
      int objectId,
      int babyId,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'babyId': babyId,
      });
      Response response = await _client.postForm(
        '${url}information/getMonmentDetails',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getMomentDetails: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          DynamicContent dynamicContent =
          DynamicContent.fromJson(responseModel.content);
          return dynamicContent;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getMomentDetails error: $e, $s');
      return Future.error(e);
    }
  }

  Future<AgreeInfoModel> invitateFriendsDetails(
      int objectId,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
      });
      Response response = await _client.postForm(
        '${url}invitate/FriendsDetials',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('invitateFriendsDetials: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          AgreeInfoModel agreeInfoModel =
          AgreeInfoModel.fromJson(responseModel.content);
          return agreeInfoModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('invitateFriendsDetials error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> invitateDispose(
      int objectId,
      bool isAgree,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'objectId': objectId,
        'isAgree': isAgree,
      });
      Response response = await _client.postForm(
        '${url}invitate/dispose',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('invitateDispose: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('invitateDispose error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> uploadPushToken(
      String token,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'token': token,
      });
      Response response = await _client.postForm(
        '${url}common/push?token=$token',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('uploadPushToken: {$response}');
      return true;
    } on DioError catch (e, s) {
      print('uploadPushToken error: $e, $s');
      return Future.error(e);
    }
  }

  Future<bool> clearBadge() async {
    try {
      Response response = await _client.get(
        '${url}common/clearBadge',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('clearBadge: {$response}');
      return true;
    } on DioError catch (e, s) {
      print('clearBadge error: $e, $s');
      return Future.error(e);
    }
  }

  Future<List<StickerCategory>> getStikerCategory() async {
    try {
      Response response = await _client.postForm(
        '${url}information/getStikerCategory',
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('getStikerCategory: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          List categories = List.castFrom(responseModel.content);
          List<StickerCategory> stickerCategory = [];
          for (int i = 0; i < categories.length; i++)
          {
            stickerCategory.add(StickerCategory.fromJson(categories[i]));
          }
          return stickerCategory;
        }
      }
      return [];
    } on DioError catch (e, s) {
      print('getStikerCategory error: $e, $s');
      return Future.error(e);
    }
  }

  Future<StickerListModel> getStickers(
      int objectId,
      int page,
      ) async {
    try {
      FormData formData = FormData.fromMap({
        'categoryid': objectId,
        'page': page,
      });
      Response response = await _client.postForm(
        '${url}information/getStickers',
        body: formData,
        headers: {
          'content-type': 'multipart/form-data',
          'accept': '*/*',
        },
      );
      print('objectId => $objectId, page => $page  getStickers: {$response}');
      if (response.statusCode == 200) {
        ResponseModel responseModel = ResponseModel.fromJson(response.data);
        if (responseModel.status == 1000) {
          return Future.error('Logout');
        }
        if (responseModel.content != null) {
          StickerListModel stickerListModel = StickerListModel.fromJson(responseModel.content);
          return stickerListModel;
        }
      }
      return null;
    } on DioError catch (e, s) {
      print('getStickers error: $e, $s');
      return Future.error(e);
    }
  }
}
