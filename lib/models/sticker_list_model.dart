import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/growth_record_model.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:Viiddo/models/vaccine_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sticker_list_model.g.dart';

@JsonSerializable(nullable: true)
class StickerListModel extends Jsonable {
  int totalElements;
  int totalPages;
  List<StickerModel> content;
  StickerListModel({
    this.totalElements,
    this.totalPages,
    this.content,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$StickerListModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$StickerListModelToJson(this);
  }

  factory StickerListModel.fromJson(Map<String, dynamic> json) =>
      _$StickerListModelFromJson(json);

  StickerListModel copyWith({
    int totalElements,
    int totalPages,
    List<StickerModel> content,
  }) {
    return StickerListModel(
      totalElements: totalElements ?? this.totalElements,
      totalPages: totalPages ?? this.totalPages,
      content: content ?? this.content,
    );
  }
}
