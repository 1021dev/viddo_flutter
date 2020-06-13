import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/post_item_no_activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BabyDetailsScreen extends StatefulWidget {
  final HomeScreenBloc screenBloc;
  final String babyName;
  final int babyId;
  const BabyDetailsScreen({Key key, this.screenBloc, this.babyName, this.babyId,}): super(key: key);

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
    super.initState();
  }
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      bloc: widget.screenBloc,
      builder: (BuildContext context, HomeScreenState state) {
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
              widget.babyName,
              style: TextStyle(
                color: Color(0xFF8476AB),
                fontSize: 18,
              ),
            ),
          ),
          body: _getBody(state),
        );
      },
    );
  }

  Widget _getBody(HomeScreenState state) {
    return SafeArea(
      child: Container(
          child: state.dataArr != null && state.dataArr.length == 0
              ? Container(
            child: Image.asset('assets/icons/no_post_yet.png'),
          )
              : _buildPostList(state)
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
              body = Container();
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
                widget.screenBloc.add(LikeEvent(state.dataArr[index].objectId, !state.dataArr[index].isLike, index));
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

}
