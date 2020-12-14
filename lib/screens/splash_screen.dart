import 'package:Viiddo/blocs/splash/splash_bloc.dart';
import 'package:Viiddo/blocs/splash/splash_event.dart';
import 'package:Viiddo/blocs/splash/splash_state.dart';
import 'package:Viiddo/screens/main_screen.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenBloc screenBloc;

  @override
  void initState() {
    screenBloc = SplashScreenBloc();
    screenBloc.add(TryAutoLogin());
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: screenBloc,
      listener: (BuildContext context, SplashScreenState state) async {
        if (state is AutoLoginFailure) {
          Navigation.toScreenAndCleanBackStack(
            context: context,
            screen: LoginScreen(),
          );
        } else if (state is AutoLoginSuccess) {
          Navigation.toScreenAndCleanBackStack(
            context: context,
            screen: MainScreen(),
          );
        }
      },
      child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
        bloc: screenBloc,
        builder: (BuildContext context, SplashScreenState state) {
          return Scaffold(backgroundColor: Colors.white, body: _getBody(state));
        },
      ),
    );
  }

  Widget _getBody(SplashScreenState state) {
    return Container();//Center(child: Image.asset('assets/icons/signin_logo.png'));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    screenBloc.close();
    super.dispose();
  }
}
