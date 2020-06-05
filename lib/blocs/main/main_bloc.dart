import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:bloc/bloc.dart';

import '../bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  ApiService _apiService = ApiService();

  @override
  MainScreenState get initialState => MainScreenState();

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
    if (event is UnreadMessage) {
      yield* getUnreadMessages(event);
    }
  }

  Stream<MainScreenState> getUnreadMessages(UnreadMessage event) async* {
    yield state.copyWith(isLoading: true);
    try {
      UnreadMessageModel model = await _apiService.getUnreadMessages();
      yield state.copyWith(unreadMessageModel: model);
    } catch (error) {
      yield MainScreenFailure(error: error);
    } finally {
      yield state.copyWith(isLoading: false);
    }
  }
}
