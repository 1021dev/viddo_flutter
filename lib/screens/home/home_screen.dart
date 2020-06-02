import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/babies/add_baby_screen.dart';
import 'package:Viiddo/screens/home/post_item_no_activity.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  MainScreenBloc bloc;

  HomeScreen({
    this.bloc,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isPost = false;

  RefreshController _refreshController = RefreshController(
    initialRefresh: true,
  );

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
          return Scaffold(
            key: scaffoldKey,
            body: _getBody(state),
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
    if (state.isLoading) {
      return WidgetUtils.loadingView();
    } else {
      return SafeArea(
        key: formKey,
        child: Container(
          child: isPost
              ? _buildPostList()
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
                      setState(() {
                        isPost = true;
                      });
                      Navigation.toScreen(
                        context: context,
                        screen: AddBabyScreen(
                          bloc: widget.bloc,
                        ),
                      );
                    },
                  ),
                ),
        ),
      );
    }
  }

  Widget _buildPostList() {
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
          itemCount: 10,
          itemBuilder: (context, index) {
            return PostNoActivityItem(
              index: index,
            );
          },
        ),
      ),
    );
  }

  Future<Null> _handleRefresh(context) {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
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

  @override
  void dispose() {
    super.dispose();
  }
}
