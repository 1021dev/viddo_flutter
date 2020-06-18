import 'package:Viiddo/screens/home/babies/add_baby_screen.dart';
import 'package:Viiddo/screens/home/babies/babies_screen.dart';
import 'package:Viiddo/screens/home/babies/edit_baby_information.dart';
import 'package:Viiddo/screens/home/baby_details.dart';
import 'package:Viiddo/screens/home/comments/comment_screen.dart';
import 'package:Viiddo/screens/main_screen.dart';
import 'package:Viiddo/screens/register_screen.dart';
import 'package:Viiddo/screens/reset_password_screen.dart';
import 'package:Viiddo/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'blocs/simple_bloc_delegate.dart';
import 'env.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';
import 'themes.dart';

const debug = true;
Future main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(debug: debug);
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
        ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
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
      routes: <String, WidgetBuilder> {
        '/splash' : (BuildContext context) => new SplashScreen(),
        '/login' : (BuildContext context) => new LoginScreen(),
        '/register' : (BuildContext context) => new RegisterScreen(),
        '/resetpassword' : (BuildContext context) => new ResetPasswordScreen(),
        '/main' : (BuildContext context) => new MainScreen(),
        '/babydetails' : (BuildContext context) => new BabyDetailsScreen(),
        '/babylist' : (BuildContext context) => new BabiesScreen(),
        '/addbaby' : (BuildContext context) => new AddBabyScreen(),
        '/editbaby' : (BuildContext context) => new EditBabyInformationScreen(),
        '/comments' : (BuildContext context) => new CommentScreen(),
      },
    );
  }
}
