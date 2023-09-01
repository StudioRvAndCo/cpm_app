import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants_globals.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    const Padding verticalPadding = Padding(padding: EdgeInsets.only(bottom: 32));
    const Padding horizontalPadding = Padding(padding: EdgeInsets.only(right: 8));

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            verticalPadding,
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              spacing: 30,
              runSpacing: 30,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Builder>[
                Builder(builder: (BuildContext context) {
                  return Theme.of(context).brightness == Brightness.light
                      ? Image.asset(
                          Logos.cameraLight.value,
                          height: 100,
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.medium,
                        )
                      : Image.asset(
                          Logos.cameraDark.value,
                          height: 100,
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.medium,
                        );
                }),
                Builder(builder: (BuildContext context) {
                  return Theme.of(context).brightness == Brightness.light
                      ? Image.asset(
                          Logos.rvandcoLight.value,
                          height: 150,
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.medium,
                        )
                      : Image.asset(
                          Logos.rvandcoDark.value,
                          height: 150,
                          fit: BoxFit.fitWidth,
                          filterQuality: FilterQuality.medium,
                        );
                }),
              ],
            ),
            verticalPadding,
            const Text(
              'Cinema Project Manager',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            verticalPadding,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('about.description'.tr(), textAlign: TextAlign.center),
            ),
            verticalPadding,
            Text(
              '${'about.more_about'.tr()} CPM',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Row(children: <Widget>[
              const Spacer(),
              TextButton(
                onPressed: () => launchUrl(Uri.parse('https://github.com/StudioRvAndCo')),
                child: const Text('GitHub'),
              ),
              const Spacer(),
            ]),
            verticalPadding,
            Text(
              '${'about.more_about'.tr()} Studio Rv & Co',
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Row(children: <Widget>[
              const Spacer(),
              TextButton(
                onPressed: () => launchUrl(Uri.parse('https://linktr.ee/studiorvandco')),
                child: const Text('Linktree'),
              ),
              horizontalPadding,
              TextButton(
                onPressed: () => launchUrl(Uri.parse('https://rvandco.fr')),
                child: Text('about.website'.tr()),
              ),
              horizontalPadding,
              TextButton(
                onPressed: () => launchUrl(Uri.parse('https://www.youtube.com/@studiorvandco')),
                child: const Text('YouTube'),
              ),
              const Spacer(),
            ]),
            verticalPadding,
          ],
        ),
      ),
    );
  }
}
