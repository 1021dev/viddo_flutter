import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/main.dart';
import 'package:Viiddo/screens/home/babies/babies_screen.dart';
import 'package:Viiddo/screens/home/growth/growth_screen.dart';
import 'package:Viiddo/screens/home/home_screen.dart';
import 'package:Viiddo/screens/home/notifications/notifications_screen.dart';
import 'package:Viiddo/screens/home/post/edit_picture_screen.dart';
import 'package:Viiddo/screens/home/vaccines/vaccines_screen.dart';
import 'package:Viiddo/screens/profile/profile_screen.dart';
import 'package:Viiddo/screens/profile/welcome_view.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/widgets/bottom_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes.dart';

class OverflowMenuItem {
  final String title;
  final Color textColor;
  final VoidCallback onTap;

  OverflowMenuItem({
    this.title,
    this.textColor = Colors.black,
    this.onTap,
  });
}

class MainScreen extends StatefulWidget {
  int selectedPage;

  MainScreen({
    this.selectedPage = 0,
  });
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  MainScreenBloc mainScreenBloc = MainScreenBloc();
  TabController tabController;
  int _selectedIndex = 0;
  List<Widget> tabs = [];
  List<String> titles = ['Home', '', 'Profile'];
  int loginDate = 0;
  SharedPreferences sharedPreferences;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _selectedIndex = widget.selectedPage;
    tabController = TabController(length: 2, vsync: this);

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      bool isShowWelcome = sp.getBool(Constants.SHOWWELCOME) ?? false;
      if (!isShowWelcome) {
        sharedPreferences.setBool(Constants.SHOWWELCOME, false);
        showWelcome();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: mainScreenBloc,
      listener: (BuildContext context, MainScreenState state) async {},
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: mainScreenBloc,
        builder: (BuildContext context, state) {
          tabs = [
            HomeScreen(
              bloc: mainScreenBloc,
            ),
            Container(),
            ProfileScreen(),
          ];
          return DefaultTabController(
            length: 2,
            child: new Scaffold(
              appBar: new AppBar(
                title: _selectedIndex == 0
                    ? ImageIcon(
                        AssetImage('assets/icons/home_top_image.png'),
                        size: 72,
                      )
                    : Text(
                        titles[_selectedIndex],
                        style: TextStyle(color: Color(0xFF7861B7)),
                      ),
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                leading: _selectedIndex == 0
                    ? IconButton(
                        icon: ImageIcon(
                          AssetImage('assets/icons/tag_baby.png'),
                          size: 24,
                        ),
                        tooltip: 'Next page',
                        onPressed: () {
                          Navigation.toScreen(
                              context: context,
                              screen: BabiesScreen(
                                bloc: mainScreenBloc,
                              ));
                        },
                      )
                    : Container(),
                actions: <Widget>[
                  _selectedIndex == 0
                      ? IconButton(
                          icon: ImageIcon(
                            AssetImage('assets/icons/notifications.png'),
                            size: 24,
                          ),
                          tooltip: 'Next page',
                          onPressed: () {
                            Navigation.toScreen(
                              context: context,
                              screen: NotificationsScreen(
                                bloc: mainScreenBloc,
                              ),
                            );
                          },
                        )
                      : Container(),
                ],
                elevation: 0,
                textTheme: TextTheme(
                  title: TextStyle(
                    color: Color(0xFFFFA685),
                    fontSize: 20.0,
                  ),
                ),
                iconTheme: IconThemeData(
                  color: Color(0xFFFFA685),
                ),
              ),
              body: Center(
                child: tabs[_selectedIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                showSelectedLabels: false, // <-- HERE
                showUnselectedLabels: false, // <-- AND HERE
                items: [
                  BottomNavigationBarItem(
                      icon: ImageIcon(
                        AssetImage('assets/icons/tab_home_off.png'),
                        color: Color(0xFFFFA685),
                      ),
                      activeIcon: ImageIcon(
                        AssetImage('assets/icons/tab_home_on.png'),
                        color: Color(0xFFFFA685),
                      ),
                      title: Text('Home')),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icons/tab_add_off.png"),
                      color: Color(0xFFFFA685),
                    ),
                    title: Text('Profile'),
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage("assets/icons/tab_profile_off.png"),
                      color: Color(0xFFFFA685),
                    ),
                    activeIcon: ImageIcon(
                      AssetImage("assets/icons/tab_profile_on.png"),
                      color: Color(0xFFFFA685),
                    ),
                    title: Text('Profile'),
                  ),
                ],
                currentIndex: _selectedIndex,
                backgroundColor: lightTheme.primaryColor,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                onTap: (index) {
                  _onItemTapped(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index != 1) {
      setState(() {
        _selectedIndex = index;
      });
    } else {
      showGeneralDialog(
        barrierLabel: "Label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 235),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: BottomSelector(
              closeFunction: () {
                Navigator.pop(context, 'close');
              },
              libraryFunction: () {
                Navigator.pop(context, 'library');
                getImage(0);
              },
              cameraFunction: () {
                Navigator.pop(context, 'camera');
                getImage(1);
              },
              growthFunction: () {
                Navigator.pop(context, 'growth');
                Navigation.toScreen(
                  context: context,
                  screen: GrowthScreen(
                    bloc: mainScreenBloc,
                  ),
                );
              },
              vaccinesFunction: () {
                Navigator.pop(context, 'vaccines');
                Navigation.toScreen(
                  context: context,
                  screen: VaccinesScreen(
                    bloc: mainScreenBloc,
                  ),
                );
              },
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
                Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        },
      );
    }
  }

  Future getImage(int type) async {
    var image = await ImagePicker.pickImage(
      source: type == 0 ? ImageSource.gallery : ImageSource.camera,
    );

    if (image != null) {
      Navigation.toScreen(
        context: context,
        screen: EditPictureScreen(
          bloc: mainScreenBloc,
          image: image,
        ),
      );
    }
  }

  @override
  void dispose() {
    mainScreenBloc.close();
    super.dispose();
  }

  void showWelcome() {
    showDialog(
      context: context,
      builder: (context) {
        return WelcomeView(
          onTapSkip: () {},
          onTapWatchVideo: () {},
        );
      },
    );
  }
}
