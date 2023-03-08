import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/shot.dart';

class ShotCard extends StatefulWidget {
  const ShotCard({super.key, required this.onPressed, required this.shot});

  final Shot shot;
  final Function onPressed;

  @override
  State<StatefulWidget> createState() => _ShotCardState();
}

class _ShotCardState extends State<ShotCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Visibility(
        visible: widget.shot.completed,
        replacement: CollapsedShotCard(
          widget: widget,
          onPressed: widget.onPressed,
          onCheck: onCheck,
        ),
        child: CompactShotCard(
          widget: widget,
          onPressed: widget.onPressed,
          onCheck: onCheck,
        ),
      ),
    );
  }

  void onCheck(bool? value) {
    if (value != null) {
      setState(() {
        widget.shot.completed = !widget.shot.completed;
      });
    }
  }
}

class CompactShotCard extends StatelessWidget {
  const CompactShotCard({super.key, required this.widget, required this.onPressed, required this.onCheck});

  final ShotCard widget;
  final void Function(bool?) onCheck;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.5,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          onPressed: () => print('click shot'),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(children: <Widget>[
                Container(
                  width: 30,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.tertiary,
                      borderRadius: const BorderRadius.all(Radius.circular(15))),
                  child: Text(widget.shot.number.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onTertiary)),
                ),
                const Padding(padding: EdgeInsets.only(right: 12)),
                Expanded(
                  child: Text(
                    widget.shot.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Checkbox(value: widget.shot.completed, onChanged: onCheck)
              ])
            ]),
          )),
    );
  }
}

class CollapsedShotCard extends StatelessWidget {
  const CollapsedShotCard({super.key, required this.widget, required this.onPressed, required this.onCheck});

  final ShotCard widget;
  final void Function(bool?) onCheck;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        onPressed: () => print('click shot'),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Container(
                width: 30,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: Text(widget.shot.number.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSecondary)),
              ),
              const Padding(padding: EdgeInsets.only(right: 12)),
              Expanded(
                child: Text(
                  widget.shot.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Checkbox(value: widget.shot.completed, onChanged: onCheck)
            ]),
            Text(
              widget.shot.value ?? 'shots.value.no_value'.tr(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.shot.description ?? '',
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ]),
        ));
  }
}
