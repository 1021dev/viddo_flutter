import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes.dart';

class InvitationCodeInputScreen extends StatefulWidget {
  final MainScreenBloc bloc;

  InvitationCodeInputScreen({
    this.bloc,
  });

  @override
  _InvitationCodeInputScreenState createState() =>
      _InvitationCodeInputScreenState();
}

class _InvitationCodeInputScreenState extends State<InvitationCodeInputScreen>
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
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, MainScreenState state) async {
        FocusScope.of(context).requestFocus(nameFocus);
      },
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              textTheme: TextTheme(
                headline6: TextStyle(
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
            body: _getBody(state),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
    if (state.isLoading) {
      return WidgetUtils.loadingView();
    } else {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: SafeArea(
          key: formKey,
          child: Container(
            padding: EdgeInsets.only(left: 45, right: 45, top: 16, bottom: 16),
            child: Column(
              children: <Widget>[
                Container(
                  height: 64,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                  ),
                  child: Text(
                    'Invitation',
                    style: TextStyle(
                      color: Color(0xFF8476AB),
                      fontSize: 30,
                      fontFamily: 'Roboto-Bold',
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: nameController,
                          focusNode: nameFocus,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            color: Color(0xFF8476AB),
                            fontSize: 16,
                          ),
                          maxLength: 6,
                          decoration: InputDecoration(
                            hintText: 'Invitation Code',
                            hintStyle: TextStyle(
                              color: Color(0x998476AB),
                              fontSize: 16,
                            ),
                            counterText: '',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0x2F8476AB),
                                  style: BorderStyle.solid),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 16),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Invitation code are 6 digits numbers',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color(0xFF8476AB),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 44),
                        ),
                        Container(
                          height: 44,
                          child: SizedBox.expand(
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              color: lightTheme.accentColor,
                              clipBehavior: Clip.antiAlias,
                              child: MaterialButton(
                                height: 44.0,
                                color: lightTheme.accentColor,
                                child: Text('Next',
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
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _relationshipButton(int type, bool isSelected) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: <Widget>[
            Image.asset(
              'assets/icons/add_baby_select_normal.png',
              width: 8,
              height: 8,
              color: isSelected ? Color(0xFFFFA685) : Color(0xFF8476AB),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
            ),
            Text(
              type == 0 ? 'Father' : 'Mother',
              style: TextStyle(
                color: isSelected ? Color(0xFFFFA685) : Color(0xFF8476AB),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }

  Future<Null> _handleRefresh(context) {
    Completer<Null> completer = new Completer<Null>();
    return completer.future;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
