import 'package:flutter/material.dart';

enum Separator {
  divider1(1, 1, 0, 0),
  divider1indent16(1, 1, 16, 16),
  divider2(2, 2, 0, 0),
  divider2indent16(2, 2, 16, 16),
  ;

  final double _height;
  final double _thickness;
  final double _indent;
  final double _endIndent;

  Divider get divider => Divider(
        height: _height,
        thickness: _thickness,
        indent: _indent,
        endIndent: _endIndent,
      );

  const Separator(
    this._height,
    this._thickness,
    this._indent,
    this._endIndent,
  );
}
