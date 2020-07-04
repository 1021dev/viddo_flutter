import 'dart:async';
import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/screens/home/post_item_no_activity.dart';
import 'package:Viiddo/screens/home/vaccines/vaccines_screen.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/widgets/bottom_selector.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'comments/comment_screen.dart';
import 'growth/growth_screen.dart';
import 'post/edit_picture_screen.dart';


class BabyDetailsScreen extends StatefulWidget {
  final MainScreenBloc screenBloc;
  final BabyModel babyModel;
  const BabyDetailsScreen({Key key, this.screenBloc, this.babyModel,}): super(key: key);

  @override
  _BabyDetailsScreenState createState() => _BabyDetailsScreenState();
}

class _BabyDetailsScreenState extends State<BabyDetailsScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int dataCount = 0;

  SharedPreferences sharedPreferences;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    widget.screenBloc.add(GetBabyInfo(widget.babyModel.objectId));
    super.initState();
  }
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      bloc: widget.screenBloc,
      builder: (BuildContext context, MainScreenState state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Color(0xFFFFA685),
              size: 12,
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(
              widget.babyModel.name,
              style: TextStyle(
                color: Color(0xFF8476AB),
                fontSize: 18,
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Container(
              width: 44.0,
              height: 44.0,
              margin: EdgeInsets.only(bottom: 24),
              alignment: Alignment.bottomCenter,
              child: new RawMaterialButton(
                shape: new CircleBorder(),
                fillColor: Colors.white,
                elevation: 4.0,
                child: Icon(
                  Icons.add_circle,
                  size: 40,
                  color: Color(0xFFFFA685),
                ),
                onPressed: (){
                  showGeneralDialog(
                    barrierLabel: "Label",
                    barrierDismissible: true,
                    barrierColor: Colors.black.withOpacity(0.5),
                    transitionDuration: Duration(milliseconds: 235),
                    context: context,
                    pageBuilder: (context, anim1, anim2) {
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomSelector(
                          mainScreenBloc: widget.screenBloc,
                          closeFunction: () {
                            Navigator.pop(context, 'close');
                          },
                          libraryFunction: () {
                            Navigator.pop(context, 'library');
                            getImage(0);
                          },
                          cameraFunction: () {
                            Navigator.pop(context, 'camera');
                            getImage(1);
                          },
                          growthFunction: () {
                            Navigator.pop(context, 'growth');
                            Navigation.toScreen(
                              context: context,
                              screen: GrowthScreen(
                                bloc: widget.screenBloc,
                              ),
                            );
                          },
                          vaccinesFunction: () {
                            Navigator.pop(context, 'vaccines');
                            Navigation.toScreen(
                              context: context,
                              screen: VaccinesScreen(
                                bloc: widget.screenBloc,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    transitionBuilder: (context, anim1, anim2, child) {
                      return SlideTransition(
                        position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                            .animate(anim1),
                        child: child,
                      );
                    },
                  );
                },
              ),
            ),
          body: _getBody(state),
        );
      },
    );
  }

  Widget _getBody(MainScreenState state) {
    return SafeArea(
      child: Container(
          child: _buildPostList(state),
      ),
    );
  }

  Widget _buildPostList(MainScreenState state) {
    dataCount = state.dataArr != null ? state.dataArr.length : 0;
    print('Data Count: => ${state.dataArr}');
    String gender = state.babyModel != null ? state.babyModel.gender ?? '': '';
    String boxImage = 'assets/icons/unisex_container.png';
    Color detailButtonColor = Color(0xFFF9BE08);
    Color bottomBackgroundColor = Color(0xCCF9BE08);
    if (gender == 'M') {
      boxImage = 'assets/icons/boy_container.png';
      detailButtonColor = Color(0xFF439EF2);
      bottomBackgroundColor = Color(0xCC439EF2);
    } else if (gender == 'F') {
      boxImage = 'assets/icons/girl_container.png';
      detailButtonColor = Color(0xFFFF6B87);
      bottomBackgroundColor = Color(0xCCFF6B87);
    }
    double width = MediaQuery.of(context).size.width;
    double height = width * 0.44;
    String babyAvatar = state.babyModel != null ? state.babyModel.avatar ?? '': '';
    String babyName = state.babyModel != null ? state.babyModel.name ?? '': '';
    int birth = state.babyModel != null ? state.babyModel.birthDay ?? 0 : 0;
    DateTime birthday = DateTime.fromMillisecondsSinceEpoch(birth);
    String birthString = birth != 0 ? formatDate(birthday, [m, '/', dd, '/', yyyy]): '';
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF5EF),
              Colors.white,
            ]),
      ),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropHeader(
          waterDropColor: Color(0xFFFFA685),
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            return Container(
              height: 55.0,
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(boxImage),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 16, right: 16, top: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 30.0,
                                  height: 30.0,
                                  padding: EdgeInsets.all(4),
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: babyAvatar != '' ? FadeInImage.assetNetwork(
                                        placeholder: 'assets/icons/ic_baby_solid.png',
                                        image: babyAvatar,
                                      ).image : AssetImage('assets/icons/ic_baby_solid.png'),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 12,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text: babyName,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Birthdate: $birthString',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                                width: 60,
                                height: 25,
                                alignment: Alignment.center,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: detailButtonColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Details',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        )
                      ),
                      Expanded(child: Container(),),
                      Container(
                        height: 45,
                        color: bottomBackgroundColor,
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/icons/ic_milestone.png'),
                                    Padding(padding: EdgeInsets.only(left: 8),),
                                    Text('Milestone', style: TextStyle(color: Colors.white, fontSize: 14),),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Image.asset('assets/icons/ic_dash_line.png'),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image.asset('assets/icons/ic_family_white.png'),
                                    Padding(padding: EdgeInsets.only(left: 8),),
                                    Text('Family', style: TextStyle(color: Colors.white, fontSize: 14),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: state.dataArr == null || state.dataArr.length == 0
                              ? Container(
                            child: Image.asset('assets/icons/no_post_yet.png'),
                                ):
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: dataCount,
                                  itemBuilder: (context, index) {
                                    return PostNoActivityItem(
                                      content: state.dataArr[index],
                                      onTapDetail:(content) {
                                        widget.screenBloc.add(ClearMomentDetailEvent());
                                        widget.screenBloc.add(GetMomentDetailsEvent(content.objectId, content.baby.objectId));
                                        Navigator.of(context, rootNavigator: true).push<void>(
                                          FadePageRoute(
                                              CommentScreen(
                                                screenBloc: widget.screenBloc,
                                                content: content,
                                              )
                                          ),
                                        );
                                      },
                                      onTapLike: () {
                                        widget.screenBloc.add(LikeEvent(state.dataArr[index].objectId, !state.dataArr[index].isLike, index));
                                      },
                                      onTapComment: () {},
                                      onTapShare: () {},
                                      onTapView: (content) {
                                        widget.screenBloc.add(SelectBabyEvent(content.baby));
                                        Navigator.of(context, rootNavigator: true).push<void>(
                                          FadePageRoute(
                                              BabyDetailsScreen(
                                                screenBloc: widget.screenBloc,
                                                babyModel: content.baby,
                                              )
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                ),
              ],
            ),
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    Completer<Null> completer = new Completer<Null>();
    // screenBloc.add(HomeScreenRe(completer));
    return completer.future;
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
//    items.add((items.length+1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _loadFailed() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _loadNodata() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    // screenBloc.close();
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
      Navigation.toScreen(
        context: context,
        screen: EditPictureScreen(
          mainScreenBloc: widget.screenBloc,
          image: File(croppedFile.path),
        ),
      );
    }

  }


}
