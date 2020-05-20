import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileSettingTile extends StatelessWidget {
  final ProfileSettingModel model;

  const ProfileSettingTile({
    Key key,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: model.icon,
      title: Text(
        model.title,
        style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
        ),
      ),
    );

    final inkWell = Positioned.fill(
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
          onTap: model.function,
        ),
      ),
    );

    final stackView = Stack(
      children: <Widget>[
        makeListTile,
        inkWell,
      ],
    );

    return stackView;
  }
}
