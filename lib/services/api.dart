import 'config.dart';

String token = '';

class API {
  API() {
    login = '${_api}Login/login';
    projects = '${_api}Projects';
    members = '${_api}Members';
    locations = '${_api}Locations';
  }

  // ignore: avoid_dynamic_calls
  final String _api = Config.get('api')['url'] as String;

  late final String login;
  late final String projects;
  late final String members;
  late final String locations;

  final String authorization = 'Authorization';
  final String bearer = 'Bearer ';
}
