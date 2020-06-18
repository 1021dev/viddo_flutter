import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/blocs/post/post.dart';
import 'package:Viiddo/blocs/post/post_event.dart';
import 'package:Viiddo/models/sticker_category_model.dart';
import 'package:Viiddo/models/sticker_list_model.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  MainScreenBloc mainScreenBloc;
  ApiService _apiService = ApiService();
  PostBloc({@required this.mainScreenBloc});

  @override
  PostState get initialState => PostState();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is InitPostScreen) {
      yield* getLocalStikers();
    } else if (event is GetStickerCategory) {
      yield* getStickerCategories();
    } else if (event is GetStickerByCategory) {
      yield* getStickerByCategory(event.objectId, event.page);
    } else if (event is StickersSaveToLocal) {

    }
  }

  Stream<PostState> getLocalStikers() async* {
    try {
    } catch (error) {
      yield PostFailure(error: error);
    }
  }

  Stream<PostState> downloadAndSaveStickers(Map<int, List<StickerModel>> map) async* {
    try {
    } catch (error) {
      yield PostFailure(error: error);
    }
  }

  Stream<PostState> getStickerCategories() async* {
    try {
      List<StickerCategory> stickerCategory = await _apiService.getStikerCategory();
      yield state.copyWith(categories: stickerCategory);
      for (int i = 0; i < stickerCategory.length; i++) {
        int objectId = stickerCategory[i].objectId;
        add(GetStickerByCategory(objectId, 0));
      }
    } catch (error) {
      yield PostFailure(error: error);
    }
  }

  Stream<PostState> getStickerByCategory(int objectId, int page) async* {
    try {
      Map<int, List<StickerModel>> map = {};
      if (state.stickers != null) {
        map.addAll(state.stickers);
      }
      StickerListModel stickerListModel = await _apiService.getStickers(objectId, 0);
      map[objectId] = stickerListModel.content;
      yield state.copyWith(stickers: map);
      downloadAndSaveStickers(map);
    } catch (error) {
      yield PostFailure(error: error);
    }
  }
}