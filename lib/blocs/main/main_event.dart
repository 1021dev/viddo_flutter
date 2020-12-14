import 'dart:async';
import 'dart:io';

import 'package:Viiddo/models/baby_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SelectBabyEvent extends MainScreenEvent {
  final BabyModel babyModel;
  SelectBabyEvent(this.babyModel);

  @override
  List<Object> get props => [babyModel];

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

class GetMomentByBaby extends MainScreenEvent {
  final int objectId;
  final int page;
  final bool tag;

  GetMomentByBaby(
    this.objectId,
    this.page,
    this.tag,
  );

  @override
  List<Object> get props => [
        objectId,
        page,
        tag,
      ];
}

@immutable
class LikeEvent extends MainScreenEvent {
  final int objectId;
  final bool isLike;
  final int index;
  LikeEvent(
    this.objectId,
    this.isLike,
    this.index,
  );

  @override
  List<Object> get props => [
        this.objectId,
        this.isLike,
        this.index,
      ];
}

@immutable
class CommentEvent extends MainScreenEvent {
  final int objectId;
  final int parentId;
  final String content;
  CommentEvent(
    this.objectId,
    this.parentId,
    this.content,
  );

  @override
  List<Object> get props => [
        this.objectId,
        this.parentId,
        this.content,
      ];
}

@immutable
class GetMomentDetailsEvent extends MainScreenEvent {
  final int objectId;
  final int babyId;
  GetMomentDetailsEvent(
    this.objectId,
    this.babyId,
  );

  @override
  List<Object> get props => [
        this.objectId,
        this.babyId,
      ];
}

@immutable
class ClearMomentDetailEvent extends MainScreenEvent {}

class SendVerificationCode extends MainScreenEvent {
  String email;
  String type;

  SendVerificationCode(
    this.email,
    this.type,
  );

  @override
  List<Object> get props => [
        this.email,
        this.type,
      ];
}
class GetUserProfile extends MainScreenEvent {}
class MainScreenGetRefresh extends MainScreenEvent {}
