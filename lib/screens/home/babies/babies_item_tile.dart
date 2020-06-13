import 'package:Viiddo/models/baby_model.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BabiesItemTile extends StatelessWidget {
  final Function function;
  final BabyModel model;
  final isSelected;
  const BabiesItemTile({
    Key key,
    this.function,
    this.model,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String name = model.name ?? '';
    String avatar = model.avatar ?? '';
    String defaultImage = (model.gender ?? '') == '' ? 'assets/icons/default_unisex.png' :
                            (model.gender == 'M' ? 'assets/icons/default_boy.png':
                            'assets/icons/default_girl.png');
    int birthDay = model.birthDay ?? 0;
    String ageString = '';
    int age = -1;
    double diff = -1;
    String birthString = '';
    if (birthDay != 0) {
      DateTime now = DateTime.now();
      DateTime birth = DateTime.fromMillisecondsSinceEpoch(birthDay);
      age = now.year - birth.year;
      diff = now.difference(birth).inDays / 30;
      birthString = formatDate(
                      birth,
                      [m, '/', dd, '/', yyyy],
                    );
      if (age > 1) {
        ageString = '$age Years';
      } else if (age == 1) {
        ageString = '1 Year';
      } else {
        if (diff.toInt() > 1) {
          ageString = '${diff.toInt()} Months';
        } else if (diff.toInt() == 1) {
          ageString = '1 Month';
        }
      }
    }

    final makeListTile = ListTile(
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: avatar != '' ?
                FadeInImage.assetNetwork(
                  placeholder: defaultImage,
                  image: avatar,
                ).image : AssetImage(defaultImage)
          ),
        ),
      ),
      title: Row(
        children:<Widget>[
          Text(
            name,
            style: TextStyle(
              color: Color(0xFFFFA685),
              fontSize: 12,
            ),
          ),
          birthDay == 0 ? Image.asset('assets/icons/baby_indicator.png'): Container(),
        ],
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
            birthString,
            style: TextStyle(
              color: Color(0xFF8476AB),
              fontSize: 11,
            ),
          ),
          ageString != '' ? Padding(
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
                ageString,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                ) ,
              ),
            ),
          ): Container(),
        ],
      ),
      trailing: Image.asset(
        'assets/icons/ic_right_arrow.png',
        width: 16,
        height: 16,
        color: Color(0xFFFFA685),
      ),
    );

    final inkWell = new InkWell(
          onTap: function,
          splashColor: Color(0xFFFFF5EF),
          highlightColor: Color(0xFFFFF5EF),
          hoverColor: Color(0xFFFFF5EF),
          focusColor: Color(0xFFFFF5EF),
          child: Container(
            child: makeListTile,
            color: isSelected ? Color(0xFFFFF5EF): Colors.white,
          ),
    );

    return inkWell;
  }
}
