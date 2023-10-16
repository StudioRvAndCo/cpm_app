enum RouterRoute {
  // Projects
  projects('Projects', '/projects'),
  episodes('Episodes', 'episodes'),
  sequences('Sequences', 'sequences'),
  shots('Shots', 'shots'),
  schedule('Schedule', 'schedule'),

  // Members
  members('Members', '/members'),

  // Locations
  locations('Locations', '/locations'),

  // Other
  login('Login', '/login'),
  settings('Settings', '/settings'),
  ;

  final String name;
  final String path;

  const RouterRoute(this.name, this.path);
}
