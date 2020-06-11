import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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

class GetBabyListModel extends MainScreenEvent {
  final int page;

  GetBabyListModel(this.page);

  @override
  List<Object> get props => [page];
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

class UpdateBabyBirthDay extends MainScreenEvent {
  final int babyId;
  final int birthday;
  UpdateBabyBirthDay(
    this.babyId,
    this.birthday
  );

  @override
  List<Object> get props => [
        this.babyId,
        this.birthday,
      ];
}

@immutable
class UpdateBabyProfile extends MainScreenEvent {
  final int babyId;
  final dynamic map;
  UpdateBabyProfile(
    this.babyId,
    this.map,
  );

  @override
  List<Object> get props => [
        this.babyId,
        this.map,
      ];
}

@immutable
class PickBabyProfileImage extends MainScreenEvent {
  final int babyId;
  final List<File> files;
  PickBabyProfileImage(
    this.babyId,
    this.files,
  );

  @override
  List<Object> get props => [
        this.babyId,
        this.files,
      ];
}

