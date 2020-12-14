import 'dart:io';

import 'package:Viiddo/blocs/bloc.dart';
import 'package:Viiddo/blocs/post/post_bloc.dart';
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
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/babies/babies_screen.dart';
import 'home/notifications/notifications_screen.dart';


// ignore: must_be_immutable
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
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(
            mainScreenBloc: mainScreenBloc,
          ),
        ),
      ],
      child: BlocBuilder<MainScreenBloc, MainScreenState>(
        bloc: mainScreenBloc,
        builder: (BuildContext context, MainScreenState state) {
          _tabController.index = _selectedIndex;
          String babyAvatar = state.babyAvatar ?? '';
          bool hasUnread = state.unreadMessageModel != null ? state.unreadMessageModel.hasUnread ?? false : false;

          return CupertinoTabScaffold(
              controller: _tabController,
              tabBar: _createTabBar(),
              tabBuilder: (BuildContext context, int index) {
                Widget tabPage;
                switch (index) {
                  case 0:
                    tabPage = HomeScreen(
                      navKey: homeTabNavKey,
                      mainScreenBloc: mainScreenBloc,
                    );
                    break;
                  case 1:
                    tabPage = null;
                    break;
                  case 2:
                    tabPage = ProfileScreen(
                      navKey: profileTabNavKey,
                      mainScreenBloc: mainScreenBloc,
                    );
                    break;
                }
                return new Scaffold(
                  appBar: new AppBar(
                    title: _selectedIndex == 0
                        ? ImageIcon(
                            AssetImage('assets/icons/ic_logo_viiddo.png'),
                            size: 72,
                          )
                        : Text(
                            'Profile',
                            style: TextStyle(color: Color(0xFF7861B7)),
                          ),
                    backgroundColor: Colors.white,
                    automaticallyImplyLeading: false,
                    leading: _selectedIndex == 0
                        ? GestureDetector(
                            child: Center(
                              child: Container(
                                width: babyAvatar.length > 0 ? 30.0 : 24.0,
                                height: babyAvatar.length > 0 ? 30.0 : 24.0,
                                clipBehavior: Clip.antiAlias,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                    fit: BoxFit.cover,
                                    image: babyAvatar != '' ?
                                        FadeInImage.assetNetwork(
                                          placeholder: 'assets/icons/ic_tag_baby.png',
                                          image: babyAvatar,
                                          width: 24,
                                          height: 24,
                                        ).image:
                                          AssetImage('assets/icons/ic_tag_baby.png')
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                SharedPreferences.getInstance()
                                    .then((SharedPreferences sp) {
                                  sharedPreferences = sp;
                                  bool isVerical =
                                      sp.getBool(Constants.IS_VERI_CAL) ?? false;
                                  if (isVerical) {
                                    Navigation.toScreen(
                                        context: context,
                                        screen: BabiesScreen(
                                          bloc: mainScreenBloc,
                                        ));
                                  } else {
                                    WidgetUtils.showErrorDialog(
                                        context, 'Please verify your email first.');
                                  }
                                }
                              );
                            },
                          )
                        : Container(),
                    actions: <Widget>[
                      _selectedIndex == 0
                        ? Stack(
                            alignment: Alignment.center,
                              children: <Widget>[
                                IconButton(
                                icon: ImageIcon(
                                  AssetImage('assets/icons/notifications.png'),
                                  size: 24,
                                ),
                                tooltip: 'Next page',
                                onPressed: () {
                                  Navigation.toScreen(
                                    context: context,
                                    screen: NotificationsScreen(
                                      homeContext: context,
                                    ),
                                  );
                                },
                              ),
                              hasUnread ?
                                Container(
                                  width: 24,
                                  height: 24,
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red,
                                    ),
                                  )
                                ) : Container(),
                            ],
                          )
                        : Container(),
                    ],
                    elevation: 0,
                    textTheme: TextTheme(
                      headline6: TextStyle(
                        color: Color(0xFFFFA685),
                        fontSize: 20.0,
                      ),
                    ),
                    iconTheme: IconThemeData(
                      color: Color(0xFFFFA685),
                    ),
                  ),
                  body: tabPage,

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
                    mainScreenBloc: mainScreenBloc,
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

//    if (image != null) {
//      Navigation.toScreen(
//        context: context,
//        screen: EditPictureScreen(
//          mainScreenBloc: mainScreenBloc,
//          image: File(image.path),
//        ),
//      );
//    }

    if (image != null) {
    await _cropImage(File(image.path));
    }
  }

  Future<Null> _cropImage(File imageFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    //    if (croppedFile != null) {
    //      imageFile = croppedFile;
    //      setState(() {
    //        state = AppState.cropped;
    //      });
    //    }

    if (croppedFile != null) {
      Navigation.toScreen(
        context: context,
        screen: EditPictureScreen(
          mainScreenBloc: mainScreenBloc,
          image: File(croppedFile.path),
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
