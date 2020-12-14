import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../themes.dart';

class ReportProblemScreen extends StatefulWidget {
  MainScreenBloc bloc;

  ReportProblemScreen({
    this.bloc,
  });

  @override
  _ReportProblemScreenState createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController reportController = TextEditingController();
  FocusNode reportFocus = FocusNode();

  @override
  void initState() {
    reportController.text = '';
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
        FocusScope.of(context).requestFocus(reportFocus);
      },
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: Text('Report a Problem'),
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
            resizeToAvoidBottomPadding: false,
            resizeToAvoidBottomInset: false,
            key: scaffoldKey,
            body: _getBody(state),
            backgroundColor: Colors.white,
          );
        },
      ),
    );
  }

  Widget _getBody(MainScreenState state) {
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
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                color: Color(0xFFFFFBF8),
                height: 10,
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 20,
                  top: 16,
                  bottom: 16,
                ),
                child: Text(
                  'Feedback',
                  style: TextStyle(
                    color: Color(0xFF8476AB),
                    fontFamily: 'Roboto',
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                height: 196,
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 16,
                  right: 16,
                ),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    SizedBox.expand(
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        color: Color(0xFFF9F9F9),
                        clipBehavior: Clip.antiAlias,
                        child: TextField(
                          autofocus: true,
                          focusNode: reportFocus,
                          controller: reportController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          maxLength: 200,
                          style: TextStyle(
                            color: Color(0xFF8476AB),
                            fontSize: 14.0,
                            fontFamily: 'Roboto',
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                            hintText: 'Please enter a feeback',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Color(0x998476AB),
                              fontFamily: 'Roboto',
                            ),
                          ),
                          onSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                        ),
                      ),
                    ),
//                    Container(
//                      padding: EdgeInsets.only(
//                        bottom: 8,
//                        right: 8,
//                      ),
//                      child: Text(
//                        '0/200',
//                        style: TextStyle(
//                          color: Color(0x998476AB),
//                          fontFamily: 'Roboto',
//                          fontSize: 10,
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 20,
                  top: 16,
                  bottom: 16,
                ),
                child: Text(
                  'Upload Image (0/4)',
                  style: TextStyle(
                    color: Color(0xFF8476AB),
                    fontFamily: 'Roboto',
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 20,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      Image.asset('assets/icons/report_add_picture.png'),
                      Container(), //Image.asset('assets/icons/report_add_picture.png'),
                      Container(), //Image.asset('assets/icons/report_add_picture.png'),
                      Container(), //Image.asset('assets/icons/report_add_picture.png'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      height: 100,
                      padding: EdgeInsets.only(
                        left: 45,
                        right: 45,
                        bottom: 56,
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
                            child: Text('Send',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                )),
                            onPressed: () {},
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    reportFocus.dispose();
    super.dispose();
  }
}
