import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dynamic_tag.g.dart';

@JsonSerializable(nullable: true)
class DynamicTag extends Jsonable {
  String name;
  int id;

  DynamicTag({
    this.name,
    this.id,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DynamicTagFromJson(json);
  }

  @override
  Map toJson() {
    return _$DynamicTagToJson(this);
  }

  factory DynamicTag.fromJson(Map<String, dynamic> json) =>
      _$DynamicTagFromJson(json);

  DynamicTag copyWith({
    String name,
    int id,
  }) {
    return DynamicTag(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
