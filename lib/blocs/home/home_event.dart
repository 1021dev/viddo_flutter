import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  HomeScreenEvent();

  @override
  List<Object> get props => [];
}

class GetFriendByBaby extends HomeScreenEvent {
  final int objectId;

  GetFriendByBaby(this.objectId);

  @override
  List<Object> get props => [objectId];
}

class GetBabyInfo extends HomeScreenEvent {
  final int objectId;

  GetBabyInfo(this.objectId);

  @override
  List<Object> get props => [objectId];
}

class GetMomentByBaby extends HomeScreenEvent {
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

class HomeInitEvent extends HomeScreenEvent {}

class HomeScreenRefresh extends HomeScreenEvent {}

class GetDataWithHeader extends HomeScreenEvent {
  final bool isHeader;

  GetDataWithHeader(this.isHeader);

  @override
  List<Object> get props => [isHeader];
}
