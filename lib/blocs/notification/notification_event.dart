import 'dart:async';

import 'package:equatable/equatable.dart';

abstract class NotificationScreenEvent extends Equatable {
  NotificationScreenEvent();

  @override
  List<Object> get props => [];
}

class UnreadMessageEvent extends NotificationScreenEvent {}

class NotificationScreenInitEvent extends NotificationScreenEvent {}

class GetActivityListEvent extends NotificationScreenEvent {
  final int page;

  GetActivityListEvent(this.page);

  @override
  List<Object> get props => [this.page];
}

class GetMessageListEvent extends NotificationScreenEvent {
  final int page;

  GetMessageListEvent(this.page);

  @override
  List<Object> get props => [this.page];
}

class ReadMessageEvent extends NotificationScreenEvent {
  final int objectId;
  final bool readAll;

  ReadMessageEvent(this.objectId, this.readAll);

  @override
  List<Object> get props => [this.objectId, this.readAll];
}

class DeleteMessageEvent extends NotificationScreenEvent {
  final String objectIds;
  final bool deleteAll;

  DeleteMessageEvent(this.objectIds, this.deleteAll);

  @override
  List<Object> get props => [this.objectIds, this.deleteAll];
}