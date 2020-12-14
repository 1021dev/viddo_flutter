import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRecordsScreen extends StatefulWidget {
  MainScreenBloc bloc;

  AddRecordsScreen({
    this.bloc,
  });

  @override
  _AddRecordsScreenState createState() => _AddRecordsScreenState();
}

class _AddRecordsScreenState extends State<AddRecordsScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  FocusNode heightFocus = FocusNode();
  FocusNode weightFocus = FocusNode();

  int _selectedIndex = 0;
  bool isEmpty = false;
  bool sendButtonEnabled = false;
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
            length: 3,
            initialIndex: _selectedIndex,
            child: Scaffold(
              appBar: new AppBar(
                title: Text('Add Records'),
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
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Color(0xFFFAA382),
                        fontSize: 14,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              key: scaffoldKey,
              body: _body(),
              backgroundColor: Colors.white,
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Divider(
              color: Color(0xFFFFFBF8),
              thickness: 6,
              height: 0,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Height',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            Flexible(
                              child: TextField(
                                controller: heightController,
                                focusNode: heightFocus,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xFF8476AB),
                                  fontSize: 12,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter height',
                                  hintStyle: TextStyle(
                                    color: Color(0x998476AB),
                                    fontSize: 12,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(weightFocus);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                'in',
                                style: TextStyle(
                                  color: Color(0xFF8476AB),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFF4F4F4),
                      indent: 15,
                      endIndent: 15,
                    ),
                    Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Weight',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            Flexible(
                              child: TextField(
                                controller: weightController,
                                focusNode: weightFocus,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Color(0xFF8476AB),
                                  fontSize: 12,
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Enter weight',
                                  hintStyle: TextStyle(
                                    color: Color(0x998476AB),
                                    fontSize: 12,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onSubmitted: (_) {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                            ),
                            Container(
                              width: 30,
                              child: Text(
                                'lbs',
                                style: TextStyle(
                                  color: Color(0xFF8476AB),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFF4F4F4),
                      indent: 15,
                      endIndent: 15,
                    ),
                    Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 15, right: 15),
                      child: SizedBox.expand(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Birthday',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GestureDetector(
                                  child: Text(
                                    '05/22/2020',
                                    style: TextStyle(
                                      color: Color(0xFFFFA685),
                                      fontSize: 12,
                                    ),
                                  ),
                                  onTap: () async => await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext builder) {
                                      return Container(
                                        height: 240,
                                        child: CupertinoDatePicker(
                                          initialDateTime: DateTime.now(),
                                          onDateTimeChanged:
                                              (DateTime newdate) {
                                            print(newdate);
                                          },
                                          mode: CupertinoDatePickerMode.date,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                ),
                                Image.asset(
                                  'assets/icons/ic_right_arrow.png',
                                  width: 20,
                                  color: Color(0xFFFFA685),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFF4F4F4),
                    ),
                  ],
                ),
              ),
            ),
          ],
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
