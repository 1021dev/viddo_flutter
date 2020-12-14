import 'dart:math';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart';

typedef StickerImageRemoveCallback = void Function(
    StickerImage sticker);

class StickerImage extends StatefulWidget {
  StickerImage(
    this.image, {
    Key key,
    this.width,
    this.height,
    this.viewport,
    this.minScale = 1.0,
    this.maxScale = 2.0,
    this.onTapRemove,
  }) : super(key: key);

  final Widget image;
  final double width;
  final double height;
  final Size viewport;

  final double minScale;
  final double maxScale;

  final StickerImageRemoveCallback onTapRemove;

  final _StickerImageState _stickerImageState =
      _StickerImageState();

  void prepareExport() {
    _stickerImageState.hideRemoveButton();
  }

  @override
  _StickerImageState createState() =>
      _stickerImageState;
}

class _StickerImageState extends State<StickerImage> {
  _StickerImageState();

  double _scale = 1.0;
  double _previousScale = 1.0;

  Offset _previousOffset = Offset(0, 0);
  Offset _startingFocalPoint = Offset(0, 0);
  Offset _offset = Offset(0, 0);

  double _rotation = 0.0;
  double _previousRotation = 0.0;

  bool _isSelected = false;

  @override
  void dispose() {
    super.dispose();
    _offset = Offset(0, 0);
    _scale = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: Rect.fromPoints(Offset(_offset.dx, _offset.dy),
          Offset(_offset.dx + widget.width, _offset.dy + widget.height)),
      child: Container(
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            _isSelected 
              ? Positioned(
                  top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(width: 2, color: Color(0x880000FF),),
                    ),
                    child: Container(),
                  ),
                ): Container(),
            Center(
              child: Transform(
                transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                // ..setRotationZ(_rotation),
                alignment: FractionalOffset.center,
                child: GestureDetector(
                  onScaleStart: (ScaleStartDetails details) {
                    _startingFocalPoint = details.focalPoint;
                    _previousOffset = _offset;
                    _previousRotation = _rotation;
                    _previousScale = _scale;

                    // print(
                    //     "begin - focal : ${details.focalPoint}, local : ${details.localFocalPoint}");
                  },
                  onScaleUpdate: (ScaleUpdateDetails details) {
                    _scale = min(
                        max(_previousScale * details.scale, widget.minScale),
                        widget.maxScale);

                    _rotation = details.rotation;

                    final Offset normalizedOffset =
                        (_startingFocalPoint - _previousOffset) /
                            _previousScale;

                    Offset __offset =
                        details.focalPoint - (normalizedOffset * _scale);

                    __offset = Offset(max(__offset.dx, -widget.width),
                        max(__offset.dy, -widget.height));

                    __offset = Offset(min(__offset.dx, widget.viewport.width),
                        min(__offset.dy, widget.viewport.height));

                    setState(() {
                      _offset = __offset;
                      // print("move - $_offset, scale : $_scale");
                    });
                  },
                  onTap: () {
                    setState(() {
                      _isSelected = !_isSelected;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _isSelected = false;
                    });
                  },
                  onDoubleTap: () {
                    setState(() {
                      _scale = 1.0;
                    });
                  },
                  child: Container(child: widget.image),
                ),
              ),
            ),
            _isSelected
                ? Positioned(
                    top: -12,
                    right: -12,
                    width: 24,
                    height: 24,
                    child: Container(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.remove_circle),
                        color: Color.fromRGBO(255, 0, 0, 1.0),
                        onPressed: () {
                          print('tapped remove sticker');
                          if (this.widget.onTapRemove != null) {
                            this.widget.onTapRemove(this.widget);
                          }
                        },
                      ),
                    ),
                  )
                : Container(),
            _isSelected
                ? Positioned(
                    top: -12,
                    left: -12,
                    width: 24,
                    height: 24,
                    child: Container(
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(Icons.crop_rotate),
                        color: Color.fromRGBO(0, 0, 255, 1.0),
                        onPressed: () {
                          print('tapped rotate sticker');
                          if (this.widget.onTapRemove != null) {
                            this.widget.onTapRemove(this.widget);
                          }
                        },
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void hideRemoveButton() {
    setState(() {
      _isSelected = false;
    });
  }
}
