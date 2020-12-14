import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Navigation {
  static dynamic toScreen({
    @required BuildContext context,
    @required Widget screen,
  }) async {
    return await Navigator.of(context, rootNavigator: true).push(
        MaterialPageRoute(
      builder: (_) => screen,
    ));
  }

  static dynamic toScreenAndCleanBackStack({
    @required BuildContext context,
    @required Widget screen,
  }) async {
    return await Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => screen,
      ),
      (_) => false,
    );
  }

  static dynamic toScreenWithReplacement({
    @required BuildContext context,
    @required Widget screen,
  }) async {
    return await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => screen,
      ),
    );
  }
}
class FadePageRoute<T> extends PageRoute<T> {
  FadePageRoute(this.child);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black;

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
