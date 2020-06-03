import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:Viiddo/screens/profile/edit/change_location_screen.dart';
import 'package:Viiddo/screens/profile/edit/change_name_screen.dart';
import 'package:Viiddo/screens/profile/edit/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../utils/navigation.dart';
import '../../../utils/widget_utils.dart';

class EditProfileScreen extends StatefulWidget {
  ProfileScreenBloc bloc;

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
      listener: (BuildContext context, ProfileScreenState state) async {},
      child: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: Text('Profile'),
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

  Widget _getBody(ProfileScreenState state) {
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
              _listView(state),
            ],
          ),
        ),
      );
    }
  }

  Widget _listView(ProfileScreenState state) {
    String avatar = '';
    String nikName = '';
    String gender = 'Select gender';
    String area = 'Select region';
    String birthDateString = 'Select date';
    if (state.userModel != null) {
      avatar = state.userModel.avatar;
      nikName = state.userModel.nikeName;
      gender = state.userModel.gender == 'M'
          ? 'Male'
          : (state.userModel.gender == 'FM' ? 'Female' : 'Select Gender');
      if (state.userModel.area != '') {
        area = state.userModel.area;
      }
      DateTime birthday = state.userModel.birthDay != null
          ? DateTime.fromMillisecondsSinceEpoch(
              state.userModel.birthDay,
            )
          : null;
      if (birthday != null) {
        birthDateString = formatDate(
          birthday,
          [
            mm,
            '/',
            dd,
            '/',
            yyyy,
          ],
        );
      }
    }
    List<EditProfileSettingTile> list = [
      EditProfileSettingTile(
        title: 'Change Profile Photo',
        image: avatar != '' ? avatar : 'assets/icons/icon_place_holder.png',
        height: 55,
        function: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
                title: const Text('Choose Photo'),
                message: const Text('Your options are '),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: const Text('Take a Picture'),
                    onPressed: () {
                      Navigator.pop(context, 'Take a Picture');
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('Camera Roll'),
                    onPressed: () {
                      Navigator.pop(context, 'Camera Roll');
                    },
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                )),
          );
        },
      ),
      EditProfileSettingTile(
        title: 'Name',
        value: nikName,
        height: 55,
        color: nikName != '' ? Color(0xFFFFA685) : Color(0x808476AB),
        function: () {
          Navigation.toScreen(
            context: context,
            screen: ChangeNameScreen(),
          );
        },
      ),
      EditProfileSettingTile(
        title: 'Gender',
        value: gender,
        height: 55,
        function: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
                title: const Text('Choose Gender'),
                message: const Text('Your options are '),
                actions: <Widget>[
                  CupertinoActionSheetAction(
                    child: const Text('Male'),
                    onPressed: () {
                      Navigator.pop(context, 'Male');
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('Female'),
                    onPressed: () {
                      Navigator.pop(context, 'Female');
                    },
                  )
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                )),
          );
        },
      ),
      EditProfileSettingTile(
        title: 'Birthdate',
        value: birthDateString,
        height: 55,
        function: () async => await showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: MediaQuery.of(context).copyWith().size.height / 3,
              child: CupertinoDatePicker(
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime newdate) {
                  print(newdate);
                },
                mode: CupertinoDatePickerMode.date,
              ),
            );
          },
        ),
      ),
      EditProfileSettingTile(
        title: 'Location',
        value: area,
        height: 55,
        function: () {
          Navigation.toScreen(
            context: context,
            screen: ChangeLocationScreen(
              bloc: widget.bloc,
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
