import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/widgets/info_sheets/shot_info_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShotCard extends ConsumerStatefulWidget {
  const ShotCard({super.key, required this.shot});

  final Shot shot;

  @override
  ConsumerState<ShotCard> createState() => _ShotCardState();
}

class _ShotCardState extends ConsumerState<ShotCard> {
  late bool completed;

  @override
  void initState() {
    super.initState();
    completed = widget.shot.completed;
  }

  void _showDetails() {
    ref.read(currentShotProvider.notifier).set(widget.shot);
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return const ShotInfoSheet();
      },
    );
  }

  void _toggleCompletion() {
    ref.read(shotsProvider.notifier).toggleCompletion(widget.shot);

    setState(() {
      completed = !completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? cardColor;
    if (completed) {
      cardColor = Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade200
          : Colors.green.shade900.withOpacity(0.75);
    }

    return Card(
      clipBehavior: Clip.hardEdge,
      color: cardColor,
      child: InkWell(
        onTap: _showDetails,
        onLongPress: _toggleCompletion,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: InkWell(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Badge(
                            label: Text(widget.shot.getNumber),
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            textColor: Theme.of(context).colorScheme.onSecondary,
                          ),
                          const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
                          Badge(
                            label: Text(widget.shot.getValue),
                            backgroundColor: widget.shot.value?.color,
                            textColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ],
                      ),
                      if (widget.shot.getDescription.isNotEmpty) ...[
                        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                        Text(
                          widget.shot.getDescription,
                          maxLines: completed ? 1 : 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: _toggleCompletion,
                  icon: Icon(widget.shot.completed ? Icons.remove_done : Icons.done_all),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
