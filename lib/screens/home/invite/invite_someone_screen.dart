import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteSomeOneScreen extends StatefulWidget {
  MainScreenBloc bloc;

  InviteSomeOneScreen({
    this.bloc,
  });

  @override
  _InviteSomeOneScreenState createState() => _InviteSomeOneScreenState();
}

class _InviteSomeOneScreenState extends State<InviteSomeOneScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  FocusNode emailFocus = FocusNode();

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
                title: Text('Invite someone'),
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
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  tabs: [
                    Tab(
                      child: Text(
                        'Code',
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? Color(0xFFFFA685)
                              : Color(0xFF8476AB),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Email',
                        style: TextStyle(
                          color: _selectedIndex == 1
                              ? Color(0xFFFFA685)
                              : Color(0xFF8476AB),
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'QR',
                        style: TextStyle(
                          color: _selectedIndex == 2
                              ? Color(0xFFFFA685)
                              : Color(0xFF8476AB),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
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
                      child: TabBarView(
                        children: [
                          _codeBody(state),
                          _emailBody(state),
                          _qrBody(state),
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

  Widget _codeBody(MainScreenState state) {
    return Container(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          left: 45,
          right: 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 64,
              ),
            ),
            Text(
              '212347',
              style: TextStyle(
                color: Color(0xFFE46E5C),
                fontSize: 24,
                fontFamily: 'Roboto',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 44,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                'Share this invitation code with your friends and family. Only invited people can view your photos and videos.',
                style: TextStyle(
                  color: Color(0xFF8476AB),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 30,
              ),
            ),
            Container(
              height: 44,
              child: SizedBox.expand(
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  elevation: 1.0,
                  color: Color(0xFFFFA685),
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    height: 46.0,
                    color: Color(0xFFFFA685),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'assets/icons/copy_code.png',
                          width: 44,
                          height: 20,
                          color: Colors.white,
                        ),
                        Text(
                          'Copy invitation code',
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emailBody(MainScreenState state) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.only(
            left: 45,
            right: 45,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 64,
                ),
              ),
              Text(
                'Send invitation code with email',
                style: TextStyle(
                  color: Color(0xFF8476AB),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 44,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: TextField(
                  controller: emailController,
                  focusNode: emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF8476AB),
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter email address',
                    hintStyle: TextStyle(
                      color: Color(0x998476AB),
                      fontSize: 16,
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x2F8476AB),
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  onChanged: (_) {
                    setState(() {
                      sendButtonEnabled = emailController.text.length > 0;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              Container(
                height: 44.0,
                child: SizedBox.expand(
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    color: Colors.transparent,
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      disabledColor: Color(0x64FFA685),
                      height: 44.0,
                      elevation: 0,
                      color: Color(0xFFFFA685),
                      child: Text(
                        'Send',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      onPressed: sendButtonEnabled ? () {} : null,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              Container(
                height: 24,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(
                            right: 20.0,
                          ),
                          child: Divider(
                            color: Color(0x808476AB),
                            thickness: 0.5,
                            height: 36,
                          )),
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8476AB),
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: Divider(
                            color: Color(0x808476AB),
                            thickness: 0.5,
                            height: 36,
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 30,
                ),
              ),
              Container(
                height: 44,
                child: SizedBox.expand(
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    elevation: 1.0,
                    color: Color(0xFFFFA685),
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      height: 46.0,
                      color: Color(0xFFFFA685),
                      child: Text(
                        'Use contacts',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _qrBody(MainScreenState state) {
    return Container(
      alignment: Alignment.topCenter,
      color: Color(0xFFFFF5EF),
      child: Padding(
        padding: EdgeInsets.only(
          left: 25,
          right: 25,
          top: 44,
        ),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 4.0,
          color: Colors.white,
          shadowColor: Color(0x32FFA685),
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: 360,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 8, top: 16, right: 8),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 35.0,
                        height: 35.0,
                        padding: EdgeInsets.all(4),
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                              'https://i.imgur.com/BoN9kdC.png',
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                      ),
                      Text(
                        'Tom',
                        style:
                            TextStyle(color: Color(0xFFFFA685), fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 24,
                      left: 8,
                      right: 8,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/icons/qr.png'),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 8,
                    top: 24,
                    bottom: 24,
                    right: 8,
                  ),
                  child: Text(
                    'My QR code',
                    style: TextStyle(
                      color: Color(0xFF8476AB),
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
