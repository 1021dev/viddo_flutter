import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../bloc.dart';

class BabyScreenBloc extends Bloc<BabyScreenEvent, BabyScreenState> {
  MainScreenBloc mainScreenBloc;
  ApiService _apiService = ApiService();
  BabyScreenBloc({@required this.mainScreenBloc});

  @override
  BabyScreenState get initialState => BabyScreenState();

  @override
  Stream<BabyScreenState> mapEventToState(BabyScreenEvent event) async* {
  }
}
