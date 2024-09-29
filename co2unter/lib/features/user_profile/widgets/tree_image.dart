import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class TreeImage extends StatelessWidget {
  final double percentage;
  final double width;
  final double height;

  const TreeImage(
      {Key? key, required this.percentage, this.width = 200, this.height = 200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FutureBuilder<ui.Image>(
        future: _loadImage('assets/images/main_tree.png'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomPaint(
              painter: TreePainter(
                image: snapshot.data!,
                percentage: percentage,
              ),
              size: Size(width, height),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<ui.Image> _loadImage(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final Uint8List bytes = data.buffer.asUint8List();
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }
}

class TreePainter extends CustomPainter {
  final ui.Image image;
  final double percentage;

  TreePainter({required this.image, required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final scale = size.width / image.width;
    final scaledSize = Size(image.width * scale, image.height * scale);
    final centered = Offset(
      (size.width - scaledSize.width) / 2,
      (size.height - scaledSize.height) / 2,
    );

    // Draw original image
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(
          centered.dx, centered.dy, scaledSize.width, scaledSize.height),
      paint,
    );

    // Apply grayscale effect
    paint.colorFilter = const ColorFilter.matrix([
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0.2126,
      0.7152,
      0.0722,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
    ]);
    canvas.saveLayer(null, paint);
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(
          centered.dx, centered.dy, scaledSize.width, scaledSize.height),
      paint,
    );
    canvas.restore();

    // Apply color overlay
    paint.colorFilter = null;
    if (percentage <= 100) {
      paint.color = Colors.green.withOpacity(0.5);
    } else {
      paint.color = Colors.red.withOpacity(0.5);
    }
    paint.blendMode = BlendMode.srcATop;

    final coloredHeight =
        scaledSize.height * (percentage / 100).clamp(0.0, 1.0);
    final coloredRect = Rect.fromLTWH(
        centered.dx,
        centered.dy + scaledSize.height - coloredHeight,
        scaledSize.width,
        coloredHeight);

    canvas.drawRect(coloredRect, paint);
  }

  @override
  bool shouldRepaint(covariant TreePainter oldDelegate) =>
      oldDelegate.image != image || oldDelegate.percentage != percentage;
}
