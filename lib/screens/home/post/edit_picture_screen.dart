import 'dart:async';
import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:Viiddo/screens/home/post/all_stickers_screen.dart';
import 'package:Viiddo/screens/home/post/edit_picture_complete_screen.dart';
import 'package:Viiddo/screens/home/post/post_screen.dart';
import 'package:Viiddo/screens/home/post/sticker_image.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EditPictureScreen extends StatefulWidget {
  final MainScreenBloc mainScreenBloc;
  final File image;
  EditPictureScreen({
    this.mainScreenBloc,
    this.image,
  });

  @override
  _EditPictureScreenState createState() => _EditPictureScreenState(this.image, this.mainScreenBloc);
}

class _EditPictureScreenState extends State<EditPictureScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();
  // final List<AspectRatioItem> _aspectRatios = <AspectRatioItem>[
  //   AspectRatioItem(text: 'custom', value: CropAspectRatios.custom),
  //   AspectRatioItem(text: 'original', value: CropAspectRatios.original),
  //   AspectRatioItem(text: '1*1', value: CropAspectRatios.ratio1_1),
  //   AspectRatioItem(text: '4*3', value: CropAspectRatios.ratio4_3),
  //   AspectRatioItem(text: '3*4', value: CropAspectRatios.ratio3_4),
  //   AspectRatioItem(text: '16*9', value: CropAspectRatios.ratio16_9),
  //   AspectRatioItem(text: '9*16', value: CropAspectRatios.ratio9_16)
  // ];
  // AspectRatioItem _aspectRatio;
  final GlobalKey key = GlobalKey();
  Widget source;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final File image;
  int _selectedIndex = 10019;
  bool isEmpty = false;
  Animation<double> animation;
  AnimationController controller;
  PostBloc screenBloc;
  final MainScreenBloc mainScreenBloc;
  Size viewport;

  _EditPictureScreenState(this.image, this.mainScreenBloc);

  @override
  void initState() {
    if (screenBloc == null) {
      screenBloc = PostBloc(mainScreenBloc: widget.mainScreenBloc);
    }
    // screenBloc.add(InitPostScreen());
    screenBloc.add(GetStickerCategory());
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 109, end: 0).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});
    controller.reverse();
    source = Image.file(
      image,
      fit: BoxFit.contain,
//      mode: ExtendedImageMode.editor,
//      extendedImageEditorKey: editorKey,
//      initEditorConfigHandler: (state) {
//        return EditorConfig(
//            maxScale: 8.0,
//            cropRectPadding: EdgeInsets.all(20.0),
//            hitTestSize: 20.0,
//            cropAspectRatio: CropAspectRatios.ratio3_4);
//      },
    );
    super.initState();
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: screenBloc,
      listener: (BuildContext context, PostState state) async {},
      child: BlocBuilder<PostBloc, PostState>(
        bloc: screenBloc,
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
                    'Next',
                    style: TextStyle(
                      color: Color(0xFFFAA382),
                      fontSize: 14,
                    ),
                  ),
                  onPressed: () {
                    Navigation.toScreen(
                      context: context,
                      screen: PostScreen(
                        bloc: screenBloc,
                        image: image,
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
      child: RepaintBoundary(
        key: key,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                viewport = viewport ??
                    Size(constraints.maxWidth, constraints.maxHeight);
                return source;
              },
            ),
            Stack(children: state.attachedList, fit: StackFit.expand)
          ],
        ),
      ),
    );
  }

  Widget _bottomBar(PostState state) {
    List<StickerModel> stickers = [];
    if (state.stickers != null) {
      if (state.stickers.containsKey(_selectedIndex)) {
        stickers = state.stickers[_selectedIndex];
      }
    }
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
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 10019;
                          });
                        },
                        child: Text(
                          'Trending',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 10020;
                          });
                        },
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
                              bloc: screenBloc,
                              categories: state.categories,
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
                    itemCount: stickers.length,
                    itemBuilder: (context, index) {
                      return _stickerItem(stickers[index]);
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

  Widget _stickerItem(StickerModel sticker) {
    return GestureDetector(
      onTap: () {
        controller.reverse();
        screenBloc.add(AddStickerEvent(StickerImage(
            SvgPicture.network(
              sticker.url,
              excludeFromSemantics: true,
            ),
            key: Key('sticker_${sticker.name}'),
            width: 100,
            height: 100,
            viewport: viewport,
            maxScale: 20,
            minScale: 0.2,
            onTapRemove: (sk) {

            },
        )));
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Container(
          width: 55,
          height: 55,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            border: Border.all(
              width: 1,
              color: Color(0xFFFFA685),
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: sticker.url != null ? //WebsafeSvg.network(sticker.url)://SvgPicture(AdvancedNetworkSvg(sticker.url, SvgPicture.svgByteDecoder)):
            SvgPicture.network(
              sticker.url,
              excludeFromSemantics: true,
              placeholderBuilder: (BuildContext context) => Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const CircularProgressIndicator(strokeWidth: 2,)),
                  ): 
                  Image.asset(
            'assets/icons/ic_sticker.png',
          ),
        ),
      ),
    );
  }

  Widget _bottomToolBar(PostState state) {
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
                              bloc: screenBloc,
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
                      return Container();//_stickerItem(index);
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

  Future<Null> _handleRefresh() {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  @override
  void dispose() {
    controller.dispose();
    screenBloc.close();
    super.dispose();
  }
}
