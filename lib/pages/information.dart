import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Information extends StatelessWidget {
  const Information({super.key});

  @override
  Widget build(BuildContext context) {
    const Padding verticalPadding =
        Padding(padding: EdgeInsets.only(bottom: 32));
    const Padding horizontalPadding =
        Padding(padding: EdgeInsets.only(right: 8));

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            verticalPadding,
            Wrap(
              spacing: 100,
              runSpacing: 30,
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Builder>[
                Builder(
                  builder: (BuildContext context) {
                    if (Theme.of(context).brightness == Brightness.light) {
                      return Image.asset(
                        'assets/logo-camera.png',
                        fit: BoxFit.fitWidth,
                        width: 250,
                        filterQuality: FilterQuality.high,
                      );
                    } else {
                      return Image.asset(
                        'assets/logo-camera-blanc.png',
                        fit: BoxFit.fitWidth,
                        width: 250,
                        filterQuality: FilterQuality.high,
                      );
                    }
                  },
                ),
                Builder(
                  builder: (BuildContext context) {
                    if (Theme.of(context).brightness == Brightness.light) {
                      return Image.asset(
                        'assets/logo-rv&co.png',
                        fit: BoxFit.fitWidth,
                        width: 250,
                        filterQuality: FilterQuality.high,
                      );
                    } else {
                      return Image.asset(
                        'assets/logo-rv&co-blanc.png',
                        fit: BoxFit.fitWidth,
                        width: 250,
                        filterQuality: FilterQuality.high,
                      );
                    }
                  },
                )
              ],
            ),
            verticalPadding,
            const Text('Cinema Project Manager',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            verticalPadding,
            const Text(
                'CPM is a tool to efficiently manage the production of a cinema project. It is developed as an open-source project by Studio Rv & Co, which is a non-profit organisation that produces audiovisual projects.',
                textAlign: TextAlign.center),
            verticalPadding,
            const Text('More about CPM',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(children: <Widget>[
              const Spacer(),
              TextButton(
                  onPressed: () =>
                      launchUrl(Uri.parse('https://github.com/StudioRvAndCo')),
                  child: const Text('GitHub')),
              const Spacer()
            ]),
            verticalPadding,
            const Text('More about Studio Rv & Co',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Row(children: <Widget>[
              const Spacer(),
              TextButton(
                  onPressed: () => launchUrl(Uri.parse('https://rvandco.fr')),
                  child: const Text('Website')),
              horizontalPadding,
              TextButton(
                  onPressed: () => launchUrl(
                      Uri.parse('https://www.youtube.com/@studiorvandco')),
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
