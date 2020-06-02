import 'package:bloc/bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    assert(() {
      print(event);
      return true; // assert doesn't run in production
    }());
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    assert(() {
      print(transition);
      return true; // assert doesn't run in production
    }());
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    assert(() {
      print(error);
      return true; // assert doesn't run in production
    }());
  }
}
