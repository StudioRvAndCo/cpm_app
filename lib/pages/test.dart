import 'package:flutter/material.dart';
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
              dateRange: DateTimeRange(start: DateTime(2023, 9, 19), end: DateTime(2023, 9, 24)),
              leftLabel: const IconLabel(text: 'Bastien', icon: Icons.movie_outlined),
              rightLabel: const IconLabel(text: 'Maxence', icon: Icons.description_outlined),
              image: Image.asset('assets/en-sursis.png'),
              progress: 0.3,
              cornerButton: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ),
            WebMemberCard(name: 'Member', phone: '04 76 87 01 32', picture: Image.asset('assets/logo-camera.png')),
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: SizedBox(
                    width: 170,
                    height: 170,
                    child: FittedBox(
                        fit: BoxFit.cover, clipBehavior: Clip.hardEdge, child: Image.asset('assets/logo-camera.png')))),
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const TabbedInfoSheet();
                      });
                },
                child: const Text('Bottom sheet')),
          ],
        ),
      ),
    );
  }
}
