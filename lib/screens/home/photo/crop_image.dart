import 'dart:io';

import 'package:Viiddo/screens/home/photo/pic_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CropImage extends StatelessWidget {
  const CropImage({
    @required this.index,
    @required this.albumn,
    @required this.list,
    this.isVideo,
  });
  final List<String> albumn;
  final List<String> list;
  final bool isVideo;
  final int index;
  @override
  Widget build(BuildContext context) {
    if (albumn.length == 0) {
      return Container();
    }
    final String imageItem = albumn[index];

    return ExtendedImage.network(
      imageItem,
        clearMemoryCacheWhenDispose: true,
        loadStateChanged: (ExtendedImageState state) {
      Widget widget;
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          widget = Container(
            color: Colors.grey,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
          break;
        case LoadState.completed:
          state.returnLoadStateChangedWidget = true;
          widget = Hero(
              tag: imageItem,
              child: ExtendedRawImage(image: state.extendedImageInfo.image, fit: BoxFit.cover),);

          break;
        case LoadState.failed:
          widget = GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  'assets/failed.jpg',
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Text(
                    'load image failed, click to reload',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
          break;
      }
      if (index == 6 && albumn.length > 6) {
        widget = Stack(
          children: <Widget>[
            widget,
            Container(
              color: Colors.grey.withOpacity(0.2),
              alignment: Alignment.center,
              child: Text(
                '+${albumn.length - 6}',
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            )
          ],
        );
      }

      widget = GestureDetector(
        child: widget,
        onTap: () {
          final page = PicSwiper(index: index, pics: albumn);
          Navigator.of(context).push(
            PageRouteBuilder(
              opaque: false,fullscreenDialog:false,
              pageBuilder: (_, __, ___) => page,
            ),
          );
          // Navigator.pushNamed(context, 'viiddo://picswiper',
          //     arguments: <String, dynamic>{
          //       'index': index,
          //       'pics': albumn,
          //       'list': list,
          //     });
        },
      );

      return widget;
      }
    );
  }

}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute(this.child);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black;
  @override
  bool get opaque => false;

  @override
  String get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}

class FFNavigatorObserver extends NavigatorObserver {
  FFNavigatorObserver({this.routeChange});

  final RouteChange routeChange;

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    _didRouteChange(previousRoute, route);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    _didRouteChange(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didRemove(route, previousRoute);
    _didRouteChange(previousRoute, route);
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _didRouteChange(newRoute, oldRoute);
  }

  void _didRouteChange(Route<dynamic> newRoute, Route<dynamic> oldRoute) {
    // oldRoute may be null when route first time enter.
    routeChange?.call(newRoute, oldRoute);
  }
}

typedef RouteChange = void Function(
    Route<dynamic> newRoute, Route<dynamic> oldRoute);

class FFTransparentPageRoute<T> extends PageRouteBuilder<T> {
  FFTransparentPageRoute({
    RouteSettings settings,
    @required RoutePageBuilder pageBuilder,
    RouteTransitionsBuilder transitionsBuilder = _defaultTransitionsBuilder,
    Duration transitionDuration = const Duration(milliseconds: 300),
    bool barrierDismissible = false,
    Color barrierColor,
    String barrierLabel,
    bool maintainState = true,
  })  : assert(pageBuilder != null),
        assert(transitionsBuilder != null),
        assert(barrierDismissible != null),
        assert(maintainState != null),
        super(
          settings: settings,
          opaque: false,
          pageBuilder: pageBuilder,
          transitionsBuilder: transitionsBuilder,
          transitionDuration: transitionDuration,
          barrierDismissible: barrierDismissible,
          barrierColor: barrierColor,
          barrierLabel: barrierLabel,
          maintainState: maintainState,
        );
}

Widget _defaultTransitionsBuilder(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return child;
}

