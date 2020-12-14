import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes.dart';

class BabyInfoScreen extends StatefulWidget {
  final MainScreenBloc bloc;
  int index = 0;

  BabyInfoScreen({
    this.bloc,
    this.index,
  });

  @override
  _BabyInfoScreenState createState() => _BabyInfoScreenState();
}

class _BabyInfoScreenState extends State<BabyInfoScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();

  @override
  void initState() {
    nameController.text = '';
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, MainScreenState state) async {
        FocusScope.of(context).requestFocus(nameFocus);
      },
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
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
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
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
            padding: EdgeInsets.only(left: 34, right: 34, top: 16, bottom: 16),
            child: Column(
              children: <Widget>[
                Container(
                  height: 64,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: Text(
                    'Baby Information',
                    style: TextStyle(
                      color: Color(0xFF8476AB),
                      fontSize: 30,
                      fontFamily: 'Roboto-Bold',
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        widget.index < 2
                            ? Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                ),
                                child: GestureDetector(
                                  child: SizedBox(
                                    child: Image.asset(
                                        'assets/icons/add_baby_profile_picture.png'),
                                    height: 90,
                                    width: 90,
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                          height: 50,
                          child: SizedBox.expand(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Name',
                                  style: TextStyle(
                                    color: Color(0xFF8476AB),
                                    fontSize: 12,
                                  ),
                                ),
                                Flexible(
                                  child: new TextField(
                                    controller: nameController,
                                    focusNode: nameFocus,
                                    keyboardType: TextInputType.text,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Enter name',
                                      hintStyle: TextStyle(
                                        color: Color(0x998476AB),
                                        fontSize: 12,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          color: Color(0xFFF4F4F4),
                        ),
                        Container(
                          height: 50,
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
                                    Text(
                                      '05/0/2020',
                                      style: TextStyle(
                                        color: Color(0xFFFFA685),
                                        fontSize: 12,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                    ),
                                    Image.asset(
                                      'assets/icons/ic_calendar.png',
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
                        Container(
                          height: 50,
                          child: SizedBox.expand(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Relationship',
                                  style: TextStyle(
                                    color: Color(0xFF8476AB),
                                    fontSize: 12,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    _relationshipButton(0, true),
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                    ),
                                    _relationshipButton(1, false),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 44),
                        ),
                        Container(
                          height: 44,
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                          child: SizedBox.expand(
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: lightTheme.accentColor,
                              clipBehavior: Clip.antiAlias,
                              child: MaterialButton(
                                height: 44.0,
                                color: lightTheme.accentColor,
                                child: Text('Save',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    )),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _relationshipButton(int type, bool isSelected) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/icons/add_baby_select_normal.png',
              width: 8,
              height: 8,
              color: isSelected ? Color(0xFFFFA685) : Color(0xFF8476AB),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
            ),
            Text(
              type == 0 ? 'Father' : 'Mother',
              style: TextStyle(
                color: isSelected ? Color(0xFFFFA685) : Color(0xFF8476AB),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      onTap: () {},
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
