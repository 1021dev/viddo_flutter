import 'package:meta/meta.dart';

@immutable
class HomeScreenState {
  final bool isLoading;

  HomeScreenState({
    this.isLoading = false,
  });

  HomeScreenState copyWith({bool isLoading}) {
    return HomeScreenState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class HomeScreenSuccess extends HomeScreenState {}

class HomeScreenFailure extends HomeScreenState {}
