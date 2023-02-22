import 'package:flutter/material.dart';

class SubProjectCard extends StatefulWidget {
  const SubProjectCard(
      {super.key,
      required this.number,
      required this.title,
      required this.description,
      required this.shotsTotal,
      required this.shotsCompleted});

  final int number;
  final String title;
  final String description;
  final int shotsTotal;
  final int shotsCompleted;

  @override
  State<StatefulWidget> createState() => _SubProjectCardState(
      number: number,
      title: title,
      description: description,
      shotsTotal: shotsTotal,
      shotsCompleted: shotsCompleted);
}

class _SubProjectCardState extends State<SubProjectCard> {
  _SubProjectCardState(
      {required this.number,
      required this.title,
      required this.description,
      required this.shotsTotal,
      required this.shotsCompleted});

  int number;
  final String title;
  final String description;
  final int shotsTotal;
  final int shotsCompleted;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: SizedBox(
            height: 100,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 30,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15))),
                      child: Text(number.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
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
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    LinearProgressIndicator(value: shotsCompleted / shotsTotal),
              )
            ])));
  }
}
