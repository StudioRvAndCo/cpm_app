import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Config {
  Config._(String yaml) {
    config = loadYaml(yaml);
  }

  static Config? _instance;
  late final dynamic config;

  dynamic _get(String key) {
    // ignore: avoid_dynamic_calls
    return config[key];
  }

  static Future<void> init() async {
    final String yaml = await rootBundle.loadString('assets/config/config.yaml');
    _instance = Config._(yaml);
  }

  static dynamic get(String key) {
    if (_instance == null) {
      throw Exception('Configuration not yet initialized');
    }
    return _instance!._get(key);
  }
}
