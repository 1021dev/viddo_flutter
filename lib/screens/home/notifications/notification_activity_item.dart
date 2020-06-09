import 'package:Viiddo/models/activity_notification_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationActivityItem extends StatelessWidget {
  final Function function;
  final ActivityNotificationModel model;
  const NotificationActivityItem({
    Key key,
    this.function,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 38,
                            height: 38,
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  child: Container(
                                    width: 30.0,
                                    height: 30.0,
                                    padding: EdgeInsets.all(4),
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: new NetworkImage(
                                          'https://i.imgur.com/BoN9kdC.png',
                                        ),
                                      ),
                                    ),
                                  ),
                                  padding: EdgeInsets.all(4),
                                ),
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFFA685),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                              alignment: Alignment.centerLeft,
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
                                  text: 'Van Le ',
                                  style: TextStyle(
                                    color: Color(0xFFE46E5C),
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'left a comment',
                                      style: TextStyle(
                                        color: Color(0xFF8476AB),
                                        fontFamily: 'Roboto',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '2 minute ago',
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
                      Padding(
                        padding: EdgeInsets.only(top: 8),
                      ),
                      Text(
                        'I Like this! Very cute moments.',
                        style: TextStyle(
                          color: Color(0xFF8476AB),
                          fontFamily: 'Roboto',
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 70.0,
                  height: 70.0,
                  padding: EdgeInsets.all(4),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('https://i.imgur.com/bFFfXSmg.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0x998476AB),
            height: 0,
            thickness: 0.5,
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'See post',
                  style: TextStyle(
                    color: Color(0xFFFAA382),
                    fontSize: 12,
                  ),
                ),
                Image.asset(
                  'assets/icons/ic_right_arrow.png',
                  width: 7,
                  height: 13,
                  color: Color(0xFFFAA382),
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
          onTap: function,
        ),
      ),
    );

    final stackView = Stack(
      alignment: Alignment.center,
      children: <Widget>[
        makeListTile,
        inkWell,
      ],
    );

    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: 20,
        right: 20,
      ),
      child: stackView,
    );
  }
}
