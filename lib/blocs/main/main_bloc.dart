import 'dart:async';

import 'package:bloc/bloc.dart';

import '../bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  @override
  MainScreenState get initialState => MainScreenState();

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {}
}
