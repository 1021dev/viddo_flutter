import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/babies/baby_info_screen.dart';
import 'package:Viiddo/screens/home/invite/invitation_code_input_screen.dart';
import 'package:Viiddo/utils/navigation.dart';

class AddBabyScreen extends StatefulWidget {
  final MainScreenBloc bloc;
  AddBabyScreen({
    Key key,
    this.bloc,
  }) : super(key: key);

  @override
  _AddBabyScreenState createState() => _AddBabyScreenState();
}

class _AddBabyScreenState extends State<AddBabyScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<Image> list = [
    Image.asset('assets/icons/add_baby_girl.png'),
    Image.asset('assets/icons/add_baby_boy.png'),
    Image.asset('assets/icons/add_baby_pregnancy.png')
  ];
  @override
  void initState() {
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
              title: Text('Add baby'),
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
    return SafeArea(
      key: formKey,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                'Choose baby gender or pregnancy',
                style: TextStyle(
                  color: Color(0xFF8476AB),
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.symmetric(
                  vertical: 24,
                  horizontal: 20,
                ),
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                childAspectRatio: 5 / 7,
                mainAxisSpacing: 20,
                children: <Widget>[
                  _babyButton(state, 0),
                  _babyButton(state, 1),
                  _babyButton(state, 2),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigation.toScreen(
                    context: context,
                    screen: InvitationCodeInputScreen(
                      bloc: widget.bloc,
                    ),
                  );
                },
                child: Center(
                  child: Text(
                    'Enter invitation code to join a group',
                    style: TextStyle(
                      color: Color(0xFFE46E5C),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _babyButton(MainScreenState state, int index) {
    return GestureDetector(
      child: Container(
        child: SizedBox.expand(
          child: list[index],
        ),
      ),
      onTap: () {
        Navigation.toScreen(
          context: context,
          screen: BabyInfoScreen(
            bloc: widget.bloc,
            index: index,
          ),
        );
      },
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
