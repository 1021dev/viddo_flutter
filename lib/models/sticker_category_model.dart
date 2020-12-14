import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sticker_category_model.g.dart';

@JsonSerializable(nullable: true)
class StickerCategory extends Jsonable {
  String name;
  int objectId;

  StickerCategory({
    this.name,
    this.objectId,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$StickerCategoryFromJson(json);
  }

  @override
  Map toJson() {
    return _$StickerCategoryToJson(this);
  }

  factory StickerCategory.fromJson(Map<String, dynamic> json) =>
      _$StickerCategoryFromJson(json);

  StickerCategory copyWith({
    String name,
    int objectId,
  }) {
    return StickerCategory(
      name: name ?? this.name,
      objectId: objectId ?? this.objectId,
    );
  }
}
