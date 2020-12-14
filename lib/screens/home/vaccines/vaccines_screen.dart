import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/vaccines/vaccine_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VaccinesScreen extends StatefulWidget {
  MainScreenBloc bloc;

  VaccinesScreen({
    this.bloc,
  });

  @override
  _VaccinesScreenState createState() => _VaccinesScreenState();
}

class _VaccinesScreenState extends State<VaccinesScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int _selectedIndex = 0;
  bool isEmpty = false;
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
              title: Text('Vaccine list'),
              backgroundColor: Colors.transparent,
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
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Divider(
                    color: Color(0x75FAA382),
                    thickness: 2,
                    height: 0,
                  ),
                  Expanded(
                    child: _body(state),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }

  Widget _body(MainScreenState state) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF5EF),
              Colors.white,
            ]),
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return VaccineListItem(
            index: index,
            function: () {},
          );
        },
      ),
    );
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
