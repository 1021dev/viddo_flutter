import 'package:flutter/material.dart';

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
      alignment: Alignment.center,
      padding: EdgeInsets.all(0),
      child: Container(
        margin: EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        clipBehavior: Clip.antiAlias,
        height: 400,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 44),
            ),
            Image.asset('assets/icons/welcome.png'),
            Padding(
              padding: EdgeInsets.only(top: 36),
            ),
            Expanded(
              child: Material(
                color: Colors.transparent,
                child: Text(
                  'One-stop app to share photos of your kiddos.\nDon’t know where to start?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8476AB),
                    fontFamily: 'Roboto',
                  ),
                ),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      height: 50.0,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      color: Color(0xFFFFA685),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      focusElevation: 0.0,
                      hoverElevation: 0.0,
                      highlightElevation: 0.0,
                      onPressed: onTapSkip,
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      height: 50.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5),
                        ),
                      ),
                      elevation: 0.0,
                      color: Color(0xFFE46E5C),
                      child: Text(
                        'Watch our video',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                      focusElevation: 0.0,
                      hoverElevation: 0.0,
                      highlightElevation: 0.0,
                      onPressed: onTapWatchVideo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
