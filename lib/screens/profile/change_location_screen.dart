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

class ChangeLocationScreen extends StatefulWidget {
  MainScreenBloc bloc;

  ChangeLocationScreen({
    this.bloc,
  });

  @override
  _ChangeLocationScreenState createState() => _ChangeLocationScreenState();
}

class _ChangeLocationScreenState extends State<ChangeLocationScreen>
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
              title: Text('Change address'),
              backgroundColor: Colors.white,
              elevation: 0,
              textTheme: TextTheme(
                title: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.black,
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
                    hintText: 'Please enter address',
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
                height: 50,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: SizedBox.expand(
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0)),
                    elevation: 4.0,
                    color: lightTheme.accentColor,
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      height: 46.0,
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
