import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/profile/baby/baby_item_tile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/widget_utils.dart';

class BabiesVisibleScreen extends StatefulWidget {
  final BuildContext homeContext;
  const BabiesVisibleScreen({Key key, this.homeContext}) : super(key: key);

  @override
  _BabiesVisibleScreenState createState() => _BabiesVisibleScreenState(this.homeContext);
}

class _BabiesVisibleScreenState extends State<BabiesVisibleScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  BabyScreenBloc screenBloc;
  final BuildContext homeContext;

  _BabiesVisibleScreenState(this.homeContext);

  @override
  void initState() {
    screenBloc = BlocProvider.of<BabyScreenBloc>(homeContext);
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<BabyScreenBloc, BabyScreenState>(
      bloc: screenBloc,
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
    );
  }

  Widget _getBody(BabyScreenState state) {
    if (state.isLoading) {
      return WidgetUtils.loadingView();
    } else {
      return SafeArea(
        key: scaffoldKey,
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
          'assets/icons/icon_place_holder.png',
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
          'assets/icons/icon_place_holder.png',
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
          'assets/icons/icon_place_holder.png',
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
          'assets/icons/icon_place_holder.png',
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