Route<dynamic> onGenerateRouteHelper(
  RouteSettings settings, {
  Widget notFoundFallback,
  Object arguments,
}) {
  arguments ??= settings.arguments;

  final RouteResult routeResult = getRouteResult(
    name: settings.name,
    arguments: arguments as Map<String, dynamic>,
  );
  if (routeResult.showStatusBar != null || routeResult.routeName != null) {
    settings = FFRouteSettings(
      name: settings.name,
      routeName: routeResult.routeName,
      arguments: arguments as Map<String, dynamic>,
      showStatusBar: routeResult.showStatusBar,
    );
  }
  final Widget page = routeResult.widget ?? notFoundFallback;
  if (page == null) {
    throw Exception(
      '''Route "${settings.name}" returned null. Route Widget must never return null, 
          maybe the reason is that route name did not match with right path.
          You can use parameter[notFoundFallback] to avoid this ugly error.''',
    );
  }

  if (arguments is Map<String, dynamic>) {
    final RouteBuilder builder = arguments['routeBuilder'] as RouteBuilder;
    if (builder != null) {
      return builder(page);
    }
  }

  switch (routeResult.pageRouteType) {
    case PageRouteType.material:
      return MaterialPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext _) => page,
      );
    case PageRouteType.cupertino:
      return CupertinoPageRoute<dynamic>(
        settings: settings,
        builder: (BuildContext _) => page,
      );
    case PageRouteType.transparent:
      return FFTransparentPageRoute<dynamic>(
        settings: settings,
        pageBuilder: (
          BuildContext _,
          Animation<double> __,
          Animation<double> ___,
        ) =>
            page,
      );
    default:
      return Platform.isIOS
          ? CupertinoPageRoute<dynamic>(
              settings: settings,
              builder: (BuildContext _) => page,
            )
          : MaterialPageRoute<dynamic>(
              settings: settings,
              builder: (BuildContext _) => page,
            );
  }
}

typedef RouteBuilder = PageRoute<dynamic> Function(Widget page);

class FFRouteSettings extends RouteSettings {
  const FFRouteSettings({
    this.routeName,
    this.showStatusBar,
    String name,
    Object arguments,
  }) : super(
          name: name,
          arguments: arguments,
        );

  final String routeName;
  final bool showStatusBar;
}

RouteResult getRouteResult({String name, Map<String, dynamic> arguments}) {
  switch (name) {
    // case 'viiddo//WaterfallFlowDemo':
    //   return RouteResult(
    //     widget: WaterfallFlowDemo(),
    //     routeName: 'WaterfallFlow',
    //     description:
    //         'show how to build loading more WaterfallFlow with ExtendedImage.',
    //   );
    // case 'viiddo//customimage':
    //   return RouteResult(
    //     widget: CustomImageDemo(),
    //     routeName: 'custom image load state',
    //     description: 'show image with loading,failed,animation state',
    //   );
    // case 'viiddo//image':
    //   return RouteResult(
    //     widget: ImageDemo(),
    //     routeName: 'image',
    //     description:
    //         'cache image,save to photo Library,image border,shape,borderRadius',
    //   );
    // case 'viiddo//imageeditor':
    //   return RouteResult(
    //     widget: ImageEditorDemo(),
    //     routeName: 'image editor',
    //     description: 'crop,rotate and flip with image editor',
    //   );
    // case 'viiddo//loadingprogress':
    //   return RouteResult(
    //     widget: LoadingProgress(),
    //     routeName: 'loading progress',
    //     description: 'show how to make loading progress for network image',
    //   );
    // case 'viiddo//mainpage':
    //   return RouteResult(
    //     widget: MainPage(),
    //     routeName: 'MainPage',
    //   );
    // case 'viiddo//paintimage':
    //   return RouteResult(
    //     widget: PaintImageDemo(),
    //     routeName: 'paint image',
    //     description:
    //         'show how to paint any thing before/after image is painted',
    //   );
    // case 'viiddo//photoview':
    //   return RouteResult(
    //     widget: PhotoViewDemo(),
    //     routeName: 'photo view',
    //     description: 'show how to zoom/pan image in page view like WeChat',
    //   );
    case 'viiddo://picswiper':
      return RouteResult(
        widget: PicSwiper(
          index: arguments['index'],
          pics: arguments['pics'],
          list: arguments['list'],
        ),
        showStatusBar: false,
        routeName: 'PicSwiper',
        pageRouteType: PageRouteType.transparent,
      );
    // case 'viiddo//zoomimage':
    //   return RouteResult(
    //     widget: ZoomImageDemo(),
    //     routeName: 'image zoom',
    //     description: 'show how to zoom/pan image',
    //   );
    default:
      return const RouteResult();
  }
}
class RouteResult {
  const RouteResult({
    this.widget,
    this.showStatusBar = true,
    this.routeName = '',
    this.pageRouteType,
    this.description = '',
    this.exts,
  });

  /// The Widget return base on route
  final Widget widget;

  /// Whether show this route with status bar.
  final bool showStatusBar;

  /// The route name to track page
  final String routeName;

  /// The type of page route
  final PageRouteType pageRouteType;

  /// The description of route
  final String description;

  /// The extend arguments
  final Map<String, dynamic> exts;
}

enum PageRouteType {
  material,
  cupertino,
  transparent,
}
