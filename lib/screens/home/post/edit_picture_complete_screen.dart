import 'dart:async';
import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/post/all_stickers_screen.dart';
import 'package:Viiddo/screens/home/post/post_screen.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPictureCompleteScreen extends StatefulWidget {
  PostBloc bloc;

  final File image;
  EditPictureCompleteScreen({
    this.bloc,
    this.image,
  });

  @override
  _EditPictureCompleteScreenState createState() =>
      _EditPictureCompleteScreenState(this.image);
}

class _EditPictureCompleteScreenState extends State<EditPictureCompleteScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final File image;
  int _selectedIndex = 0;
  bool isEmpty = false;
  Animation<double> animation;
  AnimationController controller;

  _EditPictureCompleteScreenState(this.image);

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 109, end: 0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});
    controller.reverse();

    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, PostState state) async {},
      child: BlocBuilder<PostBloc, PostState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: Text('Edit Picture'),
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
                    'Done',
                    style: TextStyle(
                      color: Color(0xFFFAA382),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigation.toScreen(
                      context: context,
                      screen: PostScreen(
                        bloc: widget.bloc,
                      ),
                    );
                  },
                ),
              ],
            ),
            key: scaffoldKey,
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: GestureDetector(
                onTap: () {
                  controller.reverse();
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFF5EF),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      _body(state),
                      _bottomBar(state),
                    ],
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }

  Widget _body(PostState state) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        child: Image.file(
          image,
        ),
      ),
    );
  }

  Widget _bottomBar(PostState state) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Container(
            height: 153,
            child: Column(
              children: <Widget>[
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          controller.forward();
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/ic_sticker.png',
                              color: Color(0xFF8476AB),
                              width: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                              ),
                            ),
                            Text(
                              'Stickers',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                        ),
                        child: Image.asset('assets/icons/ic_line.png'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          controller.reverse();
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/ic_text.png',
                              color: Color(0xFF8476AB),
                              width: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                              ),
                            ),
                            Text(
                              'Text',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFA685),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Trending',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'New',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          controller.reverse();
                          Navigation.toScreen(
                            context: context,
                            screen: AllStickerScreen(
                              bloc: widget.bloc,
                            ),
                          );
                        },
                        child: Text(
                          'To see all',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 65,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _stickerItem(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _stickerItem(int index) {
    return GestureDetector(
      onTap: () {
        controller.reverse();
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          width: 55,
          height: 55,
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

  Widget _bottomToolBar(MainScreenState state) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: Container(
            height: 153,
            child: Column(
              children: <Widget>[
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                          controller.forward();
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/ic_sticker.png',
                              color: Color(0xFF8476AB),
                              width: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                              ),
                            ),
                            Text(
                              'Stickers',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 4,
                          bottom: 4,
                        ),
                        child: Image.asset('assets/icons/ic_line.png'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          controller.reverse();
                        },
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/ic_text.png',
                              color: Color(0xFF8476AB),
                              width: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                              ),
                            ),
                            Text(
                              'Text',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFA685),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'Trending',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        child: Text(
                          'New',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          controller.reverse();
                          Navigation.toScreen(
                            context: context,
                            screen: AllStickerScreen(
                              bloc: widget.bloc,
                            ),
                          );
                        },
                        child: Text(
                          'To see all',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 65,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _stickerItem(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<Null> _handleRefresh(context) {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
