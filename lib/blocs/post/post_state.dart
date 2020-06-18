import 'package:Viiddo/models/baby_model.dart';
import 'package:Viiddo/models/sticker_category_model.dart';
import 'package:Viiddo/models/sticker_model.dart';
import 'package:meta/meta.dart';

@immutable
// ignore: must_be_immutable
class PostState {
  final bool isLoading;
  final BabyModel babyModel;
  final Map<int, List<StickerModel>> stickers;
  final List<StickerCategory> categories;

  PostState({
    this.isLoading = false,
    this.babyModel,
    this.stickers = const {},
    this.categories = const [],
  });

  List<Object> get props => [
    this.isLoading,
    this.babyModel,
    this.stickers,
    this.categories,
  ];

  PostState copyWith({
    bool isLoading,
    BabyModel babyModel,
    Map<int, List<StickerModel>> stickers,
    List<StickerCategory> categories,

  }) {
    return PostState(
      isLoading: isLoading ?? this.isLoading,
      babyModel: babyModel ?? this.babyModel,
      stickers: stickers ?? this.stickers,
      categories: categories ?? this.categories,
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
