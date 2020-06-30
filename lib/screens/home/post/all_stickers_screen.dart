import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/sticker_category_model.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllStickerScreen extends StatefulWidget {
  PostBloc bloc;
  final List<StickerCategory> categories;
  AllStickerScreen({
    this.bloc,
    this.categories,
  });

  @override
  _AllStickerScreenState createState() => _AllStickerScreenState();
}

class _AllStickerScreenState extends State<AllStickerScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  TabController _controller;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    _controller = TabController(vsync: this, length: widget.categories.length + 1)
      ..addListener(() {
        setState(() {
          _selectedIndex = _controller.index;
        });
      });

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
          return RefreshConfiguration(
            headerBuilder: () => WaterDropHeader(),        // Configure the default header indicator. If you have the same header indicator for each page, you need to set this
            footerBuilder:  () => ClassicFooter(),        // Configure default bottom indicator
            enableScrollWhenRefreshCompleted: true, //This property is incompatible with PageView and TabBarView. If you need TabBarView to slide left and right, you need to set it to true.
            enableLoadingWhenFailed : true, //In the case of load failure, users can still trigger more loads by gesture pull-up.
            hideFooterWhenNotFull: false, // Disable pull-up to load more functionality when Viewport is less than one screen
            enableBallisticLoad: true, // trigger load more by BallisticScrollActivity
            child: Scaffold(
              appBar: new AppBar(
                title: Text('All Stickers'),
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
                  controller: _controller,
                  isScrollable: true,
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  tabs: List.generate(
                    widget.categories.length + 1,
                    (index) {
                      if (index == 0) {
                        return Tab(
                          child: Text(
                            'ALL',
                            style: TextStyle(
                              color: _selectedIndex == index
                                  ? Color(0xFFFFA685)
                                  : Color(0xFF8476AB),
                              fontSize: 12,
                            ),
                          ),
                        );
                      }
                      return Tab(
                        child: Text(
                          widget.categories[index - 1].name,
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Color(0xFFFFA685)
                                : Color(0xFF8476AB),
                            fontSize: 12,
                          ),
                        ),
                      );
                    },
                  ),
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
                    Container(
                      color: Color(0xFFFFF5EF),
                      height: 8,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _controller,
                        children: List.generate(
                          widget.categories.length + 1,
                          (index) {
                            return _body(state, _selectedIndex);
                          },
                        ),
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

  Widget _body(PostState state, int index) {
    List<StickerModel> stickers = [];
    if (index == 0 && state.stickers.keys.contains(0)) {
      stickers.addAll(state.stickers[0]);
    } else if (state.stickers.keys.contains(widget.categories[index - 1].objectId)) {
      stickers.addAll(state.stickers[widget.categories[index - 1].objectId]);
    }
    bool hasMore = false;
    int count = stickers.length;
    if (count.remainder(30) == 0) {
      hasMore = true;
    }
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        waterDropColor: Color(0xFFFFA685),
      ),
      footer: CustomFooter(
        loadStyle: LoadStyle.ShowWhenLoading,
        height: 1,
        builder: (context, status) {
          return Container();
        },
      ),
      controller: _refreshController,
      onRefresh: () {
        int objectId = 0;
        if (index > 0) {
          objectId = state.categories[index - 1].objectId;
        }
        widget.bloc.add(StickerRefreshEvent(objectId, 1));
        onRefresh();
      },
      onLoading: () {
        int objectId = 0;
        if (index > 0) {
          objectId = state.categories[index - 1].objectId;
        }
        int page = (count - 1) ~/ 30 + 1;
        widget.bloc.add(StickerLoadMoreEvent(objectId, page + 1));
        onLoading();
      },
      child: CustomScrollView(
        slivers: <Widget>[
          SliverGrid.count(
            crossAxisCount: 5,
            crossAxisSpacing: 8,
            children: List.generate(
              stickers.length,
                  (index) {
                return _stickerItem(stickers[index]);
              },
            ),
          ),
          new SliverToBoxAdapter(
            child: hasMore ? Container(
              child: Column(
                children: <Widget>[
                  Image.asset('assets/icons/ic_load_more.png'),
                  Text(
                    'Load more',
                    style: TextStyle(
                      color: Color(0xFFFFA685),
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ) : Container(),
          )
        ],
      ),
    );
  }

  Widget _stickerItem(StickerModel sticker) {
    return GestureDetector(
      onTap: () {
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

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  Future<Null> _handleRefresh() {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted)
    setState(() {

    });
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
    super.dispose();
  }
}
