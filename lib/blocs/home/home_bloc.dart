import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/page_response_model.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  ApiService _apiService = ApiService();
  final MainScreenBloc mainScreenBloc;
  HomeScreenBloc({@required this.mainScreenBloc});


  @override
  HomeScreenState get initialState => HomeScreenState();

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    if (event is GetMomentByBaby) {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;

      yield* getMomentByBaby(
        babyId,
        event.page,
        event.tag,
      );
    }
  }

  Stream<HomeScreenState> getMomentByBaby(
    int objectId, int page, bool tag) async* {
    yield state.copyWith(isLoading: true);
    try {
      PageResponseModel pageResponseModel = await _apiService.getMomentByBaby(
        objectId,
        page,
        tag,
      );
      List<DynamicContent> dataArr = [];
     if (state.dataArr != null && page != 0) {
       dataArr.addAll(state.dataArr);
     }
      if (pageResponseModel.content != null) {
        for (int i = 0; i < pageResponseModel.content.length; i++) {
          DynamicContent content =
              DynamicContent.fromJson(pageResponseModel.content[i]);
          if (content != null) {
            dataArr.add(content);
          }
        }
      }
      print('data => $dataArr');
      yield state.copyWith(isLoading: false, dataArr: dataArr);
    } catch (error) {
      yield HomeScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    }
  }

}
