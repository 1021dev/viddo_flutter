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


class HomeScreen extends StatefulWidget {
  final MainScreenBloc mainScreenBloc;
  final GlobalKey<NavigatorState> navKey;
  final Function showDetail;
  final Function showBaby;

  const HomeScreen({@required this.navKey, this.mainScreenBloc, this.showDetail, this.showBaby});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      bloc: widget.mainScreenBloc,
      builder: (BuildContext context, MainScreenState state) {

        return _getBody(state);
      },
    );
  }

  Widget _getBody(MainScreenState state) {
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
                        bloc: widget.mainScreenBloc,
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

  Widget _buildPostList(MainScreenState state) {
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
            return Container(
              height: 55.0,
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
                widget.mainScreenBloc.add(ClearMomentDetailEvent());
                widget.mainScreenBloc.add(GetMomentDetailsEvent(content.objectId, content.baby.objectId));
                Navigator.of(context, rootNavigator: true).push<void>(
                  FadePageRoute(
                      CommentScreen(
                        screenBloc: widget.mainScreenBloc,
                        content: content,
                      )
                  ),
                );
              },
              onTapLike: () {
                widget.mainScreenBloc.add(LikeEvent(state.dataArr[index].objectId, !state.dataArr[index].isLike, index));
              },
              onTapComment: () {},
              onTapShare: () {},
              onTapView:(content) {
                widget.mainScreenBloc.add(SelectBabyEvent(content.baby));
                Navigator.of(context, rootNavigator: true).push<void>(
                  FadePageRoute(
                      BabyDetailsScreen(
                        screenBloc: widget.mainScreenBloc,
                        babyModel: content.baby,
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
    widget.mainScreenBloc.add(MainScreenRefresh(completer));
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
            widget.mainScreenBloc.add(MainScreenGetRefresh());
            time -= 1;
          }
        } else {
            time -= 1;
        }
    });
  }
}
