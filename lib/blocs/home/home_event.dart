import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  HomeScreenEvent();

  @override
  List<Object> get props => [];
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

