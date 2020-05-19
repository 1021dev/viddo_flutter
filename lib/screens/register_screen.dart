import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/login/login_bloc.dart';
import 'package:Viiddo/blocs/login/login_state.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFF313131)),
              title: SizedBox(
                height: 0,
              ),
            ),
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
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SingleChildScrollView(
              padding: EdgeInsets.only(left: 45.0, right: 45.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: _title(),
                  ),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 44, top: 24),
              child: _terms(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Registration',
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
              controller: userNameController,
              textInputAction: TextInputAction.next,
              focusNode: userNameFocus,
              style: TextStyle(
                color: Color(0xFF203152),
                fontSize: 20.0,
              ),
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name',
                hasFloatingPlaceholder: true,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFE66E5C), style: BorderStyle.solid)),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
            ),
          ),
          Container(
            height: 70,
            child: TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              focusNode: emailFocus,
              style: TextStyle(
                color: Color(0xFF203152),
                fontSize: 20.0,
              ),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hasFloatingPlaceholder: true,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFE66E5C), style: BorderStyle.solid)),
              ),
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(emailFocus);
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
                labelText: 'Password',
                hasFloatingPlaceholder: true,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFE66E5C), style: BorderStyle.solid)),
              ),
              obscureText: true,
              onSubmitted: (_) {
                FocusScope.of(context).requestFocus(confirmPasswordFocus);
              },
            ),
          ),
          Container(
            height: 70,
            child: TextField(
              controller: confirmPasswordController,
              textInputAction: TextInputAction.next,
              focusNode: confirmPasswordFocus,
              style: TextStyle(
                color: Color(0xFF203152),
                fontSize: 20.0,
              ),
              decoration: InputDecoration(
                labelText: 'Password',
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

  Widget _signUoButton() {
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
            child: Text('Register',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
            onPressed: () {},
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

  Widget _terms() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'By registering you agree with our',
          ),
          GestureDetector(
            child: Text(
              'User agreement',
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF203152),
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {},
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
