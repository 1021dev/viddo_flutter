import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'baby_info.g.dart';

@JsonSerializable(nullable: true)
class BabyInfo extends Jsonable {
  String name;
  int objectId;
  String cover;

  BabyInfo({
    this.name,
    this.objectId,
    this.cover,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$BabyInfoFromJson(json);
  }

  @override
  Map toJson() {
    return _$BabyInfoToJson(this);
  }

  factory BabyInfo.fromJson(Map<String, dynamic> json) =>
      _$BabyInfoFromJson(json);

  BabyInfo copyWith({
    String name,
    int objectId,
    String cover,
  }) {
    return BabyInfo(
      name: name ?? this.name,
      objectId: objectId ?? this.objectId,
      cover: cover ?? this.cover,
    );
  }
}
