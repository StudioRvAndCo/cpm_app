import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard(
      {super.key,
      required this.title,
      required this.image,
      required this.favorite,
      required this.shotsTotal,
      required this.shotsCompleted});

  final String title;
  final Image image;
  final bool favorite;
  final int shotsTotal;
  final int shotsCompleted;

  @override
  State<StatefulWidget> createState() => _ProjectCardState(
      title: title,
      image: image,
      favorite: favorite,
      shotsTotal: shotsTotal,
      shotsCompleted: shotsCompleted);
}

class _ProjectCardState extends State<ProjectCard> {
  _ProjectCardState(
      {required this.title,
      required this.image,
      required this.favorite,
      required this.shotsTotal,
      required this.shotsCompleted});

  final String title;
  final Image image;
  bool favorite;
  final int shotsTotal;
  final int shotsCompleted;

  void toggleFavorite() {
    favorite = !favorite;
  }

  @override
  Widget build(BuildContext context) {
    var favIcon = favorite
        ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
        : Icon(Icons.star_border);
    return Card(
        child: SizedBox(
            height: 100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 60,
                            child: image,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  IconButton(
                      onPressed: () {
                        toggleFavorite();
                        setState(() {
                          favIcon = Icon(Icons.star);
                        });
                      },
                      icon: favIcon),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.event))
                ])
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    LinearProgressIndicator(value: shotsCompleted / shotsTotal),
              )
            ])));
  }
}
