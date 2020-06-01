import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'page_model.g.dart';

@JsonSerializable(nullable: true)
class PageModel extends Jsonable {
  int totalPage;
  int size;
  int current;
  int total;

  PageModel({
    this.totalPage,
    this.size,
    this.current,
    this.total,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$PageModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$PageModelToJson(this);
  }

  factory PageModel.fromJson(Map<String, dynamic> json) =>
      _$PageModelFromJson(json);

  PageModel copyWith({
    int totalPage,
    int size,
    int current,
    int total,
  }) {
    return PageModel(
      totalPage: totalPage ?? this.totalPage,
      size: size ?? this.size,
      current: current ?? this.current,
      total: total ?? this.total,
    );
  }
}
