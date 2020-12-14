import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'baby_model.dart';
part 'baby_list_model.g.dart';

@JsonSerializable(nullable: true)
class BabyListModel extends Jsonable {
  int totalElements;
  int totalPages;
  List<BabyModel> content;
  BabyListModel({
    this.totalElements,
    this.totalPages,
    this.content,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$BabyListModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$BabyListModelToJson(this);
  }

  factory BabyListModel.fromJson(Map<String, dynamic> json) =>
      _$BabyListModelFromJson(json);

  BabyListModel copyWith({
    int totalElements,
    int totalPages,
    List<BabyModel> content,
  }) {
    return BabyListModel(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      content: content ?? this.content,
    );
  }
}
