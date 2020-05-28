import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BabiesItemTile extends StatelessWidget {
  final Function function;
  final int index;
  const BabiesItemTile({
    Key key,
    this.function,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
      leading: Container(
        width: 45,
        height: 45,
        child: Image.asset('assets/icons/default_boy.png'),
      ),
      title: Text(
        'Lean',
        style: TextStyle(
          color: Color(0xFFFFA685),
          fontSize: 12,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          Text(
            'Birthdate: ',
            style: TextStyle(
              color: Color(0xFF8476AB),
              fontSize: 11,
            ),
          ),
          Text(
            '07/15/2013',
            style: TextStyle(
              color: Color(0xFF8476AB),
              fontSize: 11,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Container(
              alignment: Alignment.center,
              height: 12,
              width: 58,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFFFFA685),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                '1 Month',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                ),
              ),
            ),
          ),
        ],
      ),
      trailing: Image.asset(
        'assets/icons/ic_right_arrow.png',
        width: 16,
        height: 16,
        color: Color(0xFFFFA685),
      ),
    );

    final inkWell = Positioned.fill(
      child: new Material(
        color: Colors.transparent,
        child: new InkWell(
          onTap: function,
          splashColor: Color(0xFFFFF5EF),
          highlightColor: Color(0xFFFFF5EF),
          hoverColor: Color(0xFFFFF5EF),
          focusColor: Color(0xFFFFF5EF),
          child: makeListTile,
        ),
      ),
    );

    return inkWell;
  }
}
