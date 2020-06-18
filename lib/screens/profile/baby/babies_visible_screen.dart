import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/baby_info.dart';
import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/screens/profile/baby/baby_item_tile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/widget_utils.dart';

class BabiesVisibleScreen extends StatefulWidget {
  final MainScreenBloc mainScreenBloc;
  const BabiesVisibleScreen({Key key, this.mainScreenBloc}) : super(key: key);

  @override
  _BabiesVisibleScreenState createState() => _BabiesVisibleScreenState();
}

class _BabiesVisibleScreenState extends State<BabiesVisibleScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    widget.mainScreenBloc.add(GetBabyListModel(0));
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      bloc: widget.mainScreenBloc,
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: new AppBar(
            title: Text('Visibility'),
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
          ),
          key: scaffoldKey,
          body: _getBody(state),
          backgroundColor: Colors.white,
        );
      },
    );
  }

  Widget _getBody(MainScreenState state) {
    return SafeArea(
      child: Container(
        child: _listView(state),
      ),
    );
  }

  Widget _listView(MainScreenState state) {
    BabyListModel babyListModel = state.babyListModel;
    List<BabyModel> babies = babyListModel != null ? babyListModel.content : [];
    return RefreshIndicator(
      child: ListView.separated(
        itemCount: babies.length,
        itemBuilder: (BuildContext context, int index) {
          BabyModel baby = babies[index];
          String name = baby.name;
          int birthday = baby.birthDay;
          DateTime birth = DateTime.fromMillisecondsSinceEpoch(birthday);
          String dateString = formatDate(birth, [m, '/', dd, '/', yyyy]);
          String avatar = baby.avatar;
          return BabyItemTile(
            title: name,
            value: dateString,
            image: avatar,
            ison: true,
            function: (_) {},
          );
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
