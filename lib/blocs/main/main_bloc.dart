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

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  ApiService _apiService = ApiService();

  @override
  MainScreenState get initialState => MainScreenState();

  @override
  Stream<MainScreenState> mapEventToState(MainScreenEvent event) async* {
    if (event is MainScreenInitEvent) {
      yield* init();
    } else if (event is UnreadMessage) {
      yield* getUnreadMessages(event);
    } else if (event is GetBabyInfo) {
      yield* getBabyInfo(event.objectId);
    } else if (event is GetFriendByBaby) {
      yield* getFriendByBaby(event.objectId);
    } else if (event is GetMomentByBaby) {
      yield* getMomentByBaby(
        event.objectId,
        event.page,
        event.tag,
      );
    } else if (event is GetDataWithHeader) {
      yield* getDataWithHeader(event.isHeader);
    } else if (event is MainScreenRefresh) {
      yield* getDataWithHeader(true);
    }
  }

  Stream<MainScreenState> init() async* {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool isRefresh = sharedPreferences.getInt(Constants.IS_REFRESH) ?? false;
      int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;

     if (isRefresh) {
       add(GetDataWithHeader(true));
       add(GetFriendByBaby(babyId));
       sharedPreferences.setBool(Constants.IS_REFRESH, false);
     }
      if (babyId == 0) {
        add(GetDataWithHeader(true));
      } else {
        add(GetBabyInfo(babyId));
      }
      try {
        UnreadMessageModel model = await _apiService.getUnreadMessages();
        yield state.copyWith(unreadMessageModel: model);
      } catch (error) {
        yield state.copyWith(unreadMessageModel: null);
        print(error.toString());
      } finally {}
    } catch (error) {
      yield MainScreenFailure(error: error);
    } finally {}
  }


  Stream<MainScreenState> getUnreadMessages(UnreadMessage event) async* {
    yield state.copyWith(isLoading: true);
    try {
      UnreadMessageModel model = await _apiService.getUnreadMessages();
      yield state.copyWith(isLoading: false, unreadMessageModel: model);
    } catch (error) {
      yield state.copyWith(isLoading: false);
      yield MainScreenFailure(error: error);
    }
  }

  Stream<MainScreenState> getBabyInfo(int objectId) async* {
    try {
      BabyModel model = await _apiService.getBabyInfo(objectId);
      yield state.copyWith(babyModel: model);
    } catch (error) {
      yield MainScreenFailure(error: error);
    }
  }

  Stream<MainScreenState> getFriendByBaby(int objectId) async* {
    try {
      FriendListModel model = await _apiService.getFriendsByBaby(objectId);
      yield state.copyWith(friendListModel: model);
    } catch (error) {
      yield MainScreenFailure(error: error);
    } finally {}
  }

  Stream<MainScreenState> getMomentByBaby(
      int objectId, int page, bool tag) async* {
    yield state.copyWith(isLoading: true);
    try {
      PageResponseModel pageResponseModel = await _apiService.getMomentByBaby(
        objectId,
        page,
        tag,
      );
      List<DynamicContent> dataArr = [];
     if (state.dataArr != null) {
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
      yield MainScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<MainScreenState> getDataWithHeader(bool isHeader) async* {
    try {
      UnreadMessageModel model = await _apiService.getUnreadMessages();
      yield state.copyWith(unreadMessageModel: model);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
      if (babyId != 0) {
        add(GetMomentByBaby(
          babyId,
          state.page,
          state.tag,
        ));
      } else {
        try {
          BabyListModel model = await _apiService.getMyBabyList(state.page);
          yield state.copyWith(babyListModel: model);
        } catch (error) {
          yield MainScreenFailure(error: error);
        } finally {}
      }
    } catch (error) {} finally {}
  }

  Stream<MainScreenState> getRefreshInformation() async* {
    try {
      bool isRefresh = await _apiService.getRefreshInformation();
      if (isRefresh) {
        add(GetDataWithHeader(true));
      }
    } catch (error) {
      print(error.toString());
    } finally {}
  }

}
