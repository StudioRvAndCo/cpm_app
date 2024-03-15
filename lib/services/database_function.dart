enum DatabaseFunction {
  projectShotsTotal('project_shots_total', 'project_id'),
  projectShotsCompleted('project_shots_completed', 'project_id'),
  episodeShotsTotal('episode_shots_total', 'episode_id'),
  episodeShotsCompleted('episode_shots_completed', 'episode_id'),
  sequenceShotsTotal('sequence_shots_total', 'sequence_id'),
  sequenceShotsCompleted('sequence_shots_completed', 'sequence_id'),
  ;

  final String name;
  final String argument;

  const DatabaseFunction(this.name, this.argument);
}
