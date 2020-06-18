import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../bloc.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  ApiService _apiService = ApiService();
  final MainScreenBloc mainScreenBloc;
  HomeScreenBloc({@required this.mainScreenBloc});


  @override
  HomeScreenState get initialState => HomeScreenState();

  @override
  Stream<HomeScreenState> mapEventToState(HomeScreenEvent event) async* {
    // if (event is GetMomentByBaby) {
    //   if (event.objectId == 0) {
    //     SharedPreferences sharedPreferences =
    //         await SharedPreferences.getInstance();
    //     int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;

    //     yield* getMomentByBaby(
    //       babyId,
    //       event.page,
    //       event.tag,
    //     );
    //   } else {
    //     yield* getMomentByBaby(
    //       event.objectId,
    //       event.page,
    //       event.tag,
    //     );
    //   }
    // } else if (event is LikeEvent) {
    //   yield* _likeMoment(event.objectId, event.isLike, event.index);
    // } else if (event is CommentEvent) {
    //   yield* _postComment(event.objectId, event.parentId, event.content);
    // } else if (event is HomeScreenInitEvent) {
    //   yield* _init();
    // } else if (event is GetMomentDetailsEvent) {
    //   yield* _getMomentDetails(event.objectId, event.babyId);
    // } else if (event is ClearMomentDetailEvent) {
    //   yield state.copyWith(dynamicDetails: null);
    // } else if (event is HomeScreenRefresh) {
    //     mainScreenBloc.add(GetDataWithHeader(true));
    //     int babyId = 0;
    //     if (mainScreenBloc.state.babyId == 0) {
    //       SharedPreferences sharedPreferences =
    //           await SharedPreferences.getInstance();
    //       babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
    //     } else {
    //       babyId = state.babyId;
    //     }
    //     yield* getMomentByBaby(
    //       babyId,
    //       0,
    //       false,
    //     );
    //     yield* getBabyInfo(
    //       babyId,
    //     );
    // }
  }

//   Stream<HomeScreenState> _init() async* {
//     try {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
//       String babyAvatar = sharedPreferences.getString(Constants.BABY_ICON) ?? '';
//       bool isCreator = sharedPreferences.getBool(Constants.IS_CREATOR) ?? false;
//       bool isBirth = sharedPreferences.getBool(Constants.IS_BIRTH) ?? false;
//       yield state.copyWith(
//         babyAvatar: babyAvatar,
//         isCreator: isCreator,
//         isBirth: isBirth,
//         babyId: babyId,
//       );
//       if (babyId == 0) {
//         mainScreenBloc.add(GetDataWithHeader(true));
//       } else {
//         add(GetMomentByBaby(babyId, state.page ?? 0, false));
//       }
//     } catch (error) {
//       yield HomeScreenFailure(error: error);
//     }
//   }

//   Stream<HomeScreenState> getBabyInfo(int objectId) async* {
//     try {
//       if (objectId == 0) {
//         SharedPreferences sharedPreferences =
//             await SharedPreferences.getInstance();
//         int babyId = sharedPreferences.getInt(Constants.BABY_ID) ?? 0;
//         BabyModel model = await _apiService.getBabyInfo(babyId);
//         yield state.copyWith(babyModel: model);
//       } else {
//         BabyModel model = await _apiService.getBabyInfo(objectId);
//         yield state.copyWith(babyModel: model);
//       }
//     } catch (error) {
//       yield HomeScreenFailure(error: error);
//     }
//   }

//   Stream<HomeScreenState> getMomentByBaby(
//     int objectId, int page, bool tag) async* {
//     yield state.copyWith(isLoading: true);
//     try {
//       PageResponseModel pageResponseModel = await _apiService.getMomentByBaby(
//         objectId,
//         page,
//         tag,
//       );
//       List<DynamicContent> dataArr = [];
//       if (state.dataArr != null && page != 0) {
//         dataArr.addAll(state.dataArr);
//       }
//       if (pageResponseModel.content != null) {
//         for (int i = 0; i < pageResponseModel.content.length; i++) {
//           DynamicContent content =
//               DynamicContent.fromJson(pageResponseModel.content[i]);
//           if (content != null) {
//             dataArr.add(content);
//           }
//         }
//       }
//       print('data => $dataArr');
//       yield state.copyWith(isLoading: false, dataArr: dataArr);
//     } catch (error) {
//       yield HomeScreenFailure(error: error);
//       yield state.copyWith(isLoading: false);
//     }
//   }

//   Stream<HomeScreenState> _likeMoment(int objectId, bool isLike, int index) async* {
//     try {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       List<DynamicContent> dataArr = state.dataArr;
//       if (index > -1) {
//         DynamicContent dynamicContent = dataArr[index];
//         dynamicContent.isLike = !dynamicContent.isLike;
//         List<DynamicCreator> likeList = dynamicContent.likeList;
//           String name = sharedPreferences.getString(Constants.USERNAME) ?? '';
//           String avatar = sharedPreferences.getString(Constants.AVATAR) ?? '';
//           int id = sharedPreferences.getInt(Constants.OBJECT_ID) ?? 0;
//         if (dynamicContent.isLike) {
//           likeList.add(DynamicCreator(name: name, avatar: avatar, objectId: id, nickName: name));
//         } else {
//           likeList = likeList.where( (user) {
//             return user.objectId != id;
//           }).toList();
//         }
//         dynamicContent.likeList = likeList;
//         dataArr[index] = dynamicContent;
//         yield state.copyWith(dataArr: dataArr);
//       } else if (state.dynamicDetails != null && state.dynamicDetails.objectId == objectId){
//         DynamicContent dynamicContent = state.dynamicDetails;
//         dynamicContent.isLike = !dynamicContent.isLike;
//         List<DynamicCreator> likeList = dynamicContent.likeList;
//           String name = sharedPreferences.getString(Constants.USERNAME) ?? '';
//           String avatar = sharedPreferences.getString(Constants.AVATAR) ?? '';
//           int id = sharedPreferences.getInt(Constants.OBJECT_ID) ?? 0;
//         if (dynamicContent.isLike) {
//           likeList.add(DynamicCreator(name: name, avatar: avatar, objectId: id, nickName: name));
//         } else {
//           likeList = likeList.where( (user) {
//             return user.objectId != id;
//           }).toList();
//         }
//         dynamicContent.likeList = likeList;
//         yield state.copyWith(dynamicDetails: dynamicContent);
//       }
//       bool isLiked =
//           await _apiService.updateLike(objectId, isLike);
//           print('isLiked => $isLiked');
//     } catch (error) {
//       print('error => $error');
//     }
//   }

//   Stream<HomeScreenState> _postComment(int objectId, int parentId, String content) async* {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       int replyUserId = preferences.getInt(Constants.OBJECT_ID) ?? 0;
//       int babyId = preferences.getInt(Constants.BABY_ID) ?? 0;
//       bool success =
//           await _apiService.postComment(objectId, parentId, replyUserId, content);
//           print('post comment success => $success');
//       add(GetMomentDetailsEvent(objectId, babyId));
//     } catch (error) {
//       print('error => $error');
//     }
//   }

//   Stream<HomeScreenState> _getMomentDetails(int objectId, int babyId) async* {
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       preferences.setInt(Constants.BABY_ID, babyId);
//       DynamicContent content =
//           await _apiService.getMomentDetails(objectId, babyId);
//       print('_getMomentDetails $content');
//       yield state.copyWith(dynamicDetails: content);
//     } catch (error) {
//       yield state.copyWith(dynamicDetails: null);
//       print('error => $error');
//     }
//   }
}
