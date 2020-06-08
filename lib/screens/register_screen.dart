import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/register/register.dart';
import 'package:Viiddo/utils/email_validator.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenBloc screenBloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  static final FacebookLogin facebookSignIn = new FacebookLogin();

  FocusNode emailFocus = FocusNode();
  FocusNode userNameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();
  bool isPasswordShow = false;
  bool isConfirmPasswordShow = false;

  SharedPreferences sharedPreferences;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    screenBloc = RegisterScreenBloc();
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
      listener: (BuildContext context, RegisterScreenState state) async {
        if (state is RegisterSuccess) {
          Navigation.toScreenWithReplacement(
            context: context,
            screen: MainScreen(
              selectedPage: 2,
            ),
          );
        } else if (state is RegisterScreenFailure) {
          WidgetUtils.showErrorDialog(context, state.error);
        }
      },
      child: BlocBuilder<RegisterScreenBloc, RegisterScreenState>(
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

  Widget _getBody(RegisterScreenState state) {
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
              padding: const EdgeInsets.only(
                top: 80,
                bottom: 24,
              ),
              child: _title(),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 45.0,
                  right: 45.0,
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: loginFields(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 44,
                      ),
                      child: state.isLoading
                          ? WidgetUtils.loadingView()
                          : _signUoButton(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: _divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: _facebookButton(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 44,
                top: 24,
              ),
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
              top: 16.0,
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
              top: 16.0,
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
              top: 16.0,
            ),
            child: TextField(
              focusNode: passwordFocus,
              controller: passwordController,
              autocorrect: false,
              obscureText: !isPasswordShow,
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
                suffixIcon: IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/icons/ic_reveal_password.png'),
                  ),
                  color: isPasswordShow ? Color(0xFF8476AB) : Color(0xFFFAA382),
                  onPressed: () {
                    setState(() {
                      isPasswordShow = !isPasswordShow;
                    });
                  },
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
              top: 16.0,
            ),
            child: TextField(
              focusNode: confirmPasswordFocus,
              controller: confirmPasswordController,
              autocorrect: false,
              obscureText: !isConfirmPasswordShow,
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
                suffixIcon: IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/icons/ic_reveal_password.png'),
                  ),
                  color: isConfirmPasswordShow
                      ? Color(0xFF8476AB)
                      : Color(0xFFFAA382),
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordShow = !isConfirmPasswordShow;
                    });
                  },
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
      height: 44,
      child: SizedBox.expand(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Color(0xFFFFA685),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            height: 44.0,
            color: Color(0xFFFFA685),
            child: Text('Register',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                )),
            onPressed: () {
              if (userNameController.text.length == 0) {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Please enter username'),
                  ),
                );
              } else if (emailController.text.length == 0) {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Please enter email address'),
                  ),
                );
              } else if (passwordController.text.length == 0) {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Please enter password'),
                  ),
                );
              } else if (confirmPasswordController.text.length == 0) {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Please enter confirm password'),
                  ),
                );
              } else if (!EmailValidator.validate(emailController.text)) {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Please enter valid email address'),
                  ),
                );
              } else {
                screenBloc.add(
                  Register(
                    userNameController.text,
                    emailController.text,
                    passwordController.text,
                  ),
                );
              }
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
            'or',
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
              image: AssetImage("assets/icons/facebook_logo.png"),
              width: 24.0,
              height: 24.0,
            ),
            onPressed: () {
              _loginFacebook();
            },
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

  Future<Null> _loginFacebook() async {
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;
        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');
        screenBloc.add(FacebookRegisterEvent(accessToken));
        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
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
