import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:Viiddo/screens/login_screen.dart';
import 'package:Viiddo/screens/profile/edit/edit_profile_setting_tile.dart';
import 'package:Viiddo/screens/profile/settings/webview_screen.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../themes.dart';

class SettingsScreen extends StatefulWidget {
  MainScreenBloc bloc;

  SettingsScreen({
    this.bloc,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, MainScreenState state) async {},
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: Text('Settings'),
              backgroundColor: Colors.white,
              elevation: 0,
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: Color(0xFF7861B7),
                  fontSize: 18.0,
                  fontFamily: 'Roboto',
                ),
              ),
              iconTheme: IconThemeData(
                color: Color(0xFFFFA685),
                size: 12,
              ),
            ),
            key: scaffoldKey,
            body: _getBody(state),
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
    return SafeArea(
      key: formKey,
      child: Container(
        color: Color(0xFFFFFBF8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            _listView(state),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(
                  height: 100,
                  padding: EdgeInsets.only(
                    left: 45,
                    right: 45,
                    bottom: 56,
                  ),
                  child: SizedBox.expand(
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      elevation: 0.0,
                      color: lightTheme.accentColor,
                      clipBehavior: Clip.antiAlias,
                      child: MaterialButton(
                        height: 44.0,
                        color: lightTheme.accentColor,
                        child: Text('Log Out',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontFamily: 'Roboto',
                            )),
                        onPressed: () {
                          SharedPreferences.getInstance().then((sp) async {
                            sp.setString(Constants.TOKEN, '');
                            bool isSignin = await facebookSignIn.isLoggedIn;
                            if (isSignin) {
                              facebookSignIn.logOut();
                            }
                            Navigation.toScreenAndCleanBackStack(
                              context: context, screen: LoginScreen());
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listView(MainScreenState state) {
    String email = state.email ?? '';

    List<EditProfileSettingTile> list = [
      EditProfileSettingTile(
        title: 'Email',
        value: email,
        color: Color(0xFFFFA685),
        height: 44,
        function: () {},
      ),
      EditProfileSettingTile(
        title: 'Change Password',
        value: '',
        height: 44,
        function: () {},
      ),
      EditProfileSettingTile(
        title: 'Terms of Service',
        value: '',
        height: 44,
        function: () {
          Navigation.toScreen(
            context: context,
            screen: WebViewScreen(
              title: 'Terms',
              url: Constants.termsURL,
            ),
          );
        },
      ),
      EditProfileSettingTile(
        title: 'Privacy Policy',
        value: '',
        height: 44,
        function: () {
          Navigation.toScreen(
            context: context,
            screen: WebViewScreen(
              title: 'Privacy',
              url: Constants.privacyURL,
            ),
          );
        },
      ),
    ];
    return Container(
      color: Colors.white,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
            thickness: 1,
            color: Color(0xFFF4F4F4),
            indent: 12,
            endIndent: 12,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
