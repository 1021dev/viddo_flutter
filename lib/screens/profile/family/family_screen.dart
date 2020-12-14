import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:Viiddo/screens/home/invite/invite_someone_screen.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/navigation.dart';
import '../../../utils/widget_utils.dart';
import 'family_item_tile.dart';

class FamilyScreen extends StatefulWidget {
  MainScreenBloc mainScreenBloc;

  FamilyScreen({
    this.mainScreenBloc,
  });

  @override
  _FamilyScreenState createState() => _FamilyScreenState();
}

class _FamilyScreenState extends State<FamilyScreen>
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
      bloc: widget.mainScreenBloc,
      listener: (BuildContext context, MainScreenState state) async {},
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.mainScreenBloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: Text('Family'),
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
                FlatButton(
                  child: Text(
                    'Invite',
                    style: TextStyle(
                      color: Color(0xFFFAA382),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigation.toScreen(
                      context: context,
                      screen: InviteSomeOneScreen(
                        bloc: widget.mainScreenBloc,
                      ),
                    );
                  },
                ),
              ],
            ),
            key: scaffoldKey,
            body: _getBody(state),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
    return SafeArea(
      key: formKey,
      child: Container(
        child: _listView(),
      ),
    );
  }

  Widget _listView() {
    List<FamilyItemTile> list = [
      FamilyItemTile(
        title: 'Tom',
        image: Image.asset(
          'assets/icons/icon_place_holder.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        value: 'Father',
        function: () {},
      ),
      FamilyItemTile(
        title: 'Van Le',
        value: 'Mother',
        image: Image.asset(
          'assets/icons/icon_place_holder.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        function: () {},
      ),
    ];
    return Container(
      color: Colors.white,
      child: ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
