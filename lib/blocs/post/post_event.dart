import 'package:Viiddo/models/sticker_model.dart';
import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  PostEvent();

  @override
  List<Object> get props => [];
}

class InitPostScreen extends PostEvent {}

class GetStickerCategory extends PostEvent {}

class GetStickerByCategory extends PostEvent {
  final int objectId;
  final int page;

  GetStickerByCategory(this.objectId, this.page);

  @override
  List<Object> get props => [this.objectId, this.page];

}

class StickersSaveToLocal extends PostEvent {
  final Map<int, List<StickerModel>> map;
  StickersSaveToLocal(this.map);

  @override
  List<Object> get props => [this.map];


}

