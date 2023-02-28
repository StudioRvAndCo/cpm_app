import 'package:flutter/material.dart';

import '../dialogs/new_edit_location.dart';
import '../dialogs/new_edit_member.dart';
import '../dialogs/new_episode.dart';
import '../dialogs/new_project.dart';
import '../dialogs/new_sequence.dart';
import '../dialogs/new_shot.dart';
import '../widgets/icon_label.dart';
import '../widgets/info_header.dart';
import '../widgets/tabbed_info_sheet.dart';
import '../widgets/web_member_card.dart';
import '../widgets/web_member_editor.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            InfoHeader(
              title: 'Test',
              description:
                  'This is a project, and this is a very long description that takes multiples lines, this project is a very good project that will be awesome',
              dateRange: DateTimeRange(
                  start: DateTime(2023, 9, 19), end: DateTime(2023, 9, 24)),
              leftLabel:
                  const IconLabel(text: 'Bastien', icon: Icons.movie_outlined),
              rightLabel: const IconLabel(
                  text: 'Maxence', icon: Icons.description_outlined),
              image: Image.asset('assets/en-sursis.png'),
              progress: 0.3,
              cornerButton: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ),
            WebMemberCard(
                name: 'Member',
                phone: '04 76 87 01 32',
                picture: Image.asset('assets/logo-camera.png')),
            WebMemberEditor(
                onEdit: () {},
                onSave: () {},
                onCancel: () {},
                name: 'Member',
                phone: '04 76 87 01 32',
                picture: Image.asset('assets/logo-camera.png')),
            ElevatedButton(
                onPressed: () {},
                clipBehavior: Clip.antiAlias,
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: SizedBox(
                    width: 170,
                    height: 170,
                    child: FittedBox(
                        fit: BoxFit.cover,
                        clipBehavior: Clip.hardEdge,
                        child: Image.asset('assets/logo-camera.png')))),
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const TabbedInfoSheet();
                      });
                },
                child: const Text('Bottom sheet')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const NewSequenceDialog(locations: <String>[
                          'Maison de Bastien1',
                          'Maison de Bastien2',
                          'Maison de Bastien3',
                          'Maison de Bastien4',
                          'Maison de Bastien5',
                          'Maison de Bastien6',
                        ]);
                      });
                },
                child: const Text('New Sequence')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const NewProjectDialog();
                      });
                },
                child: const Text('New Project')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const NewShotDialog();
                      });
                },
                child: const Text('New Shot')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const NewEpisodeDialog();
                      });
                },
                child: const Text('New episode')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const MemberDialog(edit: false);
                      });
                },
                child: const Text('New member')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MemberDialog(
                            edit: true,
                            firstName: 'Damian',
                            lastName: 'Carmona',
                            telephone: '0836656565',
                            image: Image.asset('assets/logo-cpm-alpha.png'));
                      });
                },
                child: const Text('Edit member')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LocationDialog(
                          edit: false,
                        );
                      });
                },
                child: const Text('New location')),
            TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const LocationDialog(
                          edit: true,
                          name: 'Tour Perret',
                          position: 'https://goo.gl/maps/h781vPcmbBjHhqmY9',
                        );
                      });
                },
                child: const Text('Edit location'))
          ],
        ),
      ),
    );
  }
}
