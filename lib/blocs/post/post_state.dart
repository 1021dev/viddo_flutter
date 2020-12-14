import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/sticker_category_model.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:Viiddo/screens/home/post/sticker_image.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: must_be_immutable
class PostState {
  final bool isLoading;
  final BabyModel babyModel;
  final Map<int, List<StickerModel>> stickers;
  final List<StickerCategory> categories;
  final List<StickerImage> attachedList;
  PostState({
    this.isLoading = false,
    this.babyModel,
    this.stickers = const {},
    this.categories = const [],
    this.attachedList = const [],
  });

  List<Object> get props => [
    this.isLoading,
    this.babyModel,
    this.stickers,
    this.categories,
    this.attachedList,
  ];

  PostState copyWith({
    bool isLoading,
    BabyModel babyModel,
    Map<int, List<StickerModel>> stickers,
    List<StickerCategory> categories,
    List<StickerImage> attachedList,
  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      babyModel: babyModel ?? this.babyModel,
      stickers: stickers ?? this.stickers,
      categories: categories ?? this.categories,
      attachedList: attachedList ?? this.attachedList,
    );
  }
}

class PostSuccess extends PostState {}

class PostFailure extends PostState {
  final String error;

  PostFailure({@required this.error}) : super();

  @override
  String toString() => 'PostFailure { error: $error }';
}
