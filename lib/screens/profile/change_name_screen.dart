import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/profile/edit_profile_setting_tile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../themes.dart';
import '../../utils/widget_utils.dart';

class ChangeNameScreen extends StatefulWidget {
  MainScreenBloc bloc;

  ChangeNameScreen({
    this.bloc,
  });

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
            body: _getBody(state),
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
    if (state.isLoading) {
      return WidgetUtils.loadingView();
    } else {
      return SafeArea(
        key: formKey,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Color(0xFFF0F0F0),
                height: 10,
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
              Container(
                color: Color(0xFFF0F0F0),
                height: 200,
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
                    elevation: 4.0,
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
  }

  @override
  void dispose() {
    nameFocus.dispose();
    super.dispose();
  }
}
