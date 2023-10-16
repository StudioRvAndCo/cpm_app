import 'package:cpm/utils/config/config_key.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Config {
  late final YamlMap config;

  static final Config _instance = Config._internal();

  factory Config() {
    return _instance;
  }

  Config._internal();

  Future<void> init() async {
    final String yaml = await rootBundle.loadString('assets/config/config.yaml');
    config = loadYaml(yaml) as YamlMap;
  }

  T get<T>(ConfigKey key) {
    return (config[key.parent] as YamlMap)[key.name] as T;
  }
}
