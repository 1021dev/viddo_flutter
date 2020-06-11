import 'package:Viiddo/screens/home/photo/pic_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CropImage extends StatelessWidget {
  const CropImage({
    @required this.index,
    @required this.albumn,
    this.knowImageSize,
  });
  final List<String> albumn;
  final bool knowImageSize;
  final int index;
  @override
  Widget build(BuildContext context) {
    if (albumn.length == 0) {
      return Container();
    }
    final String imageItem = albumn[index];

    return ExtendedImage.network(imageItem,
        clearMemoryCacheWhenDispose: true,
        loadStateChanged: (ExtendedImageState state) {
      Widget widget;
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          widget = Container(
            color: Colors.grey,
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
            ),
          );
          break;
        case LoadState.completed:
          state.returnLoadStateChangedWidget = !knowImageSize;
          widget = Hero(
              tag: imageItem,
              child: ExtendedRawImage(image: state.extendedImageInfo.image, fit: BoxFit.cover),);

          break;
        case LoadState.failed:
          widget = GestureDetector(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  'assets/failed.jpg',
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Text(
                    'load image failed, click to reload',
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            onTap: () {
              state.reLoadImage();
            },
          );
          break;
      }
      if (index == 6 && albumn.length > 6) {
        widget = Stack(
          children: <Widget>[
            widget,
            Container(
              color: Colors.grey.withOpacity(0.2),
              alignment: Alignment.center,
              child: Text(
                '+${albumn.length - 6}',
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            )
          ],
        );
      }

      widget = GestureDetector(
        child: widget,
        onTap: () {
          final page = PicSwiper(index: index, pics: albumn);
          Navigator.of(context).push(CustomPageRoute(page));
        },
      );

      return widget;
    });
  }

}

class CustomPageRoute<T> extends PageRoute<T> {
  CustomPageRoute(this.child);
  @override
  // TODO: implement barrierColor
  Color get barrierColor => Colors.black;

  @override
  String get barrierLabel => null;

  final Widget child;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);
}
