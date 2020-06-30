import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/login/login_bloc.dart';
import 'package:Viiddo/blocs/login/login_state.dart';
import 'package:Viiddo/screens/main_screen.dart';
import 'package:Viiddo/screens/register_screen.dart';
import 'package:Viiddo/screens/reset_password_screen.dart';
import 'package:Viiddo/utils/email_validator.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenBloc screenBloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  SharedPreferences sharedPreferences;
  bool isPasswordShow = false;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    screenBloc = LoginScreenBloc();
    emailController.text = '';
    passwordController.text = '';
    SharedPreferences.getInstance().then((sp) {
      sharedPreferences = sp;
      if (sp.getString('username') != null) {
        emailController.text = sp.getString('username') ?? '';
        passwordController.text = sp.getString('password') ?? '';
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: screenBloc,
      listener: (BuildContext context, LoginScreenState state) async {
        if (state is LoginScreenFailure) {
          WidgetUtils.showErrorDialog(context, 'Invalid Login Credentials');
        } else if (state is LoginSuccess) {
          sharedPreferences.setString(
              'username', emailController.text.toString());
          sharedPreferences.setString(
              'password', passwordController.text.toString());
          if (state.isVerical) {
            Navigation.toScreenAndCleanBackStack(
              context: context,
              screen: MainScreen(
                selectedPage: 0,
              ),
            );
          } else {
            Navigation.toScreenAndCleanBackStack(
              context: context,
              screen: MainScreen(
                selectedPage: 2,
              ),
            );
          }
        }
      },
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                        top: 24,
                      ),
                      child: _forgotPassword(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 24,
                      ),
                      child: state.isLoading
                          ? WidgetUtils.loadingView()
                          : _loginButton(),
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
              padding: const EdgeInsets.only(bottom: 44, top: 24),
              child: _signUpButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icons/signin_logo.png',
            height: 40,
            width: 40,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8),
          ),
          Text(
            'Sign In',
            style: TextStyle(
              color: Color(0xFFFFA685),
              fontSize: 30,
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
                hintText: "Enter Email address",
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
                hintText: "Enter Password",
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

  Widget _forgotPassword() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.only(right: 0.0),
            color: Colors.transparent,
            child: Text('Forgot password?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'Roboto',
                  color: Color(0xFFFAA382),
                )),
            onPressed: () {
              Navigation.toScreen(
                context: context,
                screen: ResetPasswordScreen(
                  email: emailController.text,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
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
            child: Text('Sign In',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                )),
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (emailController.text.length == 0) {
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
              } else if (!EmailValidator.validate(emailController.text)) {
                scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Please enter valid email address'),
                  ),
                );
              } else {
                screenBloc.add(
                  Login(
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

  Widget _signUpButton() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 16,
            child: Text(
              'Don\'t have an account yet?',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF8476AB),
                fontFamily: 'Roboto',
              ),
            ),
          ),
          GestureDetector(
            child: Text(
              'Sign up now',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFFFAA382),
                fontFamily: 'Roboto-Bold',
              ),
            ),
            onTap: () {
              Navigation.toScreen(context: context, screen: RegisterScreen());
            },
          )
        ],
      ),
    );
  }

  Future<Null> _loginFacebook() async {
    await facebookSignIn.logOut();
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
        screenBloc.add(FacebookLoginEvent(accessToken));
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

    passwordFocus.dispose();
    screenBloc.close();
    super.dispose();
  }
}
