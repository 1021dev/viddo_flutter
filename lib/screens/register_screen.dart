import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/login/login_bloc.dart';
import 'package:Viiddo/blocs/login/login_state.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  LoginScreenBloc screenBloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    screenBloc = LoginScreenBloc();
    userNameController.text = '';
    emailController.text = '';
    confirmPasswordController.text = '';
    passwordController.text = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: screenBloc,
      listener: (BuildContext context, LoginScreenState state) async {},
      child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
        bloc: screenBloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            body: _getBody(state),
          );
        },
      ),
    );
  }

  Widget _getBody(LoginScreenState state) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 80, bottom: 24),
              child: _title(),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(left: 45.0, right: 45.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: loginFields(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 44),
                      child: state.isLoading
                          ? WidgetUtils.loadingView()
                          : _signUoButton(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: _divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: _facebookButton(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 44, top: 24),
              child: _loginButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Registration',
            style: TextStyle(
              color: Color(0xFFFFA685),
              fontSize: 30,
              fontFamily: 'Roboto-Bold',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget loginFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: TextField(
              focusNode: emailFocus,
              controller: emailController,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16.0,
                color: Color(0xFF8476AB),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Image.asset(
                  'assets/icons/ic_email.png',
                ),
                hintText: "Email address",
                hintStyle: TextStyle(fontFamily: "Roboto", fontSize: 16.0),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(userNameFocus);
              },
            ),
          ),
          Divider(
            color: Color(0xFF8476AB),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: TextField(
              focusNode: userNameFocus,
              controller: userNameController,
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16.0,
                color: Color(0xFF8476AB),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Image.asset(
                  'assets/icons/ic_username.png',
                ),
                hintText: "Username",
                hintStyle: TextStyle(fontFamily: "Roboto", fontSize: 16.0),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),
          ),
          Divider(
            color: Color(0xFF8476AB),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: TextField(
              focusNode: passwordFocus,
              controller: passwordController,
              autocorrect: false,
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16.0,
                color: Color(0xFF8476AB),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Image.asset(
                  'assets/icons/ic_password.png',
                ),
                hintText: "Password",
                hintStyle: TextStyle(fontFamily: "Roboto", fontSize: 16.0),
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    FontAwesomeIcons.eye,
                    size: 20.0,
                    color: Color(0xFF8476AB),
                  ),
                ),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(confirmPasswordFocus);
              },
            ),
          ),
          Divider(
            color: Color(0xFF8476AB),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20.0,
            ),
            child: TextField(
              focusNode: confirmPasswordFocus,
              controller: confirmPasswordController,
              autocorrect: false,
              obscureText: true,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              style: TextStyle(
                fontFamily: "Roboto",
                fontSize: 16.0,
                color: Color(0xFF8476AB),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Image.asset(
                  'assets/icons/ic_password.png',
                ),
                hintText: "Repeat Password",
                hintStyle: TextStyle(fontFamily: "Roboto", fontSize: 16.0),
                suffixIcon: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    FontAwesomeIcons.eye,
                    size: 20.0,
                    color: Color(0xFF8476AB),
                  ),
                ),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
          Divider(
            color: Color(0xFF8476AB),
          ),
        ],
      ),
    );
  }

  Widget _signUoButton() {
    return Container(
      height: 50,
      child: SizedBox.expand(
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 1.0,
          color: Color(0xFFFFA685),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            height: 46.0,
            color: Color(0xFFFFA685),
            child: Text('Register',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                )),
            onPressed: () {
              Navigation.toScreenAndCleanBackStack(
                context: context,
                screen: MainScreen(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 24,
      child: Row(
        children: <Widget>[
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(
                  right: 20.0,
                ),
                child: Divider(
                  color: Color(0x808476AB),
                  thickness: 0.5,
                  height: 36,
                )),
          ),
          Text(
            "or",
            style: TextStyle(
              fontSize: 12,
              color: Color(0xFF8476AB),
              fontFamily: 'Roboto',
            ),
          ),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Divider(
                  color: Color(0x808476AB),
                  thickness: 0.5,
                  height: 36,
                )),
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton.icon(
            label: Flexible(
              fit: FlexFit.loose,
              child: Container(
                color: Colors.transparent,
                child: Text(
                  'Sign in with Facebook',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF439EF2),
                  ),
                ),
              ),
            ),
            icon: Image(
              image: AssetImage("assets/icons/2.0x/login_facebook.png"),
              width: 24.0,
              height: 24.0,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 16,
            child: Text(
              'Already have an account?',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF8476AB),
                fontFamily: 'Roboto',
              ),
            ),
          ),
          GestureDetector(
            child: Text(
              'Sign in now',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFFFAA382),
                fontFamily: 'Roboto-Bold',
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    userNameController.dispose();
    confirmPasswordController.dispose();

    userNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    screenBloc.close();
    super.dispose();
  }
}
