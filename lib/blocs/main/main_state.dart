import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/friend_list_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:meta/meta.dart';

@immutable
class MainScreenState {
  final bool isLoading;
  final bool isUploading;

  final UnreadMessageModel unreadMessageModel;
  final BabyModel babyModel;
  final FriendListModel friendListModel;
  final BabyListModel babyListModel;

  final List<DynamicContent> dataArr;
  final int babyId;
  final int page;
  final bool tag;


  MainScreenState({
    this.isLoading = false,
    this.isUploading = false,
    this.unreadMessageModel,
    this.babyListModel,
    this.babyModel,
    this.dataArr,
    this.friendListModel,
    this.babyId = 0,
    this.page = 0,
    this.tag = false,
  });

  List<Object> get props => [
      this.isLoading,
      this.babyModel,
      this.friendListModel,
      this.babyListModel,
      this.unreadMessageModel,
      this.dataArr,
      this.babyId,
      this.page,
      this.tag,
    ];


  MainScreenState copyWith({
    bool isLoading,
    bool isUploading,
    UnreadMessageModel unreadMessageModel,
    BabyModel babyModel,
    FriendListModel friendListModel,
    BabyListModel babyListModel,
    List<DynamicContent> dataArr,
    int babyId,
    int page,
    bool tag,
  }) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
      isUploading: isUploading ?? this.isUploading,
      unreadMessageModel: unreadMessageModel ?? this.unreadMessageModel,
      babyModel: babyModel ?? this.babyModel,
      friendListModel: friendListModel ?? this.friendListModel,
      babyListModel: babyListModel ?? this.babyListModel,
      dataArr: dataArr ?? this.dataArr,
      babyId: babyId ?? this.babyId,
      page: page ?? this.page,
      tag: tag ?? this.tag,
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

class UpdateBabyProfileSuccess extends MainScreenState {}

class UpdateBabyProfileFailure extends MainScreenState {
  final String error;

  UpdateBabyProfileFailure({@required this.error}) : super();

  @override
  String toString() => 'UpdateBabyProfileFailure { error: $error }';
}