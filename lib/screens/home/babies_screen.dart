import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/babies_item_tile.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../themes.dart';

class BabiesScreen extends StatefulWidget {
  final MainScreenBloc bloc;

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
              title: Text(
                'Babies',
                style: TextStyle(
                  color: Color(0xFF7861B7),
                  fontSize: 18,
                ),
              ),
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
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          key: formKey,
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 86,
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 36,
                    right: 36,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/baby_list_add.png',
                              width: 45,
                              height: 45,
                              color: Color(0xFFFFA685),
                            ),
                            Text(
                              'Add Baby',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/invitation_code.png',
                              width: 45,
                              height: 45,
                              color: Color(0xFFFFA685),
                            ),
                            Text(
                              'Enter Invitation Code',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/scan_qr.png',
                              width: 45,
                              height: 45,
                              color: Color(0xFFFFA685),
                            ),
                            Text(
                              'Scan',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return BabiesItemTile(
                        index: index,
                        function: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
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
