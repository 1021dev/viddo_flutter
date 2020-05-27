import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BabyItemTile extends StatelessWidget {
  final String title;
  final String value;
  final Image image;
  final bool ison;
  final Function function;

  const BabyItemTile({
    Key key,
    this.title,
    this.value,
    this.image,
    this.ison = false,
    this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
      contentPadding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
      ),
      leading: image,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          color: Color(0xFFFFA685),
          fontFamily: 'Roboto',
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          Text(
            'BirthDate:',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF8476AB),
              fontFamily: 'Roboto',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 2),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF8476AB),
              fontFamily: 'Roboto',
            ),
          ),
        ],
      ),
      trailing: CupertinoSwitch(
        value: ison,
        onChanged: function,
        activeColor: Color(0xFFFFA685),
        dragStartBehavior: DragStartBehavior.start,
      ),
    );

    return makeListTile;
  }
}
