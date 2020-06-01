import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileSettingTile extends StatelessWidget {
  final String title;
  final String value;
  final Image image;
  final double height;
  Color color;
  final Function function;

  EditProfileSettingTile({
    Key key,
    this.title,
    this.value,
    this.image,
    this.height,
    this.function,
    this.color = const Color(0x808476AB),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final makeListTile = Container(
        padding: EdgeInsets.only(
          left: 16.0,
          right: 16.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF8476AB),
                fontFamily: 'Roboto',
              ),
            ),
            Row(
              children: <Widget>[
                image != null
                    ? image
                    : Text(
                        value,
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontFamily: 'Roboto',
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Color(0xFFFFA685),
                ),
              ],
            ),
          ],
        ));

    final inkWell = Positioned.fill(
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
          onTap: function,
        ),
      ),
    );

    final stackView = Stack(
      children: <Widget>[
        height != null
            ? Container(
                child: makeListTile,
                height: height,
                alignment: Alignment.centerLeft,
              )
            : makeListTile,
        inkWell,
      ],
    );

    return stackView;
  }
}
