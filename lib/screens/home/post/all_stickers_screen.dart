import 'dart:async';
import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/babies/baby_info_screen.dart';
import 'package:Viiddo/screens/home/invitation_code_input_screen.dart';
import 'package:Viiddo/screens/home/notifications/notification_activity_item.dart';
import 'package:Viiddo/screens/home/notifications/notification_message_item.dart';
import 'package:Viiddo/screens/home/vaccines/vaccine_list_item.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllStickerScreen extends StatefulWidget {
  MainScreenBloc bloc;

  AllStickerScreen({
    this.bloc,
  });

  @override
  _AllStickerScreenState createState() => _AllStickerScreenState();
}

class _AllStickerScreenState extends State<AllStickerScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  List<String> categories = [
    'All',
    'Trending',
    'New',
    'Toys',
    'Animals',
    'Decorations',
    'Fashions',
    'Heroes',
    'Science',
    'Military',
    'Sports',
    'Daily',
    'Pregnancy',
    'Humor',
  ];
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(vsync: this, length: categories.length)
      ..addListener(() {
        setState(() {
          _selectedIndex = _controller.index;
        });
      });

    super.initState();
  }

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
              title: Text('Notifications'),
              backgroundColor: Colors.transparent,
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
              bottom: TabBar(
                controller: _controller,
                isScrollable: true,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                tabs: List.generate(
                  categories.length,
                  (index) {
                    return Tab(
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: _selectedIndex == index
                              ? Color(0xFFFFA685)
                              : Color(0xFF8476AB),
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
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
                  Container(
                    color: Color(0xFFFFF5EF),
                    height: 8,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: List.generate(
                        categories.length,
                        (index) {
                          return _body(state, _selectedIndex);
                        },
                      ),
                    ),
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

  Widget _body(MainScreenState state, int index) {
    return GridView.count(
      crossAxisCount: 5,
      padding: EdgeInsets.all(8),
      children: List.generate(
        30,
        (index) {
          return _stickerItem(index);
        },
      ),
    );
  }

  Widget _stickerItem(int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop(index);
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border.all(
              width: 1,
              color: Color(0xFFFFA685),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Image.asset(
            'assets/icons/ic_sticker.png',
          ),
        ),
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
