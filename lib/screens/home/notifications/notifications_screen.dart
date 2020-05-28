import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/babies/baby_info_screen.dart';
import 'package:Viiddo/screens/home/invitation_code_input_screen.dart';
import 'package:Viiddo/screens/home/notifications/notification_activity_item.dart';
import 'package:Viiddo/screens/home/notifications/notification_message_item.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsScreen extends StatefulWidget {
  MainScreenBloc bloc;

  NotificationsScreen({
    this.bloc,
  });

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
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
          return DefaultTabController(
            length: 2,
            initialIndex: _selectedIndex,
            child: Scaffold(
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
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  tabs: [
                    Tab(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Activity',
                              style: TextStyle(
                                color: _selectedIndex == 0
                                    ? Color(0xFFFFA685)
                                    : Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            SizedBox(
                              width: 15,
                              height: 15,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFFFA685)),
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Messages',
                            style: TextStyle(
                              color: _selectedIndex == 1
                                  ? Color(0xFFFFA685)
                                  : Color(0xFF8476AB),
                              fontSize: 12,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                          ),
                          SizedBox(
                            width: 15,
                            height: 15,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFFFFA685),
                              ),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        color: Color(0xFFFAA382),
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext context) => CupertinoActionSheet(
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: const Text('Mark all as read'),
                                onPressed: () {
                                  Navigator.pop(context, 'Mark all as read');
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: const Text('Clear all'),
                                onPressed: () {
                                  Navigator.pop(context, 'Clear all');
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
                ],
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
                      child: TabBarView(
                        children: [
                          _getActivityBody(state),
                          _getMessagesBody(state),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _getActivityBody(MainScreenState state) {
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
      child: isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/icons/no_message_image.png',
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 24,
                      ),
                    ),
                    Text(
                      'Never miss a moment',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 18,
                        fontFamily: 'Roboto-Bold',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                      ),
                    ),
                    Text(
                      'Turn on push notifications',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ],
            )
          : ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return NotificationActivityItem(
                  index: index,
                  function: () {},
                );
              },
            ),
    );
  }

  Widget _getMessagesBody(MainScreenState state) {
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
      child: isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/icons/no_message_image.png',
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 24,
                      ),
                    ),
                    Text(
                      'Never miss a moment',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 18,
                        fontFamily: 'Roboto-Bold',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 8,
                      ),
                    ),
                    Text(
                      'Turn on push notifications',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ],
            )
          : ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return NotificationMessageItem(
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
