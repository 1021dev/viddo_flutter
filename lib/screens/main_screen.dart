import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/screens/home/growth/growth_screen.dart';
import 'package:Viiddo/screens/home/home_screen.dart';
import 'package:Viiddo/screens/home/post/edit_picture_screen.dart';
import 'package:Viiddo/screens/home/vaccines/vaccines_screen.dart';
import 'package:Viiddo/screens/profile/profile_screen.dart';
import 'package:Viiddo/screens/profile/welcome_view.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:Viiddo/utils/navigation.dart';
import 'package:Viiddo/utils/widget_utils.dart';
import 'package:Viiddo/widgets/bottom_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';



@FFRoute(
  name: 'viiddo://mainpage',
  routeName: 'MainPage',
)

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
  // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  MainScreenBloc mainScreenBloc = MainScreenBloc();
  int _selectedIndex = 0;
  int _previousIndex = 0;
  int loginDate = 0;
  SharedPreferences sharedPreferences;
  final PageStorageBucket bucket = PageStorageBucket();

  final GlobalKey<NavigatorState> homeTabNavKey = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> profileTabNavKey = GlobalKey<NavigatorState>();
  final CupertinoTabController _tabController = CupertinoTabController();
  Widget _pretabPage;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    _selectedIndex = widget.selectedPage;
    // tabController = TabController(length: 2, vsync: this);

    SharedPreferences.getInstance().then((SharedPreferences sp) {
      sharedPreferences = sp;
      bool isShowWelcome = sp.getBool(Constants.SHOW_WELCOME) ?? false;
      if (isShowWelcome) {
        sharedPreferences.setBool(Constants.SHOW_WELCOME, false);
        showWelcome();
      }
    });

    mainScreenBloc.add(MainScreenInitEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MainScreenBloc>(
          create: (context) => mainScreenBloc,
        ),
        BlocProvider<NotificationScreenBloc>(
          create: (context) => NotificationScreenBloc(
            mainScreenBloc: mainScreenBloc,
          ),
        ),
        BlocProvider<HomeScreenBloc>(
          create: (context) => HomeScreenBloc(
            mainScreenBloc: mainScreenBloc,
          ),
        ),
        BlocProvider<ProfileScreenBloc>(
          create: (context) => ProfileScreenBloc(
            mainScreenBloc: mainScreenBloc,
          ),
        ),
        BlocProvider<BabyScreenBloc>(
          create: (context) => BabyScreenBloc(
            mainScreenBloc: mainScreenBloc,
          ),
        ),
      ],
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: mainScreenBloc,
        builder: (BuildContext context, MainScreenState state) {
          _tabController.index = _selectedIndex;
          return CupertinoTabScaffold(
              controller: _tabController,
              tabBar: _createTabBar(),
              tabBuilder: (BuildContext context, int index) {
                Widget tabPage;
                switch (index) {
                  case 0:
                    tabPage = HomeScreen(
                      navKey: homeTabNavKey,
                      homeContext: context,
                    );
                    _pretabPage = tabPage;
                    break;
                  case 1:
                    tabPage = null;
                    break;
                  case 2:
                    tabPage = ProfileScreen(
                      navKey: profileTabNavKey,
                      homeContext: context,
                    );
                    _pretabPage = tabPage;
                    break;
                }
                return Material(
                  type: MaterialType.transparency,
                  child: tabPage,
                );
              },
          );
        },
      ),
    );
  }
  GlobalKey<NavigatorState> _currentNavigatorKey() {
    switch (_tabController.index) {
      case 0:
        return homeTabNavKey;
        break;

      case 2:
        return profileTabNavKey;
        break;
    }
    return null;
  }

  CupertinoTabBar _createTabBar() {
    return CupertinoTabBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/tab_home_off.png'),
              color: Color(0xFFFFA685),
              size: 24,
            ),
            activeIcon: ImageIcon(
              AssetImage('assets/icons/tab_home_on.png'),
              color: Color(0xFFFFA685),
            size: 24,
            ),
          ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/tab_add_off.png"),
            color: Color(0xFFFFA685),
            size: 24,
          ),
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(
            AssetImage("assets/icons/tab_profile_off.png"),
            color: Color(0xFFFFA685),
            size: 24,
          ),
          activeIcon: ImageIcon(
            AssetImage("assets/icons/tab_profile_on.png"),
            color: Color(0xFFFFA685),
            size: 24,
          ),
        ),
      ],
      onTap: (index) {
        _onItemTapped(index);
      },
    );
  }

  void _onItemTapped(int index) {
    if (index != 1) {
      if (index == 0) {
            mainScreenBloc.add(MainScreenInitEvent());
      }
      setState(() {
        _selectedIndex = index;
        _previousIndex = index;
      });
    } else {
      setState(() {
        _selectedIndex = _previousIndex;
        _tabController.index = _selectedIndex;
      });
      SharedPreferences.getInstance().then(
        (SharedPreferences sp) {
          sharedPreferences = sp;
          bool isVerical = sp.getBool(Constants.IS_VERI_CAL) ?? false;
          if (isVerical) {
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
                  position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
                      .animate(anim1),
                  child: child,
                );
              },
            );
          } else {
            WidgetUtils.showErrorDialog(
                context, 'Please verify your email first.');
          }
        },
      );
    }
  }

  Future getImage(int type) async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.getImage(
      source: type == 0 ? ImageSource.gallery : ImageSource.camera,
    );

    if (image != null) {
      Navigation.toScreen(
        context: context,
        screen: EditPictureScreen(
          bloc: mainScreenBloc,
          image: File(image.path),
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
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WelcomeView(
          onTapSkip: () {
            Navigator.pop(context);
          },
          onTapWatchVideo: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
