import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key, required this.title, required this.time});

  final String title;
  final DateTime time;

  @override
  State<StatefulWidget> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(DateFormat('hh:mm').format(widget.time)),
        const Padding(padding: EdgeInsets.only(right: 16)),
        Card(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(widget.title),
        )),
      ],
    );
  }
}
