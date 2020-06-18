import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/screens/home/babies/change_baby_name_screen.dart';
import 'package:Viiddo/screens/profile/edit/change_name_screen.dart';
import 'package:Viiddo/screens/profile/edit/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditBabyInformationScreen extends StatefulWidget {
  MainScreenBloc bloc;
  BabyModel baby;
  EditBabyInformationScreen({
    this.baby,
    this.bloc,
  });

  @override
  _EditBabyInformationScreenState createState() =>
      _EditBabyInformationScreenState();
}

class _EditBabyInformationScreenState extends State<EditBabyInformationScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int tempBirthday = 0;
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
              title: Text('Baby information'),
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
              actions: <Widget>[
                IconButton(
                  icon: ImageIcon(
                    AssetImage('assets/icons/ic_three_dot.png'),
                  ),
                  tooltip: 'Delete',
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            child: const Text('Delete Baby'),
                            onPressed: () {
                              Navigator.pop(context, 'Delete Baby');
                            },
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Cancel'),
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
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
          ],
        ),
      ),
    );
  }

  Widget _listView(MainScreenState state) {
    String avatar = widget.baby.avatar ?? 'assets/icons/icon_place_holder.png';
    String name = widget.baby.name;
    String gender = (widget.baby.gender ?? '') == 'M' ? 'Male': ((widget.baby.gender ?? '') == 'F' ? 'Female': '');
    String birthDate = '';
    int birth = widget.baby.birthDay ?? 0;
    if (birth > 0) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(birth);
      birthDate = formatDate(date, [m, '/' , dd, '/', yyyy]);
    }
    List<EditProfileSettingTile> list = [
      EditProfileSettingTile(
        title: 'Profile Picture',
        image: avatar,
        height: 45,
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
        value: name == '' ? 'Add Name' : name,
        height: 45,
        color: name == '' ? Color(0x907861B7): Color(0xFFFFA685),
        function: () {
          Navigation.toScreen(
            context: context,
            screen: ChangeBabyNameScreen(screenBloc: widget.bloc, babyModel: widget.baby,),
          );
        },
      ),
      EditProfileSettingTile(
        title: 'Gender',
        value: gender == '' ? 'Select Gender' : gender,
        color: gender == '' ? Color(0x907861B7): Color(0xFFFFA685),
        height: 44,
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
        value: birthDate == '' ? 'Select Date': birthDate,
        color: birthDate == '' ? Color(0x907861B7): Color(0xFFFFA685),
        height: 45,
        function: () async => await showModalBottomSheet(
          context: context,
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
                            setState(() {
                              tempBirthday = 0;
                            });
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
                              UpdateBabyBirthDay(widget.baby.objectId, tempBirthday),
                            );
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Expanded(
                      child: CupertinoDatePicker(
                        initialDateTime: birth > 0 ? DateTime.fromMillisecondsSinceEpoch(birth): DateTime.now(),
                        onDateTimeChanged: (DateTime newdate) {
                          print(newdate);
                          setState(() {
                            tempBirthday = newdate.millisecondsSinceEpoch;
                          });
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
      List<File> files = [];
      files.add(new File(image.path));
      widget.bloc.add(PickBabyProfileImage(widget.baby.objectId, files));
    }
  }



  @override
  void dispose() {
    super.dispose();
  }
}
