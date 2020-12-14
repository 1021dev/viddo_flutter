import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dynamic_creator.g.dart';

@JsonSerializable(nullable: true)
class DynamicCreator extends Jsonable {
  String avatar;
  String name;
  int objectId;
  String nickName;

  DynamicCreator({
    this.avatar,
    this.name,
    this.objectId,
    this.nickName,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$DynamicCreatorFromJson(json);
  }

  @override
  Map toJson() {
    return _$DynamicCreatorToJson(this);
  }

  factory DynamicCreator.fromJson(Map<String, dynamic> json) =>
      _$DynamicCreatorFromJson(json);

  DynamicCreator copyWith({
    String avatar,
    String name,
    int objectId,
    String nickName,
  }) {
    return DynamicCreator(
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      objectId: objectId ?? this.objectId,
      nickName: nickName ?? this.nickName,
    );
  }
}
