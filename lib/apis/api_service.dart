import 'dart:io';

import 'package:Viiddo/models/login_model.dart';
import 'package:Viiddo/models/response_model.dart';
import 'package:dio/dio.dart';

import 'package:device_info/device_info.dart';

import '../env.dart';
import 'base_client.dart';

class ApiService {
  BaseClient _client = BaseClient();

  String url = Env().baseUrl;

  Future<bool> accountLogin(String email, String password) async {
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
          return true;
        }
      }
      return false;
    } on DioError catch (e, s) {
      print('accountLogin error: $e, $s');
      return Future.error(e);
    }
  }
}
