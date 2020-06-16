import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/dynamic_creator.dart';
import 'package:Viiddo/models/dynamic_tag.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'photo/crop_image.dart';

class PostNoActivityItem extends StatelessWidget {
  final Function onTapDetail;
  final Function onTapComment;
  final Function onTapLike;
  final Function onTapShare;
  final Function onTapView;
  final DynamicContent content;
  const PostNoActivityItem({
    Key key,
    this.onTapDetail,
    this.onTapComment,
    this.onTapLike,
    this.onTapShare,
    this.onTapView,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String babyName = content.baby != null ? content.baby.name ?? '' : '';
    String babyAvatar = content.baby != null ? content.baby.avatar ?? '' : '';
    String babyRelationShip =
        content.baby != null ? content.baby.relationship ?? '' : '';
    String userName = content.creator != null ? content.creator.nickName ?? '' : '';
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

    int commentCount = content.commentCount ?? 0;
    var commentView = Padding(
      padding: EdgeInsets.only(
        left: 8,
        right: 8,
        top: 8,
        bottom: 8,
      ),
      child: Text(
        'View $commentCount comment${(commentCount > 1 ? 's' : '')}',
        style: TextStyle(
          color: Color(0xFFFFA685),
          fontFamily: 'Roboto-Bold',
          fontSize: 9,
        ),
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
    if (content.commentCount > 0) {
      if (bottomViewList.length > 0) {
        bottomViewList.add(Divider(
          color: Color(0x66FFA685),
          height: 0,
          thickness: 1,
        ));
      }
      bottomViewList.add(commentView);
    }

    Widget bottomView = Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Color(0x20FFA685),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: bottomViewList,
      ),
    );

    final makeListTile = GestureDetector(
      onTap: () {
        onTapDetail(content);
      },
      child: Container(
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
                  onTapView(content);
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
                                  ).image: Image.asset(
                                      'assets/icons/icon_place_holder.png',
                                      fit: BoxFit.cover,
                                    ).image,
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
                            onTap: onTapLike,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          GestureDetector(
                            child: Image.asset(
                              'assets/icons/ic_comment.png',
                              width: 16,
                            ),
                            onTap: onTapComment,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                          ),
                          GestureDetector(
                            child: Image.asset(
                              'assets/icons/ic_share.png',
                              width: 16,
                            ),
                            onTap: onTapShare,
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
}
