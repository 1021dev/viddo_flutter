import 'package:flutter/material.dart';

import '../../themes.dart';
import '../../themes.dart';

class WelcomeView extends StatelessWidget {
  final Function onTapWatchVideo;
  final Function onTapSkip;

  WelcomeView({
    Key key,
    @required this.onTapSkip,
    @required this.onTapWatchVideo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 44),
          ),
          Image.asset('assets/icons/welcome.png'),
          Padding(
            padding: EdgeInsets.only(top: 36),
          ),
          Text(
            'One-stop app to share photos of your kiddos.\nDon’t know where to start?',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF8476AB),
              fontFamily: 'Roboto',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24),
          ),
          Image.asset('assets/icons/ic_arrow_down.png'),
          Padding(
            padding: EdgeInsets.only(top: 32),
          ),
          Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Material(
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    height: 50.0,
                    color: Color(0xFFFFA685),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: onTapSkip,
                  ),
                ),
                Material(
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    height: 50.0,
                    color: Color(0xFFE46E5C),
                    child: Text(
                      'Watch our video',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: onTapWatchVideo,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
