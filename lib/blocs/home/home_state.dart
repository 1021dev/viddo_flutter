import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/friend_list_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: must_be_immutable
class HomeScreenState {
  final bool isLoading;
  final BabyModel babyModel;
  final FriendListModel friendListModel;
  final BabyListModel babyListModel;
  final UnreadMessageModel unreadMessageModel;
  final String babyAvatar;
  final DynamicContent dynamicDetails;

  final List<DynamicContent> dataArr;
  final bool frameBaby;
  final bool isCreator;
  final bool isBirth;
  final int babyId;
  final int page;
  final bool tag;

  HomeScreenState({
    this.isLoading = false,
    this.babyModel,
    this.dynamicDetails,
    this.friendListModel,
    this.babyListModel,
    this.unreadMessageModel,
    this.dataArr,
    this.babyAvatar,
    this.isCreator,
    this.isBirth,
    this.frameBaby,
    this.babyId,
    this.page,
    this.tag,
  });

  List<Object> get props => [
        this.isLoading,
        this.babyModel,
        this.dynamicDetails,
        this.friendListModel,
        this.babyListModel,
        this.unreadMessageModel,
        this.dataArr,
        this.babyAvatar,
        this.frameBaby,
        this.babyId,
        this.page,
        this.tag,
      ];

  HomeScreenState copyWith({
    bool isLoading,
    BabyModel babyModel,
    DynamicContent dynamicDetails,
    FriendListModel friendListModel,
    BabyListModel babyListModel,
    UnreadMessageModel unreadMessageModel,
    List<DynamicContent> dataArr,
    String babyAvatar,
    bool isCreator,
    bool isBirth,
    bool frameBaby,
    int babyId,
    int page,
    bool tag,
  }) {
    return HomeScreenState(
      isLoading: isLoading ?? this.isLoading,
      babyModel: babyModel ?? this.babyModel,
      dynamicDetails: dynamicDetails,
      friendListModel: friendListModel ?? this.friendListModel,
      babyListModel: babyListModel ?? this.babyListModel,
      unreadMessageModel: unreadMessageModel ?? this.unreadMessageModel,
      dataArr: dataArr ?? this.dataArr,
      babyAvatar: babyAvatar ?? this.babyAvatar,
      frameBaby: frameBaby ?? this.frameBaby,
      babyId: babyId ?? this.babyId,
      isCreator: isCreator ?? this.isCreator,
      isBirth: isBirth ?? this.isBirth,
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
  String toString() => 'HomeScreenFailure { error: $error }';
}
