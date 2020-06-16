import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/comment_model.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/dynamic_creator.dart';
import 'package:Viiddo/models/dynamic_tag.dart';
import 'package:Viiddo/screens/home/comments/comment_item.dart';
import 'package:Viiddo/screens/home/photo/crop_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:timeago/timeago.dart' as timeago;


class CommentScreen extends StatefulWidget {
  final MainScreenBloc screenBloc;
  final DynamicContent content;
  const CommentScreen({Key key, this.screenBloc, this.content,}): super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> with SingleTickerProviderStateMixin{
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _textController = TextEditingController();
  final FocusNode textFocus = FocusNode();
  DynamicContent content;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  bool isLoaded = false;
  List<CommentModel> commentList = [];
  CommentModel parentModel;
  String reply = '';
  @override
  void initState() {
    super.initState();
  }
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      bloc: widget.screenBloc,
      builder: (BuildContext context, MainScreenState state) {
        content = state.dynamicDetails ?? widget.content;
        commentList = [];
        List<CommentModel> parentList = content.commentList.where((CommentModel model) {
          return model.parentId == 0;
        }).toList();
        parentList.sort((c1, c2) {
          return c2.createTime.compareTo(c1.createTime);
        });
        for (int i = 0; i < parentList.length; i++) {
          CommentModel comment = parentList[i];
          commentList.add(comment);
          List<CommentModel> childList = content.commentList.where((CommentModel model) {
            return model.parentId == comment.objectId;
          }).toList();
          childList.sort((c1, c2 ){
            return c2.createTime.compareTo(c1.createTime);
          });
          commentList.addAll(childList);
            print(comment.toJson());
        }
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            iconTheme: IconThemeData(
              color: Color(0xFFFFA685),
              size: 12,
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            title: Text(
              'Details',
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

  Widget _getBody(MainScreenState state) {
    return SafeArea(
      child: NotificationListener<ScrollStartNotification>(
        onNotification: (x) {
          if (x.dragDetails == null) {
            return;
          }

          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  header: WaterDropHeader(
                    waterDropColor: Color(0xFFFFA685),
                  ),
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: SingleChildScrollView(
                    child: Column(children: <Widget>[
                      buildPostView(state),
                      new Container(
                          child: new ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return CommentItem(comment: commentList[index], onTapReply: (CommentModel comment) {
                                setState(() {
                                  parentModel = comment;
                                  reply = 'reply ${comment.creator.nickName}: ';
                                  FocusScope.of(context).requestFocus(textFocus);
                                });
                              },);
                            },
                            itemCount: commentList.length,
                          ),
                        ),
                        Container(height: 24,),
                      ],
                    ),
                  ),
                ),
              ),
              new Divider(height: 1.0),
              new Container(
                  decoration:
                      new BoxDecoration(color: Theme.of(context).cardColor),
                  child: new IconTheme(
                      data: new IconThemeData(
                          color: Theme.of(context).accentColor),
                      child: new Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: new Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.only(left: 16),
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  border: new Border.all(
                                    color: Color(0xFFE5E5EA),
                                    width: 1.0,
                                    style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    new Container(
                                      width: 36.0,
                                      height: 36.0,
                                      child: Image.asset(
                                              "assets/icons/ic_message.png"),
                                    ),
                                    new Flexible(
                                      child: new TextField(
                                        controller: _textController,
                                        focusNode: textFocus,
                                        textAlignVertical: TextAlignVertical.center,
                                        decoration: new InputDecoration(
                                          prefixText: reply,
                                          prefixStyle: TextStyle(color: Color(0xFFFFA685), fontSize: 12, fontFamily: 'Roboto-Medium'),
                                          contentPadding: EdgeInsets.all(0),
                                          border: InputBorder.none,
                                          isDense: true,
                                          hintText: "Write a comment"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            new Container(
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 2.0),
                              child: new CupertinoButton(
                                  child: Text(
                                    'Post',
                                    style: TextStyle(
                                      color: Color(0xFFFFA685),
                                      fontSize: 14,
                                    ),
                                  ),
                                  onPressed: () => _sendMsg(
                                      _textController.text),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  void _sendMsg(String msg) {
    if (msg.length == 0) {
      Toast.show( 'Please write a comment', context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER,);
    } else {
      _textController.clear();
      widget.screenBloc.add(CommentEvent(content.objectId, parentModel != null ? parentModel.objectId ?? 0 : 0, msg));
      setState(() {
        parentModel = null;
        reply = '';
      });

    }
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

  Widget buildPostView(MainScreenState state) {
    String babyName = content.baby != null ? content.baby.name ?? '' : '';
    String babyAvatar = content.baby != null ? content.baby.avatar ?? '' : '';
    String babyRelationShip =
        content.baby != null ? content.baby.relationship ?? '' : '';
    String userName = content.creator != null ? content.creator.name ?? '' : '';
    String userAvatar =
        content.creator != null ? content.creator.avatar ?? '' : '';
    String desc = content.content ?? '';
    bool isLike = content.isLike ?? false;

    String address = content.address ?? '';
    int created = content.createTime ?? 0;
    int diff = DateTime.now().millisecondsSinceEpoch - created;
    String timeAgo = '';
    if (diff > 86400000) {
      timeAgo = formatDate(DateTime.fromMillisecondsSinceEpoch(created), [mm, '/', dd, ' ', HH, ':', nn]);
    } else {
      timeAgo = timeago.format(DateTime.fromMillisecondsSinceEpoch(created));
    }

    int gridCount = 1;
    int itemCount = 1;
    double screenWidth = MediaQuery.of(context).size.width;
    double width = screenWidth - 48;
    double height = width * 0.8;
    if (content.albums != null) {
      itemCount = content.albums.length;
      if (itemCount > 1) {
        width = width / 2 - 4;
        height = width;
        gridCount = 2;
      }
    }
    List<String> photoList = [];
    for (int i = 0; i < content.albums.length; i ++) {
      String url = content.albums[i];
      if (url.contains('video') || url.split('.').last == 'm3u8') {
        String placeHolderUrl = 'http://image.mux.com/${(((url.split('/')).last).split('.')).first}/thumbnail.jpg';
        photoList.add(placeHolderUrl);
      } else {
        photoList.add(url);
      }
    }
    final pictureView = Padding(
      padding: EdgeInsets.all(12),
      child: Container(
        height: gridCount == 1 ? height + 8: (itemCount / 2) * (height + 8),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: gridCount,
          childAspectRatio: gridCount == 1 ? 1.25 : 1,
          addAutomaticKeepAlives: true,
          physics: NeverScrollableScrollPhysics(),
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          children: List.generate(
            itemCount,
            (index) {
              String url = photoList[index];
              if (url.contains('http://image.mux.com/')) {
                return _postView(url, width, height, true, content.albums[index], index, photoList);
              } else {
                return _postView(url, width, height, false, '', index, photoList);
              }
            },
          ),
        ),
      ),
    );

    List<DynamicTag> tags = content.tags ?? [];
    var tagsView = Padding(
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: _buildTagList(tags),
      ),
    );

    var favView = Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: _buildLikeList(content.likeList),
      ),
    );


    List<Widget> bottomViewList = [];
    if (content.likeList.length > 0) {
      bottomViewList.add(favView);
    }
    Widget bottomView = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: bottomViewList,
      ),
    );

    final makeListTile = Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 12,
                left: 12,
                right: 12,
              ),
              child: GestureDetector(
                onTap: () {
                },
                child: Row(
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
                          image: FadeInImage.assetNetwork(
                            placeholder: 'assets/icons/ic_baby_solid.png',
                            image: babyAvatar,
                          ).image,
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
                              color: Color(0xFFE46E5C),
                              fontFamily: 'Roboto',
                              fontSize: 13,
                            ),
                          ),
                        ),
                        Text(
                          address,
                          style: TextStyle(
                            color: Color(0xFF8476AB),
                            fontFamily: 'Roboto',
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            desc != '' ?
            Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                desc, 
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 11,
                ),
              ),
            ) : Container(),
            pictureView,
            tags.length > 0 ? tagsView: Container(),
            Container(
              child: Padding(
                padding: EdgeInsets.only(top: 4, left: 12, right: 12, bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 20.0,
                              height: 20.0,
                              padding: EdgeInsets.all(4),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: userAvatar != '' ? FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/icons/icon_place_holder.png',
                                    image: userAvatar,
                                  ).image : AssetImage('assets/icons/icon_place_holder.png'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8,
                              ),
                            ),
                            Text(
                              userName,
                              style: TextStyle(
                                color: Color(0xFFFAA382),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4),
                        ),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            color: Color(0xFF8476AB),
                            fontSize: 9,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          GestureDetector(
                            child: Image.asset(
                              isLike ? 'assets/icons/ic_like_on.png': 'assets/icons/ic_like_off.png',
                              width: 16,
                            ),
                            onTap: (){
                              widget.screenBloc.add(LikeEvent(content.objectId, !content.isLike, -1));
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          GestureDetector(
                            child: Image.asset(
                              'assets/icons/ic_comment.png',
                              width: 16,
                            ),
                            onTap: (){
                              setState(() {
                                parentModel = null;
                                reply = '';
                              });
                              FocusScope.of(context).requestFocus(textFocus);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          GestureDetector(
                            child: Image.asset(
                              'assets/icons/ic_share.png',
                              width: 16,
                            ),
                            onTap: (){},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            (content.likeCount > 0 || content.commentCount > 0) ?
              Padding(
                padding: EdgeInsets.only(left: 12, right: 12, bottom: 12,),
                child: bottomView,
              ): Container(),
          ],
        ),
    );

    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: 12,
        right: 12,
      ),
      child: makeListTile,
    );
  }

  Widget _postView(String picture, double width, double height, bool isVideo, String videoUrl, int index, List<String> photoList) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: height,
            width: width,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(5),
            ),
            child: CropImage(
              index: index,
              albumn: photoList,
              isVideo: isVideo,
              list: content.albums,
            ),
          ),
        ],
    );
  }

  List<Widget> _buildTagList(List<DynamicTag> groups) {
    List<Widget> lines = []; // this will hold Rows according to available lines
    for (DynamicTag tag in groups) {
      lines.add(
        Text(
          tag.name,
          style: TextStyle(
            color: Color(0xFFE46E5C),
            fontFamily: 'Roboto',
            fontSize: 9,
          ),
        ),
      );
    }
    return lines;
  }

  List<Widget> _buildLikeList(List<DynamicCreator> groups) {
    List<Widget> lines = [];
    lines.add(
      Image.asset('assets/icons/ic_like_on.png', width: 16,),
    );
    for (DynamicCreator creator in groups) {
      lines.add(
        Padding(
          padding: EdgeInsets.only(left: 4),
          child: Text(
            lines.length == groups.length ? creator.name : '${creator.name},',
            style: TextStyle(
              color: Color(0xFFFFA685),
              fontFamily: 'Roboto',
              fontSize: 9,
            ),
          ),
        ),
      );
    }
    return lines;
  }

  @override
  void dispose() {
    _textController.dispose();
    textFocus.dispose();
    super.dispose();
  }

}
