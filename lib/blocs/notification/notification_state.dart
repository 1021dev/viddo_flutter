import 'package:Viiddo/models/activity_notification_list_model.dart';
import 'package:Viiddo/models/activity_notification_model.dart';
import 'package:Viiddo/models/message_list_model.dart';
import 'package:Viiddo/models/message_model.dart';
import 'package:Viiddo/models/unread_message_model.dart';
import 'package:meta/meta.dart';

@immutable
class NotificationScreenState {
  final bool isLoading;

  final UnreadMessageModel unreadMessageModel;
  final ActivityNotificationListModel activityNotificationListModel;
  final MessageListModel messageListModel;

  final List<ActivityNotificationModel> activityList;
  final List<MessageModel> messageList;
  final int activityPage;
  final int messagePage;

  NotificationScreenState({
    this.isLoading = false,
    this.unreadMessageModel,
    this.activityNotificationListModel,
    this.messageListModel,
    this.activityList = const [],
    this.messageList = const [],
    this.activityPage = 0,
    this.messagePage = 0,
  });

  List<Object> get props => [
      this.isLoading,
      this.unreadMessageModel,
      this.activityNotificationListModel,
      this.messageListModel,
      this.activityList,
      this.messageList,
      this.activityPage,
      this.messagePage,
    ];


  NotificationScreenState copyWith({
    bool isLoading,
    UnreadMessageModel unreadMessageModel,
    ActivityNotificationListModel activityNotificationListModel,
    MessageListModel messageListModel,
    List<ActivityNotificationModel> activityList,
    List<MessageModel> messageList,
    int activityPage,
    int messagePage,
  }) {
    return NotificationScreenState(
      isLoading: isLoading ?? this.isLoading,
      unreadMessageModel: unreadMessageModel ?? this.unreadMessageModel,
      activityNotificationListModel: activityNotificationListModel ?? this.activityNotificationListModel,
      messageListModel: messageListModel ?? this.messageListModel,
      activityList: activityList ?? this.activityList,
      messageList: messageList ?? this.messageList,
      activityPage: activityPage ?? this.activityPage,
      messagePage: messagePage ?? this.messagePage,
    );
  }
}

class NotificationScreenSuccess extends NotificationScreenState {}

class NotificationScreenFailure extends NotificationScreenState {
  final String error;

  NotificationScreenFailure({@required this.error}) : super();

  @override
  String toString() => 'NotificationScreenFailure { error: $error }';
}

class NotificationScreenLogout extends NotificationScreenState {}
