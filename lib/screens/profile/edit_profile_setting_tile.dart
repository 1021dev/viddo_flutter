import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditProfileSettingTile extends StatelessWidget {
  final String title;
  final String value;
  final Image image;
  final double height;
  final Function function;

  const EditProfileSettingTile({
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
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      trailing: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 16,
          minHeight: 16,
          maxWidth: 16,
          maxHeight: 16,
        ),
        child: Icon(
          Icons.arrow_forward_ios,
          size: 12,
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          image != null
              ? image
              : Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
        ],
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
              )
            : makeListTile,
        inkWell,
      ],
    );

    return stackView;
  }
}
