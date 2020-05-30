import 'package:Viiddo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Env {
  static Env value;

  final String baseUrl = Constants.baseUrl;

  // Support contact info

  Env() {
    value = this;
    runApp(Viiddo(this));
  }

  String get name => runtimeType.toString();
}
