import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/profile/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/widget_utils.dart';

class EditProfileScreen extends StatefulWidget {
  MainScreenBloc bloc;

  EditProfileScreen({
    this.bloc,
  });

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
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
              title: Text('Profile'),
              backgroundColor: Colors.white,
              elevation: 0,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
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
    if (state.isLoading) {
      return WidgetUtils.loadingView();
    } else {
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
            ],
          ),
        ),
      );
    }
  }

  Widget _listView() {
    List<EditProfileSettingTile> list = [
      EditProfileSettingTile(
        title: 'Change Profile Photo',
        image: Image.asset(
          'assets/icons/2.0x/icon_place_holder.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        height: 60,
        function: () {},
      ),
      EditProfileSettingTile(
        title: 'Name',
        value: 'Demo User',
        function: () {},
      ),
      EditProfileSettingTile(
        title: 'Gender',
        value: 'Select Gender',
        function: () {},
      ),
      EditProfileSettingTile(
        title: 'Birthdate',
        value: 'Select Date',
        function: () {},
      ),
      EditProfileSettingTile(
        title: 'Location',
        value: 'Select Location',
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
