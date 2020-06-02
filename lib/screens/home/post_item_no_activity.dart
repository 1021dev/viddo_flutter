import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PostNoActivityItem extends StatelessWidget {
  final Function function;
  final int index;
  const PostNoActivityItem({
    Key key,
    this.function,
    this.index,
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
            padding: EdgeInsets.only(
              top: 12,
              left: 12,
              right: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
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
                        text: 'San',
                        style: TextStyle(
                          color: Color(0xFFE46E5C),
                          fontFamily: 'Roboto',
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Text(
                      'Canadá',
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
          Padding(
            padding: EdgeInsets.all(12),
            child: Container(
              height: 264.0,
              padding: EdgeInsets.all(4),
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1542037104857-ffbb0b9155fb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=950&q=80'),
                ),
              ),
            ),
          ),
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
                                image: new NetworkImage(
                                  'https://i.imgur.com/BoN9kdC.png',
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 8,
                            ),
                          ),
                          Text(
                            'Tom',
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
                        '16 minutes ago',
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
                            'assets/icons/ic_like_off.png',
                          ),
                          onTap: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/icons/ic_comments.png',
                          ),
                          onTap: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                        ),
                        GestureDetector(
                          child: Image.asset(
                            'assets/icons/ic_share.png',
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
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
}
