import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/reset_password/reset__password_bloc.dart';
import 'package:Viiddo/blocs/reset_password/reset_password.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  String email = '';
  ResetPasswordScreen({
    this.email = '',
  });

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetPassowrdScreenBloc screenBloc;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController emailController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    screenBloc = ResetPassowrdScreenBloc();
    emailController.text = widget.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: screenBloc,
      listener: (BuildContext context, ResetPasswordScreenState state) async {
        if (state is ResetCodeSentSuccess) {
          _handleResetPassword();
        }
      },
      child: BlocBuilder<ResetPassowrdScreenBloc, ResetPasswordScreenState>(
        bloc: screenBloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Color(0xFFFFA685)),
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

  Widget _getBody(ResetPasswordScreenState state) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: SingleChildScrollView(
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
                    : _resetButton(),
              ),
            ],
          ),
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
            'Reset Password',
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
                hintText: "Enter Email address",
                hintStyle: TextStyle(fontFamily: "Roboto", fontSize: 16.0),
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

  Widget _resetButton() {
    return Container(
      height: 50,
      child: SizedBox.expand(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 1.0,
          color: Color(0xFFFFA685),
          clipBehavior: Clip.antiAlias,
          child: MaterialButton(
            height: 46.0,
            color: Color(0xFFFFA685),
            child: Text('Reset',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontFamily: 'Roboto',
                )),
            onPressed: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              currentFocus.unfocus();
              _handleResetPassword();
            },
          ),
        ),
      ),
    );
  }

  Future<void> _handleResetPassword() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
            child: Text(
              'Please check your email, follow the link and change your password.',
              style: TextStyle(
                color: Color(0xFF8476AB),
                fontFamily: 'Roboto',
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFFE46E5C),
                  fontFamily: 'Roboto',
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocus.dispose();
    screenBloc.close();
    super.dispose();
  }
}
