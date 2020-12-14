import 'package:Viiddo/models/message_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotificationMessageItem extends StatelessWidget {
  final Function function;
  final MessageModel model;
  const NotificationMessageItem({
    Key key,
    this.function,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.type == 'GUIDE') {
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
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      model.title,
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4),
                    ),
                    Text(
                      model.subtitle,
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                    ),
                    model.content != '' ? Text(
                      model.content,
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ): Container(),
                  ],
                ),
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
                    'See details',
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
    } else if (model.type == 'INVITE') {
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
              child: Padding(
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
                      model.content,
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
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
                    'See details',
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
    } else if (model.type == 'NORMAL') {
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
              child: Padding(
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
                      model.content,
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontFamily: 'Roboto',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
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
                    'See details',
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
}
