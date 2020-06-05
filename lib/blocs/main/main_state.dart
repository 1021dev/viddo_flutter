import 'package:Viiddo/models/unread_message_model.dart';
import 'package:meta/meta.dart';

@immutable
class MainScreenState {
  final bool isLoading;

  UnreadMessageModel unreadMessageModel;
  MainScreenState({
    this.isLoading = false,
    this.unreadMessageModel,
  });

  MainScreenState copyWith({
    bool isLoading,
    UnreadMessageModel unreadMessageModel,
  }) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
      unreadMessageModel: unreadMessageModel ?? this.unreadMessageModel,
    );
  }
}

class MainScreenSuccess extends MainScreenState {}

class MainScreenFailure extends MainScreenState {
  final String error;

  MainScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'MainScreenFailure { error: $error }';
}

class MainScreenLogout extends MainScreenState {}
