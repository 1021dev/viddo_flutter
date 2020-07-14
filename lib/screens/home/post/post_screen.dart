import 'dart:async';
import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/main_screen.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'edit_picture_screen.dart';


class PostScreen extends StatefulWidget {
  final PostBloc bloc;

  final File image;

  PostScreen({
    this.bloc,
    this.image,
  });

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController captionController = TextEditingController();
  FocusNode captionFocus = FocusNode();

  List<File> images = [];
  @override
  void initState() {
    if (widget.image != null) {
      images.add(widget.image);
    }
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, PostState state) async {
        FocusScope.of(context).unfocus();
      },
      child: BlocBuilder<PostBloc, PostState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            key: scaffoldKey,
            body: _getBody(state),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }

  Widget _getBody(PostState state) {
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
                  height: 44,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        color: Colors.white,
                        margin: EdgeInsets.only(
                          left: 16,
                          top: 7,
                          bottom: 7,
                        ),
                        child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF7861B7),
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop('Cancel');
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFFAA382),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: EdgeInsets.only(
                          right: 16,
                          top: 7,
                          bottom: 7,
                        ),
                        child: MaterialButton(
                          padding: EdgeInsets.all(0),
                          child: Text(
                            'Share',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          onPressed: () {
                            Navigation.toScreenAndCleanBackStack(
                              context: context,
                              screen: MainScreen(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 130,
                  margin: EdgeInsets.only(left: 25, right: 25, top: 32),
                  child: TextField(
                    autofocus: true,
                    focusNode: captionFocus,
                    controller: captionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                      color: Color(0xFF8476AB),
                      fontSize: 14.0,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: InputBorder.none,
                      hintText: 'Write a caption',
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0x998476AB),
                        fontFamily: 'Roboto',
                      ),
                    ),
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                Divider(
                  color: Color(0x328476AB),
                  thickness: 1,
                  indent: 25,
                  endIndent: 25,
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 25,
                      right: 25,
                      top: 32,
                    ),
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: images.length + 1,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _photoItem(index);
                      },
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Text(
                            'Add Milestone',
                            style: TextStyle(
                              color: Color(0xFFFFA685),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        onTap: () {},
                      ),
                      Divider(
                        color: Color(0xFFF4F4F4),
                        thickness: 1,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/ic_location.png',
                                    width: 20,
                                    height: 20,
                                    color: Color(0xFF8476AB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Text(
                                    'Add location',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Departamento de Lima',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Image.asset(
                                    'assets/icons/ic_right_arrow.png',
                                    width: 13,
                                    height: 13,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      Divider(
                        color: Color(0xFFF4F4F4),
                        thickness: 1,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/ic_user_visibility.png',
                                    width: 20,
                                    height: 20,
                                    color: Color(0xFF8476AB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Text(
                                    'Who can see',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'All Friends',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Image.asset(
                                    'assets/icons/ic_right_arrow.png',
                                    width: 13,
                                    height: 13,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      Divider(
                        color: Color(0xFFF4F4F4),
                        thickness: 1,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/ic_time.png',
                                    width: 20,
                                    height: 20,
                                    color: Color(0xFF8476AB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Text(
                                    'Add time',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    '05/25/2020',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Image.asset(
                                    'assets/icons/ic_right_arrow.png',
                                    width: 13,
                                    height: 13,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      Divider(
                        color: Color(0xFFF4F4F4),
                        thickness: 1,
                      ),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 8,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/ic_tag_baby.png',
                                    width: 20,
                                    height: 20,
                                    color: Color(0xFF8476AB),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Text(
                                    'Tag someone',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Tom',
                                    style: TextStyle(
                                      color: Color(0xFF8476AB),
                                      fontSize: 12,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 8),
                                  ),
                                  Image.asset(
                                    'assets/icons/ic_right_arrow.png',
                                    width: 13,
                                    height: 13,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        onTap: () {},
                      ),
                      Divider(
                        color: Color(0xFFF4F4F4),
                        thickness: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _photoItem(int index) {
    return Container(
      width: 90,
      height: 90,
      margin: EdgeInsets.all(8),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (index == images.length) {
                showCupertinoModalPopup(
                  context: context,
                  builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Choose Photo'),
                      message: const Text('Your options are '),
                      actions: <Widget>[
                        CupertinoActionSheetAction(
                          child: const Text('Take a Picture'),
                          onPressed: () {
                            Navigator.pop(context, 'Take a Picture');
                            getImage(0);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('Camera Roll'),
                          onPressed: () {
                            Navigator.pop(context, 'Camera Roll');
                            getImage(1);
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
              } else {
                Navigator.pop(context);
              }
            },
            child: Container(
              width: 80,
              height: 80,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: index == images.length
                      ? new AssetImage(
                    'assets/icons/ic_upload.png',
                  )
                      : Image.file(
                    images[index],
                  ).image,
                ),
              ),
            ),
          ),
          index == images.length
              ? Container()
              : GestureDetector(
                  child: Container(
                    child: Image.asset(
                      'assets/icons/ic_close.png',
                      width: 15,
                      height: 15,
                    ),
                  ),
                )
        ],
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

  Future getImage(int type) async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.getImage(
      source: type == 0 ? ImageSource.gallery : ImageSource.camera,
    );
    if (image != null) {
      await _cropImage(File(image.path));
    }
  }

  Future<Null> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
//    if (croppedFile != null) {
//      imageFile = croppedFile;
//      setState(() {
//        state = AppState.cropped;
//      });
//    }

    if (croppedFile != null) {
    }

  }


}
