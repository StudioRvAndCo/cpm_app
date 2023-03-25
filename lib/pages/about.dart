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
              spacing: 30,
              runSpacing: 30,
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Builder>[
                Builder(
                  builder: (BuildContext context) {
                    if (Theme.of(context).brightness == Brightness.light) {
                      return Image.asset(Logos.camera_light.value,
                          fit: BoxFit.fitWidth, height: 100, filterQuality: FilterQuality.medium);
                    } else {
                      return Image.asset(Logos.camera_dark.value,
                          fit: BoxFit.fitWidth, height: 100, filterQuality: FilterQuality.medium);
                    }
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    if (Theme.of(context).brightness == Brightness.light) {
                      return Image.asset(Logos.rvandco_light.value,
                          fit: BoxFit.fitWidth, height: 150, filterQuality: FilterQuality.medium);
                    } else {
                      return Image.asset(Logos.rvandco_dark.value,
                          fit: BoxFit.fitWidth, height: 150, filterQuality: FilterQuality.medium);
                    }
                  },
                )
              ],
            ),
            verticalPadding,
            const Text('Cinema Project Manager',
                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            verticalPadding,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('about.description'.tr(), textAlign: TextAlign.center),
            ),
            verticalPadding,
            Text('${'about.more_about'.tr()} CPM',
                textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(children: <Widget>[
              const Spacer(),
              TextButton(
                  onPressed: () => launchUrl(Uri.parse('https://github.com/StudioRvAndCo')),
                  child: const Text('GitHub')),
              const Spacer()
            ]),
            verticalPadding,
            Text('${'about.more_about'.tr()} Studio Rv & Co',
                textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
            Row(children: <Widget>[
              const Spacer(),
              TextButton(
                  onPressed: () => launchUrl(Uri.parse('https://linktr.ee/studiorvandco')),
                  child: const Text('Linktree')),
              horizontalPadding,
              TextButton(
                  onPressed: () => launchUrl(Uri.parse('https://rvandco.fr')), child: Text('about.website'.tr())),
              horizontalPadding,
              TextButton(
                  onPressed: () => launchUrl(Uri.parse('https://www.youtube.com/@studiorvandco')),
                  child: const Text('YouTube')),
              const Spacer()
            ]),
            verticalPadding,
          ],
        ),
      ),
    );
  }
}
