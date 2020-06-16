import 'package:Viiddo/models/baby_list_model.dart';
import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/dynamic_content.dart';
import 'package:Viiddo/models/friend_list_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:Viiddo/models/user_model.dart';
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

  final String babyAvatar;
  final DynamicContent dynamicDetails;
  final bool frameBaby;
  final bool isCreator;
  final bool isBirth;

  final String userName;
  final String userAvatar;
  final String email;
  final bool isVerified;
  final UserModel userModel;

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
    this.babyAvatar = '',
    this.dynamicDetails,
    this.frameBaby = false,
    this.isBirth = false,
    this.isCreator = false,
    this.userAvatar = '',
    this.userName = '',
    this.email = '',
    this.isVerified = false,
    this.userModel,
  });

  List<Object> get props => [
      this.isLoading,
      this.babyModel,
      this.dynamicDetails,
      this.friendListModel,
      this.babyListModel,
      this.unreadMessageModel,
      this.dataArr,
      this.babyId,
      this.page,
      this.tag,
      this.isCreator,
      this.isBirth,
      this.frameBaby,
      this.babyId,
      this.page,
      this.tag,
      this.userName,
      this.email,
      this.userAvatar,
      this.isVerified,
      this.userModel,
    ];


  MainScreenState copyWith({
    bool isLoading,
    bool isUploading,
    DynamicContent dynamicDetails,
    UnreadMessageModel unreadMessageModel,
    BabyModel babyModel,
    FriendListModel friendListModel,
    BabyListModel babyListModel,
    List<DynamicContent> dataArr,
    String babyAvatar,
    bool isCreator,
    bool isBirth,
    bool frameBaby,
    int babyId,
    int page,
    bool tag,
    String userName,
    String email,
    String userAvatar,
    bool isVerified,
    UserModel userModel,
  }) {
    return MainScreenState(
      isLoading: isLoading ?? this.isLoading,
      isUploading: isUploading ?? this.isUploading,
      dynamicDetails: dynamicDetails,
      babyModel: babyModel ?? this.babyModel,
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
      userName: userName ?? this.userName,
      email: email ?? this.email,
      userAvatar: userAvatar ?? this.userAvatar,
      isVerified: isVerified ?? this.isVerified,
      userModel: userModel ?? this.userModel,
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

class MainVerificationSuccess extends MainScreenState {}
