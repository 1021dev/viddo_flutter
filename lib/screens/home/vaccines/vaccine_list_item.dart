import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VaccineListItem extends StatelessWidget {
  final Function function;
  final int index;
  const VaccineListItem({
    Key key,
    this.function,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final makeListTile = ListTile(
      subtitle: Container(
        child: RichText(
          text: TextSpan(
            text: '2 months of age',
            style: TextStyle(
              color: Color(0x997861B7),
              fontFamily: 'Roboto',
              fontSize: 10,
            ),
          ),
        ),
      ),
      trailing: SizedBox(
        width: 38,
        height: 38,
        child: MaterialButton(
          height: 24,
          onPressed: () {},
          child: Text('Not Given'),
        ),
      ),
      title: RichText(
        text: TextSpan(
          text: 'HepB (1st does)',
          style: TextStyle(
            color: Color(0xFFE46E5C),
            fontFamily: 'Roboto',
            fontSize: 12,
          ),
        ),
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
        left: 20,
        right: 20,
      ),
      child: stackView,
    );
    ;
  }
}
