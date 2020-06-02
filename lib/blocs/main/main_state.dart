import 'package:meta/meta.dart';

@immutable
class MainScreenState {
  final bool isLoading;

  MainScreenState({
    this.isLoading = false,
  });

  MainScreenState copyWith({bool isLoading}) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class MainScreenSuccess extends MainScreenState {}

class MainScreenFailure extends MainScreenState {}
