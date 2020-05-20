import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:Viiddo/screens/profile/edit_profile_screen.dart';
import 'package:Viiddo/screens/profile/profile_header.dart';
import 'package:Viiddo/screens/profile/profile_setting_tile.dart';
import 'package:Viiddo/screens/profile/verify_email_view.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes.dart';
import '../../utils/navigation.dart';
import '../../utils/widget_utils.dart';

class ProfileScreen extends StatefulWidget {
  MainScreenBloc bloc;

  ProfileScreen({
    this.bloc,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int resourceID;

  List<ProfileSettingModel> list = [
    ProfileSettingModel(
      icon: ImageIcon(
        AssetImage('assets/icons/2.0x/report_image.png'),
        size: 24,
        color: lightTheme.accentColor,
      ),
      title: 'Report a Problem',
      function: () {},
    ),
    ProfileSettingModel(
      icon: ImageIcon(
        AssetImage('assets/icons/2.0x/settings_image.png'),
        size: 24,
        color: lightTheme.accentColor,
      ),
      title: 'Settings',
      function: () {},
    ),
  ];

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
            key: scaffoldKey,
            body: _getBody(state),
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
    if (state.isLoading) {
      return WidgetUtils.loadingView();
    } else {
      return SafeArea(
        key: formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ProfileHeaderView(
                onTap: () {
                  Navigation.toScreen(
                    context: context,
                    screen: EditProfileScreen(
                      bloc: widget.bloc,
                    ),
                  );
                },
              ),
              Container(
                color: Color(0xFFF5F5F5),
                height: 8,
                width: MediaQuery.of(context).size.width,
              ),
              _listView(),
              VerifyEmailView(
                onTap: () {
                  WidgetUtils.showSuccessDialog(
                    context,
                    'Please check your email and click on the link to complete verification.',
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget _listView() {
    return Container(
      color: Colors.white,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(list[index]);
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
            thickness: 1,
            color: Colors.black12,
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

  @override
  void dispose() {
    super.dispose();
  }
}