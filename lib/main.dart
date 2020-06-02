import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/simple_bloc_delegate.dart';
import 'env.dart';
import 'screens/splash_screen.dart';
import 'themes.dart';

Future main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  Env();
}

class Viiddo extends StatefulWidget {
  final Env env;

  Viiddo(this.env);

  @override
  ViiddoState createState() => new ViiddoState();
}

class ViiddoState extends State<Viiddo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      builder: (context, child) {
        var data = MediaQuery.of(context);
        var textScaleFactor = data.textScaleFactor;
        if (textScaleFactor > 1.25) {
          textScaleFactor = 1.25;
          data = data.copyWith(textScaleFactor: textScaleFactor);
        }
        if (textScaleFactor < 0.9) {
          textScaleFactor = 0.9;
          data = data.copyWith(textScaleFactor: textScaleFactor);
        }
        return MediaQuery(
          child: child,
          data: data,
        );
      },
      theme: lightTheme,
      home: SplashScreen(),
    );
  }
}
