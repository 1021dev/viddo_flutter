import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/profile/baby_item_tile.dart';
import 'package:Viiddo/screens/profile/change_location_screen.dart';
import 'package:Viiddo/screens/profile/change_name_screen.dart';
import 'package:Viiddo/screens/profile/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../utils/navigation.dart';
import '../../utils/widget_utils.dart';
import 'family_item_tile.dart';

class BabiesScreen extends StatefulWidget {
  MainScreenBloc bloc;

  BabiesScreen({
    this.bloc,
  });

  @override
  _BabiesScreenState createState() => _BabiesScreenState();
}

class _BabiesScreenState extends State<BabiesScreen>
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
              title: Text('Visibility'),
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
            backgroundColor: Colors.white,
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
          child: _listView(),
        ),
      );
    }
  }

  Widget _listView() {
    List<BabyItemTile> list = [
      BabyItemTile(
        title: 'Kendra',
        image: Image.asset(
          'assets/icons/2.0x/icon_place_holder.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        value: '07/15/2013',
        ison: true,
        function: (_) {},
      ),
      BabyItemTile(
        title: 'Kendra',
        value: '07/15/2013',
        image: Image.asset(
          'assets/icons/2.0x/icon_place_holder.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        ison: true,
        function: (_) {},
      ),
      BabyItemTile(
        title: 'Kendra',
        value: '07/15/2013',
        image: Image.asset(
          'assets/icons/2.0x/icon_place_holder.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        ison: true,
        function: (_) {},
      ),
      BabyItemTile(
        title: 'Kendra',
        value: '07/15/2013',
        image: Image.asset(
          'assets/icons/2.0x/icon_place_holder.png',
          fit: BoxFit.cover,
          width: 40,
        ),
        ison: true,
        function: (_) {},
      ),
    ];
    return RefreshIndicator(
      child: ListView.separated(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 0,
            thickness: 1.4,
            color: Colors.transparent,
          );
        },
      ),
      onRefresh: () {},
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
