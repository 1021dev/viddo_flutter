import 'package:flutter/material.dart';
import 'main.dart';

class Env {
  static Env value;

  final String baseUrl = 'http://www.icranetrax.info/';

  // Support contact info

  Env() {
    value = this;
    runApp(Viiddo(this));
  }

  String get name => runtimeType.toString();
}
