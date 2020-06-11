import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/babies/add_baby_screen.dart';
import 'package:Viiddo/screens/home/post_item_no_activity.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BabyDetailsScreen extends StatefulWidget {
  final BuildContext homeContext;
  const BabyDetailsScreen({Key key, this.homeContext}) : super(key: key);

  @override
  _BabyDetailsScreenState createState() => _BabyDetailsScreenState(homeContext);
}

class _BabyDetailsScreenState extends State<BabyDetailsScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  MainScreenBloc screenBloc;

  final BuildContext homeContext;

  _BabyDetailsScreenState(this.homeContext);

  Timer refreshTimer;
  bool isLogin = true;
  int dataCount = 0;
  bool isVerical = true;

  SharedPreferences sharedPreferences;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    // if (screenBloc == null) {
    //   screenBloc = BlocProvider.of<HomeScreenBloc>(homeContext);
    //   screenBloc.add(GetMomentByBaby(0, 0, false));
    // }
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      setState(() {
        isLogin = (sp.getString(Constants.TOKEN) ?? '').length > 0;
        isVerical = sp.getBool(Constants.IS_VERI_CAL) ?? false;
      });
    });

    startTimer();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: screenBloc,
      builder: (BuildContext context, state) {
        return Scaffold(
          appBar: new AppBar(
            title: state.babyModel.name ?? '',
            backgroundColor: Colors.transparent,
            elevation: 0,
            textTheme: TextTheme(
              title: TextStyle(
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
        );
      },
    );
  }

  Widget _getBody(HomeScreenState state) {
    return SafeArea(
      child: Container(
        child: isVerical
            ? state.dataArr != null && state.dataArr.length == 0
                ? Container(
                    child: Image.asset('assets/icons/no_data.png'),
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
                              bloc: screenBloc,
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
              onTapDetail: () {},
              onTapLike: () {
                // screenBloc.add(LikeEvent(state.dataArr[index].objectId, !state.dataArr[index].isLike, index));
              },
              onTapComment: () {},
              onTapShare: () {},
              onTapView: (int i) {
                // DynamicContent content = state.dataArr[index];
                // open(context, i, content.albums);
              },
            );
          },
        ),
      ),
    );
  }

  Future<Null> _handleRefresh() {
    Completer<Null> completer = new Completer<Null>();
    // screenBloc.add(HomeScreenRefresh(completer));
    return completer.future;
  }

  void _onRefresh() async {
    // await Future.delayed(Duration(milliseconds: 1000));
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
    if (refreshTimer != null) return;
    int time = 20;
    const oneSec = const Duration(seconds: 1);
    refreshTimer = new Timer.periodic(
      oneSec,
      (Timer timer) => () {
        if (time <= 0) {
          time = 20;
          if (dataCount > 0 && isLogin) {
            _handleRefresh();
            time -= 1;
          }
        }
      },
    );
  }
}