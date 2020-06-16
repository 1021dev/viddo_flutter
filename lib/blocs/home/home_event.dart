import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class HomeScreenEvent extends Equatable {
  HomeScreenEvent();

  @override
  List<Object> get props => [];
}
class HomeScreenInitEvent extends HomeScreenEvent {}
// class GetMomentByBaby extends HomeScreenEvent {
//   final int objectId;
//   final int page;
//   final bool tag;

//   GetMomentByBaby(
//     this.objectId,
//     this.page,
//     this.tag,
//   );

//   @override
//   List<Object> get props => [
//         objectId,
//         page,
//         tag,
//       ];
// }

// @immutable
// class LikeEvent extends HomeScreenEvent {
//   final int objectId;
//   final bool isLike;
//   final int index;
//   LikeEvent(
//     this.objectId,
//     this.isLike,
//     this.index,
//   );

//   @override
//   List<Object> get props => [
//         this.objectId,
//         this.isLike,
//         this.index,
//       ];
// }

// @immutable
// class CommentEvent extends HomeScreenEvent {
//   final int objectId;
//   final int parentId;
//   final String content;
//   CommentEvent(
//     this.objectId,
//     this.parentId,
//     this.content,
//   );

//   @override
//   List<Object> get props => [
//         this.objectId,
//         this.parentId,
//         this.content,
//       ];
// }

// @immutable
// class GetMomentDetailsEvent extends HomeScreenEvent {
//   final int objectId;
//   final int babyId;
//   GetMomentDetailsEvent(
//     this.objectId,
//     this.babyId,
//   );

//   @override
//   List<Object> get props => [
//         this.objectId,
//         this.babyId,
//       ];
// }

// @immutable
// class ClearMomentDetailEvent extends HomeScreenEvent {}

// @immutable
// class HomeScreenRefresh extends HomeScreenEvent {
//   final Completer completer;
//   HomeScreenRefresh(this.completer);
//   @override
//   List<Object> get props => [
//         this.completer,
//       ];
// }


