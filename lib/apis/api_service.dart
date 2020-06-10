import 'dart:io';
import 'dart:math';

import 'package:Viiddo/models/activity_notification_list_model.dart';
import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/friend_list_model.dart';
import 'package:Viiddo/models/message_list_model.dart';
import 'package:Viiddo/models/message_model.dart';
import 'package:Viiddo/models/page_response_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
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

}
