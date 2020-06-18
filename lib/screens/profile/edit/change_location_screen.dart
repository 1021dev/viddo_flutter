import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../../../themes.dart';
import '../../../utils/widget_utils.dart';

class ChangeLocationScreen extends StatefulWidget {
  ProfileScreenBloc bloc;

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
  final TextEditingController locationController = TextEditingController();
  FocusNode locationFocus = FocusNode();

  @override
  void initState() {
    locationController.text = widget.bloc.state.location;
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, ProfileScreenState state) async {
        if (state is UpdateProfileSuccess) {
          Navigator.of(context).pop();
        } else if (state is ProfileScreenFailure) {
          WidgetUtils.showErrorDialog(context, state.error);
        }
      },
      child: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return ModalProgressHUD(
            child: Scaffold(
              appBar: new AppBar(
                title: Text('Change address'),
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
            ),
            inAsyncCall: state.isLoading,
            dismissible: false,
            color: Colors.black,
          );
        },
      ),
    );
  }

  Widget _getBody(ProfileScreenState state) {
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
                focusNode: locationFocus,
                controller: locationController,
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
                    onPressed: () {
                      if (locationController.text.isEmpty) {
                        WidgetUtils.showErrorDialog(
                            context, 'Area cannot be empty');
                        return;
                      }
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      widget.bloc.add(
                        UpdateUserProfile(
                          {'area': locationController.text},
                        ),
                      );
                    },
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
    locationFocus.dispose();
    super.dispose();
  }
}
