import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({super.key, required this.sequence});

  final Sequence sequence;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${sequence.startDate?.Hm} - ${sequence.endDate?.Hm}',
      waitDuration: const Duration(seconds: 1),
      child: Row(
        children: [
          Badge(label: Text(sequence.getNumber)),
          Padding(padding: Paddings.padding8.horizontal),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sequence.getTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(padding: Paddings.padding2.vertical),
              if (sequence.description != null && sequence.description!.isNotEmpty)
                Text(
                  sequence.getDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
