import 'package:Viiddo/apis/jsonable.dart';
import 'package:Viiddo/models/page_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'page_response_model.g.dart';

@JsonSerializable(nullable: true)
class PageResponseModel extends Jsonable {
  List<dynamic> content;
  PageModel page;
  int totalPage;
  int size;
  int totalElements;

  PageResponseModel({
    this.content,
    this.page,
    this.totalPage,
    this.size,
    this.totalElements,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$PageResponseModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$PageResponseModelToJson(this);
  }

  factory PageResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PageResponseModelFromJson(json);

  PageResponseModel copyWith({
    List<dynamic> content,
    PageModel page,
    int totalPage,
    int size,
    int totalElements,
  }) {
    return PageResponseModel(
      content: content ?? this.content,
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
      size: size ?? this.size,
      totalElements: totalElements ?? this.totalElements,
    );
  }
}
