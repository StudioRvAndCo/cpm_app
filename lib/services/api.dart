import 'config.dart';

class API {
  API() {
    login = '${_api}Login/login';
    members = '${_api}Members';
    locations = '${_api}Locations';
    projects = '${_api}Projects';
  }

  // ignore: avoid_dynamic_calls
  final String _api = Config.get('api')['url'] as String;
  late final String login;
  late final String members;
  late final String locations;
  late final String projects;
}
