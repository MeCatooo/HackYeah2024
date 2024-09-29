import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class TreeImage extends StatefulWidget {
  final double percentage;
  final double width;
  final double height;

  const TreeImage({
    Key? key,
    required this.percentage,
    this.width = 200,
    this.height = 200,
  }) : super(key: key);

  @override
  _TreeImageState createState() => _TreeImageState();
}

class _TreeImageState extends State<TreeImage> {
  ui.Image? _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final imageProvider = AssetImage('assets/images/main_tree.png');
    final completer = Completer<ui.Image>();
    imageProvider.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );

    _image = await completer.future;
    setState(() {}); // Trigger a rebuild once the image is loaded
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        painter: TreePainter(
          image: _image!,
          percentage: widget.percentage,
        ),
        size: Size(widget.width, widget.height),
      ),
    );
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

    // Apply the color overlay based on percentage
    paint.colorFilter = null;
    paint.blendMode = BlendMode.multiply;

    // Create a path that matches the shape of the image
    final Path overlayPath = Path();
    overlayPath.addRect(
      Rect.fromLTWH(
        centered.dx,
        centered.dy +
            scaledSize.height -
            (scaledSize.height * (percentage / 100).clamp(0.0, 1.0)),
        scaledSize.width,
        scaledSize.height * (percentage / 100).clamp(0.0, 1.0),
      ),
    );

    if (percentage <= 100) {
      paint.color = Colors.green;
    } else {
      paint.color = Colors.red;
    }

    // Clip the overlay to the shape of the image to avoid drawing outside the bounds
    canvas.save();
    canvas.clipPath(overlayPath);
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(
          centered.dx, centered.dy, scaledSize.width, scaledSize.height),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant TreePainter oldDelegate) =>
      oldDelegate.image != image || oldDelegate.percentage != percentage;
}
