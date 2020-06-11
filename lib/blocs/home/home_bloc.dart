import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/dynamic_creator.dart';
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
    } else if (event is LikeEvent) {
      yield* _likeMoment(event.objectId, event.isLike, event.index);
    } else if (event is CommentEvent) {
      yield* _postComment(event.objectId, event.parentId, event.replyUserId, event.content);
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


  Stream<HomeScreenState> _likeMoment(int objectId, bool isLike, int index) async* {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      List<DynamicContent> dataArr = state.dataArr;
      DynamicContent dynamicContent = dataArr[index];
      dynamicContent.isLike = !dynamicContent.isLike;
      List<DynamicCreator> likeList = dynamicContent.likeList;
        String name = sharedPreferences.getString(Constants.USERNAME) ?? '';
        String avatar = sharedPreferences.getString(Constants.AVATAR) ?? '';
        int id = sharedPreferences.getInt(Constants.OBJECT_ID) ?? 0;
      if (dynamicContent.isLike) {
        likeList.add(DynamicCreator(name: name, avatar: avatar, objectId: id, nickName: name));
      } else {
        likeList = likeList.where( (user) {
          return user.objectId != id;
        }).toList();
      }
      dynamicContent.likeList = likeList;
      dataArr[index] = dynamicContent;
      yield state.copyWith(dataArr: dataArr);
      bool isLiked =
          await _apiService.updateLike(objectId, isLike);
          print('isLiked => $isLiked');
    } catch (error) {
      print('error => $error');
    }
  }

  Stream<HomeScreenState> _postComment(int objectId, int parentId, int replyUserId, String content) async* {
    try {
      bool success =
          await _apiService.postComment(objectId, parentId, replyUserId, content);
          print('post comment success => $success');
    } catch (error) {
      print('error => $error');
    }
  }

}
