import 'dart:async';
import 'dart:io';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/friend_list_model.dart';
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
    } else if (event is GetBabyListModel) {
      yield* getBabyListModel(event.page);
    } else if (event is GetBabyInfo) {
      yield* getBabyInfo(event.objectId);
    } else if (event is GetFriendByBaby) {
      yield* getFriendByBaby(event.objectId);
    } else if (event is GetDataWithHeader) {
      yield* getDataWithHeader(event.isHeader);
    } else if (event is MainScreenRefresh) {
      yield* getDataWithHeader(true);
    } else if (event is UpdateBabyBirthDay) {
      yield* _updateBabyProfile({
        'birthDay': event.birthday,
        'objectId': event.babyId,
      });
    } else if (event is UpdateBabyProfile) {
      yield* _updateBabyProfile(event.map);
    } else if (event is PickBabyProfileImage) {
      yield* _pickBabyProfileImageFile(event.babyId, event.files);
    } else if (event is SelectBabyEvent) {
      yield* _selectBaby(event.babyId);
    // } else if (event is GetMomentByBaby) {
    //   SharedPreferences sharedPreferences =
    //       await SharedPreferences.getInstance();
    //   int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;

    //   yield* getMomentByBaby(
    //     babyId,
    //     event.page,
    //     event.tag,
    //   );
    // } else if (event is LikeEvent) {
    //   yield* _likeMoment(event.objectId, event.isLike, event.index);
    // } else if (event is CommentEvent) {
    //   yield* _postComment(event.objectId, event.parentId, event.replyUserId, event.content);
    }

  }

  Stream<MainScreenState> init() async* {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool isRefresh = sharedPreferences.getInt(Constants.IS_REFRESH) ?? false;
      int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
      if (babyId == 0) {
        add(GetBabyListModel(0));
      }
      add(UnreadMessage());
    } catch (error) {
      yield MainScreenFailure(error: error);
    } 
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
      if (objectId == 0) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
        BabyModel model = await _apiService.getBabyInfo(babyId);
        yield state.copyWith(babyModel: model);
      } else {
        BabyModel model = await _apiService.getBabyInfo(objectId);
        yield state.copyWith(babyModel: model);
      }
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
    }
  }


  Stream<MainScreenState> getDataWithHeader(bool isHeader) async* {
    try {
      add(UnreadMessage());
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
      if (babyId != 0) {
        // add(GetBabyInfo(babyId));
        // add(GetMomentByBaby(
        //   babyId,
        //   state.page,
        //   state.tag,
        // ));
      } else {
        // add(GetBabyListModel(0));
      }
    } catch (error) {} 
  }

  Stream<MainScreenState> getRefreshInformation() async* {
    try {
      bool isRefresh = await _apiService.getRefreshInformation();
      if (isRefresh) {
        add(GetDataWithHeader(true));
      }
    } catch (error) {
      print(error.toString());
    } 
  }


  Stream<MainScreenState> getBabyListModel(int page) async* {
    try {
      BabyListModel model = await _apiService.getMyBabyList(page);
      if (model.content.length > 0) {
        add(GetBabyInfo(0));
      }
      yield state.copyWith(babyListModel: model);
    } catch (error) {
      yield MainScreenFailure(error: error);
    }
  }

  Stream<MainScreenState> _updateBabyProfile(Map<String, dynamic> map) async* {
    yield state.copyWith(isLoading: true);
    try {
      bool success = await _apiService.updateProfile(
        map,
      );
      if (success) {
        add(GetBabyInfo(map['objectId']));
      } else {
        yield UpdateBabyProfileFailure(error: 'error');
      }
    } catch (error) {
      yield UpdateBabyProfileFailure(error: error.toString());
    }
  }

  Stream<MainScreenState> _selectBaby(int babyId) async* {
    try {
      SharedPreferences shared = await SharedPreferences.getInstance();
      shared.setInt(Constants.BABY_ID, babyId);
      yield state.copyWith(babyId: babyId);
      add(GetBabyInfo(babyId));
    } catch (error) {
    }
  }

  Stream<MainScreenState> _pickBabyProfileImageFile(int babyId, List<File> pickedFiles) async* {
    try {
      yield state.copyWith(isUploading: true);
      List<String> urls =
          await _apiService.uploadProfileImage(pickedFiles);
      String avatar = '';
      if (urls.length > 0) {
        avatar = urls.first;
      }
      yield state.copyWith(isUploading: false);
      if(avatar != '') {
        add(UpdateBabyProfile(babyId, {'avatar': avatar, 'objectId': babyId}));
      }
    } catch (error) {
      yield UpdateBabyProfileFailure(error: error.toString());
      yield state.copyWith(isUploading: false);
    }
  }

  // Stream<MainScreenState> getMomentByBaby(
  //   int objectId, int page, bool tag) async* {
  //   yield state.copyWith(isLoading: true);
  //   try {
  //     PageResponseModel pageResponseModel = await _apiService.getMomentByBaby(
  //       objectId,
  //       page,
  //       tag,
  //     );
  //     List<DynamicContent> dataArr = [];
  //     if (state.dataArr != null && page != 0) {
  //       dataArr.addAll(state.dataArr);
  //     }
  //     if (pageResponseModel.content != null) {
  //       for (int i = 0; i < pageResponseModel.content.length; i++) {
  //         DynamicContent content =
  //             DynamicContent.fromJson(pageResponseModel.content[i]);
  //         if (content != null) {
  //           dataArr.add(content);
  //         }
  //       }
  //     }
  //     print('data => $dataArr');
  //     yield state.copyWith(isLoading: false, dataArr: dataArr);
  //   } catch (error) {
  //     yield MainScreenFailure(error: error);
  //     yield state.copyWith(isLoading: false);
  //   }
  // }


  // Stream<MainScreenState> _likeMoment(int objectId, bool isLike, int index) async* {
  //   try {
  //     SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     List<DynamicContent> dataArr = state.dataArr;
  //     DynamicContent dynamicContent = dataArr[index];
  //     dynamicContent.isLike = !dynamicContent.isLike;
  //     List<DynamicCreator> likeList = dynamicContent.likeList;
  //       String name = sharedPreferences.getString(Constants.USERNAME) ?? '';
  //       String avatar = sharedPreferences.getString(Constants.AVATAR) ?? '';
  //       int id = sharedPreferences.getInt(Constants.OBJECT_ID) ?? 0;
  //     if (dynamicContent.isLike) {
  //       likeList.add(DynamicCreator(name: name, avatar: avatar, objectId: id, nickName: name));
  //     } else {
  //       likeList = likeList.where( (user) {
  //         return user.objectId != id;
  //       }).toList();
  //     }
  //     dynamicContent.likeList = likeList;
  //     dataArr[index] = dynamicContent;
  //     yield state.copyWith(dataArr: dataArr);
  //     bool isLiked =
  //         await _apiService.updateLike(objectId, isLike);
  //         print('isLiked => $isLiked');
  //   } catch (error) {
  //     print('error => $error');
  //   }
  // }

  // Stream<MainScreenState> _postComment(int objectId, int parentId, int replyUserId, String content) async* {
  //   try {
  //     bool success =
  //         await _apiService.postComment(objectId, parentId, replyUserId, content);
  //         print('post comment success => $success');
  //   } catch (error) {
  //     print('error => $error');
  //   }
  // }

}
