import 'package:Viiddo/models/profile_setting_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GrowthRecordItem extends StatelessWidget {
  final Function function;
  final int index;
  const GrowthRecordItem({
    Key key,
    this.function,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final makeListTile = Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 12,
              top: 20,
              bottom: 16,
              right: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '05/22/2019',
                  style: TextStyle(
                    color: Color(0xFFE46E5C),
                    fontSize: 14,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                ),
                Text(
                  '3 days',
                  style: TextStyle(
                    color: Color(0x998476AB),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0x998476AB),
            height: 0,
            thickness: 0.5,
            indent: 12,
            endIndent: 12,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12,
              top: 16,
              bottom: 20,
              right: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Height',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                    ),
                    Text(
                      '58.00',
                      style: TextStyle(
                        color: Color(0xFFFFA685),
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                    ),
                    Text(
                      'in',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Weight',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                    ),
                    Text(
                      '68.00',
                      style: TextStyle(
                        color: Color(0xFFFFA685),
                        fontSize: 24,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                    ),
                    Text(
                      'lbs',
                      style: TextStyle(
                        color: Color(0xFF8476AB),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
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
      alignment: Alignment.center,
      children: <Widget>[
        makeListTile,
        inkWell,
      ],
    );

    return Padding(
      padding: EdgeInsets.only(
        top: 8,
        bottom: 8,
        left: 20,
        right: 20,
      ),
      child: stackView,
    );
  }
}
