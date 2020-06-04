import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../themes.dart';

class ChangeNameScreen extends StatefulWidget {
  ChangeNameScreen();

  @override
  _ChangeNameScreenState createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  FocusNode nameFocus = FocusNode();

  @override
  void initState() {
    nameController.text = '';
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Change name'),
        backgroundColor: Colors.white,
        elevation: 0,
        textTheme: TextTheme(
          title: TextStyle(
            color: Color(0xFF7861B7),
            fontSize: 18.0,
            fontFamily: 'Roboto',
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFFFA685),
          size: 12,
        ),
      ),
      key: scaffoldKey,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return SafeArea(
      key: formKey,
      child: Container(
        color: Color(0xFFFFFBF8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              height: 50,
              color: Colors.white,
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: TextField(
                autofocus: true,
                focusNode: nameFocus,
                controller: nameController,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                  color: Color(0xFF203152),
                  fontSize: 16.0,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Please enter your name',
                ),
                keyboardType: TextInputType.text,
                onSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200),
            ),
            Container(
              height: 44,
              padding: EdgeInsets.only(
                left: 45,
                right: 45,
              ),
              child: SizedBox.expand(
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  elevation: 0.0,
                  color: lightTheme.accentColor,
                  clipBehavior: Clip.antiAlias,
                  child: MaterialButton(
                    height: 44.0,
                    color: lightTheme.accentColor,
                    child: Text('Save',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        )),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameFocus.dispose();
    super.dispose();
  }
}
