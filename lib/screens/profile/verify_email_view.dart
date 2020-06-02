import 'package:flutter/material.dart';

import '../../themes.dart';
import '../../themes.dart';

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
                    'assets/icons/mine_houlder.png',
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
              height: 50,
              child: SizedBox.expand(
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  elevation: 4.0,
                  color: lightTheme.accentColor,
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    height: 46.0,
                    color: lightTheme.accentColor,
                    child: Text(sentCode ? '${time}s' : 'Verify Email',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                    onPressed: onTap,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
