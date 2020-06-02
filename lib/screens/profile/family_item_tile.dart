import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FamilyItemTile extends StatelessWidget {
  final String title;
  final String value;
  final Image image;
  final double height;
  final Function function;

  const FamilyItemTile({
    Key key,
    this.title,
    this.value,
    this.image,
    this.height,
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
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 10,
          color: Color(0xFFC4C4C4),
          fontFamily: 'Roboto',
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Color(0xFFFFA685),
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
