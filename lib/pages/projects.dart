import 'package:flutter/material.dart';

import '../widgets/project_card.dart';
import '../widgets/subproject_card.dart';

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

    const SubProjectCard subProjectCard = SubProjectCard(
        number: 1,
        title: 'Titre',
        description:
            'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM',
        shotsTotal: 15,
        shotsCompleted: 2);

    return Expanded(
        child: Column(
      children: <Widget>[
        project,
        project,
        subProjectCard,
      ],
    ));
  }
}
