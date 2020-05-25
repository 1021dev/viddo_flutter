import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileHeaderView extends StatelessWidget {
  final Function onTap;

  const ProfileHeaderView({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: 80,
        child: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Image.asset(
                    'assets/icons/2.0x/user_icon_bg.png',
                    fit: BoxFit.cover,
                    width: 40,
                  ),
                  Image.asset(
                    'assets/icons/2.0x/icon_place_holder.png',
                    fit: BoxFit.cover,
                    width: 40,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Test',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFE46E5C),
                        fontFamily: 'Roboto',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 4,
                      ),
                    ),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0x998476AB),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
              ),
              ImageIcon(
                AssetImage('assets/icons/2.0x/publish_right.png'),
                size: 13,
                color: Color(0xFFFFA685),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
