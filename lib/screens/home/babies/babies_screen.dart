import 'dart:async';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/screens/home/babies/add_baby_screen.dart';
import 'package:Viiddo/screens/home/babies/babies_item_tile.dart';
import 'package:Viiddo/screens/home/baby_details.dart';
import 'package:Viiddo/screens/home/invite/invitation_code_input_screen.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BabiesScreen extends StatefulWidget {
  final MainScreenBloc bloc;

  BabiesScreen({
    this.bloc,
  });

  @override
  _BabiesScreenState createState() => _BabiesScreenState();
}

class _BabiesScreenState extends State<BabiesScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.bloc.state.babyListModel == null) {
      widget.bloc.add(GetBabyListModel(0));
    }
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.bloc,
      listener: (BuildContext context, MainScreenState state) async {},
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: widget.bloc,
        builder: (BuildContext context, state) {
          return Scaffold(
            appBar: new AppBar(
              title: Text(
                'Babies',
                style: TextStyle(
                  color: Color(0xFF7861B7),
                  fontSize: 18,
                ),
              ),
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
    List<BabyModel> babyListModel = state.babyListModel != null ? state.babyListModel.content : [];
    return SafeArea(
        key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 90,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 36,
                    right: 36,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigation.toScreen(
                            context: context,
                            screen: AddBabyScreen(bloc: widget.bloc,),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/baby_list_add.png',
                              width: 45,
                              height: 45,
                              color: Color(0xFFFFA685),
                            ),
                            Text(
                              'Add Baby',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigation.toScreen(
                            context: context,
                            screen: InvitationCodeInputScreen(bloc: widget.bloc,),
                          );
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/invitation_code.png',
                              width: 45,
                              height: 45,
                              color: Color(0xFFFFA685),
                            ),
                            Text(
                              'Enter Invitation Code',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              'assets/icons/scan_qr.png',
                              width: 45,
                              height: 45,
                              color: Color(0xFFFFA685),
                            ),
                            Text(
                              'Scan',
                              style: TextStyle(
                                color: Color(0xFF8476AB),
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: babyListModel.length,
                  shrinkWrap: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    print(state.babyId);
                    return BabiesItemTile(
                      model: babyListModel[index],
                      isSelected: babyListModel[index].objectId == state.babyId,
                      function: () {
                        widget.bloc.add(SelectBabyEvent(babyListModel[index]));
                        Navigation.toScreen(
                          context: context,
                          screen: BabyDetailsScreen(
                            screenBloc: widget.bloc,
                            babyModel: babyListModel[index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
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
