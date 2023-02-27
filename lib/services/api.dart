class API {
  API() {
    login = '${_api}Login/login';
    members = '${_api}Members';
    locations = '${_api}Locations';
    projects = '${_api}Projects';
  }

  final String _api = 'https://rymeco.fr:1027/api/';
  late final String login;
  late final String members;
  late final String locations;
  late final String projects;
}
