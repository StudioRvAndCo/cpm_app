import 'package:flutter/material.dart';

import '../widgets/project_card.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectCard project = ProjectCard(
      title: 'En Sursis',
      favorite: false,
      image: Image.asset('assets/en-sursis.png'),
      shotsCompleted: 3,
      shotsTotal: 12,
    );

    return Expanded(
        child: Column(
      children: [project, project],
    ));
  }
}
