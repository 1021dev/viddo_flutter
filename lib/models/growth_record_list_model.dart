import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/growth_record_model.dart';
import 'package:Viiddo/models/vaccine_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'growth_record_list_model.g.dart';

@JsonSerializable(nullable: true)
class GrowthRecordListModel extends Jsonable {
  int totalElements;
  int totalPages;
  List<GrowthRecordModel> content;
  GrowthRecordListModel({
    this.totalElements,
    this.totalPages,
    this.content,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$GrowthRecordListModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$GrowthRecordListModelToJson(this);
  }

  factory GrowthRecordListModel.fromJson(Map<String, dynamic> json) =>
      _$GrowthRecordListModelFromJson(json);

  GrowthRecordListModel copyWith({
    int totalElements,
    int totalPages,
    List<GrowthRecordModel> content,
  }) {
    return GrowthRecordListModel(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      content: content ?? this.content,
    );
  }
}
