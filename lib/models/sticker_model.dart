import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sticker_model.g.dart';

@JsonSerializable(nullable: true)
class StickerModel extends Jsonable {
  bool allowChangeColor;
  String url;
  String name;

  StickerModel({
    this.name,
    this.allowChangeColor,
    this.url,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$StickerModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$StickerModelToJson(this);
  }

  factory StickerModel.fromJson(Map<String, dynamic> json) =>
      _$StickerModelFromJson(json);

  StickerModel copyWith({
    String name,
    String url,
    bool allowChangeColor,
  }) {
    return StickerModel(
      name: name ?? this.name,
      url: url ?? this.url,
      allowChangeColor: allowChangeColor ?? this.allowChangeColor,
    );
  }
}
