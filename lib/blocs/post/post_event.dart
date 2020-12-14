import 'package:Viiddo/models/sticker_model.dart';
import 'package:Viiddo/screens/home/post/sticker_image.dart';
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

class StickerRefreshEvent extends PostEvent {
  final int objectId;
  final int page;

  StickerRefreshEvent(this.objectId, this.page);

  @override
  List<Object> get props => [this.objectId, this.page];
}

class StickerLoadMoreEvent extends PostEvent {
  final int objectId;
  final int page;

  StickerLoadMoreEvent(this.objectId, this.page);

  @override
  List<Object> get props => [this.objectId, this.page];
}

class AddStickerEvent extends PostEvent {
  final StickerImage stickerImage;

  AddStickerEvent(this.stickerImage);

  @override
  List<Object> get props => [this.stickerImage];
}

class RemoveStickerEvent extends PostEvent {
  final int index;

  RemoveStickerEvent(this.index);

  @override
  List<Object> get props => [this.index];
}

class UpdateStickerEvent extends PostEvent {
  final int index;
  final StickerImage stickerImage;

  UpdateStickerEvent(this.index, this.stickerImage,);

  @override
  List<Object> get props => [this.index, this.stickerImage,];
}
