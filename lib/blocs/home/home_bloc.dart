import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:bloc/bloc.dart';

import '../bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  ApiService _apiService = ApiService();

  @override
  HomeScreenState get initialState => HomeScreenState();

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
  }
}
