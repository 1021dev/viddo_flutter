import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/friend_list_model.dart';
import 'package:Viiddo/models/page_response_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:Viiddo/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  ApiService _apiService = ApiService();

  @override
  HomeScreenState get initialState => HomeScreenState();

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
  }
}
