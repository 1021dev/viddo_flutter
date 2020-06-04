import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:Viiddo/screens/profile/edit/change_location_screen.dart';
import 'package:Viiddo/screens/profile/edit/change_name_screen.dart';
import 'package:Viiddo/screens/profile/edit/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

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
  DateTime birthday;
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

  Widget _listView(ProfileScreenState state) {
    String avatar = state.avatar;
    String nikName = state.username != '' ? state.username : 'Enter name';
    String gender = state.gender == 'M'
        ? 'Male'
        : (state.gender == 'FM' ? 'Female' : 'Select Gender');
    String area = state.location != '' ? state.location : 'Select region';
    String birthDateString = '';
    birthday = state.birthday != 0
        ? DateTime.fromMillisecondsSinceEpoch(
            state.birthday,
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
                      getImage(0);
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('Camera Roll'),
                    onPressed: () {
                      Navigator.pop(context, 'Camera Roll');
                      getImage(1);
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
                      widget.bloc.add(
                        UpdateUserProfile({'gender': 'M'}),
                      );
                    },
                  ),
                  CupertinoActionSheetAction(
                    child: const Text('Female'),
                    onPressed: () {
                      Navigator.pop(context, 'Female');
                      widget.bloc.add(
                        UpdateUserProfile({'gender': 'FM'}),
                      );
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
          isDismissible: false,
          builder: (BuildContext builder) {
            return SafeArea(
              child: Container(
                height: 270,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        MaterialButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF8476AB),
                            ),
                          ),
                          onPressed: () {
                            widget.bloc.add(
                              UpdateUserProfile({'birthDay': state.birthday}),
                            );
                            Navigator.of(context).pop();
                          },
                        ),
                        MaterialButton(
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Color(0xFFFFA685),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();

                            widget.bloc.add(
                              UpdateUserProfile({'birthDay': birthday}),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        initialDateTime: birthday ?? DateTime.now(),
                        onDateTimeChanged: (DateTime newdate) {
                          print(newdate);
                          widget.bloc.add(
                            UpdateBirthDay(newdate),
                          );
                        },
                        mode: CupertinoDatePickerMode.date,
                      ),
                    ),
                  ],
                ),
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

  Future getImage(int type) async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile image = await imagePicker.getImage(
      source: type == 0 ? ImageSource.camera : ImageSource.gallery,
    );

    if (image != null) {
      List<PickedFile> files = [];
      files.add(image);
      setState(() {
        widget.bloc.add(PickImageFile(files));
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
