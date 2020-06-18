import 'package:Viiddo/blocs/main/main_bloc.dart';
import 'package:flutter/material.dart';

class BottomSelector extends StatelessWidget {
  final Function closeFunction;
  final Function libraryFunction;
  final Function cameraFunction;
  final Function growthFunction;
  final Function vaccinesFunction;
  final MainScreenBloc mainScreenBloc;
  const BottomSelector({
    Key key,
    this.mainScreenBloc,
    this.closeFunction,
    this.libraryFunction,
    this.cameraFunction,
    this.growthFunction,
    this.vaccinesFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String avatar = mainScreenBloc.state.babyModel != null ? mainScreenBloc.state.babyModel.avatar ?? '' : '';
    final makeContent = Container(
      height: 235,
      margin: EdgeInsets.only(bottom: 0, left: 0, right: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                padding: EdgeInsets.all(4),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: avatar != '' ? new NetworkImage(
                      avatar,
                    ): Image.asset('assets/icons/ic_baby_solid.png').image,
                  ),
                ),
              ),
            ],
            alignment: Alignment.center,
          ),
          Divider(
            color: Color(0x808476AB),
            height: 24,
            indent: 32,
            endIndent: 32,
            thickness: 0.5,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 32,
              right: 32,
              top: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  minWidth: 0,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/ic_library.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                          ),
                          Text(
                            'Library',
                            style: TextStyle(
                              color: Color(0xFF8476AB),
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: libraryFunction,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  minWidth: 0,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/ic_camera.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                          ),
                          Text(
                            'Camera',
                            style: TextStyle(
                              color: Color(0xFF8476AB),
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: cameraFunction,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  minWidth: 0,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/ic_growth.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                          ),
                          Text(
                            'Growth',
                            style: TextStyle(
                              color: Color(0xFF8476AB),
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: growthFunction,
                ),
                MaterialButton(
                  padding: EdgeInsets.all(0),
                  minWidth: 0,
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image.asset(
                                'assets/icons/ic_vaccine.png',
                                width: 24,
                                height: 24,
                              ),
                            ],
                            alignment: Alignment.center,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8),
                          ),
                          Text(
                            'Vaccines',
                            style: TextStyle(
                              color: Color(0xFF8476AB),
                              fontSize: 10,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  onPressed: vaccinesFunction,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24),
          ),
          Container(
            height: 28,
            width: 28,
            child: SizedBox.expand(
              child: Material(
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                child: MaterialButton(
                  child: Image.asset('assets/icons/ic_close.png'),
                  onPressed: closeFunction,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final background = Container(
      color: Color(0xFFF8F8F8),
      height: 205,
    );

    final stackView = Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        background,
        makeContent,
      ],
    );

    return stackView;
  }
}
