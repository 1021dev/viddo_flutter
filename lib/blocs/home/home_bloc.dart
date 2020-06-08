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
    if (event is HomeInitEvent) {
      yield* init();
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
    } else if (event is HomeScreenRefresh) {
      yield* getDataWithHeader(true);
    }
  }

  Stream<HomeScreenState> init() async* {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool isRefresh = sharedPreferences.getInt(Constants.IS_REFRESH) ?? false;
      int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
      add(GetDataWithHeader(true));

//      if (isRefresh) {
//        add(GetDataWithHeader(true));
////        getDataWithHeader(true);
//        add(GetFriendByBaby(babyId));
////        getFriendByBaby(babyId);
//        sharedPreferences.setBool(Constants.IS_REFRESH, false);
//      }
      if (babyId == 0) {
        add(GetDataWithHeader(true));
      } else {
        add(GetBabyInfo(babyId));
      }
      if (!(state.frameBaby ?? false)) {
        try {
          UnreadMessageModel model = await _apiService.getUnreadMessages();
          yield state.copyWith(unreadMessageModel: model);
        } catch (error) {
          yield state.copyWith(unreadMessageModel: null);
          print(error.toString());
        } finally {}
      }
    } catch (error) {
      yield HomeScreenFailure(error: error);
    } finally {}
  }

  Stream<HomeScreenState> getBabyInfo(int objectId) async* {
    try {
      BabyModel model = await _apiService.getBabyInfo(objectId);
      yield state.copyWith(babyModel: model);
    } catch (error) {
      yield HomeScreenFailure(error: error);
    } finally {}
  }

  Stream<HomeScreenState> getFriendByBaby(int objectId) async* {
    try {
      FriendListModel model = await _apiService.getFriendsByBaby(objectId);
      yield state.copyWith(friendListModel: model);
    } catch (error) {
      yield HomeScreenFailure(error: error);
    } finally {}
  }

//  Stream<HomeScreenState> getMyBabys(int page) async* {
//    try {
//      BabyListModel model = await _apiService.getMyBabyList(page);
//      yield state.copyWith(babyListModel: model);
//    } catch (error) {
//      yield HomeScreenFailure(error: error);
//    } finally {}
//  }

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
//      if (state.dataArr != null) {
//        dataArr.addAll(state.dataArr);
//      }
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

  Stream<HomeScreenState> getDataWithHeader(bool isHeader) async* {
    try {
      if (!(state.frameBaby ?? false)) {
        UnreadMessageModel model = await _apiService.getUnreadMessages();
        yield state.copyWith(unreadMessageModel: model);
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
      if (babyId != 0) {
        if (isHeader) {
          if (state.frameBaby ?? false) {
            add(GetBabyInfo(state.frameBaby ? state.babyId : babyId));
          }
        }
        add(GetMomentByBaby(
          babyId,
          state.page ?? 0,
          state.tag ?? false,
        ));
      } else {
        try {
          BabyListModel model = await _apiService.getMyBabyList(state.page);
          yield state.copyWith(babyListModel: model);
        } catch (error) {
          yield HomeScreenFailure(error: error);
        } finally {}
      }
    } catch (error) {} finally {}
  }

  Stream<HomeScreenState> getUnreadMessages() async* {
    try {
      UnreadMessageModel model = await _apiService.getUnreadMessages();
      yield state.copyWith(unreadMessageModel: model);
    } catch (error) {
      yield state.copyWith(unreadMessageModel: null);
      print(error.toString());
    } finally {}
  }

  Stream<HomeScreenState> getRefreshInformation() async* {
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
