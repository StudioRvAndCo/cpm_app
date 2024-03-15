import 'package:cpm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ColoredCircle extends StatelessWidget {
  const ColoredCircle({
    super.key,
    this.color,
    this.height,
    this.width,
  });

  final Color? color;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? Sizes.size8.size,
      width: width ?? Sizes.size8.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Theme.of(context).colorScheme.onBackground,
      ),
    );
  }
}
