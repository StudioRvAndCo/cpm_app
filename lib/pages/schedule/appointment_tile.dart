import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppointmentTile extends ConsumerWidget {
  const AppointmentTile({super.key, required this.sequence});

  final Sequence sequence;

  void _openSequence(WidgetRef ref, BuildContext context) {
    ref.read(currentSequenceProvider.notifier).set(sequence);
    context.pushNamed(RouterRoute.shots.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Tooltip(
      message: '${sequence.startDate?.Hm} - ${sequence.endDate?.Hm}',
      waitDuration: const Duration(seconds: 1),
      child: InkWell(
        onTap: () => _openSequence(ref, context),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Badge(
                      label: Text(sequence.getNumber),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                    Expanded(
                      child: Text(
                        sequence.getTitle,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Text(sequence.getDescription),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
