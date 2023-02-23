import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({super.key, required this.text, required this.icon, this.gap = 8, this.iconColor, this.textStyle});

  final String text;
  final IconData icon;
  final double gap;
  final Color? iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Icon(icon, color: iconColor), SizedBox(width: gap), Text(text, style: textStyle)],
    );
  }
}
