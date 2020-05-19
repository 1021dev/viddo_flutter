import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/login/login_bloc.dart';
import 'package:Viiddo/blocs/login/login_state.dart';
import 'package:Viiddo/screens/register_screen.dart';
import 'package:Viiddo/screens/reset_password_screen.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginScreenBloc screenBloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  FocusNode passwordFocus = FocusNode();
  SharedPreferences sharedPreferences;
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
        }
      },
      child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
        bloc: screenBloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            resizeToAvoidBottomPadding: false,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.all(45.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 64),
                  child: _title(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: loginFields(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: _forgotPassword(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 44),
                  child: state.isLoading
                      ? WidgetUtils.loadingView()
                      : _loginButton(),
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
          Padding(
            padding: const EdgeInsets.only(bottom: 64, top: 24),
            child: _signUpButton(),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Sign In',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 28,
              fontWeight: FontWeight.w500,
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
          Container(
            height: 70,
            child: TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              style: TextStyle(
                color: Color(0xFF203152),
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                labelText: 'Email',
                hasFloatingPlaceholder: true,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFE66E5C), style: BorderStyle.solid)),
              ),
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),
          ),
          Container(
            height: 70,
            child: TextField(
              controller: passwordController,
              textInputAction: TextInputAction.next,
              focusNode: passwordFocus,
              style: TextStyle(
                color: Color(0xFF203152),
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hasFloatingPlaceholder: true,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFE66E5C), style: BorderStyle.solid)),
              ),
              obscureText: true,
              onSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _forgotPassword() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.only(right: 0.0),
            color: Colors.transparent,
            child: Text('Forgot password?',
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color(0xFFE66E5C),
                  fontWeight: FontWeight.w500,
                )),
            onPressed: () {
              Navigation.toScreen(
                  context: context, screen: ResetPasswordScreen());
            },
          ),
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      height: 50,
      child: SizedBox.expand(
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          elevation: 4.0,
          color: Color(0xFFE66E5C),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            height: 46.0,
            color: Color(0xFFE66E5C),
            child: Text('Sign In',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
            onPressed: () {
              screenBloc.add(Login(
                emailController.text,
                passwordController.text,
              ));
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
                  color: Color(0xFFE5E5E5),
                  thickness: 1,
                  height: 36,
                )),
          ),
          Text("or"),
          Expanded(
            child: new Container(
                margin: const EdgeInsets.only(
                  left: 20.0,
                ),
                child: Divider(
                  color: Color(0xFFE5E5E5),
                  thickness: 1,
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
                      fontSize: 14.0,
                      color: Color(0xFFE66E5C),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            icon: Image(
              image: AssetImage("assets/icons/login_facebook.png"),
              width: 24.0,
              height: 24.0,
            ),
            onPressed: () {},
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
            ),
          ),
          GestureDetector(
            child: Text(
              'Sign up now',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF203152),
                fontWeight: FontWeight.w500,
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    passwordFocus.dispose();
    screenBloc.close();
    super.dispose();
  }
}
