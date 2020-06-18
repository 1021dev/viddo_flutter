import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/activity_notification_model.dart';
import 'package:Viiddo/models/message_model.dart';
import 'package:Viiddo/screens/home/notifications/notification_activity_item.dart';
import 'package:Viiddo/screens/home/notifications/notification_message_item.dart';
import 'package:Viiddo/screens/profile/settings/webview_screen.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:Viiddo/utils/format_utils.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grouped_list/grouped_list.dart';

class NotificationsScreen extends StatefulWidget {
  final BuildContext homeContext;
  const NotificationsScreen({Key key, this.homeContext}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState(homeContext);
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin {
  NotificationScreenBloc screenBloc;
  final BuildContext homeContext;

  _NotificationsScreenState(this.homeContext);
  TabController _tabController;

  int _selectedIndex = 0;
  bool isEmpty = false;

  @override
  void initState() {
    screenBloc = BlocProvider.of<NotificationScreenBloc>(homeContext);
    screenBloc.add(GetActivityListEvent(0));
    screenBloc.add(GetMessageListEvent(0));

    _tabController = TabController(vsync: this, length: 2, initialIndex: _selectedIndex);
    _tabController.addListener(_handleTabSelection);

    super.initState();
  }

  _handleTabSelection() {
    setState(() {
      _selectedIndex = _tabController.index;
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: screenBloc,
      builder: (context, state) {
        int activityCount = state.unreadMessageModel != null ? state.unreadMessageModel.activityCount ?? 0 : 0;
        int messageCount = state.unreadMessageModel != null ? state.unreadMessageModel.messageCount ?? 0 : 0;
        List<Widget> actions = [];
        if (_selectedIndex == 0 && (state.activityList.length ?? 0) > 0) {
          actions.add( FlatButton(
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
                          ActivityNotificationModel model = state.activityList.first;
                          int id = model.objectId;
                          screenBloc.add(ReadMessageEvent(id, true));
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Clear all'),
                        onPressed: () {
                          Navigator.pop(context, 'Clear all');
                          ActivityNotificationModel model = state.activityList.first;
                          int id = model.objectId;
                          screenBloc.add(DeleteMessageEvent('$id', true));
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
          );
        } else if (_selectedIndex == 1 && (state.messageList.length ?? 0) > 0){
          actions.add( FlatButton(
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
                          MessageModel model = state.messageList.first;
                          int id = model.objectId;
                          screenBloc.add(ReadMessageEvent(id, true));
                        },
                      ),
                      CupertinoActionSheetAction(
                        child: const Text('Clear all'),
                        onPressed: () {
                          Navigator.pop(context, 'Clear all');
                          MessageModel model = state.messageList.first;
                          int id = model.objectId;
                          screenBloc.add(DeleteMessageEvent('$id', true));
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
          );
        }
        return Scaffold(
            appBar: new AppBar(
              title: Text('Notifications'),
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
              bottom: TabBar(
                controller: _tabController,
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
                          activityCount == 0 ? Container() : Padding(
                            padding: EdgeInsets.only(left: 8),
                          ),
                          activityCount == 0 ? Container() : SizedBox(
                            width: 15,
                            height: 15,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFFFA685)),
                              child: Text(
                                '$activityCount',
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
                        messageCount == 0 ? Container() : Padding(
                          padding: EdgeInsets.only(left: 8),
                        ),
                        messageCount == 0 ? Container() : SizedBox(
                          width: 15,
                          height: 15,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFFA685),
                            ),
                            child: Text(
                              '$messageCount',
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
              actions: actions,
            ),
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
                      controller: _tabController,
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
        );
      },
    );
  }

  Widget _getActivityBody(NotificationScreenState state) {
    if (state.activityList.length == 0) {
      return Center(
        child: Column(
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
        ),
      );
    }
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFFFF5EF),
            Colors.white,
          ],
        ),
      ),
      child: GroupedListView<ActivityNotificationModel, String>(
        groupBy: (element) => getActivitySectionHeader(element),
        elements: state.activityList,
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        floatingHeader: true,
        groupSeparatorBuilder: (String value) => Container(
          padding: EdgeInsets.only(top: 8, bottom: 4),
          child: Container(
            width: 50,
            height: 16,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFAA382),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, color: Colors.white),
            ),
          )
        ),
        itemBuilder: (c, element) {
          return NotificationActivityItem(function: () {}, model: element);
        },
      ),
    );
  }

  Widget _getMessagesBody(NotificationScreenState state) {
    if (state.messageList.length == 0) {
      return Center(
        child: Column(
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
        ),
      );
    }
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
      child: GroupedListView<MessageModel, String>(
        groupBy: (element) => getMessageSectionHeader(element),
        elements: state.messageList,
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        floatingHeader: true,
        groupSeparatorBuilder: (String value) => Container(
          padding: EdgeInsets.only(top: 8, bottom: 4),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 60,
              height: 16,
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Color(0xFFFAA382),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                value,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 9, color: Colors.white),
              ),
            ),
          ),
        ),
        itemBuilder: (c, element) {
          return NotificationMessageItem(
            function: () {
              screenBloc.add(ReadMessageEvent(element.objectId, false));
              if (element.type == 'GUIDE') {
                Navigation.toScreen(
                  context: context,
                  screen: WebViewScreen(
                    title: 'Welcome',
                    url: Constants.welcomeURL,
                  ),
                );
              } else if (element.type == 'INVITE') {

              } else if (element.type == 'NORMAL') {

              }
            }, 
            model: element,
          );
        },
      ),
    );
  }

  String getActivitySectionHeader(ActivityNotificationModel model) {
    int created = model.createTime;
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(created);
    String sectionString = '';
    if (FormatUtils.isToday(datetime)) {
      sectionString = 'Today';
    } else if (FormatUtils.isYesterday(datetime)) {
      sectionString = 'Yesterday';
    } else {
      sectionString = formatDate(
            datetime,
            [m, '/', dd, '/', yyyy],
          );
    }
    return sectionString;
  }

  String getMessageSectionHeader(MessageModel model) {
    int created = model.createTime;
    DateTime datetime = DateTime.fromMillisecondsSinceEpoch(created);
    String sectionString = '';
    if (FormatUtils.isToday(datetime)) {
      sectionString = 'Today';
    } else if (FormatUtils.isYesterday(datetime)) {
      sectionString = 'Yesterday';
    } else {
      sectionString = formatDate(
            datetime,
            [m, '/', dd, '/', yyyy],
          );
    }
    return sectionString;
  }

  Future<Null> _handleRefresh(context) {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

}
