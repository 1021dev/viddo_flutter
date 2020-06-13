import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/vaccine_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vaccine_list_model.g.dart';

@JsonSerializable(nullable: true)
class VaccineListModel extends Jsonable {
  int totalElements;
  int totalPages;
  List<VaccineModel> content;
  VaccineListModel({
    this.totalElements,
    this.totalPages,
    this.content,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$VaccineListModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$VaccineListModelToJson(this);
  }

  factory VaccineListModel.fromJson(Map<String, dynamic> json) =>
      _$VaccineListModelFromJson(json);

  VaccineListModel copyWith({
    int totalElements,
    int totalPages,
    List<VaccineModel> content,
  }) {
    return VaccineListModel(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      content: content ?? this.content,
    );
  }
}
