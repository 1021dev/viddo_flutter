import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<File> maxWidth(File file, int maxWidth) async {
    Uint8List bytes = await file.readAsBytes();
    Img.Image image = await compute(Img.decodeImage, bytes);
    if (image.width > maxWidth) {
      image = Img.copyResize(
        image,
        width: maxWidth,
        height:
            -1, // If width or height are -1, it will be calculated by maintaining the aspect ratio of the original image.
      );
    }
    return imageToFile(image);
  }

  static Future<String> toBase64(File file) async {
    List<int> imageBytes = await file.readAsBytes();
    return base64Encode(imageBytes);
  }

  static Future<File> cropDriverLicense(
      String imagePath, BuildContext context) async {
    Uint8List bytes = await File(imagePath).readAsBytes();
    Img.Image image = await compute(Img.decodeImage, bytes);
    double screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    double screenWidth = MediaQuery.of(context).size.width;
    int h = image.height;
    int w = image.width;

    // Some devices may return rotated image
    // So we need to rotate it back to horizontal
    if (h < w) {
      image = Img.copyRotate(image, 90);
    }

    int x = (screenWidth / 7).floor();
    int y = (screenHeight * 1.8).floor();

    int realHeight, realWidth;
    if (image.height > image.width) {
      realHeight = image.width;
      realWidth = image.height;
    } else {
      realHeight = image.height;
      realWidth = image.width;
    }

    Img.Image thumbnail = Img.copyCrop(
        image, x, y, (realWidth * 0.52).floor(), (realHeight * 0.55).floor());

    return imageToFile(thumbnail);
  }

  static Img.Image cropImage(CropImageParams params) {
    return Img.copyCrop(params.image, params.x, params.y, params.w, params.h);
  }

//  static Future cropFace(File source, Face face) async {
//    Img.Image image = await compute(Img.decodeImage, source.readAsBytesSync());
//    CropImageParams params = CropImageParams(
//      image,
//      (face.boundingBox.left.floor() - face.boundingBox.width.floor() * 0.2)
//          .floor(),
//      (face.boundingBox.top.floor() - face.boundingBox.height.floor() * 0.2)
//          .floor(),
//      face.boundingBox.width.floor() + (face.boundingBox.width * 0.4).floor(),
//      face.boundingBox.height.floor() + (face.boundingBox.height * 0.4).floor(),
//    );
//    Img.Image faceImage = await compute(cropImage, params);
//
//    return await imageToFile(faceImage);
//  }
//
  static Future<File> imageToFile(Img.Image image) async {
    String path = await newFilePath();
    File file = File(path);
    return await file.writeAsBytes(Img.encodePng(image));
  }

  static Future<String> newFilePath() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/classic_crm';
    await Directory(dirPath).create(recursive: true);
    final String path = '$dirPath/${DateTime.now().millisecondsSinceEpoch}.jpg';
    return path;
  }
}

class CropImageParams {
  final Img.Image image;
  final int x, y, w, h;

  CropImageParams(this.image, this.x, this.y, this.w, this.h);
}
