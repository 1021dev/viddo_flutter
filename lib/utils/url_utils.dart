import 'package:shared_preferences/shared_preferences.dart';

class UrlUtils {
  static Future<SharedPreferences> get _prefs =>
      SharedPreferences.getInstance();

  static Future<String> getBaseUrl() async {
    return (await _prefs).getString('baseUrl');
  }

  static Future<bool> saveBaseUrl(String url) async {
    return (await _prefs).setString('baseUrl', url);
  }
}
