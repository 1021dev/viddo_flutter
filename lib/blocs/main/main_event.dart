import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/semantics.dart';

abstract class MainScreenEvent extends Equatable {
  MainScreenEvent();

  @override
  List<Object> get props => [];
}

class UnreadMessage extends MainScreenEvent {}

class MainScreenInitEvent extends MainScreenEvent {}

class GetFriendByBaby extends MainScreenEvent {
  final int objectId;

  GetFriendByBaby(this.objectId);

  @override
  List<Object> get props => [objectId];
}

class GetBabyInfo extends MainScreenEvent {
  final int objectId;

  GetBabyInfo(this.objectId);

  @override
  List<Object> get props => [objectId];
}

class MainScreenRefresh extends MainScreenEvent {
  final Completer completer;
  MainScreenRefresh(this.completer);

  @override
  List<Object> get props => [completer];

}

class GetDataWithHeader extends MainScreenEvent {
  final bool isHeader;

  GetDataWithHeader(this.isHeader);

  @override
  List<Object> get props => [isHeader];
}
