import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({
    super.key,
    required this.text,
    required this.icon,
    this.spacing = 4,
    this.iconColor,
    this.textStyle,
  });

  final String text;
  final IconData icon;
  final double spacing;
  final Color? iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(icon, color: iconColor),
        Padding(padding: EdgeInsets.symmetric(horizontal: spacing)),
        Text(text, style: textStyle),
      ],
    );
  }
}
