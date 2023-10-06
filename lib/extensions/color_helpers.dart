import 'package:flutter/material.dart';

extension ColorHelpers on Color {
  Color getColorByLuminance(BuildContext context) {
    return computeLuminance() > 0.5
        ? Theme.of(context).colorScheme.onInverseSurface
        : Theme.of(context).colorScheme.onSurface;
  }
}
