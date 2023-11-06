import 'dart:ui' as ui;

import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class IconImageProvider extends ImageProvider<IconImageProvider> {
  final IconData icon;
  final double scale;
  final int size;

  IconImageProvider(
    this.icon, {
    this.scale = 1.0,
    this.size = 48,
  });

  @override
  Future<IconImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<IconImageProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(IconImageProvider key, ImageDecoderCallback decode) {
    return OneFrameImageStreamCompleter(_loadAsync(key));
  }

  Future<ImageInfo> _loadAsync(IconImageProvider key) async {
    assert(key == this);

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.scale(scale, scale);
    final textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: size.toDouble(),
        fontFamily: icon.fontFamily,
        color: Theme.of(navigatorKey.currentContext!).colorScheme.onBackground,
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);
    final image = await recorder.endRecording().toImage(size, size);
    return ImageInfo(image: image, scale: key.scale);
  }
}
