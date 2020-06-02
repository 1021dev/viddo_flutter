import 'package:Viiddo/apis/jsonable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'response_model.g.dart';

@JsonSerializable(nullable: true)
class ResponseModel extends Jsonable {
  bool head;
  dynamic content;
  int status;
  String message;

  ResponseModel({
    this.head,
    this.content,
    this.status,
    this.message,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$ResponseModelFromJson(json);
  }

  @override
  Map toJson() {
    return _$ResponseModelToJson(this);
  }

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  ResponseModel copyWith({
    bool head,
    dynamic content,
    int status,
    String message,
  }) {
    return ResponseModel(
      head: head ?? this.head,
      content: content ?? this.content,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
