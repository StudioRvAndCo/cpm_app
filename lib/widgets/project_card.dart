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
  State<StatefulWidget> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  late final String title;
  late final Image image;
  late bool favorite;
  late final int shotsTotal;
  late final int shotsCompleted;

  @override
  void initState() {
    title = widget.title;
    image = widget.image;
    favorite = widget.favorite;
    shotsTotal = widget.shotsTotal;
    shotsCompleted = widget.shotsCompleted;
    super.initState();
  }

  void toggleFavorite() {
    favorite = !favorite;
  }

  @override
  Widget build(BuildContext context) {
    Icon favIcon = favorite
        ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
        : const Icon(Icons.star_border);
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(children: <Widget>[
              SizedBox(
                height: 80,
                width: 80,
                child: image,
              ),
              const SizedBox(width: 8),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                  onPressed: () {
                    toggleFavorite();
                    setState(() {
                      favIcon = const Icon(Icons.star);
                    });
                  },
                  icon: favIcon),
              IconButton(onPressed: () {}, icon: const Icon(Icons.event))
            ]),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: shotsCompleted / shotsTotal),
          ]),
    ));
  }
}
