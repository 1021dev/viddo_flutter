import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/profile/edit/change_name_screen.dart';
import 'package:Viiddo/screens/profile/edit/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditBabyInformationScreen extends StatefulWidget {
  MainScreenBloc bloc;

  EditBabyInformationScreen({
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
        title: 'Profile Picture',
        image: 'assets/icons/icon_place_holder.png',
        height: 44,
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
        value: 'Demo User',
        height: 44,
        function: () {
          Navigation.toScreen(
            context: context,
            screen: ChangeNameScreen(),
          );
        },
      ),
      EditProfileSettingTile(
        title: 'Gender',
        value: 'Select Gender',
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
        value: 'Select Date',
        height: 44,
        function: () async => await showModalBottomSheet(
          context: context,
          builder: (BuildContext builder) {
            return Container(
              height: 240,
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
