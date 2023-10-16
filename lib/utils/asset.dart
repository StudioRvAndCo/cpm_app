import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

enum Asset {
  cpm('logos', 'cpm.png', true),
  rvandco('logos', 'rvandco.png', true),
  camera('logos', 'camera.png', true),
  ;

  final _basePath = 'assets';
  final _light = '_light';
  final _dark = '_dark';

  final String folder;
  final String filename;
  final bool themed;

  const Asset(this.folder, this.filename, [this.themed = false]);

  String get path => '$_basePath/$folder/${themed ? _getThemedFilename() : filename}';

  String _getThemedFilename() {
    final theme = Theme.of(navigatorKey.currentContext!).brightness == Brightness.light ? _light : _dark;

    return '${basenameWithoutExtension(filename)}$theme${extension(filename)}';
  }
}
