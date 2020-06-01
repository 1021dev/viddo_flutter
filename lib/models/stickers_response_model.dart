import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/page_model.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'stickers_response_model.g.dart';

@JsonSerializable(nullable: true)
class StickersResponseModel extends Jsonable {
  List<StickerModel> content;
  PageModel page;
  int totalPage;
  int size;
  int totalElements;

  StickersResponseModel({
    this.content,
    this.page,
    this.totalPage,
    this.size,
    this.totalElements,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$StickersResponseModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$StickersResponseModelToJson(this);
  }

  factory StickersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StickersResponseModelFromJson(json);

  StickersResponseModel copyWith({
    List<StickerModel> content,
    PageModel page,
    int totalPage,
    int size,
    int totalElements,
  }) {
    return StickersResponseModel(
      content: content ?? this.content,
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
      size: size ?? this.size,
      totalElements: totalElements ?? this.totalElements,
    );
  }
}
