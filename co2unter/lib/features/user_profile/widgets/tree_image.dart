import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TreeImage extends StatefulWidget {
  final double width;
  final double height;

  const TreeImage({
    Key? key,
    this.width = 200,
    this.height = 200,
  }) : super(key: key);

  @override
  _TreeImageState createState() => _TreeImageState();
}

class _TreeImageState extends State<TreeImage> {
  ui.Image? _image;
  double opercentage = 0;

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
          percentage: opercentage,
        ),
        size: Size(widget.width, widget.height),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
    getState().then((x) {
      opercentage = x;
    });
  }

  Future<double> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await prefs.getDouble('results');
    return data ?? 0;
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

    // Draw grayscale image
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
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(
          centered.dx, centered.dy, scaledSize.width, scaledSize.height),
      paint,
    );

    // Reset color filter
    paint.colorFilter = null;

    // Determine the color and height of the overlay
    Color overlayColor;
    double fillPercentage;

    if (percentage <= 100) {
      overlayColor = Colors.green.withOpacity((100 - percentage) / 100);
      fillPercentage = percentage / 100;
    } else {
      double redIntensity = (percentage - 100) / 100;
      redIntensity = redIntensity.clamp(0.0, 1.0);
      overlayColor = Colors.red.withOpacity(redIntensity);
      fillPercentage = (percentage - 100) / 100;
      fillPercentage = fillPercentage.clamp(0.0, 1.0);
    }

    paint.color = overlayColor;
    paint.blendMode = BlendMode.srcOver;

    // Calculate the overlay height
    double overlayHeight = scaledSize.height * fillPercentage;

    // Clip the overlay to the shape of the image
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(
        centered.dx, centered.dy, scaledSize.width, scaledSize.height));

    // Draw the colored overlay
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, image.height - (image.height * fillPercentage),
          image.width.toDouble(), image.height * fillPercentage),
      Rect.fromLTWH(
          centered.dx,
          centered.dy + scaledSize.height - overlayHeight,
          scaledSize.width,
          overlayHeight),
      paint,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant TreePainter oldDelegate) =>
      oldDelegate.image != image || oldDelegate.percentage != percentage;
}
