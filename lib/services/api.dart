import 'config.dart';

String token = '';

class API {
  API() {
    login = '${_api}Login/login';
    projects = '${_api}Projects';
    episodes = '${_api}Episodes';
    sequences = '${_api}Sequences';
    shots = '${_api}Shots';
    members = '${_api}Members';
    locations = '${_api}Locations';
  }

  // ignore: avoid_dynamic_calls
  final String _api = Config.get('api')['url'] as String;

  late final String login;
  late final String projects;
  late final String episodes;
  late final String sequences;
  late final String shots;
  late final String members;
  late final String locations;

  final String authorization = 'Authorization';
  final String bearer = 'Bearer ';
}
