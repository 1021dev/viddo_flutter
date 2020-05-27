import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/main.dart';
import 'package:Viiddo/screens/home/babies_screen.dart';
import 'package:Viiddo/screens/home/home_screen.dart';
import 'package:Viiddo/screens/home/notifications_screen.dart';
import 'package:Viiddo/screens/profile/profile_screen.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
    tabController = TabController(length: 2, vsync: this);
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
            ProfileScreen(
              bloc: mainScreenBloc,
            ),
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    mainScreenBloc.close();
    super.dispose();
  }
}
