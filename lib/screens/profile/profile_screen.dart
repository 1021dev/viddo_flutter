import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:Viiddo/screens/profile/edit/edit_profile_screen.dart';
import 'package:Viiddo/screens/profile/family/family_screen.dart';
import 'package:Viiddo/screens/profile/profile_header.dart';
import 'package:Viiddo/screens/profile/settings/profile_setting_tile.dart';
import 'package:Viiddo/screens/profile/settings/report_problem_screen.dart';
import 'package:Viiddo/screens/profile/settings/settings_screen.dart';
import 'package:Viiddo/screens/profile/verify_email_view.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../themes.dart';
import '../../utils/navigation.dart';
import 'baby/babies_visible_screen.dart';

class ProfileScreen extends StatefulWidget {
  final MainScreenBloc mainScreenBloc;
  final GlobalKey<NavigatorState> navKey;

  const ProfileScreen({@required this.navKey, this.mainScreenBloc});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Timer _timer;
  int _start = 10;
  bool _sentCode = false;
  bool isVerified = true;

  SharedPreferences sharedPreferences;
  List<ProfileSettingModel> listViewItems(BuildContext context) {
    return [
      ProfileSettingModel(
        icon: ImageIcon(
          AssetImage('assets/icons/ic_family_solid.png'),
          size: 20,
          color: lightTheme.accentColor,
        ),
        title: 'Family',
        function: () {
          Navigation.toScreen(
            context: context,
            screen: FamilyScreen(
              mainScreenBloc: widget.mainScreenBloc,
            ),
          );
        },
      ),
      ProfileSettingModel(
        icon: ImageIcon(
          AssetImage('assets/icons/ic_report_solid.png'),
          size: 20,
          color: lightTheme.accentColor,
        ),
        title: 'Report a Problem',
        function: () {
          Navigation.toScreen(
            context: context,
            screen: ReportProblemScreen(
              bloc: widget.mainScreenBloc,
            ),
          );
        },
      ),
      ProfileSettingModel(
        icon: ImageIcon(
          AssetImage('assets/icons/ic_settings_solid.png'),
          size: 20,
          color: lightTheme.accentColor,
        ),
        title: 'Settings',
        function: () {
          Navigation.toScreen(
            context: context,
            screen: SettingsScreen(
              bloc: widget.mainScreenBloc,
            ),
          );
        },
      ),
    ];
  }

  @override
  void initState() {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
    });
    widget.mainScreenBloc.add(GetUserProfile());
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.mainScreenBloc,
      listener: (BuildContext context, MainScreenState state) async {
        if (state is VerificationSuccess) {
          _hadleVerification();
        }
      },
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.mainScreenBloc,
        builder: (BuildContext context, MainScreenState state) {
          return CupertinoTabView(
            key: widget.navKey,
            builder: (BuildContext context) {
              return _getBody(state);
            },
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
    if (sharedPreferences != null) {
      isVerified = sharedPreferences.getBool(Constants.IS_VERI_CAL) ?? false;
    }
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 24),
        child: Container(
          color: Color(0xFFFFFBF8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ProfileHeaderView(
                onTap: () {
                  Navigation.toScreen(
                    context: context,
                    screen: EditProfileScreen(
                      mainScreenBloc: widget.mainScreenBloc,
                    ),
                  );
                },
                nikName: state.userName,
                avatar: state.userAvatar,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              _listView(),
              isVerified
                  ? Container()
                  : VerifyEmailView(
                      time: _start,
                      sentCode: _sentCode,
                      onTap: () {
                        if (!_sentCode) {
                          widget.mainScreenBloc.add(
                            SendVerificationCode(
                              state.userModel.email,
                              'REGISTER',
                            ),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listView() {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: listViewItems(context).length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(listViewItems(context)[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
            thickness: 1,
            color: Color(0xFFF4F4F4),
          );
        },
      ),
    );
  }

  Widget _buildItem(ProfileSettingModel model) {
    return ProfileSettingTile(
      model: model,
    );
  }

  Future<Null> _handleRefresh(context) {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  Future<void> _hadleVerification() async {
    startTimer();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Padding(
            padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 12),
            child: Text(
              'Please check your email and click on the link to complete verification.',
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
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _start = 119;
      _sentCode = true;
    });
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            setState(() {
              _sentCode = false;
            });
            timer.cancel();
          } else {
            setState(() {
              _start = _start - 1;
            });
          }
        },
      ),
    );
  }
}
