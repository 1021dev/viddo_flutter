import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/babies/add_baby_screen.dart';
import 'package:Viiddo/screens/home/baby_details.dart';
import 'package:Viiddo/screens/home/comments/comment_screen.dart';
import 'package:Viiddo/screens/home/post_item_no_activity.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'babies/babies_screen.dart';
import 'notifications/notifications_screen.dart';

class HomeScreen extends StatefulWidget {
  final BuildContext homeContext;
  final GlobalKey<NavigatorState> navKey;
  final Function showDetail;
  final Function showBaby;

  const HomeScreen({@required this.navKey, this.homeContext, this.showDetail, this.showBaby});

  @override
  _HomeScreenState createState() => _HomeScreenState(this.homeContext);
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final BuildContext homeContext;

  _HomeScreenState(this.homeContext);
  HomeScreenBloc screenBloc;

  Timer refreshTimer;
  bool isLogin = true;
  int dataCount = 0;
  bool isVerical = true;

  SharedPreferences sharedPreferences;
  RefreshController _refreshController = RefreshController(
    initialRefresh: true,
  );

  @override
  void initState() {
    if (screenBloc == null) {
      screenBloc = BlocProvider.of<HomeScreenBloc>(homeContext);

      screenBloc.add(HomeScreenInitEvent());
    }
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      setState(() {
        isLogin = (sp.getString(Constants.TOKEN) ?? '').length > 0;
        isVerical = sp.getBool(Constants.IS_VERI_CAL) ?? false;
      });
    });

    super.initState();
        startTimer();

  }

  // @override
  // bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      bloc: screenBloc,
      builder: (BuildContext context, HomeScreenState state) {
        String babyAvatar = state.babyAvatar ?? '';
        bool hasUnread = state.unreadMessageModel != null ? state.unreadMessageModel.hasUnread ?? false : false;

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Color(0xFFFFA685),
              size: 12,
            ),
            backgroundColor: Colors.white,
            leading: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: SizedBox(
                height: 44,
                width: 44,
                child: Center(
                  child: Container(
                    width: babyAvatar.length > 0 ? 30.0 : 24.0,
                    height: babyAvatar.length > 0 ? 30.0 : 24.0,
                    clipBehavior: Clip.antiAlias,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: babyAvatar != '' ?
                          FadeInImage.assetNetwork(
                            placeholder: 'assets/icons/ic_tag_baby.png',
                            image: babyAvatar,
                            width: 24,
                            height: 24,
                          ).image:
                          AssetImage('assets/icons/ic_tag_baby.png')
                      ),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                SharedPreferences.getInstance()
                    .then((SharedPreferences sp) {
                  sharedPreferences = sp;
                  bool isVerical =
                      sp.getBool(Constants.IS_VERI_CAL) ?? false;
                  if (isVerical) {
                    Navigator.of(context, rootNavigator: true).push<void>(
                      CupertinoPageRoute(
                        // fullscreenDialog: true,
                          builder: (context) => BabiesScreen(
                              bloc: screenBloc.mainScreenBloc
                          )
                      ),
                    );
                  } else {
                    WidgetUtils.showErrorDialog(
                        context, 'Please verify your email first.');
                  }
                }
                );
              },
            ),
            title: SizedBox(child:Image.asset('assets/icons/ic_logo_viiddo.png'), width: 72, height: 35,),
            actions: <Widget>[
              CupertinoButton(
                padding: EdgeInsets.all(0),
                child: SizedBox(
                  width: 44,
                  height: 44,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      ImageIcon(
                        AssetImage('assets/icons/notifications.png'),
                        color: Color(0xFFFFA685),
                        size: 24,
                      ),
                      hasUnread ?
                      Container(
                          width: 24,
                          height: 24,
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                          )
                      ) : Container(),
                    ],
                  ),
                ),
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).push<void>(
                    CupertinoPageRoute(
                      // fullscreenDialog: true,
                        builder: (context) => NotificationsScreen(
                          mainScreenBloc: screenBloc.mainScreenBloc,
                        )

                    ),
                  );
                },
              ),
            ],
          ),
          body: _getBody(state),
        );
      },
    );
  }

  Widget _getBody(HomeScreenState state) {
    return SafeArea(
      child: Container(
        child: isVerical
            ? state.dataArr != null && state.dataArr.length == 0
            ? Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/icons/no_post_yet.png'),
                Padding(padding: EdgeInsets.only(top: 8),),
                Text(
                  'No Data',
                  style: TextStyle(
                    color: Color(0xFFC4C4C4),
                    fontFamily: 'Roboto',
                    fontSize: 18,
                  ),
                ),

              ],
              ),
          )
            : _buildPostList(state)
            : Center(
          child: GestureDetector(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/icons/ic_home_empty.png'),
                Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Add a baby ',
                    style: TextStyle(
                      color: Color(0xFFFFA685),
                      fontFamily: 'Roboto-Bold',
                      fontSize: 13,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' or ',
                        style: TextStyle(
                          color: Color(0xFF8476AB),
                          fontFamily: 'Roboto-Light',
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: 'enter invitation code',
                        style: TextStyle(
                          color: Color(0xFFFFA685),
                          fontFamily: 'Roboto-Bold',
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: ' to join a group',
                        style: TextStyle(
                          color: Color(0xFF8476AB),
                          fontFamily: 'Roboto-Light',
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            onTap: () {
              SharedPreferences.getInstance().then(
                    (SharedPreferences sp) {
                  bool isVerical =
                      sp.getBool(Constants.IS_VERI_CAL) ?? false;
                  if (isVerical) {
                    Navigation.toScreen(
                      context: context,
                      screen: AddBabyScreen(
                        bloc: screenBloc.mainScreenBloc,
                      ),
                    );
                  } else {
                    WidgetUtils.showErrorDialog(
                        context, 'Please verify your email first.');
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPostList(HomeScreenState state) {
    dataCount = state.dataArr != null ? state.dataArr.length : 0;
    print('Data Count: => ${state.dataArr}');
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
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text("pull up load");
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text("Load Failed!Click retry!");
            } else if (mode == LoadStatus.canLoading) {
              body = Text("release to load more");
            } else {
              body = Text("No more Data");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: dataCount,
          itemBuilder: (context, index) {
            return PostNoActivityItem(
              content: state.dataArr[index],
              onTapDetail:(content) {
                screenBloc.add(ClearMomentDetailEvent());
                screenBloc.add(GetMomentDetailsEvent(content.objectId, content.baby.objectId));
                Navigator.of(context, rootNavigator: true).push<void>(
                  FadePageRoute(
                      CommentScreen(
                        screenBloc: screenBloc,
                        content: content,
                      )
                  ),
                );
              },
              onTapLike: () {
                screenBloc.add(LikeEvent(state.dataArr[index].objectId, !state.dataArr[index].isLike, index));
              },
              onTapComment: () {},
              onTapShare: () {},
              onTapView:(content) {
                Navigator.of(context, rootNavigator: true).push<void>(
                  FadePageRoute(
                      BabyDetailsScreen(
                        screenBloc: screenBloc,
                        babyId: content.baby.objectId,
                        babyName: content.baby.name,
                      )
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    Completer<Null> completer = new Completer<Null>();
    screenBloc.add(HomeScreenRefresh(completer));
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
    if (refreshTimer != null) {
      refreshTimer.cancel();
      refreshTimer = null;
    }
    // screenBloc.close();
    super.dispose();
  }

  void startTimer() {
    print('Timer Started');
    if (refreshTimer != null && refreshTimer.isActive) return;
    int time = 20;
    const oneSec = const Duration(seconds: 1);
    refreshTimer = Timer.periodic(oneSec, (timer) {
        if (time <= 0) {
          time = 20;
          if (dataCount > 0 && isLogin) {
            _handleRefresh();
            time -= 1;
          }
        } else {
            time -= 1;
        }
    });
  }
}
