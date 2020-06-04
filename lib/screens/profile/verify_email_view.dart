import 'package:flutter/material.dart';

class VerifyEmailView extends StatelessWidget {
  final Function onTap;

  int time;
  bool sentCode;
  VerifyEmailView({
    Key key,
    @required this.onTap,
    this.time,
    this.sentCode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFBF8),
      ),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 44),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 4,
                  child: Image.asset(
                    'assets/icons/ic_verification_code.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 36),
            ),
            Text(
              'Please verify your email before continuing',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF8476AB),
                fontFamily: 'Roboto',
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
            ),
            Container(
              height: 44,
              child: SizedBox.expand(
                child: MaterialButton(
                  height: 44.0,
                  color: Color(0xFFFFA685),
                  elevation: 0.0,
                  focusElevation: 0.0,
                  highlightElevation: 0.0,
                  child: Text(sentCode ? '${time}s' : 'Verify Email',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                  onPressed: onTap,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
