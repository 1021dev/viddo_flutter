import 'dart:async';

import 'package:Viiddo/apis/api_service.dart';
import 'package:Viiddo/models/activity_notification_list_model.dart';
import 'package:Viiddo/models/activity_notification_model.dart';
import 'package:Viiddo/models/message_list_model.dart';
import 'package:Viiddo/models/message_model.dart';
import 'package:Viiddo/models/response_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../bloc.dart';

class NotificationScreenBloc extends Bloc<NotificationScreenEvent, NotificationScreenState> {
  ApiService _apiService = ApiService();
  final MainScreenBloc mainScreenBloc;
  NotificationScreenBloc({@required this.mainScreenBloc});

  @override
  NotificationScreenState get initialState => NotificationScreenState();

  @override
  Stream<NotificationScreenState> mapEventToState(NotificationScreenEvent event) async* {
    if (event is NotificationScreenInitEvent) {
      yield* init();
    } else if (event is UnreadMessageEvent) {
      yield* getUnreadMessages();
    } else if (event is GetActivityListEvent) {
      yield* getActivityList(event.page);
    } else if (event is GetMessageListEvent) {
      yield* getSystemMessage(event.page);
    } else if (event is ReadMessageEvent) {
      yield* readMessage(
        event.objectId,
        event.readAll,
      );
    } else if (event is DeleteMessageEvent) {
      yield* deleteMessage(event.objectIds, event.deleteAll);
    }
  }

  Stream<NotificationScreenState> init() async* {
    try {
    } catch (error) {
      yield NotificationScreenFailure(error: error);
    } finally {}
  }


  Stream<NotificationScreenState> getUnreadMessages() async* {
    yield state.copyWith(isLoading: true);
    try {
      UnreadMessageModel model = await _apiService.getUnreadMessages();
      yield state.copyWith(isLoading: false, unreadMessageModel: model);
    } catch (error) {
      yield state.copyWith(isLoading: false);
      yield NotificationScreenFailure(error: error);
    }
  }

  Stream<NotificationScreenState> getActivityList(int page) async* {
    try {
      ActivityNotificationListModel activityNotificationListModel = await _apiService.getActivityList(page);
      List<ActivityNotificationModel> activitySectionList = [];
      if (page != 0) {
        activitySectionList.addAll(state.activityList);
      }
      activitySectionList.addAll(activityNotificationListModel.content);
      yield state.copyWith(activityNotificationListModel: activityNotificationListModel, activityList: activitySectionList);
    } catch (error) {
      yield NotificationScreenFailure(error: error);
    }
  }

  Stream<NotificationScreenState> getSystemMessage(int page) async* {
    try {
      MessageListModel messageListModel = await _apiService.getSystemessage(
        page,
      );
      List<MessageModel> messageSectionList = [];
      if (page != 0) {
        messageSectionList.addAll(state.messageList);
      }
      messageSectionList.addAll(messageListModel.content);
      yield state.copyWith(messageListModel: messageListModel, messageList: messageSectionList);
    } catch (error) {
      yield NotificationScreenFailure(error: error);
    }
  }

  Stream<NotificationScreenState> readMessage(int objectId, bool readAll) async* {
    yield state.copyWith(isLoading: true);
    try {
      ResponseModel model = await _apiService.makeMessageRead(
        objectId, readAll,
      );
      print('readMessage => $model');
      yield state.copyWith(isLoading: false);
    } catch (error) {
      yield NotificationScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<NotificationScreenState> deleteMessage(String objectIds, bool deleteAll) async* {
    yield state.copyWith(isLoading: true);
    try {
      ResponseModel model = await _apiService.deleteMessage(
        objectIds, deleteAll,
      );
      print('deleteMessage => $model');
      yield state.copyWith(isLoading: false);
    } catch (error) {
      yield NotificationScreenFailure(error: error);
      yield state.copyWith(isLoading: false);
    }
  }

  Stream<NotificationScreenState> getDataWithHeader(bool isHeader) async* {
  }

}
