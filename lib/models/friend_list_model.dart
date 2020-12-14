import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/friend_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_list_model.g.dart';

@JsonSerializable(nullable: true)
class FriendListModel extends Jsonable {
  int totalElements;
  int totalPages;
  List<FriendModel> content;
  FriendListModel({
    this.totalElements,
    this.totalPages,
    this.content,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$FriendListModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$FriendListModelToJson(this);
  }

  factory FriendListModel.fromJson(Map<String, dynamic> json) =>
      _$FriendListModelFromJson(json);

  FriendListModel copyWith({
    int totalElements,
    int totalPages,
    List<FriendModel> content,
  }) {
    return FriendListModel(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      content: content ?? this.content,
    );
  }
}
