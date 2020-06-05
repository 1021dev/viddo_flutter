import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/friend_list_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:meta/meta.dart';

@immutable
class HomeScreenState {
  final bool isLoading;
  final BabyModel babyModel;
  final FriendListModel friendListModel;
  final BabyListModel babyListModel;
  final UnreadMessageModel unreadMessageModel;

  List<DynamicContent> dataArr = const [];
  bool frameBaby;
  int babyId;
  int page;
  bool tag;

  HomeScreenState({
    this.isLoading = false,
    this.babyModel,
    this.friendListModel,
    this.babyListModel,
    this.unreadMessageModel,
    this.dataArr,
    this.frameBaby = false,
    this.babyId = 0,
    this.page = 0,
    this.tag = false,
  });

  HomeScreenState copyWith({
    bool isLoading,
    BabyModel babyModel,
    FriendListModel friendListModel,
    BabyListModel babyListModel,
    UnreadMessageModel unreadMessageModel,
    List<DynamicContent> dataArr,
    bool frameBaby,
    int babyId,
    int page,
    bool tag,
  }) {
    return HomeScreenState(
      isLoading: isLoading ?? this.isLoading,
      babyModel: babyModel ?? this.babyModel,
      friendListModel: friendListModel ?? this.friendListModel,
      babyListModel: babyListModel ?? this.babyListModel,
      unreadMessageModel: unreadMessageModel ?? this.unreadMessageModel,
      dataArr: dataArr ?? this.dataArr,
      frameBaby: frameBaby ?? this.frameBaby,
      babyId: babyId ?? this.babyId,
      page: page ?? this.page,
      tag: tag ?? this.tag,
    );
  }
}

class HomeScreenSuccess extends HomeScreenState {}

class HomeScreenFailure extends HomeScreenState {
  final String error;

  HomeScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'MainScreenFailure { error: $error }';
}
