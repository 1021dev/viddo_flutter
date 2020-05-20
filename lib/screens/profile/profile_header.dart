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
                    width: 60,
                  ),
                  Image.asset(
                    'assets/icons/2.0x/icon_place_holder.png',
                    fit: BoxFit.cover,
                    width: 54,
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
                        fontSize: 17,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal,
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
                        fontSize: 12,
                        color: Color(0xFF9C9C9C),
                        fontWeight: FontWeight.normal,
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
                color: Color(0xFFC8C8C8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
