import 'package:cpm/common/sheets/sheet.dart';
import 'package:cpm/common/sheets/sheet_manager.dart';
import 'package:cpm/common/sheets/shot/shot_details_tab.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShotCard extends ConsumerStatefulWidget {
  const ShotCard(this.shot, {super.key});

  final Shot shot;

  @override
  ConsumerState<ShotCard> createState() => _ShotCardState();
}

class _ShotCardState extends ConsumerState<ShotCard> {
  void _showDetails() {
    ref.read(currentShotProvider.notifier).set(widget.shot);
    SheetManager().showSheet(
      context,
      Sheet(tabs: const [ShotDetailsTab()]),
    );
  }

  Future<void> _toggleCompletion() async {
    final toggled = await ref.read(shotsProvider.notifier).toggleCompletion(widget.shot);
    if (!toggled) {
      SnackBarManager().show(
        getErrorSnackBar(localizations.snack_bar_edit_fail_item(localizations.item_shot, Gender.male.name)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? cardColor;
    if (widget.shot.completed) {
      cardColor = Theme.of(context).brightness == Brightness.light
          ? Colors.green.shade200
          : Colors.green.shade900.withOpacity(0.75);
    }

    return Card(
      clipBehavior: Clip.hardEdge,
      color: cardColor,
      child: InkWell(
        onTap: _showDetails,
        onLongPress: () => _toggleCompletion(),
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
                            label: Text(widget.shot.getValueName),
                            backgroundColor: widget.shot.value?.color,
                            textColor: Colors.white,
                          ),
                        ],
                      ),
                      if (widget.shot.getDescription.isNotEmpty) ...[
                        const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                        Text(
                          widget.shot.getDescription,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _toggleCompletion(),
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
