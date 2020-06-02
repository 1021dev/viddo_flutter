import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/login_screen.dart';
import 'package:Viiddo/screens/profile/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes.dart';

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
                title: TextStyle(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Color(0xFFF0F0F0),
              height: 10,
            ),
            _listView(),
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
                      elevation: 4.0,
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
                          Navigation.toScreenAndCleanBackStack(
                              context: context, screen: LoginScreen());
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

  Widget _listView() {
    List<EditProfileSettingTile> list = [
      EditProfileSettingTile(
        title: 'Email',
        value: 'tomliu@gmail.com',
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
        function: () {},
      ),
      EditProfileSettingTile(
        title: 'Privacy Policy',
        value: '',
        height: 44,
        function: () {},
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
            color: Colors.black12,
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
