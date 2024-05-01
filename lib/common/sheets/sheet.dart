import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';

class Sheet extends StatefulWidget {
  Sheet({
    super.key,
    required this.tabs,
    this.icons,
  }) {
    if (icons != null && icons!.length != tabs.length) {
      throw ArgumentError();
    }
  }

  final List<Widget> tabs;
  final List<IconData>? icons;

  @override
  State<Sheet> createState() => _SheetState();
}

class _SheetState extends State<Sheet> with TickerProviderStateMixin {
  int index = 0;
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    if (widget.icons != null) {
      tabController = TabController(length: widget.icons!.length, vsync: this);
    }
  }

  void _changeTab(int? newIndex) {
    if (newIndex == null) {
      return;
    }

    setState(() {
      index = newIndex;
      tabController.index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.icons == null
          ? Padding(
              padding: Paddings.custom.drawer,
              child: Wrap(
                children: [
                  widget.tabs.first,
                ],
              ),
            )
          : Wrap(
              children: [
                TabBar(
                  controller: tabController,
                  tabs: widget.icons!.map((icon) {
                    return Tab(icon: Icon(icon));
                  }).toList(),
                  onTap: _changeTab,
                ),
                Padding(
                  padding: Paddings.custom.drawer,
                  child: widget.tabs[index],
                ),
              ],
            ),
    );
  }
}
