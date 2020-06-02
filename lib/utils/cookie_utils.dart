import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CookieUtils {
  static String cookieKey = 'cookie';

  static List<String> extractCookies(HttpHeaders headers) {
    List<String> cookies = [];
    headers.forEach((String name, List<String> values) {
      if (name == 'set-cookie') {
        cookies.addAll(values);
      }
    });

    return cookies;
  }

  static List<String> extractHeaderCookies(Headers headers) {
    List<String> cookies = [];
    headers.forEach((String name, List<String> values) {
      if (name == 'set-cookie') {
        cookies.addAll(values);
      }
    });

    return cookies;
  }

  static Future<bool> saveCookies(List<String> cookies) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String setCookiesJson = json.encode(cookies);
      bool result =
          await sharedPreferences.setString(cookieKey, setCookiesJson);
      return result;
    } on Exception catch (e, s) {
      print('saveCookies error: $e, $s');
      return Future.error(e);
    }
  }

  static Future<bool> updateCookie(List<String> cookies) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<String> oldCookies = await getCookies();

      oldCookies.addAll(cookies);

      String setCookiesJson = json.encode(oldCookies);
      bool result =
          await sharedPreferences.setString(cookieKey, setCookiesJson);
      return result;
    } on Exception catch (e, s) {
      print('updateCookie error: $e, $s');
      return Future.error(e);
    }
  }

  static Future<List<String>> getCookies() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var cookies = sharedPreferences.getString(cookieKey);
    if ((cookies ?? '').length == 0) {
      return null;
    }
    return json.decode(cookies).cast<String>();
  }

  static Future<bool> clearCookies() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result = await sharedPreferences.remove(cookieKey);
    print('Cookies cleared: $result');
    return result;
  }
}
