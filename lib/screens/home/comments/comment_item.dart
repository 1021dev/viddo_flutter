import 'package:Viiddo/models/comment_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;


class CommentItem extends StatelessWidget {
  final Function onTapReply;
  final CommentModel comment;
  const CommentItem({
    Key key,
    this.onTapReply,
    this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userAvatar = comment.replyUser.avatar ?? '';
    String userName = comment.replyUser.name ?? '';
    String content = comment.content ?? '';
    int parentId = comment.parentId ?? 0;
    int time = comment.createTime ?? 0;
    int diff = DateTime.now().millisecondsSinceEpoch - time;
    String timeAgo = '';
    if (diff > 86400000) {
      timeAgo = formatDate(DateTime.fromMillisecondsSinceEpoch(time), [mm, '/', dd, ' ', HH, ':', nn]);
    } else {
      timeAgo = timeago.format(DateTime.fromMillisecondsSinceEpoch(time));
    }
    final makeListTile = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(left: parentId > 0 ? 44 : 24),),
            Container(
              width: parentId > 0 ? 20.0 : 30.0,
              height: parentId > 0 ? 20.0 : 30.0,
              padding: EdgeInsets.all(4),
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: userAvatar != '' ? FadeInImage.assetNetwork(
                    placeholder: 'assets/icons/icon_place_holder.png',
                    image: userAvatar,
                  ).image : AssetImage('assets/icons/icon_place_holder.png'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12,
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      text: userName,
                      style: TextStyle(
                        color: Color(0xFFE46E5C),
                        fontFamily: 'Roboto',
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 4),),
                  Text(
                    content,
                    style: TextStyle(
                      color: Color(0xFF8476AB),
                      fontFamily: 'Roboto',
                      fontSize: 10,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 4),),
                  Text(
                    timeAgo,
                    style: TextStyle(
                      color: Color(0x908476AB),
                      fontFamily: 'Roboto',
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
    final inkWell = Positioned.fill(
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
          onTap: () {
            onTapReply(comment);
          },
        ),
      ),
    );

    final stackView = Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 8, right: 16),
          child: makeListTile,
        ),
        inkWell,
      ],
    );

    return stackView;
  }

}
